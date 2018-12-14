Received: from eggs.gnu.org ([2001:4830:134:3::10]:58774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0r-0005vx-1J
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0o-0006iA-Oe
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:40 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:34180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe0o-0006gw-JX
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:38 -0500
Received: by mail-oi1-x233.google.com with SMTP id h25so3490855oig.1
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:19:01 -0600
Message-Id: <20181214031923.29527-12-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/32] tcg/mips: Remove retranslation code
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

There is no longer a need for preserving branch offset operands,
as we no longer re-translate.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
