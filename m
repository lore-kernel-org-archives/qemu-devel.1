Received: from eggs.gnu.org ([2001:4830:134:3::10]:51422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d6FQn-0002me-1b
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d6FQj-0006p0-F4
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:00:25 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d6FQj-0006nw-6z
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:00:21 -0400
Received: by mail-pg0-x243.google.com with SMTP id i63so2024129pgd.2
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 05:00:21 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Thu,  4 May 2017 19:59:48 +0800
Message-Id: <20170504115948.3048-6-xiaoguangrong@tencent.com>
In-Reply-To: <20170504115948.3048-1-xiaoguangrong@tencent.com>
References: <20170504115948.3048-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 5/5] mc146818rtc: embrace all x86 specific
 code
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

Introduce a function, rtc_policy_slew_deliver_irq(), which delivers
irq if LOST_TICK_POLICY_SLEW is used, as which is only supported on
x86, other platforms call it will trigger a assert

After that, we can move the x86 specific code to the common place

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 hw/timer/mc146818rtc.c | 60 ++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 8fc9313..987160c 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -125,17 +125,34 @@ static void rtc_coalesced_timer_update(RTCState *s)
     }
 }
 
+static QLIST_HEAD(, RTCState) rtc_devices =
+    QLIST_HEAD_INITIALIZER(rtc_devices);
+
 #ifdef TARGET_I386
+void qmp_rtc_reset_reinjection(Error **errp)
+{
+    RTCState *s;
+
+    QLIST_FOREACH(s, &rtc_devices, link) {
+        s->irq_coalesced = 0;
+    }
+}
+
+static bool rtc_policy_slew_deliver_irq(RTCState *s)
+{
+    apic_reset_irq_delivered();
+    qemu_irq_raise(s->irq);
+    return apic_get_irq_delivered();
+}
+
 static void rtc_coalesced_timer(void *opaque)
 {
     RTCState *s = opaque;
 
     if (s->irq_coalesced != 0) {
-        apic_reset_irq_delivered();
         s->cmos_data[RTC_REG_C] |= 0xc0;
         DPRINTF_C("cmos: injecting from timer\n");
-        qemu_irq_raise(s->irq);
-        if (apic_get_irq_delivered()) {
+        if (rtc_policy_slew_deliver_irq(s)) {
             s->irq_coalesced--;
             DPRINTF_C("cmos: coalesced irqs decreased to %d\n",
                       s->irq_coalesced);
@@ -144,6 +161,12 @@ static void rtc_coalesced_timer(void *opaque)
 
     rtc_coalesced_timer_update(s);
 }
+#else
+static bool rtc_policy_slew_deliver_irq(RTCState *s)
+{
+    assert(0);
+    return false;
+}
 #endif
 
 static int period_code_to_clock(int period_code)
@@ -260,21 +283,17 @@ static void rtc_periodic_timer(void *opaque)
     s->cmos_data[RTC_REG_C] |= REG_C_PF;
     if (s->cmos_data[RTC_REG_B] & REG_B_PIE) {
         s->cmos_data[RTC_REG_C] |= REG_C_IRQF;
-#ifdef TARGET_I386
         if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
             if (s->irq_reinject_on_ack_count >= RTC_REINJECT_ON_ACK_COUNT)
-                s->irq_reinject_on_ack_count = 0;		
-            apic_reset_irq_delivered();
-            qemu_irq_raise(s->irq);
-            if (!apic_get_irq_delivered()) {
+                s->irq_reinject_on_ack_count = 0;
+            if (!rtc_policy_slew_deliver_irq(s)) {
                 s->irq_coalesced++;
                 rtc_coalesced_timer_update(s);
                 DPRINTF_C("cmos: coalesced irqs increased to %d\n",
                           s->irq_coalesced);
             }
         } else
-#endif
-        qemu_irq_raise(s->irq);
+            qemu_irq_raise(s->irq);
     }
 }
 
@@ -616,20 +635,6 @@ static void rtc_get_time(RTCState *s, struct tm *tm)
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
@@ -749,22 +754,19 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
             if (ret & (REG_C_UF | REG_C_AF)) {
                 check_update_timer(s);
             }
-#ifdef TARGET_I386
+
             if(s->irq_coalesced &&
                     (s->cmos_data[RTC_REG_B] & REG_B_PIE) &&
                     s->irq_reinject_on_ack_count < RTC_REINJECT_ON_ACK_COUNT) {
                 s->irq_reinject_on_ack_count++;
                 s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_PF;
-                apic_reset_irq_delivered();
                 DPRINTF_C("cmos: injecting on ack\n");
-                qemu_irq_raise(s->irq);
-                if (apic_get_irq_delivered()) {
+                if (rtc_policy_slew_deliver_irq(s)) {
                     s->irq_coalesced--;
                     DPRINTF_C("cmos: coalesced irqs decreased to %d\n",
                               s->irq_coalesced);
                 }
             }
-#endif
             break;
         default:
             ret = s->cmos_data[s->cmos_index];
-- 
2.9.3
