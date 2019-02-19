Received: from eggs.gnu.org ([209.51.188.92]:49595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydy-0005Y2-Np
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydx-0007C2-K6
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:38 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234]:46667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydx-00079s-Ap
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:37 -0500
Received: by mail-lj1-x234.google.com with SMTP id v16so16355878ljg.13
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:32 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:11:06 -0800
Message-Id: <20190219061111.10231-19-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 18/23] tests/tcg/xtensa: add test for FLIX
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

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/Makefile    |  1 +
 tests/tcg/xtensa/test_flix.S | 60 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 tests/tcg/xtensa/test_flix.S

diff --git a/tests/tcg/xtensa/Makefile b/tests/tcg/xtensa/Makefile
index aee0134ef5b9..bd94ba6fe549 100644
--- a/tests/tcg/xtensa/Makefile
+++ b/tests/tcg/xtensa/Makefile
@@ -38,6 +38,7 @@ TESTCASES += test_cache.tst
 TESTCASES += test_clamps.tst
 TESTCASES += test_extui.tst
 TESTCASES += test_fail.tst
+TESTCASES += test_flix.tst
 TESTCASES += test_interrupt.tst
 TESTCASES += test_loop.tst
 TESTCASES += test_mac16.tst
diff --git a/tests/tcg/xtensa/test_flix.S b/tests/tcg/xtensa/test_flix.S
new file mode 100644
index 000000000000..7c259e701897
--- /dev/null
+++ b/tests/tcg/xtensa/test_flix.S
@@ -0,0 +1,60 @@
+#include "macros.inc"
+
+test_suite flix
+
+#if XCHAL_HAVE_FLIX3
+
+test misc
+    {
+        mov     a3, a4
+        mov     a2, a3
+        nop
+    }
+    {
+        nop
+        bne.w18 a2, a3, 1f
+    }
+    movi    a2, 1f
+    {
+        mov     a2, a3
+        mov     a3, a2
+        nop
+    }
+    {
+        l32i    a2, a3, 0
+        add     a4, a4, a2
+        nop
+    }
+    {
+        mov     a3, a4
+        jx      a3
+        nop
+    }
+1:
+test_end
+
+test sum
+
+    movi    a2, 0
+    movi    a3, 2f
+    movi    a4, 0
+    movi    a5, 4
+
+    loop    a5, 1f
+    {
+        l32i    a2, a3, 0
+        addi    a3, a3, 4
+        add     a4, a4, a2
+    }
+1:
+    add     a4, a4, a2
+    assert  eqi, a4, 10
+    .data
+2:
+    .word   1, 2, 3, 4
+    .previous
+test_end
+
+#endif
+
+test_suite_end
-- 
2.11.0
