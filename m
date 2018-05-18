Received: from eggs.gnu.org ([2001:4830:134:3::10]:35912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3B-0000ZZ-98
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3A-0007Rr-GI
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:17 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fJj3A-0007Oi-AJ
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:16 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj39-0004mI-BC
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:20:15 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 18:19:44 +0100
Message-Id: <20180518172009.14416-8-peter.maydell@linaro.org>
In-Reply-To: <20180518172009.14416-1-peter.maydell@linaro.org>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/32] hw/arm/smmu-common: Fix coverity issue in
 get_block_pte_address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

Coverity points out that this can overflow if n > 31,
because it's only doing 32-bit arithmetic. Let's use 1ULL instead
of 1. Also the formulae used to compute n can be replaced by
the level_shift() macro.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1526493784-25328-3-git-send-email-eric.auger@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmu-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 01c7be82b6..3c5f7245b5 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -83,9 +83,9 @@ static inline hwaddr get_table_pte_address(uint64_t pte, int granule_sz)
 static inline hwaddr get_block_pte_address(uint64_t pte, int level,
                                            int granule_sz, uint64_t *bsz)
 {
-    int n = (granule_sz - 3) * (4 - level) + 3;
+    int n = level_shift(level, granule_sz);
 
-    *bsz = 1 << n;
+    *bsz = 1ULL << n;
     return PTE_ADDRESS(pte, n);
 }
 
-- 
2.17.0
