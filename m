Received: from eggs.gnu.org ([209.51.188.92]:40420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXS-0000yt-Bm
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXO-0000fE-PB
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:51 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXL-0000Sm-Tm
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:49 -0400
Received: by mail-pl1-x642.google.com with SMTP id n8so3526796plp.10
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 21:34:41 -1000
Message-Id: <20190420073442.7488-38-richard.henderson@linaro.org>
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 37/38] tcg/aarch64: Use MVNI for expansion of
 dupi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index e68e4de08c..20c8699f79 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -513,6 +513,7 @@ typedef enum {
 
     /* AdvSIMD modified immediate */
     I3606_MOVI      = 0x0f000400,
+    I3606_MVNI      = 0x2f000400,
 
     /* AdvSIMD shift by immediate */
     I3614_SSHR      = 0x0f000400,
@@ -823,6 +824,9 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
 
     if (is_fimm(v64, &op, &cmode, &imm8)) {
         tcg_out_insn(s, 3606, MOVI, type == TCG_TYPE_V128, rd, op, cmode, imm8);
+    } else if (is_fimm(~v64, &op, &cmode, &imm8)
+               && op == 0 && ((1 << cmode) & 0x03555)) {
+        tcg_out_insn(s, 3606, MVNI, type == TCG_TYPE_V128, rd, 0, cmode, imm8);
     } else if (type == TCG_TYPE_V128) {
         new_pool_l2(s, R_AARCH64_CONDBR19, s->code_ptr, 0, v64, v64);
         tcg_out_insn(s, 3305, LDR_v128, 0, rd);
-- 
2.17.1
