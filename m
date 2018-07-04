Received: from eggs.gnu.org ([2001:4830:134:3::10]:40800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1faoxc-0002z8-42
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 17:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1faoxX-000819-5M
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 17:05:12 -0400
Date: Wed, 4 Jul 2018 18:04:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180704210459.GH7451@localhost.localdomain>
References: <20180704112859.20146-1-kraxel@redhat.com>
	<20180704185321.GZ7451@localhost.localdomain>
	<6a0aba7b46b168360fb291eaec769eb0@sebastianbauer.info>
	<20180704205206.GG7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704205206.GG7451@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] vga: make stdvga the global default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>

On Wed, Jul 04, 2018 at 05:52:06PM -0300, Eduardo Habkost wrote:
> On Wed, Jul 04, 2018 at 10:21:19PM +0200, Sebastian Bauer wrote:
> > Am 2018-07-04 20:53, schrieb Eduardo Habkost:
> > > >      mc->kvm_type = spapr_kvm_type;
> > > >      machine_class_allow_dynamic_sysbus_dev(mc,
> > > > TYPE_SPAPR_PCI_HOST_BRIDGE);
> > > >      mc->pci_allow_0_address = true;
> > > > diff --git a/vl.c b/vl.c
> > > > index 16b913f9d5..e60bf2d6cd 100644
> > > > --- a/vl.c
> > > > +++ b/vl.c
> > > > @@ -4475,10 +4475,10 @@ int main(int argc, char **argv, char **envp)
> > > >      if (default_vga) {
> > > >          if (machine_class->default_display) {
> > > >              vga_model = machine_class->default_display;
> > > > -        } else if (vga_interface_available(VGA_CIRRUS)) {
> > > > -            vga_model = "cirrus";
> > > >          } else if (vga_interface_available(VGA_STD)) {
> > > >              vga_model = "std";
> > > > +        } else if (vga_interface_available(VGA_CIRRUS)) {
> > > > +            vga_model = "cirrus";
> > > 
> > > If we don't make the machines above have default_display=NULL, we
> > > won't need this hunk, right?  In either case, I suggest doing
> > > this change on a separate patch.
> > 
> > An alternative would be to define the default always to VGA_STD if the
> > machine does not override it. This is from the observation that the majority
> > would chose std. Obviously, having default values always has pro and cons. I
> > would not consider it harmful here.
> 
> That would be my preference: not having any machine with
> default_display==NULL.  I just don't want to make this a
> requirement for fixing the current bug.
> 
> > 
> > Is there any configuration that includes VGA_CIRRUS but not VGA_STD?
> 
> Not sure, I'll check.

I couldn't find any:

    [VGA_STD] = {
        .opt_name = "std",
        .name = "standard VGA",
        .class_names = { "VGA", "isa-vga" },
    },
    [VGA_CIRRUS] = {
        .opt_name = "cirrus",
        .name = "Cirrus VGA",
        .class_names = { "cirrus-vga", "isa-cirrus-vga" },
    },


"VGA" enabled by CONFIG_VGA_PCI:
hw/display/vga-pci.c:    .name          = "VGA",
hw/display/Makefile.objs:common-obj-$(CONFIG_VGA_PCI) += vga-pci.o

"isa-vga" enabled by CONFIG_VGA_ISA:
hw/display/vga-isa.c:#define TYPE_ISA_VGA "isa-vga"
hw/display/vga-isa.c:    .name          = TYPE_ISA_VGA,
hw/display/Makefile.objs:common-obj-$(CONFIG_VGA_ISA) += vga-isa.o

"cirrus-vga" enabled by CONFIG_VGA_CIRRUS:
hw/display/cirrus_vga.c:#define TYPE_PCI_CIRRUS_VGA "cirrus-vga"
hw/display/cirrus_vga.c:    .name          = TYPE_PCI_CIRRUS_VGA,
hw/display/Makefile.objs:common-obj-$(CONFIG_VGA_CIRRUS) += cirrus_vga.o

"isa-cirrus-vga" enabled by CONFIG_VGA_CIRRUS:
hw/display/cirrus_vga.c:#define TYPE_ISA_CIRRUS_VGA "isa-cirrus-vga"
hw/display/cirrus_vga.c:    .name          = TYPE_ISA_CIRRUS_VGA,
hw/display/Makefile.objs:common-obj-$(CONFIG_VGA_CIRRUS) += cirrus_vga.o

Build configs:

$ git grep -E 'CONFIG_VGA_(ISA|PCI|CIRRUS)|pci.mak'

default-configs/pci.mak:CONFIG_VGA_PCI=y

* 'include pci.mak' below means VGA_STD is available

default-configs/alpha-softmmu.mak:include pci.mak
default-configs/alpha-softmmu.mak:CONFIG_VGA_CIRRUS=y

* VGA_CIRRUS & VGA_STD.

default-configs/arm-softmmu.mak:include pci.mak

* VGA_STD only.

default-configs/hppa-softmmu.mak:include pci.mak

* VGA_STD only.

default-configs/i386-softmmu.mak:include pci.mak
default-configs/i386-softmmu.mak:CONFIG_VGA_ISA=y
default-configs/i386-softmmu.mak:CONFIG_VGA_CIRRUS=y

* VGA_CIRRUS & VGA_STD.

default-configs/mips-softmmu-common.mak:include pci.mak
default-configs/mips-softmmu-common.mak:CONFIG_VGA_ISA=y
default-configs/mips-softmmu-common.mak:CONFIG_VGA_ISA_MM=y
default-configs/mips-softmmu-common.mak:CONFIG_VGA_CIRRUS=y

* VGA_CIRRUS & VGA_STD.

default-configs/ppc-softmmu.mak:include pci.mak
default-configs/ppc-softmmu.mak:CONFIG_VGA_CIRRUS=y

* VGA_CIRRUS & VGA_STD.

default-configs/ppcemb-softmmu.mak:include pci.mak

* VGA_STD only.

default-configs/sh4-softmmu.mak:include pci.mak

* VGA_STD only.

default-configs/sh4eb-softmmu.mak:include pci.mak

* VGA_STD only.

default-configs/sparc64-softmmu.mak:include pci.mak

* VGA_STD only.

default-configs/x86_64-softmmu.mak:include pci.mak
default-configs/x86_64-softmmu.mak:CONFIG_VGA_ISA=y
default-configs/x86_64-softmmu.mak:CONFIG_VGA_CIRRUS=y

* VGA_CIRRUS & VGA_STD.

roms/config.vga-bochs-display:CONFIG_VGA_PCI=y
roms/config.vga-cirrus:CONFIG_VGA_CIRRUS=y
roms/config.vga-cirrus:CONFIG_VGA_PCI=y
roms/config.vga-isavga:CONFIG_VGA_PCI=n
roms/config.vga-qxl:CONFIG_VGA_PCI=y
roms/config.vga-ramfb:CONFIG_VGA_PCI=n
roms/config.vga-stdvga:CONFIG_VGA_PCI=y
roms/config.vga-virtio:CONFIG_VGA_PCI=y
roms/config.vga-vmware:CONFIG_VGA_PCI=y

* I have no idea what this is, I guess this is not related to the
  QEMU build system at all.  :)

-- 
Eduardo
