Received: from eggs.gnu.org ([2001:4830:134:3::10]:34491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dIAGv-0006DR-Ix
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dIAGs-0005EL-Fv
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:55:29 -0400
Received: from 7.mo7.mail-out.ovh.net ([46.105.43.131]:36296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dIAGs-0005Dx-9Z
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:55:26 -0400
Received: from player762.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id D7720592CB
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 10:55:24 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue,  6 Jun 2017 10:55:12 +0200
Message-Id: <1496739312-32304-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] timer/aspeed: fix timer enablement when a
 reload is not set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

When a timer is enabled before a reload value is set, the controller
waits for a reload value to be set before starting decrementing. This
fix tries to cover that case by changing the timer expiry only when
a reload value is valid.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/timer/aspeed_timer.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 9b70ee09b07f..50acbf530a3a 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -130,15 +130,26 @@ static uint64_t calculate_next(struct AspeedTimer *=
t)
             next =3D seq[1];
         } else if (now < seq[2]) {
             next =3D seq[2];
-        } else {
+        } else if (t->reload) {
             reload_ns =3D muldiv64(t->reload, NANOSECONDS_PER_SECOND, ra=
te);
             t->start =3D now - ((now - t->start) % reload_ns);
+        } else {
+            /* no reload value, return 0 */
+            break;
         }
     }
=20
     return next;
 }
=20
+static void aspeed_timer_mod(AspeedTimer *t)
+{
+    uint64_t next =3D calculate_next(t);
+    if (next) {
+        timer_mod(&t->timer, next);
+    }
+}
+
 static void aspeed_timer_expire(void *opaque)
 {
     AspeedTimer *t =3D opaque;
@@ -164,7 +175,7 @@ static void aspeed_timer_expire(void *opaque)
         qemu_set_irq(t->irq, t->level);
     }
=20
-    timer_mod(&t->timer, calculate_next(t));
+    aspeed_timer_mod(t);
 }
=20
 static uint64_t aspeed_timer_get_value(AspeedTimer *t, int reg)
@@ -227,10 +238,23 @@ static void aspeed_timer_set_value(AspeedTimerCtrlS=
tate *s, int timer, int reg,
                                    uint32_t value)
 {
     AspeedTimer *t;
+    uint32_t old_reload;
=20
     trace_aspeed_timer_set_value(timer, reg, value);
     t =3D &s->timers[timer];
     switch (reg) {
+    case TIMER_REG_RELOAD:
+        old_reload =3D t->reload;
+        t->reload =3D value;
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
             uint64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -238,17 +262,14 @@ static void aspeed_timer_set_value(AspeedTimerCtrlS=
tate *s, int timer, int reg,
             uint32_t rate =3D calculate_rate(t);
=20
             t->start +=3D muldiv64(delta, NANOSECONDS_PER_SECOND, rate);
-            timer_mod(&t->timer, calculate_next(t));
+            aspeed_timer_mod(t);
         }
         break;
-    case TIMER_REG_RELOAD:
-        t->reload =3D value;
-        break;
     case TIMER_REG_MATCH_FIRST:
     case TIMER_REG_MATCH_SECOND:
         t->match[reg - 2] =3D value;
         if (timer_enabled(t)) {
-            timer_mod(&t->timer, calculate_next(t));
+            aspeed_timer_mod(t);
         }
         break;
     default:
@@ -268,7 +289,7 @@ static void aspeed_timer_ctrl_enable(AspeedTimer *t, =
bool enable)
     trace_aspeed_timer_ctrl_enable(t->id, enable);
     if (enable) {
         t->start =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        timer_mod(&t->timer, calculate_next(t));
+        aspeed_timer_mod(t);
     } else {
         timer_del(&t->timer);
     }
--=20
2.7.4
