Received: from eggs.gnu.org ([2001:4830:134:3::10]:42229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cmucJ-0003jY-DA
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 22:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cmucE-0004EX-9u
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 22:56:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cmucD-0004DU-Vp
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 22:56:18 -0500
Date: Sun, 12 Mar 2017 05:56:15 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170312055033-mutt-send-email-mst@kernel.org>
References: <90ac2aef-5fff-ada6-d847-cd3ce20b967a@ilande.co.uk>
	<20170312025259-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170312025259-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] Incorrect memory region address with large 64-bit
 PCI BARs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Sun, Mar 12, 2017 at 03:46:57AM +0200, Michael S. Tsirkin wrote:
> On Sat, Mar 11, 2017 at 10:37:09AM +0000, Mark Cave-Ayland wrote:
> > I've been looking at an issue with virtio BARs being mapped incorrectly
> > on qemu-system-sparc64, and as part of this investigation found that
> > some 64-bit PCI BAR memory regions don't appear correctly in "info mtree".
> > 
> > The easiest way to see this is to launch QEMU as below and then check
> > the output of "info mtree":
> > 
> > ./qemu-system-sparc64 -device virtio-net-pci
> > 
> > The interesting part is this:
> > 
> > > address-space: memory
> > >   0000000000000000-ffffffffffffffff (prio 0, i/o): system
> > >     0000000000000000-0000000007ffffff (prio 0, ram): sun4u.ram
> > >     000001fe00000000-000001fe0000ffff (prio 0, i/o): apb-config
> > >     000001fe01000000-000001fe01ffffff (prio 0, i/o): apb-pci-config
> > >     000001fe02000000-000001fe0200ffff (prio 0, i/o): alias apb-pci ioport @io 0000000000000000-000000000000ffff
> > >     000001ff00000000-000001ffffffffff (prio 0, i/o): pci-mmio
> > >       000001ff00000000-000001ff000fffff (prio 1, i/o): alias pci_bridge_mem @pci_bridge_pci 0000000000000000-00000000000fffff
> > >       000001ff00000000-000001ff000fffff (prio 1, i/o): alias pci_bridge_pref_mem @pci_bridge_pci 0000000000000000-00000000000fffff
> > >       000001ff00000000-000001ff000fffff (prio 1, i/o): alias pci_bridge_mem @pci_bridge_pci 0000000000000000-00000000000fffff
> > >       000001ff00000000-000001ff000fffff (prio 1, i/o): alias pci_bridge_pref_mem @pci_bridge_pci 0000000000000000-00000000000fffff
> > >       000001ff000a0000-000001ff000affff (prio 2, i/o): alias vga.chain4 @vga.vram 0000000000000000-000000000000ffff
> > >       000001ff000a0000-000001ff000bffff (prio 1, i/o): vga-lowmem
> > >       000001ff01000000-000001ff01ffffff (prio 1, ram): vga.vram
> > >       000001ff02000000-000001ff02000fff (prio 1, i/o): vga.mmio
> > >         000001ff02000400-000001ff0200041f (prio 0, i/o): vga ioports remapped
> > >         000001ff02000500-000001ff02000515 (prio 0, i/o): bochs dispi interface
> > >         000001ff02000600-000001ff02000607 (prio 0, i/o): qemu extended regs
> > >       000001ff02010000-000001ff0201ffff (prio 1, rom): vga.rom
> > >       000001ff03000000-000001ff03ffffff (prio 1, i/o): alias bar0 @io 0000000000000000-0000000000ffffff
> > >       000001ff04000000-000001ff0403ffff (prio 1, rom): ne2000.rom
> > >       000001ff04080000-000001ff040bffff (prio 1, rom): virtio-net-pci.rom
> > >       000001fe04040000-000001fe04043fff (prio 1, i/o): virtio-pci
> >         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > Here virtio-pci is mapped to address 0x1fe04040000 even though its
> > parent pci-mmio memory region is at 0x1ff00000000.
> > 
> > >         000001fe04040000-000001fe04040fff (prio 0, i/o): virtio-pci-common
> > >         000001fe04041000-000001fe04041fff (prio 0, i/o): virtio-pci-isr
> > >         000001fe04042000-000001fe04042fff (prio 0, i/o): virtio-pci-device
> > >         000001fe04043000-000001fe04043fff (prio 0, i/o): virtio-pci-notify
> > >     000001fff0000000-000001fff03fffff (prio 0, rom): sun4u.prom
> > 
> > The bug in the current OpenBIOS is that 64-bit BARs are incorrectly
> > identified, and so the BAR MSB register is set to 0xffffffff to detect
> > the size as per a standard 32-bit BAR. At this point OpenBIOS detects
> > something is wrong and aborts, leaving the 64-bit BAR set to 0xffffffff
> > 0x04040000.
> > 
> > This is accurately reflected in the virtio-pci memory region itself, i.e.
> > 
> > > memory-region: virtio-pci
> > >   ffffffff04040000-ffffffff04043fff (prio 1, i/o): virtio-pci
> > >     ffffffff04040000-ffffffff04040fff (prio 0, i/o): virtio-pci-common
> > >     ffffffff04041000-ffffffff04041fff (prio 0, i/o): virtio-pci-isr
> > >     ffffffff04042000-ffffffff04042fff (prio 0, i/o): virtio-pci-device
> > >     ffffffff04043000-ffffffff04043fff (prio 0, i/o): virtio-pci-notify
> > 
> > But as you can see above the overall effect is that the virtio-pci
> > device ends up somehow being mapped outside (and indeed, before the
> > start of) its parent memory region.
> 
> And specifically we have:
> 
> 000001ff00000000 + ffffffff04040000 = 000001fe04043000
> 
> which seems to be where this is coming from.
> 
> It does have to indicate some kind of modelling problem:
> since it looks like on sparc BAR is an offset within
> PCI MMIO region, I would expect an offset value bigger than 
> the region size not to be visible.
> 
> Specifically documentation states:
> 
> - all direct subregions of the root region are matched against the address, in
>   descending priority order
>   - if the address lies outside the region offset/size, the subregion is
>     discarded
> 

After looking at it some more, I think the issue is merely with how info
mtree presents information, which confuses instead of helping when
overlap triggers. Specifically
    000001ff00000000-000001ffffffffff (prio 0, i/o): pci-mmio
	...
      000001fe04040000-000001fe04043fff (prio 1, i/o): virtio-pci

really means that virtio-pci is not visible at all, this
happens because it starts at offset ffffffff04040000 which is
outside the parent.

I think that the cleanest fix is probably to show 128 bit addresses,
then user will see the real addresses:

    000001ff00000000-000001ffffffffff (prio 0, i/o): pci-mmio
	...
      1000001fe04040000-1000001fe04043fff (prio 1, i/o): virtio-pci
	
and now it's clear what is going on: virtio-pci is outside pci-mmio.

This would have pointed Mark in the right direction earlier.

Thoughts? Patch?


-- 
MST
