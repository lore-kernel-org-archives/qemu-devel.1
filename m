Received: from eggs.gnu.org ([2001:4830:134:3::10]:55404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flESn-0001i2-R2
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flESj-0005wl-Cw
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:20:25 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:37035 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1flESj-0005wJ-5R
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:20:21 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu,  2 Aug 2018 16:15:54 +0200
Message-Id: <1533219424-7627-8-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 07/77] target/mips: Add gen_op_addr_addi()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com

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
index 432d1a6..841c0c8 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1733,6 +1733,18 @@ static inline void gen_op_addr_add (DisasContext *ctx, TCGv ret, TCGv arg0, TCGv
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
1.9.1
