Received: from eggs.gnu.org ([2001:4830:134:3::10]:56776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dPc7B-0007DD-Nz
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dPc79-0005DI-Lq
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:13 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:54172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dPc79-0005Ca-9M
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:11 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 27 Jun 2017 00:03:30 +0200
Message-Id: <20170626220330.6785-8-laurent@vivier.eu>
In-Reply-To: <20170626220330.6785-1-laurent@vivier.eu>
References: <20170626220330.6785-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 7/7] target/m68k: add fmovem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/fpu_helper.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/helper.h     |   6 +++
 target/m68k/translate.c  |  93 ++++++++++++++++++++++++------------
 3 files changed, 189 insertions(+), 30 deletions(-)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index c07ab05..3e38151 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 
 static const floatx80 fpu_rom[128] = {
     [0x00] = floatx80_pi,                                   /* Pi */
@@ -378,3 +379,122 @@ void HELPER(fconst)(CPUM68KState *env, FPReg *val, uint32_t offset)
 {
     val->d = fpu_rom[offset];
 }
+
+typedef int (*float_access)(CPUM68KState *env, uint32_t addr, FPReg *fp,
+                            uintptr_t ra);
+
+static uint32_t fmovem_predec(CPUM68KState *env, uint32_t addr, uint32_t mask,
+                               float_access access)
+{
+    uintptr_t ra = GETPC();
+    int i, size;
+
+    for (i = 7; i >= 0; i--, mask <<= 1) {
+        if (mask & 0x80) {
+            size = access(env, addr, &env->fregs[i], ra);
+            if ((mask & 0xff) != 0x80) {
+                addr -= size;
+            }
+        }
+    }
+
+    return addr;
+}
+
+static uint32_t fmovem_postinc(CPUM68KState *env, uint32_t addr, uint32_t mask,
+                               float_access access)
+{
+    uintptr_t ra = GETPC();
+    int i, size;
+
+    for (i = 0; i < 8; i++, mask <<= 1) {
+        if (mask & 0x80) {
+            size = access(env, addr, &env->fregs[i], ra);
+            addr += size;
+        }
+    }
+
+    return addr;
+}
+
+static int cpu_ld_floatx80_ra(CPUM68KState *env, uint32_t addr, FPReg *fp,
+                              uintptr_t ra)
+{
+    uint32_t high;
+    uint64_t low;
+
+    high = cpu_ldl_data_ra(env, addr, ra);
+    low = cpu_ldq_data_ra(env, addr + 4, ra);
+
+    fp->l.upper = high >> 16;
+    fp->l.lower = low;
+
+    return 12;
+}
+
+static int cpu_st_floatx80_ra(CPUM68KState *env, uint32_t addr, FPReg *fp,
+                               uintptr_t ra)
+{
+    cpu_stl_data_ra(env, addr, fp->l.upper << 16, ra);
+    cpu_stq_data_ra(env, addr + 4, fp->l.lower, ra);
+
+    return 12;
+}
+
+static int cpu_ld_float64_ra(CPUM68KState *env, uint32_t addr, FPReg *fp,
+                             uintptr_t ra)
+{
+    uint64_t val;
+
+    val = cpu_ldq_data_ra(env, addr, ra);
+    fp->d = float64_to_floatx80(*(float64 *)&val, &env->fp_status);
+
+    return 8;
+}
+
+static int  cpu_st_float64_ra(CPUM68KState *env, uint32_t addr, FPReg *fp,
+                             uintptr_t ra)
+{
+    float64 val;
+
+    val = floatx80_to_float64(fp->d, &env->fp_status);
+    cpu_stq_data_ra(env, addr, *(uint64_t *)&val, ra);
+
+    return 8;
+}
+
+uint32_t HELPER(fmovemx_st_predec)(CPUM68KState *env, uint32_t addr,
+                                   uint32_t mask)
+{
+    return fmovem_predec(env, addr, mask, cpu_st_floatx80_ra);
+}
+
+uint32_t HELPER(fmovemx_st_postinc)(CPUM68KState *env, uint32_t addr,
+                                    uint32_t mask)
+{
+    return fmovem_postinc(env, addr, mask, cpu_st_floatx80_ra);
+}
+
+uint32_t HELPER(fmovemx_ld_postinc)(CPUM68KState *env, uint32_t addr,
+                                    uint32_t mask)
+{
+    return fmovem_postinc(env, addr, mask, cpu_ld_floatx80_ra);
+}
+
+uint32_t HELPER(fmovemd_st_predec)(CPUM68KState *env, uint32_t addr,
+                                   uint32_t mask)
+{
+    return fmovem_predec(env, addr, mask, cpu_st_float64_ra);
+}
+
+uint32_t HELPER(fmovemd_st_postinc)(CPUM68KState *env, uint32_t addr,
+                                    uint32_t mask)
+{
+    return fmovem_postinc(env, addr, mask, cpu_st_float64_ra);
+}
+
+uint32_t HELPER(fmovemd_ld_postinc)(CPUM68KState *env, uint32_t addr,
+                                    uint32_t mask)
+{
+    return fmovem_postinc(env, addr, mask, cpu_ld_float64_ra);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index b396899..475a1f2 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -54,6 +54,12 @@ DEF_HELPER_FLAGS_3(fcmp, TCG_CALL_NO_RWG, void, env, fp, fp)
 DEF_HELPER_FLAGS_2(set_fpcr, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(ftst, TCG_CALL_NO_RWG, void, env, fp)
 DEF_HELPER_3(fconst, void, env, fp, i32)
+DEF_HELPER_3(fmovemx_st_predec, i32, env, i32, i32)
+DEF_HELPER_3(fmovemx_st_postinc, i32, env, i32, i32)
+DEF_HELPER_3(fmovemx_ld_postinc, i32, env, i32, i32)
+DEF_HELPER_3(fmovemd_st_predec, i32, env, i32, i32)
+DEF_HELPER_3(fmovemd_st_postinc, i32, env, i32, i32)
+DEF_HELPER_3(fmovemd_ld_postinc, i32, env, i32, i32)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index e120935..71cfc70 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4505,6 +4505,66 @@ static void gen_op_fmove_fcr(CPUM68KState *env, DisasContext *s,
     tcg_temp_free_i32(addr);
 }
 
+static void gen_op_fmovem(CPUM68KState *env, DisasContext *s,
+                          uint32_t insn, uint32_t ext)
+{
+    int opsize;
+    TCGv addr, tmp;
+    int mode = (ext >> 11) & 0x3;
+    int is_load = ((ext & 0x2000) == 0);
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
+    tmp = tcg_temp_new();
+    if (mode & 0x1) {
+        /* Dynamic register list */
+        tcg_gen_ext8u_i32(tmp, DREG(ext, 4));
+    } else {
+        /* Static register list */
+        tcg_gen_movi_i32(tmp, ext & 0xff);
+    }
+
+    if (!is_load && (mode & 2) == 0) {
+        /* predecrement addressing mode
+         * only available to store register to memory
+         */
+        if (opsize == OS_EXTENDED) {
+            gen_helper_fmovemx_st_predec(tmp, cpu_env, addr, tmp);
+        } else {
+            gen_helper_fmovemd_st_predec(tmp, cpu_env, addr, tmp);
+        }
+    } else {
+        /* postincrement addressing mode */
+        if (opsize == OS_EXTENDED) {
+            if (is_load) {
+                gen_helper_fmovemx_ld_postinc(tmp, cpu_env, addr, tmp);
+            } else {
+                gen_helper_fmovemx_st_postinc(tmp, cpu_env, addr, tmp);
+            }
+        } else {
+            if (is_load) {
+                gen_helper_fmovemd_ld_postinc(tmp, cpu_env, addr, tmp);
+            } else {
+                gen_helper_fmovemd_st_postinc(tmp, cpu_env, addr, tmp);
+            }
+        }
+    }
+    if ((insn & 070) == 030 || (insn & 070) == 040) {
+        tcg_gen_mov_i32(AREG(insn, 0), tmp);
+    }
+    tcg_temp_free(tmp);
+}
+
 /* ??? FP exceptions are not implemented.  Most exceptions are deferred until
    immediately before the next FP instruction is executed.  */
 DISAS_INSN(fpu)
@@ -4512,7 +4572,6 @@ DISAS_INSN(fpu)
     uint16_t ext;
     uint8_t rom_offset;
     int opmode;
-    TCGv tmp32;
     int opsize;
     TCGv_ptr cpu_src, cpu_dest;
 
@@ -4548,36 +4607,10 @@ DISAS_INSN(fpu)
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
