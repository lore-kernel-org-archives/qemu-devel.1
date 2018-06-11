Received: from eggs.gnu.org ([2001:4830:134:3::10]:60831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fSMNL-00017l-L0
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fSMNK-0006uB-QL
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:56:47 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fSMNK-0006nu-Fj
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:56:46 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Jun 2018 13:56:32 +0100
Message-Id: <20180611125633.32755-2-peter.maydell@linaro.org>
In-Reply-To: <20180611125633.32755-1-peter.maydell@linaro.org>
References: <20180611125633.32755-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] cpu-defs.h: Document CPUIOTLBEntry 'addr'
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

The 'addr' field in the CPUIOTLBEntry struct has a rather non-obvious
use; add a comment documenting it (reverse-engineered from what
the code that sets it is doing).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/cpu-defs.h |  9 +++++++++
 accel/tcg/cputlb.c      | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index e43ff8346b1..452e82d21c6 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -127,6 +127,15 @@ QEMU_BUILD_BUG_ON(sizeof(CPUTLBEntry) != (1 << CPU_TLB_ENTRY_BITS));
  * structs into one.)
  */
 typedef struct CPUIOTLBEntry {
+    /*
+     * @addr contains:
+     *  - in the lower TARGET_PAGE_BITS, a physical section number
+     *  - with the lower TARGET_PAGE_BITS masked off, an offset which
+     *    must be added to the virtual address to obtain:
+     *     + the ramaddr_t of the target RAM (if the physical section
+     *       number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
+     *     + the offset within the target MemoryRegion (otherwise)
+     */
     hwaddr addr;
     MemTxAttrs attrs;
 } CPUIOTLBEntry;
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 05439039e91..355ded27024 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -664,6 +664,18 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     env->iotlb_v[mmu_idx][vidx] = env->iotlb[mmu_idx][index];
 
     /* refill the tlb */
+    /*
+     * At this point iotlb contains a physical section number in the lower
+     * TARGET_PAGE_BITS, and either
+     *  + the ramaddr_t of the page base of the target RAM (if NOTDIRTY or ROM)
+     *  + the offset within section->mr of the page base (otherwise)
+     * We subtract the vaddr (which is page aligned and thus won't
+     * disturb the low bits) to give an offset which can be added to the
+     * (non-page-aligned) vaddr of the eventual memory access to get
+     * the MemoryRegion offset for the access. Note that the vaddr we
+     * subtract here is that of the page base, and not the same as the
+     * vaddr we add back in io_readx()/io_writex()/get_page_addr_code().
+     */
     env->iotlb[mmu_idx][index].addr = iotlb - vaddr;
     env->iotlb[mmu_idx][index].attrs = attrs;
 
-- 
2.17.1
