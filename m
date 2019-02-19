Received: from eggs.gnu.org ([209.51.188.92]:49538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydx-0005X9-87
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydw-0007Ab-6O
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:37 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:46473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydr-00076p-Gf
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:33 -0500
Received: by mail-lj1-x243.google.com with SMTP id v16so16355753ljg.13
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:28 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:11:04 -0800
Message-Id: <20190219061111.10231-17-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 16/23] tests/tcg/xtensa: conditionalize
 windowed register tests
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

Make windowed register tests conditional on the presence of this option.
Fix tests to work correctly for both 32 and 64 physical registers.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_windowed.S | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/tests/tcg/xtensa/test_windowed.S b/tests/tcg/xtensa/test_windowed.S
index d851e8f43c5c..5ead90a790ed 100644
--- a/tests/tcg/xtensa/test_windowed.S
+++ b/tests/tcg/xtensa/test_windowed.S
@@ -2,10 +2,12 @@
 
 test_suite windowed
 
+#if XCHAL_HAVE_WINDOWED
+
 .altmacro
 
 .macro reset_window start
-    movi    a2, 0xff
+    movi    a2, 0xffff
     wsr     a2, windowstart
     rsync
     movi    a2, 0
@@ -105,7 +107,8 @@ test_end
     movi    a3, 0x4001f
     assert  eq, a2, a3
     rsr     a2, windowbase
-    assert  eqi, a2, 8 - ((\window) / 4)
+    movi    a3, (XCHAL_NUM_AREGS - (\window)) / 4
+    assert  eq, a2, a3
     rsr     a2, windowstart
     assert  eqi, a2, 1
     rfwu
@@ -116,8 +119,8 @@ test_end
     rsr     a2, windowbase
     assert  eqi, a2, 0
     rsr     a2, windowstart
-    assert  bsi, a2, 0
-    assert  bsi, a2, 8 - ((\window) / 4)
+    assert  bsi.l, a2, 0
+    assert  bsi.l, a2, (XCHAL_NUM_AREGS - (\window)) / 4
 .endm
 
 test underflow
@@ -132,7 +135,7 @@ test_end
 
 
 .macro retw_test window
-    reset_window %(1 | (1 << (8 - (\window) / 4)))
+    reset_window %(1 | (1 << ((XCHAL_NUM_AREGS - \window) / 4)))
     reset_ps
 
     ssai    2
@@ -147,10 +150,11 @@ test_end
     movi    a3, 0x4000f
     assert  eq, a2, a3
     rsr     a2, windowbase
-    assert  eqi, a2, 8 - ((\window) / 4)
+    movi    a3, (XCHAL_NUM_AREGS - (\window)) / 4
+    assert  eq, a2, a3
     rsr     a2, windowstart
-    assert  bci, a2, 0
-    assert  bsi, a2, 8 - ((\window) / 4)
+    assert  bci.l, a2, 0
+    assert  bsi.l, a2, (XCHAL_NUM_AREGS - (\window)) / 4
 .endm
 
 test retw
@@ -180,7 +184,7 @@ test movsp
 
     set_vector kernel, 0
 
-    reset_window 0x81
+    reset_window %(0x1 | (1 << ((XCHAL_NUM_AREGS / 4) - 1)))
     reset_ps
 
     movsp   a2, a3
@@ -211,8 +215,16 @@ test rotw
     movi    a3, 0x16
     movi    a7, 0x17
 
+#if XCHAL_NUM_AREGS == 32
     movi    a2, 0x44
     wsr     a2, windowstart
+#elif XCHAL_NUM_AREGS == 64
+    movi    a2, 0x4004
+    wsr     a2, windowstart
+    rotw    -8
+#else
+#error XCHAL_NUM_AREGS unsupported
+#endif
     rsync
 
     movi    a2, 0x10
@@ -350,4 +362,6 @@ test entry_overflow
     all_entry_overflow_tests
 test_end
 
+#endif
+
 test_suite_end
-- 
2.11.0
