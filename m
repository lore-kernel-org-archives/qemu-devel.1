Received: from eggs.gnu.org ([2001:4830:134:3::10]:43647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fb9xy-0005F5-Sx
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 15:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fb9xu-0005ZW-As
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 15:30:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fb9xu-0005XN-5K
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 15:30:54 -0400
Date: Thu, 5 Jul 2018 13:30:44 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180705133044.634ede43@t450s.home>
In-Reply-To: <20180705181148.26871-1-clg@kaod.org>
References: <20180705181148.26871-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] pci: remove pci_del_option_rom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Thu,  5 Jul 2018 20:11:48 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> PCI devices needing a ROM allocate an optional MemoryRegion with
> pci_add_option_rom(). pci_del_option_rom() does the cleanup when the
> device is destroyed. The only action taken by this routine is to call
> vmstate_unregister_ram() which clears the id string of the optional
> ROM RAMBlock and now, also flags the RAMBlock as non-migratable. This
> was recently added by commit b895de502717 ("migration: discard
> non-migratable RAMBlocks"), .
>=20
> VFIO devices do their own allocation of the PCI ROM region. It is
> initialized in vfio_pci_size_rom() in which the PCI attribute
> 'has_rom' is set to true but the RAMBlock of the ROM region is not
> allocated. When the associated PCI device is deleted,
> pci_del_option_rom() calls vmstate_unregister_ram() which tries to
> flag a NULL RAMBlock because 'has_rom' is set, leading to a SEGV .
>=20
> The use of vmstate_unregister_ram() in the PCI device was added in
> commit b0e56e0b63f350691b52d3e75e89bb64143fbeff ("unset RAMBlock idstr
> when unregister MemoryRegion") and from the archive in
> http://lists.gnu.org/archive/html/qemu-devel/2014-04/msg00282.html, it
> seems that it was trying to fix a reference count issue.
>=20
> vmstate_unregister_ram() being a work around, let's remove it to fix
> the current SEGV issue and let's try to find a fix for the initial ref
> count issue if we can reproduce.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/pci/pci.c | 11 -----------
>  1 file changed, 11 deletions(-)

Looking back through git history, I think vfio sets PCIDevice.has_rom
because we needed that to have memory_region_destroy() called, but that
changed with Paolo's:

469b046ead06 ("memory: remove memory_region_destroy")

Now the MemoryRegion gets freed automagically, so maybe the better
option is that vfio-pci should not set has_rom to keep it out of this
path.  I don't see that has_rom serves any other purpose.  Thanks,

Alex
