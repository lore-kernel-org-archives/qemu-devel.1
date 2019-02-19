Received: from eggs.gnu.org ([209.51.188.92]:49598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydy-0005Y3-OL
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydx-0007CE-NE
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:38 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:32981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydx-00076C-Dc
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:37 -0500
Received: by mail-lf1-x141.google.com with SMTP id q12so14064605lfm.0
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:20 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:11:00 -0800
Message-Id: <20190219061111.10231-13-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 12/23] tests/tcg/xtensa: conditionalize
 timer/CCOUNT tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Make timer/CCOUNT tests conditional on the presence of timer option and
number of configured timers. Don't use hard coded interrupt levels for
timers, use configured values.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_timer.S | 48 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/xtensa/test_timer.S b/tests/tcg/xtensa/test_timer.S
index 6cda71adbb06..1ec8e20883ff 100644
--- a/tests/tcg/xtensa/test_timer.S
+++ b/tests/tcg/xtensa/test_timer.S
@@ -2,6 +2,8 @@
 
 #define CCOUNT_SHIFT 4
 #define WAIT_LOOPS 20
+#define level1 kernel
+#define INTERRUPT_LEVEL(n) glue3(XCHAL_INT, n, _LEVEL)
 
 .macro      make_ccount_delta target, delta
     rsr     \delta, ccount
@@ -13,6 +15,8 @@
 
 test_suite timer
 
+#if XCHAL_HAVE_CCOUNT
+
 test ccount
     rsr     a3, ccount
     rsr     a4, ccount
@@ -32,14 +36,20 @@ test ccount_write
     assert  ltu, a3, a4
 test_end
 
+#if XCHAL_NUM_TIMERS
+
 test ccount_update_deadline
     movi    a2, 0
     wsr     a2, intenable
     rsr     a2, interrupt
     wsr     a2, intclear
     movi    a2, 0
+#if XCHAL_NUM_TIMERS > 1
     wsr     a2, ccompare1
+#endif
+#if XCHAL_NUM_TIMERS > 2
     wsr     a2, ccompare2
+#endif
     movi    a2, 0x12345678
     wsr     a2, ccompare0
     rsr     a3, interrupt
@@ -59,8 +69,12 @@ test ccompare
     rsr     a2, interrupt
     wsr     a2, intclear
     movi    a2, 0
+#if XCHAL_NUM_TIMERS > 1
     wsr     a2, ccompare1
+#endif
+#if XCHAL_NUM_TIMERS > 2
     wsr     a2, ccompare2
+#endif
 
     make_ccount_delta a2, a15
     wsr     a2, ccompare0
@@ -76,6 +90,7 @@ test ccompare
     assert  nei, a5, 0
 test_end
 
+#if INTERRUPT_LEVEL(XCHAL_TIMER0_INTERRUPT) == 1
 test ccompare0_interrupt
     set_vector kernel, 2f
     movi    a2, 0
@@ -83,8 +98,12 @@ test ccompare0_interrupt
     rsr     a2, interrupt
     wsr     a2, intclear
     movi    a2, 0
+#if XCHAL_NUM_TIMERS > 1
     wsr     a2, ccompare1
+#endif
+#if XCHAL_NUM_TIMERS > 2
     wsr     a2, ccompare2
+#endif
 
     movi    a3, WAIT_LOOPS
     make_ccount_delta a2, a15
@@ -104,16 +123,21 @@ test ccompare0_interrupt
     rsr     a2, exccause
     assert  eqi, a2, 4 /* LEVEL1_INTERRUPT_CAUSE */
 test_end
+#endif
+
+#if XCHAL_NUM_TIMERS > 1
 
 test ccompare1_interrupt
-    set_vector level3, 2f
+    set_vector glue(level, INTERRUPT_LEVEL(XCHAL_TIMER1_INTERRUPT)), 2f
     movi    a2, 0
     wsr     a2, intenable
     rsr     a2, interrupt
     wsr     a2, intclear
     movi    a2, 0
     wsr     a2, ccompare0
+#if XCHAL_NUM_TIMERS > 2
     wsr     a2, ccompare2
+#endif
 
     movi    a3, WAIT_LOOPS
     make_ccount_delta a2, a15
@@ -123,7 +147,7 @@ test ccompare1_interrupt
     assert  eqi, a2, 0
     movi    a2, 1 << XCHAL_TIMER1_INTERRUPT
     wsr     a2, intenable
-    rsil    a2, 2
+    rsil    a2, INTERRUPT_LEVEL(XCHAL_TIMER1_INTERRUPT) - 1
     loop    a3, 1f
     nop
 1:
@@ -131,8 +155,11 @@ test ccompare1_interrupt
 2:
 test_end
 
+#endif
+#if XCHAL_NUM_TIMERS > 2
+
 test ccompare2_interrupt
-    set_vector level5, 2f
+    set_vector glue(level, INTERRUPT_LEVEL(XCHAL_TIMER2_INTERRUPT)), 2f
     movi    a2, 0
     wsr     a2, intenable
     rsr     a2, interrupt
@@ -149,7 +176,7 @@ test ccompare2_interrupt
     assert  eqi, a2, 0
     movi    a2, 1 << XCHAL_TIMER2_INTERRUPT
     wsr     a2, intenable
-    rsil    a2, 4
+    rsil    a2, INTERRUPT_LEVEL(XCHAL_TIMER2_INTERRUPT) - 1
     loop    a3, 1f
     nop
 1:
@@ -157,6 +184,8 @@ test ccompare2_interrupt
 2:
 test_end
 
+#endif
+
 test ccompare_interrupt_masked
     set_vector kernel, 2f
     movi    a2, 0
@@ -164,11 +193,15 @@ test ccompare_interrupt_masked
     rsr     a2, interrupt
     wsr     a2, intclear
     movi    a2, 0
+#if XCHAL_NUM_TIMERS > 2
     wsr     a2, ccompare2
+#endif
 
     movi    a3, 2 * WAIT_LOOPS
     make_ccount_delta a2, a15
+#if XCHAL_NUM_TIMERS > 1
     wsr     a2, ccompare1
+#endif
     add     a2, a2, a15
     wsr     a2, ccompare0
     rsync
@@ -194,11 +227,15 @@ test ccompare_interrupt_masked_waiti
     rsr     a2, interrupt
     wsr     a2, intclear
     movi    a2, 0
+#if XCHAL_NUM_TIMERS > 2
     wsr     a2, ccompare2
+#endif
 
     movi    a3, 2 * WAIT_LOOPS
     make_ccount_delta a2, a15
+#if XCHAL_NUM_TIMERS > 1
     wsr     a2, ccompare1
+#endif
     add     a2, a2, a15
     wsr     a2, ccompare0
     rsync
@@ -214,4 +251,7 @@ test ccompare_interrupt_masked_waiti
     assert  eqi, a2, 4 /* LEVEL1_INTERRUPT_CAUSE */
 test_end
 
+#endif
+#endif
+
 test_suite_end
-- 
2.11.0
