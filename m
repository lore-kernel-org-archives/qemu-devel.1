Received: from eggs.gnu.org ([2001:4830:134:3::10]:44286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6Tm-0000Hz-W3
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6Ti-0005af-4Z
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:47 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fG6Th-0005aD-Td
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:42 -0400
Received: by mail-lf0-x242.google.com with SMTP id m18-v6so47060607lfb.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 10:32:41 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  8 May 2018 19:31:46 +0200
Message-Id: <20180508173152.29327-31-edgar.iglesias@gmail.com>
In-Reply-To: <20180508173152.29327-1-edgar.iglesias@gmail.com>
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 30/36] target-microblaze: Simplify address
 computation using tcg_gen_addi_i32()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Simplify address computation using tcg_gen_addi_i32().
tcg_gen_addi_i32() already optimizes the case when the
immediate is zero.

No functional change.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index bed86dc805..a987444f19 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -895,12 +895,7 @@ static inline void compute_ldst_addr(DisasContext *dc, bool ea, TCGv t)
     /* Immediate.  */
     t32 = tcg_temp_new_i32();
     if (!extimm) {
-        if (dc->imm == 0) {
-            tcg_gen_mov_i32(t32, cpu_R[dc->ra]);
-        } else {
-            tcg_gen_movi_i32(t32, (int32_t)((int16_t)dc->imm));
-            tcg_gen_add_i32(t32, cpu_R[dc->ra], t32);
-        }
+        tcg_gen_addi_i32(t32, cpu_R[dc->ra], (int16_t)dc->imm);
     } else {
         tcg_gen_add_i32(t32, cpu_R[dc->ra], *(dec_alu_op_b(dc)));
     }
-- 
2.14.1
