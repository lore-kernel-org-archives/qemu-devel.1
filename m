Received: from eggs.gnu.org ([2001:4830:134:3::10]:37151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dKC6O-0001yU-9d
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 19:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dKC6L-0007zN-3O
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 19:17:00 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:60424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dKC6K-0007ys-Od
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 19:16:57 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 12 Jun 2017 01:16:30 +0200
Message-Id: <20170611231633.32582-5-laurent@vivier.eu>
In-Reply-To: <20170611231633.32582-1-laurent@vivier.eu>
References: <20170611231633.32582-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v4 4/7] target-m68k: move fmove CR to a function
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

Move code of fmove to/from control register to a function

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 66 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 049d837..45733ce 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4099,6 +4099,45 @@ DISAS_INSN(trap)
     gen_exception(s, s->pc - 2, EXCP_TRAP0 + (insn & 0xf));
 }
 
+static void gen_op_fmove_fcr(CPUM68KState *env, DisasContext *s,
+                             uint32_t insn, uint32_t ext)
+{
+    int mask = (ext >> 10) & 7;
+    int is_write = (ext >> 13) & 1;
+    TCGv val;
+
+    if (is_write) {
+        switch (mask) {
+        case 1: /* FPIAR */
+        case 2: /* FPSR */
+        default:
+            cpu_abort(NULL, "Unimplemented: fmove from control %d", mask);
+            goto undef;
+        case 4: /* FPCR */
+            val = tcg_const_i32(0);
+            DEST_EA(env, insn, OS_LONG, val, NULL);
+            tcg_temp_free(val);
+            break;
+        }
+        return;
+    }
+    switch (mask) {
+    case 1: /* FPIAR */
+    case 2: /* FPSR */
+    default:
+        cpu_abort(NULL, "Unimplemented: fmove to control %d",
+                  mask);
+        break;
+    case 4: /* FPCR */
+        /* Not implemented.  Ignore writes.  */
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
@@ -4177,32 +4216,9 @@ DISAS_INSN(fpu)
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
