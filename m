Received: from eggs.gnu.org ([2001:4830:134:3::10]:55030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAOt-0000r3-TI
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAOt-00052S-3Q
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:43 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:40832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fEAOs-000520-Qu
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:43 -0400
Received: by mail-lf0-x244.google.com with SMTP id j16-v6so24916577lfb.7
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 02:19:42 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu,  3 May 2018 11:19:03 +0200
Message-Id: <20180503091922.28733-11-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-1-edgar.iglesias@gmail.com>
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 10/29] target-microblaze: Bypass MMU with
 MMU_NOMMU_IDX
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

Bypass MMU translation when mmu-index MMU_NOMMU_IDX is used.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index a9f4ca93e3..261dcc74c7 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -58,7 +58,8 @@ int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
     int prot;
 
     /* Translate if the MMU is available and enabled.  */
-    if (cpu->cfg.use_mmu && (env->sregs[SR_MSR] & MSR_VM)) {
+    if (cpu->cfg.use_mmu && (env->sregs[SR_MSR] & MSR_VM)
+        && mmu_idx != MMU_NOMMU_IDX) {
         uint32_t vaddr, paddr;
         struct microblaze_mmu_lookup lu;
 
-- 
2.14.1
