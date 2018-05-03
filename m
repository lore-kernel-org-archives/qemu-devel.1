Received: from eggs.gnu.org ([2001:4830:134:3::10]:54985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAOq-0000ng-EJ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAOp-00050q-Ih
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:40 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:37522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fEAOp-00050U-Ad
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:39 -0400
Received: by mail-lf0-x242.google.com with SMTP id b23-v6so24913989lfg.4
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 02:19:39 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu,  3 May 2018 11:19:01 +0200
Message-Id: <20180503091922.28733-9-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-1-edgar.iglesias@gmail.com>
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 08/29] target-microblaze: Remove USE_MMU PVR
 checks
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

We already have a CPU property to control if a core has
an MMU or not. Remove USE_MMU PVR checks in favor of
looking at the property.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/helper.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 387d4aca5a..a9f4ca93e3 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -54,21 +54,11 @@ int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
     unsigned int hit;
-    unsigned int mmu_available;
     int r = 1;
     int prot;
 
-    mmu_available = 0;
-    if (cpu->cfg.use_mmu) {
-        mmu_available = 1;
-        if ((cpu->cfg.pvr == C_PVR_FULL) &&
-            (env->pvr.regs[11] & PVR11_USE_MMU) != PVR11_USE_MMU) {
-            mmu_available = 0;
-        }
-    }
-
     /* Translate if the MMU is available and enabled.  */
-    if (mmu_available && (env->sregs[SR_MSR] & MSR_VM)) {
+    if (cpu->cfg.use_mmu && (env->sregs[SR_MSR] & MSR_VM)) {
         uint32_t vaddr, paddr;
         struct microblaze_mmu_lookup lu;
 
-- 
2.14.1
