Received: from eggs.gnu.org ([2001:4830:134:3::10]:53115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sahid.ferdjaoui@redhat.com>) id 1cxYpG-0001rv-JC
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sahid.ferdjaoui@redhat.com>) id 1cxYpD-0002Yz-Gq
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:53:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sahid.ferdjaoui@redhat.com>)
	id 1cxYpD-0002Xi-Ao
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:53:43 -0400
Date: Mon, 10 Apr 2017 14:53:39 +0200
From: Sahid Orentino Ferdjaoui <sferdjao@redhat.com>
Message-ID: <20170410125339.GA31761@redhat>
References: <4712D8F4B26E034E80552F30A67BE0B1A4E842@ORSMSX112.amr.corp.intel.com>
	<20170406115854.GA29142@redhat>
	<4712D8F4B26E034E80552F30A67BE0B1A51E90@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A51E90@ORSMSX112.amr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH]Enable kvmvapic only when host doesn't
 support VAPIC capability in KVM mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>
Cc: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>, 'Paolo Bonzini' <pbonzini@redhat.com>, 'Stefan Hajnoczi' <stefanha@gmail.com>

On Thu, Apr 06, 2017 at 06:18:33PM +0000, Xu, Anthony wrote:
> > > --- a/kvm-all.c
> > > +++ b/kvm-all.c
> > > @@ -2232,6 +2232,10 @@ int kvm_has_sync_mmu(void)
> > >      return kvm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
> > >  }
> > >
> > > +int kvm_has_vapic(void){
> > > +    return !kvm_check_extension(kvm_state, KVM_CAP_VAPIC);
> > > +}
> > > +
> > 
> > Is that function shouldn't return true if KVM is providing VAPIC
> > capability?
> > 
> 
> It should, but it doesn't. see below KVM kernel code segment,
> it returns false if KVM provides VAPIC.

I think we shouldn't read it like that. It seems that KVM is always
returning the VAPIC capability except when the CPU is providing a
special acceleration [0].

I would say you can't really refer yourself at this bit to enable or
not kvmapic in QEMU.

Does that make sense?

[0] https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?id=774ead3ad9bcbc05ef6aaebb9bdf8b4c3126923b

> Thanks for your comments,
> 
> Will resend the patch.
> 
> 
> Anthony
> 
> 
> 
> arch/x86/kvm/x86.c
> 
>         case KVM_CAP_VAPIC:
>                 r = !kvm_x86_ops->cpu_has_accelerated_tpr();
>                 break;
> 
