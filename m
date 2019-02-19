Received: from eggs.gnu.org ([209.51.188.92]:49522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydw-0005Wh-5K
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydt-0007A2-Fl
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:35 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:44799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydn-000762-QM
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:29 -0500
Received: by mail-lj1-x243.google.com with SMTP id q128so16334874ljb.11
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:18 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:10:59 -0800
Message-Id: <20190219061111.10231-12-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 11/23] tests/tcg/xtensa: conditionalize
 interrupt tests
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

Make interrupt tests conditional on the presence of interrupt option and
on the presence of level-1 and high level software interrupts. Don't use
hard-coded interrupt level for the high level interrupt tests, choose
high level software IRQ and use its configured level.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/macros.inc       |  3 ++
 tests/tcg/xtensa/test_interrupt.S | 88 +++++++++++++++++++++++++++++++--------
 2 files changed, 73 insertions(+), 18 deletions(-)

diff --git a/tests/tcg/xtensa/macros.inc b/tests/tcg/xtensa/macros.inc
index 5265c8606bff..36536ed8a4bc 100644
--- a/tests/tcg/xtensa/macros.inc
+++ b/tests/tcg/xtensa/macros.inc
@@ -100,3 +100,6 @@ test_\name:
 
 #define glue(a, b) _glue(a, b)
 #define _glue(a, b) a ## b
+
+#define glue3(a, b, c) _glue3(a, b, c)
+#define _glue3(a, b, c) a ## b ## c
diff --git a/tests/tcg/xtensa/test_interrupt.S b/tests/tcg/xtensa/test_interrupt.S
index 876683518ee5..efedc43f6062 100644
--- a/tests/tcg/xtensa/test_interrupt.S
+++ b/tests/tcg/xtensa/test_interrupt.S
@@ -1,15 +1,59 @@
 #include "macros.inc"
 
-#define LSBIT(v) ((v) ^ ((v) & ((v) - 1)))
+#define LSBIT(v) ((v) & -(v))
+
+#define LEVEL_MASK(x) glue3(XCHAL_INTLEVEL, x, _MASK)
+#define LEVEL_SOFT_MASK(x) (LEVEL_MASK(x) & XCHAL_INTTYPE_MASK_SOFTWARE)
+
+#define L1_SOFT_MASK LEVEL_SOFT_MASK(1)
+#define L1_SOFT LSBIT(L1_SOFT_MASK)
+
+#if LEVEL_SOFT_MASK(2)
+#define HIGH_LEVEL_SOFT_MASK LEVEL_SOFT_MASK(2)
+#elif LEVEL_SOFT_MASK(3)
+#define HIGH_LEVEL_SOFT_MASK LEVEL_SOFT_MASK(3)
+#elif LEVEL_SOFT_MASK(4)
+#define HIGH_LEVEL_SOFT_MASK LEVEL_SOFT_MASK(4)
+#elif LEVEL_SOFT_MASK(5)
+#define HIGH_LEVEL_SOFT_MASK LEVEL_SOFT_MASK(5)
+#elif LEVEL_SOFT_MASK(6)
+#define HIGH_LEVEL_SOFT_MASK LEVEL_SOFT_MASK(6)
+#else
+#define HIGH_LEVEL_SOFT_MASK 0
+#endif
+
+#define HIGH_LEVEL_SOFT LSBIT(HIGH_LEVEL_SOFT_MASK)
+
+#if LEVEL_SOFT_MASK(2)
+#define HIGH_LEVEL_SOFT_LEVEL 2
+#elif LEVEL_SOFT_MASK(3)
+#define HIGH_LEVEL_SOFT_LEVEL 3
+#elif LEVEL_SOFT_MASK(4)
+#define HIGH_LEVEL_SOFT_LEVEL 4
+#elif LEVEL_SOFT_MASK(5)
+#define HIGH_LEVEL_SOFT_LEVEL 5
+#elif LEVEL_SOFT_MASK(6)
+#define HIGH_LEVEL_SOFT_LEVEL 6
+#else
+#define HIGH_LEVEL_SOFT_LEVEL 0
+#endif
 
 test_suite interrupt
 
+#if XCHAL_HAVE_INTERRUPTS
+
 .macro clear_interrupts
     movi    a2, 0
     wsr     a2, intenable
+#if XCHAL_NUM_TIMERS
     wsr     a2, ccompare0
+#endif
+#if XCHAL_NUM_TIMERS > 1
     wsr     a2, ccompare1
+#endif
+#if XCHAL_NUM_TIMERS > 2
     wsr     a2, ccompare2
+#endif
     esync
     rsr     a2, interrupt
     wsr     a2, intclear
@@ -44,11 +88,12 @@ test rsil
     assert  eqi, a2, 0
 test_end
 
+#if L1_SOFT
 test soft_disabled
     set_vector kernel, 1f
     clear_interrupts
 
-    movi    a2, LSBIT(XCHAL_INTTYPE_MASK_SOFTWARE)
+    movi    a2, L1_SOFT
     wsr     a2, intset
     esync
     rsr     a3, interrupt
@@ -70,7 +115,7 @@ test soft_intenable
     set_vector kernel, 1f
     clear_interrupts
 
-    movi    a2, LSBIT(XCHAL_INTTYPE_MASK_SOFTWARE)
+    movi    a2, L1_SOFT
     wsr     a2, intset
     esync
     rsr     a3, interrupt
@@ -89,7 +134,7 @@ test soft_rsil
     set_vector kernel, 1f
     clear_interrupts
 
-    movi    a2, LSBIT(XCHAL_INTTYPE_MASK_SOFTWARE)
+    movi    a2, L1_SOFT
     wsr     a2, intset
     esync
     rsr     a3, interrupt
@@ -108,7 +153,7 @@ test soft_waiti
     set_vector kernel, 1f
     clear_interrupts
 
-    movi    a2, LSBIT(XCHAL_INTTYPE_MASK_SOFTWARE)
+    movi    a2, L1_SOFT
     wsr     a2, intset
     esync
     rsr     a3, interrupt
@@ -127,7 +172,7 @@ test soft_user
     set_vector user, 2f
     clear_interrupts
 
-    movi    a2, LSBIT(XCHAL_INTTYPE_MASK_SOFTWARE)
+    movi    a2, L1_SOFT
     wsr     a2, intset
     esync
     rsr     a3, interrupt
@@ -147,12 +192,13 @@ test soft_user
     check_l1
 test_end
 
+#if HIGH_LEVEL_SOFT
 test soft_priority
     set_vector kernel, 1f
-    set_vector level3, 2f
+    set_vector glue(level, HIGH_LEVEL_SOFT_LEVEL), 2f
     clear_interrupts
 
-    movi    a2, XCHAL_INTTYPE_MASK_SOFTWARE
+    movi    a2, L1_SOFT | HIGH_LEVEL_SOFT
     wsr     a2, intenable
     rsil    a3, 0
     esync
@@ -164,17 +210,20 @@ test soft_priority
     rsr     a2, ps
     movi    a3, 0x1f        /* EXCM | INTMASK */
     and     a2, a2, a3
-    movi    a3, 0x13
+    movi    a3, 0x10 | HIGH_LEVEL_SOFT_LEVEL
     assert  eq, a2, a3      /* EXCM and INTMASK are set
                                for high-priority interrupt */
 test_end
+#endif
+#endif
 
+#if HIGH_LEVEL_SOFT
 test eps_epc_rfi
-    set_vector level3, 3f
+    set_vector glue(level, HIGH_LEVEL_SOFT_LEVEL), 3f
     clear_interrupts
     reset_ps
 
-    movi    a2, XCHAL_INTTYPE_MASK_SOFTWARE
+    movi    a2, L1_SOFT_MASK | HIGH_LEVEL_SOFT_MASK
     wsr     a2, intenable
     rsil    a3, 0
     rsr     a3, ps
@@ -185,23 +234,26 @@ test eps_epc_rfi
 2:
     test_fail
 3:
-    rsr     a2, eps3
+    rsr     a2, glue(eps, HIGH_LEVEL_SOFT_LEVEL)
     assert  eq, a2, a3
-    rsr     a2, epc3
+    rsr     a2, glue(epc, HIGH_LEVEL_SOFT_LEVEL)
     movi    a3, 1b
     assert  ge, a2, a3
     movi    a3, 2b
     assert  ge, a3, a2
     movi    a2, 4f
-    wsr     a2, epc3
-    movi    a2, 0x40003
-    wsr     a2, eps3
-    rfi     3
+    wsr     a2, glue(epc, HIGH_LEVEL_SOFT_LEVEL)
+    movi    a2, 0x40000 | HIGH_LEVEL_SOFT_LEVEL
+    wsr     a2, glue(eps, HIGH_LEVEL_SOFT_LEVEL)
+    rfi     HIGH_LEVEL_SOFT_LEVEL
     test_fail
 4:
     rsr     a2, ps
-    movi    a3, 0x40003
+    movi    a3, 0x40000 | HIGH_LEVEL_SOFT_LEVEL
     assert  eq, a2, a3
 test_end
+#endif
+
+#endif
 
 test_suite_end
-- 
2.11.0
