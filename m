Received: from eggs.gnu.org ([2001:4830:134:3::10]:59343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1erP7A-0003Kj-7T
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:23:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1erP74-0005Bz-PJ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:23:18 -0500
Received: from mel.act-europe.fr ([194.98.77.210]:40731
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1erP74-0005BV-JJ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:23:14 -0500
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Thu,  1 Mar 2018 15:22:53 +0100
Message-Id: <1519914173-31868-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [RFC PATCH] sparc: fix leon3 casa instruction when MMU
 is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, mark.cave-ayland@ilande.co.uk, KONRAD Frederic <frederic.konrad@adacore.com>

Since the commit af7a06bac7d3abb2da48ef3277d2a415772d2ae8:
`casa [..](10), .., ..` triggers a data access exception when the MMU
is disabled.

This fixes this wrong behavior.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---

Notes:
    There is an other way to do that: emiting the instruction with a
    MMU_PHYS_IDX when the MMU is disabled. I can switch to that if it's a
    prefered method.

 target/sparc/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index f8886ae..3cebf50 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -100,7 +100,7 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
 
     is_user = mmu_idx == MMU_USER_IDX;
 
-    if (mmu_idx == MMU_PHYS_IDX) {
+    if ((mmu_idx == MMU_PHYS_IDX) || ((env->mmuregs[0] & MMU_E) == 0)) {
         *page_size = TARGET_PAGE_SIZE;
         /* Boot mode: instruction fetches are taken from PROM */
         if (rw == 2 && (env->mmuregs[0] & env->def.mmu_bm)) {
-- 
1.8.3.1
