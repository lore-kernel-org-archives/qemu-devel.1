Received: from eggs.gnu.org ([2001:4830:134:3::10]:39307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fhdK3-0002Wk-Qu
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fhdJy-0003jY-Qt
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:04:31 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:54860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fhdJy-0003ic-EG
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:04:26 -0400
Received: from player794.ha.ovh.net (unknown [10.109.159.73])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 7B0F2141545
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 18:04:24 +0200 (CEST)
References: <20180706090713.15712-1-clg@kaod.org>
	<20180706090713.15712-2-clg@kaod.org>
	<20180720021850.GE18205@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <771a55a5-d719-a8ca-1b78-13e363e11eaa@kaod.org>
Date: Mon, 23 Jul 2018 18:04:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180720021850.GE18205@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/3] spapr: introduce a fixed IRQ number
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On 07/20/2018 04:18 AM, David Gibson wrote:
> On Fri, Jul 06, 2018 at 11:07:11AM +0200, C=E9dric Le Goater wrote:
>> This proposal introduces a new IRQ number space layout using static
>> numbers for all devices, depending on a device index, and a bitmap
>> allocator for the MSI IRQ numbers which are negotiated by the guest at
>> runtime.
>>
>> As the VIO device model does not have a device index but a "reg"
>> property, we introduce a formula to compute an IRQ number from a "reg"
>> value. It should minimize most of the collisions.
>>
>> The previous layout is kept in pre-3.0 machines raising the
>> 'legacy_irq_allocation' machine class flag.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  The new XICS layout will only be activated when a new pseries-3.1
>>  machine is introduced.
>=20
> Looking good.  I've noted a few nits below, but they're very minor -
> I wouldn't even bother to ask for the changes if we didn't have to
> wait for 3.1 anyway.

Yes. np. I have taken into account the nits. We just need to agree
on a reg_to_irq formula now.

Thanks,

C.=20


>=20
>=20
>>
>>  include/hw/ppc/spapr.h     |  5 ++++
>>  include/hw/ppc/spapr_irq.h | 32 ++++++++++++++++++++++
>>  hw/ppc/spapr.c             | 32 +++++++++++++++++++++-
>>  hw/ppc/spapr_events.c      | 12 ++++++--
>>  hw/ppc/spapr_irq.c         | 56 +++++++++++++++++++++++++++++++++++++=
+
>>  hw/ppc/spapr_pci.c         | 29 ++++++++++++++++----
>>  hw/ppc/spapr_vio.c         | 47 ++++++++++++++++++++++++++++----
>>  hw/ppc/Makefile.objs       |  2 +-
>>  8 files changed, 199 insertions(+), 16 deletions(-)
>>  create mode 100644 include/hw/ppc/spapr_irq.h
>>  create mode 100644 hw/ppc/spapr_irq.c
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 7e5de1a6fd42..73067f5ee8aa 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -8,6 +8,7 @@
>>  #include "hw/ppc/spapr_drc.h"
>>  #include "hw/mem/pc-dimm.h"
>>  #include "hw/ppc/spapr_ovec.h"
>> +#include "hw/ppc/spapr_irq.h"
>> =20
>>  struct VIOsPAPRBus;
>>  struct sPAPRPHBState;
>> @@ -101,6 +102,8 @@ struct sPAPRMachineClass {
>>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of =
LMBs */
>>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
>>      bool pre_2_10_has_unused_icps;
>> +    bool legacy_irq_allocation;
>> +
>>      void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
>>                            uint64_t *buid, hwaddr *pio,=20
>>                            hwaddr *mmio32, hwaddr *mmio64,
>> @@ -167,6 +170,8 @@ struct sPAPRMachineState {
>>      char *kvm_type;
>> =20
>>      const char *icp_type;
>> +    int32_t irq_map_nr;
>> +    unsigned long *irq_map;
>> =20
>>      bool cmd_line_caps[SPAPR_CAP_NUM];
>>      sPAPRCapabilities def, eff, mig;
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> new file mode 100644
>> index 000000000000..6f7f50548809
>> --- /dev/null
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -0,0 +1,32 @@
>> +/*
>> + * QEMU PowerPC sPAPR IRQ backend definitions
>> + *
>> + * Copyright (c) 2018, IBM Corporation.
>> + *
>> + * This code is licensed under the GPL version 2 or later. See the
>> + * COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef HW_SPAPR_IRQ_H
>> +#define HW_SPAPR_IRQ_H
>> +
>> +/*
>> + * IRQ range offsets per device type
>> + */
>> +#define SPAPR_IRQ_EPOW       0x1000  /* XICS_IRQ_BASE offset */
>> +#define SPAPR_IRQ_HOTPLUG    0x1001
>> +#define SPAPR_IRQ_VIO        0x1100  /* 256 VIO devices */
>> +#define SPAPR_IRQ_PCI_LSI    0x1200  /* 32+ PHBs devices */
>> +
>> +#define SPAPR_IRQ_MSI        0x1300  /* Offset of the dynamic range c=
overed
>> +                                      * by the bitmap allocator */
>> +
>> +typedef struct sPAPRMachineState sPAPRMachineState;
>> +
>> +void spapr_irq_msi_init(sPAPRMachineState *spapr, uint32_t nr_msis);
>> +int spapr_irq_msi_alloc(sPAPRMachineState *spapr, uint32_t num, bool =
align,
>> +                        Error **errp);
>> +void spapr_irq_msi_free(sPAPRMachineState *spapr, int irq, uint32_t n=
um);
>> +void spapr_irq_msi_reset(sPAPRMachineState *spapr);
>> +
>> +#endif
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 3f5e1d3ec21a..7bc9a48abf04 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -189,6 +189,11 @@ static void xics_system_init(MachineState *machin=
e, int nr_irqs, Error **errp)
>>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
>>      Error *local_err =3D NULL;
>> =20
>> +    /* Initialize the MSI IRQ allocator. */
>> +    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
>> +        spapr_irq_msi_init(spapr, XICS_IRQ_BASE + nr_irqs - SPAPR_IRQ=
_MSI);
>> +    }
>> +
>>      if (kvm_enabled()) {
>>          if (machine_kernel_irqchip_allowed(machine) &&
>>              !xics_kvm_init(spapr, &local_err)) {
>> @@ -1636,6 +1641,10 @@ static void spapr_machine_reset(void)
>>          ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_f=
atal);
>>      }
>> =20
>> +    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
>> +        spapr_irq_msi_reset(spapr);
>> +    }
>> +
>>      qemu_devices_reset();
>> =20
>>      /* DRC reset may cause a device to be unplugged. This will cause =
troubles
>> @@ -1910,6 +1919,24 @@ static const VMStateDescription vmstate_spapr_p=
atb_entry =3D {
>>      },
>>  };
>> =20
>> +static bool spapr_irq_map_needed(void *opaque)
>> +{
>> +    sPAPRMachineState *spapr =3D opaque;
>> +
>> +    return spapr->irq_map && !bitmap_empty(spapr->irq_map, spapr->irq=
_map_nr);
>> +}
>> +
>> +static const VMStateDescription vmstate_spapr_irq_map =3D {
>> +    .name =3D "spapr_irq_map",
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 1,
>> +    .needed =3D spapr_irq_map_needed,
>> +    .fields =3D (VMStateField[]) {
>> +        VMSTATE_BITMAP(irq_map, sPAPRMachineState, 0, irq_map_nr),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>>  static const VMStateDescription vmstate_spapr =3D {
>>      .name =3D "spapr",
>>      .version_id =3D 3,
>> @@ -1937,6 +1964,7 @@ static const VMStateDescription vmstate_spapr =3D=
 {
>>          &vmstate_spapr_cap_cfpc,
>>          &vmstate_spapr_cap_sbbc,
>>          &vmstate_spapr_cap_ibs,
>> +        &vmstate_spapr_irq_map,
>>          NULL
>>      }
>>  };
>> @@ -4067,7 +4095,9 @@ static void spapr_machine_3_0_instance_options(M=
achineState *machine)
>> =20
>>  static void spapr_machine_3_0_class_options(MachineClass *mc)
>>  {
>> -    /* Defaults for the latest behaviour inherited from the base clas=
s */
>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
>> +
>> +    smc->legacy_irq_allocation =3D true;
>>  }
>> =20
>>  DEFINE_SPAPR_MACHINE(3_0, "3.0", true);
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index e4f5946a2188..cab950d33446 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -709,7 +709,11 @@ void spapr_events_init(sPAPRMachineState *spapr)
>>  {
>>      int epow_irq;
>> =20
>> -    epow_irq =3D spapr_irq_findone(spapr, &error_fatal);
>> +    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
>> +        epow_irq =3D spapr_irq_findone(spapr, &error_fatal);
>> +    } else {
>> +        epow_irq =3D SPAPR_IRQ_EPOW;
>> +    }
>=20
> Nit: these can be rearranged more briefly by initializing to the fixed
> value, then overriding in the legacy case.
>=20
>> =20
>>      spapr_irq_claim(spapr, epow_irq, false, &error_fatal);
>> =20
>> @@ -731,7 +735,11 @@ void spapr_events_init(sPAPRMachineState *spapr)
>>      if (spapr->use_hotplug_event_source) {
>>          int hp_irq;
>> =20
>> -        hp_irq =3D spapr_irq_findone(spapr, &error_fatal);
>> +        if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
>> +            hp_irq =3D spapr_irq_findone(spapr, &error_fatal);
>> +        } else {
>> +            hp_irq =3D SPAPR_IRQ_HOTPLUG;
>> +        }
>=20
> Here too.
>=20
>>          spapr_irq_claim(spapr, hp_irq, false, &error_fatal);
>> =20
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> new file mode 100644
>> index 000000000000..24e9c1d4433c
>> --- /dev/null
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -0,0 +1,56 @@
>> +/*
>> + * QEMU PowerPC sPAPR IRQ interface
>> + *
>> + * Copyright (c) 2018, IBM Corporation.
>> + *
>> + * This code is licensed under the GPL version 2 or later. See the
>> + * COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "qemu/error-report.h"
>> +#include "qapi/error.h"
>> +#include "hw/ppc/spapr.h"
>> +#include "hw/ppc/xics.h"
>> +
>> +void spapr_irq_msi_init(sPAPRMachineState *spapr, uint32_t nr_msis)
>> +{
>> +    spapr->irq_map_nr =3D nr_msis;
>> +    spapr->irq_map =3D bitmap_new(spapr->irq_map_nr);
>> +}
>> +
>> +int spapr_irq_msi_alloc(sPAPRMachineState *spapr, uint32_t num, bool =
align,
>> +                        Error **errp)
>> +{
>> +    int irq;
>> +
>> +    /*
>> +     * The 'align_mask' parameter of bitmap_find_next_zero_area()
>> +     * should be one less than a power of 2; 0 means no
>> +     * alignment. Adapt the 'align' value of the former allocator
>> +     * to fit the requirements of bitmap_find_next_zero_area()
>> +     */
>> +    align -=3D 1;
>> +
>> +    irq =3D bitmap_find_next_zero_area(spapr->irq_map, spapr->irq_map=
_nr, 0, num,
>> +                                     align);
>> +    if (irq =3D=3D spapr->irq_map_nr) {
>> +        error_setg(errp, "can't find a free %d-IRQ block", num);
>> +        return -1;
>> +    }
>> +
>> +    bitmap_set(spapr->irq_map, irq, num);
>> +
>> +    return irq + SPAPR_IRQ_MSI;
>> +}
>> +
>> +void spapr_irq_msi_free(sPAPRMachineState *spapr, int irq, uint32_t n=
um)
>> +{
>> +    bitmap_clear(spapr->irq_map, irq - SPAPR_IRQ_MSI, num);
>> +}
>> +
>> +void spapr_irq_msi_reset(sPAPRMachineState *spapr)
>> +{
>> +    bitmap_clear(spapr->irq_map, 0, spapr->irq_map_nr);
>> +}
>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index 497b896c7d24..cba5340f4bad 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -334,6 +334,9 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, s=
PAPRMachineState *spapr,
>>              return;
>>          }
>> =20
>> +        if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
>> +            spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
>> +        }
>>          spapr_irq_free(spapr, msi->first_irq, msi->num);
>>          if (msi_present(pdev)) {
>>              spapr_msi_setmsg(pdev, 0, false, 0, 0);
>> @@ -372,7 +375,13 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, =
sPAPRMachineState *spapr,
>>      }
>> =20
>>      /* Allocate MSIs */
>> -    irq =3D spapr_irq_find(spapr, req_num, ret_intr_type =3D=3D RTAS_=
TYPE_MSI, &err);
>> +    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
>> +        irq =3D spapr_irq_find(spapr, req_num, ret_intr_type =3D=3D R=
TAS_TYPE_MSI,
>> +                             &err);
>> +    } else {
>> +        irq =3D spapr_irq_msi_alloc(spapr, req_num,
>> +                                  ret_intr_type =3D=3D RTAS_TYPE_MSI,=
 &err);
>> +    }
>>      if (err) {
>>          error_reportf_err(err, "Can't allocate MSIs for device %x: ",
>>                            config_addr);
>> @@ -392,6 +401,9 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, s=
PAPRMachineState *spapr,
>> =20
>>      /* Release previous MSIs */
>>      if (msi) {
>> +        if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
>> +            spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
>> +        }
>>          spapr_irq_free(spapr, msi->first_irq, msi->num);
>>          g_hash_table_remove(phb->msi, &config_addr);
>>      }
>> @@ -1708,11 +1720,15 @@ static void spapr_phb_realize(DeviceState *dev=
, Error **errp)
>>          uint32_t irq;
>>          Error *local_err =3D NULL;
>> =20
>> -        irq =3D spapr_irq_findone(spapr, &local_err);
>> -        if (local_err) {
>> -            error_propagate(errp, local_err);
>> -            error_prepend(errp, "can't allocate LSIs: ");
>> -            return;
>> +        if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
>> +            irq =3D spapr_irq_findone(spapr, &local_err);
>> +            if (local_err) {
>> +                error_propagate(errp, local_err);
>> +                error_prepend(errp, "can't allocate LSIs: ");
>> +                return;
>> +            }
>> +        } else {
>> +            irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + =
i;
>=20
> Here again, you can use the new fixed value as the default.
>=20
>>          }
>> =20
>>          spapr_irq_claim(spapr, irq, true, &local_err);
>> @@ -2123,6 +2139,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
>>      _FDT(fdt_setprop(fdt, bus_off, "ranges", &ranges, sizeof_ranges))=
;
>>      _FDT(fdt_setprop(fdt, bus_off, "reg", &bus_reg, sizeof(bus_reg)))=
;
>>      _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pci-config-space-type", =
0x1));
>> +    /* TODO: fine tune the total count of allocatable MSIs per PHB */
>>      _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", XICS_IRQ=
S_SPAPR));
>> =20
>>      /* Dynamic DMA window */
>> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
>> index be9af71437cc..a0695200f348 100644
>> --- a/hw/ppc/spapr_vio.c
>> +++ b/hw/ppc/spapr_vio.c
>> @@ -37,12 +37,13 @@
>> =20
>>  #include "hw/ppc/spapr.h"
>>  #include "hw/ppc/spapr_vio.h"
>> -#include "hw/ppc/xics.h"
>>  #include "hw/ppc/fdt.h"
>>  #include "trace.h"
>> =20
>>  #include <libfdt.h>
>> =20
>> +#define SPAPR_VIO_REG_BASE 0x71000000
>> +
>>  static void spapr_vio_get_irq(Object *obj, Visitor *v, const char *na=
me,
>>                                void *opaque, Error **errp)
>>  {
>> @@ -445,6 +446,32 @@ static void spapr_vio_busdev_reset(DeviceState *q=
dev)
>>      }
>>  }
>> =20
>> +/*
>> + * The register property of a VIO device is defined in livirt using a
>> + * base number + 0x1000 increment and in QEMU by incrementing the bas=
e
>> + * register number 0x71000000.
>> + *
>> + * The formula below tries to compute a unique index number from the
>> + * register value that will be used to define the IRQ number of the
>> + * VIO device. A maximum of 256 (0x100) VIO devices is covered.
>> + *
>> + * To minimize collisions, we define two distinct ranges depending on
>> + * the "reg" value definition:
>> + *
>> + *     [0x00 - 0x7f]    user/libvirt
>> + *     [0x80 - 0xff]    QEMU VIO model
>> + *
>> + * Collisions will be detected when the IRQ is claimed.
>> + */
>> +static inline uint32_t spapr_vio_reg_to_irq(uint32_t reg)
>> +{
>> +    if (reg >=3D SPAPR_VIO_REG_BASE) {
>> +        return SPAPR_IRQ_VIO | (reg & 0x7f) | 0x80;
>> +    } else {
>> +        return SPAPR_IRQ_VIO | ((reg & 0x7f) ^ ((reg >> 12) & 0x7f));
>> +    }
>> +}
>> +
>>  static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
>>  {
>>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>> @@ -485,10 +512,18 @@ static void spapr_vio_busdev_realize(DeviceState=
 *qdev, Error **errp)
>>      }
>> =20
>>      if (!dev->irq) {
>> -        dev->irq =3D spapr_irq_findone(spapr, &local_err);
>> -        if (local_err) {
>> -            error_propagate(errp, local_err);
>> -            return;
>> +        if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
>> +            dev->irq =3D spapr_irq_findone(spapr, &local_err);
>> +            if (local_err) {
>> +                error_propagate(errp, local_err);
>> +                return;
>> +            }
>> +        } else {
>> +            dev->irq =3D spapr_vio_reg_to_irq(dev->reg);
>> +            if (dev->irq =3D=3D SPAPR_IRQ_PCI_LSI) {
>> +                error_setg(errp, "Too many VIO devices");
>> +                return;
>> +            }
>>          }
>>      }
>> =20
>> @@ -557,7 +592,7 @@ VIOsPAPRBus *spapr_vio_bus_init(void)
>>      /* Create bus on bridge device */
>>      qbus =3D qbus_create(TYPE_SPAPR_VIO_BUS, dev, "spapr-vio");
>>      bus =3D SPAPR_VIO_BUS(qbus);
>> -    bus->next_reg =3D 0x71000000;
>> +    bus->next_reg =3D SPAPR_VIO_REG_BASE;
>> =20
>>      /* hcall-vio */
>>      spapr_register_hypercall(H_VIO_SIGNAL, h_vio_signal);
>> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
>> index bcab6323b7ed..4ab556467289 100644
>> --- a/hw/ppc/Makefile.objs
>> +++ b/hw/ppc/Makefile.objs
>> @@ -4,7 +4,7 @@ obj-y +=3D ppc.o ppc_booke.o fdt.o
>>  obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio.o spapr_eve=
nts.o
>>  obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o
>>  obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o spapr_=
rng.o
>> -obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o
>> +obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
>>  # IBM PowerNV
>>  obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv=
_psi.o pnv_occ.o pnv_bmc.o
>>  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
>=20
