Received: from eggs.gnu.org ([2001:4830:134:3::10]:36446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrOB-0008NE-4j
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrO7-0002IU-Q0
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:16:31 -0400
Received: from foss.arm.com ([217.140.101.70]:39296)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrO7-0002I7-JY
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:16:27 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Date: Fri, 29 Jun 2018 12:15:25 +0100
Message-Id: <1530270944-11351-6-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
Subject: [Qemu-devel] [PATCH v3 05/20] kvm: arm/arm64: Fix
 stage2_flush_memslot for 4 level page table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org, Suzuki K Poulose <suzuki.poulose@arm.com>

So far we have only supported 3 level page table with fixed IPA of 40bits.
Fix stage2_flush_memslot() to accommodate for 4 level tables.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <cdall@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 virt/kvm/arm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 1d90d79..061e6b3 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -379,7 +379,8 @@ static void stage2_flush_memslot(struct kvm *kvm,
 	pgd = kvm->arch.pgd + stage2_pgd_index(addr);
 	do {
 		next = stage2_pgd_addr_end(addr, end);
-		stage2_flush_puds(kvm, pgd, addr, next);
+		if (!stage2_pgd_none(*pgd))
+			stage2_flush_puds(kvm, pgd, addr, next);
 	} while (pgd++, addr = next, addr != end);
 }
 
-- 
2.7.4
