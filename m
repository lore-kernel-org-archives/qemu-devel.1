Received: from eggs.gnu.org ([2001:4830:134:3::10]:39739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKU-0002qE-8l
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKS-0006xc-CS
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:22 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:49 +1000
Message-Id: <20180703055804.13449-21-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 20/35] target/ppc: Use MO_ALIGN for EXIWX and
 ECOWX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Richard Henderson <richard.henderson@linaro.org>

This avoids the need for gen_check_align entirely.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 53ca8f0114..c2a28be6d7 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2388,23 +2388,6 @@ static inline void gen_addr_add(DisasContext *ctx, TCGv ret, TCGv arg1,
     }
 }
 
-static inline void gen_check_align(DisasContext *ctx, TCGv EA, int mask)
-{
-    TCGLabel *l1 = gen_new_label();
-    TCGv t0 = tcg_temp_new();
-    TCGv_i32 t1, t2;
-    tcg_gen_andi_tl(t0, EA, mask);
-    tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0, l1);
-    t1 = tcg_const_i32(POWERPC_EXCP_ALIGN);
-    t2 = tcg_const_i32(ctx->opcode & 0x03FF0000);
-    gen_update_nip(ctx, ctx->base.pc_next - 4);
-    gen_helper_raise_exception_err(cpu_env, t1, t2);
-    tcg_temp_free_i32(t1);
-    tcg_temp_free_i32(t2);
-    gen_set_label(l1);
-    tcg_temp_free(t0);
-}
-
 static inline void gen_align_no_le(DisasContext *ctx)
 {
     gen_exception_err(ctx, POWERPC_EXCP_ALIGN,
@@ -4706,8 +4689,8 @@ static void gen_eciwx(DisasContext *ctx)
     gen_set_access_type(ctx, ACCESS_EXT);
     t0 = tcg_temp_new();
     gen_addr_reg_index(ctx, t0);
-    gen_check_align(ctx, t0, 0x03);
-    gen_qemu_ld32u(ctx, cpu_gpr[rD(ctx->opcode)], t0);
+    tcg_gen_qemu_ld_tl(cpu_gpr[rD(ctx->opcode)], t0, ctx->mem_idx,
+                       DEF_MEMOP(MO_UL | MO_ALIGN));
     tcg_temp_free(t0);
 }
 
@@ -4719,8 +4702,8 @@ static void gen_ecowx(DisasContext *ctx)
     gen_set_access_type(ctx, ACCESS_EXT);
     t0 = tcg_temp_new();
     gen_addr_reg_index(ctx, t0);
-    gen_check_align(ctx, t0, 0x03);
-    gen_qemu_st32(ctx, cpu_gpr[rD(ctx->opcode)], t0);
+    tcg_gen_qemu_st_tl(cpu_gpr[rD(ctx->opcode)], t0, ctx->mem_idx,
+                       DEF_MEMOP(MO_UL | MO_ALIGN));
     tcg_temp_free(t0);
 }
 
-- 
2.17.1
