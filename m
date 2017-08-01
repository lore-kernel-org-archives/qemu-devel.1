Received: from eggs.gnu.org ([2001:4830:134:3::10]:59718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrm-0004c2-0u
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrj-0007Mr-3k
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:54 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dcZri-0007MU-Tk
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:51 -0400
Received: by mail-wm0-x243.google.com with SMTP id d40so3782835wma.3
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 09:17:50 -0700 (PDT)
Received: from 640k.lan (94-39-192-75.adsl-ull.clienti.tiscali.it.
	[94.39.192.75]) by smtp.gmail.com with ESMTPSA id
	u187sm1724160wmd.26.2017.08.01.09.17.47 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 01 Aug 2017 09:17:48 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  1 Aug 2017 18:17:24 +0200
Message-Id: <1501604245-33460-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
References: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/17] mc146818rtc: simplify check_update_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
+        /* If AF cannot change (i.e. either it is set already, or
+         * SET=1 and then the time is not updated), nothing to do.
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
