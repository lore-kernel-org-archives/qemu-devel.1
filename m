Received: from eggs.gnu.org ([2001:4830:134:3::10]:44980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evU3Z-0005fU-Cf
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evU3W-0006rn-2Q
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:28:29 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57035)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evU3V-0006mA-P3
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:28:26 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 12 Mar 2018 21:27:21 +0100
Message-Id: <20180312202728.23790-5-laurent@vivier.eu>
In-Reply-To: <20180312202728.23790-1-laurent@vivier.eu>
References: <20180312202728.23790-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 04/11] target/m68k: implement fsincos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>, Richard Henderson <rth@twiddle.net>

using floatx80_sin() and floatx80_cos()

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/fpu_helper.c | 11 +++++++++++
 target/m68k/helper.h     |  1 +
 target/m68k/translate.c  |  8 ++++++++
 3 files changed, 20 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 71df19c685..36e34d42a8 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -607,3 +607,14 @@ void HELPER(fcos)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_cos(val->d, &env->fp_status);
 }
+
+void HELPER(fsincos)(CPUM68KState *env, FPReg *res0, FPReg *res1, FPReg *val)
+{
+    floatx80 a = val->d;
+    /* If res0 and res1 specify the same floating-point data register,
+     * the sine result is stored in the register, and the cosine
+     * result is discarded.
+     */
+    res1->d = floatx80_cos(a, &env->fp_status);
+    res0->d = floatx80_sin(a, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 767baf75a3..a168ffbaea 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -78,6 +78,7 @@ DEF_HELPER_3(ftentox, void, env, fp, fp)
 DEF_HELPER_3(ftan, void, env, fp, fp)
 DEF_HELPER_3(fsin, void, env, fp, fp)
 DEF_HELPER_3(fcos, void, env, fp, fp)
+DEF_HELPER_4(fsincos, void, env, fp, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index f47388da4b..a78edd8825 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5159,6 +5159,14 @@ DISAS_INSN(fpu)
     case 0x6c: /* fdsub */
         gen_helper_fdsub(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
+    case 0x30: case 0x31: case 0x32:
+    case 0x33: case 0x34: case 0x35:
+    case 0x36: case 0x37: {
+            TCGv_ptr cpu_dest2 = gen_fp_ptr(REG(ext, 0));
+            gen_helper_fsincos(cpu_env, cpu_dest, cpu_dest2, cpu_src);
+            tcg_temp_free_ptr(cpu_dest2);
+        }
+        break;
     case 0x38: /* fcmp */
         gen_helper_fcmp(cpu_env, cpu_src, cpu_dest);
         return;
-- 
2.14.3
