Received: from eggs.gnu.org ([2001:4830:134:3::10]:52906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dNFGG-00007T-3i
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 05:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dNFGD-0007lw-Fy
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 05:15:48 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dNFGD-0007lb-Aj
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 05:15:45 -0400
Received: by mail-pf0-x242.google.com with SMTP id s66so21597948pfs.2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 02:15:45 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 20 Jun 2017 17:15:20 +0800
Message-Id: <20170620091526.4287-2-xiaoguangrong@tencent.com>
In-Reply-To: <20170620091526.4287-1-xiaoguangrong@tencent.com>
References: <20170620091526.4287-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 1/7] KVM: MMU: correct the behavior of
 mmu_spte_update_no_track
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mtosatti@redhat.com, avi.kivity@gmail.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong@tencent.com>

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
index 5d3376f..d18c17c 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -583,10 +583,29 @@ static void mmu_spte_set(u64 *sptep, u64 new_spte)
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
 
@@ -621,7 +640,7 @@ static u64 mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
 static bool mmu_spte_update(u64 *sptep, u64 new_spte)
 {
 	bool flush = false;
-	u64 old_spte = mmu_spte_update_no_track(sptep, new_spte);
+	u64 old_spte = mmu_spte_update_track(sptep, new_spte);
 
 	if (!is_shadow_present_pte(old_spte))
 		return false;
-- 
2.9.4
