Received: from eggs.gnu.org ([2001:4830:134:3::10]:55383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAPK-0001Dv-8M
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAPJ-0005Dt-3K
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:20:10 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:42896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fEAPI-0005Db-SK
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:20:09 -0400
Received: by mail-lf0-x241.google.com with SMTP id u21-v6so24912155lfu.9
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 02:20:08 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu,  3 May 2018 11:19:20 +0200
Message-Id: <20180503091922.28733-28-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-1-edgar.iglesias@gmail.com>
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 27/29] target-microblaze: mmu: Add a
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add a configurable output address mask, used to mimic the
configurable physical address bit width.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c | 1 +
 target/microblaze/mmu.c | 1 +
 target/microblaze/mmu.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 2b3f8fa374..d0649fdaaa 100644
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
