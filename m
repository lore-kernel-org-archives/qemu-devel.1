Received: from eggs.gnu.org ([209.51.188.92]:48659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1gmcqy-00039r-Sb
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1gmcqy-0003E5-0U
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:07:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2236 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ann.zhuangyanying@huawei.com>)
	id 1gmcqx-00030B-BT
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:07:23 -0500
From: Zhuangyanying <ann.zhuangyanying@huawei.com>
Date: Thu, 24 Jan 2019 11:02:23 +0000
Message-ID: <1548327746-20484-1-git-send-email-ann.zhuangyanying@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] KVM: MMU: fast cleanup D bit based on
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com, Zhuang yanying <ann.zhuangyanying@huawei.com>

From: Zhuang yanying <ann.zhuangyanying@huawei.com>

When live-migration with large-memory guests, vcpu may hang for a long
time while starting migration, such as 9s for 2T
(linux-5.0.0-rc2+qemu-3.1.0).
The reason is memory_global_dirty_log_start() taking too long, and the
vcpu is waiting for BQL. The page-by-page D bit clearup is the main time
consumption. I think that the idea of "KVM: MMU: fast write protect" by
xiaoguangrong, especially the function kvm_mmu_write_protect_all_pages(),
is very helpful. After a little modifcation, on his patch, can solve
this problem, 9s to 0.5s.

At the beginning of live migration, write protection is only applied to t=
he
top-level SPTE. Then the write from vm trigger the EPT violation, with
for_each_shadow_entry write protection is performed at dirct_map.
Finally the Dirty bit of the target page(at level 1 page table) is cleare=
d,
and the dirty page tracking is started. The page where GPA is located is
marked dirty when mmu_set_spte.
A similar implementation on xen, just emt instead of write protection.

Xiao Guangrong (2):
  KVM: MMU: introduce possible_writable_spte_bitmap
  KVM: MMU: introduce kvm_mmu_write_protect_all_pages

Zhuang Yanying (1):
  KVM: MMU: fast cleanup D bit based on fast write protect

 arch/x86/include/asm/kvm_host.h |  24 ++++-
 arch/x86/kvm/mmu.c              | 229 ++++++++++++++++++++++++++++++++++=
++++--
 arch/x86/kvm/mmu.h              |   1 +
 arch/x86/kvm/paging_tmpl.h      |  13 ++-
 arch/x86/kvm/vmx/vmx.c          |   5 +-
 5 files changed, 257 insertions(+), 15 deletions(-)

--
v1 -> v2:

  - drop "KVM: MMU: correct the behavior of mmu_spte_update_no_track"
  - mmu_write_protect_all_indicator is no longer an atomic variable,
    protected by mmu_lock
  - Implement kvm_mmu_slot_set_dirty with kvm_mmu_write_protect_all_pages
  - some modification on the commit messages
--
1.8.3.1
