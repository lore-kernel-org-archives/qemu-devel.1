Received: from eggs.gnu.org ([2001:4830:134:3::10]:54769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ff3cs-0006Lw-HL
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ff3cr-00021Y-Gw
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:33:18 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 14:33:02 +0100
Message-Id: <20180716133302.25989-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0] target/arm: Correctly handle
 overlapping small MPU regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Adithya Baglody <adithya.nagaraj.baglody@intel.com>

To correctly handle small (less than TARGET_PAGE_SIZE) MPU regions,
we must correctly handle the case where the address being looked
up hits in an MPU region that is not small but the address is
in the same page as a small region. For instance if MPU region
1 covers an entire page from 0x2000 to 0x2400 and MPU region
2 is small and covers only 0x2200 to 0x2280, then for an access
to 0x2000 we must not return a result covering the full page
even though we hit the page-sized region 1. Otherwise we will
then cache that result in the TLB and accesses that should
hit region 2 will incorrectly find the region 1 information.

Check for the case where we miss an MPU region but it is still
within the same page, and in that case narrow the size we will
pass to tlb_set_page_with_attrs() for whatever the final
outcome is of the MPU lookup.

Reported-by: Adithya Baglody <adithya.nagaraj.baglody@intel.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This should go into 3.0 as it fixes a corner case in the newly added
small-MPU-region handling.

 target/arm/helper.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0604a0efbe2..22d812240af 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -17,6 +17,7 @@
 #include "exec/semihost.h"
 #include "sysemu/kvm.h"
 #include "fpu/softfloat.h"
+#include "qemu/range.h"
 
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
@@ -9669,6 +9670,20 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
             }
 
             if (address < base || address > base + rmask) {
+                /*
+                 * Address not in this region. We must check whether the
+                 * region covers addresses in the same page as our address.
+                 * In that case we must not report a size that covers the
+                 * whole page for a subsequent hit against a different MPU
+                 * region or the background region, because it would result in
+                 * incorrect TLB hits for subsequent accesses to addresses that
+                 * are in this MPU region.
+                 */
+                if (ranges_overlap(base, rmask,
+                                   address & TARGET_PAGE_MASK,
+                                   TARGET_PAGE_SIZE)) {
+                    *page_size = 1;
+                }
                 continue;
             }
 
@@ -9888,6 +9903,22 @@ static void v8m_security_lookup(CPUARMState *env, uint32_t address,
                         sattrs->srvalid = true;
                         sattrs->sregion = r;
                     }
+                } else {
+                    /*
+                     * Address not in this region. We must check whether the
+                     * region covers addresses in the same page as our address.
+                     * In that case we must not report a size that covers the
+                     * whole page for a subsequent hit against a different MPU
+                     * region or the background region, because it would result
+                     * in incorrect TLB hits for subsequent accesses to
+                     * addresses that are in this MPU region.
+                     */
+                    if (limit >= base &&
+                        ranges_overlap(base, limit - base + 1,
+                                       addr_page_base,
+                                       TARGET_PAGE_SIZE)) {
+                        sattrs->subpage = true;
+                    }
                 }
             }
         }
@@ -9963,6 +9994,21 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
             }
 
             if (address < base || address > limit) {
+                /*
+                 * Address not in this region. We must check whether the
+                 * region covers addresses in the same page as our address.
+                 * In that case we must not report a size that covers the
+                 * whole page for a subsequent hit against a different MPU
+                 * region or the background region, because it would result in
+                 * incorrect TLB hits for subsequent accesses to addresses that
+                 * are in this MPU region.
+                 */
+                if (limit >= base &&
+                    ranges_overlap(base, limit - base + 1,
+                                   addr_page_base,
+                                   TARGET_PAGE_SIZE)) {
+                    *is_subpage = true;
+                }
                 continue;
             }
 
-- 
2.17.1
