Received: from eggs.gnu.org ([209.51.188.92]:38521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRm-0006lM-5u
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRj-00035R-44
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:22 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRi-00033z-UW
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:19 -0400
Received: by mail-pl1-x641.google.com with SMTP id e92so7750692plb.6
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:06:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 30 Apr 2019 22:05:33 -0700
Message-Id: <20190501050536.15580-27-richard.henderson@linaro.org>
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 26/29] target/ppc: Use tcg_gen_abs_tl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 68 +++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 44 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 8d08625c33..b5217f632f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -5075,40 +5075,26 @@ static void gen_ecowx(DisasContext *ctx)
 /* abs - abs. */
 static void gen_abs(DisasContext *ctx)
 {
-    TCGLabel *l1 = gen_new_label();
-    TCGLabel *l2 = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_GE, cpu_gpr[rA(ctx->opcode)], 0, l1);
-    tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_br(l2);
-    gen_set_label(l1);
-    tcg_gen_mov_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    gen_set_label(l2);
+    TCGv d = cpu_gpr[rD(ctx->opcode)];
+    TCGv a = cpu_gpr[rA(ctx->opcode)];
+
+    tcg_gen_abs_tl(d, a);
     if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+        gen_set_Rc0(ctx, d);
     }
 }
 
 /* abso - abso. */
 static void gen_abso(DisasContext *ctx)
 {
-    TCGLabel *l1 = gen_new_label();
-    TCGLabel *l2 = gen_new_label();
-    TCGLabel *l3 = gen_new_label();
-    /* Start with XER OV disabled, the most likely case */
-    tcg_gen_movi_tl(cpu_ov, 0);
-    tcg_gen_brcondi_tl(TCG_COND_GE, cpu_gpr[rA(ctx->opcode)], 0, l2);
-    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_gpr[rA(ctx->opcode)], 0x80000000, l1);
-    tcg_gen_movi_tl(cpu_ov, 1);
-    tcg_gen_movi_tl(cpu_so, 1);
-    tcg_gen_br(l2);
-    gen_set_label(l1);
-    tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_br(l3);
-    gen_set_label(l2);
-    tcg_gen_mov_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    gen_set_label(l3);
+    TCGv d = cpu_gpr[rD(ctx->opcode)];
+    TCGv a = cpu_gpr[rA(ctx->opcode)];
+
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_ov, a, 0x80000000);
+    tcg_gen_abs_tl(d, a);
+    tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
     if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+        gen_set_Rc0(ctx, d);
     }
 }
 
@@ -5344,34 +5330,28 @@ static void gen_mulo(DisasContext *ctx)
 /* nabs - nabs. */
 static void gen_nabs(DisasContext *ctx)
 {
-    TCGLabel *l1 = gen_new_label();
-    TCGLabel *l2 = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_GT, cpu_gpr[rA(ctx->opcode)], 0, l1);
-    tcg_gen_mov_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_br(l2);
-    gen_set_label(l1);
-    tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    gen_set_label(l2);
+    TCGv d = cpu_gpr[rD(ctx->opcode)];
+    TCGv a = cpu_gpr[rA(ctx->opcode)];
+
+    tcg_gen_abs_tl(d, a);
+    tcg_gen_neg_tl(d, d);
     if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+        gen_set_Rc0(ctx, d);
     }
 }
 
 /* nabso - nabso. */
 static void gen_nabso(DisasContext *ctx)
 {
-    TCGLabel *l1 = gen_new_label();
-    TCGLabel *l2 = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_GT, cpu_gpr[rA(ctx->opcode)], 0, l1);
-    tcg_gen_mov_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_br(l2);
-    gen_set_label(l1);
-    tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    gen_set_label(l2);
+    TCGv d = cpu_gpr[rD(ctx->opcode)];
+    TCGv a = cpu_gpr[rA(ctx->opcode)];
+
+    tcg_gen_abs_tl(d, a);
+    tcg_gen_neg_tl(d, d);
     /* nabs never overflows */
     tcg_gen_movi_tl(cpu_ov, 0);
     if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+        gen_set_Rc0(ctx, d);
     }
 }
 
-- 
2.17.1
