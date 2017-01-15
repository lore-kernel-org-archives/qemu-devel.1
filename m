Received: from eggs.gnu.org ([2001:4830:134:3::10]:35300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs4l-00068z-QF
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs4k-0002qN-OQ
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:55 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cSs4k-0002q8-JZ
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:54 -0500
Received: by mail-pg0-x241.google.com with SMTP id 194so3586007pgd.0
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 13:10:54 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 15 Jan 2017 13:10:15 -0800
Message-Id: <1484514617-11726-6-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1484514617-11726-1-git-send-email-jcmvbkbc@gmail.com>
References: <1484514617-11726-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 5/7] target/xtensa: tests: fix timer tests
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

Don't expect that CCOUNT increments are equal to the number of executed
instructions. Verify that timer interrupt does not fire before the
programmed CCOMPARE value and does fire after.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_timer.S | 61 +++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/tests/tcg/xtensa/test_timer.S b/tests/tcg/xtensa/test_timer.S
index f8c6f74..9e6012d 100644
--- a/tests/tcg/xtensa/test_timer.S
+++ b/tests/tcg/xtensa/test_timer.S
@@ -1,12 +1,22 @@
 #include "macros.inc"
 
+#define CCOUNT_SHIFT 4
+#define WAIT_LOOPS 20
+
+.macro      make_ccount_delta target, delta
+    rsr     \delta, ccount
+    rsr     \target, ccount
+    sub     \delta, \target, \delta
+    slli    \delta, \delta, CCOUNT_SHIFT
+    add     \target, \target, \delta
+.endm
+
 test_suite timer
 
 test ccount
     rsr     a3, ccount
     rsr     a4, ccount
-    sub     a3, a4, a3
-    assert  eqi, a3, 1
+    assert  ne, a3, a4
 test_end
 
 test ccompare
@@ -18,18 +28,18 @@ test ccompare
     wsr     a2, ccompare1
     wsr     a2, ccompare2
 
-    movi    a3, 20
-    rsr     a2, ccount
-    addi    a2, a2, 20
+    make_ccount_delta a2, a15
     wsr     a2, ccompare0
-    rsr     a2, interrupt
-    assert  eqi, a2, 0
-    loop    a3, 1f
-    rsr     a3, interrupt
-    bnez    a3, 2f
 1:
-    test_fail
+    rsr     a3, interrupt
+    rsr     a4, ccount
+    rsr     a5, interrupt
+    sub     a4, a4, a2
+    bgez    a4, 2f
+    assert  eqi, a3, 0
+    j       1b
 2:
+    assert  nei, a5, 0
 test_end
 
 test ccompare0_interrupt
@@ -42,9 +52,8 @@ test ccompare0_interrupt
     wsr     a2, ccompare1
     wsr     a2, ccompare2
 
-    movi    a3, 20
-    rsr     a2, ccount
-    addi    a2, a2, 20
+    movi    a3, WAIT_LOOPS
+    make_ccount_delta a2, a15
     wsr     a2, ccompare0
     rsync
     rsr     a2, interrupt
@@ -72,9 +81,8 @@ test ccompare1_interrupt
     wsr     a2, ccompare0
     wsr     a2, ccompare2
 
-    movi    a3, 20
-    rsr     a2, ccount
-    addi    a2, a2, 20
+    movi    a3, WAIT_LOOPS
+    make_ccount_delta a2, a15
     wsr     a2, ccompare1
     rsync
     rsr     a2, interrupt
@@ -99,9 +107,8 @@ test ccompare2_interrupt
     wsr     a2, ccompare0
     wsr     a2, ccompare1
 
-    movi    a3, 20
-    rsr     a2, ccount
-    addi    a2, a2, 20
+    movi    a3, WAIT_LOOPS
+    make_ccount_delta a2, a15
     wsr     a2, ccompare2
     rsync
     rsr     a2, interrupt
@@ -125,11 +132,10 @@ test ccompare_interrupt_masked
     movi    a2, 0
     wsr     a2, ccompare2
 
-    movi    a3, 40
-    rsr     a2, ccount
-    addi    a2, a2, 20
+    movi    a3, 2 * WAIT_LOOPS
+    make_ccount_delta a2, a15
     wsr     a2, ccompare1
-    addi    a2, a2, 20
+    add     a2, a2, a15
     wsr     a2, ccompare0
     rsync
     rsr     a2, interrupt
@@ -156,11 +162,10 @@ test ccompare_interrupt_masked_waiti
     movi    a2, 0
     wsr     a2, ccompare2
 
-    movi    a3, 40
-    rsr     a2, ccount
-    addi    a2, a2, 20
+    movi    a3, 2 * WAIT_LOOPS
+    make_ccount_delta a2, a15
     wsr     a2, ccompare1
-    addi    a2, a2, 20
+    add     a2, a2, a15
     wsr     a2, ccompare0
     rsync
     rsr     a2, interrupt
-- 
2.1.4
