Received: from eggs.gnu.org ([2001:4830:134:3::10]:49995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjO-0006mI-3n
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjN-00050k-0R
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:30 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYjM-00050b-Rw
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:28 -0400
Received: by mail-qk0-x242.google.com with SMTP id u126so2857282qka.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:04:28 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:48 -1000
Message-Id: <20170718200255.31647-24-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 23/30] target/sh4: Introduce CHECK_SH4A
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 66 +++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 346f672..239a0d9 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -394,6 +394,11 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
         goto do_illegal;                    \
     }
 
+#define CHECK_SH4A \
+    if (!(ctx->features & SH_FEATURE_SH4A)) { \
+        goto do_illegal;                      \
+    }
+
 static void _decode_opc(DisasContext * ctx)
 {
     /* This code tries to make movcal emulation sufficiently
@@ -1473,7 +1478,7 @@ static void _decode_opc(DisasContext * ctx)
 	LDST(ssr,  0x403e, 0x4037, 0x0032, 0x4033, CHECK_PRIVILEGED)
 	LDST(spc,  0x404e, 0x4047, 0x0042, 0x4043, CHECK_PRIVILEGED)
 	ST(sgr,  0x003a, 0x4032, CHECK_PRIVILEGED)
-	LD(sgr,  0x403a, 0x4036, CHECK_PRIVILEGED if (!(ctx->features & SH_FEATURE_SH4A)) break;)
+	LD(sgr,  0x403a, 0x4036, CHECK_PRIVILEGED CHECK_SH4A)
 	LDST(dbr,  0x40fa, 0x40f6, 0x00fa, 0x40f2, CHECK_PRIVILEGED)
 	LDST(mach, 0x400a, 0x4006, 0x000a, 0x4002, {})
 	LDST(macl, 0x401a, 0x4016, 0x001a, 0x4012, {})
@@ -1523,21 +1528,19 @@ static void _decode_opc(DisasContext * ctx)
         ctx->has_movcal = 1;
 	return;
     case 0x40a9:                /* movua.l @Rm,R0 */
+        CHECK_SH4A
         /* Load non-boundary-aligned data */
-        if (ctx->features & SH_FEATURE_SH4A) {
-            tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx,
-                                MO_TEUL | MO_UNALN);
-            return;
-        }
+        tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx,
+                            MO_TEUL | MO_UNALN);
+        return;
         break;
     case 0x40e9:                /* movua.l @Rm+,R0 */
+        CHECK_SH4A
         /* Load non-boundary-aligned data */
-        if (ctx->features & SH_FEATURE_SH4A) {
-            tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx,
-                                MO_TEUL | MO_UNALN);
-            tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
-            return;
-        }
+        tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx,
+                            MO_TEUL | MO_UNALN);
+        tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
+        return;
         break;
     case 0x0029:		/* movt Rn */
         tcg_gen_mov_i32(REG(B11_8), cpu_sr_t);
@@ -1546,7 +1549,8 @@ static void _decode_opc(DisasContext * ctx)
         /* MOVCO.L: if (lock still held) R0 -> (Rn), T=1; else T=0.
            Approximate "lock still held" with a comparison of address
            from the MOVLI insn and a cmpxchg with the value read.  */
-        if (ctx->features & SH_FEATURE_SH4A) {
+        CHECK_SH4A
+        {
             TCGLabel *fail = gen_new_label();
             TCGLabel *done = gen_new_label();
 
@@ -1564,20 +1568,15 @@ static void _decode_opc(DisasContext * ctx)
             gen_set_label(done);
             tcg_gen_movi_i32(cpu_lock_addr, -1);
             return;
-        } else {
-            break;
         }
     case 0x0063:
         /* MOVLI.L @Rm -> R0, and remember the address and value loaded.  */
-        if (ctx->features & SH_FEATURE_SH4A) {
-            tcg_gen_qemu_ld_i32(cpu_lock_value, REG(B11_8),
-                                ctx->memidx, MO_TESL);
-            tcg_gen_mov_i32(cpu_lock_addr, REG(B11_8));
-            tcg_gen_mov_i32(REG(0), cpu_lock_value);
-            return;
-        } else {
-            break;
-        }
+        CHECK_SH4A
+        tcg_gen_qemu_ld_i32(cpu_lock_value, REG(B11_8),
+                            ctx->memidx, MO_TESL);
+        tcg_gen_mov_i32(cpu_lock_addr, REG(B11_8));
+        tcg_gen_mov_i32(REG(0), cpu_lock_value);
+        return;
     case 0x0093:		/* ocbi @Rn */
 	{
             gen_helper_ocbi(cpu_env, REG(B11_8));
@@ -1592,20 +1591,15 @@ static void _decode_opc(DisasContext * ctx)
     case 0x0083:		/* pref @Rn */
 	return;
     case 0x00d3:		/* prefi @Rn */
-	if (ctx->features & SH_FEATURE_SH4A)
-	    return;
-	else
-	    break;
+        CHECK_SH4A
+        return;
     case 0x00e3:		/* icbi @Rn */
-	if (ctx->features & SH_FEATURE_SH4A)
-	    return;
-	else
-	    break;
+        CHECK_SH4A
+        return;
     case 0x00ab:		/* synco */
-        if (ctx->features & SH_FEATURE_SH4A) {
-            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-            return;
-        }
+        CHECK_SH4A
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+        return;
         break;
     case 0x4024:		/* rotcl Rn */
 	{
-- 
2.9.4
