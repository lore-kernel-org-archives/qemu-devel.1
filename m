Received: from eggs.gnu.org ([2001:4830:134:3::10]:39454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1f97dE-0006Kn-Mb
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1f97dB-00085F-9y
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:21:40 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:38110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1f97dB-00083h-1S
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:21:37 -0400
Received: by mail-lf0-x243.google.com with SMTP id z130-v6so261049lff.5
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 04:21:36 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 19 Apr 2018 13:21:28 +0200
Message-Id: <20180419112131.16932-3-edgar.iglesias@gmail.com>
In-Reply-To: <20180419112131.16932-1-edgar.iglesias@gmail.com>
References: <20180419112131.16932-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 2/5] target-microblaze: Fix trap checks for
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
Cc: peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Fix trap checks for FPU insns when extended FPU insns are enabled.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index df62563815..5f9efcdd11 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1406,7 +1406,7 @@ static void dec_fpu(DisasContext *dc)
 
     if ((dc->tb_flags & MSR_EE_FLAG)
           && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
-          && (dc->cpu->cfg.use_fpu != 1)) {
+          && !dc->cpu->cfg.use_fpu) {
         tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
         return;
-- 
2.14.1
