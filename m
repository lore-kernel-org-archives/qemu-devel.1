Received: from eggs.gnu.org ([2001:4830:134:3::10]:36473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1csgxJ-0004bD-8X
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1csgxF-0003gz-Bi
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:33:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1csgxF-0003gl-5r
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:33:53 -0400
Date: Tue, 28 Mar 2017 05:33:48 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170328053258-mutt-send-email-mst@kernel.org>
References: <20170327044030.31306-1-aik@ozlabs.ru>
	<d474bbee-94aa-d8d2-7369-71058fb8a099@redhat.com>
	<20170328000628.GA13461@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170328000628.GA13461@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH qemu] pci: Add missing drop of bus master
 AS reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Tue, Mar 28, 2017 at 11:06:28AM +1100, David Gibson wrote:
> On Mon, Mar 27, 2017 at 05:28:17PM +0200, Paolo Bonzini wrote:
> > 
> > 
> > On 27/03/2017 06:40, Alexey Kardashevskiy wrote:
> > > The recent introduction of a bus master container added
> > > memory_region_add_subregion() into the PCI device registering path but
> > > missed memory_region_del_subregion() in the unregistering path leaving
> > > a reference to the root memory region of the new container.
> > > 
> > > This adds missing memory_region_del_subregion().
> > > 
> > > Fixes: 3716d5902d743 ("pci: introduce a bus master container")
> > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > ---
> > >  hw/pci/pci.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index e6b08e1988..bd8043c460 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -869,6 +869,8 @@ static void do_pci_unregister_device(PCIDevice *pci_dev)
> > >      pci_dev->bus->devices[pci_dev->devfn] = NULL;
> > >      pci_config_free(pci_dev);
> > >  
> > > +    memory_region_del_subregion(&pci_dev->bus_master_container_region,
> > > +                                &pci_dev->bus_master_enable_region);
> > >      address_space_destroy(&pci_dev->bus_master_as);
> > >  }
> > >  
> > > 
> > 
> > My own review fail.  The enable subregion would be deleted when a memory
> > region is finalized, but the enable subregions is keeping the owner
> > alive.  And until the owner is alive, the container region is not
> > deleted either.  So there is a reference count cycle, which we need to
> > break.
> > 
> > It's probably good to revisit commit 2e2b8eb ("memory: allow destroying
> > a non-empty MemoryRegion", 2015-10-01).  For 2.9,
> > 
> > Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Merged to ppc-for-2.9.

I have it on pci branch, seems more appropriate.

> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
