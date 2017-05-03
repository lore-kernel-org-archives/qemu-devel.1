Received: from eggs.gnu.org ([2001:4830:134:3::10]:33018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d5ruN-0005Pm-Lw
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d5ruM-0006lI-Py
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:53:23 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d5ruM-0006kp-Kc
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:53:22 -0400
Received: by mail-pf0-x241.google.com with SMTP id v14so3779810pfd.3
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 03:53:22 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Wed,  3 May 2017 18:52:23 +0800
Message-Id: <20170503105224.19049-7-xiaoguangrong@tencent.com>
In-Reply-To: <20170503105224.19049-1-xiaoguangrong@tencent.com>
References: <20170503105224.19049-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 6/7] KVM: MMU: clarify fast_pf_fix_direct_spte
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

The writable spte can not be locklessly fixed and add a WARN_ON()
to trigger the warning if something out of our mind happens, that
is good for us to track if the log for writable spte is missed
on the fast path

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 arch/x86/kvm/mmu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index ad6ee46..f6a74e7 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3225,6 +3225,15 @@ fast_pf_fix_direct_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	WARN_ON(!sp->role.direct);
 
 	/*
+	 * the original spte can not be writable as only the spte which
+	 * fulfills is_access_track_spte() or
+	 * spte_can_locklessly_be_made_writable() can be locklessly fixed,
+	 * for the former, the W bit is always cleared, for the latter,
+	 * there is nothing to do if it is already writable.
+	 */
+	WARN_ON(is_writable_pte(old_spte));
+
+	/*
 	 * Theoretically we could also set dirty bit (and flush TLB) here in
 	 * order to eliminate unnecessary PML logging. See comments in
 	 * set_spte. But fast_page_fault is very unlikely to happen with PML
@@ -3239,7 +3248,7 @@ fast_pf_fix_direct_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	if (cmpxchg64(sptep, old_spte, new_spte) != old_spte)
 		return false;
 
-	if (is_writable_pte(new_spte) && !is_writable_pte(old_spte)) {
+	if (is_writable_pte(new_spte)) {
 		/*
 		 * The gfn of direct spte is stable since it is
 		 * calculated by sp->gfn.
-- 
2.9.3
