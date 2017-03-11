Received: from eggs.gnu.org ([2001:4830:134:3::10]:55022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cmeP9-00048s-Ar
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 05:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cmeP5-0005Ld-BX
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 05:37:43 -0500
Received: from chuckie.co.uk ([82.165.15.123]:50698
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cmeP5-0005GN-4Y
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 05:37:39 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <90ac2aef-5fff-ada6-d847-cd3ce20b967a@ilande.co.uk>
Date: Sat, 11 Mar 2017 10:37:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] Incorrect memory region address with large 64-bit PCI
 BARs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

I've been looking at an issue with virtio BARs being mapped incorrectly
on qemu-system-sparc64, and as part of this investigation found that
some 64-bit PCI BAR memory regions don't appear correctly in "info mtree".

The easiest way to see this is to launch QEMU as below and then check
the output of "info mtree":

./qemu-system-sparc64 -device virtio-net-pci

The interesting part is this:

> address-space: memory
>   0000000000000000-ffffffffffffffff (prio 0, i/o): system
>     0000000000000000-0000000007ffffff (prio 0, ram): sun4u.ram
>     000001fe00000000-000001fe0000ffff (prio 0, i/o): apb-config
>     000001fe01000000-000001fe01ffffff (prio 0, i/o): apb-pci-config
>     000001fe02000000-000001fe0200ffff (prio 0, i/o): alias apb-pci ioport @io 0000000000000000-000000000000ffff
>     000001ff00000000-000001ffffffffff (prio 0, i/o): pci-mmio
>       000001ff00000000-000001ff000fffff (prio 1, i/o): alias pci_bridge_mem @pci_bridge_pci 0000000000000000-00000000000fffff
>       000001ff00000000-000001ff000fffff (prio 1, i/o): alias pci_bridge_pref_mem @pci_bridge_pci 0000000000000000-00000000000fffff
>       000001ff00000000-000001ff000fffff (prio 1, i/o): alias pci_bridge_mem @pci_bridge_pci 0000000000000000-00000000000fffff
>       000001ff00000000-000001ff000fffff (prio 1, i/o): alias pci_bridge_pref_mem @pci_bridge_pci 0000000000000000-00000000000fffff
>       000001ff000a0000-000001ff000affff (prio 2, i/o): alias vga.chain4 @vga.vram 0000000000000000-000000000000ffff
>       000001ff000a0000-000001ff000bffff (prio 1, i/o): vga-lowmem
>       000001ff01000000-000001ff01ffffff (prio 1, ram): vga.vram
>       000001ff02000000-000001ff02000fff (prio 1, i/o): vga.mmio
>         000001ff02000400-000001ff0200041f (prio 0, i/o): vga ioports remapped
>         000001ff02000500-000001ff02000515 (prio 0, i/o): bochs dispi interface
>         000001ff02000600-000001ff02000607 (prio 0, i/o): qemu extended regs
>       000001ff02010000-000001ff0201ffff (prio 1, rom): vga.rom
>       000001ff03000000-000001ff03ffffff (prio 1, i/o): alias bar0 @io 0000000000000000-0000000000ffffff
>       000001ff04000000-000001ff0403ffff (prio 1, rom): ne2000.rom
>       000001ff04080000-000001ff040bffff (prio 1, rom): virtio-net-pci.rom
>       000001fe04040000-000001fe04043fff (prio 1, i/o): virtio-pci
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Here virtio-pci is mapped to address 0x1fe04040000 even though its
parent pci-mmio memory region is at 0x1ff00000000.

>         000001fe04040000-000001fe04040fff (prio 0, i/o): virtio-pci-common
>         000001fe04041000-000001fe04041fff (prio 0, i/o): virtio-pci-isr
>         000001fe04042000-000001fe04042fff (prio 0, i/o): virtio-pci-device
>         000001fe04043000-000001fe04043fff (prio 0, i/o): virtio-pci-notify
>     000001fff0000000-000001fff03fffff (prio 0, rom): sun4u.prom

The bug in the current OpenBIOS is that 64-bit BARs are incorrectly
identified, and so the BAR MSB register is set to 0xffffffff to detect
the size as per a standard 32-bit BAR. At this point OpenBIOS detects
something is wrong and aborts, leaving the 64-bit BAR set to 0xffffffff
0x04040000.

This is accurately reflected in the virtio-pci memory region itself, i.e.

> memory-region: virtio-pci
>   ffffffff04040000-ffffffff04043fff (prio 1, i/o): virtio-pci
>     ffffffff04040000-ffffffff04040fff (prio 0, i/o): virtio-pci-common
>     ffffffff04041000-ffffffff04041fff (prio 0, i/o): virtio-pci-isr
>     ffffffff04042000-ffffffff04042fff (prio 0, i/o): virtio-pci-device
>     ffffffff04043000-ffffffff04043fff (prio 0, i/o): virtio-pci-notify

But as you can see above the overall effect is that the virtio-pci
device ends up somehow being mapped outside (and indeed, before the
start of) its parent memory region.

Fixing the bug in OpenBIOS itself is fairly trivial, although it took
much longer to diagnose due to the misleading output above. It does seem
that something isn't quite right with the handling of the large 64-bit
BARs in this case, so Michael suggested I email the list for further
comment.


ATB,

Mark.
