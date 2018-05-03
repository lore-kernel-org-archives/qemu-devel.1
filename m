Received: from eggs.gnu.org ([2001:4830:134:3::10]:55251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAPA-00015S-8E
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAP6-00058h-Nz
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:20:00 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:45445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fEAP6-000585-GM
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:56 -0400
Received: by mail-lf0-x244.google.com with SMTP id y14-v6so24549547lfy.12
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 02:19:56 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu,  3 May 2018 11:19:12 +0200
Message-Id: <20180503091922.28733-20-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-1-edgar.iglesias@gmail.com>
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 19/29] target-microblaze: dec_msr: Fix MTS
 to FSR
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

Fix moves to FSR. Not only bit 31 is accessible.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 05449fb941..97d7782bc6 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -533,11 +533,9 @@ static void dec_msr(DisasContext *dc)
                 break;
             case SR_EAR:
             case SR_ESR:
+            case SR_FSR:
                 tcg_gen_mov_i32(cpu_SR[sr], cpu_R[dc->ra]);
                 break;
-            case 0x7:
-                tcg_gen_andi_i32(cpu_SR[SR_FSR], cpu_R[dc->ra], 31);
-                break;
             case 0x800:
                 tcg_gen_st_i32(cpu_R[dc->ra],
                                cpu_env, offsetof(CPUMBState, slr));
-- 
2.14.1
