Received: from eggs.gnu.org ([2001:4830:134:3::10]:60495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0u-00061u-Fz
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0t-0006qO-Kz
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:16 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:45839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edT0t-0006q8-FC
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:15 -0500
Received: by mail-pf0-x241.google.com with SMTP id a88so6067266pfe.12
	for <qemu-devel@nongnu.org>; Sun, 21 Jan 2018 19:43:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 21 Jan 2018 19:42:11 -0800
Message-Id: <20180122034217.19593-38-richard.henderson@linaro.org>
In-Reply-To: <20180122034217.19593-1-richard.henderson@linaro.org>
References: <20180122034217.19593-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 37/43] target/hppa: Implement LDSID for system
 mode
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
index 965641f380..76ed7e1ad4 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2200,8 +2200,20 @@ static DisasJumpType trans_ldsid(DisasContext *ctx, uint32_t insn,
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
