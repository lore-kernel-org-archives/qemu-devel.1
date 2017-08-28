Received: from eggs.gnu.org ([2001:4830:134:3::10]:55762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dmB7I-0003jE-0C
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 23:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dmB7G-00042k-T6
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 23:53:36 -0400
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Sun, 27 Aug 2017 23:53:26 -0400
Message-Id: <20170828035327.17146-3-bobby.prani@gmail.com>
In-Reply-To: <20170828035327.17146-1-bobby.prani@gmail.com>
References: <20170828035327.17146-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 3/3] mttcg: Implement implicit ordering
 semantics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org, Claudio Fontana <claudio.fontana@huawei.com>, Richard Henderson <rth@twiddle.net>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, "open list:AArch64 target" <qemu-arm@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: pbonzini@redhat.com

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
---
 tcg/aarch64/tcg-target.h |  2 ++
 tcg/arm/tcg-target.h     |  2 ++
 tcg/mips/tcg-target.h    |  2 ++
 tcg/ppc/tcg-target.h     |  2 ++
 tcg/tcg-op.c             | 17 +++++++++++++++++
 tcg/tcg-op.h             |  1 +
 6 files changed, 26 insertions(+)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 55a46ac825..b41a248bee 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -117,4 +117,6 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
     __builtin___clear_cache((char *)start, (char *)stop);
 }
 
+#define TCG_TARGET_DEFAULT_MO (0)
+
 #endif /* AARCH64_TCG_TARGET_H */
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 5ef1086710..a38be15a39 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -134,4 +134,6 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
     __builtin___clear_cache((char *) start, (char *) stop);
 }
 
+#define TCG_TARGET_DEFAULT_MO (0)
+
 #endif
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index d75cb63ed3..e9558d15bc 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -206,4 +206,6 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
     cacheflush ((void *)start, stop-start, ICACHE);
 }
 
+#define TCG_TARGET_DEFAULT_MO (0)
+
 #endif
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 5f4a40a5b4..5a092b038a 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -125,4 +125,6 @@ extern bool have_isa_3_00;
 
 void flush_icache_range(uintptr_t start, uintptr_t stop);
 
+#define TCG_TARGET_DEFAULT_MO (0)
+
 #endif
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 87f673ef49..085fe66fb2 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -28,6 +28,7 @@
 #include "exec/exec-all.h"
 #include "tcg.h"
 #include "tcg-op.h"
+#include "tcg-mo.h"
 #include "trace-tcg.h"
 #include "trace/mem.h"
 
@@ -2662,8 +2663,21 @@ static void gen_ldst_i64(TCGOpcode opc, TCGv_i64 val, TCGv addr,
 #endif
 }
 
+void tcg_gen_req_mo(TCGBar type)
+{
+#if defined(TCG_GUEST_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
+    TCGBar order_mismatch = type & (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO);
+    if (order_mismatch) {
+        tcg_gen_mb(order_mismatch | TCG_BAR_SC);
+    }
+#else
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+#endif
+}
+
 void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
+    tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_LD_ST);
     memop = tcg_canonicalize_memop(memop, 0, 0);
     trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env,
                                addr, trace_mem_get_info(memop, 0));
@@ -2672,6 +2686,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 
 void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
+    tcg_gen_req_mo(TCG_MO_ST_LD | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 0, 1);
     trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env,
                                addr, trace_mem_get_info(memop, 1));
@@ -2680,6 +2695,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 
 void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
+    tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_LD_ST);
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_ld_i32(TCGV_LOW(val), addr, idx, memop);
         if (memop & MO_SIGN) {
@@ -2698,6 +2714,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 
 void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
+    tcg_gen_req_mo(TCG_MO_ST_LD | TCG_MO_ST_ST);
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_st_i32(TCGV_LOW(val), addr, idx, memop);
         return;
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 5d3278f243..6ad2c6d60e 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -262,6 +262,7 @@ static inline void tcg_gen_br(TCGLabel *l)
 }
 
 void tcg_gen_mb(TCGBar);
+void tcg_gen_req_mo(TCGBar type);
 
 /* Helper calls. */
 
-- 
2.13.0
