Received: from eggs.gnu.org ([2001:4830:134:3::10]:38260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1frauv-0006ph-7j
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 23:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1frauu-0001Qb-IM
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 23:31:45 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:34453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1frauu-0001QF-Bj
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 23:31:44 -0400
Received: by mail-lf1-x141.google.com with SMTP id g9-v6so4557517lfh.1
	for <qemu-devel@nongnu.org>; Sun, 19 Aug 2018 20:31:44 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 19 Aug 2018 20:31:25 -0700
Message-Id: <20180820033125.10296-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] tests/tcg/xtensa: add test for failed memory
 transactions
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

Failed memory transactions should raise exceptions 14 (for fetch) or 15
(for load/store) with XEA2.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/Makefile        |  1 +
 tests/tcg/xtensa/test_phys_mem.S | 68 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 tests/tcg/xtensa/test_phys_mem.S

diff --git a/tests/tcg/xtensa/Makefile b/tests/tcg/xtensa/Makefile
index 091518c05583..2f5691f75b09 100644
--- a/tests/tcg/xtensa/Makefile
+++ b/tests/tcg/xtensa/Makefile
@@ -44,6 +44,7 @@ TESTCASES += test_mmu.tst
 TESTCASES += test_mul16.tst
 TESTCASES += test_mul32.tst
 TESTCASES += test_nsa.tst
+TESTCASES += test_phys_mem.tst
 ifdef XT
 TESTCASES += test_pipeline.tst
 endif
diff --git a/tests/tcg/xtensa/test_phys_mem.S b/tests/tcg/xtensa/test_phys_mem.S
new file mode 100644
index 000000000000..5db17ce506e8
--- /dev/null
+++ b/tests/tcg/xtensa/test_phys_mem.S
@@ -0,0 +1,68 @@
+#include "macros.inc"
+
+test_suite phys_mem
+
+.purgem test_init
+
+.macro test_init
+    movi    a2, 0xc0000003 /* PPN */
+    movi    a3, 0xc0000004 /* VPN */
+    wdtlb   a2, a3
+    witlb   a2, a3
+.endm
+
+test inst_fetch_no_phys
+    set_vector kernel, 1f
+
+    movi    a2, 0xc0000000
+    jx      a2
+1:
+    movi    a2, 0xc0000000
+    rsr     a3, excvaddr
+    assert  eq, a2, a3
+    rsr     a3, epc1
+    assert  eq, a2, a3
+    rsr     a3, exccause
+    movi    a2, 14
+    assert  eq, a2, a3
+test_end
+
+test read_no_phys
+    set_vector kernel, 2f
+
+    movi    a2, 0xc0000000
+1:
+    l32i    a3, a2, 0
+    test_fail
+2:
+    movi    a2, 0xc0000000
+    rsr     a3, excvaddr
+    assert  eq, a2, a3
+    movi    a2, 1b
+    rsr     a3, epc1
+    assert  eq, a2, a3
+    rsr     a3, exccause
+    movi    a2, 15
+    assert  eq, a2, a3
+test_end
+
+test write_no_phys
+    set_vector kernel, 2f
+
+    movi    a2, 0xc0000000
+1:
+    s32i    a3, a2, 0
+    test_fail
+2:
+    movi    a2, 0xc0000000
+    rsr     a3, excvaddr
+    assert  eq, a2, a3
+    movi    a2, 1b
+    rsr     a3, epc1
+    assert  eq, a2, a3
+    rsr     a3, exccause
+    movi    a2, 15
+    assert  eq, a2, a3
+test_end
+
+test_suite_end
-- 
2.11.0
