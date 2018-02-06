Received: from eggs.gnu.org ([2001:4830:134:3::10]:43904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ej3uY-0003QO-9i
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ej3uS-0004Sm-Vl
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:07:50 -0500
Received: from [45.249.212.35] (port=33460 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1ej3uS-0004Ql-BZ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:07:44 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Tue, 6 Feb 2018 22:07:19 +0800
Message-ID: <1517926039-86416-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] rtc: placing RTC memory region outside BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, weidong.huang@huawei.com, peter.maydell@linaro.org, Gonglei <arei.gonglei@huawei.com>

As windows guest use rtc as the clock source device,
and access rtc frequently. Let's move the rtc memory
region outside BQL to decrease overhead for windows guests.
Meanwhile, adding a new lock to avoid different vCPUs
access the RTC together.

$ cat strace_c.sh
strace -tt -p $1 -c -o result_$1.log &
sleep $2
pid=$(pidof strace)
kill $pid
cat result_$1.log

Before appling this change:
$ ./strace_c.sh 10528 30
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 93.87    0.119070          30      4000           ppoll
  3.27    0.004148           2      2038           ioctl
  2.66    0.003370           2      2014           futex
  0.09    0.000113           1       106           read
  0.09    0.000109           1       104           io_getevents
  0.02    0.000029           1        30           poll
  0.00    0.000000           0         1           write
------ ----------- ----------- --------- --------- ----------------
100.00    0.126839                  8293           total

After appling the change:
$ ./strace_c.sh 23829 30
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 92.86    0.067441          16      4094           ppoll
  4.85    0.003522           2      2136           ioctl
  1.17    0.000850           4       189           futex
  0.54    0.000395           2       202           read
  0.52    0.000379           2       202           io_getevents
  0.05    0.000037           1        30           poll
------ ----------- ----------- --------- --------- ----------------
100.00    0.072624                  6853           total

The futex call number decreases ~90.6% on an idle windows 7 guest.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
v2->v1:
 a)Adding a new lock to avoid different vCPUs
   access the RTC together. [Paolo]
 b)Taking the BQL before raising the outbound IRQ line. [Peter]
 c)Don't hold BQL if it was holden. [Peter]

 hw/timer/mc146818rtc.c | 55 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 35a05a6..f0a2a62 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -85,6 +85,7 @@ typedef struct RTCState {
     uint16_t irq_reinject_on_ack_count;
     uint32_t irq_coalesced;
     uint32_t period;
+    QemuMutex rtc_lock;
     QEMUTimer *coalesced_timer;
     Notifier clock_reset_notifier;
     LostTickPolicy lost_tick_policy;
@@ -125,6 +126,36 @@ static void rtc_coalesced_timer_update(RTCState *s)
     }
 }
 
+static void rtc_rasie_irq(RTCState *s)
+{
+    bool unlocked = !qemu_mutex_iothread_locked();
+
+    if (unlocked) {
+        qemu_mutex_lock_iothread();
+    }
+
+    qemu_irq_raise(s->irq);
+
+    if (unlocked) {
+        qemu_mutex_unlock_iothread();
+    }
+}
+
+static void rtc_lower_irq(RTCState *s)
+{
+    bool unlocked = !qemu_mutex_iothread_locked();
+
+    if (unlocked) {
+        qemu_mutex_lock_iothread();
+    }
+
+    qemu_irq_lower(s->irq);
+
+    if (unlocked) {
+        qemu_mutex_unlock_iothread();
+    }
+}
+
 static QLIST_HEAD(, RTCState) rtc_devices =
     QLIST_HEAD_INITIALIZER(rtc_devices);
 
@@ -141,7 +172,7 @@ void qmp_rtc_reset_reinjection(Error **errp)
 static bool rtc_policy_slew_deliver_irq(RTCState *s)
 {
     apic_reset_irq_delivered();
-    qemu_irq_raise(s->irq);
+    rtc_rasie_irq(s);
     return apic_get_irq_delivered();
 }
 
@@ -277,8 +308,9 @@ static void rtc_periodic_timer(void *opaque)
                 DPRINTF_C("cmos: coalesced irqs increased to %d\n",
                           s->irq_coalesced);
             }
-        } else
-            qemu_irq_raise(s->irq);
+        } else {
+            rtc_rasie_irq(s);
+        }
     }
 }
 
@@ -459,7 +491,7 @@ static void rtc_update_timer(void *opaque)
     s->cmos_data[RTC_REG_C] |= irqs;
     if ((new_irqs & s->cmos_data[RTC_REG_B]) != 0) {
         s->cmos_data[RTC_REG_C] |= REG_C_IRQF;
-        qemu_irq_raise(s->irq);
+        rtc_rasie_irq(s);
     }
     check_update_timer(s);
 }
@@ -471,6 +503,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
     uint32_t old_period;
     bool update_periodic_timer;
 
+    qemu_mutex_lock(&s->rtc_lock);
     if ((addr & 1) == 0) {
         s->cmos_index = data & 0x7f;
     } else {
@@ -560,10 +593,10 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
              * becomes enabled, raise an interrupt immediately.  */
             if (data & s->cmos_data[RTC_REG_C] & REG_C_MASK) {
                 s->cmos_data[RTC_REG_C] |= REG_C_IRQF;
-                qemu_irq_raise(s->irq);
+                rtc_rasie_irq(s);
             } else {
                 s->cmos_data[RTC_REG_C] &= ~REG_C_IRQF;
-                qemu_irq_lower(s->irq);
+                rtc_lower_irq(s);
             }
             s->cmos_data[RTC_REG_B] = data;
 
@@ -583,6 +616,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
             break;
         }
     }
+    qemu_mutex_unlock(&s->rtc_lock);
 }
 
 static inline int rtc_to_bcd(RTCState *s, int a)
@@ -710,6 +744,7 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
     if ((addr & 1) == 0) {
         return 0xff;
     } else {
+        qemu_mutex_lock(&s->rtc_lock);
         switch(s->cmos_index) {
 	case RTC_IBM_PS2_CENTURY_BYTE:
             s->cmos_index = RTC_CENTURY;
@@ -737,7 +772,7 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
             break;
         case RTC_REG_C:
             ret = s->cmos_data[s->cmos_index];
-            qemu_irq_lower(s->irq);
+            rtc_lower_irq(s);
             s->cmos_data[RTC_REG_C] = 0x00;
             if (ret & (REG_C_UF | REG_C_AF)) {
                 check_update_timer(s);
@@ -762,6 +797,7 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
         }
         CMOS_DPRINTF("cmos: read index=0x%02x val=0x%02x\n",
                      s->cmos_index, ret);
+        qemu_mutex_unlock(&s->rtc_lock);
         return ret;
     }
 }
@@ -909,7 +945,7 @@ static void rtc_reset(void *opaque)
     s->cmos_data[RTC_REG_C] &= ~(REG_C_UF | REG_C_IRQF | REG_C_PF | REG_C_AF);
     check_update_timer(s);
 
-    qemu_irq_lower(s->irq);
+    rtc_lower_irq(s);
 
     if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
         s->irq_coalesced = 0;
@@ -960,6 +996,8 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
 
     rtc_set_date_from_host(isadev);
 
+    qemu_mutex_init(&s->rtc_lock);
+
     switch (s->lost_tick_policy) {
 #ifdef TARGET_I386
     case LOST_TICK_POLICY_SLEW:
@@ -986,6 +1024,7 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
     qemu_register_suspend_notifier(&s->suspend_notifier);
 
     memory_region_init_io(&s->io, OBJECT(s), &cmos_ops, s, "rtc", 2);
+    memory_region_clear_global_locking(&s->io);
     isa_register_ioport(isadev, &s->io, base);
 
     qdev_set_legacy_instance_id(dev, base, 3);
-- 
1.8.3.1
