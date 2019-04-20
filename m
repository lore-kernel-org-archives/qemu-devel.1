Received: from eggs.gnu.org ([209.51.188.92]:40373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXG-0000gZ-IK
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXC-0000H0-0t
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:39 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXB-0008U2-Oj
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:37 -0400
Received: by mail-pl1-x642.google.com with SMTP id cv12so3533292plb.9
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 21:34:27 -1000
Message-Id: <20190420073442.7488-24-richard.henderson@linaro.org>
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 23/38] target/ppc: Use tcg_gen_abs_tl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 80 +++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 48 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index badc1ae1a3..97b8e8ddaf 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -5013,39 +5013,27 @@ static void gen_ecowx(DisasContext *ctx)
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
-    if (unlikely(Rc(ctx->opcode) != 0))
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    TCGv d = cpu_gpr[rD(ctx->opcode)];
+    TCGv a = cpu_gpr[rA(ctx->opcode)];
+
+    tcg_gen_abs_tl(d, a);
+    if (unlikely(Rc(ctx->opcode) != 0)) {
+        gen_set_Rc0(ctx, d);
+    }
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
-    if (unlikely(Rc(ctx->opcode) != 0))
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    TCGv d = cpu_gpr[rD(ctx->opcode)];
+    TCGv a = cpu_gpr[rA(ctx->opcode)];
+
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_ov, a, 0x80000000);
+    tcg_gen_abs_tl(d, a);
+    tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
+    if (unlikely(Rc(ctx->opcode) != 0)) {
+        gen_set_Rc0(ctx, d);
+    }
 }
 
 /* clcs */
@@ -5265,33 +5253,29 @@ static void gen_mulo(DisasContext *ctx)
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
-    if (unlikely(Rc(ctx->opcode) != 0))
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    TCGv d = cpu_gpr[rD(ctx->opcode)];
+    TCGv a = cpu_gpr[rA(ctx->opcode)];
+
+    tcg_gen_abs_tl(d, a);
+    tcg_gen_neg_tl(d, d);
+    if (unlikely(Rc(ctx->opcode) != 0)) {
+        gen_set_Rc0(ctx, d);
+    }
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
-    if (unlikely(Rc(ctx->opcode) != 0))
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    if (unlikely(Rc(ctx->opcode) != 0)) {
+        gen_set_Rc0(ctx, d);
+    }
 }
 
 /* rlmi - rlmi. */
-- 
2.17.1
