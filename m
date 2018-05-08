Received: from eggs.gnu.org ([2001:4830:134:3::10]:43923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6TE-0008CT-QU
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6TA-0005Jl-8e
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:12 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fG6T9-0005JQ-LO
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:08 -0400
Received: by mail-lf0-x242.google.com with SMTP id r25-v6so3269788lfd.1
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 10:32:07 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  8 May 2018 19:31:23 +0200
Message-Id: <20180508173152.29327-8-edgar.iglesias@gmail.com>
In-Reply-To: <20180508173152.29327-1-edgar.iglesias@gmail.com>
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 07/36] target-microblaze: Tighten up
 TCGv_i32 vs TCGv type usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Tighten up TCGv_i32 vs TCGv type usage. Avoid using TCGv when
TCGv_i32 should be used.

This is in preparation for adding 64bit addressing support.
No functional change.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/helper.c    |   2 +-
 target/microblaze/translate.c | 581 +++++++++++++++++++++---------------------
 2 files changed, 295 insertions(+), 288 deletions(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index fac6ee9263..387d4aca5a 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -69,7 +69,7 @@ int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
 
     /* Translate if the MMU is available and enabled.  */
     if (mmu_available && (env->sregs[SR_MSR] & MSR_VM)) {
-        target_ulong vaddr, paddr;
+        uint32_t vaddr, paddr;
         struct microblaze_mmu_lookup lu;
 
         hit = mmu_translate(&env->mmu, &lu, address, rw, mmu_idx);
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 75079f18fa..7bda643b0f 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -52,22 +52,22 @@
 #define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
 #define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
 
-static TCGv env_debug;
-static TCGv cpu_R[32];
-static TCGv cpu_SR[14];
-static TCGv env_imm;
-static TCGv env_btaken;
-static TCGv env_btarget;
-static TCGv env_iflags;
-static TCGv env_res_addr;
-static TCGv env_res_val;
+static TCGv_i32 env_debug;
+static TCGv_i32 cpu_R[32];
+static TCGv_i32 cpu_SR[14];
+static TCGv_i32 env_imm;
+static TCGv_i32 env_btaken;
+static TCGv_i32 env_btarget;
+static TCGv_i32 env_iflags;
+static TCGv_i32 env_res_addr;
+static TCGv_i32 env_res_val;
 
 #include "exec/gen-icount.h"
 
 /* This is the state at translation time.  */
 typedef struct DisasContext {
     MicroBlazeCPU *cpu;
-    target_ulong pc;
+    uint32_t pc;
 
     /* Decoder.  */
     int type_b;
@@ -113,7 +113,7 @@ static inline void t_sync_flags(DisasContext *dc)
 {
     /* Synch the tb dependent flags between translator and runtime.  */
     if (dc->tb_flags != dc->synced_flags) {
-        tcg_gen_movi_tl(env_iflags, dc->tb_flags);
+        tcg_gen_movi_i32(env_iflags, dc->tb_flags);
         dc->synced_flags = dc->tb_flags;
     }
 }
@@ -123,7 +123,7 @@ static inline void t_gen_raise_exception(DisasContext *dc, uint32_t index)
     TCGv_i32 tmp = tcg_const_i32(index);
 
     t_sync_flags(dc);
-    tcg_gen_movi_tl(cpu_SR[SR_PC], dc->pc);
+    tcg_gen_movi_i32(cpu_SR[SR_PC], dc->pc);
     gen_helper_raise_exception(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
     dc->is_jmp = DISAS_UPDATE;
@@ -142,41 +142,41 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
 {
     if (use_goto_tb(dc, dest)) {
         tcg_gen_goto_tb(n);
-        tcg_gen_movi_tl(cpu_SR[SR_PC], dest);
+        tcg_gen_movi_i32(cpu_SR[SR_PC], dest);
         tcg_gen_exit_tb((uintptr_t)dc->tb + n);
     } else {
-        tcg_gen_movi_tl(cpu_SR[SR_PC], dest);
+        tcg_gen_movi_i32(cpu_SR[SR_PC], dest);
         tcg_gen_exit_tb(0);
     }
 }
 
-static void read_carry(DisasContext *dc, TCGv d)
+static void read_carry(DisasContext *dc, TCGv_i32 d)
 {
-    tcg_gen_shri_tl(d, cpu_SR[SR_MSR], 31);
+    tcg_gen_shri_i32(d, cpu_SR[SR_MSR], 31);
 }
 
 /*
  * write_carry sets the carry bits in MSR based on bit 0 of v.
  * v[31:1] are ignored.
  */
-static void write_carry(DisasContext *dc, TCGv v)
+static void write_carry(DisasContext *dc, TCGv_i32 v)
 {
-    TCGv t0 = tcg_temp_new();
-    tcg_gen_shli_tl(t0, v, 31);
-    tcg_gen_sari_tl(t0, t0, 31);
-    tcg_gen_andi_tl(t0, t0, (MSR_C | MSR_CC));
-    tcg_gen_andi_tl(cpu_SR[SR_MSR], cpu_SR[SR_MSR],
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    tcg_gen_shli_i32(t0, v, 31);
+    tcg_gen_sari_i32(t0, t0, 31);
+    tcg_gen_andi_i32(t0, t0, (MSR_C | MSR_CC));
+    tcg_gen_andi_i32(cpu_SR[SR_MSR], cpu_SR[SR_MSR],
                     ~(MSR_C | MSR_CC));
-    tcg_gen_or_tl(cpu_SR[SR_MSR], cpu_SR[SR_MSR], t0);
-    tcg_temp_free(t0);
+    tcg_gen_or_i32(cpu_SR[SR_MSR], cpu_SR[SR_MSR], t0);
+    tcg_temp_free_i32(t0);
 }
 
 static void write_carryi(DisasContext *dc, bool carry)
 {
-    TCGv t0 = tcg_temp_new();
-    tcg_gen_movi_tl(t0, carry);
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    tcg_gen_movi_i32(t0, carry);
     write_carry(dc, t0);
-    tcg_temp_free(t0);
+    tcg_temp_free_i32(t0);
 }
 
 /* True if ALU operand b is a small immediate that may deserve
@@ -187,13 +187,13 @@ static inline int dec_alu_op_b_is_small_imm(DisasContext *dc)
     return dc->type_b && !(dc->tb_flags & IMM_FLAG);
 }
 
-static inline TCGv *dec_alu_op_b(DisasContext *dc)
+static inline TCGv_i32 *dec_alu_op_b(DisasContext *dc)
 {
     if (dc->type_b) {
         if (dc->tb_flags & IMM_FLAG)
-            tcg_gen_ori_tl(env_imm, env_imm, dc->imm);
+            tcg_gen_ori_i32(env_imm, env_imm, dc->imm);
         else
-            tcg_gen_movi_tl(env_imm, (int32_t)((int16_t)dc->imm));
+            tcg_gen_movi_i32(env_imm, (int32_t)((int16_t)dc->imm));
         return &env_imm;
     } else
         return &cpu_R[dc->rb];
@@ -202,7 +202,7 @@ static inline TCGv *dec_alu_op_b(DisasContext *dc)
 static void dec_add(DisasContext *dc)
 {
     unsigned int k, c;
-    TCGv cf;
+    TCGv_i32 cf;
 
     k = dc->opcode & 4;
     c = dc->opcode & 2;
@@ -216,15 +216,15 @@ static void dec_add(DisasContext *dc)
         /* k - keep carry, no need to update MSR.  */
         /* If rd == r0, it's a nop.  */
         if (dc->rd) {
-            tcg_gen_add_tl(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
+            tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
 
             if (c) {
                 /* c - Add carry into the result.  */
-                cf = tcg_temp_new();
+                cf = tcg_temp_new_i32();
 
                 read_carry(dc, cf);
-                tcg_gen_add_tl(cpu_R[dc->rd], cpu_R[dc->rd], cf);
-                tcg_temp_free(cf);
+                tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->rd], cf);
+                tcg_temp_free_i32(cf);
             }
         }
         return;
@@ -232,31 +232,31 @@ static void dec_add(DisasContext *dc)
 
     /* From now on, we can assume k is zero.  So we need to update MSR.  */
     /* Extract carry.  */
-    cf = tcg_temp_new();
+    cf = tcg_temp_new_i32();
     if (c) {
         read_carry(dc, cf);
     } else {
-        tcg_gen_movi_tl(cf, 0);
+        tcg_gen_movi_i32(cf, 0);
     }
 
     if (dc->rd) {
-        TCGv ncf = tcg_temp_new();
+        TCGv_i32 ncf = tcg_temp_new_i32();
         gen_helper_carry(ncf, cpu_R[dc->ra], *(dec_alu_op_b(dc)), cf);
-        tcg_gen_add_tl(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
-        tcg_gen_add_tl(cpu_R[dc->rd], cpu_R[dc->rd], cf);
+        tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
+        tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->rd], cf);
         write_carry(dc, ncf);
-        tcg_temp_free(ncf);
+        tcg_temp_free_i32(ncf);
     } else {
         gen_helper_carry(cf, cpu_R[dc->ra], *(dec_alu_op_b(dc)), cf);
         write_carry(dc, cf);
     }
-    tcg_temp_free(cf);
+    tcg_temp_free_i32(cf);
 }
 
 static void dec_sub(DisasContext *dc)
 {
     unsigned int u, cmp, k, c;
-    TCGv cf, na;
+    TCGv_i32 cf, na;
 
     u = dc->imm & 2;
     k = dc->opcode & 4;
@@ -282,15 +282,15 @@ static void dec_sub(DisasContext *dc)
         /* k - keep carry, no need to update MSR.  */
         /* If rd == r0, it's a nop.  */
         if (dc->rd) {
-            tcg_gen_sub_tl(cpu_R[dc->rd], *(dec_alu_op_b(dc)), cpu_R[dc->ra]);
+            tcg_gen_sub_i32(cpu_R[dc->rd], *(dec_alu_op_b(dc)), cpu_R[dc->ra]);
 
             if (c) {
                 /* c - Add carry into the result.  */
-                cf = tcg_temp_new();
+                cf = tcg_temp_new_i32();
 
                 read_carry(dc, cf);
-                tcg_gen_add_tl(cpu_R[dc->rd], cpu_R[dc->rd], cf);
-                tcg_temp_free(cf);
+                tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->rd], cf);
+                tcg_temp_free_i32(cf);
             }
         }
         return;
@@ -298,30 +298,30 @@ static void dec_sub(DisasContext *dc)
 
     /* From now on, we can assume k is zero.  So we need to update MSR.  */
     /* Extract carry. And complement a into na.  */
-    cf = tcg_temp_new();
-    na = tcg_temp_new();
+    cf = tcg_temp_new_i32();
+    na = tcg_temp_new_i32();
     if (c) {
         read_carry(dc, cf);
     } else {
-        tcg_gen_movi_tl(cf, 1);
+        tcg_gen_movi_i32(cf, 1);
     }
 
     /* d = b + ~a + c. carry defaults to 1.  */
-    tcg_gen_not_tl(na, cpu_R[dc->ra]);
+    tcg_gen_not_i32(na, cpu_R[dc->ra]);
 
     if (dc->rd) {
-        TCGv ncf = tcg_temp_new();
+        TCGv_i32 ncf = tcg_temp_new_i32();
         gen_helper_carry(ncf, na, *(dec_alu_op_b(dc)), cf);
-        tcg_gen_add_tl(cpu_R[dc->rd], na, *(dec_alu_op_b(dc)));
-        tcg_gen_add_tl(cpu_R[dc->rd], cpu_R[dc->rd], cf);
+        tcg_gen_add_i32(cpu_R[dc->rd], na, *(dec_alu_op_b(dc)));
+        tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->rd], cf);
         write_carry(dc, ncf);
-        tcg_temp_free(ncf);
+        tcg_temp_free_i32(ncf);
     } else {
         gen_helper_carry(cf, na, *(dec_alu_op_b(dc)), cf);
         write_carry(dc, cf);
     }
-    tcg_temp_free(cf);
-    tcg_temp_free(na);
+    tcg_temp_free_i32(cf);
+    tcg_temp_free_i32(na);
 }
 
 static void dec_pattern(DisasContext *dc)
@@ -331,7 +331,7 @@ static void dec_pattern(DisasContext *dc)
     if ((dc->tb_flags & MSR_EE_FLAG)
           && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
           && !dc->cpu->cfg.use_pcmp_instr) {
-        tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
+        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
     }
 
@@ -346,14 +346,14 @@ static void dec_pattern(DisasContext *dc)
         case 2:
             LOG_DIS("pcmpeq r%d r%d r%d\n", dc->rd, dc->ra, dc->rb);
             if (dc->rd) {
-                tcg_gen_setcond_tl(TCG_COND_EQ, cpu_R[dc->rd],
+                tcg_gen_setcond_i32(TCG_COND_EQ, cpu_R[dc->rd],
                                    cpu_R[dc->ra], cpu_R[dc->rb]);
             }
             break;
         case 3:
             LOG_DIS("pcmpne r%d r%d r%d\n", dc->rd, dc->ra, dc->rb);
             if (dc->rd) {
-                tcg_gen_setcond_tl(TCG_COND_NE, cpu_R[dc->rd],
+                tcg_gen_setcond_i32(TCG_COND_NE, cpu_R[dc->rd],
                                    cpu_R[dc->ra], cpu_R[dc->rb]);
             }
             break;
@@ -380,9 +380,9 @@ static void dec_and(DisasContext *dc)
         return;
 
     if (not) {
-        tcg_gen_andc_tl(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
+        tcg_gen_andc_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
     } else
-        tcg_gen_and_tl(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
+        tcg_gen_and_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
 }
 
 static void dec_or(DisasContext *dc)
@@ -394,7 +394,7 @@ static void dec_or(DisasContext *dc)
 
     LOG_DIS("or r%d r%d r%d imm=%x\n", dc->rd, dc->ra, dc->rb, dc->imm);
     if (dc->rd)
-        tcg_gen_or_tl(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
+        tcg_gen_or_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
 }
 
 static void dec_xor(DisasContext *dc)
@@ -406,31 +406,31 @@ static void dec_xor(DisasContext *dc)
 
     LOG_DIS("xor r%d\n", dc->rd);
     if (dc->rd)
-        tcg_gen_xor_tl(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
+        tcg_gen_xor_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
 }
 
-static inline void msr_read(DisasContext *dc, TCGv d)
+static inline void msr_read(DisasContext *dc, TCGv_i32 d)
 {
-    tcg_gen_mov_tl(d, cpu_SR[SR_MSR]);
+    tcg_gen_mov_i32(d, cpu_SR[SR_MSR]);
 }
 
-static inline void msr_write(DisasContext *dc, TCGv v)
+static inline void msr_write(DisasContext *dc, TCGv_i32 v)
 {
-    TCGv t;
+    TCGv_i32 t;
 
-    t = tcg_temp_new();
+    t = tcg_temp_new_i32();
     dc->cpustate_changed = 1;
     /* PVR bit is not writable.  */
-    tcg_gen_andi_tl(t, v, ~MSR_PVR);
-    tcg_gen_andi_tl(cpu_SR[SR_MSR], cpu_SR[SR_MSR], MSR_PVR);
-    tcg_gen_or_tl(cpu_SR[SR_MSR], cpu_SR[SR_MSR], t);
+    tcg_gen_andi_i32(t, v, ~MSR_PVR);
+    tcg_gen_andi_i32(cpu_SR[SR_MSR], cpu_SR[SR_MSR], MSR_PVR);
+    tcg_gen_or_i32(cpu_SR[SR_MSR], cpu_SR[SR_MSR], t);
     tcg_temp_free(t);
 }
 
 static void dec_msr(DisasContext *dc)
 {
     CPUState *cs = CPU(dc->cpu);
-    TCGv t0, t1;
+    TCGv_i32 t0, t1;
     unsigned int sr, to, rn;
     int mem_index = cpu_mmu_index(&dc->cpu->env, false);
 
@@ -454,7 +454,7 @@ static void dec_msr(DisasContext *dc)
 
         if ((dc->tb_flags & MSR_EE_FLAG)
             && mem_index == MMU_USER_IDX && (dc->imm != 4 && dc->imm != 0)) {
-            tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
+            tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
             t_gen_raise_exception(dc, EXCP_HW_EXCP);
             return;
         }
@@ -462,20 +462,20 @@ static void dec_msr(DisasContext *dc)
         if (dc->rd)
             msr_read(dc, cpu_R[dc->rd]);
 
-        t0 = tcg_temp_new();
-        t1 = tcg_temp_new();
+        t0 = tcg_temp_new_i32();
+        t1 = tcg_temp_new_i32();
         msr_read(dc, t0);
-        tcg_gen_mov_tl(t1, *(dec_alu_op_b(dc)));
+        tcg_gen_mov_i32(t1, *(dec_alu_op_b(dc)));
 
         if (clr) {
-            tcg_gen_not_tl(t1, t1);
-            tcg_gen_and_tl(t0, t0, t1);
+            tcg_gen_not_i32(t1, t1);
+            tcg_gen_and_i32(t0, t0, t1);
         } else
-            tcg_gen_or_tl(t0, t0, t1);
+            tcg_gen_or_i32(t0, t0, t1);
         msr_write(dc, t0);
-        tcg_temp_free(t0);
-        tcg_temp_free(t1);
-	tcg_gen_movi_tl(cpu_SR[SR_PC], dc->pc + 4);
+        tcg_temp_free_i32(t0);
+        tcg_temp_free_i32(t1);
+        tcg_gen_movi_i32(cpu_SR[SR_PC], dc->pc + 4);
         dc->is_jmp = DISAS_UPDATE;
         return;
     }
@@ -483,7 +483,7 @@ static void dec_msr(DisasContext *dc)
     if (to) {
         if ((dc->tb_flags & MSR_EE_FLAG)
              && mem_index == MMU_USER_IDX) {
-            tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
+            tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
             t_gen_raise_exception(dc, EXCP_HW_EXCP);
             return;
         }
@@ -495,9 +495,9 @@ static void dec_msr(DisasContext *dc)
         sr &= 7;
         LOG_DIS("m%ss sr%d r%d imm=%x\n", to ? "t" : "f", sr, dc->ra, dc->imm);
         if (to)
-            gen_helper_mmu_write(cpu_env, tcg_const_tl(sr), cpu_R[dc->ra]);
+            gen_helper_mmu_write(cpu_env, tcg_const_i32(sr), cpu_R[dc->ra]);
         else
-            gen_helper_mmu_read(cpu_R[dc->rd], cpu_env, tcg_const_tl(sr));
+            gen_helper_mmu_read(cpu_R[dc->rd], cpu_env, tcg_const_i32(sr));
         return;
     }
 #endif
@@ -511,19 +511,21 @@ static void dec_msr(DisasContext *dc)
                 msr_write(dc, cpu_R[dc->ra]);
                 break;
             case 0x3:
-                tcg_gen_mov_tl(cpu_SR[SR_EAR], cpu_R[dc->ra]);
+                tcg_gen_mov_i32(cpu_SR[SR_EAR], cpu_R[dc->ra]);
                 break;
             case 0x5:
-                tcg_gen_mov_tl(cpu_SR[SR_ESR], cpu_R[dc->ra]);
+                tcg_gen_mov_i32(cpu_SR[SR_ESR], cpu_R[dc->ra]);
                 break;
             case 0x7:
-                tcg_gen_andi_tl(cpu_SR[SR_FSR], cpu_R[dc->ra], 31);
+                tcg_gen_andi_i32(cpu_SR[SR_FSR], cpu_R[dc->ra], 31);
                 break;
             case 0x800:
-                tcg_gen_st_tl(cpu_R[dc->ra], cpu_env, offsetof(CPUMBState, slr));
+                tcg_gen_st_i32(cpu_R[dc->ra],
+                               cpu_env, offsetof(CPUMBState, slr));
                 break;
             case 0x802:
-                tcg_gen_st_tl(cpu_R[dc->ra], cpu_env, offsetof(CPUMBState, shr));
+                tcg_gen_st_i32(cpu_R[dc->ra],
+                               cpu_env, offsetof(CPUMBState, shr));
                 break;
             default:
                 cpu_abort(CPU(dc->cpu), "unknown mts reg %x\n", sr);
@@ -534,28 +536,30 @@ static void dec_msr(DisasContext *dc)
 
         switch (sr) {
             case 0:
-                tcg_gen_movi_tl(cpu_R[dc->rd], dc->pc);
+                tcg_gen_movi_i32(cpu_R[dc->rd], dc->pc);
                 break;
             case 1:
                 msr_read(dc, cpu_R[dc->rd]);
                 break;
             case 0x3:
-                tcg_gen_mov_tl(cpu_R[dc->rd], cpu_SR[SR_EAR]);
+                tcg_gen_mov_i32(cpu_R[dc->rd], cpu_SR[SR_EAR]);
                 break;
             case 0x5:
-                tcg_gen_mov_tl(cpu_R[dc->rd], cpu_SR[SR_ESR]);
+                tcg_gen_mov_i32(cpu_R[dc->rd], cpu_SR[SR_ESR]);
                 break;
              case 0x7:
-                tcg_gen_mov_tl(cpu_R[dc->rd], cpu_SR[SR_FSR]);
+                tcg_gen_mov_i32(cpu_R[dc->rd], cpu_SR[SR_FSR]);
                 break;
             case 0xb:
-                tcg_gen_mov_tl(cpu_R[dc->rd], cpu_SR[SR_BTR]);
+                tcg_gen_mov_i32(cpu_R[dc->rd], cpu_SR[SR_BTR]);
                 break;
             case 0x800:
-                tcg_gen_ld_tl(cpu_R[dc->rd], cpu_env, offsetof(CPUMBState, slr));
+                tcg_gen_ld_i32(cpu_R[dc->rd],
+                               cpu_env, offsetof(CPUMBState, slr));
                 break;
             case 0x802:
-                tcg_gen_ld_tl(cpu_R[dc->rd], cpu_env, offsetof(CPUMBState, shr));
+                tcg_gen_ld_i32(cpu_R[dc->rd],
+                               cpu_env, offsetof(CPUMBState, shr));
                 break;
             case 0x2000:
             case 0x2001:
@@ -571,7 +575,7 @@ static void dec_msr(DisasContext *dc)
             case 0x200b:
             case 0x200c:
                 rn = sr & 0xf;
-                tcg_gen_ld_tl(cpu_R[dc->rd],
+                tcg_gen_ld_i32(cpu_R[dc->rd],
                               cpu_env, offsetof(CPUMBState, pvr.regs[rn]));
                 break;
             default:
@@ -581,20 +585,20 @@ static void dec_msr(DisasContext *dc)
     }
 
     if (dc->rd == 0) {
-        tcg_gen_movi_tl(cpu_R[0], 0);
+        tcg_gen_movi_i32(cpu_R[0], 0);
     }
 }
 
 /* Multiplier unit.  */
 static void dec_mul(DisasContext *dc)
 {
-    TCGv tmp;
+    TCGv_i32 tmp;
     unsigned int subcode;
 
     if ((dc->tb_flags & MSR_EE_FLAG)
          && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
          && !dc->cpu->cfg.use_hw_mul) {
-        tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
+        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
         return;
     }
@@ -603,7 +607,7 @@ static void dec_mul(DisasContext *dc)
 
     if (dc->type_b) {
         LOG_DIS("muli r%d r%d %x\n", dc->rd, dc->ra, dc->imm);
-        tcg_gen_mul_tl(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
+        tcg_gen_mul_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
         return;
     }
 
@@ -612,29 +616,31 @@ static void dec_mul(DisasContext *dc)
         /* nop??? */
     }
 
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i32();
     switch (subcode) {
         case 0:
             LOG_DIS("mul r%d r%d r%d\n", dc->rd, dc->ra, dc->rb);
-            tcg_gen_mul_tl(cpu_R[dc->rd], cpu_R[dc->ra], cpu_R[dc->rb]);
+            tcg_gen_mul_i32(cpu_R[dc->rd], cpu_R[dc->ra], cpu_R[dc->rb]);
             break;
         case 1:
             LOG_DIS("mulh r%d r%d r%d\n", dc->rd, dc->ra, dc->rb);
-            tcg_gen_muls2_tl(tmp, cpu_R[dc->rd], cpu_R[dc->ra], cpu_R[dc->rb]);
+            tcg_gen_muls2_i32(tmp, cpu_R[dc->rd],
+                              cpu_R[dc->ra], cpu_R[dc->rb]);
             break;
         case 2:
             LOG_DIS("mulhsu r%d r%d r%d\n", dc->rd, dc->ra, dc->rb);
-            tcg_gen_mulsu2_tl(tmp, cpu_R[dc->rd], cpu_R[dc->ra], cpu_R[dc->rb]);
+            tcg_gen_mulsu2_i32(tmp, cpu_R[dc->rd],
+                               cpu_R[dc->ra], cpu_R[dc->rb]);
             break;
         case 3:
             LOG_DIS("mulhu r%d r%d r%d\n", dc->rd, dc->ra, dc->rb);
-            tcg_gen_mulu2_tl(tmp, cpu_R[dc->rd], cpu_R[dc->ra], cpu_R[dc->rb]);
+            tcg_gen_mulu2_i32(tmp, cpu_R[dc->rd], cpu_R[dc->ra], cpu_R[dc->rb]);
             break;
         default:
             cpu_abort(CPU(dc->cpu), "unknown MUL insn %x\n", subcode);
             break;
     }
-    tcg_temp_free(tmp);
+    tcg_temp_free_i32(tmp);
 }
 
 /* Div unit.  */
@@ -647,7 +653,7 @@ static void dec_div(DisasContext *dc)
 
     if ((dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
           && !dc->cpu->cfg.use_div) {
-        tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
+        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
     }
 
@@ -658,19 +664,19 @@ static void dec_div(DisasContext *dc)
         gen_helper_divs(cpu_R[dc->rd], cpu_env, *(dec_alu_op_b(dc)),
                         cpu_R[dc->ra]);
     if (!dc->rd)
-        tcg_gen_movi_tl(cpu_R[dc->rd], 0);
+        tcg_gen_movi_i32(cpu_R[dc->rd], 0);
 }
 
 static void dec_barrel(DisasContext *dc)
 {
-    TCGv t0;
+    TCGv_i32 t0;
     unsigned int imm_w, imm_s;
     bool s, t, e = false, i = false;
 
     if ((dc->tb_flags & MSR_EE_FLAG)
           && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
           && !dc->cpu->cfg.use_barrel) {
-        tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
+        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
         return;
     }
@@ -709,28 +715,28 @@ static void dec_barrel(DisasContext *dc)
                                 imm_s, width);
         }
     } else {
-        t0 = tcg_temp_new();
+        t0 = tcg_temp_new_i32();
 
-        tcg_gen_mov_tl(t0, *(dec_alu_op_b(dc)));
-        tcg_gen_andi_tl(t0, t0, 31);
+        tcg_gen_mov_i32(t0, *(dec_alu_op_b(dc)));
+        tcg_gen_andi_i32(t0, t0, 31);
 
         if (s) {
-            tcg_gen_shl_tl(cpu_R[dc->rd], cpu_R[dc->ra], t0);
+            tcg_gen_shl_i32(cpu_R[dc->rd], cpu_R[dc->ra], t0);
         } else {
             if (t) {
-                tcg_gen_sar_tl(cpu_R[dc->rd], cpu_R[dc->ra], t0);
+                tcg_gen_sar_i32(cpu_R[dc->rd], cpu_R[dc->ra], t0);
             } else {
-                tcg_gen_shr_tl(cpu_R[dc->rd], cpu_R[dc->ra], t0);
+                tcg_gen_shr_i32(cpu_R[dc->rd], cpu_R[dc->ra], t0);
             }
         }
-        tcg_temp_free(t0);
+        tcg_temp_free_i32(t0);
     }
 }
 
 static void dec_bit(DisasContext *dc)
 {
     CPUState *cs = CPU(dc->cpu);
-    TCGv t0;
+    TCGv_i32 t0;
     unsigned int op;
     int mem_index = cpu_mmu_index(&dc->cpu->env, false);
 
@@ -738,16 +744,16 @@ static void dec_bit(DisasContext *dc)
     switch (op) {
         case 0x21:
             /* src.  */
-            t0 = tcg_temp_new();
+            t0 = tcg_temp_new_i32();
 
             LOG_DIS("src r%d r%d\n", dc->rd, dc->ra);
-            tcg_gen_andi_tl(t0, cpu_SR[SR_MSR], MSR_CC);
+            tcg_gen_andi_i32(t0, cpu_SR[SR_MSR], MSR_CC);
             write_carry(dc, cpu_R[dc->ra]);
             if (dc->rd) {
-                tcg_gen_shri_tl(cpu_R[dc->rd], cpu_R[dc->ra], 1);
-                tcg_gen_or_tl(cpu_R[dc->rd], cpu_R[dc->rd], t0);
+                tcg_gen_shri_i32(cpu_R[dc->rd], cpu_R[dc->ra], 1);
+                tcg_gen_or_i32(cpu_R[dc->rd], cpu_R[dc->rd], t0);
             }
-            tcg_temp_free(t0);
+            tcg_temp_free_i32(t0);
             break;
 
         case 0x1:
@@ -759,9 +765,9 @@ static void dec_bit(DisasContext *dc)
             write_carry(dc, cpu_R[dc->ra]);
             if (dc->rd) {
                 if (op == 0x41)
-                    tcg_gen_shri_tl(cpu_R[dc->rd], cpu_R[dc->ra], 1);
+                    tcg_gen_shri_i32(cpu_R[dc->rd], cpu_R[dc->ra], 1);
                 else
-                    tcg_gen_sari_tl(cpu_R[dc->rd], cpu_R[dc->ra], 1);
+                    tcg_gen_sari_i32(cpu_R[dc->rd], cpu_R[dc->ra], 1);
             }
             break;
         case 0x60:
@@ -780,7 +786,7 @@ static void dec_bit(DisasContext *dc)
             LOG_DIS("wdc r%d\n", dc->ra);
             if ((dc->tb_flags & MSR_EE_FLAG)
                  && mem_index == MMU_USER_IDX) {
-                tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
+                tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
                 t_gen_raise_exception(dc, EXCP_HW_EXCP);
                 return;
             }
@@ -790,7 +796,7 @@ static void dec_bit(DisasContext *dc)
             LOG_DIS("wic r%d\n", dc->ra);
             if ((dc->tb_flags & MSR_EE_FLAG)
                  && mem_index == MMU_USER_IDX) {
-                tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
+                tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
                 t_gen_raise_exception(dc, EXCP_HW_EXCP);
                 return;
             }
@@ -799,7 +805,7 @@ static void dec_bit(DisasContext *dc)
             if ((dc->tb_flags & MSR_EE_FLAG)
                 && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
                 && !dc->cpu->cfg.use_pcmp_instr) {
-                tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
+                tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
                 t_gen_raise_exception(dc, EXCP_HW_EXCP);
             }
             if (dc->cpu->cfg.use_pcmp_instr) {
@@ -827,22 +833,22 @@ static inline void sync_jmpstate(DisasContext *dc)
 {
     if (dc->jmp == JMP_DIRECT || dc->jmp == JMP_DIRECT_CC) {
         if (dc->jmp == JMP_DIRECT) {
-            tcg_gen_movi_tl(env_btaken, 1);
+            tcg_gen_movi_i32(env_btaken, 1);
         }
         dc->jmp = JMP_INDIRECT;
-        tcg_gen_movi_tl(env_btarget, dc->jmp_pc);
+        tcg_gen_movi_i32(env_btarget, dc->jmp_pc);
     }
 }
 
 static void dec_imm(DisasContext *dc)
 {
     LOG_DIS("imm %x\n", dc->imm << 16);
-    tcg_gen_movi_tl(env_imm, (dc->imm << 16));
+    tcg_gen_movi_i32(env_imm, (dc->imm << 16));
     dc->tb_flags |= IMM_FLAG;
     dc->clear_imm = 0;
 }
 
-static inline TCGv *compute_ldst_addr(DisasContext *dc, TCGv *t)
+static inline TCGv_i32 *compute_ldst_addr(DisasContext *dc, TCGv_i32 *t)
 {
     bool extimm = dc->tb_flags & IMM_FLAG;
     /* Should be set to true if r1 is used by loadstores.  */
@@ -866,8 +872,8 @@ static inline TCGv *compute_ldst_addr(DisasContext *dc, TCGv *t)
             stackprot = true;
         }
 
-        *t = tcg_temp_new();
-        tcg_gen_add_tl(*t, cpu_R[dc->ra], cpu_R[dc->rb]);
+        *t = tcg_temp_new_i32();
+        tcg_gen_add_i32(*t, cpu_R[dc->ra], cpu_R[dc->rb]);
 
         if (stackprot) {
             gen_helper_stackprot(cpu_env, *t);
@@ -879,12 +885,12 @@ static inline TCGv *compute_ldst_addr(DisasContext *dc, TCGv *t)
         if (dc->imm == 0) {
             return &cpu_R[dc->ra];
         }
-        *t = tcg_temp_new();
-        tcg_gen_movi_tl(*t, (int32_t)((int16_t)dc->imm));
-        tcg_gen_add_tl(*t, cpu_R[dc->ra], *t);
+        *t = tcg_temp_new_i32();
+        tcg_gen_movi_i32(*t, (int32_t)((int16_t)dc->imm));
+        tcg_gen_add_i32(*t, cpu_R[dc->ra], *t);
     } else {
-        *t = tcg_temp_new();
-        tcg_gen_add_tl(*t, cpu_R[dc->ra], *(dec_alu_op_b(dc)));
+        *t = tcg_temp_new_i32();
+        tcg_gen_add_i32(*t, cpu_R[dc->ra], *(dec_alu_op_b(dc)));
     }
 
     if (stackprot) {
@@ -895,7 +901,7 @@ static inline TCGv *compute_ldst_addr(DisasContext *dc, TCGv *t)
 
 static void dec_load(DisasContext *dc)
 {
-    TCGv t, v, *addr;
+    TCGv_i32 t, v, *addr;
     unsigned int size;
     bool rev = false, ex = false;
     TCGMemOp mop;
@@ -913,7 +919,7 @@ static void dec_load(DisasContext *dc)
 
     if (size > 4 && (dc->tb_flags & MSR_EE_FLAG)
           && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)) {
-        tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
+        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
         return;
     }
@@ -939,20 +945,20 @@ static void dec_load(DisasContext *dc)
                    01 -> 10
                    10 -> 10
                    11 -> 00 */
-                TCGv low = tcg_temp_new();
+                TCGv_i32 low = tcg_temp_new_i32();
 
                 /* Force addr into the temp.  */
                 if (addr != &t) {
-                    t = tcg_temp_new();
-                    tcg_gen_mov_tl(t, *addr);
+                    t = tcg_temp_new_i32();
+                    tcg_gen_mov_i32(t, *addr);
                     addr = &t;
                 }
 
-                tcg_gen_andi_tl(low, t, 3);
-                tcg_gen_sub_tl(low, tcg_const_tl(3), low);
-                tcg_gen_andi_tl(t, t, ~3);
-                tcg_gen_or_tl(t, t, low);
-                tcg_temp_free(low);
+                tcg_gen_andi_i32(low, t, 3);
+                tcg_gen_sub_i32(low, tcg_const_i32(3), low);
+                tcg_gen_andi_i32(t, t, ~3);
+                tcg_gen_or_i32(t, t, low);
+                tcg_temp_free_i32(low);
                 break;
             }
 
@@ -961,11 +967,11 @@ static void dec_load(DisasContext *dc)
                    10 -> 00.  */
                 /* Force addr into the temp.  */
                 if (addr != &t) {
-                    t = tcg_temp_new();
-                    tcg_gen_xori_tl(t, *addr, 2);
+                    t = tcg_temp_new_i32();
+                    tcg_gen_xori_i32(t, *addr, 2);
                     addr = &t;
                 } else {
-                    tcg_gen_xori_tl(t, t, 2);
+                    tcg_gen_xori_i32(t, t, 2);
                 }
                 break;
             default:
@@ -978,11 +984,11 @@ static void dec_load(DisasContext *dc)
     if (ex) {
         /* Force addr into the temp.  */
         if (addr != &t) {
-            t = tcg_temp_new();
-            tcg_gen_mov_tl(t, *addr);
+            t = tcg_temp_new_i32();
+            tcg_gen_mov_i32(t, *addr);
             addr = &t;
         }
-        tcg_gen_andi_tl(t, t, ~3);
+        tcg_gen_andi_i32(t, t, ~3);
     }
 
     /* If we get a fault on a dslot, the jmpstate better be in sync.  */
@@ -995,23 +1001,23 @@ static void dec_load(DisasContext *dc)
      * into v. If the load succeeds, we verify alignment of the
      * address and if that succeeds we write into the destination reg.
      */
-    v = tcg_temp_new();
-    tcg_gen_qemu_ld_tl(v, *addr, cpu_mmu_index(&dc->cpu->env, false), mop);
+    v = tcg_temp_new_i32();
+    tcg_gen_qemu_ld_i32(v, *addr, cpu_mmu_index(&dc->cpu->env, false), mop);
 
     if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
-        tcg_gen_movi_tl(cpu_SR[SR_PC], dc->pc);
-        gen_helper_memalign(cpu_env, *addr, tcg_const_tl(dc->rd),
-                            tcg_const_tl(0), tcg_const_tl(size - 1));
+        tcg_gen_movi_i32(cpu_SR[SR_PC], dc->pc);
+        gen_helper_memalign(cpu_env, *addr, tcg_const_i32(dc->rd),
+                            tcg_const_i32(0), tcg_const_i32(size - 1));
     }
 
     if (ex) {
-        tcg_gen_mov_tl(env_res_addr, *addr);
-        tcg_gen_mov_tl(env_res_val, v);
+        tcg_gen_mov_i32(env_res_addr, *addr);
+        tcg_gen_mov_i32(env_res_val, v);
     }
     if (dc->rd) {
-        tcg_gen_mov_tl(cpu_R[dc->rd], v);
+        tcg_gen_mov_i32(cpu_R[dc->rd], v);
     }
-    tcg_temp_free(v);
+    tcg_temp_free_i32(v);
 
     if (ex) { /* lwx */
         /* no support for AXI exclusive so always clear C */
@@ -1019,12 +1025,12 @@ static void dec_load(DisasContext *dc)
     }
 
     if (addr == &t)
-        tcg_temp_free(t);
+        tcg_temp_free_i32(t);
 }
 
 static void dec_store(DisasContext *dc)
 {
-    TCGv t, *addr, swx_addr;
+    TCGv_i32 t, *addr, swx_addr;
     TCGLabel *swx_skip = NULL;
     unsigned int size;
     bool rev = false, ex = false;
@@ -1043,7 +1049,7 @@ static void dec_store(DisasContext *dc)
 
     if (size > 4 && (dc->tb_flags & MSR_EE_FLAG)
           && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)) {
-        tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
+        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
         return;
     }
@@ -1055,31 +1061,31 @@ static void dec_store(DisasContext *dc)
     sync_jmpstate(dc);
     addr = compute_ldst_addr(dc, &t);
 
-    swx_addr = tcg_temp_local_new();
+    swx_addr = tcg_temp_local_new_i32();
     if (ex) { /* swx */
-        TCGv tval;
+        TCGv_i32 tval;
 
         /* Force addr into the swx_addr. */
-        tcg_gen_mov_tl(swx_addr, *addr);
+        tcg_gen_mov_i32(swx_addr, *addr);
         addr = &swx_addr;
         /* swx does not throw unaligned access errors, so force alignment */
-        tcg_gen_andi_tl(swx_addr, swx_addr, ~3);
+        tcg_gen_andi_i32(swx_addr, swx_addr, ~3);
 
         write_carryi(dc, 1);
         swx_skip = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_NE, env_res_addr, swx_addr, swx_skip);
+        tcg_gen_brcond_i32(TCG_COND_NE, env_res_addr, swx_addr, swx_skip);
 
         /* Compare the value loaded at lwx with current contents of
            the reserved location.
            FIXME: This only works for system emulation where we can expect
            this compare and the following write to be atomic. For user
            emulation we need to add atomicity between threads.  */
-        tval = tcg_temp_new();
-        tcg_gen_qemu_ld_tl(tval, swx_addr, cpu_mmu_index(&dc->cpu->env, false),
+        tval = tcg_temp_new_i32();
+        tcg_gen_qemu_ld_i32(tval, swx_addr, cpu_mmu_index(&dc->cpu->env, false),
                            MO_TEUL);
-        tcg_gen_brcond_tl(TCG_COND_NE, env_res_val, tval, swx_skip);
+        tcg_gen_brcond_i32(TCG_COND_NE, env_res_val, tval, swx_skip);
         write_carryi(dc, 0);
-        tcg_temp_free(tval);
+        tcg_temp_free_i32(tval);
     }
 
     if (rev && size != 4) {
@@ -1091,20 +1097,20 @@ static void dec_store(DisasContext *dc)
                    01 -> 10
                    10 -> 10
                    11 -> 00 */
-                TCGv low = tcg_temp_new();
+                TCGv_i32 low = tcg_temp_new_i32();
 
                 /* Force addr into the temp.  */
                 if (addr != &t) {
-                    t = tcg_temp_new();
-                    tcg_gen_mov_tl(t, *addr);
+                    t = tcg_temp_new_i32();
+                    tcg_gen_mov_i32(t, *addr);
                     addr = &t;
                 }
 
-                tcg_gen_andi_tl(low, t, 3);
-                tcg_gen_sub_tl(low, tcg_const_tl(3), low);
-                tcg_gen_andi_tl(t, t, ~3);
-                tcg_gen_or_tl(t, t, low);
-                tcg_temp_free(low);
+                tcg_gen_andi_i32(low, t, 3);
+                tcg_gen_sub_i32(low, tcg_const_i32(3), low);
+                tcg_gen_andi_i32(t, t, ~3);
+                tcg_gen_or_i32(t, t, low);
+                tcg_temp_free_i32(low);
                 break;
             }
 
@@ -1113,11 +1119,11 @@ static void dec_store(DisasContext *dc)
                    10 -> 00.  */
                 /* Force addr into the temp.  */
                 if (addr != &t) {
-                    t = tcg_temp_new();
-                    tcg_gen_xori_tl(t, *addr, 2);
+                    t = tcg_temp_new_i32();
+                    tcg_gen_xori_i32(t, *addr, 2);
                     addr = &t;
                 } else {
-                    tcg_gen_xori_tl(t, t, 2);
+                    tcg_gen_xori_i32(t, t, 2);
                 }
                 break;
             default:
@@ -1125,51 +1131,52 @@ static void dec_store(DisasContext *dc)
                 break;
         }
     }
-    tcg_gen_qemu_st_tl(cpu_R[dc->rd], *addr, cpu_mmu_index(&dc->cpu->env, false), mop);
+    tcg_gen_qemu_st_i32(cpu_R[dc->rd], *addr,
+                        cpu_mmu_index(&dc->cpu->env, false), mop);
 
     /* Verify alignment if needed.  */
     if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
-        tcg_gen_movi_tl(cpu_SR[SR_PC], dc->pc);
+        tcg_gen_movi_i32(cpu_SR[SR_PC], dc->pc);
         /* FIXME: if the alignment is wrong, we should restore the value
          *        in memory. One possible way to achieve this is to probe
          *        the MMU prior to the memaccess, thay way we could put
          *        the alignment checks in between the probe and the mem
          *        access.
          */
-        gen_helper_memalign(cpu_env, *addr, tcg_const_tl(dc->rd),
-                            tcg_const_tl(1), tcg_const_tl(size - 1));
+        gen_helper_memalign(cpu_env, *addr, tcg_const_i32(dc->rd),
+                            tcg_const_i32(1), tcg_const_i32(size - 1));
     }
 
     if (ex) {
         gen_set_label(swx_skip);
     }
-    tcg_temp_free(swx_addr);
+    tcg_temp_free_i32(swx_addr);
 
     if (addr == &t)
-        tcg_temp_free(t);
+        tcg_temp_free_i32(t);
 }
 
 static inline void eval_cc(DisasContext *dc, unsigned int cc,
-                           TCGv d, TCGv a, TCGv b)
+                           TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
 {
     switch (cc) {
         case CC_EQ:
-            tcg_gen_setcond_tl(TCG_COND_EQ, d, a, b);
+            tcg_gen_setcond_i32(TCG_COND_EQ, d, a, b);
             break;
         case CC_NE:
-            tcg_gen_setcond_tl(TCG_COND_NE, d, a, b);
+            tcg_gen_setcond_i32(TCG_COND_NE, d, a, b);
             break;
         case CC_LT:
-            tcg_gen_setcond_tl(TCG_COND_LT, d, a, b);
+            tcg_gen_setcond_i32(TCG_COND_LT, d, a, b);
             break;
         case CC_LE:
-            tcg_gen_setcond_tl(TCG_COND_LE, d, a, b);
+            tcg_gen_setcond_i32(TCG_COND_LE, d, a, b);
             break;
         case CC_GE:
-            tcg_gen_setcond_tl(TCG_COND_GE, d, a, b);
+            tcg_gen_setcond_i32(TCG_COND_GE, d, a, b);
             break;
         case CC_GT:
-            tcg_gen_setcond_tl(TCG_COND_GT, d, a, b);
+            tcg_gen_setcond_i32(TCG_COND_GT, d, a, b);
             break;
         default:
             cpu_abort(CPU(dc->cpu), "Unknown condition code %x.\n", cc);
@@ -1177,13 +1184,13 @@ static inline void eval_cc(DisasContext *dc, unsigned int cc,
     }
 }
 
-static void eval_cond_jmp(DisasContext *dc, TCGv pc_true, TCGv pc_false)
+static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i32 pc_false)
 {
     TCGLabel *l1 = gen_new_label();
     /* Conditional jmp.  */
-    tcg_gen_mov_tl(cpu_SR[SR_PC], pc_false);
-    tcg_gen_brcondi_tl(TCG_COND_EQ, env_btaken, 0, l1);
-    tcg_gen_mov_tl(cpu_SR[SR_PC], pc_true);
+    tcg_gen_mov_i32(cpu_SR[SR_PC], pc_false);
+    tcg_gen_brcondi_i32(TCG_COND_EQ, env_btaken, 0, l1);
+    tcg_gen_mov_i32(cpu_SR[SR_PC], pc_true);
     gen_set_label(l1);
 }
 
@@ -1200,22 +1207,22 @@ static void dec_bcc(DisasContext *dc)
     if (dslot) {
         dc->delayed_branch = 2;
         dc->tb_flags |= D_FLAG;
-        tcg_gen_st_tl(tcg_const_tl(dc->type_b && (dc->tb_flags & IMM_FLAG)),
+        tcg_gen_st_i32(tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG)),
                       cpu_env, offsetof(CPUMBState, bimm));
     }
 
     if (dec_alu_op_b_is_small_imm(dc)) {
         int32_t offset = (int32_t)((int16_t)dc->imm); /* sign-extend.  */
 
-        tcg_gen_movi_tl(env_btarget, dc->pc + offset);
+        tcg_gen_movi_i32(env_btarget, dc->pc + offset);
         dc->jmp = JMP_DIRECT_CC;
         dc->jmp_pc = dc->pc + offset;
     } else {
         dc->jmp = JMP_INDIRECT;
-        tcg_gen_movi_tl(env_btarget, dc->pc);
-        tcg_gen_add_tl(env_btarget, env_btarget, *(dec_alu_op_b(dc)));
+        tcg_gen_movi_i32(env_btarget, dc->pc);
+        tcg_gen_add_i32(env_btarget, env_btarget, *(dec_alu_op_b(dc)));
     }
-    eval_cc(dc, cc, env_btaken, cpu_R[dc->ra], tcg_const_tl(0));
+    eval_cc(dc, cc, env_btaken, cpu_R[dc->ra], tcg_const_i32(0));
 }
 
 static void dec_br(DisasContext *dc)
@@ -1241,7 +1248,7 @@ static void dec_br(DisasContext *dc)
             tcg_gen_st_i32(tmp_1, cpu_env,
                            -offsetof(MicroBlazeCPU, env)
                            +offsetof(CPUState, halted));
-            tcg_gen_movi_tl(cpu_SR[SR_PC], dc->pc + 4);
+            tcg_gen_movi_i32(cpu_SR[SR_PC], dc->pc + 4);
             gen_helper_raise_exception(cpu_env, tmp_hlt);
             tcg_temp_free_i32(tmp_hlt);
             tcg_temp_free_i32(tmp_1);
@@ -1262,22 +1269,22 @@ static void dec_br(DisasContext *dc)
     if (dslot) {
         dc->delayed_branch = 2;
         dc->tb_flags |= D_FLAG;
-        tcg_gen_st_tl(tcg_const_tl(dc->type_b && (dc->tb_flags & IMM_FLAG)),
+        tcg_gen_st_i32(tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG)),
                       cpu_env, offsetof(CPUMBState, bimm));
     }
     if (link && dc->rd)
-        tcg_gen_movi_tl(cpu_R[dc->rd], dc->pc);
+        tcg_gen_movi_i32(cpu_R[dc->rd], dc->pc);
 
     dc->jmp = JMP_INDIRECT;
     if (abs) {
-        tcg_gen_movi_tl(env_btaken, 1);
-        tcg_gen_mov_tl(env_btarget, *(dec_alu_op_b(dc)));
+        tcg_gen_movi_i32(env_btaken, 1);
+        tcg_gen_mov_i32(env_btarget, *(dec_alu_op_b(dc)));
         if (link && !dslot) {
             if (!(dc->tb_flags & IMM_FLAG) && (dc->imm == 8 || dc->imm == 0x18))
                 t_gen_raise_exception(dc, EXCP_BREAK);
             if (dc->imm == 0) {
                 if ((dc->tb_flags & MSR_EE_FLAG) && mem_index == MMU_USER_IDX) {
-                    tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
+                    tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
                     t_gen_raise_exception(dc, EXCP_HW_EXCP);
                     return;
                 }
@@ -1290,63 +1297,63 @@ static void dec_br(DisasContext *dc)
             dc->jmp = JMP_DIRECT;
             dc->jmp_pc = dc->pc + (int32_t)((int16_t)dc->imm);
         } else {
-            tcg_gen_movi_tl(env_btaken, 1);
-            tcg_gen_movi_tl(env_btarget, dc->pc);
-            tcg_gen_add_tl(env_btarget, env_btarget, *(dec_alu_op_b(dc)));
+            tcg_gen_movi_i32(env_btaken, 1);
+            tcg_gen_movi_i32(env_btarget, dc->pc);
+            tcg_gen_add_i32(env_btarget, env_btarget, *(dec_alu_op_b(dc)));
         }
     }
 }
 
 static inline void do_rti(DisasContext *dc)
 {
-    TCGv t0, t1;
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
-    tcg_gen_shri_tl(t0, cpu_SR[SR_MSR], 1);
-    tcg_gen_ori_tl(t1, cpu_SR[SR_MSR], MSR_IE);
-    tcg_gen_andi_tl(t0, t0, (MSR_VM | MSR_UM));
-
-    tcg_gen_andi_tl(t1, t1, ~(MSR_VM | MSR_UM));
-    tcg_gen_or_tl(t1, t1, t0);
+    TCGv_i32 t0, t1;
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
+    tcg_gen_shri_i32(t0, cpu_SR[SR_MSR], 1);
+    tcg_gen_ori_i32(t1, cpu_SR[SR_MSR], MSR_IE);
+    tcg_gen_andi_i32(t0, t0, (MSR_VM | MSR_UM));
+
+    tcg_gen_andi_i32(t1, t1, ~(MSR_VM | MSR_UM));
+    tcg_gen_or_i32(t1, t1, t0);
     msr_write(dc, t1);
-    tcg_temp_free(t1);
-    tcg_temp_free(t0);
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
     dc->tb_flags &= ~DRTI_FLAG;
 }
 
 static inline void do_rtb(DisasContext *dc)
 {
-    TCGv t0, t1;
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
-    tcg_gen_andi_tl(t1, cpu_SR[SR_MSR], ~MSR_BIP);
-    tcg_gen_shri_tl(t0, t1, 1);
-    tcg_gen_andi_tl(t0, t0, (MSR_VM | MSR_UM));
-
-    tcg_gen_andi_tl(t1, t1, ~(MSR_VM | MSR_UM));
-    tcg_gen_or_tl(t1, t1, t0);
+    TCGv_i32 t0, t1;
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
+    tcg_gen_andi_i32(t1, cpu_SR[SR_MSR], ~MSR_BIP);
+    tcg_gen_shri_i32(t0, t1, 1);
+    tcg_gen_andi_i32(t0, t0, (MSR_VM | MSR_UM));
+
+    tcg_gen_andi_i32(t1, t1, ~(MSR_VM | MSR_UM));
+    tcg_gen_or_i32(t1, t1, t0);
     msr_write(dc, t1);
-    tcg_temp_free(t1);
-    tcg_temp_free(t0);
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
     dc->tb_flags &= ~DRTB_FLAG;
 }
 
 static inline void do_rte(DisasContext *dc)
 {
-    TCGv t0, t1;
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    TCGv_i32 t0, t1;
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
 
-    tcg_gen_ori_tl(t1, cpu_SR[SR_MSR], MSR_EE);
-    tcg_gen_andi_tl(t1, t1, ~MSR_EIP);
-    tcg_gen_shri_tl(t0, t1, 1);
-    tcg_gen_andi_tl(t0, t0, (MSR_VM | MSR_UM));
+    tcg_gen_ori_i32(t1, cpu_SR[SR_MSR], MSR_EE);
+    tcg_gen_andi_i32(t1, t1, ~MSR_EIP);
+    tcg_gen_shri_i32(t0, t1, 1);
+    tcg_gen_andi_i32(t0, t0, (MSR_VM | MSR_UM));
 
-    tcg_gen_andi_tl(t1, t1, ~(MSR_VM | MSR_UM));
-    tcg_gen_or_tl(t1, t1, t0);
+    tcg_gen_andi_i32(t1, t1, ~(MSR_VM | MSR_UM));
+    tcg_gen_or_i32(t1, t1, t0);
     msr_write(dc, t1);
-    tcg_temp_free(t1);
-    tcg_temp_free(t0);
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
     dc->tb_flags &= ~DRTE_FLAG;
 }
 
@@ -1361,14 +1368,14 @@ static void dec_rts(DisasContext *dc)
 
     dc->delayed_branch = 2;
     dc->tb_flags |= D_FLAG;
-    tcg_gen_st_tl(tcg_const_tl(dc->type_b && (dc->tb_flags & IMM_FLAG)),
+    tcg_gen_st_i32(tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG)),
                   cpu_env, offsetof(CPUMBState, bimm));
 
     if (i_bit) {
         LOG_DIS("rtid ir=%x\n", dc->ir);
         if ((dc->tb_flags & MSR_EE_FLAG)
              && mem_index == MMU_USER_IDX) {
-            tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
+            tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
             t_gen_raise_exception(dc, EXCP_HW_EXCP);
         }
         dc->tb_flags |= DRTI_FLAG;
@@ -1376,7 +1383,7 @@ static void dec_rts(DisasContext *dc)
         LOG_DIS("rtbd ir=%x\n", dc->ir);
         if ((dc->tb_flags & MSR_EE_FLAG)
              && mem_index == MMU_USER_IDX) {
-            tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
+            tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
             t_gen_raise_exception(dc, EXCP_HW_EXCP);
         }
         dc->tb_flags |= DRTB_FLAG;
@@ -1384,7 +1391,7 @@ static void dec_rts(DisasContext *dc)
         LOG_DIS("rted ir=%x\n", dc->ir);
         if ((dc->tb_flags & MSR_EE_FLAG)
              && mem_index == MMU_USER_IDX) {
-            tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
+            tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
             t_gen_raise_exception(dc, EXCP_HW_EXCP);
         }
         dc->tb_flags |= DRTE_FLAG;
@@ -1392,14 +1399,14 @@ static void dec_rts(DisasContext *dc)
         LOG_DIS("rts ir=%x\n", dc->ir);
 
     dc->jmp = JMP_INDIRECT;
-    tcg_gen_movi_tl(env_btaken, 1);
-    tcg_gen_add_tl(env_btarget, cpu_R[dc->ra], *(dec_alu_op_b(dc)));
+    tcg_gen_movi_i32(env_btaken, 1);
+    tcg_gen_add_i32(env_btarget, cpu_R[dc->ra], *(dec_alu_op_b(dc)));
 }
 
 static int dec_check_fpuv2(DisasContext *dc)
 {
     if ((dc->cpu->cfg.use_fpu != 2) && (dc->tb_flags & MSR_EE_FLAG)) {
-        tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_FPU);
+        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_FPU);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
     }
     return (dc->cpu->cfg.use_fpu == 2) ? 0 : PVR2_USE_FPU2_MASK;
@@ -1412,7 +1419,7 @@ static void dec_fpu(DisasContext *dc)
     if ((dc->tb_flags & MSR_EE_FLAG)
           && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
           && !dc->cpu->cfg.use_fpu) {
-        tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
+        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
         return;
     }
@@ -1514,7 +1521,7 @@ static void dec_null(DisasContext *dc)
 {
     if ((dc->tb_flags & MSR_EE_FLAG)
           && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)) {
-        tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
+        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
         return;
     }
@@ -1533,29 +1540,29 @@ static void dec_stream(DisasContext *dc)
             dc->type_b ? "" : "d", dc->imm);
 
     if ((dc->tb_flags & MSR_EE_FLAG) && (mem_index == MMU_USER_IDX)) {
-        tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
+        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
         return;
     }
 
-    t_id = tcg_temp_new();
+    t_id = tcg_temp_new_i32();
     if (dc->type_b) {
-        tcg_gen_movi_tl(t_id, dc->imm & 0xf);
+        tcg_gen_movi_i32(t_id, dc->imm & 0xf);
         ctrl = dc->imm >> 10;
     } else {
-        tcg_gen_andi_tl(t_id, cpu_R[dc->rb], 0xf);
+        tcg_gen_andi_i32(t_id, cpu_R[dc->rb], 0xf);
         ctrl = dc->imm >> 5;
     }
 
-    t_ctrl = tcg_const_tl(ctrl);
+    t_ctrl = tcg_const_i32(ctrl);
 
     if (dc->rd == 0) {
         gen_helper_put(t_id, t_ctrl, cpu_R[dc->ra]);
     } else {
         gen_helper_get(cpu_R[dc->rd], t_id, t_ctrl);
     }
-    tcg_temp_free(t_id);
-    tcg_temp_free(t_ctrl);
+    tcg_temp_free_i32(t_id);
+    tcg_temp_free_i32(t_ctrl);
 }
 
 static struct decoder_info {
@@ -1599,7 +1606,7 @@ static inline void decode(DisasContext *dc, uint32_t ir)
         if ((dc->tb_flags & MSR_EE_FLAG)
               && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
               && (dc->cpu->env.pvr.regs[2] & PVR2_OPCODE_0x0_ILL_MASK)) {
-            tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
+            tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
             t_gen_raise_exception(dc, EXCP_HW_EXCP);
             return;
         }
@@ -1637,7 +1644,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     struct DisasContext ctx;
     struct DisasContext *dc = &ctx;
     uint32_t next_page_start, org_flags;
-    target_ulong npc;
+    uint32_t npc;
     int num_insns;
     int max_insns;
 
@@ -1680,7 +1687,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
 #if SIM_COMPAT
         if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)) {
-            tcg_gen_movi_tl(cpu_SR[SR_PC], dc->pc);
+            tcg_gen_movi_i32(cpu_SR[SR_PC], dc->pc);
             gen_helper_debug();
         }
 #endif
@@ -1722,7 +1729,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
                 dc->tb_flags &= ~D_FLAG;
                 /* If it is a direct jump, try direct chaining.  */
                 if (dc->jmp == JMP_INDIRECT) {
-                    eval_cond_jmp(dc, env_btarget, tcg_const_tl(dc->pc));
+                    eval_cond_jmp(dc, env_btarget, tcg_const_i32(dc->pc));
                     dc->is_jmp = DISAS_JUMP;
                 } else if (dc->jmp == JMP_DIRECT) {
                     t_sync_flags(dc);
@@ -1732,7 +1739,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
                     TCGLabel *l1 = gen_new_label();
                     t_sync_flags(dc);
                     /* Conditional jmp.  */
-                    tcg_gen_brcondi_tl(TCG_COND_NE, env_btaken, 0, l1);
+                    tcg_gen_brcondi_i32(TCG_COND_NE, env_btaken, 0, l1);
                     gen_goto_tb(dc, 1, dc->pc);
                     gen_set_label(l1);
                     gen_goto_tb(dc, 0, dc->jmp_pc);
@@ -1755,7 +1762,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     if (dc->jmp == JMP_DIRECT || dc->jmp == JMP_DIRECT_CC) {
         if (dc->tb_flags & D_FLAG) {
             dc->is_jmp = DISAS_UPDATE;
-            tcg_gen_movi_tl(cpu_SR[SR_PC], npc);
+            tcg_gen_movi_i32(cpu_SR[SR_PC], npc);
             sync_jmpstate(dc);
         } else
             npc = dc->jmp_pc;
@@ -1767,7 +1774,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     if (dc->is_jmp == DISAS_NEXT
         && (dc->cpustate_changed || org_flags != dc->tb_flags)) {
         dc->is_jmp = DISAS_UPDATE;
-        tcg_gen_movi_tl(cpu_SR[SR_PC], npc);
+        tcg_gen_movi_i32(cpu_SR[SR_PC], npc);
     }
     t_sync_flags(dc);
 
@@ -1775,7 +1782,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         TCGv_i32 tmp = tcg_const_i32(EXCP_DEBUG);
 
         if (dc->is_jmp != DISAS_JUMP) {
-            tcg_gen_movi_tl(cpu_SR[SR_PC], npc);
+            tcg_gen_movi_i32(cpu_SR[SR_PC], npc);
         }
         gen_helper_raise_exception(cpu_env, tmp);
         tcg_temp_free_i32(tmp);
@@ -1849,34 +1856,34 @@ void mb_tcg_init(void)
 {
     int i;
 
-    env_debug = tcg_global_mem_new(cpu_env,
+    env_debug = tcg_global_mem_new_i32(cpu_env,
                     offsetof(CPUMBState, debug),
                     "debug0");
-    env_iflags = tcg_global_mem_new(cpu_env,
+    env_iflags = tcg_global_mem_new_i32(cpu_env,
                     offsetof(CPUMBState, iflags),
                     "iflags");
-    env_imm = tcg_global_mem_new(cpu_env,
+    env_imm = tcg_global_mem_new_i32(cpu_env,
                     offsetof(CPUMBState, imm),
                     "imm");
-    env_btarget = tcg_global_mem_new(cpu_env,
+    env_btarget = tcg_global_mem_new_i32(cpu_env,
                      offsetof(CPUMBState, btarget),
                      "btarget");
-    env_btaken = tcg_global_mem_new(cpu_env,
+    env_btaken = tcg_global_mem_new_i32(cpu_env,
                      offsetof(CPUMBState, btaken),
                      "btaken");
-    env_res_addr = tcg_global_mem_new(cpu_env,
+    env_res_addr = tcg_global_mem_new_i32(cpu_env,
                      offsetof(CPUMBState, res_addr),
                      "res_addr");
-    env_res_val = tcg_global_mem_new(cpu_env,
+    env_res_val = tcg_global_mem_new_i32(cpu_env,
                      offsetof(CPUMBState, res_val),
                      "res_val");
     for (i = 0; i < ARRAY_SIZE(cpu_R); i++) {
-        cpu_R[i] = tcg_global_mem_new(cpu_env,
+        cpu_R[i] = tcg_global_mem_new_i32(cpu_env,
                           offsetof(CPUMBState, regs[i]),
                           regnames[i]);
     }
     for (i = 0; i < ARRAY_SIZE(cpu_SR); i++) {
-        cpu_SR[i] = tcg_global_mem_new(cpu_env,
+        cpu_SR[i] = tcg_global_mem_new_i32(cpu_env,
                           offsetof(CPUMBState, sregs[i]),
                           special_regnames[i]);
     }
-- 
2.14.1
