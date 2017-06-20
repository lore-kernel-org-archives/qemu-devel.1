Received: from eggs.gnu.org ([2001:4830:134:3::10]:55329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dNQ7z-0008AD-KA
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 16:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dNQ7u-0004C3-RN
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 16:51:59 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:65270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dNQ7u-0004BV-Gp
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 16:51:54 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 20 Jun 2017 22:51:16 +0200
Message-Id: <20170620205121.26515-2-laurent@vivier.eu>
In-Reply-To: <20170620205121.26515-1-laurent@vivier.eu>
References: <20170620205121.26515-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v5 1/6] target-m68k: move fmove CR to a function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Move code of fmove to/from control register to a function

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 56 +++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index dfecfb6..c9a5fe4 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4099,6 +4099,35 @@ DISAS_INSN(trap)
     gen_exception(s, s->pc - 2, EXCP_TRAP0 + (insn & 0xf));
 }
 
+static void gen_op_fmove_fcr(CPUM68KState *env, DisasContext *s,
+                             uint32_t insn, uint32_t ext)
+{
+    int mask = (ext >> 10) & 7;
+    int is_write = (ext >> 13) & 1;
+    TCGv val;
+
+    switch (mask) {
+    case 1: /* FPIAR */
+    case 2: /* FPSR */
+    default:
+        qemu_log_mask(LOG_UNIMP, "Unimplemented: fmove to/from control %d",
+                      mask);
+        goto undef;
+    case 4: /* FPCR */
+        if (is_write) {
+            val = tcg_const_i32(0);
+            DEST_EA(env, insn, OS_LONG, val, NULL);
+            tcg_temp_free(val);
+        }
+        /* Not implemented. Ignore register update */
+        break;
+    }
+    return;
+undef:
+    s->pc -= 2;
+    disas_undef_fpu(env, s, insn);
+}
+
 /* ??? FP exceptions are not implemented.  Most exceptions are deferred until
    immediately before the next FP instruction is executed.  */
 DISAS_INSN(fpu)
@@ -4177,32 +4206,9 @@ DISAS_INSN(fpu)
         tcg_temp_free_i32(tmp32);
         return;
     case 4: /* fmove to control register.  */
-        switch ((ext >> 10) & 7) {
-        case 4: /* FPCR */
-            /* Not implemented.  Ignore writes.  */
-            break;
-        case 1: /* FPIAR */
-        case 2: /* FPSR */
-        default:
-            cpu_abort(NULL, "Unimplemented: fmove to control %d",
-                      (ext >> 10) & 7);
-        }
-        break;
     case 5: /* fmove from control register.  */
-        switch ((ext >> 10) & 7) {
-        case 4: /* FPCR */
-            /* Not implemented.  Always return zero.  */
-            tmp32 = tcg_const_i32(0);
-            break;
-        case 1: /* FPIAR */
-        case 2: /* FPSR */
-        default:
-            cpu_abort(NULL, "Unimplemented: fmove from control %d",
-                      (ext >> 10) & 7);
-            goto undef;
-        }
-        DEST_EA(env, insn, OS_LONG, tmp32, NULL);
-        break;
+        gen_op_fmove_fcr(env, s, insn, ext);
+        return;
     case 6: /* fmovem */
     case 7:
         {
-- 
2.9.4
