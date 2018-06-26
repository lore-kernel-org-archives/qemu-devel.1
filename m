Received: from eggs.gnu.org ([2001:4830:134:3::10]:42659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXqh0-00015w-FV
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXqgu-0005zH-PT
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:46 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:32934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXqgu-0005z2-KT
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:40 -0400
Received: by mail-pl0-x242.google.com with SMTP id 6-v6so8787362plb.0
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 09:19:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 09:19:18 -0700
Message-Id: <20180626161921.27941-11-richard.henderson@linaro.org>
In-Reply-To: <20180626161921.27941-1-richard.henderson@linaro.org>
References: <20180626161921.27941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 10/13] target/ppc: Use MO_ALIGN for EXIWX and
 ECOWX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This avoids the need for gen_check_align entirely.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
