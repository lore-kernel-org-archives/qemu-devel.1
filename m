Received: from eggs.gnu.org ([2001:4830:134:3::10]:35212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fIwxK-0007LE-Sn
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fIwxK-00062X-3W
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:59:02 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 16 May 2018 14:03:04 -0400
Message-Id: <1526493784-25328-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1526493784-25328-1-git-send-email-eric.auger@redhat.com>
References: <1526493784-25328-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] hw/arm/smmu-common: Fix coverity issue in
 get_block_pte_address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org

Coverity points out that this can overflow if n > 31,
because it's only doing 32-bit arithmetic. Let's use 1ULL instead
of 1. Also the formulae used to compute n can be replaced by
the level_shift() macro.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmu-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 01c7be8..3c5f724 100644
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
1.8.3.1
