Received: from eggs.gnu.org ([2001:4830:134:3::10]:44313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6Tp-0000K0-DJ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6To-0005cR-6b
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:49 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fG6Tn-0005c8-RS
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:48 -0400
Received: by mail-lf0-x241.google.com with SMTP id y72-v6so33291605lfd.2
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 10:32:47 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  8 May 2018 19:31:50 +0200
Message-Id: <20180508173152.29327-35-edgar.iglesias@gmail.com>
In-Reply-To: <20180508173152.29327-1-edgar.iglesias@gmail.com>
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 34/36] target-microblaze: Convert env_btaken
 to i64
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

Convert env_btaken to i64.
No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.h       |  2 +-
 target/microblaze/op_helper.c |  2 +-
 target/microblaze/translate.c | 32 ++++++++++++++++++++------------
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index e62c456ccf..4198e98095 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -238,7 +238,7 @@ typedef struct CPUMBState CPUMBState;
 
 struct CPUMBState {
     uint32_t debug;
-    uint32_t btaken;
+    uint64_t btaken;
     uint32_t btarget;
     uint32_t bimm;
 
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index ddc1f71d62..4f45a2f3e2 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -99,7 +99,7 @@ void helper_debug(CPUMBState *env)
              "debug[%x] imm=%x iflags=%x\n",
              env->sregs[SR_MSR], env->sregs[SR_ESR], env->sregs[SR_EAR],
              env->debug, env->imm, env->iflags);
-    qemu_log("btaken=%d btarget=%x mode=%s(saved=%s) eip=%d ie=%d\n",
+    qemu_log("btaken=%" PRId64 " btarget=%x mode=%s(saved=%s) eip=%d ie=%d\n",
              env->btaken, env->btarget,
              (env->sregs[SR_MSR] & MSR_UM) ? "user" : "kernel",
              (env->sregs[SR_MSR] & MSR_UMS) ? "user" : "kernel",
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 77ef21a708..20cc257b39 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -56,7 +56,7 @@ static TCGv_i32 env_debug;
 static TCGv_i32 cpu_R[32];
 static TCGv_i64 cpu_SR[14];
 static TCGv_i32 env_imm;
-static TCGv_i32 env_btaken;
+static TCGv_i64 env_btaken;
 static TCGv_i32 env_btarget;
 static TCGv_i32 env_iflags;
 static TCGv env_res_addr;
@@ -824,7 +824,7 @@ static inline void sync_jmpstate(DisasContext *dc)
 {
     if (dc->jmp == JMP_DIRECT || dc->jmp == JMP_DIRECT_CC) {
         if (dc->jmp == JMP_DIRECT) {
-            tcg_gen_movi_i32(env_btaken, 1);
+            tcg_gen_movi_i64(env_btaken, 1);
         }
         dc->jmp = JMP_INDIRECT;
         tcg_gen_movi_i32(env_btarget, dc->jmp_pc);
@@ -1139,7 +1139,7 @@ static void dec_store(DisasContext *dc)
 }
 
 static inline void eval_cc(DisasContext *dc, unsigned int cc,
-                           TCGv_i32 d, TCGv_i32 a)
+                           TCGv_i64 d, TCGv_i64 a)
 {
     static const int mb_to_tcg_cc[] = {
         [CC_EQ] = TCG_COND_EQ,
@@ -1157,7 +1157,7 @@ static inline void eval_cc(DisasContext *dc, unsigned int cc,
     case CC_LE:
     case CC_GE:
     case CC_GT:
-        tcg_gen_setcondi_i32(mb_to_tcg_cc[cc], d, a, 0);
+        tcg_gen_setcondi_i64(mb_to_tcg_cc[cc], d, a, 0);
         break;
     default:
         cpu_abort(CPU(dc->cpu), "Unknown condition code %x.\n", cc);
@@ -1170,7 +1170,7 @@ static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i64 pc_false)
     TCGLabel *l1 = gen_new_label();
     /* Conditional jmp.  */
     tcg_gen_mov_i64(cpu_SR[SR_PC], pc_false);
-    tcg_gen_brcondi_i32(TCG_COND_EQ, env_btaken, 0, l1);
+    tcg_gen_brcondi_i64(TCG_COND_EQ, env_btaken, 0, l1);
     tcg_gen_extu_i32_i64(cpu_SR[SR_PC], pc_true);
     gen_set_label(l1);
 }
@@ -1179,6 +1179,7 @@ static void dec_bcc(DisasContext *dc)
 {
     unsigned int cc;
     unsigned int dslot;
+    TCGv_i64 tmp64;
 
     cc = EXTRACT_FIELD(dc->ir, 21, 23);
     dslot = dc->ir & (1 << 25);
@@ -1203,7 +1204,12 @@ static void dec_bcc(DisasContext *dc)
         tcg_gen_movi_i32(env_btarget, dc->pc);
         tcg_gen_add_i32(env_btarget, env_btarget, *(dec_alu_op_b(dc)));
     }
-    eval_cc(dc, cc, env_btaken, cpu_R[dc->ra]);
+
+    tmp64 = tcg_temp_new_i64();
+    /* Signed arithmetics.  */
+    tcg_gen_ext_i32_i64(tmp64, cpu_R[dc->ra]);
+    eval_cc(dc, cc, env_btaken, tmp64);
+    tcg_temp_free_i64(tmp64);
 }
 
 static void dec_br(DisasContext *dc)
@@ -1257,7 +1263,7 @@ static void dec_br(DisasContext *dc)
 
     dc->jmp = JMP_INDIRECT;
     if (abs) {
-        tcg_gen_movi_i32(env_btaken, 1);
+        tcg_gen_movi_i64(env_btaken, 1);
         tcg_gen_mov_i32(env_btarget, *(dec_alu_op_b(dc)));
         if (link && !dslot) {
             if (!(dc->tb_flags & IMM_FLAG) && (dc->imm == 8 || dc->imm == 0x18))
@@ -1275,7 +1281,7 @@ static void dec_br(DisasContext *dc)
             dc->jmp = JMP_DIRECT;
             dc->jmp_pc = dc->pc + (int32_t)((int16_t)dc->imm);
         } else {
-            tcg_gen_movi_i32(env_btaken, 1);
+            tcg_gen_movi_i64(env_btaken, 1);
             tcg_gen_movi_i32(env_btarget, dc->pc);
             tcg_gen_add_i32(env_btarget, env_btarget, *(dec_alu_op_b(dc)));
         }
@@ -1368,7 +1374,7 @@ static void dec_rts(DisasContext *dc)
         LOG_DIS("rts ir=%x\n", dc->ir);
 
     dc->jmp = JMP_INDIRECT;
-    tcg_gen_movi_i32(env_btaken, 1);
+    tcg_gen_movi_i64(env_btaken, 1);
     tcg_gen_add_i32(env_btarget, cpu_R[dc->ra], *(dec_alu_op_b(dc)));
 }
 
@@ -1692,7 +1698,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
                     TCGLabel *l1 = gen_new_label();
                     t_sync_flags(dc);
                     /* Conditional jmp.  */
-                    tcg_gen_brcondi_i32(TCG_COND_NE, env_btaken, 0, l1);
+                    tcg_gen_brcondi_i64(TCG_COND_NE, env_btaken, 0, l1);
                     gen_goto_tb(dc, 1, dc->pc);
                     gen_set_label(l1);
                     gen_goto_tb(dc, 0, dc->jmp_pc);
@@ -1791,7 +1797,8 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                    "debug=%x imm=%x iflags=%x fsr=%" PRIx64 "\n",
              env->sregs[SR_MSR], env->sregs[SR_ESR], env->sregs[SR_EAR],
              env->debug, env->imm, env->iflags, env->sregs[SR_FSR]);
-    cpu_fprintf(f, "btaken=%d btarget=%x mode=%s(saved=%s) eip=%d ie=%d\n",
+    cpu_fprintf(f, "btaken=%" PRId64" btarget=%x mode=%s(saved=%s) "
+                   "eip=%d ie=%d\n",
              env->btaken, env->btarget,
              (env->sregs[SR_MSR] & MSR_UM) ? "user" : "kernel",
              (env->sregs[SR_MSR] & MSR_UMS) ? "user" : "kernel",
@@ -1810,6 +1817,7 @@ void mb_tcg_init(void)
 {
     int i;
 
+
     env_debug = tcg_global_mem_new_i32(cpu_env,
                     offsetof(CPUMBState, debug),
                     "debug0");
@@ -1822,7 +1830,7 @@ void mb_tcg_init(void)
     env_btarget = tcg_global_mem_new_i32(cpu_env,
                      offsetof(CPUMBState, btarget),
                      "btarget");
-    env_btaken = tcg_global_mem_new_i32(cpu_env,
+    env_btaken = tcg_global_mem_new_i64(cpu_env,
                      offsetof(CPUMBState, btaken),
                      "btaken");
     env_res_addr = tcg_global_mem_new(cpu_env,
-- 
2.14.1
