Received: from eggs.gnu.org ([2001:4830:134:3::10]:58714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYgZJ-0008Dc-N0
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYgZG-0007jD-Cc
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:11:01 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:61178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eYgZG-0007fi-1i
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:10:58 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  9 Jan 2018 00:10:46 +0100
Message-Id: <20180108231048.23966-5-laurent@vivier.eu>
In-Reply-To: <20180108231048.23966-1-laurent@vivier.eu>
References: <20180108231048.23966-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 4/6] target/m68k: add moves
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

and introduce SFC and DFC control registers.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.h       |  2 ++
 target/m68k/helper.c    | 82 +++++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/helper.h    |  2 ++
 target/m68k/monitor.c   |  2 ++
 target/m68k/op_helper.c |  4 +--
 target/m68k/qregs.def   |  2 ++
 target/m68k/translate.c | 74 ++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 166 insertions(+), 2 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 60e669c3b4..4877be93ec 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -137,6 +137,8 @@ typedef struct CPUM68KState {
     uint32_t mbar;
     uint32_t rambar0;
     uint32_t cacr;
+    uint32_t sfc;
+    uint32_t dfc;
 
     int pending_vector;
     int pending_level;
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index c5b436d382..090f50fa05 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "exec/gdbstub.h"
 
 #include "exec/helper-proto.h"
@@ -203,6 +204,12 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
 
     switch (reg) {
     /* MC680[1234]0 */
+    case M68K_CR_SFC:
+        env->sfc = val & 7;
+        return;
+    case M68K_CR_DFC:
+        env->dfc = val & 7;
+        return;
     case M68K_CR_VBR:
         env->vbr = val;
         return;
@@ -254,6 +261,10 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
 
     switch (reg) {
     /* MC680[1234]0 */
+    case M68K_CR_SFC:
+        return env->sfc;
+    case M68K_CR_DFC:
+        return env->dfc;
     case M68K_CR_VBR:
         return env->vbr;
     /* MC680[234]0 */
@@ -1066,6 +1077,77 @@ void HELPER(set_mac_extu)(CPUM68KState *env, uint32_t val, uint32_t acc)
 }
 
 #if defined(CONFIG_SOFTMMU)
+void HELPER(moves_store)(CPUM68KState *env, uint32_t val,
+                         uint32_t addr, uint32_t size)
+{
+    if (env->dfc & 4) { /* kernel */
+        switch (size) {
+        case OS_BYTE:
+            cpu_stb_kernel_ra(env, addr, val, GETPC());
+            break;
+        case OS_WORD:
+            cpu_stw_kernel_ra(env, addr, val, GETPC());
+            break;
+        case OS_LONG:
+            cpu_stl_kernel_ra(env, addr, val, GETPC());
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else { /* user */
+        switch (size) {
+        case OS_BYTE:
+            cpu_stb_user_ra(env, addr, val, GETPC());
+            break;
+        case OS_WORD:
+            cpu_stw_user_ra(env, addr, val, GETPC());
+            break;
+        case OS_LONG:
+            cpu_stl_user_ra(env, addr, val, GETPC());
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+}
+
+uint32_t HELPER(moves_load)(CPUM68KState *env, uint32_t addr, uint32_t size)
+{
+    uint32_t val;
+
+    if (env->sfc & 4) { /* kernel */
+        switch (size) {
+        case OS_BYTE:
+            val = cpu_ldub_kernel_ra(env, addr, GETPC());
+            break;
+        case OS_WORD:
+            val = cpu_lduw_kernel_ra(env, addr, GETPC());
+            break;
+        case OS_LONG:
+            val = cpu_ldl_kernel_ra(env, addr, GETPC());
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else { /* user */
+        switch (size) {
+        case OS_BYTE:
+            val = cpu_ldub_user_ra(env, addr, GETPC());
+            break;
+        case OS_WORD:
+            val = cpu_lduw_user_ra(env, addr, GETPC());
+            break;
+        case OS_LONG:
+            val = cpu_ldl_user_ra(env, addr, GETPC());
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    return val;
+}
+
 void HELPER(reset)(CPUM68KState *env)
 {
     /* FIXME: reset all except CPU */
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 57f210aa14..620c6d5686 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -101,5 +101,7 @@ DEF_HELPER_3(chk, void, env, s32, s32)
 DEF_HELPER_4(chk2, void, env, s32, s32, s32)
 
 #if defined(CONFIG_SOFTMMU)
+DEF_HELPER_FLAGS_4(moves_store, TCG_CALL_NO_WG, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_3(moves_load, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_1(reset, TCG_CALL_NO_RWG, void, env)
 #endif
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index a20af6b09c..c31feb4b02 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -31,6 +31,8 @@ static const MonitorDef monitor_defs[] = {
     { "ssp", offsetof(CPUM68KState, sp[0]) },
     { "usp", offsetof(CPUM68KState, sp[1]) },
     { "isp", offsetof(CPUM68KState, sp[2]) },
+    { "sfc", offsetof(CPUM68KState, sfc) },
+    { "dfc", offsetof(CPUM68KState, dfc) },
     { "urp", offsetof(CPUM68KState, mmu.urp) },
     { "srp", offsetof(CPUM68KState, mmu.srp) },
     { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]) },
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 83ac1e669e..6bf16695ac 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -400,8 +400,8 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
         mmu_fault = 0;
         if (qemu_loglevel_mask(CPU_LOG_INT)) {
             qemu_log("            "
-                     "ssw:  %08x ea:   %08x\n",
-                     env->mmu.ssw, env->mmu.ar);
+                     "ssw:  %08x ea:   %08x sfc:  %d    dfc: %d\n",
+                     env->mmu.ssw, env->mmu.ar, env->sfc, env->dfc);
         }
     } else if (cs->exception_index == EXCP_ADDRESS) {
         do_stack_frame(env, &sp, 2, oldsr, 0, retaddr);
diff --git a/target/m68k/qregs.def b/target/m68k/qregs.def
index 1aadc622db..efe2bf90ee 100644
--- a/target/m68k/qregs.def
+++ b/target/m68k/qregs.def
@@ -1,5 +1,7 @@
 DEFO32(PC, pc)
 DEFO32(SR, sr)
+DEFO32(DFC, dfc)
+DEFO32(SFC, sfc)
 DEFO32(CC_OP, cc_op)
 DEFO32(CC_X, cc_x)
 DEFO32(CC_C, cc_c)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index af70825480..7cb0e12ee7 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -48,6 +48,8 @@ static char cpu_reg_names[2 * 8 * 3 + 5 * 4];
 static TCGv cpu_dregs[8];
 static TCGv cpu_aregs[8];
 static TCGv_i64 cpu_macc[4];
+static TCGv QEMU_DFC;
+static TCGv QEMU_SFC;
 
 #define REG(insn, pos)  (((insn) >> (pos)) & 7)
 #define DREG(insn, pos) cpu_dregs[REG(insn, pos)]
@@ -103,6 +105,10 @@ void m68k_tcg_init(void)
         p += 5;
     }
 
+    QEMU_DFC = tcg_global_mem_new(cpu_env, offsetof(CPUM68KState, dfc),
+                                  "DFC");
+    QEMU_SFC = tcg_global_mem_new(cpu_env, offsetof(CPUM68KState, sfc),
+                                  "SFC");
     NULL_QREG = tcg_global_mem_new(cpu_env, -4, "NULL");
     store_dummy = tcg_global_mem_new(cpu_env, -8, "NULL");
 }
@@ -4449,6 +4455,70 @@ DISAS_INSN(move_from_sr)
 }
 
 #if defined(CONFIG_SOFTMMU)
+DISAS_INSN(moves)
+{
+    int opsize;
+    uint16_t ext;
+    TCGv reg;
+    TCGv addr;
+    TCGv size;
+    int extend;
+
+    if (IS_USER(s)) {
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        return;
+    }
+
+    ext = read_im16(env, s);
+
+    opsize = insn_opsize(insn);
+
+    if (ext & 0x8000) {
+        /* address register */
+        reg = AREG(ext, 12);
+        extend = 1;
+    } else {
+        /* data register */
+        reg = DREG(ext, 12);
+        extend = 0;
+    }
+
+    addr = gen_lea(env, s, insn, opsize);
+    if (IS_NULL_QREG(addr)) {
+        gen_addr_fault(s);
+        return;
+    }
+
+    size = tcg_const_i32(opsize);
+    if (ext & 0x0800) {
+        /* from reg to ea */
+        gen_helper_moves_store(cpu_env, reg, addr, size);
+    } else {
+        /* from ea to reg */
+        TCGv tmp = tcg_temp_new();
+        gen_helper_moves_load(tmp, cpu_env, addr, size);
+        if (extend) {
+            gen_ext(reg, tmp, opsize, 1);
+        } else {
+            gen_partset_reg(opsize, reg, tmp);
+        }
+        tcg_temp_free(tmp);
+    }
+    tcg_temp_free(size);
+
+    switch (extract32(insn, 3, 3)) {
+    case 3: /* Indirect postincrement.  */
+        tcg_gen_addi_i32(AREG(insn, 0), addr,
+                         REG(insn, 0) == 7 && opsize == OS_BYTE
+                         ? 2
+                         : opsize_bytes(opsize));
+        break;
+    case 4: /* Indirect predecrememnt.  */
+        tcg_gen_mov_i32(AREG(insn, 0), addr);
+        break;
+    }
+}
+
 DISAS_INSN(move_to_sr)
 {
     if (IS_USER(s)) {
@@ -5601,6 +5671,9 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(bitop_im,  08c0, ffc0);
     INSN(arith_im,  0a80, fff8, CF_ISA_A);
     INSN(arith_im,  0a00, ff00, M68000);
+#if defined(CONFIG_SOFTMMU)
+    INSN(moves,     0e00, ff00, M68000);
+#endif
     INSN(cas,       0ac0, ffc0, CAS);
     INSN(cas,       0cc0, ffc0, CAS);
     INSN(cas,       0ec0, ffc0, CAS);
@@ -5981,6 +6054,7 @@ void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                env->current_sp == M68K_USP ? "->" : "  ", env->sp[M68K_USP],
                env->current_sp == M68K_ISP ? "->" : "  ", env->sp[M68K_ISP]);
     cpu_fprintf(f, "VBR = 0x%08x\n", env->vbr);
+    cpu_fprintf(f, "SFC = %x DFC %x\n", env->sfc, env->dfc);
     cpu_fprintf(f, "SSW %08x TCR %08x URP %08x SRP %08x\n",
                 env->mmu.ssw, env->mmu.tcr, env->mmu.urp, env->mmu.srp);
     cpu_fprintf(f, "DTTR0/1: %08x/%08x ITTR0/1: %08x/%08x\n",
-- 
2.14.3
