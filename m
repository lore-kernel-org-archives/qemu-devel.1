Received: from eggs.gnu.org ([2001:4830:134:3::10]:33045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d5ruQ-0005Sk-7w
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d5ruP-0006mJ-Ij
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:53:26 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d5ruP-0006m3-CR
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:53:25 -0400
Received: by mail-pg0-x242.google.com with SMTP id t7so27786569pgt.1
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 03:53:25 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Wed,  3 May 2017 18:52:24 +0800
Message-Id: <20170503105224.19049-8-xiaoguangrong@tencent.com>
In-Reply-To: <20170503105224.19049-1-xiaoguangrong@tencent.com>
References: <20170503105224.19049-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 7/7] KVM: MMU: stop using mmu_spte_get_lockless
 under mmu-lock
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
index f6a74e7..a8b91ee 100644
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
2.9.3
