Received: from eggs.gnu.org ([2001:4830:134:3::10]:60843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFih-0004p9-Ne
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFid-0001J7-Vl
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:09:51 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gMFiY-0008MG-Ez
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:09:45 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFhF-0005qq-DX
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:08:21 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 17:08:01 +0000
Message-Id: <20181112170816.500-2-peter.maydell@linaro.org>
In-Reply-To: <20181112170816.500-1-peter.maydell@linaro.org>
References: <20181112170816.500-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/16] target/arm: Remove workaround for small
 SAU regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181106163801.14474-1-peter.maydell@linaro.org
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
