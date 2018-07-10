Received: from eggs.gnu.org ([2001:4830:134:3::10]:39262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1fcw3A-0003Da-H4
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1fcw37-00071U-Os
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:03:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57992
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1fcw37-00070u-FY
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:03:37 -0400
Date: Tue, 10 Jul 2018 18:03:30 +0100
From: Dave Martin <Dave.Martin@arm.com>
Message-ID: <20180710170330.GJ9486@e103592.cambridge.arm.com>
References: <1530270944-11351-16-git-send-email-suzuki.poulose@arm.com>
	<20180704155104.GN4828@arm.com>
	<12d1832a-1a13-7dd4-662b-addf58400789@arm.com>
	<fe9f5aa5-b283-07e0-5f0e-e97d96b780e7@arm.com>
	<9f1af26e-2913-2b0b-1352-63160096f78f@arm.com>
	<f3463d0a-c6a3-c34d-acb3-13c99fc61c5a@arm.com>
	<20180709112326.GD9486@e103592.cambridge.arm.com>
	<17f8d585-3489-ab6f-6ee1-4d8d337dcf9c@arm.com>
	<20180709133750.GE9486@e103592.cambridge.arm.com>
	<377420ce-97a8-4359-6224-273d91f37247@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <377420ce-97a8-4359-6224-273d91f37247@arm.com>
Subject: Re: [Qemu-devel] [PATCH v3 15/20] kvm: arm/arm64: Allow tuning the
 physical address size for VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, cdall@kernel.org, kvm@vger.kernel.org, catalin.marinas@arm.com, punit.agrawal@arm.com, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org

On Tue, Jul 10, 2018 at 05:38:39PM +0100, Suzuki K Poulose wrote:
> On 09/07/18 14:37, Dave Martin wrote:
> >On Mon, Jul 09, 2018 at 01:29:42PM +0100, Marc Zyngier wrote:
> >>On 09/07/18 12:23, Dave Martin wrote:

[...]

> >>>Wedging arguments into a few bits in the type argument feels awkward,
> >>>and may be regretted later if we run out of bits, or something can't be
> >>>represented in the chosen encoding.
> >>
> >>I think that's a pretty convincing argument for a "better" CREATE_VM,
> >>one that would have a clearly defined, structured (and potentially
> >>extensible) argument.
> >>
> >>I've quickly hacked the following:
> >>
> >>diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> >>index b6270a3b38e9..3e76214034c2 100644
> >>--- a/include/uapi/linux/kvm.h
> >>+++ b/include/uapi/linux/kvm.h
> >>@@ -735,6 +735,20 @@ struct kvm_ppc_resize_hpt {
> >>  	__u32 pad;
> >>  };
> >>
> >>+struct kvm_create_vm2 {
> >>+	__u64	version;	/* Or maybe not */
> >>+	union {
> >>+		struct {
> >>+#define KVM_ARM_SVE_CAPABLE	(1 << 0)
> >>+#define KVM_ARM_SELECT_IPA	{1 << 1)
> >>+			__u64	capabilities;
> >>+			__u16	sve_vlen;
> >>+			__u8	ipa_size;
> >>+		} arm64;
> >>+		__u64	dummy[15];
> >>+	};
> >>+};
> >>+
> >>  #define KVMIO 0xAE
> >>
> >>  /* machine type bits, to be used as argument to KVM_CREATE_VM */
> >>
> >>Other architectures could fill in their own bits if they need to.
> >>
> >>Thoughts?
> >
> >This kind of thing should work, but it may still get messy when we
> >add additional fields.
> 
> 
> Marc, Dave,
> 
> I like Dave's approach. Some comments below.
> 
> >
> >It we want this to work cross-arch, would it make sense to go
> >for a more generic approach, say
> >
> >struct kvm_create_vm_attr_any {
> >         __u32   type;
> >};
> >
> >#define KVM_CREATE_VM_ATTR_ARCH_CAPABILITIES 1
> >struct kvm_create_vm_attr_arch_capabilities {
> >         __u32   type;
> >         __u16   size; /* support future expansion of capabilities[] */
> >         __u16   reserved;
> >         __u64   capabilities[1];
> >};
> 
> We also need to advertise which attributes are supported by the host,
> so that the user can tune the available ones. That would make a bit mask
> like the above trickier, unless we return the supported values back
> in the argument ptr for the "probe" call. And this scheme in general
> can be useful for passing back a non-boolean result specific to the
> attribute, without having a per-attribute ioctl. (e.g, maximum limit
> for IPA).

Maybe, but this could quickly become bloated.  (My approach already
feels a bit bloated...)

I'm not sure that arbitrarily complex negotiation will really be
needed, but userspace might want to change its mind if setting a
particular propertiy fails.

An alternative might be to have a bunch of per-VM ioctls to configure
different things, like x86 has.  There's at least precedent for that.
For arm, we currently only have a few.  That allows for easy extension,
at the cost of adding ioctls.

There may be some ioctls we can reuse, like KVM_ENABLE_CAP for per-
vm capability flags.


[...]

> >union kvm_create_vm_attr {
> >         struct kvm_create_vm_attr_any;
> >         struct kvm_create_vm_attr_arch_capabilities;
> >         struct kvm_create_vm_attr_arm64_physaddr_size;
> >         /* ... */
> >};
> 
> nit: Could we simply do s/kvm_create_vm_attr/kvm_vm_attr/ everywhere ?
> While I agree that the kvm_create_vm_attr makes it implicit that the attributes
> are valid only "create" ioctl, the lack of an ioctl to set the VM attribute
> should be sufficient to indicate the same.

I just randomly came up with some names.  The precise naming scheme
isn't that important, so long as it unlikely to result in name
collisions and so long as it's reasonablu clear (or compiler-checkable,
or preferably both) which things can be used where.

I wouldn't have a problem with something a bit terser.

> 
> >
> >struct kvm_create_vm2 {
> >         __u32   version;        /* harmless, even if not useful */
> >         __u16   nr_attrs;       /* or could just terminate attrs with a
> >                                    NULL entry */
> >         union kvm_create_vm_attr __user *__user *attrs;
> >};
> >
> >
> >This is quite flexible, but obviously a bit heavy.
> >
> >However, if we're adding a new interface due to lack of extensibility,
> >it may be worth going for something that's freely extensible.
> 
> True. I could hack something up along the lines above and send it here.

Sure, but best to keep it fairly rough for now.

Cheers
---Dave
