Received: from eggs.gnu.org ([2001:4830:134:3::10]:46340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cTxQU-0002MD-JU
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:05:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cTxQQ-0006lN-IL
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:05:50 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:55090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cTxQQ-0006kV-08
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:05:46 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 18 Jan 2017 22:05:16 +0100
Message-Id: <1484773521-16530-3-git-send-email-laurent@vivier.eu>
In-Reply-To: <1484773521-16530-1-git-send-email-laurent@vivier.eu>
References: <1484773521-16530-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 2/7] target-m68k: define ext_opsize
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
 target/m68k/translate.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 9f60fbc..d9ba735 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -669,6 +669,21 @@ static inline int insn_opsize(int insn)
     }
 }
 
+static inline int ext_opsize(int ext, int pos)
+{
+    switch ((ext >> pos) & 7) {
+    case 0: return OS_LONG;
+    case 1: return OS_SINGLE;
+    case 2: return OS_EXTENDED;
+    case 3: return OS_PACKED;
+    case 4: return OS_WORD;
+    case 5: return OS_DOUBLE;
+    case 6: return OS_BYTE;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /* Assign value to a register.  If the width is less than the register width
    only the low part of the register is set.  */
 static void gen_partset_reg(int opsize, TCGv reg, TCGv val)
@@ -4101,20 +4116,19 @@ DISAS_INSN(fpu)
         tmp32 = tcg_temp_new_i32();
         /* fmove */
         /* ??? TODO: Proper behavior on overflow.  */
-        switch ((ext >> 10) & 7) {
-        case 0:
-            opsize = OS_LONG;
+
+        opsize = ext_opsize(ext, 10);
+        switch (opsize) {
+        case OS_LONG:
             gen_helper_f64_to_i32(tmp32, cpu_env, src);
             break;
-        case 1:
-            opsize = OS_SINGLE;
+        case OS_SINGLE:
             gen_helper_f64_to_f32(tmp32, cpu_env, src);
             break;
-        case 4:
-            opsize = OS_WORD;
+        case OS_WORD:
             gen_helper_f64_to_i32(tmp32, cpu_env, src);
             break;
-        case 5: /* OS_DOUBLE */
+        case OS_DOUBLE:
             tcg_gen_mov_i32(tmp32, AREG(insn, 0));
             switch ((insn >> 3) & 7) {
             case 2:
@@ -4143,8 +4157,7 @@ DISAS_INSN(fpu)
             }
             tcg_temp_free_i32(tmp32);
             return;
-        case 6:
-            opsize = OS_BYTE;
+        case OS_BYTE:
             gen_helper_f64_to_i32(tmp32, cpu_env, src);
             break;
         default:
@@ -4217,15 +4230,7 @@ DISAS_INSN(fpu)
     }
     if (ext & (1 << 14)) {
         /* Source effective address.  */
-        switch ((ext >> 10) & 7) {
-        case 0: opsize = OS_LONG; break;
-        case 1: opsize = OS_SINGLE; break;
-        case 4: opsize = OS_WORD; break;
-        case 5: opsize = OS_DOUBLE; break;
-        case 6: opsize = OS_BYTE; break;
-        default:
-            goto undef;
-        }
+        opsize = ext_opsize(ext, 10);
         if (opsize == OS_DOUBLE) {
             tmp32 = tcg_temp_new_i32();
             tcg_gen_mov_i32(tmp32, AREG(insn, 0));
-- 
2.7.4
