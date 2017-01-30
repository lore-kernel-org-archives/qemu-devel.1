Received: from eggs.gnu.org ([2001:4830:134:3::10]:51367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGWZ-0003OW-HW
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:18:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGWV-0002P3-IV
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:55 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:65309)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cYGWU-0002Lo-DX
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:51 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Jan 2017 19:16:34 +0100
Message-Id: <20170130181634.13934-17-laurent@vivier.eu>
In-Reply-To: <20170130181634.13934-1-laurent@vivier.eu>
References: <20170130181634.13934-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 16/16] target-m68k: add fsincos
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
 target/m68k/fpu_helper.c | 21 +++++++++++++++++++++
 target/m68k/helper.h     |  1 +
 target/m68k/translate.c  | 15 +++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 95d5cc4..9b9d9aa 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -95,6 +95,12 @@ static floatx80 FP1_to_floatx80(CPUM68KState *env)
     return (floatx80){ .low = env->fp1l, .high = env->fp1h };
 }
 
+static void floatx80_to_FP1(CPUM68KState *env, floatx80 res)
+{
+    env->fp1l = res.low;
+    env->fp1h = res.high;
+}
+
 void HELPER(exts32_FP0)(CPUM68KState *env)
 {
     floatx80 res;
@@ -949,3 +955,18 @@ void HELPER(cos_FP0)(CPUM68KState *env)
     res = ldouble_to_floatx80(val);
     floatx80_to_FP0(env, res);
 }
+
+void HELPER(sincos_FP0_FP1)(CPUM68KState *env)
+{
+    floatx80 res;
+    long double val, valsin, valcos;
+
+    val = floatx80_to_ldouble(FP0_to_floatx80(env));
+
+    sincosl(val, &valsin, &valcos);
+    res = ldouble_to_floatx80(valsin);
+    floatx80_to_FP0(env, res);
+    res = ldouble_to_floatx80(valcos);
+    floatx80_to_FP1(env, res);
+
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 600a9a6..16f3370 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -69,6 +69,7 @@ DEF_HELPER_1(log10_FP0, void, env)
 DEF_HELPER_1(cosh_FP0, void, env)
 DEF_HELPER_1(acos_FP0, void, env)
 DEF_HELPER_1(cos_FP0, void, env)
+DEF_HELPER_1(sincos_FP0_FP1, void, env)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 4af6a98..30f8a6f 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -923,6 +923,14 @@ static void gen_op_load_fpr_FP1(int freg)
                    offsetof(CPUM68KState, fregs[freg].l.lower));
 }
 
+static void gen_op_store_fpr_FP1(int freg)
+{
+    tcg_gen_st16_i32(QREG_FP1H, cpu_env,
+                     offsetof(CPUM68KState, fregs[freg].l.upper));
+    tcg_gen_st_i64(QREG_FP1L, cpu_env,
+                   offsetof(CPUM68KState, fregs[freg].l.lower));
+}
+
 static void gen_extend_FP0(int opsize)
 {
     switch (opsize) {
@@ -4773,6 +4781,13 @@ DISAS_INSN(fpu)
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_dsub_FP0_FP1(cpu_env);
         break;
+    case 0x30: case 0x31: case 0x32:
+    case 0x33: case 0x34: case 0x35:
+    case 0x36: case 0x37:
+        gen_helper_sincos_FP0_FP1(cpu_env);
+        gen_op_store_fpr_FP0(REG(ext, 7)); /* sin */
+        gen_op_store_fpr_FP1(REG(ext, 0)); /* cos */
+        break;
     case 0x38: /* fcmp */
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_cmp_FP0_FP1(cpu_env);
-- 
2.9.3
