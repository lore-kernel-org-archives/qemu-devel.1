Received: from eggs.gnu.org ([2001:4830:134:3::10]:59425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christoffer.dall@arm.com>) id 1gM8BE-0007rB-ND
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christoffer.dall@arm.com>) id 1gM8BA-0001Gz-4J
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:06:48 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39532
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christoffer.dall@arm.com>) id 1gM8B9-0001EY-Lx
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:06:43 -0500
Date: Mon, 12 Nov 2018 10:06:35 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
Message-ID: <20181112090635.GA11669@C02W217FHV2R.local>
References: <1540290099-146109-1-git-send-email-mjaggi@caviumnetworks.com>
	<4bbb4e76-b714-eafe-f95b-aca1a258e9fe@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bbb4e76-b714-eafe-f95b-aca1a258e9fe@caviumnetworks.com>
Subject: Re: [Qemu-devel] [RFC] [PATCH] kvm: arm: Introduce error code
 KVM_EINVARIANT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manish Jaggi <mjaggi@caviumnetworks.com>
Cc: "Jaggi, Manish" <Manish.Jaggi@cavium.com>, "quintela@redhat.com" <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, "Nowicki, Tomasz" <Tomasz.Nowicki@cavium.com>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>

Hi Manish,

On Sat, Nov 10, 2018 at 10:18:47PM +0000, Manish Jaggi wrote:
> 
> CCing a larger audience.
> Please review.
> 
> On 10/23/2018 03:51 PM, Jaggi, Manish wrote:
> > From: Manish Jaggi <manish.jaggi@cavium.com>
> >
> > This patch introduces an error code KVM_EINVARIANT which is returned
> > by KVM when userland tries to set an invariant register.
> >
> > The need for this error code is in VM Migration for arm64.
> > ARM64 systems use mainly -machine virt -cpu host as parameter to qemu.
> > Migration requires both Source and destination machines to have same
> > physical cpu. There are cases where the overall architecture of CPU is
> > same but the next version of the chip with some bug fixes which have no
> > effect on qemu operation. In such cases invariant registers like MIDR
> > have a different value.
> > Currently Migration fails in such cases.
> >
> > Rather than sending a EINVAL, a specifc error code will help
> > userland program the guest invariant register by querying the migrated
> > host machines invariant registers.
> >
> > Qemu will have a parameter -hostinvariant along with checking of this
> > error code. So it can be safely assumed that the feature is opt-in
> >
> > Corresponding Qemu patchset can be found at :
> > https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg05048.html
> >
> >
> > Signed-off-by: Manish Jaggi <manish.jaggi@cavium.com>
> > ---
> >   arch/arm64/kvm/sys_regs.c     | 9 ++++-----
> >   include/uapi/linux/kvm_para.h | 1 +
> >   2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 22fbbdb..78ffc02 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -1111,7 +1111,7 @@ static int __set_id_reg(const struct sys_reg_desc *rd, void __user *uaddr,
> >   
> >   	/* This is what we mean by invariant: you can't change it. */
> >   	if (val != read_id_reg(rd, raz))
> > -		return -EINVAL;
> > +		return -KVM_EINVARIANT;
> >   
> >   	return 0;
> >   }
> > @@ -2254,9 +2254,8 @@ static int set_invariant_sys_reg(u64 id, void __user *uaddr)
> >   		return err;
> >   
> >   	/* This is what we mean by invariant: you can't change it. */
> > -	if (r->val != val)
> > -		return -EINVAL;
> > -
> > +	if (r->val != val)	
> > +		return -KVM_EINVARIANT;
> >   	return 0;
> >   }
> >   
> > @@ -2335,7 +2334,7 @@ static int demux_c15_set(u64 id, void __user *uaddr)
> >   
> >   		/* This is also invariant: you can't change it. */
> >   		if (newval != get_ccsidr(val))
> > -			return -EINVAL;
> > +			return -KVM_EINVARIANT;
> >   		return 0;
> >   	default:
> >   		return -ENOENT;
> > diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
> > index 6c0ce49..4358669 100644
> > --- a/include/uapi/linux/kvm_para.h
> > +++ b/include/uapi/linux/kvm_para.h
> > @@ -17,6 +17,7 @@
> >   #define KVM_E2BIG		E2BIG
> >   #define KVM_EPERM		EPERM
> >   #define KVM_EOPNOTSUPP		95
> > +#define KVM_EINVARIANT          96
> >   
> >   #define KVM_HC_VAPIC_POLL_IRQ		1
> >   #define KVM_HC_MMU_OP			2
> 

Eh, unless I'm severely missing something, I think you're confusing how
these error codes are used.

The error codes in include/uapi/linux/kvm_para.h are for hypercalls from
guests, not return values to userspace.  For the latter, we don't
have a habit of inventing new constants for something subsystem
specific, but instead we use the existing error codes which can be
understood by userspace software.

What's more, changing an error code is an ABI change and not something
you can just do at will.  If we are overloading EINVAL with the
KVM_SET_ONE_REG syscall (are we?), then you need to find some way to
communicate the additional information you need to userspace without
interfering with legacy userspace software's interaction with the
kernel.


Thanks,

    Christoffer
