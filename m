Received: from eggs.gnu.org ([209.51.188.92]:49561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1uDN-0006sV-HJ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1uDM-0003aX-Ps
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:41:41 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1uDM-0003Zh-Jk
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:41:40 -0500
Received: by mail-pg1-x542.google.com with SMTP id b2so11406756pgl.9
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 06:41:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 06:41:26 -0800
Message-Id: <20190307144126.31847-10-richard.henderson@linaro.org>
In-Reply-To: <20190307144126.31847-1-richard.henderson@linaro.org>
References: <20190307144126.31847-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 9/9] target/arm: Simplify BFXIL expansion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

The mask implied by the extract is redundant with the one
implied by the deposit.  Also, fix spelling of BFXIL.

Cc: qemu-arm@nongnu.org 
Cc: Peter Maydell <peter.maydell@linaro.org> 
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 54fe94c436..39e0512d21 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4043,8 +4043,8 @@ static void disas_bitfield(DisasContext *s, uint32_t insn)
             tcg_gen_extract_i64(tcg_rd, tcg_tmp, ri, len);
             return;
         }
-        /* opc == 1, BXFIL fall through to deposit */
-        tcg_gen_extract_i64(tcg_tmp, tcg_tmp, ri, len);
+        /* opc == 1, BFXIL fall through to deposit */
+        tcg_gen_shri_i64(tcg_tmp, tcg_tmp, ri);
         pos = 0;
     } else {
         /* Handle the ri > si case with a deposit
@@ -4062,7 +4062,7 @@ static void disas_bitfield(DisasContext *s, uint32_t insn)
         len = ri;
     }
 
-    if (opc == 1) { /* BFM, BXFIL */
+    if (opc == 1) { /* BFM, BFXIL */
         tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, pos, len);
     } else {
         /* SBFM or UBFM: We start with zero, and we haven't modified
-- 
2.17.2
