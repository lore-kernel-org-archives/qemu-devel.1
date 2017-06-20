Received: from eggs.gnu.org ([2001:4830:134:3::10]:52999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dNFGU-0000Fd-8j
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 05:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dNFGS-0007t9-4D
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 05:16:02 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dNFGR-0007se-UH
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 05:16:00 -0400
Received: by mail-pf0-x241.google.com with SMTP id y7so21600713pfd.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 02:15:59 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 20 Jun 2017 17:15:25 +0800
Message-Id: <20170620091526.4287-7-xiaoguangrong@tencent.com>
In-Reply-To: <20170620091526.4287-1-xiaoguangrong@tencent.com>
References: <20170620091526.4287-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 6/7] KVM: MMU: clarify
 fast_pf_fix_direct_spte
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
index c011ab0..7711953 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3240,6 +3240,15 @@ fast_pf_fix_direct_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
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
@@ -3254,7 +3263,7 @@ fast_pf_fix_direct_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	if (cmpxchg64(sptep, old_spte, new_spte) != old_spte)
 		return false;
 
-	if (is_writable_pte(new_spte) && !is_writable_pte(old_spte)) {
+	if (is_writable_pte(new_spte)) {
 		/*
 		 * The gfn of direct spte is stable since it is
 		 * calculated by sp->gfn.
-- 
2.9.4
