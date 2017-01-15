Received: from eggs.gnu.org ([2001:4830:134:3::10]:38182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSsUL-0005oG-FW
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSsUI-0002Qs-BB
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:37:21 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cSsUI-0002Qa-48
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:37:18 -0500
Received: by mail-pg0-x242.google.com with SMTP id 75so3618679pgf.3
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 13:37:18 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 15 Jan 2017 13:37:05 -0800
Message-Id: <1484516225-12958-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: tests: clean up interrupt tests
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

Don't use hardcoded software interrupt masks, use XCHAL macros.
Mask off timer interrupt bits that are not checked for.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_interrupt.S | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tests/tcg/xtensa/test_interrupt.S b/tests/tcg/xtensa/test_interrupt.S
index 334ddab..8766835 100644
--- a/tests/tcg/xtensa/test_interrupt.S
+++ b/tests/tcg/xtensa/test_interrupt.S
@@ -1,5 +1,7 @@
 #include "macros.inc"
 
+#define LSBIT(v) ((v) ^ ((v) & ((v) - 1)))
+
 test_suite interrupt
 
 .macro clear_interrupts
@@ -46,14 +48,17 @@ test soft_disabled
     set_vector kernel, 1f
     clear_interrupts
 
-    movi    a2, 0x80
+    movi    a2, LSBIT(XCHAL_INTTYPE_MASK_SOFTWARE)
     wsr     a2, intset
     esync
     rsr     a3, interrupt
+    movi    a4, ~XCHAL_INTTYPE_MASK_TIMER
+    and     a3, a3, a4
     assert  eq, a2, a3
     wsr     a2, intclear
     esync
     rsr     a3, interrupt
+    and     a3, a3, a4
     assert  eqi, a3, 0
     j       2f
 1:
@@ -65,10 +70,12 @@ test soft_intenable
     set_vector kernel, 1f
     clear_interrupts
 
-    movi    a2, 0x80
+    movi    a2, LSBIT(XCHAL_INTTYPE_MASK_SOFTWARE)
     wsr     a2, intset
     esync
     rsr     a3, interrupt
+    movi    a4, ~XCHAL_INTTYPE_MASK_TIMER
+    and     a3, a3, a4
     assert  eq, a2, a3
     rsil    a3, 0
     wsr     a2, intenable
@@ -82,10 +89,12 @@ test soft_rsil
     set_vector kernel, 1f
     clear_interrupts
 
-    movi    a2, 0x80
+    movi    a2, LSBIT(XCHAL_INTTYPE_MASK_SOFTWARE)
     wsr     a2, intset
     esync
     rsr     a3, interrupt
+    movi    a4, ~XCHAL_INTTYPE_MASK_TIMER
+    and     a3, a3, a4
     assert  eq, a2, a3
     wsr     a2, intenable
     rsil    a3, 0
@@ -99,10 +108,12 @@ test soft_waiti
     set_vector kernel, 1f
     clear_interrupts
 
-    movi    a2, 0x80
+    movi    a2, LSBIT(XCHAL_INTTYPE_MASK_SOFTWARE)
     wsr     a2, intset
     esync
     rsr     a3, interrupt
+    movi    a4, ~XCHAL_INTTYPE_MASK_TIMER
+    and     a3, a3, a4
     assert  eq, a2, a3
     wsr     a2, intenable
     waiti   0
@@ -116,10 +127,12 @@ test soft_user
     set_vector user, 2f
     clear_interrupts
 
-    movi    a2, 0x80
+    movi    a2, LSBIT(XCHAL_INTTYPE_MASK_SOFTWARE)
     wsr     a2, intset
     esync
     rsr     a3, interrupt
+    movi    a4, ~XCHAL_INTTYPE_MASK_TIMER
+    and     a3, a3, a4
     assert  eq, a2, a3
     wsr     a2, intenable
 
@@ -139,7 +152,7 @@ test soft_priority
     set_vector level3, 2f
     clear_interrupts
 
-    movi    a2, 0x880
+    movi    a2, XCHAL_INTTYPE_MASK_SOFTWARE
     wsr     a2, intenable
     rsil    a3, 0
     esync
@@ -161,7 +174,7 @@ test eps_epc_rfi
     clear_interrupts
     reset_ps
 
-    movi    a2, 0x880
+    movi    a2, XCHAL_INTTYPE_MASK_SOFTWARE
     wsr     a2, intenable
     rsil    a3, 0
     rsr     a3, ps
-- 
2.1.4
