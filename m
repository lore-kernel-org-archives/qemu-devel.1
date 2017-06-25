Received: from eggs.gnu.org ([2001:4830:134:3::10]:46791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dPD6o-0005xQ-1g
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dPD6j-0003o7-B0
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:22:10 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:63589)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dPD6i-0003ne-VY
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:22:05 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 25 Jun 2017 21:21:25 +0200
Message-Id: <20170625192125.9992-8-laurent@vivier.eu>
In-Reply-To: <20170625192125.9992-1-laurent@vivier.eu>
References: <20170625192125.9992-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 7/7] target/m68k: add fmovem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/fpu_helper.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/helper.h     |   1 +
 target/m68k/translate.c  |  59 +++++++++++++--------------
 3 files changed, 133 insertions(+), 30 deletions(-)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 38370d0..3e765d6 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 
 static const floatx80 fpu_rom[128] = {
     [0x00] = floatx80_pi,                                   /* Pi */
@@ -378,3 +379,105 @@ void HELPER(fconst)(CPUM68KState *env, FPReg *val, uint32_t offset)
 {
     val->d = fpu_rom[offset];
 }
+
+static void cpu_ld_floatx80_ra(CPUM68KState *env, FPReg *fp,  uint32_t addr,
+                               uintptr_t ra)
+{
+    uint32_t high;
+    uint64_t low;
+
+    high = cpu_ldl_data_ra(env, addr, ra);
+    low = cpu_ldq_data_ra(env, addr + 4, ra);
+
+    fp->l.upper = high >> 16;
+    fp->l.lower = low;
+}
+
+static void cpu_st_floatx80_ra(CPUM68KState *env, uint32_t addr, FPReg *fp,
+                               uintptr_t ra)
+{
+    cpu_stl_data_ra(env, addr, fp->l.upper << 16, ra);
+    cpu_stq_data_ra(env, addr + 4, fp->l.lower, ra);
+}
+
+static void cpu_ld_float64_ra(CPUM68KState *env, FPReg *fp,  uint32_t addr,
+                              uintptr_t ra)
+{
+    uint64_t val;
+
+    val = cpu_ldq_data_ra(env, addr, ra);
+    fp->d = float64_to_floatx80(*(float64 *)&val, &env->fp_status);
+}
+
+static void cpu_st_float64_ra(CPUM68KState *env, uint32_t addr, FPReg *fp,
+                              uintptr_t ra)
+{
+    float64 val;
+
+    val = floatx80_to_float64(fp->d, &env->fp_status);
+    cpu_stq_data_ra(env, addr, *(uint64_t *)&val, ra);
+}
+
+uint32_t HELPER(fmovem)(CPUM68KState *env, uint32_t addr, uint32_t ext)
+{
+    uintptr_t ra = GETPC();
+    int mode = (ext >> 11) & 0x3;
+    int is_load = ((ext & 0x2000) == 0);
+    uint16_t mask;
+    int incr, i;
+
+    if (m68k_feature(env, M68K_FEATURE_FPU)) {
+        incr = 12;
+    } else {
+        incr = 8;
+    }
+
+    if ((mode & 0x1) == 1) {
+        /* Dynamic register list */
+        int reg = extract32(ext, 4, 3);
+        mask = env->dregs[reg] & 0x00FF;
+    } else {
+        /* Static register list */
+        mask = ext & 0x00FF;
+    }
+
+    if (!is_load && (mode & 2) == 0) {
+        /* predecrement addressing mode
+         * only available to store register to memory
+         */
+        for (i = 7; i >= 0; i--, mask <<= 1) {
+            if (mask & 0x80) {
+                if (incr == 8) {
+                    cpu_st_float64_ra(env, addr, &env->fregs[i], ra);
+                } else {
+                    cpu_st_floatx80_ra(env, addr, &env->fregs[i], ra);
+                }
+                if ((mask & 0xff) != 0x80) {
+                    addr -= incr;
+                }
+            }
+        }
+        return addr;
+    }
+    /* postincrement addressing mode */
+    for (i = 0; i < 8; i++, mask <<= 1) {
+        if (mask & 0x80) {
+            if (is_load) {
+                if (incr == 8) {
+                    cpu_ld_float64_ra(env, &env->fregs[i], addr, ra);
+                } else {
+                    cpu_ld_floatx80_ra(env, &env->fregs[i], addr, ra);
+                }
+            } else {
+                if (incr == 8) {
+                    cpu_st_float64_ra(env, addr, &env->fregs[i], ra);
+                } else {
+                    cpu_st_floatx80_ra(env, addr, &env->fregs[i], ra);
+                }
+            }
+            addr += incr;
+        }
+    }
+
+    return addr;
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index b396899..eb3d243 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -54,6 +54,7 @@ DEF_HELPER_FLAGS_3(fcmp, TCG_CALL_NO_RWG, void, env, fp, fp)
 DEF_HELPER_FLAGS_2(set_fpcr, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(ftst, TCG_CALL_NO_RWG, void, env, fp)
 DEF_HELPER_3(fconst, void, env, fp, i32)
+DEF_HELPER_3(fmovem, i32, env, i32, i32)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 3a1bdc1..5061619 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4505,6 +4505,32 @@ static void gen_op_fmove_fcr(CPUM68KState *env, DisasContext *s,
     tcg_temp_free_i32(addr);
 }
 
+static void gen_op_fmovem(CPUM68KState *env, DisasContext *s,
+                          uint32_t insn, uint32_t ext)
+{
+    int opsize;
+    TCGv addr, tmp;
+
+    if (m68k_feature(s->env, M68K_FEATURE_FPU)) {
+        opsize = OS_EXTENDED;
+    } else {
+        opsize = OS_DOUBLE;  /* FIXME */
+    }
+
+    addr = gen_lea(env, s, insn, opsize);
+    if (IS_NULL_QREG(addr)) {
+        gen_addr_fault(s);
+        return;
+    }
+
+    tmp = tcg_const_i32(ext);
+    gen_helper_fmovem(tmp, cpu_env, addr, tmp);
+    if ((insn & 070) == 030 || (insn & 070) == 040) {
+        tcg_gen_mov_i32(AREG(insn, 0), tmp);
+    }
+    tcg_temp_free(tmp);
+}
+
 /* ??? FP exceptions are not implemented.  Most exceptions are deferred until
    immediately before the next FP instruction is executed.  */
 DISAS_INSN(fpu)
@@ -4512,7 +4538,6 @@ DISAS_INSN(fpu)
     uint16_t ext;
     uint8_t rom_offset;
     int opmode;
-    TCGv tmp32;
     int opsize;
     TCGv_ptr cpu_src, cpu_dest;
 
@@ -4548,36 +4573,10 @@ DISAS_INSN(fpu)
         return;
     case 6: /* fmovem */
     case 7:
-        {
-            TCGv addr;
-            TCGv_ptr fp;
-            uint16_t mask;
-            int i;
-            if ((ext & 0x1f00) != 0x1000 || (ext & 0xff) == 0)
-                goto undef;
-            tmp32 = gen_lea(env, s, insn, OS_LONG);
-            if (IS_NULL_QREG(tmp32)) {
-                gen_addr_fault(s);
-                return;
-            }
-            addr = tcg_temp_new_i32();
-            tcg_gen_mov_i32(addr, tmp32);
-            mask = 0x80;
-            fp = tcg_temp_new_ptr();
-            for (i = 0; i < 8; i++) {
-                if (ext & mask) {
-                    tcg_gen_addi_ptr(fp, cpu_env,
-                                     offsetof(CPUM68KState, fregs[i]));
-                    gen_ldst_fp(s, OS_DOUBLE, addr, fp,
-                                (ext & (1 << 13)) ?  EA_STORE : EA_LOADS);
-                    if (ext & (mask - 1))
-                        tcg_gen_addi_i32(addr, addr, 8);
-                }
-                mask >>= 1;
-            }
-            tcg_temp_free_i32(addr);
-            tcg_temp_free_ptr(fp);
+        if ((ext & 0x1000) == 0 && !m68k_feature(s->env, M68K_FEATURE_FPU)) {
+            goto undef;
         }
+        gen_op_fmovem(env, s, insn, ext);
         return;
     }
     if (ext & (1 << 14)) {
-- 
2.9.4
