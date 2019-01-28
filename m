Received: from eggs.gnu.org ([209.51.188.92]:33582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9K5-0005Cj-MU
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9K4-0007vh-Mf
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:45 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:35951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1go9K4-0007r7-EQ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:44 -0500
Received: by mail-pf1-x42b.google.com with SMTP id b85so8190205pfc.3
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 07:59:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 07:59:04 -0800
Message-Id: <20190128155907.20607-21-richard.henderson@linaro.org>
In-Reply-To: <20190128155907.20607-1-richard.henderson@linaro.org>
References: <20190128155907.20607-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 20/23] tcg/mips: Fix tcg_out_qemu_ld_slow_path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

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
