Received: from eggs.gnu.org ([2001:4830:134:3::10]:53951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1XT-0003Xs-VV
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1XS-0000zP-VB
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:40 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:56292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fJ1XS-0000yj-OS
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:38 -0400
Received: by mail-wm0-x241.google.com with SMTP id a8-v6so3853313wmg.5
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 11:52:38 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 16 May 2018 20:51:39 +0200
Message-Id: <20180516185146.30708-32-edgar.iglesias@gmail.com>
In-Reply-To: <20180516185146.30708-1-edgar.iglesias@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v3 31/38] target-microblaze: Simplify address
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Simplify address computation using tcg_gen_addi_i32().
tcg_gen_addi_i32() already optimizes the case when the
immediate is zero.

No functional change.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 39c4d0654e..44395cf189 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -899,12 +899,7 @@ static inline void compute_ldst_addr(DisasContext *dc, bool ea, TCGv t)
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
