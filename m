Received: from eggs.gnu.org ([2001:4830:134:3::10]:55323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fAae2-0001U4-N0
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fAae0-00088B-EP
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:32:34 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fAae0-00087j-6D
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:32:32 -0400
Received: by mail-lf0-x241.google.com with SMTP id m13-v6so497170lfc.1
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 05:32:32 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Mon, 23 Apr 2018 14:32:22 +0200
Message-Id: <20180423123225.30503-3-edgar.iglesias@gmail.com>
In-Reply-To: <20180423123225.30503-1-edgar.iglesias@gmail.com>
References: <20180423123225.30503-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 2/5] target-microblaze: Fix trap checks for
 FPU insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Fix trap checks for FPU insns when extended FPU insns are enabled.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index f739751930..ec12fed49d 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1412,7 +1412,7 @@ static void dec_fpu(DisasContext *dc)
 
     if ((dc->tb_flags & MSR_EE_FLAG)
           && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
-          && (dc->cpu->cfg.use_fpu != 1)) {
+          && !dc->cpu->cfg.use_fpu) {
         tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
         return;
-- 
2.14.1
