Received: from eggs.gnu.org ([2001:4830:134:3::10]:51918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fup6f-0000UM-A9
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 21:17:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fup6e-0003tX-CZ
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 21:17:13 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:41831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fup6e-0003sL-3t
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 21:17:12 -0400
Received: by mail-lj1-x244.google.com with SMTP id y17-v6so2965283ljy.8
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 18:17:12 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 28 Aug 2018 18:16:52 -0700
Message-Id: <20180829011652.4466-3-jcmvbkbc@gmail.com>
In-Reply-To: <20180829011652.4466-1-jcmvbkbc@gmail.com>
References: <20180829011652.4466-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2 2/2] tests/tcg/xtensa: add test for failed
 memory transactions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Failed memory transactions should raise exceptions 14 (for fetch) or 15
(for load/store) with XEA2.

Memory accesses that result in TLB miss followed by an attempt to load
PTE from physical memory which fails should raise InstTLBMiss or
LoadStoreTLBMiss with XEA2.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- add tests that attempt TLB autorefill from the physically unmapped
  addresses.

 tests/tcg/xtensa/Makefile        |   1 +
 tests/tcg/xtensa/test_phys_mem.S | 124 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)
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
index 000000000000..aae0a793a718
--- /dev/null
+++ b/tests/tcg/xtensa/test_phys_mem.S
@@ -0,0 +1,124 @@
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
+    movi    a2, 0xc0000000
+    wsr     a2, ptevaddr
+.endm
+
+test inst_fetch_get_pte_no_phys
+    set_vector kernel, 2f
+
+    movi    a2, 0x20000000
+    jx      a2
+2:
+    movi    a2, 0x20000000
+    rsr     a3, excvaddr
+    assert  eq, a2, a3
+    rsr     a3, epc1
+    assert  eq, a2, a3
+    rsr     a3, exccause
+    movi    a2, 16
+    assert  eq, a2, a3
+test_end
+
+test read_get_pte_no_phys
+    set_vector kernel, 2f
+
+    movi    a2, 0x20000000
+1:
+    l32i    a3, a2, 0
+    test_fail
+2:
+    movi    a2, 0x20000000
+    rsr     a3, excvaddr
+    assert  eq, a2, a3
+    movi    a2, 1b
+    rsr     a3, epc1
+    assert  eq, a2, a3
+    rsr     a3, exccause
+    movi    a2, 24
+    assert  eq, a2, a3
+test_end
+
+test write_get_pte_no_phys
+    set_vector kernel, 2f
+
+    movi    a2, 0x20000000
+1:
+    s32i    a3, a2, 0
+    test_fail
+2:
+    movi    a2, 0x20000000
+    rsr     a3, excvaddr
+    assert  eq, a2, a3
+    movi    a2, 1b
+    rsr     a3, epc1
+    assert  eq, a2, a3
+    rsr     a3, exccause
+    movi    a2, 24
+    assert  eq, a2, a3
+test_end
+
+test inst_fetch_no_phys
+    set_vector kernel, 2f
+
+    movi    a2, 0xc0000000
+    jx      a2
+2:
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
