Received: from eggs.gnu.org ([209.51.188.92]:44654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1glTDU-0007yh-MC
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 01:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1glTDT-0000lD-67
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 01:37:52 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2048 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ann.zhuangyanying@huawei.com>)
	id 1glTDS-0000jY-SA
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 01:37:51 -0500
From: Zhuangyanying <ann.zhuangyanying@huawei.com>
Date: Mon, 21 Jan 2019 06:37:36 +0000
Message-ID: <EC9759BC1E3E98429B5DE9A03DF86D8B59E9BBD4@DGGEML523-MBX.china.huawei.com>
References: <1547733331-16140-1-git-send-email-ann.zhuangyanying@huawei.com>
	<1547733331-16140-5-git-send-email-ann.zhuangyanying@huawei.com>
	<20190117163208.GD22169@linux.intel.com>
In-Reply-To: <20190117163208.GD22169@linux.intel.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 4/4] KVM: MMU: fast cleanup D bit based on
 fast write protect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "xiaoguangrong@tencent.com" <xiaoguangrong@tencent.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Liujinsong (Paul)" <liu.jinsong@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>



> -----Original Message-----
> From: Sean Christopherson [mailto:sean.j.christopherson@intel.com]
> Sent: Friday, January 18, 2019 12:32 AM
> To: Zhuangyanying <ann.zhuangyanying@huawei.com>
> Cc: xiaoguangrong@tencent.com; pbonzini@redhat.com; Gonglei (Arei)
> <arei.gonglei@huawei.com>; qemu-devel@nongnu.org; kvm@vger.kernel.org;
> wangxin (U) <wangxinxin.wang@huawei.com>; Liujinsong (Paul)
> <liu.jinsong@huawei.com>
> Subject: Re: [PATCH 4/4] KVM: MMU: fast cleanup D bit based on fast write
> protect
>=20
> On Thu, Jan 17, 2019 at 01:55:31PM +0000, Zhuangyanying wrote:
> > From: Zhuang Yanying <ann.zhuangyanying@huawei.com>
> >
> > When live-migration with large-memory guests, vcpu may hang for a long
> > time while starting migration, such as 9s for 2T
> > (linux-5.0.0-rc2+qemu-3.1.0).
> > The reason is memory_global_dirty_log_start() taking too long, and the
> > vcpu is waiting for BQL. The page-by-page D bit clearup is the main
> > time consumption. I think that the idea of "KVM: MMU: fast write
> > protect" by xiaoguangrong, especially the function
> > kvm_mmu_write_protect_all_pages(),
> > is very helpful. After a little modifcation, on his patch, can solve
> > this problem, 9s to 0.5s.
> >
> > At the beginning of live migration, write protection is only applied
> > to the top-level SPTE. Then the write from vm trigger the EPT
> > violation, with for_each_shadow_entry write protection is performed at
> dirct_map.
> > Finally the Dirty bit of the target page(at level 1 page table) is
> > cleared, and the dirty page tracking is started. Of coure, the page
> > where GPA is located is marked dirty when mmu_set_spte.
> > A similar implementation on xen, just emt instead of write protection.
> >
> > Signed-off-by: Zhuang Yanying <ann.zhuangyanying@huawei.com>
> > ---
> >  arch/x86/kvm/mmu.c     | 8 +++++---
> >  arch/x86/kvm/vmx/vmx.c | 3 +--
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c index
> > 047b897..a18bcc0 100644
> > --- a/arch/x86/kvm/mmu.c
> > +++ b/arch/x86/kvm/mmu.c
> > @@ -3257,7 +3257,10 @@ static bool mmu_load_shadow_page(struct kvm
> *kvm, struct kvm_mmu_page *sp)
> >  			break;
> >
> >  		if (is_last_spte(spte, sp->role.level)) {
> > -			flush |=3D spte_write_protect(sptep, false);
> > +			if (sp->role.level =3D=3D PT_PAGE_TABLE_LEVEL)
> > +				flush |=3D spte_clear_dirty(sptep);
> > +			else
> > +				flush |=3D spte_write_protect(sptep, false);
> >  			continue;
> >  		}
> >
> > @@ -6114,7 +6117,6 @@ void kvm_mmu_write_protect_all_pages(struct
> kvm
> > *kvm, bool write_protect)  {
> >  	u64 wp_all_indicator, kvm_wp_all_gen;
> >
> > -	mutex_lock(&kvm->slots_lock);
> >  	wp_all_indicator =3D get_write_protect_all_indicator(kvm);
> >  	kvm_wp_all_gen =3D get_write_protect_all_gen(wp_all_indicator);
> >
> > @@ -6134,8 +6136,8 @@ void kvm_mmu_write_protect_all_pages(struct
> kvm *kvm, bool write_protect)
> >  	 */
> >  	if (write_protect)
> >  		kvm_reload_remote_mmus(kvm);
> > -	mutex_unlock(&kvm->slots_lock);
>=20
> Why is the lock removed?  And why was it added in the first place?
>=20
The original purpose of fast write protect is to implement lock-free get_di=
rty_log,
kvm_mmu_write_protect_all_pages is a stand-alone kvm API. See
https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg04370.html
A total of 7 patches, I only need the first 3 patches to achieve step-by-st=
ep
page table traversal. In order to maintain the integrity of the xiaoguangro=
ng
patch, I did not directly modify it on his patch.
> >  }
> > +EXPORT_SYMBOL_GPL(kvm_mmu_write_protect_all_pages);
> >
> >  static unsigned long
> >  mmu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c index
> > f6915f1..5236a07 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -7180,8 +7180,7 @@ static void vmx_sched_in(struct kvm_vcpu *vcpu,
> > int cpu)  static void vmx_slot_enable_log_dirty(struct kvm *kvm,
> >  				     struct kvm_memory_slot *slot)  {
> > -	kvm_mmu_slot_leaf_clear_dirty(kvm, slot);
> > -	kvm_mmu_slot_largepage_remove_write_access(kvm, slot);
> > +	kvm_mmu_write_protect_all_pages(kvm, true);
>=20
> What's the purpose of having @write_protect if
> kvm_mmu_write_protect_all_pages() is only ever called to enable
> protection?  If there's no known scenario where write protection is
> explicitly disabled then there's no need for WP_ALL_ENABLE_MASK, i.e. a
> non-zero generation would indicate write protection is enabled.  That'd
> simplify the code and clean up the atomic usage.
>=20
In the live migration, The large page split depends on the creation of mems=
lot->dirty_bitmap
in the function __kvm_set_memory_region().
The interface design between qemu and kvm to enable dirty log is one by one=
 in slot units.
In order to enable dirty page tracking of the entire vm, it is necessary to=
 call
kvm_mmu_write_protect_all_pages multiple times. The page table update reque=
st can
be merged for processing by the atomic usage. This method is not elegant, b=
ut it works.
Complete the creation of all solt's dirty_bitmap in an API, just call=20
kvm_mmu_write_protect_all_pages once, need more implementation changes, eve=
n qemu.

Best regards,
-Zhuang Yanying
> >  }
> >
> >  static void vmx_slot_disable_log_dirty(struct kvm *kvm,
> > --
> > 1.8.3.1
> >
> >
