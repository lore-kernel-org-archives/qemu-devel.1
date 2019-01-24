Received: from eggs.gnu.org ([209.51.188.92]:48690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1gmcr1-0003Az-Ih
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:07:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1gmcqy-0003EC-1O
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:07:27 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36112 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ann.zhuangyanying@huawei.com>)
	id 1gmcqx-000350-Dp
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:07:23 -0500
From: Zhuangyanying <ann.zhuangyanying@huawei.com>
Date: Thu, 24 Jan 2019 11:02:24 +0000
Message-ID: <1548327746-20484-2-git-send-email-ann.zhuangyanying@huawei.com>
In-Reply-To: <1548327746-20484-1-git-send-email-ann.zhuangyanying@huawei.com>
References: <1548327746-20484-1-git-send-email-ann.zhuangyanying@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/3] KVM: MMU: introduce
 possible_writable_spte_bitmap
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

It is used to track possible writable sptes on the shadow page on
which the bit is set to 1 for the sptes that are already writable
or can be locklessly updated to writable on the fast_page_fault
path, also a counter for the number of possible writable sptes is
introduced to speed up bitmap walking.

This works very efficiently as usually only one entry in
PML4 ( < 512 G)=EF=BC=8Cfew entries in PDPT (only entry indicates 1G
memory), PDEs and PTEs need to be write protected for the worst case.

Later patch will benefit good performance by using this bitmap and
counter to fast figure out writable sptes and write protect them.

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Signed-off-by: Zhuang Yanying <ann.zhuangyanying@huawei.com>
---
 arch/x86/include/asm/kvm_host.h |  5 +++-
 arch/x86/kvm/mmu.c              | 53 +++++++++++++++++++++++++++++++++++=
++++--
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
index 4660ce9..6633b40 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -128,6 +128,7 @@ static inline gfn_t gfn_to_index(gfn_t gfn, gfn_t bas=
e_gfn, int level)
 #define KVM_MIN_ALLOC_MMU_PAGES 64
 #define KVM_MMU_HASH_SHIFT 12
 #define KVM_NUM_MMU_PAGES (1 << KVM_MMU_HASH_SHIFT)
+#define KVM_MMU_SP_ENTRY_NR 512
 #define KVM_MIN_FREE_MMU_PAGES 5
 #define KVM_REFILL_PAGES 25
 #define KVM_MAX_CPUID_ENTRIES 80
@@ -331,13 +332,15 @@ struct kvm_mmu_page {
 	gfn_t *gfns;
 	int root_count;          /* Currently serving as active root */
 	unsigned int unsync_children;
+	unsigned int possible_writable_sptes;
 	struct kvm_rmap_head parent_ptes; /* rmap pointers to parent sptes */
=20
 	/* The page is obsolete if mmu_valid_gen !=3D kvm->arch.mmu_valid_gen. =
 */
 	unsigned long mmu_valid_gen;
=20
-	DECLARE_BITMAP(unsync_child_bitmap, 512);
+	DECLARE_BITMAP(unsync_child_bitmap, KVM_MMU_SP_ENTRY_NR);
=20
+	DECLARE_BITMAP(possible_writable_spte_bitmap, KVM_MMU_SP_ENTRY_NR);
 #ifdef CONFIG_X86_32
 	/*
 	 * Used out of the mmu-lock to avoid reading spte values while an
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index ce770b4..e8adafc 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -718,6 +718,49 @@ static bool is_dirty_spte(u64 spte)
 	return dirty_mask ? spte & dirty_mask : spte & PT_WRITABLE_MASK;
 }
=20
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
+	struct kvm_mmu_page *sp =3D page_header(__pa(sptep));
+	bool old_state, new_state;
+
+	old_state =3D is_possible_writable_spte(old_spte);
+	new_state =3D is_possible_writable_spte(new_spte);
+
+	if (old_state =3D=3D new_state)
+		return;
+
+	/* a possible writable spte is dropped */
+	if (old_state) {
+		sp->possible_writable_sptes--;
+		__clear_bit(sptep - sp->spt, sp->possible_writable_spte_bitmap);
+		return;
+	}
+
+	/* a new possible writable spte is set */
+	sp->possible_writable_sptes++;
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
=20
 /*
@@ -751,7 +795,7 @@ static u64 mmu_spte_update_no_track(u64 *sptep, u64 n=
ew_spte)
 		old_spte =3D __update_clear_spte_slow(sptep, new_spte);
=20
 	WARN_ON(spte_to_pfn(old_spte) !=3D spte_to_pfn(new_spte));
-
+	mmu_log_possible_writable_spte(sptep, old_spte, new_spte);
 	return old_spte;
 }
=20
@@ -817,6 +861,8 @@ static int mmu_spte_clear_track_bits(u64 *sptep)
 	else
 		old_spte =3D __update_clear_spte_slow(sptep, 0ull);
=20
+	mmu_log_possible_writable_spte(sptep, old_spte, 0ull);
+
 	if (!is_shadow_present_pte(old_spte))
 		return 0;
=20
@@ -845,7 +891,10 @@ static int mmu_spte_clear_track_bits(u64 *sptep)
  */
 static void mmu_spte_clear_no_track(u64 *sptep)
 {
+	u64 old_spte =3D *sptep;
+
 	__update_clear_spte_fast(sptep, 0ull);
+	mmu_log_possible_writable_spte(sptep, old_spte, 0ull);
 }
=20
 static u64 mmu_spte_get_lockless(u64 *sptep)
@@ -2140,7 +2189,7 @@ static int __mmu_unsync_walk(struct kvm_mmu_page *s=
p,
 {
 	int i, ret, nr_unsync_leaf =3D 0;
=20
-	for_each_set_bit(i, sp->unsync_child_bitmap, 512) {
+	for_each_set_bit(i, sp->unsync_child_bitmap, KVM_MMU_SP_ENTRY_NR) {
 		struct kvm_mmu_page *child;
 		u64 ent =3D sp->spt[i];
=20
--=20
1.8.3.1
