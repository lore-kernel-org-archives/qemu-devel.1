Received: from eggs.gnu.org ([2001:4830:134:3::10]:60779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eKneu-0008Mf-Pl
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eKne3-0000dY-Jp
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:55:23 -0500
Received: from [45.249.212.35] (port=47027 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1eKne2-0000Uc-PB
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:54:31 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Fri, 1 Dec 2017 23:53:47 +0800
Message-ID: <1512143627-103300-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] rtc: fix windows guest hang problem when
 Reading RTC_REG_C is overwritten
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, zhang.zhanghailiang@huawei.com, Gonglei <arei.gonglei@huawei.com>

We hit a bug in our test while run PCMark 10 in a windows 7 VM,
The VM got stuck and the wallclock was hang after several minutes running
PCMark 10 in it.
It is quite easily to reproduce the bug with the upstream KVM and Qemu.

We found that KVM can not inject any RTC irq to VM after it was hang, it fails to
Deliver irq in ioapic_set_irq() because RTC irq is still pending in ioapic->irr.

static int ioapic_set_irq(struct kvm_ioapic *ioapic, unsigned int irq,
                  int irq_level, bool line_status)
{
...
         if (!irq_level) {
                  ioapic->irr &= ~mask;
                  ret = 1;
                  goto out;
         }
...
         if ((edge && old_irr == ioapic->irr) ||
             (!edge && entry.fields.remote_irr)) {
                  ret = 0;
                  goto out;
         }

According to RTC spec, after RTC injects a High level irq, OS will read CMOS's
register C to to clear the irq flag, and pull down the irq electric pin.

For Qemu, we will emulate the reading operation in cmos_ioport_read(),
but Guest OS will fire a write operation before to tell which register will be read
after this write, where we use s->cmos_index to record the following register to read.

But in our test, we found that there is a possible situation that Vcpu fails to read
RTC_REG_C to clear irq, This could happens while two VCpus are writing/reading
registers at the same time, for example, vcpu 0 is trying to read RTC_REG_C,
so it write RTC_REG_C first, where the s->cmos_index will be RTC_REG_C,
but before it tries to read register C, another vcpu1 is going to read RTC_YEAR,
it changes s->cmos_index to RTC_YEAR by a writing action.
The next operation of vcpu0 will be lead to read RTC_YEAR, In this case, we will miss
calling qemu_irq_lower(s->irq) to clear the irq. After this, kvm will never inject RTC irq,
and Windows VM will hang.

Let's add a global variable to record the status of accessing RTC_REG_C to
avoid the issue.

Tested by Windows guests with PCMark benchmark.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 hw/timer/mc146818rtc.c | 65 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 19 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 7764be2..c7702e7 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -98,6 +98,9 @@ static void rtc_set_cmos(RTCState *s, const struct tm *tm);
 static inline int rtc_from_bcd(RTCState *s, int a);
 static uint64_t get_next_alarm(RTCState *s);
 
+/* Used to indicate that RTC_REG_C is about to be accessed */
+bool ready_to_access_rtc_reg_c;
+
 static inline bool rtc_running(RTCState *s)
 {
     return (!(s->cmos_data[RTC_REG_B] & REG_B_SET) &&
@@ -473,6 +476,10 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
 
     if ((addr & 1) == 0) {
         s->cmos_index = data & 0x7f;
+
+        if (s->cmos_index == RTC_REG_C) {
+            ready_to_access_rtc_reg_c = true;
+        }
     } else {
         CMOS_DPRINTF("cmos: write index=0x%02x val=0x%02" PRIx64 "\n",
                      s->cmos_index, data);
@@ -575,6 +582,8 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
             check_update_timer(s);
             break;
         case RTC_REG_C:
+            ready_to_access_rtc_reg_c = false;
+            break;
         case RTC_REG_D:
             /* cannot write to them */
             break;
@@ -702,6 +711,32 @@ static int update_in_progress(RTCState *s)
     return 0;
 }
 
+static int cmos_ioport_read_rtc_reg_c(RTCState *s)
+{
+    int ret;
+
+    ret = s->cmos_data[RTC_REG_C];
+    qemu_irq_lower(s->irq);
+    s->cmos_data[RTC_REG_C] = 0x00;
+    if (ret & (REG_C_UF | REG_C_AF)) {
+        check_update_timer(s);
+    }
+
+    if (s->irq_coalesced &&
+            (s->cmos_data[RTC_REG_B] & REG_B_PIE) &&
+            s->irq_reinject_on_ack_count < RTC_REINJECT_ON_ACK_COUNT) {
+        s->irq_reinject_on_ack_count++;
+        s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_PF;
+        DPRINTF_C("cmos: injecting on ack\n");
+        if (rtc_policy_slew_deliver_irq(s)) {
+            s->irq_coalesced--;
+            DPRINTF_C("cmos: coalesced irqs decreased to %d\n",
+                      s->irq_coalesced);
+        }
+    }
+    return ret;
+}
+
 static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
                                  unsigned size)
 {
@@ -710,6 +745,15 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
     if ((addr & 1) == 0) {
         return 0xff;
     } else {
+        /*
+         * It indicate that the cmos_index for RTC_REG_C is overwritten
+         * if the condition is met, we should execute read RTC_REG_C manually.
+         */
+        if (ready_to_access_rtc_reg_c && s->cmos_index != RTC_REG_C) {
+            cmos_ioport_read_rtc_reg_c(s);
+            ready_to_access_rtc_reg_c = false;
+        }
+
         switch(s->cmos_index) {
 	case RTC_IBM_PS2_CENTURY_BYTE:
             s->cmos_index = RTC_CENTURY;
@@ -736,25 +780,8 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
             }
             break;
         case RTC_REG_C:
-            ret = s->cmos_data[s->cmos_index];
-            qemu_irq_lower(s->irq);
-            s->cmos_data[RTC_REG_C] = 0x00;
-            if (ret & (REG_C_UF | REG_C_AF)) {
-                check_update_timer(s);
-            }
-
-            if(s->irq_coalesced &&
-                    (s->cmos_data[RTC_REG_B] & REG_B_PIE) &&
-                    s->irq_reinject_on_ack_count < RTC_REINJECT_ON_ACK_COUNT) {
-                s->irq_reinject_on_ack_count++;
-                s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_PF;
-                DPRINTF_C("cmos: injecting on ack\n");
-                if (rtc_policy_slew_deliver_irq(s)) {
-                    s->irq_coalesced--;
-                    DPRINTF_C("cmos: coalesced irqs decreased to %d\n",
-                              s->irq_coalesced);
-                }
-            }
+            ret = cmos_ioport_read_rtc_reg_c(s);
+            ready_to_access_rtc_reg_c = false;
             break;
         default:
             ret = s->cmos_data[s->cmos_index];
-- 
1.8.3.1
