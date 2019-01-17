Received: from eggs.gnu.org ([209.51.188.92]:42406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1gk8Dv-0007Q6-HG
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:00:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1gk8Dt-0002Pc-4n
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:00:46 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35472 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ann.zhuangyanying@huawei.com>)
	id 1gk8Dr-0001VR-1z
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:00:43 -0500
From: Zhuangyanying <ann.zhuangyanying@huawei.com>
Date: Thu, 17 Jan 2019 13:55:27 +0000
Message-ID: <1547733331-16140-1-git-send-email-ann.zhuangyanying@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] KVM: MMU: fast cleanup D bit based on fast
 write protect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoguangrong@tencent.com, pbonzini@redhat.com, arei.gonglei@huawei.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, wangxinxin.wang@huawei.com, liu.jinsong@huawei.com, Zhuang Yanying <ann.zhuangyanying@huawei.com>

From: Zhuang Yanying <ann.zhuangyanying@huawei.com>

Recently I tested live-migration with large-memory guests, find vcpu may =
hang for a long time while starting migration, such as 9s for 2048G(linux=
-5.0.0-rc2+qemu-3.1.0).
The reason is memory_global_dirty_log_start() taking too long, and the vc=
pu is waiting for BQL. The page-by-page D bit clearup is the main time co=
nsumption.
I think that the idea of "KVM: MMU: fast write protect" by xiaoguangrong,=
 especially the function kvm_mmu_write_protect_all_pages(), is very helpf=
ul.
After a little modifcation, on his patch, can solve this problem, 9s to 0=
.5s.

At the begining of live migration, write protection is only applied to th=
e top-level SPTE. Then the write from vm trigger the EPT violation, with =
for_each_shadow_entry write protection is performed at dirct_map.
Finally the Dirty bit of the target page(at level 1 page table) is cleare=
d, and the dirty page tracking is started. Of coure, the page where GPA i=
s located is marked dirty when mmu_set_spte.
A similar implementation on xen, just emt instead of write protection.

What do you think about this solution?

Xiao Guangrong (3):
  KVM: MMU: correct the behavior of mmu_spte_update_no_track
  KVM: MMU: introduce possible_writable_spte_bitmap
  KVM: MMU: introduce kvm_mmu_write_protect_all_pages

Zhuang Yanying (1):
  KVM: MMU: fast cleanup D bit based on fast write protect

 arch/x86/include/asm/kvm_host.h |  25 +++-
 arch/x86/kvm/mmu.c              | 259 ++++++++++++++++++++++++++++++++++=
++++--
 arch/x86/kvm/mmu.h              |   1 +
 arch/x86/kvm/paging_tmpl.h      |  13 +-
 arch/x86/kvm/vmx/vmx.c          |   3 +-
 5 files changed, 286 insertions(+), 15 deletions(-)

--=20
1.8.3.1
