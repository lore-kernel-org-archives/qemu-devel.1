Received: from eggs.gnu.org ([2001:4830:134:3::10]:53131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVdxx-0003r0-61
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVdxt-00026C-OB
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:15:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVdxt-00024o-F1
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:15:33 -0400
Date: Thu, 13 Jul 2017 15:15:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170713151528.20b2c7fd@gondolin>
In-Reply-To: <7c76ac27-aca5-e5af-5e78-45fe9865c6c8@de.ibm.com>
References: <1499942429-55449-1-git-send-email-borntraeger@de.ibm.com>
	<1499942429-55449-3-git-send-email-borntraeger@de.ibm.com>
	<20170713141158.32e74897@gondolin>
	<0d4fb206-a40d-7cac-02fe-d6b96958f04f@de.ibm.com>
	<20170713150629.0e982c73@gondolin>
	<7c76ac27-aca5-e5af-5e78-45fe9865c6c8@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/s390-next 2/3] s390x/cpumodel: add zpci,
 aen and ais facilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

On Thu, 13 Jul 2017 15:11:15 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 07/13/2017 03:06 PM, Cornelia Huck wrote:
> > On Thu, 13 Jul 2017 14:29:55 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> On 07/13/2017 02:11 PM, Cornelia Huck wrote:
> >> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c  
> >>>> index 78ebe83..1901153 100644
> >>>> --- a/target/s390x/kvm.c
> >>>> +++ b/target/s390x/kvm.c
> >>>> @@ -302,6 +302,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >>>>          }
> >>>>      }
> >>>>  
> >>>> +    /* Try to enable AIS facility */
> >>>> +    kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);    
> >>>
> >>> What happens if you fail to enable it? You probably don't want to allow
> >>> the feature bit, then?    
> >>
> >> Then this bit is off. This call will enable it in the kernel, if that fails
> >> the kernel will return this bit as disabled.  
> > 
> > Looked at the kernel code again. I thought there was more to it, but I
> > misremembered. No further complaints here.
> >   
> >>>     
> >>>> +
> >>>>      qemu_mutex_init(&qemu_sigp_mutex);
> >>>>  
> >>>>      return 0;    
> >>>
> >>> Let's summarize to make sure that I'm not confused:
> >>>
> >>> - Starting with zEC12 GA1, we provide zpci, aen, ais in the full model    
> >> yes
> >>  
> >>> - Starting with zEC12 GA1, we provide zpci and aen in the default model    
> >> yes. ais has to be enabled manually for z12 and z13.
> >> The alternative is to have ais as part of the default model. This has the big
> >> disadvantage that -cpu zEC12 and -cpu z13 will stop working for all available
> >> distro kernels. I believe that a working -cpu z13 is more important than the
> >> need to manually enable ais.  
> > 
> > Agreed.
> >   
> >> For the future
> >>  - We can make ais part of the default model for a future system when that happens since
> >>    the features for a new system will require a new host kernel anyway  
> > 
> > Sounds fine.
> >   
> >>  - We can also make ais part of the default model for a future machine type (e.g. 2.13)
> >>    when we believe that the world has moved on to a newer kernel  
> > 
> > I'd rather avoid relying on that.
> >   
> >>
> >>  
> >>> - In the host model, we add zpci and aen; they might be switched off
> >>>   after applying the found model    
> >>
> >> We also get ais from the kernel, so the host model will have zpci,ais and
> >> aen
> >>  
> >>> - Compat for 2.9 and earlier switches off zpci, aen, ais    
> >>
> >> yes 
> >>  
> >>> - We unconditionally enable the kvm part of ais    
> >>
> >> We tell the KVM code in the kernel to enable the facility bit (before the cpu
> >> model might take it way) and if QEMU really uses ais, that the kernel does
> >> the right thing then  
> > 
> > Yeah, that's fine, see above.
> >   
> >>>
> >>> I'm still not sure what's supposed to happen with new qemu + old kernel
> >>> (no ais) + full zEC12 GA1 or later model.    
> >>
> >> We enable aen and zpci, but disable ais for that guest. In theory a guest
> >> can drive PCI devices without AIS. This is a valid configuration since zpci
> >> does not require ais.   
> > 
> > Yes, also fine. Looking at the kernel code cleared things up :)
> >   
> >> The fact that Linux requires ais to use PCI is unfortunate but that could 
> >> be "fixed" Linux if necessary.  
> > 
> > I'm not sure there's a need for this. Once a change like this has
> > landed in distro kernels, the same distros will also have the ais
> > changes in their hypervisor kernels.
> > 
> > Thanks for spelling things out again, this stuff always gives me a
> > headache.  
> 
> Assuming that I will keep the return because I like Halils explanation of
> "I'm in favor of 3 (keeping) as the resulting code is cleaner:
> it does not make any sense to 'continue realizing', even if 
> 'continue realizing' and set a correct ais_supported just
> to fail later does not hurt.
> "
> 
> Is that an Acked-by or Reviewed-by ?
> 

_This_ is an R-b ;)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
