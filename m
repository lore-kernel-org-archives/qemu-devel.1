Received: from eggs.gnu.org ([2001:4830:134:3::10]:43741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fbKcn-0000bu-Ea
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fbKck-00049C-DW
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:53:49 -0400
Date: Fri, 6 Jul 2018 08:53:42 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180706065342.pggd2qgd4nyv35ys@sirius.home.kraxel.org>
References: <20180705064348.3162-1-kraxel@redhat.com>
	<20180705064348.3162-3-kraxel@redhat.com>
	<20180705163501.GN7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705163501.GN7451@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vga: don't pick cirrus by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Sebastian Bauer <mail@sebastianbauer.info>

On Thu, Jul 05, 2018 at 01:35:01PM -0300, Eduardo Habkost wrote:
> Do we have a list of all machine-types with default_display==NULL
> that would be affected by this?

There are not many which use the default vga thing in the first place.
Workflow is this:

 (1) vl.c calls select_vgahw(vga_model) after setting vga_model.
 (2) select_hw() sets vga_interface_type.
 (3) isa_vga_init() and pci_vga_init() look at vga_interface_type.

Checking where either vga_interface_type or *_vga_init() is used doesn't
yield many places:

# find -name "*.[ch]" | xargs egrep '((isa|pci)_vga_init|vga_interface_type)'
./hw/alpha/dp264.c:    pci_vga_init(pci_bus);
./hw/i386/pc.c:        PCIDevice *pcidev = pci_vga_init(pci_bus);
./hw/i386/pc.c:        ISADevice *isadev = isa_vga_init(isa_bus);
./hw/isa/isa-bus.c:ISADevice *isa_vga_init(ISABus *bus)
./hw/isa/isa-bus.c:    switch (vga_interface_type) {
./hw/mips/mips_malta.c:    pci_vga_init(pci_bus);
./hw/mips/mips_r4k.c:    isa_vga_init(isa_bus);
./hw/pci/pci.c:PCIDevice *pci_vga_init(PCIBus *bus)
./hw/pci/pci.c:    switch (vga_interface_type) {
./hw/ppc/mac_newworld.c:    pci_vga_init(pci_bus);
./hw/ppc/mac_oldworld.c:    pci_vga_init(pci_bus);
./hw/ppc/spapr.c:    switch (vga_interface_type) {
./hw/ppc/spapr.c:        return pci_vga_init(pci_bus) != NULL;
./hw/ppc/prep.c:    pci_vga_init(pci_bus);
./hw/ppc/prep.c:        pci_vga_init(pci_bus);
./hw/sparc/sun4m.c:        if (vga_interface_type == VGA_CG3) {
./include/hw/isa/isa.h:ISADevice *isa_vga_init(ISABus *bus);
./include/hw/pci/pci.h:PCIDevice *pci_vga_init(PCIBus *bus);
./include/sysemu/sysemu.h:extern int vga_interface_type;
./include/sysemu/sysemu.h:#define xenfb_enabled (vga_interface_type == VGA_XENFB)
./vl.c:int vga_interface_type = VGA_NONE;
./vl.c:    assert(vga_interface_type == VGA_NONE);
./vl.c:            vga_interface_type = t;
./vl.c:        vga_interface_type = VGA_DEVICE;

So it is alpha, mips, i386, ppc.

Also some hits vl.c, headers and isa/pci code.
Xen and sparc check for something which is never picked as default,
so no worries here.

cheers,
  Gerd
