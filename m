Received: from eggs.gnu.org ([2001:4830:134:3::10]:54126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fV8kp-00066s-MJ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fV8km-0002hf-IK
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:00:31 -0400
Received: from 8.mo6.mail-out.ovh.net ([178.33.42.204]:54368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fV8kl-0002fH-Rh
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:00:28 -0400
Received: from player158.ha.ovh.net (unknown [10.109.108.5])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 029D2164E1B
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 07:00:25 +0200 (CEST)
References: <20180618173402.23405-1-clg@kaod.org>
	<20180618173402.23405-4-clg@kaod.org>
	<20180619010244.GN25461@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2f26dfab-5aca-8a61-ed83-fc56145d5bc3@kaod.org>
Date: Tue, 19 Jun 2018 07:00:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180619010244.GN25461@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] spapr: introduce a fixed IRQ number
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 06/19/2018 03:02 AM, David Gibson wrote:
> On Mon, Jun 18, 2018 at 07:34:02PM +0200, C=E9dric Le Goater wrote:
>> This proposal introduces a new IRQ number space layout using static
>> numbers for all devices and a bitmap allocator for the MSI numbers
>> which are negotiated by the guest at runtime.
>>
>> The previous layout is kept in machines raising the 'xics_legacy'
>> flag.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr.h     |  4 ++++
>>  include/hw/ppc/spapr_irq.h | 30 +++++++++++++++++++++++++
>>  hw/ppc/spapr.c             | 31 +++++++++++++++++++++++++
>>  hw/ppc/spapr_events.c      | 12 ++++++++--
>>  hw/ppc/spapr_irq.c         | 56 +++++++++++++++++++++++++++++++++++++=
+++++++++
>>  hw/ppc/spapr_pci.c         | 28 ++++++++++++++++++-----
>>  hw/ppc/spapr_vio.c         | 19 ++++++++++++----
>>  hw/ppc/Makefile.objs       |  2 +-
>>  8 files changed, 169 insertions(+), 13 deletions(-)
>>  create mode 100644 include/hw/ppc/spapr_irq.h
>>  create mode 100644 hw/ppc/spapr_irq.c
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 9decc66a1915..4c63b1fac13b 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -7,6 +7,7 @@
>>  #include "hw/ppc/spapr_drc.h"
>>  #include "hw/mem/pc-dimm.h"
>>  #include "hw/ppc/spapr_ovec.h"
>> +#include "hw/ppc/spapr_irq.h"
>> =20
>>  struct VIOsPAPRBus;
>>  struct sPAPRPHBState;
>> @@ -164,6 +165,9 @@ struct sPAPRMachineState {
>>      char *kvm_type;
>> =20
>>      const char *icp_type;
>> +    bool xics_legacy;
>=20
> This flag can go in the class, rather than the instance.
>=20
> And maybe call it 'legacy_irq_allocation'.  It assumes XICS, but
> otherwise isn't strongly tied to it.

OK.

>> +    int32_t irq_map_nr;
>> +    unsigned long *irq_map;
>=20
> So, I don't love the fact that the new bitmap duplicates information
> that's also in the intc backend (e.g. via ICS_IRQ_FREE()). =20

Yes. I agree. new devices using MSI like interrupts will follow the
same pattern for allocation.=20

we have two layers of IRQ routines, one for the IRQ numbers and one=20
for the controller backend. May be we could call the backend handling=20
routing from the msi one ?=20

> However
> leaving the authoritative info in the backend also causes problems
> when we have dynamic switching.  Not entirely sure what to do about
> that.

yes, if we put it in the IRQ backend (the current IRQ controller model
in use) we will have to synchronize the number spaces when the machine=20
switches interrupt mode.=20
=20
>>      bool cmd_line_caps[SPAPR_CAP_NUM];
>>      sPAPRCapabilities def, eff, mig;
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> new file mode 100644
>> index 000000000000..345a42efd366
>> --- /dev/null
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -0,0 +1,30 @@
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
>=20
> I'm a little confused by the MSI stuff.  It looks like you're going
> for the option of one big pool for all dynamic irqs.  Except that I
> thought in our discussion the other day you said each PHB advertised
> its own separate MSI range, so we'd actually need to split this up
> into ranges for each PHB.

Yes we can also, but we don't really need to and it might be too much
constrained in fact.

As the IRQs are allocated dynamically, there is not a strong relation=20
between the device doing so and the IRQ numbers. The need for a well
defined IRQ number range is weak. We should provision a certain number=20
of IRQs of course to size our IRQ number space but even that could be=20
done dynamically. We can resize the bitmap and allocate new source=20
blocks under the KVM XICS/XIVE device if needed. The resulting code=20
is quite simple and the IRQ number space is also less fragmented.=20

I think we have all the requirements in hand, the current ones and the=20
new ones for hotplug PHBs, XIVE interrupt model, CAPI (which should be
like the PHBs), XIVE user IRQs (like MSIs). The new ones are all=20
dynamic IRQ models.


So I am more in favor of a single big bunch of dynamic IRQs.=20
=20
>> +void spapr_irq_msi_init(sPAPRMachineState *spapr, uint32_t nr_irqs);
>> +int spapr_irq_msi_alloc(sPAPRMachineState *spapr, uint32_t num, bool =
align,
>> +                        Error **errp);
>> +void spapr_irq_msi_free(sPAPRMachineState *spapr, int irq, uint32_t n=
um);
>> +void spapr_irq_msi_reset(sPAPRMachineState *spapr);
>> +
>> +#endif
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 2b6d17056012..b9ba3ae675e5 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -188,6 +188,11 @@ static void xics_system_init(MachineState *machin=
e, int nr_irqs, Error **errp)
>>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
>>      Error *local_err =3D NULL;
>> =20
>> +    /* Initialize the MSI IRQ allocator. */
>> +    if (!spapr->xics_legacy) {
>> +        spapr_irq_msi_init(spapr, nr_irqs);
>> +    }
>> +
>>      if (kvm_enabled()) {
>>          if (machine_kernel_irqchip_allowed(machine) &&
>>              !xics_kvm_init(spapr, &local_err)) {
>> @@ -1635,6 +1640,10 @@ static void spapr_machine_reset(void)
>>          ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_f=
atal);
>>      }
>> =20
>> +    if (!spapr->xics_legacy) {
>> +        spapr_irq_msi_reset(spapr);
>> +    }
>> +
>>      qemu_devices_reset();
>> =20
>>      /* DRC reset may cause a device to be unplugged. This will cause =
troubles
>> @@ -1909,6 +1918,24 @@ static const VMStateDescription vmstate_spapr_p=
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
>> @@ -1936,6 +1963,7 @@ static const VMStateDescription vmstate_spapr =3D=
 {
>>          &vmstate_spapr_cap_cfpc,
>>          &vmstate_spapr_cap_sbbc,
>>          &vmstate_spapr_cap_ibs,
>> +        &vmstate_spapr_irq_map,
>>          NULL
>>      }
>>  };
>> @@ -4093,7 +4121,10 @@ DEFINE_SPAPR_MACHINE(3_0, "3.0", true);
>> =20
>>  static void spapr_machine_2_12_instance_options(MachineState *machine=
)
>>  {
>> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
>> +
>>      spapr_machine_3_0_instance_options(machine);
>> +    spapr->xics_legacy =3D true;
>>  }
>> =20
>>  static void spapr_machine_2_12_class_options(MachineClass *mc)
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index e4f5946a2188..c82dc40be0d5 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -709,7 +709,11 @@ void spapr_events_init(sPAPRMachineState *spapr)
>>  {
>>      int epow_irq;
>> =20
>> -    epow_irq =3D spapr_irq_findone(spapr, &error_fatal);
>> +    if (spapr->xics_legacy) {
>> +        epow_irq =3D spapr_irq_findone(spapr, &error_fatal);
>> +    } else {
>> +        epow_irq =3D SPAPR_IRQ_EPOW;
>=20
> Can slightly improve brevity by just initializing epow_irq to this,
> then overwriting it in the legacy case.

yes. I will do that. It will ease removal because we want to deprecate
the legacy mode one day.=20

That might in a long time though. We have to wait for the QEMU machine=20
number to no longer be in a maintained distro. correct? =20

Thanks,

C.

>=20
>> +    }
>> =20
>>      spapr_irq_claim(spapr, epow_irq, false, &error_fatal);
>> =20
>> @@ -731,7 +735,11 @@ void spapr_events_init(sPAPRMachineState *spapr)
>>      if (spapr->use_hotplug_event_source) {
>>          int hp_irq;
>> =20
>> -        hp_irq =3D spapr_irq_findone(spapr, &error_fatal);
>> +        if (spapr->xics_legacy) {
>> +            hp_irq =3D spapr_irq_findone(spapr, &error_fatal);
>> +        } else {
>> +            hp_irq =3D SPAPR_IRQ_HOTPLUG;
>> +        }
>=20
> Same here.
>=20
>> =20
>>          spapr_irq_claim(spapr, hp_irq, false, &error_fatal);
>> =20
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> new file mode 100644
>> index 000000000000..4e311023bab2
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
>> +void spapr_irq_msi_init(sPAPRMachineState *spapr, uint32_t nr_irqs)
>> +{
>> +    spapr->irq_map_nr =3D XICS_IRQ_BASE + nr_irqs - SPAPR_IRQ_MSI;
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
>> index 497b896c7d24..bbf48fd3503d 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -334,6 +334,9 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, s=
PAPRMachineState *spapr,
>>              return;
>>          }
>> =20
>> +        if (!spapr->xics_legacy) {
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
>> +    if (spapr->xics_legacy) {
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
>> +        if (!spapr->xics_legacy) {
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
>> +        if (spapr->xics_legacy) {
>> +            irq =3D spapr_irq_findone(spapr, &local_err);
>> +            if (local_err) {
>> +                error_propagate(errp, local_err);
>> +                error_prepend(errp, "can't allocate LSIs: ");
>> +                return;
>> +            }
>> +        } else {
>> +            irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + =
i;
>>          }
>> =20
>>          spapr_irq_claim(spapr, irq, true, &local_err);
>> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
>> index daf85130b5ef..ecee4b2d03da 100644
>> --- a/hw/ppc/spapr_vio.c
>> +++ b/hw/ppc/spapr_vio.c
>> @@ -436,6 +436,9 @@ static void spapr_vio_busdev_reset(DeviceState *qd=
ev)
>>      }
>>  }
>> =20
>> +/* TODO : poor VIO device indexing ... */
>> +static uint32_t vio_index;
>> +
>>  static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
>>  {
>>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>> @@ -476,10 +479,18 @@ static void spapr_vio_busdev_realize(DeviceState=
 *qdev, Error **errp)
>>      }
>> =20
>>      if (!dev->irq) {
>> -        dev->irq =3D spapr_irq_findone(spapr, &local_err);
>> -        if (local_err) {
>> -            error_propagate(errp, local_err);
>> -            return;
>> +        if (spapr->xics_legacy) {
>> +            dev->irq =3D spapr_irq_findone(spapr, &local_err);
>> +            if (local_err) {
>> +                error_propagate(errp, local_err);
>> +                return;
>> +            }
>> +        } else {
>> +            dev->irq =3D SPAPR_IRQ_VIO + vio_index++;
>> +            if (dev->irq =3D=3D SPAPR_IRQ_PCI_LSI) {
>> +                error_setg(errp, "Too many VIO devices");
>> +                return;
>> +            }
>>          }
>>      }
>> =20
>> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
>> index 86d82a6ec3ac..4fe3b7804d43 100644
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
