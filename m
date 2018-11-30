Received: from eggs.gnu.org ([2001:4830:134:3::10]:52603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSqiE-00081Z-7z
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSqiD-00078G-FH
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:38 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSqiD-00074K-9c
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:37 -0500
Received: by mail-pl1-x643.google.com with SMTP id a14so3408303plm.12
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 13:52:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 30 Nov 2018 13:52:15 -0800
Message-Id: <20181130215221.20554-11-richard.henderson@linaro.org>
In-Reply-To: <20181130215221.20554-1-richard.henderson@linaro.org>
References: <20181130215221.20554-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 10/16] tcg/mips: Remove retranslation code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

There is no longer a need for preserving branch offset operands,
as we no longer re-translate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.inc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index cff525373b..e21cb1ae28 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -483,12 +483,7 @@ static inline void tcg_out_opc_bf64(TCGContext *s, MIPSInsn opc, MIPSInsn opm,
 static inline void tcg_out_opc_br(TCGContext *s, MIPSInsn opc,
                                   TCGReg rt, TCGReg rs)
 {
-    /* We pay attention here to not modify the branch target by reading
-       the existing value and using it again. This ensure that caches and
-       memory are kept coherent during retranslation. */
-    uint16_t offset = (uint16_t)*s->code_ptr;
-
-    tcg_out_opc_imm(s, opc, rt, rs, offset);
+    tcg_out_opc_imm(s, opc, rt, rs, 0);
 }
 
 /*
-- 
2.17.2
