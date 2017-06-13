Received: from eggs.gnu.org ([2001:4830:134:3::10]:33241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTf-0005LO-IA
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTZ-0006gg-Ar
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dKmTZ-0006cz-2G
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:21 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTU-00014t-MH
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:07:16 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 15:07:02 +0100
Message-Id: <1497362826-21125-14-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
References: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/17] timer/aspeed: fix timer enablement when a
 reload is not set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

When a timer is enabled before a reload value is set, the controller
waits for a reload value to be set before starting decrementing. This
fix tries to cover that case by changing the timer expiry only when
a reload value is valid.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 1496739312-32304-1-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/aspeed_timer.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 9b70ee0..50acbf5 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -130,15 +130,26 @@ static uint64_t calculate_next(struct AspeedTimer *t)
             next = seq[1];
         } else if (now < seq[2]) {
             next = seq[2];
-        } else {
+        } else if (t->reload) {
             reload_ns = muldiv64(t->reload, NANOSECONDS_PER_SECOND, rate);
             t->start = now - ((now - t->start) % reload_ns);
+        } else {
+            /* no reload value, return 0 */
+            break;
         }
     }
 
     return next;
 }
 
+static void aspeed_timer_mod(AspeedTimer *t)
+{
+    uint64_t next = calculate_next(t);
+    if (next) {
+        timer_mod(&t->timer, next);
+    }
+}
+
 static void aspeed_timer_expire(void *opaque)
 {
     AspeedTimer *t = opaque;
@@ -164,7 +175,7 @@ static void aspeed_timer_expire(void *opaque)
         qemu_set_irq(t->irq, t->level);
     }
 
-    timer_mod(&t->timer, calculate_next(t));
+    aspeed_timer_mod(t);
 }
 
 static uint64_t aspeed_timer_get_value(AspeedTimer *t, int reg)
@@ -227,10 +238,23 @@ static void aspeed_timer_set_value(AspeedTimerCtrlState *s, int timer, int reg,
                                    uint32_t value)
 {
     AspeedTimer *t;
+    uint32_t old_reload;
 
     trace_aspeed_timer_set_value(timer, reg, value);
     t = &s->timers[timer];
     switch (reg) {
+    case TIMER_REG_RELOAD:
+        old_reload = t->reload;
+        t->reload = value;
+
+        /* If the reload value was not previously set, or zero, and
+         * the current value is valid, try to start the timer if it is
+         * enabled.
+         */
+        if (old_reload || !t->reload) {
+            break;
+        }
+
     case TIMER_REG_STATUS:
         if (timer_enabled(t)) {
             uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -238,17 +262,14 @@ static void aspeed_timer_set_value(AspeedTimerCtrlState *s, int timer, int reg,
             uint32_t rate = calculate_rate(t);
 
             t->start += muldiv64(delta, NANOSECONDS_PER_SECOND, rate);
-            timer_mod(&t->timer, calculate_next(t));
+            aspeed_timer_mod(t);
         }
         break;
-    case TIMER_REG_RELOAD:
-        t->reload = value;
-        break;
     case TIMER_REG_MATCH_FIRST:
     case TIMER_REG_MATCH_SECOND:
         t->match[reg - 2] = value;
         if (timer_enabled(t)) {
-            timer_mod(&t->timer, calculate_next(t));
+            aspeed_timer_mod(t);
         }
         break;
     default:
@@ -268,7 +289,7 @@ static void aspeed_timer_ctrl_enable(AspeedTimer *t, bool enable)
     trace_aspeed_timer_ctrl_enable(t->id, enable);
     if (enable) {
         t->start = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        timer_mod(&t->timer, calculate_next(t));
+        aspeed_timer_mod(t);
     } else {
         timer_del(&t->timer);
     }
-- 
2.7.4
