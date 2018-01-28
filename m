Received: from eggs.gnu.org ([2001:4830:134:3::10]:52337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwBW-000398-Ct
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwBV-0000Qt-HB
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:26 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:41266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1efwBV-0000PI-AO
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:25 -0500
Received: by mail-pg0-x241.google.com with SMTP id 136so3001518pgd.8
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 15:16:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 28 Jan 2018 15:15:20 -0800
Message-Id: <20180128231528.22719-36-richard.henderson@linaro.org>
In-Reply-To: <20180128231528.22719-1-richard.henderson@linaro.org>
References: <20180128231528.22719-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v4 35/43] target/hppa: Implement LDSID for
 system mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Helge Deller <deller@gmx.de>

From: Helge Deller <deller@gmx.de>

Signed-off-by: Helge Deller <deller@gmx.de>
Message-Id: <20180102203145.GA17059@ls3530.fritz.box>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 3327c085ff..cf67ca026e 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2211,8 +2211,20 @@ static DisasJumpType trans_ldsid(DisasContext *ctx, uint32_t insn,
     unsigned rt = extract32(insn, 0, 5);
     TCGv_reg dest = dest_gpr(ctx, rt);
 
-    /* Since we don't implement space registers, this returns zero.  */
+#ifdef CONFIG_USER_ONLY
+    /* We don't implement space registers in user mode. */
     tcg_gen_movi_reg(dest, 0);
+#else
+    unsigned rb = extract32(insn, 21, 5);
+    unsigned sp = extract32(insn, 14, 2);
+    TCGv_i64 t0 = tcg_temp_new_i64();
+
+    tcg_gen_mov_i64(t0, space_select(ctx, sp, load_gpr(ctx, rb)));
+    tcg_gen_shri_i64(t0, t0, 32);
+    tcg_gen_trunc_i64_reg(dest, t0);
+
+    tcg_temp_free_i64(t0);
+#endif
     save_gpr(ctx, rt, dest);
 
     cond_free(&ctx->null_cond);
-- 
2.14.3
