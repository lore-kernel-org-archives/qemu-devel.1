Received: from eggs.gnu.org ([2001:4830:134:3::10]:51327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1cyEwQ-0005VI-KO
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1cyEwP-0004ml-PM
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:51:58 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1cyEwP-0004mI-Ir
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:51:57 -0400
Received: by mail-pg0-x242.google.com with SMTP id 34so1371576pgx.3
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 02:51:57 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Wed, 12 Apr 2017 17:51:08 +0800
Message-Id: <20170412095111.11728-3-xiaoguangrong@tencent.com>
In-Reply-To: <20170412095111.11728-1-xiaoguangrong@tencent.com>
References: <20170412095111.11728-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 2/5] mc146818rtc: fix clock lost after scaling
 coalesced irq
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

If the period is changed by re-configuring RegA, the coalesced irq
will be scaled to reflect the new period, however, it calculates
the new interrupt number like this:
    s->irq_coalesced = (s->irq_coalesced * s->period) / period;

There are some clocks will be lost if they are not enough to be
squeezed to a single new period that will cause the VM clock slower

In order to fix the issue, we calculate the interrupt window based
on the precise clock rather than period, then the clocks lost during
period is scaled can be compensated properly

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 hw/timer/mc146818rtc.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 749e206..649678c 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -146,23 +146,46 @@ static void rtc_coalesced_timer(void *opaque)
 }
 #endif
 
+static int period_code_to_clock(int period_code)
+{
+    /* periodic timer is disabled. */
+    if (!period_code) {
+        return 0;
+    }
+
+    if (period_code <= 2) {
+        period_code += 7;
+    }
+
+    /* period in 32 Khz cycles */
+    return 1 << (period_code - 1);
+}
+
 /* handle periodic timer */
 static void periodic_timer_update(RTCState *s, int64_t current_time)
 {
     int period_code, period;
-    int64_t cur_clock, next_irq_clock;
+    int64_t cur_clock, next_irq_clock, lost_clock = 0;
 
     period_code = s->cmos_data[RTC_REG_A] & 0x0f;
     if (period_code != 0
         && (s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
-        if (period_code <= 2)
-            period_code += 7;
-        /* period in 32 Khz cycles */
-        period = 1 << (period_code - 1);
+        period = period_code_to_clock(period_code);
 #ifdef TARGET_I386
         if (period != s->period) {
-            s->irq_coalesced = (s->irq_coalesced * s->period) / period;
-            DPRINTF_C("cmos: coalesced irqs scaled to %d\n", s->irq_coalesced);
+            int current_irq_coalesced = s->irq_coalesced;
+
+            s->irq_coalesced = (current_irq_coalesced * s->period) / period;
+
+            /*
+             * calculate the lost clock after it is scaled which should be
+             * compensated in the next interrupt.
+             */
+            lost_clock += current_irq_coalesced * s->period -
+                            s->irq_coalesced * period;
+            DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, %ld clocks "
+                      "are compensated.\n",
+                      current_irq_coalesced, s->irq_coalesced, lost_clock);
         }
         s->period = period;
 #endif
@@ -170,7 +193,7 @@ static void periodic_timer_update(RTCState *s, int64_t current_time)
         cur_clock =
             muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
 
-        next_irq_clock = (cur_clock & ~(period - 1)) + period;
+        next_irq_clock = cur_clock + period - lost_clock;
         s->next_periodic_time = muldiv64(next_irq_clock, NANOSECONDS_PER_SECOND,
                                          RTC_CLOCK_RATE) + 1;
         timer_mod(s->periodic_timer, s->next_periodic_time);
-- 
2.9.3
