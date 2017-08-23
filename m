Received: from eggs.gnu.org ([2001:4830:134:3::10]:33560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkXmA-0000P2-Vm
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkXm7-0002aJ-RZ
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:41:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dkXm7-0002a5-Kb
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:40:59 -0400
Date: Wed, 23 Aug 2017 17:40:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170823174051.2b53b4e4.cohuck@redhat.com>
In-Reply-To: <efdc5e12-399e-614e-2a65-12989506039a@linux.vnet.ibm.com>
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-9-cohuck@redhat.com>
	<efdc5e12-399e-614e-2a65-12989506039a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 08/10] s390x/pci: fence off instructions
 for non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, zyimin@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, borntraeger@de.ibm.com

On Wed, 23 Aug 2017 16:10:55 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 08/21/2017 11:16 AM, Cornelia Huck wrote:
> > If a guest running on a machine without zpci issues a pci instruction,
> > throw them an exception.
> > 
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  target/s390x/kvm.c | 54 +++++++++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 41 insertions(+), 13 deletions(-)
> > 
> > diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> > index bc62bba5b7..9de165d8b1 100644
> > --- a/target/s390x/kvm.c
> > +++ b/target/s390x/kvm.c
> > @@ -1191,7 +1191,11 @@ static int kvm_clp_service_call(S390CPU *cpu, struct kvm_run *run)
> >  {
> >      uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
> > 
> > -    return clp_service_call(cpu, r2);
> > +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> > +        return clp_service_call(cpu, r2);
> > +    } else {
> > +        return -1;
> > +    }  
> 
> According to the AR the clp instruction ain't zPCI
> only. OTOH if I read the AR correctly it might be
> the only relevant one at the moment. To be more
> precise, the CLP instruction is installed if one or
> more of certain tree conditions are met. One of the
> conditions is zPCI facility installed, and the other
> two I don't really understand based on what I've
> looked into.

Thx for the info. This sounds like it's ok to leave the check as-is.

> 
> >  }

(...)

> The rest is directly tied to the zPCI facility.
> 
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>

Thanks!
