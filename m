Received: from eggs.gnu.org ([2001:4830:134:3::10]:51531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dNUbx-0007VE-O8
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 21:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dNUbu-00048n-K2
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 21:39:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dNUbu-00048f-EF
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 21:39:10 -0400
Date: Wed, 21 Jun 2017 04:39:05 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170621043236-mutt-send-email-mst@kernel.org>
References: <ccd731e5-f128-0493-d12f-72193a39d0f9@ilande.co.uk>
	<384e0431-5c29-dee4-a99c-19c350ebba57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <384e0431-5c29-dee4-a99c-19c350ebba57@redhat.com>
Subject: Re: [Qemu-devel] pci_nic_init_nofail() only works on root PCI buses?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel@redhat.com>

On Wed, Jun 21, 2017 at 03:00:31AM +0200, Thomas Huth wrote:
> On 11.06.2017 17:08, Mark Cave-Ayland wrote:
> > Hi all,
> > 
> > Playing around with trying to set up PCI bridges for sun4u, I noticed
> > that I get an assert with the following diff which simply moves the
> > default NIC behind a PCI bridge rather than being directly on the root
> > PCI bus:
> > 
> > diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> > index 69f565d..0b17f2e 100644
> > --- a/hw/sparc64/sun4u.c
> > +++ b/hw/sparc64/sun4u.c
> > @@ -465,7 +465,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
> >      parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
> > 
> >      for(i = 0; i < nb_nics; i++)
> > -        pci_nic_init_nofail(&nd_table[i], pci_bus, "ne2k_pci", NULL);
> > +        pci_nic_init_nofail(&nd_table[i], pci_bus3, "ne2k_pci", NULL);
> > 
> >      ide_drive_get(hd, ARRAY_SIZE(hd));
> > 
> > 
> > $ ./qemu-system-sparc64 -nographic
> > qemu-system-sparc64: hw/pci/pci.c:682: pci_get_bus_devfn: Assertion
> > `!root->parent_dev' failed.
> > Aborted
> > 
> > Is there any particular reason why the assert() is set to fail if the
> > NIC isn't being instantiated on the root PCI bus?
> 
> Sounds strange indeed. At least the patch description of the commit that
> introduce the assert() says that using anything else seems to be an error:
> 
> http://git.qemu.org/?p=qemu.git;a=commitdiff;h=85c6e4fabb4c26e5cd8a0
> 
> Not sure whether that's still true nowadays, since that commit is
> already 4 years old...
> 
>  Thomas

pci_get_bus_devfn is not a sensible interface. It uses bus numbers which
are guest assigned in the machine monitor interface.

We keep it around for compatibility reasons.

Just avoid legacy APIs is my advice. New machine types should create
device instances with -device or similar.

-- 
MST
