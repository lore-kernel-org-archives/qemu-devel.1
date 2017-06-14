Received: from eggs.gnu.org ([2001:4830:134:3::10]:58615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dL23C-0006or-JW
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dL23B-0005Vj-T0
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:45:10 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 14 Jun 2017 16:44:52 +1000
Message-Id: <20170614064452.23167-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [PATCH] target/ppc: Fix return value in tcg radix mmu
 fault handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, agraf@suse.de, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The mmu fault handler should return 0 if it was able to successfully
handle the fault and a positive value otherwise.

Currently the tcg radix mmu fault handler will return 1 after
successfully handling a fault in virtual mode. This is incorrect
so fix it so that it returns 0 in this case.

The handler already correctly returns 0 when a fault was handled
in real mode and 1 if an interrupt was generated.

Fixes: d5fee0bbe68d ("target/ppc: Implement ISA V3.00 radix page fault handler")

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/mmu-radix64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index de18c0b..69fde65 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -255,5 +255,5 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
 
     tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
                  prot, mmu_idx, 1UL << page_size);
-    return 1;
+    return 0;
 }
-- 
2.9.4
