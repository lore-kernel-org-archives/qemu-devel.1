Received: from eggs.gnu.org ([2001:4830:134:3::10]:51247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGWN-0003F8-5m
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGWJ-0002HO-6A
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:43 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:50256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cYGWI-0002Gy-Q6
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:39 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Jan 2017 19:16:27 +0100
Message-Id: <20170130181634.13934-10-laurent@vivier.eu>
In-Reply-To: <20170130181634.13934-1-laurent@vivier.eu>
References: <20170130181634.13934-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 09/16] target-m68k: add fmovem
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
 target/m68k/fpu_helper.c |  6 +++
 target/m68k/helper.h     |  1 +
 target/m68k/translate.c  | 99 +++++++++++++++++++++++++++++++++++-------------
 3 files changed, 80 insertions(+), 26 deletions(-)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 1e68c41..aadfc82 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -421,3 +421,9 @@ void HELPER(update_fpstatus)(CPUM68KState *env)
 
     set_float_exception_flags(flags, &env->fp_status);
 }
+
+void HELPER(fmovem)(CPUM68KState *env, uint32_t opsize,
+                    uint32_t mode, uint32_t mask)
+{
+    fprintf(stderr, "MISSING HELPER fmovem\n");
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 072a6d0..58bc273 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -31,6 +31,7 @@ DEF_HELPER_1(cmp_FP0_FP1, void, env)
 DEF_HELPER_2(set_fpcr, void, env, i32)
 DEF_HELPER_1(tst_FP0, void, env)
 DEF_HELPER_1(update_fpstatus, void, env)
+DEF_HELPER_4(fmovem, void, env, i32, i32, i32)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 030773b..699c939 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4483,13 +4483,79 @@ static void gen_op_fmove_fcr(CPUM68KState *env, DisasContext *s,
     tcg_temp_free_i32(addr);
 }
 
+static void gen_op_fmovem(CPUM68KState *env, DisasContext *s,
+                          uint32_t insn, uint32_t ext)
+{
+    int opsize;
+    uint16_t mask;
+    int i;
+    uint32_t mode;
+    int32_t incr;
+    TCGv addr, tmp;
+    int is_load;
+
+    if (m68k_feature(s->env, M68K_FEATURE_FPU)) {
+        opsize = OS_EXTENDED;
+    } else {
+        opsize = OS_DOUBLE;  /* FIXME */
+    }
+
+    mode = (ext >> 11) & 0x3;
+    if ((mode & 0x1) == 1) {
+        gen_helper_fmovem(cpu_env, tcg_const_i32(opsize),
+                          tcg_const_i32(mode), DREG(ext, 0));
+        return;
+    }
+
+    tmp = gen_lea(env, s, insn, opsize);
+    if (IS_NULL_QREG(tmp)) {
+        gen_addr_fault(s);
+        return;
+    }
+
+    addr = tcg_temp_new();
+    tcg_gen_mov_i32(addr, tmp);
+    is_load = ((ext & 0x2000) == 0);
+    incr = opsize_bytes(opsize);
+    mask = ext & 0x00FF;
+
+    if (!is_load && (mode & 2) == 0) {
+        for (i = 7; i >= 0; i--, mask <<= 1) {
+            if (mask & 0x80) {
+                gen_op_load_fpr_FP0(i);
+                gen_store_FP0(s, opsize, addr);
+                if ((mask & 0xff) != 0x80) {
+                    tcg_gen_subi_i32(addr, addr, incr);
+                }
+            }
+        }
+        tcg_gen_mov_i32(AREG(insn, 0), addr);
+    } else {
+        for (i = 0; i < 8; i++, mask <<= 1) {
+            if (mask & 0x80) {
+                if (is_load) {
+                    gen_load_FP0(s, opsize, addr);
+                    gen_op_store_fpr_FP0(i);
+                } else {
+                    gen_op_load_fpr_FP0(i);
+                    gen_store_FP0(s, opsize, addr);
+                }
+                tcg_gen_addi_i32(addr, addr, incr);
+            }
+        }
+        if ((insn & 070) == 030) {
+            tcg_gen_mov_i32(AREG(insn, 0), addr);
+        }
+    }
+    tcg_temp_free_i32(addr);
+}
+
 /* ??? FP exceptions are not implemented.  Most exceptions are deferred until
    immediately before the next FP instruction is executed.  */
 DISAS_INSN(fpu)
 {
     uint16_t ext;
     int opmode;
-    TCGv tmp32;
     int opsize;
 
     ext = read_im16(env, s);
@@ -4514,32 +4580,13 @@ DISAS_INSN(fpu)
         return;
     case 6: /* fmovem */
     case 7:
-        {
-            TCGv addr;
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
-            for (i = 0; i < 8; i++) {
-                if (ext & mask) {
-                    gen_op_load_fpr_FP0(REG(i, 0));
-                    gen_ldst_FP0(s, OS_DOUBLE, addr, (ext & (1 << 13)) ?
-                                                     EA_STORE : EA_LOADS);
-                    if (ext & (mask - 1))
-                        tcg_gen_addi_i32(addr, addr, 8);
-                }
-                mask >>= 1;
-            }
-            tcg_temp_free_i32(addr);
+        if ((ext & 0xf00) != 0 || (ext & 0xff) == 0) {
+            goto undef;
+        }
+        if ((ext & 0x1000) == 0 && !m68k_feature(s->env, M68K_FEATURE_FPU)) {
+            goto undef;
         }
+        gen_op_fmovem(env, s, insn, ext);
         return;
     }
     if (ext & (1 << 14)) {
-- 
2.9.3
