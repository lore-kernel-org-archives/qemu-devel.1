Received: from eggs.gnu.org ([2001:4830:134:3::10]:36039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOW-0004TP-3d
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOR-0007au-TH
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:18 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSOR-00071P-3o
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:15 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOE-0007MS-Id
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:55:02 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:39 +0000
Message-Id: <20181213145445.17935-32-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/37] target/arm: Fix HCR_EL2.TGE check in
 arm_phys_excp_target_el
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

The enable for TGE has already occurred within arm_hcr_el2_amo
and friends.  Moreover, when E2H is also set, the sense is
supposed to be reversed, which has also already occurred within
the helpers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181203203839.757-5-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 04c4a91b04c..bf020364e1d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6537,9 +6537,6 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
         break;
     };
 
-    /* If HCR.TGE is set then HCR is treated as being 1 */
-    hcr |= ((env->cp15.hcr_el2 & HCR_TGE) == HCR_TGE);
-
     /* Perform a table-lookup for the target EL given the current state */
     target_el = target_el_table[is64][scr][rw][hcr][secure][cur_el];
 
-- 
2.19.2
