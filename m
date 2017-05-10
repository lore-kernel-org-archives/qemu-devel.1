Received: from eggs.gnu.org ([2001:4830:134:3::10]:43048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d8N3z-0000pg-4U
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d8N3y-0003pL-90
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:33:39 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d8N3y-0003pD-1v
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:33:38 -0400
Received: by mail-pg0-x244.google.com with SMTP id 64so3227831pgb.3
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 01:33:37 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Wed, 10 May 2017 16:32:59 +0800
Message-Id: <20170510083259.3900-6-xiaoguangrong@tencent.com>
In-Reply-To: <20170510083259.3900-1-xiaoguangrong@tencent.com>
References: <20170510083259.3900-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v3 5/5] mc146818rtc: embrace all x86 specific
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
index 104a26d..6d0a610 100644
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
 
 static uint32_t rtc_periodic_clock_ticks(RTCState *s)
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
 
@@ -618,20 +637,6 @@ static void rtc_get_time(RTCState *s, struct tm *tm)
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
@@ -751,22 +756,19 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
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
