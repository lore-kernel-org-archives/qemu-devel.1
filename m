Received: from eggs.gnu.org ([2001:4830:134:3::10]:52910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1djlal-0000mI-PT
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1djlai-0007im-EK
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:14:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1djlai-0007ia-9A
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:14:00 -0400
Date: Mon, 21 Aug 2017 14:13:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170821141353.32a1242c.cohuck@redhat.com>
In-Reply-To: <feebff17-e4b8-2e00-9775-126055172564@linux.vnet.ibm.com>
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-10-cohuck@redhat.com>
	<feebff17-e4b8-2e00-9775-126055172564@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 09/10] s390x/kvm: msi route fixup for
 non-pci
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

On Mon, 21 Aug 2017 14:00:15 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 08/21/2017 11:16 AM, Cornelia Huck wrote:
> > If we don't provide pci, we cannot have a pci device for which we
> > have to translate to adapter routes: just return -ENODEV.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  target/s390x/kvm.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> > index 9de165d8b1..d8db1cbf6e 100644
> > --- a/target/s390x/kvm.c
> > +++ b/target/s390x/kvm.c
> > @@ -2424,6 +2424,12 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
> >      uint32_t idx = data >> ZPCI_MSI_VEC_BITS;
> >      uint32_t vec = data & ZPCI_MSI_VEC_MASK;
> > 
> > +    if (!s390_has_feat(S390_FEAT_ZPCI)) {
> > +        /* How can we get here without pci enabled? */
> > +        g_assert(false);  
> 
> You don't tell us about the g_assert in the commit message.
> Do you expect G_DISABLE_ASSERT being defined for production 
> builds. I've grepped for G_DISABLE_ASSERT and found nothing.

AFAIK this is set by distribution builds. I've also noticed that mingw
builds treat (g_)assert() as if code flow continues, but I don't know
whether asserts do anything there at all.

> 
> And why g_assert over assert (again no guidance in HACKING
> mostly asking for my own learning)?

I do recall a recent(ish) discussion, but not the details. Anyway,
using glib interfaces seems more consistent.

> 
> Other that that LGTM.

Thanks!

> 
> 
> > +        return -ENODEV;
> > +    }
> > +
> >      pbdev = s390_pci_find_dev_by_idx(s390_get_phb(), idx);
> >      if (!pbdev) {
> >          DPRINTF("add_msi_route no dev\n");
> >   
> 
