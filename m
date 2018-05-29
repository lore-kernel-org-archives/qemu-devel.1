Received: from eggs.gnu.org ([2001:4830:134:3::10]:36848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcD1-0001KZ-4x
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcCy-0003qG-Kd
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:31 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcCy-0003pX-EP
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:28 -0400
Received: by mail-wm0-x232.google.com with SMTP id v131-v6so20045550wma.1
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:50:28 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:49:41 +0200
Message-Id: <20180529105011.1914-9-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 08/38] target-microblaze: Remove USE_MMU PVR
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
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

We already have a CPU property to control if a core has
an MMU or not. Remove USE_MMU PVR checks in favor of
looking at the property.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
