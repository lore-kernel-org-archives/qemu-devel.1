Received: from eggs.gnu.org ([209.51.188.92]:49589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydy-0005Xy-Mw
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydx-0007Bi-C5
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:38 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229]:37405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydw-0007AF-67
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:37 -0500
Received: by mail-lj1-x229.google.com with SMTP id a17so66595ljd.4
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:35 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:11:07 -0800
Message-Id: <20190219061111.10231-20-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 19/23] tests/tcg/xtensa: add LSCI/LSCX group
 tests
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
 tests/tcg/xtensa/Makefile   |   1 +
 tests/tcg/xtensa/test_lsc.S | 122 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 tests/tcg/xtensa/test_lsc.S

diff --git a/tests/tcg/xtensa/Makefile b/tests/tcg/xtensa/Makefile
index bd94ba6fe549..c2bc278be5e7 100644
--- a/tests/tcg/xtensa/Makefile
+++ b/tests/tcg/xtensa/Makefile
@@ -41,6 +41,7 @@ TESTCASES += test_fail.tst
 TESTCASES += test_flix.tst
 TESTCASES += test_interrupt.tst
 TESTCASES += test_loop.tst
+TESTCASES += test_lsc.tst
 TESTCASES += test_mac16.tst
 TESTCASES += test_max.tst
 TESTCASES += test_min.tst
diff --git a/tests/tcg/xtensa/test_lsc.S b/tests/tcg/xtensa/test_lsc.S
new file mode 100644
index 000000000000..0578bf19e72e
--- /dev/null
+++ b/tests/tcg/xtensa/test_lsc.S
@@ -0,0 +1,122 @@
+#include "macros.inc"
+
+test_suite lsc
+
+#if XCHAL_HAVE_FP
+
+test lsi
+    movi    a2, 1
+    wsr     a2, cpenable
+
+    movi    a2, 1f
+    lsi     f0, a2, 0
+    lsi     f1, a2, 4
+    lsiu    f2, a2, 8
+    movi    a3, 1f + 8
+    assert  eq, a2, a3
+    rfr     a2, f0
+    movi    a3, 0x3f800000
+    assert  eq, a2, a3
+    rfr     a2, f1
+    movi    a3, 0x40000000
+    assert  eq, a2, a3
+    rfr     a2, f2
+    movi    a3, 0x40400000
+    assert  eq, a2, a3
+.data
+    .align  4
+1:
+.float 1, 2, 3
+.text
+test_end
+
+test ssi
+    movi    a2, 1f
+    movi    a3, 0x40800000
+    wfr     f3, a3
+    ssi     f3, a2, 0
+    movi    a3, 0x40a00000
+    wfr     f4, a3
+    ssi     f4, a2, 4
+    movi    a3, 0x40c00000
+    wfr     f5, a3
+    ssiu    f5, a2, 8
+    movi    a3, 1f + 8
+    assert  eq, a2, a3
+    l32i    a4, a2, -8
+    movi    a3, 0x40800000
+    assert  eq, a4, a3
+    l32i    a4, a2, -4
+    movi    a3, 0x40a00000
+    assert  eq, a4, a3
+    l32i    a4, a2, 0
+    movi    a3, 0x40c00000
+    assert  eq, a4, a3
+.data
+    .align  4
+1:
+.float 0, 0, 0
+.text
+test_end
+
+test lsx
+    movi    a2, 1f
+    movi    a3, 0
+    lsx     f6, a2, a3
+    movi    a3, 4
+    lsx     f7, a2, a3
+    movi    a3, 8
+    lsxu    f8, a2, a3
+    movi    a3, 1f + 8
+    assert  eq, a2, a3
+    rfr     a2, f6
+    movi    a3, 0x40e00000
+    assert  eq, a2, a3
+    rfr     a2, f7
+    movi    a3, 0x41000000
+    assert  eq, a2, a3
+    rfr     a2, f8
+    movi    a3, 0x41100000
+    assert  eq, a2, a3
+.data
+    .align  4
+1:
+.float 7, 8, 9
+.text
+test_end
+
+test ssx
+    movi    a2, 1f
+    movi    a3, 0
+    movi    a4, 0x41200000
+    wfr     f9, a4
+    ssx     f9, a2, a3
+    movi    a3, 4
+    movi    a4, 0x41300000
+    wfr     f10, a4
+    ssx     f10, a2, a3
+    movi    a3, 8
+    movi    a4, 0x41400000
+    wfr     f11, a4
+    ssxu    f11, a2, a3
+    movi    a3, 1f + 8
+    assert  eq, a2, a3
+    l32i    a4, a2, -8
+    movi    a3, 0x41200000
+    assert  eq, a4, a3
+    l32i    a4, a2, -4
+    movi    a3, 0x41300000
+    assert  eq, a4, a3
+    l32i    a4, a2, 0
+    movi    a3, 0x41400000
+    assert  eq, a4, a3
+.data
+    .align  4
+1:
+.float 0, 0, 0
+.text
+test_end
+
+#endif
+
+test_suite_end
-- 
2.11.0
