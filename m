Received: from eggs.gnu.org ([209.51.188.92]:47054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFcA-0006rk-8B
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:42:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFRS-0006K6-Nk
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:48 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goFRR-0006Dv-So
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:46 -0500
Received: by mail-oi1-x242.google.com with SMTP id u18so14489180oie.10
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:31:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 14:31:14 -0800
Message-Id: <20190128223118.5255-9-richard.henderson@linaro.org>
In-Reply-To: <20190128223118.5255-1-richard.henderson@linaro.org>
References: <20190128223118.5255-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 08/12] target/arm: Set btype for indirect
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index dbac09743c..89cc54dbed 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -138,6 +138,19 @@ static void reset_btype(DisasContext *s)
     }
 }
 
+static void set_btype(DisasContext *s, int val)
+{
+    TCGv_i32 tcg_val;
+
+    /* BTYPE is a 2-bit field, and 0 should be done with reset_btype.  */
+    tcg_debug_assert(val >= 1 && val <= 3);
+
+    tcg_val = tcg_const_i32(val);
+    tcg_gen_st_i32(tcg_val, cpu_env, offsetof(CPUARMState, btype));
+    tcg_temp_free_i32(tcg_val);
+    s->btype = -1;
+}
+
 void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
                             fprintf_function cpu_fprintf, int flags)
 {
@@ -1982,6 +1995,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
 static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
 {
     unsigned int opc, op2, op3, rn, op4;
+    unsigned btype_mod = 2;   /* 0: BR, 1: BLR, 2: other */
     TCGv_i64 dst;
     TCGv_i64 modifier;
 
@@ -1999,6 +2013,7 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
     case 0: /* BR */
     case 1: /* BLR */
     case 2: /* RET */
+        btype_mod = opc;
         switch (op3) {
         case 0:
             /* BR, BLR, RET */
@@ -2042,7 +2057,6 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
         default:
             goto do_unallocated;
         }
-
         gen_a64_set_pc(s, dst);
         /* BLR also needs to load return address */
         if (opc == 1) {
@@ -2058,6 +2072,7 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
         if (op3 != 2 || op3 != 3) {
             goto do_unallocated;
         }
+        btype_mod = opc & 1;
         if (s->pauth_active) {
             dst = new_tmp_a64(s);
             modifier = cpu_reg_sp(s, op4);
@@ -2141,6 +2156,26 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
         return;
     }
 
+    switch (btype_mod) {
+    case 0: /* BR */
+        if (dc_isar_feature(aa64_bti, s)) {
+            /* BR to {x16,x17} or !guard -> 1, else 3.  */
+            set_btype(s, rn == 16 || rn == 17 || !s->guarded_page ? 1 : 3);
+        }
+        break;
+
+    case 1: /* BLR */
+        if (dc_isar_feature(aa64_bti, s)) {
+            /* BLR sets BTYPE to 2, regardless of source guarded page.  */
+            set_btype(s, 2);
+        }
+        break;
+
+    default: /* RET or none of the above.  */
+        /* BTYPE will be set to 0 by normal end-of-insn processing.  */
+        break;
+    }
+
     s->base.is_jmp = DISAS_JUMP;
 }
 
-- 
2.17.2
