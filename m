Received: from eggs.gnu.org ([2001:4830:134:3::10]:35284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs4k-00068X-Sy
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs4i-0002pC-GK
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:54 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cSs4i-0002p3-7u
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:52 -0500
Received: by mail-pg0-x242.google.com with SMTP id b1so3583193pgc.1
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 13:10:52 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 15 Jan 2017 13:10:12 -0800
Message-Id: <1484514617-11726-3-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1484514617-11726-1-git-send-email-jcmvbkbc@gmail.com>
References: <1484514617-11726-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 2/7] target/xtensa: support icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Delimit each instruction that may access timers or IRQ state with
qemu_io_start/qemu_io_end, so that qemu-system-xtensa could be run with
-icount option.

Raise EXCP_YIELD after CCOMPARE reprogramming to let tcg_cpu_exec
recalculate how long this CPU is allowed to run.

RSR now may need to terminate TB, but it can't be done in RSR handler
because the same handler is used for XSR together with WSR handler, which
may also need to terminate TB. Change RSR and WSR handlers return type
to bool indicating whether TB termination is needed (RSR) or has been
done (WSR), and add TB termination after RSR/WSR dispatcher call.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |   5 ++
 target/xtensa/op_helper.c |   4 ++
 target/xtensa/translate.c | 179 ++++++++++++++++++++++++++++++++++------------
 3 files changed, 143 insertions(+), 45 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 744af81..a10f1ef 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -382,6 +382,7 @@ typedef struct CPUXtensaState {
     uint32_t ccount_base;
 
     int exception_taken;
+    int yield_needed;
     unsigned static_vectors;
 
     /* Watchpoints for DBREAK registers */
@@ -554,6 +555,7 @@ static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
 #define XTENSA_TBFLAG_EXCEPTION 0x4000
 #define XTENSA_TBFLAG_WINDOW_MASK 0x18000
 #define XTENSA_TBFLAG_WINDOW_SHIFT 15
+#define XTENSA_TBFLAG_YIELD 0x20000
 
 static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
         target_ulong *cs_base, uint32_t *flags)
@@ -595,6 +597,9 @@ static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
     } else {
         *flags |= 3 << XTENSA_TBFLAG_WINDOW_SHIFT;
     }
+    if (env->yield_needed) {
+        *flags |= XTENSA_TBFLAG_YIELD;
+    }
 }
 
 #include "exec/cpu-all.h"
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 5e5c7da..864a8f6 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -105,6 +105,9 @@ void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
     CPUState *cs = CPU(xtensa_env_get_cpu(env));
 
     cs->exception_index = excp;
+    if (excp == EXCP_YIELD) {
+        env->yield_needed = 0;
+    }
     if (excp == EXCP_DEBUG) {
         env->exception_taken = 0;
     }
@@ -431,6 +434,7 @@ void HELPER(update_ccompare)(CPUXtensaState *env, uint32_t i)
     dcc = (uint64_t)(env->sregs[CCOMPARE + i] - env->sregs[CCOUNT] - 1) + 1;
     timer_mod(env->ccompare[i].timer,
               env->ccount_time + (dcc * 1000000) / env->config->clock_freq_khz);
+    env->yield_needed = 1;
 }
 
 void HELPER(check_interrupts)(CPUXtensaState *env)
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index cb42945..96c64d6 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -510,22 +510,31 @@ static bool gen_check_sr(DisasContext *dc, uint32_t sr, unsigned access)
     return true;
 }
 
-static void gen_rsr_ccount(DisasContext *dc, TCGv_i32 d, uint32_t sr)
+static bool gen_rsr_ccount(DisasContext *dc, TCGv_i32 d, uint32_t sr)
 {
+    if (dc->tb->cflags & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
     gen_helper_update_ccount(cpu_env);
     tcg_gen_mov_i32(d, cpu_SR[sr]);
+    if (dc->tb->cflags & CF_USE_ICOUNT) {
+        gen_io_end();
+        return true;
+    }
+    return false;
 }
 
-static void gen_rsr_ptevaddr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
+static bool gen_rsr_ptevaddr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
 {
     tcg_gen_shri_i32(d, cpu_SR[EXCVADDR], 10);
     tcg_gen_or_i32(d, d, cpu_SR[sr]);
     tcg_gen_andi_i32(d, d, 0xfffffffc);
+    return false;
 }
 
-static void gen_rsr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
+static bool gen_rsr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
 {
-    static void (* const rsr_handler[256])(DisasContext *dc,
+    static bool (* const rsr_handler[256])(DisasContext *dc,
             TCGv_i32 d, uint32_t sr) = {
         [CCOUNT] = gen_rsr_ccount,
         [INTSET] = gen_rsr_ccount,
@@ -533,25 +542,28 @@ static void gen_rsr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
     };
 
     if (rsr_handler[sr]) {
-        rsr_handler[sr](dc, d, sr);
+        return rsr_handler[sr](dc, d, sr);
     } else {
         tcg_gen_mov_i32(d, cpu_SR[sr]);
+        return false;
     }
 }
 
-static void gen_wsr_lbeg(DisasContext *dc, uint32_t sr, TCGv_i32 s)
+static bool gen_wsr_lbeg(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
     gen_helper_wsr_lbeg(cpu_env, s);
     gen_jumpi_check_loop_end(dc, 0);
+    return false;
 }
 
-static void gen_wsr_lend(DisasContext *dc, uint32_t sr, TCGv_i32 s)
+static bool gen_wsr_lend(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
     gen_helper_wsr_lend(cpu_env, s);
     gen_jumpi_check_loop_end(dc, 0);
+    return false;
 }
 
-static void gen_wsr_sar(DisasContext *dc, uint32_t sr, TCGv_i32 s)
+static bool gen_wsr_sar(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
     tcg_gen_andi_i32(cpu_SR[sr], s, 0x3f);
     if (dc->sar_m32_5bit) {
@@ -559,68 +571,79 @@ static void gen_wsr_sar(DisasContext *dc, uint32_t sr, TCGv_i32 s)
     }
     dc->sar_5bit = false;
     dc->sar_m32_5bit = false;
+    return false;
 }
 
-static void gen_wsr_br(DisasContext *dc, uint32_t sr, TCGv_i32 s)
+static bool gen_wsr_br(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
     tcg_gen_andi_i32(cpu_SR[sr], s, 0xffff);
+    return false;
 }
 
-static void gen_wsr_litbase(DisasContext *dc, uint32_t sr, TCGv_i32 s)
+static bool gen_wsr_litbase(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
     tcg_gen_andi_i32(cpu_SR[sr], s, 0xfffff001);
     /* This can change tb->flags, so exit tb */
     gen_jumpi_check_loop_end(dc, -1);
+    return true;
 }
 
-static void gen_wsr_acchi(DisasContext *dc, uint32_t sr, TCGv_i32 s)
+static bool gen_wsr_acchi(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
     tcg_gen_ext8s_i32(cpu_SR[sr], s);
+    return false;
 }
 
-static void gen_wsr_windowbase(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool gen_wsr_windowbase(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     gen_helper_wsr_windowbase(cpu_env, v);
     /* This can change tb->flags, so exit tb */
     gen_jumpi_check_loop_end(dc, -1);
+    return true;
 }
 
-static void gen_wsr_windowstart(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool gen_wsr_windowstart(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v, (1 << dc->config->nareg / 4) - 1);
     /* This can change tb->flags, so exit tb */
     gen_jumpi_check_loop_end(dc, -1);
+    return true;
 }
 
-static void gen_wsr_ptevaddr(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool gen_wsr_ptevaddr(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v, 0xffc00000);
+    return false;
 }
 
-static void gen_wsr_rasid(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool gen_wsr_rasid(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     gen_helper_wsr_rasid(cpu_env, v);
     /* This can change tb->flags, so exit tb */
     gen_jumpi_check_loop_end(dc, -1);
+    return true;
 }
 
-static void gen_wsr_tlbcfg(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool gen_wsr_tlbcfg(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v, 0x01130000);
+    return false;
 }
 
-static void gen_wsr_ibreakenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool gen_wsr_ibreakenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     gen_helper_wsr_ibreakenable(cpu_env, v);
     gen_jumpi_check_loop_end(dc, 0);
+    return true;
 }
 
-static void gen_wsr_atomctl(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool gen_wsr_atomctl(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v, 0x3f);
+    return false;
 }
 
-static void gen_wsr_ibreaka(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool gen_wsr_ibreaka(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     unsigned id = sr - IBREAKA;
 
@@ -629,10 +652,12 @@ static void gen_wsr_ibreaka(DisasContext *dc, uint32_t sr, TCGv_i32 v)
         gen_helper_wsr_ibreaka(cpu_env, tmp, v);
         tcg_temp_free(tmp);
         gen_jumpi_check_loop_end(dc, 0);
+        return true;
     }
+    return false;
 }
 
-static void gen_wsr_dbreaka(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool gen_wsr_dbreaka(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     unsigned id = sr - DBREAKA;
 
@@ -641,9 +666,10 @@ static void gen_wsr_dbreaka(DisasContext *dc, uint32_t sr, TCGv_i32 v)
         gen_helper_wsr_dbreaka(cpu_env, tmp, v);
         tcg_temp_free(tmp);
     }
+    return false;
 }
 
-static void gen_wsr_dbreakc(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool gen_wsr_dbreakc(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     unsigned id = sr - DBREAKC;
 
@@ -652,24 +678,38 @@ static void gen_wsr_dbreakc(DisasContext *dc, uint32_t sr, TCGv_i32 v)
         gen_helper_wsr_dbreakc(cpu_env, tmp, v);
         tcg_temp_free(tmp);
     }
+    return false;
 }
 
-static void gen_wsr_cpenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool gen_wsr_cpenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v, 0xff);
     /* This can change tb->flags, so exit tb */
     gen_jumpi_check_loop_end(dc, -1);
+    return true;
 }
 
-static void gen_wsr_intset(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_check_interrupts(DisasContext *dc)
+{
+    if (dc->tb->cflags & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
+    gen_helper_check_interrupts(cpu_env);
+    if (dc->tb->cflags & CF_USE_ICOUNT) {
+        gen_io_end();
+    }
+}
+
+static bool gen_wsr_intset(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v,
             dc->config->inttype_mask[INTTYPE_SOFTWARE]);
-    gen_helper_check_interrupts(cpu_env);
+    gen_check_interrupts(dc);
     gen_jumpi_check_loop_end(dc, 0);
+    return true;
 }
 
-static void gen_wsr_intclear(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool gen_wsr_intclear(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
 
@@ -679,17 +719,20 @@ static void gen_wsr_intclear(DisasContext *dc, uint32_t sr, TCGv_i32 v)
             dc->config->inttype_mask[INTTYPE_SOFTWARE]);
     tcg_gen_andc_i32(cpu_SR[INTSET], cpu_SR[INTSET], tmp);
     tcg_temp_free(tmp);
-    gen_helper_check_interrupts(cpu_env);
+    gen_check_interrupts(dc);
+    gen_jumpi_check_loop_end(dc, 0);
+    return true;
 }
 
-static void gen_wsr_intenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool gen_wsr_intenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_mov_i32(cpu_SR[sr], v);
-    gen_helper_check_interrupts(cpu_env);
+    gen_check_interrupts(dc);
     gen_jumpi_check_loop_end(dc, 0);
+    return true;
 }
 
-static void gen_wsr_ps(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool gen_wsr_ps(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     uint32_t mask = PS_WOE | PS_CALLINC | PS_OWB |
         PS_UM | PS_EXCM | PS_INTLEVEL;
@@ -698,49 +741,72 @@ static void gen_wsr_ps(DisasContext *dc, uint32_t sr, TCGv_i32 v)
         mask |= PS_RING;
     }
     tcg_gen_andi_i32(cpu_SR[sr], v, mask);
-    gen_helper_check_interrupts(cpu_env);
+    gen_check_interrupts(dc);
     /* This can change mmu index and tb->flags, so exit tb */
     gen_jumpi_check_loop_end(dc, -1);
+    return true;
 }
 
-static void gen_wsr_ccount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool gen_wsr_ccount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
+    if (dc->tb->cflags & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
     gen_helper_wsr_ccount(cpu_env, v);
+    if (dc->tb->cflags & CF_USE_ICOUNT) {
+        gen_io_end();
+        gen_jumpi_check_loop_end(dc, 0);
+        return true;
+    }
+    return false;
 }
 
-static void gen_wsr_icount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool gen_wsr_icount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     if (dc->icount) {
         tcg_gen_mov_i32(dc->next_icount, v);
     } else {
         tcg_gen_mov_i32(cpu_SR[sr], v);
     }
+    return false;
 }
 
-static void gen_wsr_icountlevel(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool gen_wsr_icountlevel(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v, 0xf);
     /* This can change tb->flags, so exit tb */
     gen_jumpi_check_loop_end(dc, -1);
+    return true;
 }
 
-static void gen_wsr_ccompare(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool gen_wsr_ccompare(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     uint32_t id = sr - CCOMPARE;
+    bool ret = false;
+
     if (id < dc->config->nccompare) {
         uint32_t int_bit = 1 << dc->config->timerint[id];
         TCGv_i32 tmp = tcg_const_i32(id);
 
         tcg_gen_mov_i32(cpu_SR[sr], v);
         tcg_gen_andi_i32(cpu_SR[INTSET], cpu_SR[INTSET], ~int_bit);
+        if (dc->tb->cflags & CF_USE_ICOUNT) {
+            gen_io_start();
+        }
         gen_helper_update_ccompare(cpu_env, tmp);
+        if (dc->tb->cflags & CF_USE_ICOUNT) {
+            gen_io_end();
+            gen_jumpi_check_loop_end(dc, 0);
+            ret = true;
+        }
         tcg_temp_free(tmp);
     }
+    return ret;
 }
 
-static void gen_wsr(DisasContext *dc, uint32_t sr, TCGv_i32 s)
+static bool gen_wsr(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
-    static void (* const wsr_handler[256])(DisasContext *dc,
+    static bool (* const wsr_handler[256])(DisasContext *dc,
             uint32_t sr, TCGv_i32 v) = {
         [LBEG] = gen_wsr_lbeg,
         [LEND] = gen_wsr_lend,
@@ -776,9 +842,10 @@ static void gen_wsr(DisasContext *dc, uint32_t sr, TCGv_i32 s)
     };
 
     if (wsr_handler[sr]) {
-        wsr_handler[sr](dc, sr, s);
+        return wsr_handler[sr](dc, sr, s);
     } else {
         tcg_gen_mov_i32(cpu_SR[sr], s);
+        return false;
     }
 }
 
@@ -820,9 +887,17 @@ static void gen_waiti(DisasContext *dc, uint32_t imm4)
 {
     TCGv_i32 pc = tcg_const_i32(dc->next_pc);
     TCGv_i32 intlevel = tcg_const_i32(imm4);
+
+    if (dc->tb->cflags & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
     gen_helper_waiti(cpu_env, pc, intlevel);
+    if (dc->tb->cflags & CF_USE_ICOUNT) {
+        gen_io_end();
+    }
     tcg_temp_free(pc);
     tcg_temp_free(intlevel);
+    gen_jumpi_check_loop_end(dc, 0);
 }
 
 static bool gen_window_check1(DisasContext *dc, unsigned r1)
@@ -1121,7 +1196,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
                         case 0: /*RFEx*/
                             if (gen_check_privilege(dc)) {
                                 tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_EXCM);
-                                gen_helper_check_interrupts(cpu_env);
+                                gen_check_interrupts(dc);
                                 gen_jump(dc, cpu_SR[EPC1]);
                             }
                             break;
@@ -1156,7 +1231,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
                                 }
 
                                 gen_helper_restore_owb(cpu_env);
-                                gen_helper_check_interrupts(cpu_env);
+                                gen_check_interrupts(dc);
                                 gen_jump(dc, cpu_SR[EPC1]);
 
                                 tcg_temp_free(tmp);
@@ -1175,7 +1250,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
                             if (gen_check_privilege(dc)) {
                                 tcg_gen_mov_i32(cpu_SR[PS],
                                                 cpu_SR[EPS2 + RRR_S - 2]);
-                                gen_helper_check_interrupts(cpu_env);
+                                gen_check_interrupts(dc);
                                 gen_jump(dc, cpu_SR[EPC1 + RRR_S - 1]);
                             }
                         } else {
@@ -1233,7 +1308,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
                         tcg_gen_mov_i32(cpu_R[RRR_T], cpu_SR[PS]);
                         tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_INTLEVEL);
                         tcg_gen_ori_i32(cpu_SR[PS], cpu_SR[PS], RRR_S);
-                        gen_helper_check_interrupts(cpu_env);
+                        gen_check_interrupts(dc);
                         gen_jumpi_check_loop_end(dc, 0);
                     }
                     break;
@@ -1521,11 +1596,15 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
                     (RSR_SR < 64 || gen_check_privilege(dc)) &&
                     gen_window_check1(dc, RRR_T)) {
                     TCGv_i32 tmp = tcg_temp_new_i32();
+                    bool rsr_end, wsr_end;
 
                     tcg_gen_mov_i32(tmp, cpu_R[RRR_T]);
-                    gen_rsr(dc, cpu_R[RRR_T], RSR_SR);
-                    gen_wsr(dc, RSR_SR, tmp);
+                    rsr_end = gen_rsr(dc, cpu_R[RRR_T], RSR_SR);
+                    wsr_end = gen_wsr(dc, RSR_SR, tmp);
                     tcg_temp_free(tmp);
+                    if (rsr_end && !wsr_end) {
+                        gen_jumpi_check_loop_end(dc, 0);
+                    }
                 }
                 break;
 
@@ -1746,7 +1825,9 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
                 if (gen_check_sr(dc, RSR_SR, SR_R) &&
                     (RSR_SR < 64 || gen_check_privilege(dc)) &&
                     gen_window_check1(dc, RRR_T)) {
-                    gen_rsr(dc, cpu_R[RRR_T], RSR_SR);
+                    if (gen_rsr(dc, cpu_R[RRR_T], RSR_SR)) {
+                        gen_jumpi_check_loop_end(dc, 0);
+                    }
                 }
                 break;
 
@@ -3062,6 +3143,14 @@ void gen_intermediate_code(CPUXtensaState *env, TranslationBlock *tb)
 
     gen_tb_start(tb);
 
+    if ((tb->cflags & CF_USE_ICOUNT) &&
+        (tb->flags & XTENSA_TBFLAG_YIELD)) {
+        tcg_gen_insn_start(dc.pc);
+        ++insn_count;
+        gen_exception(&dc, EXCP_YIELD);
+        dc.is_jmp = DISAS_UPDATE;
+        goto done;
+    }
     if (tb->flags & XTENSA_TBFLAG_EXCEPTION) {
         tcg_gen_movi_i32(cpu_pc, dc.pc);
         gen_exception(&dc, EXCP_DEBUG);
@@ -3117,7 +3206,7 @@ void gen_intermediate_code(CPUXtensaState *env, TranslationBlock *tb)
             dc.pc < next_page_start &&
             dc.pc + xtensa_insn_len(env, &dc) <= next_page_start &&
             !tcg_op_buf_full());
-
+done:
     reset_litbase(&dc);
     reset_sar_tracker(&dc);
     if (dc.icount) {
-- 
2.1.4
