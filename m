Received: from eggs.gnu.org ([2001:4830:134:3::10]:48770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPo-0005ny-V0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPm-00043X-Sv
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:24 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXaOY-0003Up-2M
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:22 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jul 2017 23:50:46 +0200
Message-Id: <20170718215050.3812-28-aurelien@aurel32.net>
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 27/31] target/sh4: Introduce CHECK_SH4A
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

From: Richard Henderson <rth@twiddle.net>

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170718200255.31647-24-rth@twiddle.net>
[aurel32: fix conflict]
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 64 +++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 37e9ae32a3..6362a4781e 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -389,6 +389,11 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
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
@@ -1467,7 +1472,7 @@ static void _decode_opc(DisasContext * ctx)
 	LDST(ssr,  0x403e, 0x4037, 0x0032, 0x4033, CHECK_PRIVILEGED)
 	LDST(spc,  0x404e, 0x4047, 0x0042, 0x4043, CHECK_PRIVILEGED)
 	ST(sgr,  0x003a, 0x4032, CHECK_PRIVILEGED)
-	LD(sgr,  0x403a, 0x4036, CHECK_PRIVILEGED if (!(ctx->features & SH_FEATURE_SH4A)) break;)
+        LD(sgr,  0x403a, 0x4036, CHECK_PRIVILEGED CHECK_SH4A)
 	LDST(dbr,  0x40fa, 0x40f6, 0x00fa, 0x40f2, CHECK_PRIVILEGED)
 	LDST(mach, 0x400a, 0x4006, 0x000a, 0x4002, {})
 	LDST(macl, 0x401a, 0x4016, 0x001a, 0x4012, {})
@@ -1517,21 +1522,19 @@ static void _decode_opc(DisasContext * ctx)
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
@@ -1542,7 +1545,8 @@ static void _decode_opc(DisasContext * ctx)
                If (T == 1) R0 -> (Rn)
                0 -> LDST
         */
-        if (ctx->features & SH_FEATURE_SH4A) {
+        CHECK_SH4A
+        {
             TCGLabel *label = gen_new_label();
             tcg_gen_mov_i32(cpu_sr_t, cpu_ldst);
 	    tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_ldst, 0, label);
@@ -1550,8 +1554,7 @@ static void _decode_opc(DisasContext * ctx)
 	    gen_set_label(label);
 	    tcg_gen_movi_i32(cpu_ldst, 0);
 	    return;
-	} else
-	    break;
+        }
     case 0x0063:
         /* MOVLI.L @Rm,R0
                1 -> LDST
@@ -1559,13 +1562,11 @@ static void _decode_opc(DisasContext * ctx)
                When interrupt/exception
                occurred 0 -> LDST
         */
-	if (ctx->features & SH_FEATURE_SH4A) {
-	    tcg_gen_movi_i32(cpu_ldst, 0);
-            tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx, MO_TESL);
-	    tcg_gen_movi_i32(cpu_ldst, 1);
-	    return;
-	} else
-	    break;
+        CHECK_SH4A
+        tcg_gen_movi_i32(cpu_ldst, 0);
+        tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx, MO_TESL);
+        tcg_gen_movi_i32(cpu_ldst, 1);
+        return;
     case 0x0093:		/* ocbi @Rn */
 	{
             gen_helper_ocbi(cpu_env, REG(B11_8));
@@ -1580,20 +1581,15 @@ static void _decode_opc(DisasContext * ctx)
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
2.11.0
