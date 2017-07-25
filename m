Received: from eggs.gnu.org ([2001:4830:134:3::10]:48811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1da0Cb-0005s0-5p
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1da0Ca-0001OM-7S
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:48:45 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:32797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1da0Ca-0001O1-1Q
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:48:44 -0400
Received: by mail-wm0-x241.google.com with SMTP id q189so5186839wmd.0
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 06:48:43 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Jul 2017 15:48:34 +0200
Message-Id: <1500990514-30326-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1500990514-30326-1-git-send-email-pbonzini@redhat.com>
References: <1500990514-30326-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] mc146818rtc: implement UIP latching as
 intended
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

In some cases, the guest can observe the wrong ordering of UIP and
interrupts.  This can happen if the VCPU exit is timed like this
(the interrupt is supposed to happen at time t):

           iothread                 VCPU
                                  ... wait for interrupt ...
t-100ns                           read register A
t          wake up, take BQL
t+100ns                             update_in_progress
                                      return false
                                    return UIP=0
           trigger interrupt

The interrupt is late; the VCPU expected the falling edge of UIP to
happen after the interrupt.  update_in_progress is already trying to
cover this case by latching UIP if the timer is going to fire soon,
and the fix is documented in the commit message for commit 56038ef623
("RTC: Update the RTC clock only when reading it", 2012-09-10).  It
cannot be tested with qtest, because its timing of interrupts vs. reads
is exact.

However, the implementation was incorrect because UIP cmos_ioport_read
cleared register A instead of leaving that to rtc_update_timer.  Fixing
the implementation of cmos_ioport_read to match the commit message,
however, breaks the "uip-stuck" test case from the previous patch.
To fix it, skip update timer optimizations if UIP has been latched.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/mc146818rtc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index ffb2c6a..82843ed 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -294,6 +294,7 @@ static void check_update_timer(RTCState *s)
      * them to occur.
      */
     if ((s->cmos_data[RTC_REG_A] & 0x60) == 0x60) {
+        assert((s->cmos_data[RTC_REG_A] & REG_A_UIP) == 0);
         timer_del(s->update_timer);
         return;
     }
@@ -309,8 +310,12 @@ static void check_update_timer(RTCState *s)
     s->next_alarm_time = next_update_time +
                          (next_alarm_sec - 1) * NANOSECONDS_PER_SECOND;
 
-    /* If UF is already set, we might be able to optimize. */
-    if (s->cmos_data[RTC_REG_C] & REG_C_UF) {
+    /* If update_in_progress latched the UIP bit, we must keep the timer
+     * programmed to the next second, so that UIP is cleared.  Otherwise,
+     * if UF is already set, we might be able to optimize.
+     */
+    if (!(s->cmos_data[RTC_REG_A] & REG_A_UIP) &&
+        (s->cmos_data[RTC_REG_C] & REG_C_UF)) {
         /* If AF cannot change (i.e. either it is set already, or SET=1
          * and then the time of day is not updated), nothing to do.
          */
@@ -725,12 +730,10 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
             ret = s->cmos_data[s->cmos_index];
             break;
         case RTC_REG_A:
+            ret = s->cmos_data[s->cmos_index];
             if (update_in_progress(s)) {
-                s->cmos_data[s->cmos_index] |= REG_A_UIP;
-            } else {
-                s->cmos_data[s->cmos_index] &= ~REG_A_UIP;
+                ret |= REG_A_UIP;
             }
-            ret = s->cmos_data[s->cmos_index];
             break;
         case RTC_REG_C:
             ret = s->cmos_data[s->cmos_index];
-- 
1.8.3.1
