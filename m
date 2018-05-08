Received: from eggs.gnu.org ([2001:4830:134:3::10]:44327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6Tq-0000LX-Q6
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6Tp-0005dD-KV
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:50 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:38806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fG6Tp-0005cZ-8F
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:49 -0400
Received: by mail-lf0-x244.google.com with SMTP id z142-v6so3773560lff.5
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 10:32:49 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  8 May 2018 19:31:51 +0200
Message-Id: <20180508173152.29327-36-edgar.iglesias@gmail.com>
In-Reply-To: <20180508173152.29327-1-edgar.iglesias@gmail.com>
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 35/36] target-microblaze: Convert
 env_btarget to i64
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

Convert env_btarget to i64.
No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.h       |  2 +-
 target/microblaze/op_helper.c |  3 ++-
 target/microblaze/translate.c | 35 ++++++++++++++++++++++-------------
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 4198e98095..079fad437b 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -239,7 +239,7 @@ typedef struct CPUMBState CPUMBState;
 struct CPUMBState {
     uint32_t debug;
     uint64_t btaken;
-    uint32_t btarget;
+    uint64_t btarget;
     uint32_t bimm;
 
     uint32_t imm;
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 4f45a2f3e2..ed374cb8da 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -99,7 +99,8 @@ void helper_debug(CPUMBState *env)
              "debug[%x] imm=%x iflags=%x\n",
              env->sregs[SR_MSR], env->sregs[SR_ESR], env->sregs[SR_EAR],
              env->debug, env->imm, env->iflags);
-    qemu_log("btaken=%" PRId64 " btarget=%x mode=%s(saved=%s) eip=%d ie=%d\n",
+    qemu_log("btaken=%" PRId64 " btarget=%" PRIx64
+             " mode=%s(saved=%s) eip=%d ie=%d\n",
              env->btaken, env->btarget,
              (env->sregs[SR_MSR] & MSR_UM) ? "user" : "kernel",
              (env->sregs[SR_MSR] & MSR_UMS) ? "user" : "kernel",
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 20cc257b39..256acce876 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -57,7 +57,7 @@ static TCGv_i32 cpu_R[32];
 static TCGv_i64 cpu_SR[14];
 static TCGv_i32 env_imm;
 static TCGv_i64 env_btaken;
-static TCGv_i32 env_btarget;
+static TCGv_i64 env_btarget;
 static TCGv_i32 env_iflags;
 static TCGv env_res_addr;
 static TCGv_i32 env_res_val;
@@ -827,7 +827,7 @@ static inline void sync_jmpstate(DisasContext *dc)
             tcg_gen_movi_i64(env_btaken, 1);
         }
         dc->jmp = JMP_INDIRECT;
-        tcg_gen_movi_i32(env_btarget, dc->jmp_pc);
+        tcg_gen_movi_i64(env_btarget, dc->jmp_pc);
     }
 }
 
@@ -1165,13 +1165,13 @@ static inline void eval_cc(DisasContext *dc, unsigned int cc,
     }
 }
 
-static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i64 pc_false)
+static void eval_cond_jmp(DisasContext *dc, TCGv_i64 pc_true, TCGv_i64 pc_false)
 {
     TCGLabel *l1 = gen_new_label();
     /* Conditional jmp.  */
     tcg_gen_mov_i64(cpu_SR[SR_PC], pc_false);
     tcg_gen_brcondi_i64(TCG_COND_EQ, env_btaken, 0, l1);
-    tcg_gen_extu_i32_i64(cpu_SR[SR_PC], pc_true);
+    tcg_gen_mov_i64(cpu_SR[SR_PC], pc_true);
     gen_set_label(l1);
 }
 
@@ -1196,13 +1196,14 @@ static void dec_bcc(DisasContext *dc)
     if (dec_alu_op_b_is_small_imm(dc)) {
         int32_t offset = (int32_t)((int16_t)dc->imm); /* sign-extend.  */
 
-        tcg_gen_movi_i32(env_btarget, dc->pc + offset);
+        tcg_gen_movi_i64(env_btarget, dc->pc + offset);
         dc->jmp = JMP_DIRECT_CC;
         dc->jmp_pc = dc->pc + offset;
     } else {
         dc->jmp = JMP_INDIRECT;
-        tcg_gen_movi_i32(env_btarget, dc->pc);
-        tcg_gen_add_i32(env_btarget, env_btarget, *(dec_alu_op_b(dc)));
+        tcg_gen_extu_i32_i64(env_btarget, *(dec_alu_op_b(dc)));
+        tcg_gen_addi_i64(env_btarget, env_btarget, dc->pc);
+        tcg_gen_andi_i64(env_btarget, env_btarget, UINT32_MAX);
     }
 
     tmp64 = tcg_temp_new_i64();
@@ -1264,7 +1265,7 @@ static void dec_br(DisasContext *dc)
     dc->jmp = JMP_INDIRECT;
     if (abs) {
         tcg_gen_movi_i64(env_btaken, 1);
-        tcg_gen_mov_i32(env_btarget, *(dec_alu_op_b(dc)));
+        tcg_gen_extu_i32_i64(env_btarget, *(dec_alu_op_b(dc)));
         if (link && !dslot) {
             if (!(dc->tb_flags & IMM_FLAG) && (dc->imm == 8 || dc->imm == 0x18))
                 t_gen_raise_exception(dc, EXCP_BREAK);
@@ -1282,8 +1283,9 @@ static void dec_br(DisasContext *dc)
             dc->jmp_pc = dc->pc + (int32_t)((int16_t)dc->imm);
         } else {
             tcg_gen_movi_i64(env_btaken, 1);
-            tcg_gen_movi_i32(env_btarget, dc->pc);
-            tcg_gen_add_i32(env_btarget, env_btarget, *(dec_alu_op_b(dc)));
+            tcg_gen_extu_i32_i64(env_btarget, *(dec_alu_op_b(dc)));
+            tcg_gen_addi_i64(env_btarget, env_btarget, dc->pc);
+            tcg_gen_andi_i64(env_btarget, env_btarget, UINT32_MAX);
         }
     }
 }
@@ -1347,6 +1349,7 @@ static inline void do_rte(DisasContext *dc)
 static void dec_rts(DisasContext *dc)
 {
     unsigned int b_bit, i_bit, e_bit;
+    TCGv_i64 tmp64;
 
     i_bit = dc->ir & (1 << 21);
     b_bit = dc->ir & (1 << 22);
@@ -1375,7 +1378,13 @@ static void dec_rts(DisasContext *dc)
 
     dc->jmp = JMP_INDIRECT;
     tcg_gen_movi_i64(env_btaken, 1);
-    tcg_gen_add_i32(env_btarget, cpu_R[dc->ra], *(dec_alu_op_b(dc)));
+
+    tmp64 = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(env_btarget, *(dec_alu_op_b(dc)));
+    tcg_gen_extu_i32_i64(tmp64, cpu_R[dc->ra]);
+    tcg_gen_add_i64(env_btarget, env_btarget, tmp64);
+    tcg_gen_andi_i64(env_btarget, env_btarget, UINT32_MAX);
+    tcg_temp_free_i64(tmp64);
 }
 
 static int dec_check_fpuv2(DisasContext *dc)
@@ -1797,7 +1806,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                    "debug=%x imm=%x iflags=%x fsr=%" PRIx64 "\n",
              env->sregs[SR_MSR], env->sregs[SR_ESR], env->sregs[SR_EAR],
              env->debug, env->imm, env->iflags, env->sregs[SR_FSR]);
-    cpu_fprintf(f, "btaken=%" PRId64" btarget=%x mode=%s(saved=%s) "
+    cpu_fprintf(f, "btaken=%" PRId64" btarget=%" PRIx64 " mode=%s(saved=%s) "
                    "eip=%d ie=%d\n",
              env->btaken, env->btarget,
              (env->sregs[SR_MSR] & MSR_UM) ? "user" : "kernel",
@@ -1827,7 +1836,7 @@ void mb_tcg_init(void)
     env_imm = tcg_global_mem_new_i32(cpu_env,
                     offsetof(CPUMBState, imm),
                     "imm");
-    env_btarget = tcg_global_mem_new_i32(cpu_env,
+    env_btarget = tcg_global_mem_new_i64(cpu_env,
                      offsetof(CPUMBState, btarget),
                      "btarget");
     env_btaken = tcg_global_mem_new_i64(cpu_env,
-- 
2.14.1
