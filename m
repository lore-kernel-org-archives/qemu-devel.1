Received: from eggs.gnu.org ([2001:4830:134:3::10]:60669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fcdOp-0001sL-8M
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fcdOk-0006Zm-B6
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:08:47 -0400
Date: Mon, 9 Jul 2018 18:08:33 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180709210833.GC7451@localhost.localdomain>
References: <20180705064348.3162-1-kraxel@redhat.com>
	<20180705064348.3162-3-kraxel@redhat.com>
	<20180705163501.GN7451@localhost.localdomain>
	<20180706065342.pggd2qgd4nyv35ys@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706065342.pggd2qgd4nyv35ys@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vga: don't pick cirrus by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Aleksandar Markovic <aleksandar.markovic@mips.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Sebastian Bauer <mail@sebastianbauer.info>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

On Fri, Jul 06, 2018 at 08:53:42AM +0200, Gerd Hoffmann wrote:
> On Thu, Jul 05, 2018 at 01:35:01PM -0300, Eduardo Habkost wrote:
> > Do we have a list of all machine-types with default_display==NULL
> > that would be affected by this?
> 
> There are not many which use the default vga thing in the first place.
> Workflow is this:
> 
>  (1) vl.c calls select_vgahw(vga_model) after setting vga_model.
>  (2) select_hw() sets vga_interface_type.
>  (3) isa_vga_init() and pci_vga_init() look at vga_interface_type.
> 
> Checking where either vga_interface_type or *_vga_init() is used doesn't
> yield many places:
> 
> # find -name "*.[ch]" | xargs egrep '((isa|pci)_vga_init|vga_interface_type)'
> ./hw/alpha/dp264.c:    pci_vga_init(pci_bus);
> ./hw/i386/pc.c:        PCIDevice *pcidev = pci_vga_init(pci_bus);
> ./hw/i386/pc.c:        ISADevice *isadev = isa_vga_init(isa_bus);
> ./hw/isa/isa-bus.c:ISADevice *isa_vga_init(ISABus *bus)
> ./hw/isa/isa-bus.c:    switch (vga_interface_type) {
> ./hw/mips/mips_malta.c:    pci_vga_init(pci_bus);
> ./hw/mips/mips_r4k.c:    isa_vga_init(isa_bus);
> ./hw/pci/pci.c:PCIDevice *pci_vga_init(PCIBus *bus)
> ./hw/pci/pci.c:    switch (vga_interface_type) {
> ./hw/ppc/mac_newworld.c:    pci_vga_init(pci_bus);
> ./hw/ppc/mac_oldworld.c:    pci_vga_init(pci_bus);
> ./hw/ppc/spapr.c:    switch (vga_interface_type) {
> ./hw/ppc/spapr.c:        return pci_vga_init(pci_bus) != NULL;
> ./hw/ppc/prep.c:    pci_vga_init(pci_bus);
> ./hw/ppc/prep.c:        pci_vga_init(pci_bus);
> ./hw/sparc/sun4m.c:        if (vga_interface_type == VGA_CG3) {
> ./include/hw/isa/isa.h:ISADevice *isa_vga_init(ISABus *bus);
> ./include/hw/pci/pci.h:PCIDevice *pci_vga_init(PCIBus *bus);
> ./include/sysemu/sysemu.h:extern int vga_interface_type;
> ./include/sysemu/sysemu.h:#define xenfb_enabled (vga_interface_type == VGA_XENFB)
> ./vl.c:int vga_interface_type = VGA_NONE;
> ./vl.c:    assert(vga_interface_type == VGA_NONE);
> ./vl.c:            vga_interface_type = t;
> ./vl.c:        vga_interface_type = VGA_DEVICE;
> 
> So it is alpha, mips, i386, ppc.

Right, and all of them have both CONFIG_VGA_CIRRUS and
CONFIG_VGA_PCI enabled.  This means all of them will be affected
by this patch if they have any machines with
default_display==NULL.

At least on x86 we still have a few machines with
default_display==NULL: isapc, xenpv, xenfv.  We need to fix them
before we apply this patch.

I didn't check alpha/mips/ppc yet.

-- 
Eduardo
