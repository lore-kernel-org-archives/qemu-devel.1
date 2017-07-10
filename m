Received: from eggs.gnu.org ([2001:4830:134:3::10]:40622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUWUY-0005KZ-GT
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUWUV-0000iS-Cy
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:04:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dUWUV-0000hm-6a
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:04:35 -0400
Date: Mon, 10 Jul 2017 13:04:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170710130429.2ba605a4@dhcp-192-215.str.redhat.com>
In-Reply-To: <20170707150452.1f12890b@dhcp-192-215.str.redhat.com>
References: <20170707122159.24714-1-cohuck@redhat.com>
	<20170707122159.24714-6-cohuck@redhat.com>
	<7e4e8d2d-66f6-8884-96a1-83f285171c13@de.ibm.com>
	<20170707150452.1f12890b@dhcp-192-215.str.redhat.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On Fri, 7 Jul 2017 15:04:52 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 7 Jul 2017 14:55:23 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > On 07/07/2017 02:21 PM, Cornelia Huck wrote:  
> > > If a guest running on a non-pci build issues a pci instruction,
> > > throw them an exception.
> > > 
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > ---
> > >  target/s390x/kvm.c | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > > 
> > > diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> > > index a3d00196f4..c5c7c27a21 100644
> > > --- a/target/s390x/kvm.c
> > > +++ b/target/s390x/kvm.c
> > > @@ -1160,6 +1160,9 @@ static int kvm_clp_service_call(S390CPU *cpu, struct kvm_run *run)
> > >  {
> > >      uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
> > > 
> > > +#ifndef CONFIG_PCI
> > > +    return -1;
> > > +#endif    
> > 
> > Instead of this ifdefing, can you use the cpu model to decide if the instruction
> > should be available? We need to do this anyway for proper handling.
> > 
> > You can then fence off the PCI bits in the CPU model for
> > CONFIG_PCI == off.  
> 
> Sounds like a good idea, I'll give it a try.
> 
> We'll probably also want to fence off the sclp facility bit via that
> mechanism.

Slight problem here... we don't have the relevant facilities defined
yet, and they are not in the POP (other than "Assigned to IBM internal
use").

While I'm pretty sure that the magic number is 69 (judging from the
Linux code), I think they should be introduced in a patch by someone
who has access to the documentation including the proper names.
