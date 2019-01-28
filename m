Received: from eggs.gnu.org ([209.51.188.92]:50632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go4Mp-0001Lj-Co
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:42:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go4Mn-0007Zu-I2
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:42:15 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1go4Mn-0007Yi-18
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:42:13 -0500
Received: by mail-ot1-x341.google.com with SMTP id w25so14168395otm.13
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 02:42:12 -0800 (PST)
MIME-Version: 1.0
References: <1544173675-14217-1-git-send-email-hongbo.zhang@linaro.org>
	<1544173675-14217-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA8WF1nKfgQWZ11GgMzgLxOtGwoJS9zyeFQkm5ii5GLrpw@mail.gmail.com>
	<CAHmQWvD-gqxR+7dOG3BKA-5cGA-JBb4SAfJWpRAtqrOkfRw-kw@mail.gmail.com>
In-Reply-To: <CAHmQWvD-gqxR+7dOG3BKA-5cGA-JBb4SAfJWpRAtqrOkfRw-kw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 10:42:00 +0000
Message-ID: <CAFEAcA9mtwUgs0nzuKPZXFX+JBogwvUF99Ojn_oD3EOeyBo_sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 1/2] hw/arm: Add arm SBSA reference
 machine, skeleton part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>

On Mon, 28 Jan 2019 at 10:16, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>
> On Tue, 22 Jan 2019 at 19:42, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Fri, 7 Dec 2018 at 09:08, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> > >
> > > For the Aarch64, there is one machine 'virt', it is primarily meant to
> > > run on KVM and execute virtualization workloads, but we need an
> > > environment as faithful as possible to physical hardware, for supporting
> > > firmware and OS development for pysical Aarch64 machines.
> > >
> > > This patch introduces new machine type 'sbsa-ref' with main features:
> > >  - Based on 'virt' machine type.
> > >  - Re-designed memory map.
> > >  - CPU type cortex-a57.
> > >  - EL2 and EL3 are enabled.
> > >  - GIC version 3.
> > >  - System bus AHCI controller.
> > >  - System bus XHCI controller(TBD).
> > >  - CDROM and hard disc on AHCI bus.
> > >  - E1000E ethernet card on PCIE bus.
> > >  - VGA display adaptor on PCIE bus.
> > >  - No virtio deivces.
> > >  - No fw_cfg device.
> > >  - No ACPI table supplied.
> > >  - Only minimal device tree nodes.
> > >
> > > Arm Trusted Firmware and UEFI porting to this are done accordingly, and
> > > it should supply ACPI tables to load OS, the minimal device tree nodes
> > > supplied from this platform are only to pass the dynamic info reflecting
> > > command line input to firmware, not for loading OS.
> > >
> > > To make the review easier, this task is split into two patches, the
> > > fundamental sceleton part and the peripheral devices part, this patch is
> > > the first part.
> >
> > Firstly, apologies for this having sat on my to-review queue for
> > so long...
> >
> Understand, it is OK, thanks for review.
>
> > > Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> > > ---
> > >  hw/arm/Makefile.objs  |   2 +-
> > >  hw/arm/sbsa-ref.c     | 277 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  include/hw/arm/virt.h |   1 +
> > >  3 files changed, 279 insertions(+), 1 deletion(-)
> > >  create mode 100644 hw/arm/sbsa-ref.c
> > >
> > > diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> > > index d51fcec..a8895eb 100644
> > > --- a/hw/arm/Makefile.objs
> > > +++ b/hw/arm/Makefile.objs
> > > @@ -1,4 +1,4 @@
> > > -obj-y += boot.o virt.o sysbus-fdt.o
> > > +obj-y += boot.o virt.o sbsa-ref.o sysbus-fdt.o
> > >  obj-$(CONFIG_ACPI) += virt-acpi-build.o
> > >  obj-$(CONFIG_DIGIC) += digic_boards.o
> > >  obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
> > > diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> > > new file mode 100644
> > > index 0000000..1d6252b
> > > --- /dev/null
> > > +++ b/hw/arm/sbsa-ref.c
> > > @@ -0,0 +1,277 @@
> > > +/*
> > > + * ARM SBSA Reference Platform emulation
> > > + *
> > > + * Copyright (c) 2018 Linaro Limited
> > > + * Written by Hongbo Zhang <hongbo.zhang@linaro.org>
> > > + *
> > > + * Based on hw/arm/virt.c
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify it
> > > + * under the terms and conditions of the GNU General Public License,
> > > + * version 2 or later, as published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope it will be useful, but WITHOUT
> > > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > > + * more details.
> > > + *
> > > + * You should have received a copy of the GNU General Public License along with
> > > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "qapi/error.h"
> > > +#include "hw/arm/arm.h"
> > > +#include "hw/arm/virt.h"
> >
> > This isn't the virt board, so I think it would be better if it did
> > not include the virt.h header or use structures/classes that are
> > private to the virt board. It should be its own thing.
> >
> > > +#include "hw/devices.h"
> > > +#include "net/net.h"
> > > +#include "sysemu/device_tree.h"
> > > +#include "sysemu/numa.h"
> > > +#include "sysemu/sysemu.h"
> > > +#include "hw/loader.h"
> > > +#include "exec/address-spaces.h"
> > > +#include "qemu/error-report.h"
> > > +#include "hw/pci-host/gpex.h"
> > > +#include "hw/arm/sysbus-fdt.h"
> > > +#include "hw/arm/fdt.h"
> > > +#include "hw/intc/arm_gic.h"
> > > +#include "hw/intc/arm_gicv3_common.h"
> > > +#include "kvm_arm.h"
> > > +#include "hw/ide/internal.h"
> > > +#include "hw/ide/ahci_internal.h"
> > > +#include "qemu/units.h"
> > > +
> > > +#define NUM_IRQS 256
> > > +
> > > +#define RAMLIMIT_GB 8192
> > > +#define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
> > > +
> > > +static const MemMapEntry sbsa_ref_memmap[] = {
> > > +    /* 512M boot ROM */
> > > +    [VIRT_FLASH] =              {          0, 0x20000000 },
> > > +    /* 512M secure memery */
> >
> > "memory"
> >
> Oops :(
>
> > > +    [VIRT_SECURE_MEM] =         { 0x20000000, 0x20000000 },
> > > +    [VIRT_CPUPERIPHS] =         { 0x40000000, 0x00080000 },
> > > +    /* GIC distributor and CPU interface expansion spaces reserved */
> > > +    [VIRT_GIC_DIST] =           { 0x40000000, 0x00010000 },
> > > +    [VIRT_GIC_CPU] =            { 0x40040000, 0x00010000 },
> >
> > If they're just reserved you don't really need to list them here,
> > as they're covered by the VIRT_CPUPERIPHS space anyway. (You
> > don't list the VIRT_GIC_HYP registers or VIRT_GIC_VCPU.)
> >
> Yes, this can be removed.
>
> > > +    /* 64M redistributor space allows up to 512 CPUs */
> > > +    [VIRT_GIC_REDIST] =         { 0x40080000, 0x04000000 },
> > > +    /* Space here reserved for redistributor and vCPU/HYP expansion */
> > > +    [VIRT_UART] =               { 0x60000000, 0x00001000 },
> > > +    [VIRT_RTC] =                { 0x60010000, 0x00001000 },
> > > +    [VIRT_GPIO] =               { 0x60020000, 0x00001000 },
> > > +    [VIRT_SECURE_UART] =        { 0x60030000, 0x00001000 },
> > > +    [VIRT_SMMU] =               { 0x60040000, 0x00020000 },
> > > +    /* Space here reserved for more SMMUs */
> > > +    [VIRT_AHCI] =               { 0x60100000, 0x00010000 },
> > > +    /* Space here reserved for other devices */
> > > +    [VIRT_PCIE_PIO] =           { 0x7fff0000, 0x00010000 },
> > > +    /* 256M PCIE ECAM space */
> > > +    [VIRT_PCIE_ECAM] =          { 0x80000000, 0x10000000 },
> >
> > Comment says 256M but the size field says it's larger...
> >
> I calculated, 256M should be 0x10000000, 7 zeros.
>
> > > +    /* ~1TB for PCIE MMIO (4GB to 1024GB boundary) */
> > > +    [VIRT_PCIE_MMIO] =          { 0x100000000ULL, 0xFF00000000ULL },
> > > +    [VIRT_MEM] =                { 0x10000000000ULL, RAMLIMIT_BYTES },
> > > +};
> > > +
> > > +static const int sbsa_ref_irqmap[] = {
> > > +    [VIRT_UART] = 1,
> > > +    [VIRT_RTC] = 2,
> > > +    [VIRT_PCIE] = 3, /* ... to 6 */
> > > +    [VIRT_GPIO] = 7,
> > > +    [VIRT_SECURE_UART] = 8,
> > > +    [VIRT_AHCI] = 9,
> > > +};
> > > +
> > > +static void sbsa_ref_init(MachineState *machine)
> > > +{
> > > +    VirtMachineState *vms = VIRT_MACHINE(machine);
> >
> > As noted above, I think it would be better to be your own
> > subclass of MachineState, rather than being a subclass of
> > the virt board. Is there anything that becomes particularly
> > awkward if you do it that way?
> >
> Just wanted to save code lines since this board derives from virt.
> It is fine to have its own header file, will do that.
>
> > thanks
> > -- PMM



-- 
12345678901234567890123456789012345678901234567890123456789012345678901234567890
         1         2         3         4         5         6         7         8
