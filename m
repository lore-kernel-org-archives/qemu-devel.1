Received: from eggs.gnu.org ([2001:4830:134:3::10]:60684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gK4Mq-0005s7-2O
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:38:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gK4Mo-0004bj-3X
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:38:15 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  6 Nov 2018 16:38:01 +0000
Message-Id: <20181106163801.14474-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1] target/arm: Remove workaround for
 small SAU regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Before we supported direct execution from MMIO regions, we
implemented workarounds in commit 720424359917887c926a33d2
which let us avoid doing so, even if the SAU or MPU region
was less than page-sized.

Once we implemented execute-from-MMIO, we removed part
of those workarounds in commit d4b6275df320cee76; but
we forgot the one in get_phys_addr_pmsav8() which
suppressed use of small SAU regions in executable regions.
Remove that workaround now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 96301930cc8..ec56becc394 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10560,18 +10560,6 @@ static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
 
     ret = pmsav8_mpu_lookup(env, address, access_type, mmu_idx, phys_ptr,
                             txattrs, prot, &mpu_is_subpage, fi, NULL);
-    /*
-     * TODO: this is a temporary hack to ignore the fact that the SAU region
-     * is smaller than a page if this is an executable region. We never
-     * supported small MPU regions, but we did (accidentally) allow small
-     * SAU regions, and if we now made small SAU regions not be executable
-     * then this would break previously working guest code. We can't
-     * remove this until/unless we implement support for execution from
-     * small regions.
-     */
-    if (*prot & PAGE_EXEC) {
-        sattrs.subpage = false;
-    }
     *page_size = sattrs.subpage || mpu_is_subpage ? 1 : TARGET_PAGE_SIZE;
     return ret;
 }
-- 
2.19.1
