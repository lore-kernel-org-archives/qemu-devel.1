Received: from eggs.gnu.org ([209.51.188.92]:42427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1gk8Dw-0007Qq-Lm
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1gk8Dt-0002PX-4i
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:00:47 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46618 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ann.zhuangyanying@huawei.com>)
	id 1gk8Dr-0001Y2-22
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:00:43 -0500
From: Zhuangyanying <ann.zhuangyanying@huawei.com>
Date: Thu, 17 Jan 2019 13:55:28 +0000
Message-ID: <1547733331-16140-2-git-send-email-ann.zhuangyanying@huawei.com>
In-Reply-To: <1547733331-16140-1-git-send-email-ann.zhuangyanying@huawei.com>
References: <1547733331-16140-1-git-send-email-ann.zhuangyanying@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/4] KVM: MMU: correct the behavior of
 mmu_spte_update_no_track
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoguangrong@tencent.com, pbonzini@redhat.com, arei.gonglei@huawei.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, wangxinxin.wang@huawei.com, liu.jinsong@huawei.com

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Current behavior of mmu_spte_update_no_track() does not match
the name of _no_track() as actually the A/D bits are tracked
and returned to the caller

This patch introduces the real _no_track() function to update
the spte regardless of A/D bits and rename the original function
to _track()

The _no_track() function will be used by later patches to update
upper spte which need not care of A/D bits indeed

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 arch/x86/kvm/mmu.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index ce770b4..eeb3bac 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -731,10 +731,29 @@ static void mmu_spte_set(u64 *sptep, u64 new_spte)
 }
 
 /*
- * Update the SPTE (excluding the PFN), but do not track changes in its
+ * Update the SPTE (excluding the PFN) regardless of accessed/dirty
+ * status which is used to update the upper level spte.
+ */
+static void mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
+{
+	u64 old_spte = *sptep;
+
+	WARN_ON(!is_shadow_present_pte(new_spte));
+
+	if (!is_shadow_present_pte(old_spte)) {
+		mmu_spte_set(sptep, new_spte);
+		return;
+	}
+
+	__update_clear_spte_fast(sptep, new_spte);
+}
+
+/*
+ * Update the SPTE (excluding the PFN), the original value is
+ * returned, based on it, the caller can track changes of its
  * accessed/dirty status.
  */
-static u64 mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
+static u64 mmu_spte_update_track(u64 *sptep, u64 new_spte)
 {
 	u64 old_spte = *sptep;
 
@@ -769,7 +788,7 @@ static u64 mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
 static bool mmu_spte_update(u64 *sptep, u64 new_spte)
 {
 	bool flush = false;
-	u64 old_spte = mmu_spte_update_no_track(sptep, new_spte);
+	u64 old_spte = mmu_spte_update_track(sptep, new_spte);
 
 	if (!is_shadow_present_pte(old_spte))
 		return false;
-- 
1.8.3.1
