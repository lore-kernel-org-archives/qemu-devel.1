Received: from eggs.gnu.org ([2001:4830:134:3::10]:52564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTT1r-0005x3-TR
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTT1m-00025Q-Vs
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:10:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34827)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dTT1m-00025I-P3
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:10:34 -0400
Date: Fri, 7 Jul 2017 15:10:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170707151030.1352cecf@dhcp-192-215.str.redhat.com>
In-Reply-To: <8815f788-c1ba-d979-6c5d-2ab615b34d46@redhat.com>
References: <20170707122159.24714-1-cohuck@redhat.com>
	<20170707122159.24714-6-cohuck@redhat.com>
	<8815f788-c1ba-d979-6c5d-2ab615b34d46@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 5/7] s390x/pci: fence off instructions
 for non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On Fri, 7 Jul 2017 15:00:20 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 07.07.2017 14:21, Cornelia Huck wrote:
> > If a guest running on a non-pci build issues a pci instruction,
> > throw them an exception.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  target/s390x/kvm.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> > index a3d00196f4..c5c7c27a21 100644
> > --- a/target/s390x/kvm.c
> > +++ b/target/s390x/kvm.c
> > @@ -1160,6 +1160,9 @@ static int kvm_clp_service_call(S390CPU *cpu, struct kvm_run *run)
> >  {
> >      uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
> >  
> > +#ifndef CONFIG_PCI
> > +    return -1;
> > +#endif
> >      return clp_service_call(cpu, r2);
> >  }
> >  
> > @@ -1168,6 +1171,9 @@ static int kvm_pcilg_service_call(S390CPU *cpu, struct kvm_run *run)
> >      uint8_t r1 = (run->s390_sieic.ipb & 0x00f00000) >> 20;
> >      uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
> >  
> > +#ifndef CONFIG_PCI
> > +    return -1;
> > +#endif
> >      return pcilg_service_call(cpu, r1, r2);
> >  }  
> 
> pcilg_service_call() seems to be defined in s390-pci-inst.c ... which
> you later remove from the !CONFIG_PCI builds... so I wonder why this
> still compiles ... I guess GCC is smart enough to optimize it away.

Yes, as the second return is not reachable anymore.

> Anyway, to be on the safe side (and to be able to compile with -O0), you
> should maybe rather do this instead:
> 
> #ifndef CONFIG_PCI
>     return -1;
> #else
>     return pcilg_service_call(cpu, r1, r2);
> #endif
> 
> ?

I'll try Christian's suggestion to use the cpu model first. However,
we'll need some ifdeffery somewhere... maybe we should introduce a
zpci-stub.c for the referenced functions.
