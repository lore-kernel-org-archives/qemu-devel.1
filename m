Received: from eggs.gnu.org ([209.51.188.92]:49481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydZ-0005Hs-30
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydY-00074Y-8d
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:13 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:35131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydX-00074B-Se
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:12 -0500
Received: by mail-lf1-x141.google.com with SMTP id v7so14039250lfd.2
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:11 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:10:56 -0800
Message-Id: <20190219061111.10231-9-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 08/23] tests/tcg/xtensa: conditionalize debug
 option tests
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

Make debug tests conditional on the presence of the debug option in the
config and tests that depend on the presence/number of instruction or
data breakpoint registers on the corresponding definitions. Use
configured debug interrupt level instead of the hardcoded value to set
up IRQ handler and access debug EPC register.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/macros.inc   |  3 +++
 tests/tcg/xtensa/test_break.S | 27 ++++++++++++++++++---------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/tests/tcg/xtensa/macros.inc b/tests/tcg/xtensa/macros.inc
index 93825dc7b513..5265c8606bff 100644
--- a/tests/tcg/xtensa/macros.inc
+++ b/tests/tcg/xtensa/macros.inc
@@ -97,3 +97,6 @@ test_\name:
     movi    a3, \addr
     s32i    a3, a2, 0
 .endm
+
+#define glue(a, b) _glue(a, b)
+#define _glue(a, b) a ## b
diff --git a/tests/tcg/xtensa/test_break.S b/tests/tcg/xtensa/test_break.S
index 775cd7c26063..3379a3f9f06e 100644
--- a/tests/tcg/xtensa/test_break.S
+++ b/tests/tcg/xtensa/test_break.S
@@ -1,10 +1,13 @@
 #include "macros.inc"
 
-#define debug_level 6
-#define debug_vector level6
-
 test_suite break
 
+#if XCHAL_HAVE_DEBUG
+
+#define debug_level XCHAL_DEBUGLEVEL
+#define debug_vector glue(level, XCHAL_DEBUGLEVEL)
+#define EPC_DEBUG glue(epc, XCHAL_DEBUGLEVEL)
+
 test break
     set_vector debug_vector, 0
     rsil    a2, debug_level
@@ -21,7 +24,7 @@ test break
     and     a2, a2, a3
     movi    a3, 0x10 | debug_level
     assert  eq, a2, a3
-    rsr     a2, epc6
+    rsr     a2, EPC_DEBUG
     movi    a3, 1b
     assert  eq, a2, a3
     rsr     a2, debugcause
@@ -45,7 +48,7 @@ test breakn
     and     a2, a2, a3
     movi    a3, 0x10 | debug_level
     assert  eq, a2, a3
-    rsr     a2, epc6
+    rsr     a2, EPC_DEBUG
     movi    a3, 1b
     assert  eq, a2, a3
     rsr     a2, debugcause
@@ -53,6 +56,7 @@ test breakn
     assert  eq, a2, a3
 test_end
 
+#if XCHAL_NUM_IBREAK
 test ibreak
     set_vector debug_vector, 0
     rsil    a2, debug_level
@@ -83,7 +87,7 @@ test ibreak
     and     a2, a2, a3
     movi    a3, 0x10 | debug_level
     assert  eq, a2, a3
-    rsr     a2, epc6
+    rsr     a2, EPC_DEBUG
     movi    a3, 1b
     assert  eq, a2, a3
     rsr     a2, debugcause
@@ -110,7 +114,7 @@ test ibreak_remove
     and     a2, a2, a3
     movi    a3, 0x10 | debug_level
     assert  eq, a2, a3
-    rsr     a2, epc6
+    rsr     a2, EPC_DEBUG
     movi    a3, 2b
     assert  eq, a2, a3
     rsr     a2, debugcause
@@ -141,6 +145,7 @@ test ibreak_priority
     movi    a3, 0x2
     assert  eq, a2, a3
 test_end
+#endif
 
 test icount
     set_vector debug_vector, 2f
@@ -158,7 +163,7 @@ test icount
 2:
     movi    a2, 0
     wsr     a2, icountlevel
-    rsr     a2, epc6
+    rsr     a2, EPC_DEBUG
     movi    a3, 1b
     assert  eq, a2, a3
     rsr     a2, debugcause
@@ -167,7 +172,7 @@ test icount
 test_end
 
 .macro check_dbreak dr
-    rsr     a2, epc6
+    rsr     a2, EPC_DEBUG
     movi    a3, 1b
     assert  eq, a2, a3
     rsr     a2, debugcause
@@ -194,6 +199,7 @@ test_end
     reset_ps
 .endm
 
+#if XCHAL_NUM_DBREAK
 test dbreak_exact
     dbreak_test 0, 0x4000003f, 0xd000007f, 0xd000007f, l8ui
     dbreak_test 1, 0x4000003e, 0xd000007e, 0xd000007e, l16ui
@@ -253,5 +259,8 @@ test dbreak_invalid
     dbreak_test 0, 0x40000030, 0xd0000071, 0xd0000070, l16ui
     dbreak_test 1, 0x40000035, 0xd0000072, 0xd0000070, l32i
 test_end
+#endif
+
+#endif
 
 test_suite_end
-- 
2.11.0
