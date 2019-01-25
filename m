Received: from eggs.gnu.org ([209.51.188.92]:54464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn6Bk-0004K6-Rj
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn6Bi-0002eJ-JY
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:26:48 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gn6Bi-0002VV-9M
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:26:46 -0500
Received: by mail-wr1-x444.google.com with SMTP id u4so11341430wrp.3
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 10:26:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jan 2019 18:26:24 +0000
Message-Id: <20190125182626.9221-6-peter.maydell@linaro.org>
In-Reply-To: <20190125182626.9221-1-peter.maydell@linaro.org>
References: <20190125182626.9221-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/7] target/arm/translate-a64: Don't
 underdecode add/sub extended register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Laurent Desnogues <laurent.desnogues@gmail.com>

In the "add/subtract (extended register)" encoding group, the "opt"
field in bits [23:22] must be zero. Correctly UNDEF the unallocated
encodings where this field is not zero.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2cade64ed25..efd2f6490b5 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4204,12 +4204,13 @@ static void disas_add_sub_ext_reg(DisasContext *s, uint32_t insn)
     bool setflags = extract32(insn, 29, 1);
     bool sub_op = extract32(insn, 30, 1);
     bool sf = extract32(insn, 31, 1);
+    bool opt = extract32(insn, 22, 2);
 
     TCGv_i64 tcg_rm, tcg_rn; /* temps */
     TCGv_i64 tcg_rd;
     TCGv_i64 tcg_result;
 
-    if (imm3 > 4) {
+    if (imm3 > 4 || opt != 0) {
         unallocated_encoding(s);
         return;
     }
-- 
2.20.1
