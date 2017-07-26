Received: from eggs.gnu.org ([2001:4830:134:3::10]:42187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1daHYP-0005Eh-8x
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1daHYL-0001hK-8j
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:20:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1daHYL-0001h4-3J
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:20:21 -0400
Date: Wed, 26 Jul 2017 10:20:13 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170726102013.328a7419@gondolin>
In-Reply-To: <c059309f-3c96-ef41-e7f1-19b157f1e2c5@redhat.com>
References: <20170725153330.14966-1-cohuck@redhat.com>
	<20170725153330.14966-9-cohuck@redhat.com>
	<c059309f-3c96-ef41-e7f1-19b157f1e2c5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 8/9] s390x/kvm: msi route fixup for
 non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On Wed, 26 Jul 2017 09:09:06 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 25.07.2017 17:33, Cornelia Huck wrote:
> > If we don't provide pci, we cannot have a pci device for which we
> > have to translate to adapter routes: just return -ENODEV.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  target/s390x/kvm.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> > index dc3f940b95..fb3e21a3a4 100644
> > --- a/target/s390x/kvm.c
> > +++ b/target/s390x/kvm.c
> > @@ -2424,6 +2424,11 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
> >      uint32_t idx = data >> ZPCI_MSI_VEC_BITS;
> >      uint32_t vec = data & ZPCI_MSI_VEC_MASK;
> >  
> > +    if (!s390_has_feat(S390_FEAT_ZPCI)) {
> > +        DPRINTF("fixup_msi_route on non-pci machine?!\n");
> > +        return -ENODEV;
> > +    }
> > +
> >      pbdev = s390_pci_find_dev_by_idx(s390_get_phb(), idx);
> >      if (!pbdev) {
> >          DPRINTF("add_msi_route no dev\n");
> >   
> 
> Is this additional check really needed here? I'd rather expect
> s390_pci_find_dev_by_idx() to return NULL here already, so we should
> already be fine, shouldn't we?

Yes, the end result is the same, but (1) better safe than sorry and (2)
I can add a debug print here.

I had actually considered throwing an error here, as this function
really should not be called for !pci. Opinions?
