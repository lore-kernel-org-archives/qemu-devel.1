Received: from eggs.gnu.org ([2001:4830:134:3::10]:39774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fbFuC-0003TI-Lj
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 21:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fbFu8-0000J6-4d
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 21:51:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46298 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fbFu7-0000Gn-Ul
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 21:51:24 -0400
Date: Fri, 6 Jul 2018 09:51:13 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180706015113.GC23001@xz-mi>
References: <20180705181148.26871-1-clg@kaod.org>
	<20180705133044.634ede43@t450s.home>
	<b5322979-6114-6334-d1f5-ccc6abc049bb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5322979-6114-6334-d1f5-ccc6abc049bb@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Thu, Jul 05, 2018 at 11:44:44PM +0200, Paolo Bonzini wrote:
> On 05/07/2018 21:30, Alex Williamson wrote:
> > On Thu,  5 Jul 2018 20:11:48 +0200
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >=20
> >> PCI devices needing a ROM allocate an optional MemoryRegion with
> >> pci_add_option_rom(). pci_del_option_rom() does the cleanup when the
> >> device is destroyed. The only action taken by this routine is to cal=
l
> >> vmstate_unregister_ram() which clears the id string of the optional
> >> ROM RAMBlock and now, also flags the RAMBlock as non-migratable. Thi=
s
> >> was recently added by commit b895de502717 ("migration: discard
> >> non-migratable RAMBlocks"), .
> >>
> >> VFIO devices do their own allocation of the PCI ROM region. It is
> >> initialized in vfio_pci_size_rom() in which the PCI attribute
> >> 'has_rom' is set to true but the RAMBlock of the ROM region is not
> >> allocated. When the associated PCI device is deleted,
> >> pci_del_option_rom() calls vmstate_unregister_ram() which tries to
> >> flag a NULL RAMBlock because 'has_rom' is set, leading to a SEGV .
> >>
> >> The use of vmstate_unregister_ram() in the PCI device was added in
> >> commit b0e56e0b63f350691b52d3e75e89bb64143fbeff ("unset RAMBlock ids=
tr
> >> when unregister MemoryRegion") and from the archive in
> >> http://lists.gnu.org/archive/html/qemu-devel/2014-04/msg00282.html, =
it
> >> seems that it was trying to fix a reference count issue.
> >>
> >> vmstate_unregister_ram() being a work around, let's remove it to fix
> >> the current SEGV issue and let's try to find a fix for the initial r=
ef
> >> count issue if we can reproduce.
> >>
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/pci/pci.c | 11 -----------
> >>  1 file changed, 11 deletions(-)
> >=20
> > Looking back through git history, I think vfio sets PCIDevice.has_rom
> > because we needed that to have memory_region_destroy() called, but th=
at
> > changed with Paolo's:
> >=20
> > 469b046ead06 ("memory: remove memory_region_destroy")
> >=20
> > Now the MemoryRegion gets freed automagically, so maybe the better
> > option is that vfio-pci should not set has_rom to keep it out of this
> > path.  I don't see that has_rom serves any other purpose.  Thanks,
>=20
> That would work for me too!

Paolo,

A question about memory region auto destruction (which might not
related to this patch): I see that we have object_property_add_child()
in memory_region_do_init() to achieve the auto destruction but only if
the "name" of memory region is specified.  Could we just do that
unconditionally (though we might of course need to generate some of
the names), or is there a reason not to do so?

Also, not sure whether it's good we add some more comments to
memory_region_do_init() to mention about its auto destruction
capability, and if the "name" check is needed, possibly we comment
that as well (I can do that after I understand it well, if you like)?

Thanks,

--=20
Peter Xu
