Received: from eggs.gnu.org ([2001:4830:134:3::10]:59356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH36-0005Om-Gy
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH33-00073L-EB
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:36 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55746 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpH33-000724-6x
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:33 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 13 Aug 2018 19:52:39 +0200
Message-Id: <1534182832-554-15-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 14/87] target/mips: Add gen_op_addr_addi()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Add gen_op_addr_addi(). This function will be used in emulation of
some nanoMIPS instructions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 6740764..e2ffdb0 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1746,6 +1746,18 @@ static inline void gen_op_addr_add (DisasContext *ctx, TCGv ret, TCGv arg0, TCGv
 #endif
 }
 
+static inline void gen_op_addr_addi(DisasContext *ctx, TCGv ret, TCGv base,
+                                    target_long ofs)
+{
+    tcg_gen_addi_tl(ret, base, ofs);
+
+#if defined(TARGET_MIPS64)
+    if (ctx->hflags & MIPS_HFLAG_AWRAP) {
+        tcg_gen_ext32s_i64(ret, ret);
+    }
+#endif
+}
+
 /* Addresses computation (translation time) */
 static target_long addr_add(DisasContext *ctx, target_long base,
                             target_long offset)
-- 
2.7.4
