Received: from eggs.gnu.org ([2001:4830:134:3::10]:53564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMOm-0002hN-Gk
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMOk-0002Wa-Ak
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:12:32 -0500
Date: Wed, 22 Nov 2017 14:36:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171122033643.GH2380@umbus.fritz.box>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
	<20171120032420.9134-3-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/Gk0KcsbyUMelFU1"
Content-Disposition: inline
In-Reply-To: <20171120032420.9134-3-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 02/12] e500: consolidate mpc8540 guts with
 e500-ccsr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--/Gk0KcsbyUMelFU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2017 at 09:24:10PM -0600, Michael Davidsaver wrote:
> Preparation for adding more MPCxxxx control
> registers.
>=20
> Use e500 SVR to enable part specific registers.
> Only the mpc8544 reset register at present.
>=20
> Expose CCSR as SysBusDevice region to eliminate
> e500-ccsr.h.
>=20
> Track CCSR base address within device, and map on reset,
> in preparation for CCSRBAR.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

Applied to ppc-for-2.12.

> ---
>  hw/pci-host/ppce500.c |  10 ++--
>  hw/ppc/Makefile.objs  |   3 +-
>  hw/ppc/e500-ccsr.h    |  17 ------
>  hw/ppc/e500.c         |  37 +-----------
>  hw/ppc/e500_ccsr.c    | 152 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/mpc8544_guts.c | 143 --------------------------------------------=
---
>  6 files changed, 162 insertions(+), 200 deletions(-)
>  delete mode 100644 hw/ppc/e500-ccsr.h
>  create mode 100644 hw/ppc/e500_ccsr.c
>  delete mode 100644 hw/ppc/mpc8544_guts.c
>=20
> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> index 39cd24464d..f2d108bc8a 100644
> --- a/hw/pci-host/ppce500.c
> +++ b/hw/pci-host/ppce500.c
> @@ -16,7 +16,6 @@
> =20
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
> -#include "hw/ppc/e500-ccsr.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_host.h"
>  #include "qemu/bswap.h"
> @@ -420,16 +419,17 @@ static const VMStateDescription vmstate_ppce500_pci=
 =3D {
>  static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
>  {
>      PPCE500PCIBridgeState *b =3D PPC_E500_PCI_BRIDGE(d);
> -    PPCE500CCSRState *ccsr =3D CCSR(container_get(qdev_get_machine(),
> -                                  "/e500-ccsr"));
> +    SysBusDevice *ccsr =3D SYS_BUS_DEVICE(container_get(qdev_get_machine=
(),
> +                                                      "/e500-ccsr"));
> +    MemoryRegion *ccsr_mr =3D sysbus_mmio_get_region(ccsr, 0);
> =20
>      pci_config_set_class(d->config, PCI_CLASS_BRIDGE_PCI);
>      d->config[PCI_HEADER_TYPE] =3D
>          (d->config[PCI_HEADER_TYPE] & PCI_HEADER_TYPE_MULTI_FUNCTION) |
>          PCI_HEADER_TYPE_BRIDGE;
> =20
> -    memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0", &c=
csr->ccsr_space,
> -                             0, int128_get64(ccsr->ccsr_space.size));
> +    memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0", cc=
sr_mr,
> +                             0, memory_region_size(ccsr_mr));
>      pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &b->bar0);
>  }
> =20
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index 7efc686748..c1a63d0c39 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -24,6 +24,7 @@ obj-$(CONFIG_MAC) +=3D mac_oldworld.o
>  obj-$(CONFIG_MAC) +=3D mac_newworld.o
>  # e500
>  obj-$(CONFIG_E500) +=3D e500.o mpc8544ds.o e500plat.o
> -obj-$(CONFIG_E500) +=3D mpc8544_guts.o ppce500_spin.o
> +obj-$(CONFIG_E500) +=3D ppce500_spin.o
> +obj-$(CONFIG_E500) +=3D e500_ccsr.o
>  # PowerPC 440 Xilinx ML507 reference board.
>  obj-$(CONFIG_XILINX) +=3D virtex_ml507.o
> diff --git a/hw/ppc/e500-ccsr.h b/hw/ppc/e500-ccsr.h
> deleted file mode 100644
> index 12a2ba4b97..0000000000
> --- a/hw/ppc/e500-ccsr.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -#ifndef E500_CCSR_H
> -#define E500_CCSR_H
> -
> -#include "hw/sysbus.h"
> -
> -typedef struct PPCE500CCSRState {
> -    /*< private >*/
> -    SysBusDevice parent;
> -    /*< public >*/
> -
> -    MemoryRegion ccsr_space;
> -} PPCE500CCSRState;
> -
> -#define TYPE_CCSR "e500-ccsr"
> -#define CCSR(obj) OBJECT_CHECK(PPCE500CCSRState, (obj), TYPE_CCSR)
> -
> -#endif /* E500_CCSR_H */
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 9e7e1b29c4..474a46a985 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -15,10 +15,10 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
>  #include "e500.h"
> -#include "e500-ccsr.h"
>  #include "net/net.h"
>  #include "qemu/config-file.h"
>  #include "hw/hw.h"
> @@ -795,7 +795,6 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>      CPUPPCState *firstenv =3D NULL;
>      MemoryRegion *ccsr_addr_space;
>      SysBusDevice *s;
> -    PPCE500CCSRState *ccsr;
> =20
>      irqs =3D g_malloc0(smp_cpus * sizeof(qemu_irq *));
>      irqs[0] =3D g_malloc0(smp_cpus * sizeof(qemu_irq) * OPENPIC_OUTPUT_N=
B);
> @@ -854,11 +853,9 @@ void ppce500_init(MachineState *machine, PPCE500Para=
ms *params)
>      dev =3D qdev_create(NULL, "e500-ccsr");
>      object_property_add_child(qdev_get_machine(), "e500-ccsr",
>                                OBJECT(dev), NULL);
> +    qdev_prop_set_uint32(dev, "base", params->ccsrbar_base);
>      qdev_init_nofail(dev);
> -    ccsr =3D CCSR(dev);
> -    ccsr_addr_space =3D &ccsr->ccsr_space;
> -    memory_region_add_subregion(address_space_mem, params->ccsrbar_base,
> -                                ccsr_addr_space);
> +    ccsr_addr_space =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> =20
>      mpicdev =3D ppce500_init_mpic(machine, params, ccsr_addr_space, irqs=
);
> =20
> @@ -875,13 +872,6 @@ void ppce500_init(MachineState *machine, PPCE500Para=
ms *params)
>                         serial_hds[1], DEVICE_BIG_ENDIAN);
>      }
> =20
> -    /* General Utility device */
> -    dev =3D qdev_create(NULL, "mpc8544-guts");
> -    qdev_init_nofail(dev);
> -    s =3D SYS_BUS_DEVICE(dev);
> -    memory_region_add_subregion(ccsr_addr_space, MPC8544_UTIL_OFFSET,
> -                                sysbus_mmio_get_region(s, 0));
> -
>      /* PCI */
>      dev =3D qdev_create(NULL, "e500-pcihost");
>      qdev_prop_set_uint32(dev, "first_slot", params->pci_first_slot);
> @@ -1039,24 +1029,3 @@ void ppce500_init(MachineState *machine, PPCE500Pa=
rams *params)
>      boot_info->dt_base =3D dt_base;
>      boot_info->dt_size =3D dt_size;
>  }
> -
> -static void e500_ccsr_initfn(Object *obj)
> -{
> -    PPCE500CCSRState *ccsr =3D CCSR(obj);
> -    memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
> -                       MPC8544_CCSRBAR_SIZE);
> -}
> -
> -static const TypeInfo e500_ccsr_info =3D {
> -    .name          =3D TYPE_CCSR,
> -    .parent        =3D TYPE_SYS_BUS_DEVICE,
> -    .instance_size =3D sizeof(PPCE500CCSRState),
> -    .instance_init =3D e500_ccsr_initfn,
> -};
> -
> -static void e500_register_types(void)
> -{
> -    type_register_static(&e500_ccsr_info);
> -}
> -
> -type_init(e500_register_types)
> diff --git a/hw/ppc/e500_ccsr.c b/hw/ppc/e500_ccsr.c
> new file mode 100644
> index 0000000000..1b586c3f42
> --- /dev/null
> +++ b/hw/ppc/e500_ccsr.c
> @@ -0,0 +1,152 @@
> +/*
> + * MPC8540 and MPC8544 specific control registers.
> + * Not really part of e500 spec, but common to many
> + * Freescale parts w/ e500 cores.
> + *
> + * Copyright (c) 2017 Michael Davidsaver
> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All rights reserved.
> + *
> + * Authors: Alexander Graf, <alex@csgraf.de>
> + *          Michael Davidsaver <mdavidsaver@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the LICENSE file in the top-level directory.
> + *
> + * This model was developed according to:
> + *
> + * MPC8544E PowerQUICC III Integrated Host Processor Family Reference Ma=
nual
> + * Rev. 1
> + *
> + * MPC8540 PowerQUICC III Integrated Host Processor Reference Manual, Re=
v. 1
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "cpu.h"
> +#include "hw/hw.h"
> +#include "sysemu/sysemu.h"
> +#include "hw/sysbus.h"
> +
> +/* E500_ denotes registers common to all */
> +
> +#define E500_PVR         (0xE00A0)
> +#define E500_SVR         (0xE00A4)
> +
> +#define MPC8544_RSTCR       (0xE00B0)
> +#define MPC8544_RSTCR_RESET      (0x02)
> +
> +typedef struct {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    MemoryRegion iomem;
> +
> +    uint32_t defbase;
> +} CCSRState;
> +
> +#define TYPE_E500_CCSR "e500-ccsr"
> +#define E500_CCSR(obj) OBJECT_CHECK(CCSRState, (obj), TYPE_E500_CCSR)
> +
> +static uint64_t e500_ccsr_read(void *opaque, hwaddr addr,
> +                                  unsigned size)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    switch (addr) {
> +    case E500_PVR:
> +        return env->spr[SPR_PVR];
> +    case E500_SVR:
> +        return env->spr[SPR_E500_SVR];
> +    }
> +
> +    qemu_log_mask(LOG_GUEST_ERROR | LOG_UNIMP,
> +                  "can't read undefined ccsr regster %x\n",
> +                  (unsigned)addr);
> +    return 0;
> +}
> +
> +static void e500_ccsr_write(void *opaque, hwaddr addr,
> +                               uint64_t value, unsigned size)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> +    CPUPPCState *env =3D &cpu->env;
> +    uint32_t svr =3D env->spr[SPR_E500_SVR] >> 16;
> +
> +    switch (svr) {
> +    case 0: /* generic.  assumed to be mpc8544ds or e500plat board */
> +    case 0x8034: /* mpc8544 */
> +    case 0x803C: /* mpc8544E */
> +        switch (addr) {
> +        case MPC8544_RSTCR:
> +            if (value & MPC8544_RSTCR_RESET) {
> +                qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +            }
> +            return;
> +        }
> +    }
> +
> +    qemu_log_mask(LOG_GUEST_ERROR | LOG_UNIMP,
> +                  "can't write undefined ccsr regster %x <- %08x\n",
> +                  (unsigned)addr, (unsigned)value);
> +}
> +
> +static const MemoryRegionOps e500_ccsr_ops =3D {
> +    .read =3D e500_ccsr_read,
> +    .write =3D e500_ccsr_write,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    }
> +};
> +
> +static void e500_ccsr_reset(DeviceState *dev)
> +{
> +    CCSRState *ccsr =3D E500_CCSR(dev);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ccsr->defbase);
> +}
> +
> +static void e500_ccsr_initfn(Object *obj)
> +{
> +    CCSRState *ccsr =3D E500_CCSR(obj);
> +
> +    memory_region_init_io(&ccsr->iomem, obj, &e500_ccsr_ops,
> +                          ccsr, "e500-ccsr", 1024 * 1024);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &ccsr->iomem);
> +
> +}
> +
> +static Property e500_ccsr_props[] =3D {
> +    DEFINE_PROP_UINT32("base", CCSRState, defbase, 0xff700000),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
> +static
> +void e500_ccsr_class_initfn(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->props =3D e500_ccsr_props;
> +    dc->reset =3D e500_ccsr_reset;
> +}
> +
> +static const TypeInfo e500_ccsr_info =3D {
> +    .name          =3D TYPE_E500_CCSR,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(CCSRState),
> +    .instance_init =3D e500_ccsr_initfn,
> +    .class_size    =3D sizeof(SysBusDeviceClass),
> +    .class_init    =3D e500_ccsr_class_initfn
> +};
> +
> +static void e500_ccsr_register_types(void)
> +{
> +    type_register_static(&e500_ccsr_info);
> +}
> +
> +type_init(e500_ccsr_register_types)
> diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
> deleted file mode 100644
> index ce1254b5d4..0000000000
> --- a/hw/ppc/mpc8544_guts.c
> +++ /dev/null
> @@ -1,143 +0,0 @@
> -/*
> - * QEMU PowerPC MPC8544 global util pseudo-device
> - *
> - * Copyright (C) 2011 Freescale Semiconductor, Inc. All rights reserved.
> - *
> - * Author: Alexander Graf, <alex@csgraf.de>
> - *
> - * This is free software; you can redistribute it and/or modify
> - * it under the terms of  the GNU General  Public License as published by
> - * the Free Software Foundation;  either version 2 of the  License, or
> - * (at your option) any later version.
> - *
> - * *****************************************************************
> - *
> - * The documentation for this device is noted in the MPC8544 documentati=
on,
> - * file name "MPC8544ERM.pdf". You can easily find it on the web.
> - *
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qemu-common.h"
> -#include "cpu.h"
> -#include "hw/hw.h"
> -#include "sysemu/sysemu.h"
> -#include "hw/sysbus.h"
> -
> -#define MPC8544_GUTS_MMIO_SIZE        0x1000
> -#define MPC8544_GUTS_RSTCR_RESET      0x02
> -
> -#define MPC8544_GUTS_ADDR_PORPLLSR    0x00
> -#define MPC8544_GUTS_ADDR_PORBMSR     0x04
> -#define MPC8544_GUTS_ADDR_PORIMPSCR   0x08
> -#define MPC8544_GUTS_ADDR_PORDEVSR    0x0C
> -#define MPC8544_GUTS_ADDR_PORDBGMSR   0x10
> -#define MPC8544_GUTS_ADDR_PORDEVSR2   0x14
> -#define MPC8544_GUTS_ADDR_GPPORCR     0x20
> -#define MPC8544_GUTS_ADDR_GPIOCR      0x30
> -#define MPC8544_GUTS_ADDR_GPOUTDR     0x40
> -#define MPC8544_GUTS_ADDR_GPINDR      0x50
> -#define MPC8544_GUTS_ADDR_PMUXCR      0x60
> -#define MPC8544_GUTS_ADDR_DEVDISR     0x70
> -#define MPC8544_GUTS_ADDR_POWMGTCSR   0x80
> -#define MPC8544_GUTS_ADDR_MCPSUMR     0x90
> -#define MPC8544_GUTS_ADDR_RSTRSCR     0x94
> -#define MPC8544_GUTS_ADDR_PVR         0xA0
> -#define MPC8544_GUTS_ADDR_SVR         0xA4
> -#define MPC8544_GUTS_ADDR_RSTCR       0xB0
> -#define MPC8544_GUTS_ADDR_IOVSELSR    0xC0
> -#define MPC8544_GUTS_ADDR_DDRCSR      0xB20
> -#define MPC8544_GUTS_ADDR_DDRCDR      0xB24
> -#define MPC8544_GUTS_ADDR_DDRCLKDR    0xB28
> -#define MPC8544_GUTS_ADDR_CLKOCR      0xE00
> -#define MPC8544_GUTS_ADDR_SRDS1CR1    0xF04
> -#define MPC8544_GUTS_ADDR_SRDS2CR1    0xF10
> -#define MPC8544_GUTS_ADDR_SRDS2CR3    0xF18
> -
> -#define TYPE_MPC8544_GUTS "mpc8544-guts"
> -#define MPC8544_GUTS(obj) OBJECT_CHECK(GutsState, (obj), TYPE_MPC8544_GU=
TS)
> -
> -struct GutsState {
> -    /*< private >*/
> -    SysBusDevice parent_obj;
> -    /*< public >*/
> -
> -    MemoryRegion iomem;
> -};
> -
> -typedef struct GutsState GutsState;
> -
> -static uint64_t mpc8544_guts_read(void *opaque, hwaddr addr,
> -                                  unsigned size)
> -{
> -    uint32_t value =3D 0;
> -    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> -    CPUPPCState *env =3D &cpu->env;
> -
> -    addr &=3D MPC8544_GUTS_MMIO_SIZE - 1;
> -    switch (addr) {
> -    case MPC8544_GUTS_ADDR_PVR:
> -        value =3D env->spr[SPR_PVR];
> -        break;
> -    case MPC8544_GUTS_ADDR_SVR:
> -        value =3D env->spr[SPR_E500_SVR];
> -        break;
> -    default:
> -        fprintf(stderr, "guts: Unknown register read: %x\n", (int)addr);
> -        break;
> -    }
> -
> -    return value;
> -}
> -
> -static void mpc8544_guts_write(void *opaque, hwaddr addr,
> -                               uint64_t value, unsigned size)
> -{
> -    addr &=3D MPC8544_GUTS_MMIO_SIZE - 1;
> -
> -    switch (addr) {
> -    case MPC8544_GUTS_ADDR_RSTCR:
> -        if (value & MPC8544_GUTS_RSTCR_RESET) {
> -            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> -        }
> -        break;
> -    default:
> -        fprintf(stderr, "guts: Unknown register write: %x =3D %x\n",
> -                (int)addr, (unsigned)value);
> -        break;
> -    }
> -}
> -
> -static const MemoryRegionOps mpc8544_guts_ops =3D {
> -    .read =3D mpc8544_guts_read,
> -    .write =3D mpc8544_guts_write,
> -    .endianness =3D DEVICE_BIG_ENDIAN,
> -    .valid =3D {
> -        .min_access_size =3D 4,
> -        .max_access_size =3D 4,
> -    },
> -};
> -
> -static void mpc8544_guts_initfn(Object *obj)
> -{
> -    SysBusDevice *d =3D SYS_BUS_DEVICE(obj);
> -    GutsState *s =3D MPC8544_GUTS(obj);
> -
> -    memory_region_init_io(&s->iomem, OBJECT(s), &mpc8544_guts_ops, s,
> -                          "mpc8544.guts", MPC8544_GUTS_MMIO_SIZE);
> -    sysbus_init_mmio(d, &s->iomem);
> -}
> -
> -static const TypeInfo mpc8544_guts_info =3D {
> -    .name          =3D TYPE_MPC8544_GUTS,
> -    .parent        =3D TYPE_SYS_BUS_DEVICE,
> -    .instance_size =3D sizeof(GutsState),
> -    .instance_init =3D mpc8544_guts_initfn,
> -};
> -
> -static void mpc8544_guts_register_types(void)
> -{
> -    type_register_static(&mpc8544_guts_info);
> -}
> -
> -type_init(mpc8544_guts_register_types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/Gk0KcsbyUMelFU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloU8MsACgkQbDjKyiDZ
s5IX+Q//SO4mHpw3hhJaUz8Qsw3Jb7WzEhEEetIaLgyTOWKq4CLz73j6uE+qyPLx
hJl/072PjhxTzVbGsprY5BArVED4wCxt/NZa5QU+G55KkbkhJpmJCx/cSFWg/iWU
DzqMksKQGME7NtVXocIqEo1I5UHzu1iGRTT25Uk25qF7goKvDCUc7honXFC9Jg3M
GgTZ1fWxCnoIOrYJJDArrLrtxuJr7tVM7hTiJiqIgOXP0zXo+MAX0AEo5RGM8/eg
216KRVYWE6AqIS3VfvDM58JRyaV8Hwwz0GWksGj2Luu8oUONNO2/zYh7ZXuutbgd
BuIE9jdPNaobczoJckY0V+6G06x0hoKbEuSO+rmFRXmMyY82id63+gz1FJzrelXn
oQNUJlLts5GpvITdQVCvOeax471DFydPK2CNCQbz17AgGKufJRdIOGlPMtPtErKZ
KkwZdjC+pJx4VGuUWIpysnr4F/v6EF3PMAACuwWuAq2zikrUUG9P7S7lR65AEIjy
icBGqeGkd7zSHutoAu5lHqtoIe3qkAPaZ1PFly84butNmj931ATCYIjUaeV+sCOj
Vj4VPjWklMOZMOxLWGAI25SkDa/XgFKXqyERyXaCxexzBP1RDIPzsbclEeggdPbZ
fheh596AKuUCMwgBDREbydDuXXO+vLjvGSoDfQpVPaYPUl8MT38=
=rGWb
-----END PGP SIGNATURE-----

--/Gk0KcsbyUMelFU1--
