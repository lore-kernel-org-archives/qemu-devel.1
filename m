Received: from eggs.gnu.org ([2001:4830:134:3::10]:39503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1f97dG-0006La-Ox
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1f97dF-0008E8-Rx
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:21:42 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:44713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1f97dF-0008Bj-IH
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:21:41 -0400
Received: by mail-lf0-x243.google.com with SMTP id g203-v6so242069lfg.11
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 04:21:41 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 19 Apr 2018 13:21:31 +0200
Message-Id: <20180419112131.16932-6-edgar.iglesias@gmail.com>
In-Reply-To: <20180419112131.16932-1-edgar.iglesias@gmail.com>
References: <20180419112131.16932-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 5/5] target-microblaze: mmu: Make the TLBX
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
