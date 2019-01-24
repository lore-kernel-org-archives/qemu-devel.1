Received: from eggs.gnu.org ([209.51.188.92]:48691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1gmcr1-0003B1-Iv
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:07:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1gmcqy-0003ER-2S
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:07:27 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38994 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ann.zhuangyanying@huawei.com>)
	id 1gmcqx-00033P-A9
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:07:23 -0500
From: Zhuangyanying <ann.zhuangyanying@huawei.com>
Date: Thu, 24 Jan 2019 11:02:25 +0000
Message-ID: <1548327746-20484-3-git-send-email-ann.zhuangyanying@huawei.com>
In-Reply-To: <1548327746-20484-1-git-send-email-ann.zhuangyanying@huawei.com>
References: <1548327746-20484-1-git-send-email-ann.zhuangyanying@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 2/3] KVM: MMU: introduce
 kvm_mmu_write_protect_all_pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoguangrong@tencent.com, sean.j.christopherson@intel.com, arei.gonglei@huawei.com, liu.jinsong@huawei.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com, Zhuang Yanying <ann.zhuangyanying@huawei.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

The original idea is from Avi. kvm_mmu_write_protect_all_pages() is
extremely fast to write protect all the guest memory. Comparing with
the ordinary algorithm which write protects last level sptes based on
the rmap one by one, it just simply updates the generation number to
ask all vCPUs to reload its root page table, particularly, it can be
done out of mmu-lock, so that it does not hurt vMMU's parallel. It is
the O(1) algorithm which does not depends on the capacity of guest's
memory and the number of guest's vCPUs

When reloading its root page table, the vCPU checks root page table's
generation number with current global number, if it is not matched, it
makes all the entries in page readonly and directly go to VM. So the
read access is still going on smoothly without KVM's involvement and
write access triggers page fault, then KVM moves the write protection
from the upper level to the lower level page - by making all the entries
in the lower page readonly first then make the upper level writable,
this operation is repeated until we meet the last spte

Note, the number of page fault and TLB flush are the same as the ordinary
algorithm. During our test, for a VM which has 3G memory and 12 vCPUs,
we benchmarked the performance of pure memory write after write protection,
noticed only 3% is dropped, however, we also benchmarked the case that
run the test case of pure memory-write in the new booted VM (i.e, it will
trigger #PF to map memory), at the same time, live migration is going on,
we noticed the diry page ratio is increased ~50%, that means, the memory's
performance is hugely improved during live migration

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Signed-off-by: Zhuang Yanying <ann.zhuangyanying@huawei.com>
---
 arch/x86/include/asm/kvm_host.h |  19 +++++
 arch/x86/kvm/mmu.c              | 172 ++++++++++++++++++++++++++++++++++++++--
 arch/x86/kvm/mmu.h              |   1 +
 arch/x86/kvm/paging_tmpl.h      |  13 ++-
 4 files changed, 196 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6633b40..3d4231b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -338,6 +338,13 @@ struct kvm_mmu_page {
 	/* The page is obsolete if mmu_valid_gen != kvm->arch.mmu_valid_gen.  */
 	unsigned long mmu_valid_gen;
 
+	/*
+	 * The generation number of write protection for all guest memory
+	 * which is synced with kvm_arch.mmu_write_protect_all_indicator
+	 * whenever it is linked into upper entry.
+	 */
+	u64 mmu_write_protect_all_gen;
+
 	DECLARE_BITMAP(unsync_child_bitmap, KVM_MMU_SP_ENTRY_NR);
 
 	DECLARE_BITMAP(possible_writable_spte_bitmap, KVM_MMU_SP_ENTRY_NR);
@@ -850,6 +857,18 @@ struct kvm_arch {
 	unsigned int n_max_mmu_pages;
 	unsigned int indirect_shadow_pages;
 	unsigned long mmu_valid_gen;
+
+	/*
+	 * The indicator of write protection for all guest memory.
+	 *
+	 * The top bit indicates if the write-protect is enabled,
+	 * remaining bits are used as a generation number which is
+	 * increased whenever write-protect is enabled.
+	 *
+	 * The enable bit and generation number are squeezed into
+	 * a single u64 so that it can be accessed atomically.
+	 */
+	u64 mmu_write_protect_all_indicator;
 	struct hlist_head mmu_page_hash[KVM_NUM_MMU_PAGES];
 	/*
 	 * Hash table of struct kvm_mmu_page.
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index e8adafc..effae7a 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -490,6 +490,29 @@ static void kvm_mmu_reset_all_pte_masks(void)
 		GENMASK_ULL(low_phys_bits - 1, PAGE_SHIFT);
 }
 
+/* see the comments in struct kvm_arch. */
+#define WP_ALL_ENABLE_BIT      (63)
+#define WP_ALL_ENABLE_MASK     (1ull << WP_ALL_ENABLE_BIT)
+#define WP_ALL_GEN_MASK        (~0ull & ~WP_ALL_ENABLE_MASK)
+
+/* should under mmu_lock */
+static bool get_write_protect_all_indicator(struct kvm *kvm, u64 *generation)
+{
+	u64 indicator = kvm->arch.mmu_write_protect_all_indicator;
+
+	*generation = indicator & WP_ALL_GEN_MASK;
+	return !!(indicator & WP_ALL_ENABLE_MASK);
+}
+
+static void
+set_write_protect_all_indicator(struct kvm *kvm, bool enable, u64 generation)
+{
+	u64 value = (u64)(!!enable) << WP_ALL_ENABLE_BIT;
+
+	value |= generation & WP_ALL_GEN_MASK;
+	kvm->arch.mmu_write_protect_all_indicator = value;
+}
+
 static int is_cpuid_PSE36(void)
 {
 	return 1;
@@ -2532,6 +2555,8 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 			flush |= kvm_sync_pages(vcpu, gfn, &invalid_list);
 	}
 	sp->mmu_valid_gen = vcpu->kvm->arch.mmu_valid_gen;
+	get_write_protect_all_indicator(vcpu->kvm,
+					&sp->mmu_write_protect_all_gen);
 	clear_page(sp->spt);
 	trace_kvm_mmu_get_page(sp, true);
 
@@ -3180,6 +3205,71 @@ static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
 	__direct_pte_prefetch(vcpu, sp, sptep);
 }
 
+static bool mmu_load_shadow_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	unsigned int offset;
+	u64 kvm_wp_all_gen;
+	bool flush = false;
+	bool is_write_protect_all_enabled = get_write_protect_all_indicator(
+						kvm, &kvm_wp_all_gen);
+
+	if (!is_write_protect_all_enabled)
+		return false;
+
+	if (sp->mmu_write_protect_all_gen == kvm_wp_all_gen)
+		return false;
+
+	if (!sp->possible_writable_sptes)
+		return false;
+
+	for_each_set_bit(offset, sp->possible_writable_spte_bitmap,
+		KVM_MMU_SP_ENTRY_NR) {
+		u64 *sptep = sp->spt + offset, spte = *sptep;
+
+		if (!sp->possible_writable_sptes)
+			break;
+
+		if (is_last_spte(spte, sp->role.level)) {
+			flush |= spte_write_protect(sptep, false);
+			continue;
+		}
+
+		mmu_spte_update_no_track(sptep, spte & ~PT_WRITABLE_MASK);
+		flush = true;
+	}
+
+	sp->mmu_write_protect_all_gen = kvm_wp_all_gen;
+	return flush;
+}
+
+static bool
+handle_readonly_upper_spte(struct kvm *kvm, u64 *sptep, int write_fault)
+{
+	u64 spte = *sptep;
+	struct kvm_mmu_page *child = page_header(spte & PT64_BASE_ADDR_MASK);
+	bool flush;
+
+	/*
+	 * delay the spte update to the point when write permission is
+	 * really needed.
+	 */
+	if (!write_fault)
+		return false;
+
+	/*
+	 * if it is already writable, that means the write-protection has
+	 * been moved to lower level.
+	 */
+	if (is_writable_pte(spte))
+		return false;
+
+	flush = mmu_load_shadow_page(kvm, child);
+
+	/* needn't flush tlb if the spte is changed from RO to RW. */
+	mmu_spte_update_no_track(sptep, spte | PT_WRITABLE_MASK);
+	return flush;
+}
+
 static int __direct_map(struct kvm_vcpu *vcpu, int write, int map_writable,
 			int level, gfn_t gfn, kvm_pfn_t pfn, bool prefault)
 {
@@ -3187,6 +3277,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, int write, int map_writable,
 	struct kvm_mmu_page *sp;
 	int emulate = 0;
 	gfn_t pseudo_gfn;
+	bool flush = false;
 
 	if (!VALID_PAGE(vcpu->arch.mmu->root_hpa))
 		return 0;
@@ -3209,10 +3300,18 @@ static int __direct_map(struct kvm_vcpu *vcpu, int write, int map_writable,
 			pseudo_gfn = base_addr >> PAGE_SHIFT;
 			sp = kvm_mmu_get_page(vcpu, pseudo_gfn, iterator.addr,
 					      iterator.level - 1, 1, ACC_ALL);
-
+			if (write)
+				flush |= mmu_load_shadow_page(vcpu->kvm, sp);
 			link_shadow_page(vcpu, iterator.sptep, sp);
+			continue;
 		}
+
+		flush |= handle_readonly_upper_spte(vcpu->kvm, iterator.sptep,
+						write);
 	}
+
+	if (flush)
+		kvm_flush_remote_tlbs(vcpu->kvm);
 	return emulate;
 }
 
@@ -3405,10 +3504,18 @@ static bool fast_page_fault(struct kvm_vcpu *vcpu, gva_t gva, int level,
 	do {
 		u64 new_spte;
 
-		for_each_shadow_entry_lockless(vcpu, gva, iterator, spte)
+		for_each_shadow_entry_lockless(vcpu, gva, iterator, spte) {
 			if (!is_shadow_present_pte(spte) ||
 			    iterator.level < level)
 				break;
+			/*
+			 * the fast path can not fix the upper spte which
+			 * is readonly.
+			 */
+			if ((error_code & PFERR_WRITE_MASK) &&
+				!is_writable_pte(spte))
+				break;
+		}
 
 		sp = page_header(__pa(iterator.sptep));
 		if (!is_last_spte(spte, sp->role.level))
@@ -3636,26 +3743,36 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		}
 		sp = kvm_mmu_get_page(vcpu, 0, 0,
 				vcpu->arch.mmu->shadow_root_level, 1, ACC_ALL);
+		if (mmu_load_shadow_page(vcpu->kvm, sp))
+			kvm_flush_remote_tlbs(vcpu->kvm);
+
 		++sp->root_count;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 		vcpu->arch.mmu->root_hpa = __pa(sp->spt);
 	} else if (vcpu->arch.mmu->shadow_root_level == PT32E_ROOT_LEVEL) {
+		bool flush = false;
+
+		spin_lock(&vcpu->kvm->mmu_lock);
 		for (i = 0; i < 4; ++i) {
 			hpa_t root = vcpu->arch.mmu->pae_root[i];
 
 			MMU_WARN_ON(VALID_PAGE(root));
-			spin_lock(&vcpu->kvm->mmu_lock);
 			if (make_mmu_pages_available(vcpu) < 0) {
+				if (flush)
+					kvm_flush_remote_tlbs(vcpu->kvm);
 				spin_unlock(&vcpu->kvm->mmu_lock);
 				return -ENOSPC;
 			}
 			sp = kvm_mmu_get_page(vcpu, i << (30 - PAGE_SHIFT),
 					i << 30, PT32_ROOT_LEVEL, 1, ACC_ALL);
+			flush |= mmu_load_shadow_page(vcpu->kvm, sp);
 			root = __pa(sp->spt);
 			++sp->root_count;
-			spin_unlock(&vcpu->kvm->mmu_lock);
 			vcpu->arch.mmu->pae_root[i] = root | PT_PRESENT_MASK;
 		}
+		if (flush)
+			kvm_flush_remote_tlbs(vcpu->kvm);
+		spin_unlock(&vcpu->kvm->mmu_lock);
 		vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->pae_root);
 	} else
 		BUG();
@@ -3669,6 +3786,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	u64 pdptr, pm_mask;
 	gfn_t root_gfn;
 	int i;
+	bool flush = false;
 
 	root_gfn = vcpu->arch.mmu->get_cr3(vcpu) >> PAGE_SHIFT;
 
@@ -3691,6 +3809,9 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 		}
 		sp = kvm_mmu_get_page(vcpu, root_gfn, 0,
 				vcpu->arch.mmu->shadow_root_level, 0, ACC_ALL);
+		if (mmu_load_shadow_page(vcpu->kvm, sp))
+			kvm_flush_remote_tlbs(vcpu->kvm);
+
 		root = __pa(sp->spt);
 		++sp->root_count;
 		spin_unlock(&vcpu->kvm->mmu_lock);
@@ -3707,6 +3828,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.mmu->shadow_root_level == PT64_ROOT_4LEVEL)
 		pm_mask |= PT_ACCESSED_MASK | PT_WRITABLE_MASK | PT_USER_MASK;
 
+	spin_lock(&vcpu->kvm->mmu_lock);
 	for (i = 0; i < 4; ++i) {
 		hpa_t root = vcpu->arch.mmu->pae_root[i];
 
@@ -3718,22 +3840,30 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 				continue;
 			}
 			root_gfn = pdptr >> PAGE_SHIFT;
-			if (mmu_check_root(vcpu, root_gfn))
+			if (mmu_check_root(vcpu, root_gfn)) {
+				if (flush)
+					kvm_flush_remote_tlbs(vcpu->kvm);
+				spin_unlock(&vcpu->kvm->mmu_lock);
 				return 1;
+			}
 		}
-		spin_lock(&vcpu->kvm->mmu_lock);
 		if (make_mmu_pages_available(vcpu) < 0) {
+			if (flush)
+				kvm_flush_remote_tlbs(vcpu->kvm);
 			spin_unlock(&vcpu->kvm->mmu_lock);
 			return -ENOSPC;
 		}
 		sp = kvm_mmu_get_page(vcpu, root_gfn, i << 30, PT32_ROOT_LEVEL,
 				      0, ACC_ALL);
+		flush |= mmu_load_shadow_page(vcpu->kvm, sp);
 		root = __pa(sp->spt);
 		++sp->root_count;
-		spin_unlock(&vcpu->kvm->mmu_lock);
-
 		vcpu->arch.mmu->pae_root[i] = root | pm_mask;
 	}
+
+	if (flush)
+		kvm_flush_remote_tlbs(vcpu->kvm);
+	spin_unlock(&vcpu->kvm->mmu_lock);
 	vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->pae_root);
 
 	/*
@@ -5951,6 +6081,32 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, struct kvm_memslots *slots)
 	}
 }
 
+void kvm_mmu_write_protect_all_pages(struct kvm *kvm, bool write_protect)
+{
+	u64 kvm_wp_all_gen;
+
+	spin_lock(&kvm->mmu_lock);
+	get_write_protect_all_indicator(kvm, &kvm_wp_all_gen);
+
+	/*
+	 * whenever it is enabled, we increase the generation to
+	 * update shadow pages.
+	 */
+	if (write_protect)
+		kvm_wp_all_gen++;
+
+	set_write_protect_all_indicator(kvm, write_protect, kvm_wp_all_gen);
+
+	/*
+	 * if it is enabled, we need to sync the root page tables
+	 * immediately, otherwise, the write protection is dropped
+	 * on demand, i.e, when page fault is triggered.
+	 */
+	if (write_protect)
+		kvm_reload_remote_mmus(kvm);
+	spin_unlock(&kvm->mmu_lock);
+}
+
 static unsigned long
 mmu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index c7b3331..d5f9adbd 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -210,5 +210,6 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 void kvm_mmu_gfn_allow_lpage(struct kvm_memory_slot *slot, gfn_t gfn);
 bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 				    struct kvm_memory_slot *slot, u64 gfn);
+void kvm_mmu_write_protect_all_pages(struct kvm *kvm, bool write_protect);
 int kvm_arch_write_log_dirty(struct kvm_vcpu *vcpu);
 #endif
diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 6bdca39..4f0cf31 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -602,6 +602,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t addr,
 	struct kvm_shadow_walk_iterator it;
 	unsigned direct_access, access = gw->pt_access;
 	int top_level, ret;
+	bool flush = false;
 
 	direct_access = gw->pte_access;
 
@@ -633,6 +634,8 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t addr,
 			table_gfn = gw->table_gfn[it.level - 2];
 			sp = kvm_mmu_get_page(vcpu, table_gfn, addr, it.level-1,
 					      false, access);
+			if (write_fault)
+				flush |= mmu_load_shadow_page(vcpu->kvm, sp);
 		}
 
 		/*
@@ -644,6 +647,9 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t addr,
 
 		if (sp)
 			link_shadow_page(vcpu, it.sptep, sp);
+		else
+			flush |= handle_readonly_upper_spte(vcpu->kvm, it.sptep,
+					write_fault);
 	}
 
 	for (;
@@ -656,13 +662,18 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t addr,
 
 		drop_large_spte(vcpu, it.sptep);
 
-		if (is_shadow_present_pte(*it.sptep))
+		if (is_shadow_present_pte(*it.sptep)) {
+			flush |= handle_readonly_upper_spte(vcpu->kvm,
+					it.sptep, write_fault);
 			continue;
+		}
 
 		direct_gfn = gw->gfn & ~(KVM_PAGES_PER_HPAGE(it.level) - 1);
 
 		sp = kvm_mmu_get_page(vcpu, direct_gfn, addr, it.level-1,
 				      true, direct_access);
+		if (write_fault)
+			flush |= mmu_load_shadow_page(vcpu->kvm, sp);
 		link_shadow_page(vcpu, it.sptep, sp);
 	}
 
-- 
1.8.3.1
