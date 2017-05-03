Received: from eggs.gnu.org ([2001:4830:134:3::10]:32937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d5ruA-0005GS-49
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d5ru8-0006g2-DP
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:53:10 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d5ru8-0006fi-7g
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:53:08 -0400
Received: by mail-pg0-x241.google.com with SMTP id v1so27770703pgv.3
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 03:53:08 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Wed,  3 May 2017 18:52:18 +0800
Message-Id: <20170503105224.19049-2-xiaoguangrong@tencent.com>
In-Reply-To: <20170503105224.19049-1-xiaoguangrong@tencent.com>
References: <20170503105224.19049-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 1/7] KVM: MMU: correct the behavior of
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
index 5586765..ba8e7af 100644
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
2.9.3
