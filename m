Received: from eggs.gnu.org ([209.51.188.92]:42436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1gk8Dw-0007R3-TQ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1gk8Dt-0002Rl-Mq
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:00:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46612 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ann.zhuangyanying@huawei.com>)
	id 1gk8Ds-0001Y0-Sa
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:00:45 -0500
From: Zhuangyanying <ann.zhuangyanying@huawei.com>
Date: Thu, 17 Jan 2019 13:55:29 +0000
Message-ID: <1547733331-16140-3-git-send-email-ann.zhuangyanying@huawei.com>
In-Reply-To: <1547733331-16140-1-git-send-email-ann.zhuangyanying@huawei.com>
References: <1547733331-16140-1-git-send-email-ann.zhuangyanying@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/4] KVM: MMU: introduce
 possible_writable_spte_bitmap
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

It is used to track possible writable sptes on the shadow page on
which the bit is set to 1 for the sptes that are already writable
or can be locklessly updated to writable on the fast_page_fault
path, also a counter for the number of possible writable sptes is
introduced to speed up bitmap walking

Later patch will benefit good performance by using this bitmap and
counter to fast figure out writable sptes and write protect them

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 arch/x86/include/asm/kvm_host.h |  6 ++++-
 arch/x86/kvm/mmu.c              | 53 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4660ce9..5c30aa0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -128,6 +128,7 @@ static inline gfn_t gfn_to_index(gfn_t gfn, gfn_t base_gfn, int level)
 #define KVM_MIN_ALLOC_MMU_PAGES 64
 #define KVM_MMU_HASH_SHIFT 12
 #define KVM_NUM_MMU_PAGES (1 << KVM_MMU_HASH_SHIFT)
+#define KVM_MMU_SP_ENTRY_NR 512
 #define KVM_MIN_FREE_MMU_PAGES 5
 #define KVM_REFILL_PAGES 25
 #define KVM_MAX_CPUID_ENTRIES 80
@@ -331,12 +332,15 @@ struct kvm_mmu_page {
 	gfn_t *gfns;
 	int root_count;          /* Currently serving as active root */
 	unsigned int unsync_children;
+	unsigned int possiable_writable_sptes;
 	struct kvm_rmap_head parent_ptes; /* rmap pointers to parent sptes */
 
 	/* The page is obsolete if mmu_valid_gen != kvm->arch.mmu_valid_gen.  */
 	unsigned long mmu_valid_gen;
 
-	DECLARE_BITMAP(unsync_child_bitmap, 512);
+	DECLARE_BITMAP(unsync_child_bitmap, KVM_MMU_SP_ENTRY_NR);
+
+	DECLARE_BITMAP(possible_writable_spte_bitmap, KVM_MMU_SP_ENTRY_NR);
 
 #ifdef CONFIG_X86_32
 	/*
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index eeb3bac..9daab00 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -718,6 +718,49 @@ static bool is_dirty_spte(u64 spte)
 	return dirty_mask ? spte & dirty_mask : spte & PT_WRITABLE_MASK;
 }
 
+static bool is_possible_writable_spte(u64 spte)
+{
+	if (!is_shadow_present_pte(spte))
+		return false;
+
+	if (is_writable_pte(spte))
+		return true;
+
+	if (spte_can_locklessly_be_made_writable(spte))
+		return true;
+
+	/*
+	 * although is_access_track_spte() sptes can be updated out of
+	 * mmu-lock, we need not take them into account as access_track
+	 * drops writable bit for them
+	 */
+	return false;
+}
+
+static void
+mmu_log_possible_writable_spte(u64 *sptep, u64 old_spte, u64 new_spte)
+{
+	struct kvm_mmu_page *sp = page_header(__pa(sptep));
+	bool old_state, new_state;
+
+	old_state = is_possible_writable_spte(old_spte);
+	new_state = is_possible_writable_spte(new_spte);
+
+	if (old_state == new_state)
+		return;
+
+	/* a possible writable spte is dropped */
+	if (old_state) {
+		sp->possiable_writable_sptes--;
+		__clear_bit(sptep - sp->spt, sp->possible_writable_spte_bitmap);
+		return;
+	}
+
+	/* a new possible writable spte is set */
+	sp->possiable_writable_sptes++;
+	__set_bit(sptep - sp->spt, sp->possible_writable_spte_bitmap);
+}
+
 /* Rules for using mmu_spte_set:
  * Set the sptep from nonpresent to present.
  * Note: the sptep being assigned *must* be either not present
@@ -728,6 +771,7 @@ static void mmu_spte_set(u64 *sptep, u64 new_spte)
 {
 	WARN_ON(is_shadow_present_pte(*sptep));
 	__set_spte(sptep, new_spte);
+	mmu_log_possible_writable_spte(sptep, 0ull, new_spte);
 }
 
 /*
@@ -746,6 +790,7 @@ static void mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
 	}
 
 	__update_clear_spte_fast(sptep, new_spte);
+	mmu_log_possible_writable_spte(sptep, old_spte, new_spte);
 }
 
 /*
@@ -771,6 +816,7 @@ static u64 mmu_spte_update_track(u64 *sptep, u64 new_spte)
 
 	WARN_ON(spte_to_pfn(old_spte) != spte_to_pfn(new_spte));
 
+	mmu_log_possible_writable_spte(sptep, old_spte, new_spte);
 	return old_spte;
 }
 
@@ -836,6 +882,8 @@ static int mmu_spte_clear_track_bits(u64 *sptep)
 	else
 		old_spte = __update_clear_spte_slow(sptep, 0ull);
 
+	mmu_log_possible_writable_spte(sptep, old_spte, 0ull);
+
 	if (!is_shadow_present_pte(old_spte))
 		return 0;
 
@@ -864,7 +912,10 @@ static int mmu_spte_clear_track_bits(u64 *sptep)
  */
 static void mmu_spte_clear_no_track(u64 *sptep)
 {
+	u64 old_spte = *sptep;
+
 	__update_clear_spte_fast(sptep, 0ull);
+	mmu_log_possible_writable_spte(sptep, old_spte, 0ull);
 }
 
 static u64 mmu_spte_get_lockless(u64 *sptep)
@@ -2159,7 +2210,7 @@ static int __mmu_unsync_walk(struct kvm_mmu_page *sp,
 {
 	int i, ret, nr_unsync_leaf = 0;
 
-	for_each_set_bit(i, sp->unsync_child_bitmap, 512) {
+	for_each_set_bit(i, sp->unsync_child_bitmap, KVM_MMU_SP_ENTRY_NR) {
 		struct kvm_mmu_page *child;
 		u64 ent = sp->spt[i];
 
-- 
1.8.3.1
