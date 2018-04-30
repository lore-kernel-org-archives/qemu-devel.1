Received: from eggs.gnu.org ([2001:4830:134:3::10]:59068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fDAQ6-00065j-1C
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fDAQ5-00051z-2g
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:08:49 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:41026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fDAQ4-00051Z-RI
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:08:48 -0400
Received: by mail-lf0-x243.google.com with SMTP id o123-v6so12564848lfe.8
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 08:08:48 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Mon, 30 Apr 2018 17:08:37 +0200
Message-Id: <20180430150837.20470-6-edgar.iglesias@gmail.com>
In-Reply-To: <20180430150837.20470-1-edgar.iglesias@gmail.com>
References: <20180430150837.20470-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 5/5] target-microblaze: mmu: Make the TLBX
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
Cc: peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Make the TLBX MISS bit read-only.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
