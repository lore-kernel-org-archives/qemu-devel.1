Received: from eggs.gnu.org ([2001:4830:134:3::10]:47605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1WWf-0008Ew-G9
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 08:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1WWc-0004x6-64
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 08:19:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1WWb-0004wn-W3
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 08:19:26 -0400
Date: Thu, 29 Mar 2018 09:19:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180329121922.GU5046@localhost.localdomain>
References: <20180328153024.23039-1-rkagan@virtuozzo.com>
	<20180328153024.23039-3-rkagan@virtuozzo.com>
	<20180328185331.GN5046@localhost.localdomain>
	<20180329094741.GA20366@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329094741.GA20366@rkaganb.sw.ru>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2 2/2] i386/hyperv: error out if
 features requested but unsupported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>

On Thu, Mar 29, 2018 at 12:47:42PM +0300, Roman Kagan wrote:
> On Wed, Mar 28, 2018 at 03:53:31PM -0300, Eduardo Habkost wrote:
> > On Wed, Mar 28, 2018 at 06:30:24PM +0300, Roman Kagan wrote:
> > > In order to guarantee compatibility on migration, QEMU should have
> > > complete control over the features it announces to the guest via CPUID.
> > > 
> > > However, for a number of Hyper-V-related cpu properties, if the
> > > corresponding feature is not supported by the underlying KVM, the
> > > propery is silently ignored and the feature is not announced to the
> > > guest.
> > > 
> > > Refuse to start with an error instead.
> > > 
> > > Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> > 
> > Something I didn't consider before:
> > 
> > Will this block migration before it even starts, or will crash
> > the VM only after all migration data was sent to the destination?
> > 
> > I didn't test it, but kvm_arch_init_vcpu() seems to be too late
> > to block an invalid/unsupport configuration.
> 
> I just did a simple test, force-failing one of the checks and starting
> QEMU with -incoming defer.  It refused to start with the expected error
> message.  IOW in the migration case the destination will abort before
> the source have started to send any data.
> 
> > Maybe we can simply call hyperv_handle_properties() earlier,
> > inside x86_cpu_realizefn()?
> 
> Now it's
> 
>   ...
>   x86_cpu_realizefn
>     qemu_init_vcpu
>       qemu_kvm_start_vcpu
>         qemu_thread_create(qemu_kvm_cpu_thread_fn)
> 	  [in vcpu thread]
> 	  qemu_kvm_cpu_thread_fn

Oh, this is the part that I missed.  I thought the vCPU thread
wouldn't start until migration was finished.

This means the patch is OK as-is.  Sorry for the confusion.

> 	    kvm_init_vcpu
> 	      kvm_arch_init_vcpu
> 	        hyperv_handle_properties
> 		  [error return]
> 		[error return]
> 	      [error return]
> 	    exit(1)
> 
> > (I know it's very late for this kind of intrusive change in
> > v2.12, but I still think it's a good idea to fix this as soon as
> > possible.)
> 
> I agree that the current hyperv flag handling begs for cleanup but I
> think this can wait for post-2.12.
> 
> > > ---
> > > v1 -> v2:
> > >  - indicate what flag requested the feature that can't be enabled in the
> > >    error message
> > >  - fix a typo in the error message for VP_RUNTIME
> 
> I just noticed that I missed hv-time being silently cleared, too (just
> in a slightly different pattern), so I'll have to respin.
> 
> Thanks,
> Roman.

-- 
Eduardo
