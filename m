Received: from eggs.gnu.org ([2001:4830:134:3::10]:55282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAPB-00016f-8m
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAP8-00059f-QX
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:20:01 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:38125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fEAP8-000592-A2
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:58 -0400
Received: by mail-lf0-x241.google.com with SMTP id z130-v6so24921670lff.5
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 02:19:58 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu,  3 May 2018 11:19:13 +0200
Message-Id: <20180503091922.28733-21-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-1-edgar.iglesias@gmail.com>
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 20/29] target-microblaze: Make special
 registers 64-bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Extend special registers to 64-bits. This is in preparation for
MFSE/MTSE, moves to and from extended special registers.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 linux-user/microblaze/cpu_loop.c |  4 +-
 target/microblaze/cpu.h          |  2 +-
 target/microblaze/helper.c       | 15 ++++--
 target/microblaze/mmu.c          |  3 +-
 target/microblaze/op_helper.c    |  9 ++--
 target/microblaze/translate.c    | 99 +++++++++++++++++++++-------------------
 6 files changed, 72 insertions(+), 60 deletions(-)

diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index 5ffb83dea2..5af12d5b21 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -105,8 +105,8 @@ void cpu_loop(CPUMBState *env)
                     queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
                     break;
                 default:
-                    printf ("Unhandled hw-exception: 0x%x\n",
-                            env->sregs[SR_ESR] & ESR_EC_MASK);
+                    printf("Unhandled hw-exception: 0x%" PRIx64 "\n",
+                           env->sregs[SR_ESR] & ESR_EC_MASK);
                     cpu_dump_state(cs, stderr, fprintf, 0);
                     exit(EXIT_FAILURE);
                     break;
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 1593496997..215f42b384 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -243,7 +243,7 @@ struct CPUMBState {
 
     uint32_t imm;
     uint32_t regs[32];
-    uint32_t sregs[14];
+    uint64_t sregs[14];
     float_status fp_status;
     /* Stack protectors. Yes, it's a hw feature.  */
     uint32_t slr, shr;
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 261dcc74c7..985bdae8d1 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -143,7 +143,8 @@ void mb_cpu_do_interrupt(CPUState *cs)
             env->sregs[SR_MSR] |= MSR_EIP;
 
             qemu_log_mask(CPU_LOG_INT,
-                          "hw exception at pc=%x ear=%x esr=%x iflags=%x\n",
+                          "hw exception at pc=%" PRIx64 " ear=%" PRIx64 " "
+                          "esr=%" PRIx64 " iflags=%x\n",
                           env->sregs[SR_PC], env->sregs[SR_EAR],
                           env->sregs[SR_ESR], env->iflags);
             log_cpu_state_mask(CPU_LOG_INT, cs, 0);
@@ -166,7 +167,8 @@ void mb_cpu_do_interrupt(CPUState *cs)
                 /* was the branch immprefixed?.  */
                 if (env->bimm) {
                     qemu_log_mask(CPU_LOG_INT,
-                                  "bimm exception at pc=%x iflags=%x\n",
+                                  "bimm exception at pc=%" PRIx64 " "
+                                  "iflags=%x\n",
                                   env->sregs[SR_PC], env->iflags);
                     env->regs[17] -= 4;
                     log_cpu_state_mask(CPU_LOG_INT, cs, 0);
@@ -184,7 +186,8 @@ void mb_cpu_do_interrupt(CPUState *cs)
             env->sregs[SR_MSR] |= MSR_EIP;
 
             qemu_log_mask(CPU_LOG_INT,
-                          "exception at pc=%x ear=%x iflags=%x\n",
+                          "exception at pc=%" PRIx64 " ear=%" PRIx64 " "
+                          "iflags=%x\n",
                           env->sregs[SR_PC], env->sregs[SR_EAR], env->iflags);
             log_cpu_state_mask(CPU_LOG_INT, cs, 0);
             env->iflags &= ~(IMM_FLAG | D_FLAG);
@@ -221,7 +224,8 @@ void mb_cpu_do_interrupt(CPUState *cs)
             }
 #endif
             qemu_log_mask(CPU_LOG_INT,
-                         "interrupt at pc=%x msr=%x %x iflags=%x\n",
+                         "interrupt at pc=%" PRIx64 " msr=%" PRIx64 " %x "
+                         "iflags=%x\n",
                          env->sregs[SR_PC], env->sregs[SR_MSR], t, env->iflags);
 
             env->sregs[SR_MSR] &= ~(MSR_VMS | MSR_UMS | MSR_VM \
@@ -239,7 +243,8 @@ void mb_cpu_do_interrupt(CPUState *cs)
             assert(!(env->iflags & D_FLAG));
             t = (env->sregs[SR_MSR] & (MSR_VM | MSR_UM)) << 1;
             qemu_log_mask(CPU_LOG_INT,
-                        "break at pc=%x msr=%x %x iflags=%x\n",
+                        "break at pc=%" PRIx64 " msr=%" PRIx64 " %x "
+                        "iflags=%x\n",
                         env->sregs[SR_PC], env->sregs[SR_MSR], t, env->iflags);
             log_cpu_state_mask(CPU_LOG_INT, cs, 0);
             env->sregs[SR_MSR] &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM);
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 9d5e6aa8a5..0019ebd18f 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -240,7 +240,8 @@ void mmu_write(CPUMBState *env, uint32_t rn, uint32_t v)
             i = env->mmu.regs[MMU_R_TLBX] & 0xff;
             if (rn == MMU_R_TLBHI) {
                 if (i < 3 && !(v & TLB_VALID) && qemu_loglevel_mask(~0))
-                    qemu_log_mask(LOG_GUEST_ERROR, "invalidating index %x at pc=%x\n",
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                             "invalidating index %x at pc=%" PRIx64 "\n",
                              i, env->sregs[SR_PC]);
                 env->mmu.tids[i] = env->mmu.regs[MMU_R_PID] & 0xff;
                 mmu_flush_idx(env, i);
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index f5e851e38d..4dc3aff84b 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -94,16 +94,17 @@ void helper_debug(CPUMBState *env)
 {
     int i;
 
-    qemu_log("PC=%8.8x\n", env->sregs[SR_PC]);
-    qemu_log("rmsr=%x resr=%x rear=%x debug[%x] imm=%x iflags=%x\n",
+    qemu_log("PC=%" PRIx64 "\n", env->sregs[SR_PC]);
+    qemu_log("rmsr=%" PRIx64 " resr=%" PRIx64 " rear=%" PRIx64 " "
+             "debug[%x] imm=%x iflags=%x\n",
              env->sregs[SR_MSR], env->sregs[SR_ESR], env->sregs[SR_EAR],
              env->debug, env->imm, env->iflags);
     qemu_log("btaken=%d btarget=%x mode=%s(saved=%s) eip=%d ie=%d\n",
              env->btaken, env->btarget,
              (env->sregs[SR_MSR] & MSR_UM) ? "user" : "kernel",
              (env->sregs[SR_MSR] & MSR_UMS) ? "user" : "kernel",
-             (env->sregs[SR_MSR] & MSR_EIP),
-             (env->sregs[SR_MSR] & MSR_IE));
+             (bool)(env->sregs[SR_MSR] & MSR_EIP),
+             (bool)(env->sregs[SR_MSR] & MSR_IE));
     for (i = 0; i < 32; i++) {
         qemu_log("r%2.2d=%8.8x ", i, env->regs[i]);
         if ((i + 1) % 4 == 0)
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 97d7782bc6..bc5aa0b1ca 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -54,7 +54,7 @@
 
 static TCGv_i32 env_debug;
 static TCGv_i32 cpu_R[32];
-static TCGv_i32 cpu_SR[14];
+static TCGv_i64 cpu_SR[14];
 static TCGv_i32 env_imm;
 static TCGv_i32 env_btaken;
 static TCGv_i32 env_btarget;
@@ -123,7 +123,7 @@ static inline void t_gen_raise_exception(DisasContext *dc, uint32_t index)
     TCGv_i32 tmp = tcg_const_i32(index);
 
     t_sync_flags(dc);
-    tcg_gen_movi_i32(cpu_SR[SR_PC], dc->pc);
+    tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc);
     gen_helper_raise_exception(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
     dc->is_jmp = DISAS_UPDATE;
@@ -142,17 +142,18 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
 {
     if (use_goto_tb(dc, dest)) {
         tcg_gen_goto_tb(n);
-        tcg_gen_movi_i32(cpu_SR[SR_PC], dest);
+        tcg_gen_movi_i64(cpu_SR[SR_PC], dest);
         tcg_gen_exit_tb((uintptr_t)dc->tb + n);
     } else {
-        tcg_gen_movi_i32(cpu_SR[SR_PC], dest);
+        tcg_gen_movi_i64(cpu_SR[SR_PC], dest);
         tcg_gen_exit_tb(0);
     }
 }
 
 static void read_carry(DisasContext *dc, TCGv_i32 d)
 {
-    tcg_gen_shri_i32(d, cpu_SR[SR_MSR], 31);
+    tcg_gen_extrl_i64_i32(d, cpu_SR[SR_MSR]);
+    tcg_gen_shri_i32(d, d, 31);
 }
 
 /*
@@ -161,14 +162,12 @@ static void read_carry(DisasContext *dc, TCGv_i32 d)
  */
 static void write_carry(DisasContext *dc, TCGv_i32 v)
 {
-    TCGv_i32 t0 = tcg_temp_new_i32();
-    tcg_gen_shli_i32(t0, v, 31);
-    tcg_gen_sari_i32(t0, t0, 31);
-    tcg_gen_andi_i32(t0, t0, (MSR_C | MSR_CC));
-    tcg_gen_andi_i32(cpu_SR[SR_MSR], cpu_SR[SR_MSR],
-                    ~(MSR_C | MSR_CC));
-    tcg_gen_or_i32(cpu_SR[SR_MSR], cpu_SR[SR_MSR], t0);
-    tcg_temp_free_i32(t0);
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(t0, v);
+    /* Deposit bit 0 into MSR_C and the alias MSR_CC.  */
+    tcg_gen_deposit_i64(cpu_SR[SR_MSR], cpu_SR[SR_MSR], t0, 2, 1);
+    tcg_gen_deposit_i64(cpu_SR[SR_MSR], cpu_SR[SR_MSR], t0, 31, 1);
+    tcg_temp_free_i64(t0);
 }
 
 static void write_carryi(DisasContext *dc, bool carry)
@@ -187,7 +186,7 @@ static bool trap_illegal(DisasContext *dc, bool cond)
 {
     if (cond && (dc->tb_flags & MSR_EE_FLAG)
         && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)) {
-        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
+        tcg_gen_movi_i64(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
     }
     return cond;
@@ -203,7 +202,7 @@ static bool trap_userspace(DisasContext *dc, bool cond)
     bool cond_user = cond && mem_index == MMU_USER_IDX;
 
     if (cond_user && (dc->tb_flags & MSR_EE_FLAG)) {
-        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
+        tcg_gen_movi_i64(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
     }
     return cond_user;
@@ -438,20 +437,21 @@ static void dec_xor(DisasContext *dc)
 
 static inline void msr_read(DisasContext *dc, TCGv_i32 d)
 {
-    tcg_gen_mov_i32(d, cpu_SR[SR_MSR]);
+    tcg_gen_extrl_i64_i32(d, cpu_SR[SR_MSR]);
 }
 
 static inline void msr_write(DisasContext *dc, TCGv_i32 v)
 {
-    TCGv_i32 t;
+    TCGv_i64 t;
 
-    t = tcg_temp_new_i32();
+    t = tcg_temp_new_i64();
     dc->cpustate_changed = 1;
     /* PVR bit is not writable.  */
-    tcg_gen_andi_i32(t, v, ~MSR_PVR);
-    tcg_gen_andi_i32(cpu_SR[SR_MSR], cpu_SR[SR_MSR], MSR_PVR);
-    tcg_gen_or_i32(cpu_SR[SR_MSR], cpu_SR[SR_MSR], t);
-    tcg_temp_free(t);
+    tcg_gen_extu_i32_i64(t, v);
+    tcg_gen_andi_i64(t, t, ~MSR_PVR);
+    tcg_gen_andi_i64(cpu_SR[SR_MSR], cpu_SR[SR_MSR], MSR_PVR);
+    tcg_gen_or_i64(cpu_SR[SR_MSR], cpu_SR[SR_MSR], t);
+    tcg_temp_free_i64(t);
 }
 
 static void dec_msr(DisasContext *dc)
@@ -501,7 +501,7 @@ static void dec_msr(DisasContext *dc)
         msr_write(dc, t0);
         tcg_temp_free_i32(t0);
         tcg_temp_free_i32(t1);
-        tcg_gen_movi_i32(cpu_SR[SR_PC], dc->pc + 4);
+        tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc + 4);
         dc->is_jmp = DISAS_UPDATE;
         return;
     }
@@ -534,7 +534,7 @@ static void dec_msr(DisasContext *dc)
             case SR_EAR:
             case SR_ESR:
             case SR_FSR:
-                tcg_gen_mov_i32(cpu_SR[sr], cpu_R[dc->ra]);
+                tcg_gen_extu_i32_i64(cpu_SR[sr], cpu_R[dc->ra]);
                 break;
             case 0x800:
                 tcg_gen_st_i32(cpu_R[dc->ra],
@@ -562,7 +562,7 @@ static void dec_msr(DisasContext *dc)
             case SR_ESR:
             case SR_FSR:
             case SR_BTR:
-                tcg_gen_mov_i32(cpu_R[dc->rd], cpu_SR[sr]);
+                tcg_gen_extrl_i64_i32(cpu_R[dc->rd], cpu_SR[sr]);
                 break;
             case 0x800:
                 tcg_gen_ld_i32(cpu_R[dc->rd],
@@ -735,7 +735,8 @@ static void dec_bit(DisasContext *dc)
             t0 = tcg_temp_new_i32();
 
             LOG_DIS("src r%d r%d\n", dc->rd, dc->ra);
-            tcg_gen_andi_i32(t0, cpu_SR[SR_MSR], MSR_CC);
+            tcg_gen_extrl_i64_i32(t0, cpu_SR[SR_MSR]);
+            tcg_gen_andi_i32(t0, t0, MSR_CC);
             write_carry(dc, cpu_R[dc->ra]);
             if (dc->rd) {
                 tcg_gen_shri_i32(cpu_R[dc->rd], cpu_R[dc->ra], 1);
@@ -966,7 +967,7 @@ static void dec_load(DisasContext *dc)
     tcg_gen_qemu_ld_i32(v, addr, cpu_mmu_index(&dc->cpu->env, false), mop);
 
     if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
-        tcg_gen_movi_i32(cpu_SR[SR_PC], dc->pc);
+        tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc);
         gen_helper_memalign(cpu_env, addr, tcg_const_i32(dc->rd),
                             tcg_const_i32(0), tcg_const_i32(size - 1));
     }
@@ -1078,7 +1079,7 @@ static void dec_store(DisasContext *dc)
 
     /* Verify alignment if needed.  */
     if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
-        tcg_gen_movi_i32(cpu_SR[SR_PC], dc->pc);
+        tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc);
         /* FIXME: if the alignment is wrong, we should restore the value
          *        in memory. One possible way to achieve this is to probe
          *        the MMU prior to the memaccess, thay way we could put
@@ -1124,13 +1125,13 @@ static inline void eval_cc(DisasContext *dc, unsigned int cc,
     }
 }
 
-static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i32 pc_false)
+static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i64 pc_false)
 {
     TCGLabel *l1 = gen_new_label();
     /* Conditional jmp.  */
-    tcg_gen_mov_i32(cpu_SR[SR_PC], pc_false);
+    tcg_gen_mov_i64(cpu_SR[SR_PC], pc_false);
     tcg_gen_brcondi_i32(TCG_COND_EQ, env_btaken, 0, l1);
-    tcg_gen_mov_i32(cpu_SR[SR_PC], pc_true);
+    tcg_gen_extu_i32_i64(cpu_SR[SR_PC], pc_true);
     gen_set_label(l1);
 }
 
@@ -1187,7 +1188,7 @@ static void dec_br(DisasContext *dc)
             tcg_gen_st_i32(tmp_1, cpu_env,
                            -offsetof(MicroBlazeCPU, env)
                            +offsetof(CPUState, halted));
-            tcg_gen_movi_i32(cpu_SR[SR_PC], dc->pc + 4);
+            tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc + 4);
             gen_helper_raise_exception(cpu_env, tmp_hlt);
             tcg_temp_free_i32(tmp_hlt);
             tcg_temp_free_i32(tmp_1);
@@ -1246,8 +1247,9 @@ static inline void do_rti(DisasContext *dc)
     TCGv_i32 t0, t1;
     t0 = tcg_temp_new_i32();
     t1 = tcg_temp_new_i32();
-    tcg_gen_shri_i32(t0, cpu_SR[SR_MSR], 1);
-    tcg_gen_ori_i32(t1, cpu_SR[SR_MSR], MSR_IE);
+    tcg_gen_extrl_i64_i32(t1, cpu_SR[SR_MSR]);
+    tcg_gen_shri_i32(t0, t1, 1);
+    tcg_gen_ori_i32(t1, t1, MSR_IE);
     tcg_gen_andi_i32(t0, t0, (MSR_VM | MSR_UM));
 
     tcg_gen_andi_i32(t1, t1, ~(MSR_VM | MSR_UM));
@@ -1263,7 +1265,8 @@ static inline void do_rtb(DisasContext *dc)
     TCGv_i32 t0, t1;
     t0 = tcg_temp_new_i32();
     t1 = tcg_temp_new_i32();
-    tcg_gen_andi_i32(t1, cpu_SR[SR_MSR], ~MSR_BIP);
+    tcg_gen_extrl_i64_i32(t1, cpu_SR[SR_MSR]);
+    tcg_gen_andi_i32(t1, t1, ~MSR_BIP);
     tcg_gen_shri_i32(t0, t1, 1);
     tcg_gen_andi_i32(t0, t0, (MSR_VM | MSR_UM));
 
@@ -1281,7 +1284,8 @@ static inline void do_rte(DisasContext *dc)
     t0 = tcg_temp_new_i32();
     t1 = tcg_temp_new_i32();
 
-    tcg_gen_ori_i32(t1, cpu_SR[SR_MSR], MSR_EE);
+    tcg_gen_extrl_i64_i32(t1, cpu_SR[SR_MSR]);
+    tcg_gen_ori_i32(t1, t1, MSR_EE);
     tcg_gen_andi_i32(t1, t1, ~MSR_EIP);
     tcg_gen_shri_i32(t0, t1, 1);
     tcg_gen_andi_i32(t0, t0, (MSR_VM | MSR_UM));
@@ -1331,7 +1335,7 @@ static void dec_rts(DisasContext *dc)
 static int dec_check_fpuv2(DisasContext *dc)
 {
     if ((dc->cpu->cfg.use_fpu != 2) && (dc->tb_flags & MSR_EE_FLAG)) {
-        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_FPU);
+        tcg_gen_movi_i64(cpu_SR[SR_ESR], ESR_EC_FPU);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
     }
     return (dc->cpu->cfg.use_fpu == 2) ? 0 : PVR2_USE_FPU2_MASK;
@@ -1596,7 +1600,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
 #if SIM_COMPAT
         if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)) {
-            tcg_gen_movi_i32(cpu_SR[SR_PC], dc->pc);
+            tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc);
             gen_helper_debug();
         }
 #endif
@@ -1638,7 +1642,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
                 dc->tb_flags &= ~D_FLAG;
                 /* If it is a direct jump, try direct chaining.  */
                 if (dc->jmp == JMP_INDIRECT) {
-                    eval_cond_jmp(dc, env_btarget, tcg_const_i32(dc->pc));
+                    eval_cond_jmp(dc, env_btarget, tcg_const_i64(dc->pc));
                     dc->is_jmp = DISAS_JUMP;
                 } else if (dc->jmp == JMP_DIRECT) {
                     t_sync_flags(dc);
@@ -1671,7 +1675,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     if (dc->jmp == JMP_DIRECT || dc->jmp == JMP_DIRECT_CC) {
         if (dc->tb_flags & D_FLAG) {
             dc->is_jmp = DISAS_UPDATE;
-            tcg_gen_movi_i32(cpu_SR[SR_PC], npc);
+            tcg_gen_movi_i64(cpu_SR[SR_PC], npc);
             sync_jmpstate(dc);
         } else
             npc = dc->jmp_pc;
@@ -1683,7 +1687,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     if (dc->is_jmp == DISAS_NEXT
         && (dc->cpustate_changed || org_flags != dc->tb_flags)) {
         dc->is_jmp = DISAS_UPDATE;
-        tcg_gen_movi_i32(cpu_SR[SR_PC], npc);
+        tcg_gen_movi_i64(cpu_SR[SR_PC], npc);
     }
     t_sync_flags(dc);
 
@@ -1691,7 +1695,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         TCGv_i32 tmp = tcg_const_i32(EXCP_DEBUG);
 
         if (dc->is_jmp != DISAS_JUMP) {
-            tcg_gen_movi_i32(cpu_SR[SR_PC], npc);
+            tcg_gen_movi_i64(cpu_SR[SR_PC], npc);
         }
         gen_helper_raise_exception(cpu_env, tmp);
         tcg_temp_free_i32(tmp);
@@ -1741,17 +1745,18 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     if (!env || !f)
         return;
 
-    cpu_fprintf(f, "IN: PC=%x %s\n",
+    cpu_fprintf(f, "IN: PC=%" PRIx64 " %s\n",
                 env->sregs[SR_PC], lookup_symbol(env->sregs[SR_PC]));
-    cpu_fprintf(f, "rmsr=%x resr=%x rear=%x debug=%x imm=%x iflags=%x fsr=%x\n",
+    cpu_fprintf(f, "rmsr=%" PRIx64 " resr=%" PRIx64 " rear=%" PRIx64 " "
+                   "debug=%x imm=%x iflags=%x fsr=%" PRIx64 "\n",
              env->sregs[SR_MSR], env->sregs[SR_ESR], env->sregs[SR_EAR],
              env->debug, env->imm, env->iflags, env->sregs[SR_FSR]);
     cpu_fprintf(f, "btaken=%d btarget=%x mode=%s(saved=%s) eip=%d ie=%d\n",
              env->btaken, env->btarget,
              (env->sregs[SR_MSR] & MSR_UM) ? "user" : "kernel",
              (env->sregs[SR_MSR] & MSR_UMS) ? "user" : "kernel",
-             (env->sregs[SR_MSR] & MSR_EIP),
-             (env->sregs[SR_MSR] & MSR_IE));
+             (bool)(env->sregs[SR_MSR] & MSR_EIP),
+             (bool)(env->sregs[SR_MSR] & MSR_IE));
 
     for (i = 0; i < 32; i++) {
         cpu_fprintf(f, "r%2.2d=%8.8x ", i, env->regs[i]);
@@ -1792,7 +1797,7 @@ void mb_tcg_init(void)
                           regnames[i]);
     }
     for (i = 0; i < ARRAY_SIZE(cpu_SR); i++) {
-        cpu_SR[i] = tcg_global_mem_new_i32(cpu_env,
+        cpu_SR[i] = tcg_global_mem_new_i64(cpu_env,
                           offsetof(CPUMBState, sregs[i]),
                           special_regnames[i]);
     }
-- 
2.14.1
