Received: from eggs.gnu.org ([209.51.188.92]:41034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmRSw-0006Cc-9y
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmRSk-0004K7-Kh
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:41 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmRSk-0004Cu-1Y
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:38 -0500
Received: by mail-pg1-x541.google.com with SMTP id y4so1734274pgc.12
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 14:57:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 23 Jan 2019 14:57:02 -0800
Message-Id: <20190123225705.28963-11-richard.henderson@linaro.org>
In-Reply-To: <20190123225705.28963-1-richard.henderson@linaro.org>
References: <20190123225705.28963-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 10/13] tcg/mips: Fix tcg_out_qemu_ld_slow_path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, alex.bennee@linaro.org

Patch the branch after it has been emitted rather
than before it exists.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.inc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index be0bc92e8e..c5d7067f89 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -1343,8 +1343,9 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
         }
     }
 
-    reloc_pc16(s->code_ptr, l->raddr);
     tcg_out_opc_br(s, OPC_BEQ, TCG_REG_ZERO, TCG_REG_ZERO);
+    reloc_pc16(s->code_ptr - 1, l->raddr);
+
     /* delay slot */
     if (TCG_TARGET_REG_BITS == 64 && l->type == TCG_TYPE_I32) {
         /* we always sign-extend 32-bit loads */
-- 
2.17.2
