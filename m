Received: from eggs.gnu.org ([209.51.188.92]:42435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1gk8Dw-0007R2-TP
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1gk8Dt-0002QS-8i
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:00:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2173 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ann.zhuangyanying@huawei.com>)
	id 1gk8Dr-0001u4-AN
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:00:44 -0500
From: Zhuangyanying <ann.zhuangyanying@huawei.com>
Date: Thu, 17 Jan 2019 13:55:30 +0000
Message-ID: <1547733331-16140-4-git-send-email-ann.zhuangyanying@huawei.com>
In-Reply-To: <1547733331-16140-1-git-send-email-ann.zhuangyanying@huawei.com>
References: <1547733331-16140-1-git-send-email-ann.zhuangyanying@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] KVM: MMU: introduce
 kvm_mmu_write_protect_all_pages
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

In order to speed up the process of making all entries readonly, we
introduce possible_writable_spte_bitmap which indicates the writable
sptes and possiable_writable_sptes which is a counter indicating the
number of writable sptes, this works very efficiently as usually only
one entry in PML4 ( < 512 G)=EF=BC=8Cfew entries in PDPT (only entry indi=
cates
1G memory), PDEs and PTEs need to be write protected for the worst case.
Note, the number of page fault and TLB flush are the same as the ordinary
algorithm. During our test, for a VM which has 3G memory and 12 vCPUs,
we benchmarked the performance of pure memory write after write protectio=
n,
noticed only 3% is dropped, however, we also benchmarked the case that
run the test case of pure memory-write in the new booted VM (i.e, it will
trigger #PF to map memory), at the same time, live migration is going on,
we noticed the diry page ratio is increased ~50%, that means, the memory'=
s
performance is hugely improved during live migration

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 arch/x86/include/asm/kvm_host.h |  19 +++++
 arch/x86/kvm/mmu.c              | 179 ++++++++++++++++++++++++++++++++++=
++++--
 arch/x86/kvm/mmu.h              |   1 +
 arch/x86/kvm/paging_tmpl.h      |  13 ++-
 4 files changed, 204 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
index 5c30aa0..a581ff4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -338,6 +338,13 @@ struct kvm_mmu_page {
 	/* The page is obsolete if mmu_valid_gen !=3D kvm->arch.mmu_valid_gen. =
 */
 	unsigned long mmu_valid_gen;
=20
+	/*
+	 * The generation number of write protection for all guest memory
+	 * which is synced with kvm_arch.mmu_write_protect_all_indicator
+	 * whenever it is linked into upper entry.
+	 */
+	u64 mmu_write_protect_all_gen;
+
 	DECLARE_BITMAP(unsync_child_bitmap, KVM_MMU_SP_ENTRY_NR);
=20
 	DECLARE_BITMAP(possible_writable_spte_bitmap, KVM_MMU_SP_ENTRY_NR);
@@ -851,6 +858,18 @@ struct kvm_arch {
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
+	atomic64_t mmu_write_protect_all_indicator;
 	struct hlist_head mmu_page_hash[KVM_NUM_MMU_PAGES];
 	/*
 	 * Hash table of struct kvm_mmu_page.
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 9daab00..047b897 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -489,6 +489,34 @@ static void kvm_mmu_reset_all_pte_masks(void)
 	shadow_nonpresent_or_rsvd_lower_gfn_mask =3D
 		GENMASK_ULL(low_phys_bits - 1, PAGE_SHIFT);
 }
+/* see the comments in struct kvm_arch. */
+#define WP_ALL_ENABLE_BIT	(63)
+#define WP_ALL_ENABLE_MASK	(1ull << WP_ALL_ENABLE_BIT)
+#define WP_ALL_GEN_MASK		(~0ull & ~WP_ALL_ENABLE_MASK)
+
+static bool is_write_protect_all_enabled(u64 indicator)
+{
+	return !!(indicator & WP_ALL_ENABLE_MASK);
+}
+
+static u64 get_write_protect_all_gen(u64 indicator)
+{
+	return indicator & WP_ALL_GEN_MASK;
+}
+
+static u64 get_write_protect_all_indicator(struct kvm *kvm)
+{
+	return atomic64_read(&kvm->arch.mmu_write_protect_all_indicator);
+}
+
+static void
+set_write_protect_all_indicator(struct kvm *kvm, bool enable, u64 genera=
tion)
+{
+	u64 value =3D (u64)(!!enable) << WP_ALL_ENABLE_BIT;
+
+	value |=3D generation & WP_ALL_GEN_MASK;
+	atomic64_set(&kvm->arch.mmu_write_protect_all_indicator, value);
+}
=20
 static int is_cpuid_PSE36(void)
 {
@@ -2479,6 +2507,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct=
 kvm_vcpu *vcpu,
 					     int direct,
 					     unsigned access)
 {
+	u64 write_protect_indicator;
 	union kvm_mmu_page_role role;
 	unsigned quadrant;
 	struct kvm_mmu_page *sp;
@@ -2553,6 +2582,9 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct=
 kvm_vcpu *vcpu,
 			flush |=3D kvm_sync_pages(vcpu, gfn, &invalid_list);
 	}
 	sp->mmu_valid_gen =3D vcpu->kvm->arch.mmu_valid_gen;
+	write_protect_indicator =3D get_write_protect_all_indicator(vcpu->kvm);
+	sp->mmu_write_protect_all_gen =3D
+			get_write_protect_all_gen(write_protect_indicator);
 	clear_page(sp->spt);
 	trace_kvm_mmu_get_page(sp, true);
=20
@@ -3201,6 +3233,70 @@ static void direct_pte_prefetch(struct kvm_vcpu *v=
cpu, u64 *sptep)
 	__direct_pte_prefetch(vcpu, sp, sptep);
 }
=20
+static bool mmu_load_shadow_page(struct kvm *kvm, struct kvm_mmu_page *s=
p)
+{
+	unsigned int offset;
+	u64 wp_all_indicator =3D get_write_protect_all_indicator(kvm);
+	u64 kvm_wp_all_gen =3D get_write_protect_all_gen(wp_all_indicator);
+	bool flush =3D false;
+
+	if (!is_write_protect_all_enabled(wp_all_indicator))
+		return false;
+
+	if (sp->mmu_write_protect_all_gen =3D=3D kvm_wp_all_gen)
+		return false;
+
+	if (!sp->possiable_writable_sptes)
+		return false;
+
+	for_each_set_bit(offset, sp->possible_writable_spte_bitmap,
+	      KVM_MMU_SP_ENTRY_NR) {
+		u64 *sptep =3D sp->spt + offset, spte =3D *sptep;
+
+		if (!sp->possiable_writable_sptes)
+			break;
+
+		if (is_last_spte(spte, sp->role.level)) {
+			flush |=3D spte_write_protect(sptep, false);
+			continue;
+		}
+
+		mmu_spte_update_no_track(sptep, spte & ~PT_WRITABLE_MASK);
+		flush =3D true;
+	}
+
+	sp->mmu_write_protect_all_gen =3D kvm_wp_all_gen;
+	return flush;
+}
+
+static bool
+handle_readonly_upper_spte(struct kvm *kvm, u64 *sptep, int write_fault)
+{
+	u64 spte =3D *sptep;
+	struct kvm_mmu_page *child =3D page_header(spte & PT64_BASE_ADDR_MASK);
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
+	flush =3D mmu_load_shadow_page(kvm, child);
+
+	/* needn't flush tlb if the spte is changed from RO to RW. */
+	mmu_spte_update_no_track(sptep, spte | PT_WRITABLE_MASK);
+	return flush;
+}
+
 static int __direct_map(struct kvm_vcpu *vcpu, int write, int map_writab=
le,
 			int level, gfn_t gfn, kvm_pfn_t pfn, bool prefault)
 {
@@ -3208,6 +3304,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, int =
write, int map_writable,
 	struct kvm_mmu_page *sp;
 	int emulate =3D 0;
 	gfn_t pseudo_gfn;
+	bool flush =3D false;
=20
 	if (!VALID_PAGE(vcpu->arch.mmu->root_hpa))
 		return 0;
@@ -3230,10 +3327,19 @@ static int __direct_map(struct kvm_vcpu *vcpu, in=
t write, int map_writable,
 			pseudo_gfn =3D base_addr >> PAGE_SHIFT;
 			sp =3D kvm_mmu_get_page(vcpu, pseudo_gfn, iterator.addr,
 					      iterator.level - 1, 1, ACC_ALL);
+			if (write)
+				flush |=3D mmu_load_shadow_page(vcpu->kvm, sp);
=20
 			link_shadow_page(vcpu, iterator.sptep, sp);
+			continue;
 		}
+
+		flush |=3D handle_readonly_upper_spte(vcpu->kvm, iterator.sptep,
+						    write);
 	}
+
+	if (flush)
+		kvm_flush_remote_tlbs(vcpu->kvm);
 	return emulate;
 }
=20
@@ -3426,10 +3532,18 @@ static bool fast_page_fault(struct kvm_vcpu *vcpu=
, gva_t gva, int level,
 	do {
 		u64 new_spte;
=20
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
+			      !is_writable_pte(spte))
+				break;
+		}
=20
 		sp =3D page_header(__pa(iterator.sptep));
 		if (!is_last_spte(spte, sp->role.level))
@@ -3657,26 +3771,37 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu=
 *vcpu)
 		}
 		sp =3D kvm_mmu_get_page(vcpu, 0, 0,
 				vcpu->arch.mmu->shadow_root_level, 1, ACC_ALL);
+		if (mmu_load_shadow_page(vcpu->kvm, sp))
+			kvm_flush_remote_tlbs(vcpu->kvm);
+
 		++sp->root_count;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 		vcpu->arch.mmu->root_hpa =3D __pa(sp->spt);
 	} else if (vcpu->arch.mmu->shadow_root_level =3D=3D PT32E_ROOT_LEVEL) {
+		bool flush =3D false;
+
+		spin_lock(&vcpu->kvm->mmu_lock);
 		for (i =3D 0; i < 4; ++i) {
 			hpa_t root =3D vcpu->arch.mmu->pae_root[i];
=20
 			MMU_WARN_ON(VALID_PAGE(root));
-			spin_lock(&vcpu->kvm->mmu_lock);
 			if (make_mmu_pages_available(vcpu) < 0) {
+				if (flush)
+					kvm_flush_remote_tlbs(vcpu->kvm);
 				spin_unlock(&vcpu->kvm->mmu_lock);
 				return -ENOSPC;
 			}
 			sp =3D kvm_mmu_get_page(vcpu, i << (30 - PAGE_SHIFT),
 					i << 30, PT32_ROOT_LEVEL, 1, ACC_ALL);
+			flush |=3D mmu_load_shadow_page(vcpu->kvm, sp);
 			root =3D __pa(sp->spt);
 			++sp->root_count;
-			spin_unlock(&vcpu->kvm->mmu_lock);
 			vcpu->arch.mmu->pae_root[i] =3D root | PT_PRESENT_MASK;
 		}
+
+		if (flush)
+			kvm_flush_remote_tlbs(vcpu->kvm);
+		spin_unlock(&vcpu->kvm->mmu_lock);
 		vcpu->arch.mmu->root_hpa =3D __pa(vcpu->arch.mmu->pae_root);
 	} else
 		BUG();
@@ -3690,6 +3815,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *=
vcpu)
 	u64 pdptr, pm_mask;
 	gfn_t root_gfn;
 	int i;
+	bool flush =3D false;
=20
 	root_gfn =3D vcpu->arch.mmu->get_cr3(vcpu) >> PAGE_SHIFT;
=20
@@ -3712,6 +3838,9 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *=
vcpu)
 		}
 		sp =3D kvm_mmu_get_page(vcpu, root_gfn, 0,
 				vcpu->arch.mmu->shadow_root_level, 0, ACC_ALL);
+		if (mmu_load_shadow_page(vcpu->kvm, sp))
+			kvm_flush_remote_tlbs(vcpu->kvm);
+
 		root =3D __pa(sp->spt);
 		++sp->root_count;
 		spin_unlock(&vcpu->kvm->mmu_lock);
@@ -3728,6 +3857,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *=
vcpu)
 	if (vcpu->arch.mmu->shadow_root_level =3D=3D PT64_ROOT_4LEVEL)
 		pm_mask |=3D PT_ACCESSED_MASK | PT_WRITABLE_MASK | PT_USER_MASK;
=20
+	spin_lock(&vcpu->kvm->mmu_lock);
 	for (i =3D 0; i < 4; ++i) {
 		hpa_t root =3D vcpu->arch.mmu->pae_root[i];
=20
@@ -3739,22 +3869,30 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu=
 *vcpu)
 				continue;
 			}
 			root_gfn =3D pdptr >> PAGE_SHIFT;
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
 		sp =3D kvm_mmu_get_page(vcpu, root_gfn, i << 30, PT32_ROOT_LEVEL,
 				      0, ACC_ALL);
+		flush |=3D mmu_load_shadow_page(vcpu->kvm, sp);
 		root =3D __pa(sp->spt);
 		++sp->root_count;
-		spin_unlock(&vcpu->kvm->mmu_lock);
-
 		vcpu->arch.mmu->pae_root[i] =3D root | pm_mask;
 	}
+
+	if (flush)
+		kvm_flush_remote_tlbs(vcpu->kvm);
+	spin_unlock(&vcpu->kvm->mmu_lock);
 	vcpu->arch.mmu->root_hpa =3D __pa(vcpu->arch.mmu->pae_root);
=20
 	/*
@@ -5972,6 +6110,33 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm=
, struct kvm_memslots *slots)
 	}
 }
=20
+void kvm_mmu_write_protect_all_pages(struct kvm *kvm, bool write_protect=
)
+{
+	u64 wp_all_indicator, kvm_wp_all_gen;
+
+	mutex_lock(&kvm->slots_lock);
+	wp_all_indicator =3D get_write_protect_all_indicator(kvm);
+	kvm_wp_all_gen =3D get_write_protect_all_gen(wp_all_indicator);
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
+	mutex_unlock(&kvm->slots_lock);
+}
+
 static unsigned long
 mmu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index c7b3331..d5f9adbd 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -210,5 +210,6 @@ static inline u8 permission_fault(struct kvm_vcpu *vc=
pu, struct kvm_mmu *mmu,
 void kvm_mmu_gfn_allow_lpage(struct kvm_memory_slot *slot, gfn_t gfn);
 bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 				    struct kvm_memory_slot *slot, u64 gfn);
+void kvm_mmu_write_protect_all_pages(struct kvm *kvm, bool write_protect=
);
 int kvm_arch_write_log_dirty(struct kvm_vcpu *vcpu);
 #endif
diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 6bdca39..27166d7 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -602,6 +602,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t =
addr,
 	struct kvm_shadow_walk_iterator it;
 	unsigned direct_access, access =3D gw->pt_access;
 	int top_level, ret;
+	bool flush =3D false;
=20
 	direct_access =3D gw->pte_access;
=20
@@ -633,6 +634,8 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t =
addr,
 			table_gfn =3D gw->table_gfn[it.level - 2];
 			sp =3D kvm_mmu_get_page(vcpu, table_gfn, addr, it.level-1,
 					      false, access);
+			if (write_fault)
+				flush |=3D mmu_load_shadow_page(vcpu->kvm, sp);
 		}
=20
 		/*
@@ -644,6 +647,9 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t =
addr,
=20
 		if (sp)
 			link_shadow_page(vcpu, it.sptep, sp);
+		else
+			flush |=3D handle_readonly_upper_spte(vcpu->kvm, it.sptep,
+							    write_fault);
 	}
=20
 	for (;
@@ -656,13 +662,18 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_=
t addr,
=20
 		drop_large_spte(vcpu, it.sptep);
=20
-		if (is_shadow_present_pte(*it.sptep))
+		if (is_shadow_present_pte(*it.sptep)) {
+			flush |=3D handle_readonly_upper_spte(vcpu->kvm,
+							it.sptep, write_fault);
 			continue;
+		}
=20
 		direct_gfn =3D gw->gfn & ~(KVM_PAGES_PER_HPAGE(it.level) - 1);
=20
 		sp =3D kvm_mmu_get_page(vcpu, direct_gfn, addr, it.level-1,
 				      true, direct_access);
+		if (write_fault)
+			flush |=3D mmu_load_shadow_page(vcpu->kvm, sp);
 		link_shadow_page(vcpu, it.sptep, sp);
 	}
=20
--=20
1.8.3.1
