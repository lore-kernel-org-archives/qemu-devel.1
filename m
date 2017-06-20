Received: from eggs.gnu.org ([2001:4830:134:3::10]:53020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dNFGV-0000Ff-Ph
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 05:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dNFGU-0007u9-RH
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 05:16:03 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dNFGU-0007tk-Ld
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 05:16:02 -0400
Received: by mail-pg0-x241.google.com with SMTP id u62so14466743pgb.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 02:16:02 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 20 Jun 2017 17:15:26 +0800
Message-Id: <20170620091526.4287-8-xiaoguangrong@tencent.com>
In-Reply-To: <20170620091526.4287-1-xiaoguangrong@tencent.com>
References: <20170620091526.4287-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 7/7] KVM: MMU: stop using
 mmu_spte_get_lockless under mmu-lock
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

mmu_spte_age() is under the protection of mmu-lock, no reason to use
mmu_spte_get_lockless()

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 arch/x86/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 7711953..dc00c32 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -852,7 +852,7 @@ static u64 restore_acc_track_spte(u64 spte)
 /* Returns the Accessed status of the PTE and resets it at the same time. */
 static bool mmu_spte_age(u64 *sptep)
 {
-	u64 spte = mmu_spte_get_lockless(sptep);
+	u64 spte = *sptep;
 
 	if (!is_accessed_spte(spte))
 		return false;
-- 
2.9.4
