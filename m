Received: from eggs.gnu.org ([209.51.188.92]:49590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydy-0005Xz-Mt
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydx-0007Bp-DD
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:38 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:33324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydw-00076d-7C
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:37 -0500
Received: by mail-lj1-x241.google.com with SMTP id f24-v6so16403094ljk.0
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:26 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:11:03 -0800
Message-Id: <20190219061111.10231-16-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 15/23] tests/tcg/xtensa: conditionalize and fix
 s32c1i tests
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

Make s32c1i tests conditional on the presence of this option. Initialize
ATOMCTL SR when it's present to allow RCW transactions on uncached
memory.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_s32c1i.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/tcg/xtensa/test_s32c1i.S b/tests/tcg/xtensa/test_s32c1i.S
index 93b575db95ba..2885d9d003c0 100644
--- a/tests/tcg/xtensa/test_s32c1i.S
+++ b/tests/tcg/xtensa/test_s32c1i.S
@@ -2,7 +2,13 @@
 
 test_suite s32c1i
 
+#if XCHAL_HAVE_S32C1I
+
 test s32c1i_nowrite
+#if XCHAL_HW_VERSION >= 230000
+    movi    a2, 0x29
+    wsr     a2, atomctl
+#endif
     movi    a2, 1f
     movi    a3, 1
     wsr     a3, scompare1
@@ -20,6 +26,10 @@ test s32c1i_nowrite
 test_end
 
 test s32c1i_write
+#if XCHAL_HW_VERSION >= 230000
+    movi    a2, 0x29
+    wsr     a2, atomctl
+#endif
     movi    a2, 1f
     movi    a3, 3
     wsr     a3, scompare1
@@ -36,4 +46,6 @@ test s32c1i_write
 .text
 test_end
 
+#endif
+
 test_suite_end
-- 
2.11.0
