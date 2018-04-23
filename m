Received: from eggs.gnu.org ([2001:4830:134:3::10]:55373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fAae5-0001VP-V1
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fAae5-0008BL-7Z
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:32:37 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:37439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fAae5-0008AV-0K
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:32:37 -0400
Received: by mail-lf0-x243.google.com with SMTP id b23-v6so14718270lfg.4
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 05:32:36 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Mon, 23 Apr 2018 14:32:25 +0200
Message-Id: <20180423123225.30503-6-edgar.iglesias@gmail.com>
In-Reply-To: <20180423123225.30503-1-edgar.iglesias@gmail.com>
References: <20180423123225.30503-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 5/5] target-microblaze: mmu: Make the TLBX
 MISS bit read-only
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

Make the TLBX MISS bit read-only.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/mmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 8391811900..9d5e6aa8a5 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -273,6 +273,10 @@ void mmu_write(CPUMBState *env, uint32_t rn, uint32_t v)
                 env->mmu.regs[rn] = v;
             }
             break;
+        case MMU_R_TLBX:
+            /* Bit 31 is read-only.  */
+            env->mmu.regs[rn] = deposit32(env->mmu.regs[rn], 0, 31, v);
+            break;
         case MMU_R_TLBSX:
         {
             struct microblaze_mmu_lookup lu;
-- 
2.14.1
