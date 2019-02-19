Received: from eggs.gnu.org ([209.51.188.92]:49453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydV-0005EU-A5
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydU-00073i-4g
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:09 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:35132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydT-00073W-K0
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:07 -0500
Received: by mail-lf1-x143.google.com with SMTP id v7so14039149lfd.2
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:07 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:10:54 -0800
Message-Id: <20190219061111.10231-7-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 06/23] tests/tcg/xtensa: fix endianness issues
 in test_b
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

Use bbci.l/bbsi.l instead of bbci/bbsi, as they are assembly macros that
accept little-endian bit number and produce correct immediate for both
little and big endian configurations. Choose value loaded into register
for bbc/bbs opcodes based on configuration endianness.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_b.S | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/tests/tcg/xtensa/test_b.S b/tests/tcg/xtensa/test_b.S
index 8e81f956df84..713a454c535b 100644
--- a/tests/tcg/xtensa/test_b.S
+++ b/tests/tcg/xtensa/test_b.S
@@ -84,12 +84,24 @@ test_end
 
 test bbc
     movi    a2, 0xfffffffd
-    movi    a3, 0xffffff01
+#undef BIT
+#if XCHAL_HAVE_BE
+#define BIT 0xfffffffe
+#else
+#define BIT 0xffffff01
+#endif
+    movi    a3, BIT
     bbc     a2, a3, 1f
     test_fail
 1:
     movi    a2, 8
-    movi    a3, 0xffffff03
+#undef BIT
+#if XCHAL_HAVE_BE
+#define BIT 0xfffffffc
+#else
+#define BIT 0xffffff03
+#endif
+    movi    a3, BIT
     bbc     a2, a3, 1f
     j       2f
 1:
@@ -99,11 +111,11 @@ test_end
 
 test bbci
     movi    a2, 0xfffdffff
-    bbci    a2, 17, 1f
+    bbci.l  a2, 17, 1f
     test_fail
 1:
     movi    a2, 0x00020000
-    bbci    a2, 17, 1f
+    bbci.l  a2, 17, 1f
     j       2f
 1:
     test_fail
@@ -192,12 +204,24 @@ test_end
 
 test bbs
     movi    a2, 8
-    movi    a3, 0xffffff03
+#undef BIT
+#if XCHAL_HAVE_BE
+#define BIT 0xfffffffc
+#else
+#define BIT 0xffffff03
+#endif
+    movi    a3, BIT
     bbs     a2, a3, 1f
     test_fail
 1:
     movi    a2, 0xfffffffd
-    movi    a3, 0xffffff01
+#undef BIT
+#if XCHAL_HAVE_BE
+#define BIT 0xfffffffe
+#else
+#define BIT 0xffffff01
+#endif
+    movi    a3, BIT
     bbs     a2, a3, 1f
     j       2f
 1:
@@ -207,11 +231,11 @@ test_end
 
 test bbsi
     movi    a2, 0x00020000
-    bbsi    a2, 17, 1f
+    bbsi.l  a2, 17, 1f
     test_fail
 1:
     movi    a2, 0xfffdffff
-    bbsi    a2, 17, 1f
+    bbsi.l  a2, 17, 1f
     j       2f
 1:
     test_fail
-- 
2.11.0
