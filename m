Received: from eggs.gnu.org ([2001:4830:134:3::10]:53250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ934-0001s8-IK
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92v-0002xp-Bm
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:10 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92u-0002a2-VS
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:01 -0500
Received: by mail-pg1-x543.google.com with SMTP id n2so7350519pgm.3
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:39:01 -0800
Message-Id: <20181218063911.2112-25-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 24/34] target/ppc: convert xxspltw to vector
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate/vsx-impl.inc.c | 36 +++++++++--------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index d88d6bbd74..a040038ed4 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1318,38 +1318,24 @@ static void gen_xxsel(DisasContext * ctx)
 
 static void gen_xxspltw(DisasContext *ctx)
 {
-    TCGv_i64 b, b2;
-    TCGv_i64 vsr;
-
-    vsr = tcg_temp_new_i64();
-    if (UIM(ctx->opcode) & 2) {
-        get_cpu_vsrl(vsr, xB(ctx->opcode));
-    } else {
-        get_cpu_vsrh(vsr, xB(ctx->opcode));
-    }
+    int rt = xT(ctx->opcode);
+    int rb = xB(ctx->opcode);
+    int uim = UIM(ctx->opcode);
+    int tofs, bofs;
 
     if (unlikely(!ctx->vsx_enabled)) {
         gen_exception(ctx, POWERPC_EXCP_VSXU);
         return;
     }
 
-    b = tcg_temp_new_i64();
-    b2 = tcg_temp_new_i64();
+    tofs = vsr_full_offset(rt);
+    bofs = vsr_full_offset(rb);
+    bofs += uim << MO_32;
+#ifndef HOST_WORDS_BIG_ENDIAN
+    bofs ^= 8 | 4;
+#endif
 
-    if (UIM(ctx->opcode) & 1) {
-        tcg_gen_ext32u_i64(b, vsr);
-    } else {
-        tcg_gen_shri_i64(b, vsr, 32);
-    }
-
-    tcg_gen_shli_i64(b2, b, 32);
-    tcg_gen_or_i64(vsr, b, b2);
-    set_cpu_vsrh(xT(ctx->opcode), vsr);
-    set_cpu_vsrl(xT(ctx->opcode), vsr);
-
-    tcg_temp_free_i64(vsr);
-    tcg_temp_free_i64(b);
-    tcg_temp_free_i64(b2);
+    tcg_gen_gvec_dup_mem(MO_32, tofs, bofs, 16, 16);
 }
 
 #define pattern(x) (((x) & 0xff) * (~(uint64_t)0 / 0xff))
-- 
2.17.2
