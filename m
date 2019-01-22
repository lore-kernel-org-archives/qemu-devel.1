Received: from eggs.gnu.org ([209.51.188.92]:39472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sean.j.christopherson@intel.com>) id 1gm0xY-0006Lf-BF
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sean.j.christopherson@intel.com>) id 1gm0xM-0000re-24
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:39:31 -0500
Received: from mga17.intel.com ([192.55.52.151]:36859)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sean.j.christopherson@intel.com>)
	id 1gm0xB-0000SO-Cx
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:39:23 -0500
Date: Tue, 22 Jan 2019 07:17:08 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
Message-ID: <20190122151708.GB28513@linux.intel.com>
References: <1547733331-16140-1-git-send-email-ann.zhuangyanying@huawei.com>
	<1547733331-16140-5-git-send-email-ann.zhuangyanying@huawei.com>
	<20190117163208.GD22169@linux.intel.com>
	<EC9759BC1E3E98429B5DE9A03DF86D8B59E9BBD4@DGGEML523-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EC9759BC1E3E98429B5DE9A03DF86D8B59E9BBD4@DGGEML523-MBX.china.huawei.com>
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
To: Zhuangyanying <ann.zhuangyanying@huawei.com>
Cc: "xiaoguangrong@tencent.com" <xiaoguangrong@tencent.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Liujinsong (Paul)" <liu.jinsong@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>

On Mon, Jan 21, 2019 at 06:37:36AM +0000, Zhuangyanying wrote:
> 
> > >  	u64 wp_all_indicator, kvm_wp_all_gen;
> > >
> > > -	mutex_lock(&kvm->slots_lock);
> > >  	wp_all_indicator = get_write_protect_all_indicator(kvm);
> > >  	kvm_wp_all_gen = get_write_protect_all_gen(wp_all_indicator);
> > >
> > > @@ -6134,8 +6136,8 @@ void kvm_mmu_write_protect_all_pages(struct
> > kvm *kvm, bool write_protect)
> > >  	 */
> > >  	if (write_protect)
> > >  		kvm_reload_remote_mmus(kvm);
> > > -	mutex_unlock(&kvm->slots_lock);
> > 
> > Why is the lock removed?  And why was it added in the first place?
> > 
> The original purpose of fast write protect is to implement lock-free get_dirty_log,
> kvm_mmu_write_protect_all_pages is a stand-alone kvm API. See
> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg04370.html
> A total of 7 patches, I only need the first 3 patches to achieve step-by-step
> page table traversal. In order to maintain the integrity of the xiaoguangrong
> patch, I did not directly modify it on his patch.

That's not a sufficient argument for adding locking and removing it one
patch later.

> > >  }
> > > +EXPORT_SYMBOL_GPL(kvm_mmu_write_protect_all_pages);
> > >
> > >  static unsigned long
> > >  mmu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c index
> > > f6915f1..5236a07 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -7180,8 +7180,7 @@ static void vmx_sched_in(struct kvm_vcpu *vcpu,
> > > int cpu)  static void vmx_slot_enable_log_dirty(struct kvm *kvm,
> > >  				     struct kvm_memory_slot *slot)  {
> > > -	kvm_mmu_slot_leaf_clear_dirty(kvm, slot);
> > > -	kvm_mmu_slot_largepage_remove_write_access(kvm, slot);
> > > +	kvm_mmu_write_protect_all_pages(kvm, true);
> > 
> > What's the purpose of having @write_protect if
> > kvm_mmu_write_protect_all_pages() is only ever called to enable
> > protection?  If there's no known scenario where write protection is
> > explicitly disabled then there's no need for WP_ALL_ENABLE_MASK, i.e. a
> > non-zero generation would indicate write protection is enabled.  That'd
> > simplify the code and clean up the atomic usage.
> > 
> In the live migration, The large page split depends on the creation of memslot->dirty_bitmap
> in the function __kvm_set_memory_region().
> The interface design between qemu and kvm to enable dirty log is one by one in slot units.
> In order to enable dirty page tracking of the entire vm, it is necessary to call
> kvm_mmu_write_protect_all_pages multiple times. The page table update request can
> be merged for processing by the atomic usage. This method is not elegant, but it works.
> Complete the creation of all solt's dirty_bitmap in an API, just call 
> kvm_mmu_write_protect_all_pages once, need more implementation changes, even qemu.

Calling kvm_mmu_write_protect_all_pages() multiple times is fine.  My
question was regarding the 'write_protect' parameter.  If all callers
always pass %true for 'write_protect' then why does the parameter exist?
And eliminating the parameter means you don't need an 'enable' flag
buried in the generation, which would simplify the implementation.
