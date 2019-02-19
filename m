Received: from eggs.gnu.org ([209.51.188.92]:49593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydy-0005Y1-NZ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydx-0007C9-Mq
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:38 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232]:43649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydx-00076U-D5
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:37 -0500
Received: by mail-lj1-x232.google.com with SMTP id z20so15355527ljj.10
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:24 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:11:02 -0800
Message-Id: <20190219061111.10231-15-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 14/23] tests/tcg/xtensa: fix SR tests for big
 endian configs
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

SR tests generate instructions that the assembler does not recognize and
thus must take care about configuration endianness.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_sr.S | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/xtensa/test_sr.S b/tests/tcg/xtensa/test_sr.S
index e64653b8771e..b1a91a0637ee 100644
--- a/tests/tcg/xtensa/test_sr.S
+++ b/tests/tcg/xtensa/test_sr.S
@@ -2,11 +2,23 @@
 
 test_suite sr
 
+#if XCHAL_HAVE_BE
+#define LOW__SR 0x04
+#define HI_RSR 0x30
+#define HI_WSR 0x31
+#define HI_XSR 0x16
+#else
+#define LOW__SR 0x40
+#define HI_RSR 0x03
+#define HI_WSR 0x13
+#define HI_XSR 0x61
+#endif
+
 .macro  sr_op sym, op_sym, op_byte, sr
     .if \sym
     \op_sym a4, \sr
     .else
-    .byte 0x40, \sr, \op_byte
+    .byte LOW__SR, \sr, \op_byte
     .endif
 .endm
 
@@ -32,9 +44,9 @@ test_suite sr
 
 .macro  test_sr_mask sr, sym, mask
 test \sr
-    test_sr_op \sym, \mask & 1, rsr, 0x03, \sr
-    test_sr_op \sym, \mask & 2, wsr, 0x13, \sr
-    test_sr_op \sym, \mask & 4, xsr, 0x61, \sr
+    test_sr_op \sym, \mask & 1, rsr, HI_RSR, \sr
+    test_sr_op \sym, \mask & 2, wsr, HI_WSR, \sr
+    test_sr_op \sym, \mask & 4, xsr, HI_XSR, \sr
 test_end
 .endm
 
-- 
2.11.0
