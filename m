Received: from eggs.gnu.org ([2001:4830:134:3::10]:39907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpbeH-0005Nx-M8
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpbeG-0000AL-IP
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:49 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:33430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpbeG-00009w-Ca
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:48 -0400
Received: by mail-pf0-x22d.google.com with SMTP id y68so13174869pfd.0
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 07:49:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 07:49:29 -0700
Message-Id: <20170906144940.30880-4-richard.henderson@linaro.org>
In-Reply-To: <20170906144940.30880-1-richard.henderson@linaro.org>
References: <20170906144940.30880-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 03/14] tcg: Implement implicit ordering semantics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Pranith Kumar <bobby.prani@gmail.com>

From: Pranith Kumar <bobby.prani@gmail.com>

Currently, we cannot use mttcg for running strong memory model guests
on weak memory model hosts due to missing ordering semantics.

We implicitly generate fence instructions for stronger guests if an
ordering mismatch is detected. We generate fences only for the orders
for which fence instructions are necessary, for example a fence is not
necessary between a store and a subsequent load on x86 since its
absence in the guest binary tells that ordering need not be
ensured. Also note that if we find multiple subsequent fence
instructions in the generated IR, we combine them in the TCG
optimization pass.

This patch allows us to boot an x86 guest on ARM64 hosts using mttcg.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Message-Id: <20170829063313.10237-4-bobby.prani@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 87f673ef49..688d91755b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -28,6 +28,7 @@
 #include "exec/exec-all.h"
 #include "tcg.h"
 #include "tcg-op.h"
+#include "tcg-mo.h"
 #include "trace-tcg.h"
 #include "trace/mem.h"
 
@@ -2662,8 +2663,20 @@ static void gen_ldst_i64(TCGOpcode opc, TCGv_i64 val, TCGv addr,
 #endif
 }
 
+static void tcg_gen_req_mo(TCGBar type)
+{
+#ifdef TCG_GUEST_DEFAULT_MO
+    type &= TCG_GUEST_DEFAULT_MO;
+#endif
+    type &= ~TCG_TARGET_DEFAULT_MO;
+    if (type) {
+        tcg_gen_mb(type | TCG_BAR_SC);
+    }
+}
+
 void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
+    tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 0, 0);
     trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env,
                                addr, trace_mem_get_info(memop, 0));
@@ -2672,6 +2685,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 
 void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
+    tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 0, 1);
     trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env,
                                addr, trace_mem_get_info(memop, 1));
@@ -2680,6 +2694,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 
 void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
+    tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_ld_i32(TCGV_LOW(val), addr, idx, memop);
         if (memop & MO_SIGN) {
@@ -2698,6 +2713,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 
 void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
+    tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_st_i32(TCGV_LOW(val), addr, idx, memop);
         return;
-- 
2.13.5
