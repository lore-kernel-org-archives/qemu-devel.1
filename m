Received: from eggs.gnu.org ([2001:4830:134:3::10]:48797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1da0CZ-0005qg-QR
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1da0CZ-0001Np-0F
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:48:43 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1da0CY-0001NO-Qn
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:48:42 -0400
Received: by mail-wm0-x241.google.com with SMTP id c184so3844395wmd.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 06:48:42 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Jul 2017 15:48:33 +0200
Message-Id: <1500990514-30326-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1500990514-30326-1-git-send-email-pbonzini@redhat.com>
References: <1500990514-30326-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] mc146818rtc: simplify check_update_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peng.hao2@zte.com.cn, liu.yi24@zte.com.cn

Move all the optimized cases together, since they all have UF=1 in
common.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/mc146818rtc.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 1b8d3d7..ffb2c6a 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -291,26 +291,14 @@ static void check_update_timer(RTCState *s)
 
     /* From the data sheet: "Holding the dividers in reset prevents
      * interrupts from operating, while setting the SET bit allows"
-     * them to occur.  However, it will prevent an alarm interrupt
-     * from occurring, because the time of day is not updated.
+     * them to occur.
      */
     if ((s->cmos_data[RTC_REG_A] & 0x60) == 0x60) {
         timer_del(s->update_timer);
         return;
     }
-    if ((s->cmos_data[RTC_REG_C] & REG_C_UF) &&
-        (s->cmos_data[RTC_REG_B] & REG_B_SET)) {
-        timer_del(s->update_timer);
-        return;
-    }
-    if ((s->cmos_data[RTC_REG_C] & REG_C_UF) &&
-        (s->cmos_data[RTC_REG_C] & REG_C_AF)) {
-        timer_del(s->update_timer);
-        return;
-    }
 
     guest_nsec = get_guest_rtc_ns(s) % NANOSECONDS_PER_SECOND;
-    /* if UF is clear, reprogram to next second */
     next_update_time = qemu_clock_get_ns(rtc_clock)
         + NANOSECONDS_PER_SECOND - guest_nsec;
 
@@ -321,7 +309,17 @@ static void check_update_timer(RTCState *s)
     s->next_alarm_time = next_update_time +
                          (next_alarm_sec - 1) * NANOSECONDS_PER_SECOND;
 
+    /* If UF is already set, we might be able to optimize. */
     if (s->cmos_data[RTC_REG_C] & REG_C_UF) {
+        /* If AF cannot change (i.e. either it is set already, or SET=1
+         * and then the time of day is not updated), nothing to do.
+         */
+        if ((s->cmos_data[RTC_REG_B] & REG_B_SET) ||
+            (s->cmos_data[RTC_REG_C] & REG_C_AF)) {
+            timer_del(s->update_timer);
+            return;
+        }
+
         /* UF is set, but AF is clear.  Program the timer to target
          * the alarm time.  */
         next_update_time = s->next_alarm_time;
-- 
1.8.3.1
