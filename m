Received: from eggs.gnu.org ([208.118.235.92]:56815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fsj9c-0000fJ-T7
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 02:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fsj9Z-0005nt-Lw
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 02:31:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:15473)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fsj9Z-0004Cx-BY
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 02:31:33 -0400
Message-ID: <1535005708.4104.34.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Thu, 23 Aug 2018 14:28:28 +0800
In-Reply-To: <20180818150548.GN15372@localhost.localdomain>
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-3-git-send-email-robert.hu@linux.intel.com>
	<20180817131810.GA15372@localhost.localdomain>
	<1534577221.4104.20.camel@linux.intel.com>
	<20180818150548.GN15372@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] kvm: Add support to
 KVM_GET_MSR_FEATURE_INDEX_LIST and KVM_GET_MSRS system ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: robert.hu@intel.com, robert.hu@linux.intel.com, pbonzini@redhat.com, rth@twiddle.net, thomas.lendacky@amd.com, qemu-devel@nongnu.org, jingqi.liu@intel.com

On Sat, 2018-08-18 at 12:05 -0300, Eduardo Habkost wrote:

> > > >  
> > > >  int kvm_has_pit_state2(void)
> > > >  {
> > > > @@ -420,6 +421,41 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
> > > >      return ret;
> > > >  }
> > > >  
> > > > +uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
> > > > +{
> > > > +    struct {
> > > > +        struct kvm_msrs info;
> > > > +        struct kvm_msr_entry entries[1];
> > > > +    } msr_data;
> > > > +    uint32_t ret;
> > > > +
> > > > +    /*Check if the requested feature MSR is supported*/
> > > > +    int i;
> > > > +    for (i = 0; i < kvm_feature_msrs->nmsrs; i++) {
> > > > +        if (index == kvm_feature_msrs->indices[i]) {
> > > > +            break;
> > > > +        }
> > > > +    }
> > > 
> > > We are duplicating the logic that's already inside KVM (checking
> > > the list of supported MSRs and returning an error).  Can't we
> > > make this simpler and just remove this check?  If the MSR is not
> > > supported, KVM_GET_MSRS would just return 0.
> > 
> > Yes, seems dup. but if we remove this hunk, the
> > kvm_get_supported_feature_msrs() is unnecessary at all.
> 
> So maybe kvm_get_supported_feature_msrs() really is unnecessary?

I'll keep it, for 1) check KVM_CAP_GET_MSR_FEATURES capabilities; 2) get
kvm_feature_msrs, so later kvm_arch_get_supported_msr_feature() use it
to check if MSR features are supported.
> 
> We seem to have two alternatives:
> * calling KVM_GET_MSRS for all MSRs only once, at
>   kvm_get_supported_feature_msrs() (as I had suggested
>   previously);
> * calling KVM_GET_MSRS for one MSR unconditionally here, but
>   _not_ treating 0 as a fatal error.
> 
> I prefer the former, but I would be OK with both alternatives.
> Note that we need to check for KVM capabilities in both cases.
> 
> 
I'll choose the latter :).
> > > 
> > > > +    if (i >= kvm_feature_msrs->nmsrs) {
> > > > +        fprintf(stderr, "Requested MSR (index= %d) is not supported.\n", index);
> > > 
> > > This error message is meaningless for QEMU users.  Do we really
> > > need to print it?
> > > 
> > > > +        return 0;
> > > 
> > > Returning 0 for MSRs that are not supported is probably OK, but
> > > we need to see this function being used, to be sure (I didn't
> > > look at all the patches in this series yet).
> > > 
> > > > +    }
> > > > +
> > > > +    msr_data.info.nmsrs = 1;
> > > > +    msr_data.entries[0].index = index;
> > > > +
> > > > +    ret = kvm_ioctl(s, KVM_GET_MSRS, &msr_data);
> > > > +
> > > > +    if (ret != 1) {
> > > > +        fprintf(stderr, "KVM get MSR (index=0x%x) feature failed, %s\n",
> > > > +            index, strerror(-ret));
> > > > +        exit(1);
> > > 
> > > I'm not a fan of APIs that write to stdout/stderr or exit(),
> > > unless they are clearly just initialization functions that should
> > > never fail in normal circumstances.
> > > 
> > > But if you call KVM_GET_MSRS for all MSRs at
> > > kvm_get_supported_feature_msrs() below, this function would never
> > > need to report an error.
> > > 
> > > We are already going through the trouble of allocating
> > > kvm_feature_msrs in kvm_get_supported_feature_msrs() anyway.
> > 
> > I had looked into KVM KVM_GET_MSRS handling, though less likely, still
> > have changes copy_from/to_user() fail. Therefore I added the check and
> > warning here, in that seldom case happens.
> > 
> > exit() or not, I'm also not sure. Seems not necessary, while my usual
> > programming philosophy is never let wrong goes further. For in the case
> > of ioctl(KVM_GET_MSRS) returns failure, something goes wrong underlying,
> > I would prefer to let user know this, rather than let it pass and goes
> > further.
> 
> We probably have no option other than exiting if KVM_GET_MSRS
> returns an unexpected error.  It's just that I find the code
> harder to review, because we need to be sure this won't terminate
> QEMU under normal circumstances.
> 
> But if you demonstrate that all errors here are truly fatal and
> unexpected, calling exit() may be OK.  (See the
> KVM_CAP_GET_MSR_FEATURES comment below for one example where
> exiting is not going to be OK.)
> 
> Proper error reporting using Error** would be even better than
> exiting, but considering that none of the functions at i386/cpu.c
> return errors using Error**, I won't force you to do that.
> 
Thanks.
> 
> > > 
> [...]
> > > > +        struct kvm_msr_list msr_list;
> > > > +
> > > > +        kvm_supported_feature_msrs++;
> > > > +
> > > > +        msr_list.nmsrs = 0;
> > > > +        ret = kvm_ioctl(s, KVM_GET_MSR_FEATURE_INDEX_LIST, &msr_list);
> > > > +        if (ret < 0 && ret != -E2BIG) {
> > > > +            return ret;
> > > 
> > > What if the host KVM version doesn't support
> > > KVM_GET_MSR_FEATURE_INDEX_LIST?
> > 
> > Going to add kvm_check_extension(s, KVM_CAP_GET_MSR_FEATURES) before
> > this ioctl. if not support, return -1. (Then the kvm_init will fail and
> > exit.)
> 
> We don't want QEMU to refuse to run if the kernel doesn't have
> KVM_CAP_GET_MSR_FEATURES.  We can treat missing capability as
> equivalent to returning an empty list of MSRs.
Yes. I'll let caller (kvm_arch_init) ignore the return value but a
simple warning.
> 
