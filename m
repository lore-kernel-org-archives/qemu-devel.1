Received: from eggs.gnu.org ([2001:4830:134:3::10]:58676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe5-00028x-KL
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe0-0003Ei-OO
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:21 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:35 +1000
Message-Id: <20170908103558.31632-18-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 17/40] booke206: fix booke206_tlbnps for mav 2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, KONRAD Frederic <frederic.konrad@adacore.com>, David Gibson <david@gibson.dropbear.id.au>

From: KONRAD Frederic <frederic.konrad@adacore.com>

This fixes booke206_tlbnps for MAV 2.0 by checking the MMUCFG register and
return directly the right tlbnps instead of computing it from non existing
field.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index cf4ded7b8e..21f0ddd056 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2473,10 +2473,10 @@ static inline ppcmas_tlb_t *booke206_get_tlbm(CPUPPCState *env, const int tlbn,
 /* returns bitmap of supported page sizes for a given TLB */
 static inline uint32_t booke206_tlbnps(CPUPPCState *env, const int tlbn)
 {
-    bool mav2 = false;
     uint32_t ret = 0;
 
-    if (mav2) {
+    if ((env->spr[SPR_MMUCFG] & MMUCFG_MAVN) == MMUCFG_MAVN_V2) {
+        /* MAV2 */
         ret = env->spr[SPR_BOOKE_TLB0PS + tlbn];
     } else {
         uint32_t tlbncfg = env->spr[SPR_BOOKE_TLB0CFG + tlbn];
-- 
2.13.5
