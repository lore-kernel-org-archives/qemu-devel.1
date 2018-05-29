Received: from eggs.gnu.org ([2001:4830:134:3::10]:37116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDY-0001nT-72
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDU-0004DJ-0V
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:04 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:46349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcDT-0004Cb-Pr
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:59 -0400
Received: by mail-wr0-x22b.google.com with SMTP id v13-v6so13000780wrp.13
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:50:59 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:50:00 +0200
Message-Id: <20180529105011.1914-28-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 27/38] target-microblaze: mmu: Add a
 configurable output address mask
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

Add a configurable output address mask, used to mimic the
configurable physical address bit width.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c | 1 +
 target/microblaze/mmu.c | 1 +
 target/microblaze/mmu.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 6ee15ac800..71fc8d09fe 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -128,6 +128,7 @@ static void mb_cpu_reset(CPUState *s)
     env->mmu.c_mmu = 3;
     env->mmu.c_mmu_tlb_access = 3;
     env->mmu.c_mmu_zones = 16;
+    env->mmu.c_addr_mask = MAKE_64BIT_MASK(0, cpu->cfg.addr_size);
 #endif
 }
 
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index a379968618..166c79908c 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -164,6 +164,7 @@ unsigned int mmu_translate(struct microblaze_mmu *mmu,
             tlb_rpn = d & TLB_RPN_MASK;
 
             lu->vaddr = tlb_tag;
+            lu->paddr = tlb_rpn & mmu->c_addr_mask;
             lu->paddr = tlb_rpn;
             lu->size = tlb_size;
             lu->err = ERR_HIT;
diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
index 1714caf82e..9fbdf38f36 100644
--- a/target/microblaze/mmu.h
+++ b/target/microblaze/mmu.h
@@ -72,6 +72,7 @@ struct microblaze_mmu
     int c_mmu;
     int c_mmu_tlb_access;
     int c_mmu_zones;
+    uint64_t c_addr_mask; /* Mask to apply to physical addresses.  */
 };
 
 struct microblaze_mmu_lookup
-- 
2.14.1
