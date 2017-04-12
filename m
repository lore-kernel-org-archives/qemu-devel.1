Received: from eggs.gnu.org ([2001:4830:134:3::10]:51367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1cyEwX-0005aP-VG
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1cyEwW-0004oI-Ij
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:52:06 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1cyEwW-0004nf-As
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:52:04 -0400
Received: by mail-pf0-x243.google.com with SMTP id a188so4059452pfa.2
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 02:52:04 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Wed, 12 Apr 2017 17:51:11 +0800
Message-Id: <20170412095111.11728-6-xiaoguangrong@tencent.com>
In-Reply-To: <20170412095111.11728-1-xiaoguangrong@tencent.com>
References: <20170412095111.11728-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 5/5] mc146818rtc: embrace all x86 specific code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, yunfangtai@tencent.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

This patch introduces proper hooks in the common code then moves
x86 specific code into a single '#ifdef TARGET_I386'

The real logic is not touched

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 hw/timer/mc146818rtc.c | 197 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 122 insertions(+), 75 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index d7b7c56..5cb4621 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -112,6 +112,9 @@ static uint64_t get_guest_rtc_ns(RTCState *s)
         guest_clock - s->last_update + s->offset;
 }
 
+static QLIST_HEAD(, RTCState) rtc_devices =
+    QLIST_HEAD_INITIALIZER(rtc_devices);
+
 #ifdef TARGET_I386
 static void rtc_coalesced_timer_update(RTCState *s)
 {
@@ -145,6 +148,15 @@ static void rtc_coalesced_timer(void *opaque)
     rtc_coalesced_timer_update(s);
 }
 
+void qmp_rtc_reset_reinjection(Error **errp)
+{
+    RTCState *s;
+
+    QLIST_FOREACH(s, &rtc_devices, link) {
+        s->irq_coalesced = 0;
+    }
+}
+
 static int64_t
 arch_periodic_timer_update(RTCState *s, int period, int64_t lost_clock)
 {
@@ -191,6 +203,83 @@ static void arch_periodic_timer_disable(RTCState *s)
 {
     s->irq_coalesced = 0;
 }
+
+static void arch_rtc_periodic_timer(RTCState *s)
+{
+    if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
+        if (s->irq_reinject_on_ack_count >= RTC_REINJECT_ON_ACK_COUNT) {
+            s->irq_reinject_on_ack_count = 0;
+        }
+        apic_reset_irq_delivered();
+        qemu_irq_raise(s->irq);
+        if (!apic_get_irq_delivered()) {
+            s->irq_coalesced++;
+            rtc_coalesced_timer_update(s);
+            DPRINTF_C("cmos: coalesced irqs increased to %d\n",
+                      s->irq_coalesced);
+        }
+    } else {
+        qemu_irq_raise(s->irq);
+    }
+}
+
+static void arch_read_regC(RTCState *s)
+{
+    if (s->irq_coalesced && (s->cmos_data[RTC_REG_B] & REG_B_PIE) &&
+       s->irq_reinject_on_ack_count < RTC_REINJECT_ON_ACK_COUNT) {
+        s->irq_reinject_on_ack_count++;
+        s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_PF;
+        apic_reset_irq_delivered();
+        DPRINTF_C("cmos: injecting on ack\n");
+        qemu_irq_raise(s->irq);
+        if (apic_get_irq_delivered()) {
+            s->irq_coalesced--;
+            DPRINTF_C("cmos: coalesced irqs decreased to %d\n",
+                      s->irq_coalesced);
+        }
+    }
+}
+
+static void arch_rtc_post_load(RTCState *s, int version_id)
+{
+    if (version_id >= 2) {
+        if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
+            rtc_coalesced_timer_update(s);
+        }
+    }
+}
+
+static void arch_rtc_notify_clock_reset(RTCState *s)
+{
+    if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
+        rtc_coalesced_timer_update(s);
+    }
+}
+
+static void arch_rtc_reset(RTCState *s)
+{
+    if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
+        s->irq_coalesced = 0;
+        s->irq_reinject_on_ack_count = 0;
+    }
+}
+
+static bool arch_rtc_realizefn(RTCState *s, Error **errp)
+{
+    switch (s->lost_tick_policy) {
+    case LOST_TICK_POLICY_SLEW:
+        s->coalesced_timer =
+            timer_new_ns(rtc_clock, rtc_coalesced_timer, s);
+        break;
+    case LOST_TICK_POLICY_DISCARD:
+        break;
+    default:
+        error_setg(errp, "Invalid lost tick policy.");
+        return false;
+    }
+
+    return true;
+}
 #else
 static int64_t
 arch_periodic_timer_update(RTCState *s, int period, int64_t lost_clock)
@@ -201,6 +290,32 @@ arch_periodic_timer_update(RTCState *s, int period, int64_t lost_clock)
 static void arch_periodic_timer_disable(RTCState *s)
 {
 }
+
+static void arch_rtc_periodic_timer(RTCState *s)
+{
+    qemu_irq_raise(s->irq);
+}
+
+static void arch_read_regC(RTCState *s)
+{
+}
+
+static void arch_rtc_post_load(RTCState *s, int version_id)
+{
+}
+
+static void arch_rtc_notify_clock_reset(RTCState *s)
+{
+}
+
+static void arch_rtc_reset(RTCState *s)
+{
+}
+
+static bool arch_rtc_realizefn(RTCState *s, Error **errp)
+{
+    return true;
+}
 #endif
 
 static int period_code_to_clock(int period_code)
@@ -287,21 +402,7 @@ static void rtc_periodic_timer(void *opaque)
     s->cmos_data[RTC_REG_C] |= REG_C_PF;
     if (s->cmos_data[RTC_REG_B] & REG_B_PIE) {
         s->cmos_data[RTC_REG_C] |= REG_C_IRQF;
-#ifdef TARGET_I386
-        if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
-            if (s->irq_reinject_on_ack_count >= RTC_REINJECT_ON_ACK_COUNT)
-                s->irq_reinject_on_ack_count = 0;		
-            apic_reset_irq_delivered();
-            qemu_irq_raise(s->irq);
-            if (!apic_get_irq_delivered()) {
-                s->irq_coalesced++;
-                rtc_coalesced_timer_update(s);
-                DPRINTF_C("cmos: coalesced irqs increased to %d\n",
-                          s->irq_coalesced);
-            }
-        } else
-#endif
-        qemu_irq_raise(s->irq);
+        arch_rtc_periodic_timer(s);
     }
 }
 
@@ -656,20 +757,6 @@ static void rtc_get_time(RTCState *s, struct tm *tm)
         rtc_from_bcd(s, s->cmos_data[RTC_CENTURY]) * 100 - 1900;
 }
 
-static QLIST_HEAD(, RTCState) rtc_devices =
-    QLIST_HEAD_INITIALIZER(rtc_devices);
-
-#ifdef TARGET_I386
-void qmp_rtc_reset_reinjection(Error **errp)
-{
-    RTCState *s;
-
-    QLIST_FOREACH(s, &rtc_devices, link) {
-        s->irq_coalesced = 0;
-    }
-}
-#endif
-
 static void rtc_set_time(RTCState *s)
 {
     struct tm tm;
@@ -789,22 +876,8 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
             if (ret & (REG_C_UF | REG_C_AF)) {
                 check_update_timer(s);
             }
-#ifdef TARGET_I386
-            if(s->irq_coalesced &&
-                    (s->cmos_data[RTC_REG_B] & REG_B_PIE) &&
-                    s->irq_reinject_on_ack_count < RTC_REINJECT_ON_ACK_COUNT) {
-                s->irq_reinject_on_ack_count++;
-                s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_PF;
-                apic_reset_irq_delivered();
-                DPRINTF_C("cmos: injecting on ack\n");
-                qemu_irq_raise(s->irq);
-                if (apic_get_irq_delivered()) {
-                    s->irq_coalesced--;
-                    DPRINTF_C("cmos: coalesced irqs decreased to %d\n",
-                              s->irq_coalesced);
-                }
-            }
-#endif
+
+            arch_read_regC(s);
             break;
         default:
             ret = s->cmos_data[s->cmos_index];
@@ -874,13 +947,7 @@ static int rtc_post_load(void *opaque, int version_id)
         }
     }
 
-#ifdef TARGET_I386
-    if (version_id >= 2) {
-        if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
-            rtc_coalesced_timer_update(s);
-        }
-    }
-#endif
+    arch_rtc_post_load(s, version_id);
     return 0;
 }
 
@@ -937,11 +1004,7 @@ static void rtc_notify_clock_reset(Notifier *notifier, void *data)
     rtc_set_date_from_host(ISA_DEVICE(s));
     periodic_timer_update(s, now, 0);
     check_update_timer(s);
-#ifdef TARGET_I386
-    if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
-        rtc_coalesced_timer_update(s);
-    }
-#endif
+    arch_rtc_notify_clock_reset(s);
 }
 
 /* set CMOS shutdown status register (index 0xF) as S3_resume(0xFE)
@@ -961,13 +1024,7 @@ static void rtc_reset(void *opaque)
     check_update_timer(s);
 
     qemu_irq_lower(s->irq);
-
-#ifdef TARGET_I386
-    if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
-        s->irq_coalesced = 0;
-        s->irq_reinject_on_ack_count = 0;		
-    }
-#endif
+    arch_rtc_reset(s);
 }
 
 static const MemoryRegionOps cmos_ops = {
@@ -1013,19 +1070,9 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
 
     rtc_set_date_from_host(isadev);
 
-#ifdef TARGET_I386
-    switch (s->lost_tick_policy) {
-    case LOST_TICK_POLICY_SLEW:
-        s->coalesced_timer =
-            timer_new_ns(rtc_clock, rtc_coalesced_timer, s);
-        break;
-    case LOST_TICK_POLICY_DISCARD:
-        break;
-    default:
-        error_setg(errp, "Invalid lost tick policy.");
+    if (!arch_rtc_realizefn(s, errp)) {
         return;
     }
-#endif
 
     s->periodic_timer = timer_new_ns(rtc_clock, rtc_periodic_timer, s);
     s->update_timer = timer_new_ns(rtc_clock, rtc_update_timer, s);
-- 
2.9.3
