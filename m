Received: from eggs.gnu.org ([209.51.188.92]:48663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1gmcqz-00039s-33
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1gmcqy-0003EJ-2X
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:07:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2235 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ann.zhuangyanying@huawei.com>)
	id 1gmcqx-00030C-Fe
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:07:23 -0500
From: Zhuangyanying <ann.zhuangyanying@huawei.com>
Date: Thu, 24 Jan 2019 11:02:26 +0000
Message-ID: <1548327746-20484-4-git-send-email-ann.zhuangyanying@huawei.com>
In-Reply-To: <1548327746-20484-1-git-send-email-ann.zhuangyanying@huawei.com>
References: <1548327746-20484-1-git-send-email-ann.zhuangyanying@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 3/3] KVM: MMU: fast cleanup D bit based on
 fast write protect
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

From: Zhuang Yanying <ann.zhuangyanying@huawei.com>

When live-migration with large-memory guests, vcpu may hang for a long
time while starting migration, such as 9s for 2T
(linux-5.0.0-rc2+qemu-3.1.0).
The reason is memory_global_dirty_log_start() taking too long, and the
vcpu is waiting for BQL. The page-by-page D bit clearup is the main time
consumption. I think that the idea of "KVM: MMU: fast write protect" by
xiaoguangrong, especially the function kvm_mmu_write_protect_all_pages(),
is very helpful. After a little modifcation, on his patch, can solve
this problem, 9s to 0.5s.

At the beginning of live migration, write protection is only applied to the
top-level SPTE. Then the write from vm trigger the EPT violation, with
for_each_shadow_entry write protection is performed at dirct_map.
Finally the Dirty bit of the target page(at level 1 page table) is
cleared, and the dirty page tracking is started. The page where
GPA is located is marked dirty when mmu_set_spte.

Signed-off-by: Zhuang Yanying <ann.zhuangyanying@huawei.com>
---
 arch/x86/kvm/mmu.c     | 6 +++++-
 arch/x86/kvm/vmx/vmx.c | 5 ++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index effae7a..ac7a994 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3230,7 +3230,10 @@ static bool mmu_load_shadow_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 			break;
 
 		if (is_last_spte(spte, sp->role.level)) {
-			flush |= spte_write_protect(sptep, false);
+			if (sp->role.level == PT_PAGE_TABLE_LEVEL)
+				flush |= spte_clear_dirty(sptep);
+			else
+				flush |= spte_write_protect(sptep, false);
 			continue;
 		}
 
@@ -6106,6 +6109,7 @@ void kvm_mmu_write_protect_all_pages(struct kvm *kvm, bool write_protect)
 		kvm_reload_remote_mmus(kvm);
 	spin_unlock(&kvm->mmu_lock);
 }
+EXPORT_SYMBOL_GPL(kvm_mmu_write_protect_all_pages);
 
 static unsigned long
 mmu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f6915f1..540ec21 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7180,14 +7180,13 @@ static void vmx_sched_in(struct kvm_vcpu *vcpu, int cpu)
 static void vmx_slot_enable_log_dirty(struct kvm *kvm,
 				     struct kvm_memory_slot *slot)
 {
-	kvm_mmu_slot_leaf_clear_dirty(kvm, slot);
-	kvm_mmu_slot_largepage_remove_write_access(kvm, slot);
+	kvm_mmu_write_protect_all_pages(kvm, true);
 }
 
 static void vmx_slot_disable_log_dirty(struct kvm *kvm,
 				       struct kvm_memory_slot *slot)
 {
-	kvm_mmu_slot_set_dirty(kvm, slot);
+	kvm_mmu_write_protect_all_pages(kvm, false);
 }
 
 static void vmx_flush_log_dirty(struct kvm *kvm)
-- 
1.8.3.1
