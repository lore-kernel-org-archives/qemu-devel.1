Received: from eggs.gnu.org ([2001:4830:134:3::10]:57478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dekKT-0007xg-0v
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dekKO-0005n3-Cv
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:52:29 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:44797
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dekKO-0005m6-7I
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:52:24 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Mon,  7 Aug 2017 17:50:45 +0200
Message-Id: <1502121048-1816-2-git-send-email-frederic.konrad@adacore.com>
In-Reply-To: <1502121048-1816-1-git-send-email-frederic.konrad@adacore.com>
References: <1502121048-1816-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH for-2.11 1/4] booke206: fix booke206_tlbnps for
 mav 2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au, agraf@suse.de
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, frederic.konrad@adacore.com

This fixes booke206_tlbnps for MAV 2.0 by checking the MMUCFG register and
return directly the right tlbnps instead of computing it from non existing
field.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 target/ppc/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 6ee2a26..d2faea9 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2472,10 +2472,10 @@ static inline ppcmas_tlb_t *booke206_get_tlbm(CPUPPCState *env, const int tlbn,
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
1.8.3.1
