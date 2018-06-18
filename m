Received: from eggs.gnu.org ([2001:4830:134:3::10]:60224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fUpjy-0006b2-Ke
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 04:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fUpjv-0001Q2-F8
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 04:42:22 -0400
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:35291)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fUpjv-0001PM-5G
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 04:42:19 -0400
Received: from player739.ha.ovh.net (unknown [10.109.105.50])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id E2CF1C5DDB
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 10:42:15 +0200 (CEST)
Date: Mon, 18 Jun 2018 10:42:08 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180618104208.66a9f09e@bahia.lan>
In-Reply-To: <c5182296-b9f5-0072-8d13-551d71560394@kaod.org>
References: <20180615115303.31125-1-clg@kaod.org>
	<20180615115303.31125-4-clg@kaod.org>
	<20180615180311.6d16e506@bahia.lan>
	<c5182296-b9f5-0072-8d13-551d71560394@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/3] spapr: introduce a fixed
 IRQ number space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Fri, 15 Jun 2018 19:18:08 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> Hello,
>=20
> On 06/15/2018 06:03 PM, Greg Kurz wrote:
> > On Fri, 15 Jun 2018 13:53:03 +0200
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >  =20
> >> This proposal introduces a new IRQ number space layout using static
> >> numbers for all devices and a bitmap allocator for the MSI numbers
> >> which are negotiated by the guest at runtime.
> >>
> >> The previous layout is kept in machines raising the 'xics_legacy'
> >> flag.
> >>
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> ---
> >>  include/hw/ppc/spapr.h     |  4 ++++
> >>  include/hw/ppc/spapr_irq.h | 30 ++++++++++++++++++++++++
> >>  hw/ppc/spapr.c             | 31 +++++++++++++++++++++++++
> >>  hw/ppc/spapr_events.c      | 12 ++++++++--
> >>  hw/ppc/spapr_irq.c         | 57 +++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  hw/ppc/spapr_pci.c         | 28 ++++++++++++++++++-----
> >>  hw/ppc/spapr_vio.c         | 15 ++++++++----
> >>  hw/ppc/Makefile.objs       |  2 +-
> >>  8 files changed, 166 insertions(+), 13 deletions(-)
> >>  create mode 100644 include/hw/ppc/spapr_irq.h
> >>  create mode 100644 hw/ppc/spapr_irq.c
> >>
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index 49cda04b1493..094c7780130e 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -7,6 +7,7 @@
> >>  #include "hw/ppc/spapr_drc.h"
> >>  #include "hw/mem/pc-dimm.h"
> >>  #include "hw/ppc/spapr_ovec.h"
> >> +#include "hw/ppc/spapr_irq.h"
> >> =20
> >>  struct VIOsPAPRBus;
> >>  struct sPAPRPHBState;
> >> @@ -164,6 +165,9 @@ struct sPAPRMachineState {
> >>      char *kvm_type;
> >> =20
> >>      const char *icp_type;
> >> +    bool xics_legacy;
> >> +    int32_t irq_map_nr;
> >> +    unsigned long *irq_map;
> >> =20
> >>      bool cmd_line_caps[SPAPR_CAP_NUM];
> >>      sPAPRCapabilities def, eff, mig;
> >> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> >> new file mode 100644
> >> index 000000000000..07e36d1c7e74
> >> --- /dev/null
> >> +++ b/include/hw/ppc/spapr_irq.h
> >> @@ -0,0 +1,30 @@
> >> +/*
> >> + * QEMU PowerPC sPAPR IRQ backend definitions
> >> + *
> >> + * Copyright (c) 2018, IBM Corporation.
> >> + *
> >> + * This code is licensed under the GPL version 2 or later. See the
> >> + * COPYING file in the top-level directory.
> >> + */
> >> +#ifndef HW_SPAPR_IRQ_H
> >> +#define HW_SPAPR_IRQ_H
> >> +
> >> +/*
> >> + * IRQ ranges per type =20
> >=20
> > Well, range offsets actually. Maybe you could document the range size
> > as well for each type. =20
>=20
> yes. I am waiting for people to scream : "I want more !"
>=20
> >> + */
> >> +#define SPAPR_IRQ_EPOW       0x1000  /* XICS_IRQ_BASE offset */
> >> +#define SPAPR_IRQ_HOTPLUG    0x1001 =20
> >=20
> > This is just 1 irq, ie, range 0x1002-0x103F is unused
> >  =20
> >> +#define SPAPR_IRQ_VIO        0x1040 =20
> >=20
> > This is 1 irq per device, hence up to 64 devices
> >  =20
> >> +#define SPAPR_IRQ_PCI_LSI    0x1080
> >> + =20
> >=20
> > This is 4 irqs per PHB, hence up to 32 PHBs. Cool, we're currently
> > limited to 31 PHBs.
> >  =20
> >> +#define SPAPR_IRQ_MSI        0x1100  /* Offset of the dynamic range c=
overed =20
> >=20
> > We only support dynamic MSIs with PCI, maybe rename to SPAPR_IRQ_PCI_MS=
I ? =20
>=20
> hmm, no. We could have CAPI devices there. remember ? ;)
>=20

Well... OpenCAPI devices are exposed to the OS as PCI devices, so I'm not
sure we need a CAPI specific range.

> >> +                                      * by the bitmap allocator */ =20
> >=20
> > The range size is hence 1k (XICS_IRQS_SPAPR) for the time being. =20
>=20
> in fact we could this bogus limit and use spapr->irq_map_nr now.
>=20

"we could *missing verb* this bogus limit"... so I'm not sure to
understand...

> >> +
> >> +void spapr_irq_msi_init(sPAPRMachineState *spapr, uint32_t nr_irqs,
> >> +                       Error **errp); =20
> >                          ^
> >                      missing space
> > =20
> >> +int spapr_irq_msi_alloc(sPAPRMachineState *spapr, uint32_t num, bool =
align,
> >> +                        Error **errp);
> >> +void spapr_irq_msi_free(sPAPRMachineState *spapr, int irq, uint32_t n=
um);
> >> +void spapr_irq_msi_reset(sPAPRMachineState *spapr);
> >> +
> >> +#endif
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index c464951747e3..32aa5d869d9c 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -187,6 +187,11 @@ static void xics_system_init(MachineState *machin=
e, int nr_irqs, Error **errp)
> >>  {
> >>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> >> =20
> >> +    /* Initialize the MSI IRQ allocator. */
> >> +    if (!spapr->xics_legacy) {
> >> +        spapr_irq_msi_init(spapr, nr_irqs, &error_fatal); =20
> >=20
> > The error should be propagated to the caller. =20
>=20
> I think the Error is useless here.
>=20

Yeah, spapr_irq_msi_init() cannot fail.

>=20
> >  =20
> >> +    }
> >> +
> >>      if (kvm_enabled()) {
> >>          if (machine_kernel_irqchip_allowed(machine) &&
> >>              !xics_kvm_init(spapr, errp)) { =20
> >=20
> > And I now realize that the way errors are handled here is badly
> > broken.
> >=20
> > In the default case, this function is supposed to try in-kernel XICS
> > first and if it fails, then fallback to userland XICS. But since we
> > pass errp down to xics_kvm_init() and the caller happens to pass
> > &error_fatal, we stop right here instead of trying the fallback.
> >=20
> > And if the caller changes to pass a standard &local_err instead,
> > things would be even worse. With the same scenario, QEMU would
> > probably exit if it could fallback to the userland XICS, or abort
> > otherwise because error_set() would be called with an already set
> > *errp.
> >=20
> > Since this beha^wug is mine (commit 3d85885a1b1f3), let me fix it
> > first :)
> >  =20
> >> @@ -1629,6 +1634,10 @@ static void spapr_machine_reset(void)
> >>          ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_f=
atal);
> >>      }
> >> =20
> >> +    if (!spapr->xics_legacy) {
> >> +        spapr_irq_msi_reset(spapr);
> >> +    }
> >> +
> >>      qemu_devices_reset();
> >> =20
> >>      /* DRC reset may cause a device to be unplugged. This will cause =
troubles
> >> @@ -1903,6 +1912,24 @@ static const VMStateDescription vmstate_spapr_p=
atb_entry =3D {
> >>      },
> >>  };
> >> =20
> >> +static bool spapr_irq_map_needed(void *opaque)
> >> +{
> >> +    sPAPRMachineState *spapr =3D opaque;
> >> +
> >> +    return spapr->irq_map && !bitmap_empty(spapr->irq_map, spapr->irq=
_map_nr); =20
> >=20
> > Maybe check !spapr->xics_legacy as well to preserve backward migration
> > to older machines ? =20
>=20
> no need. It is redudant with spapr->irq_map which is not allocated in tha=
t case.
>=20

Right.

> >> +}
> >> +
> >> +static const VMStateDescription vmstate_spapr_irq_map =3D {
> >> +    .name =3D "spapr_irq_map",
> >> +    .version_id =3D 1,
> >> +    .minimum_version_id =3D 1,
> >> +    .needed =3D spapr_irq_map_needed,
> >> +    .fields =3D (VMStateField[]) {
> >> +        VMSTATE_BITMAP(irq_map, sPAPRMachineState, 0, irq_map_nr),
> >> +        VMSTATE_END_OF_LIST()
> >> +    },
> >> +};
> >> +
> >>  static const VMStateDescription vmstate_spapr =3D {
> >>      .name =3D "spapr",
> >>      .version_id =3D 3,
> >> @@ -1930,6 +1957,7 @@ static const VMStateDescription vmstate_spapr =
=3D {
> >>          &vmstate_spapr_cap_cfpc,
> >>          &vmstate_spapr_cap_sbbc,
> >>          &vmstate_spapr_cap_ibs,
> >> +        &vmstate_spapr_irq_map,
> >>          NULL
> >>      }
> >>  };
> >> @@ -4101,7 +4129,10 @@ DEFINE_SPAPR_MACHINE(3_0, "3.0", true);
> >> =20
> >>  static void spapr_machine_2_12_instance_options(MachineState *machine)
> >>  {
> >> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> >> +
> >>      spapr_machine_3_0_instance_options(machine);
> >> +    spapr->xics_legacy =3D true;
> >>  }
> >> =20
> >>  static void spapr_machine_2_12_class_options(MachineClass *mc)
> >> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> >> index 3b6ae7272092..1ef7ce7f1509 100644
> >> --- a/hw/ppc/spapr_events.c
> >> +++ b/hw/ppc/spapr_events.c
> >> @@ -709,7 +709,11 @@ void spapr_events_init(sPAPRMachineState *spapr)
> >>  {
> >>      int epow_irq;
> >> =20
> >> -    epow_irq =3D spapr_irq_findone(spapr, &error_fatal);
> >> +    if (spapr->xics_legacy) {
> >> +        epow_irq =3D spapr_irq_findone(spapr, &error_fatal);
> >> +    } else {
> >> +        epow_irq =3D SPAPR_IRQ_EPOW;
> >> +    }
> >> =20
> >>      spapr_irq_claim(spapr, epow_irq, 1, false, &error_fatal);
> >> =20
> >> @@ -731,7 +735,11 @@ void spapr_events_init(sPAPRMachineState *spapr)
> >>      if (spapr->use_hotplug_event_source) {
> >>          int hp_irq;
> >> =20
> >> -        hp_irq =3D spapr_irq_findone(spapr, &error_fatal);
> >> +        if (spapr->xics_legacy) {
> >> +            hp_irq =3D spapr_irq_findone(spapr, &error_fatal);
> >> +        } else {
> >> +            hp_irq =3D SPAPR_IRQ_HOTPLUG;
> >> +        }
> >> =20
> >>          spapr_irq_claim(spapr, hp_irq, 1, false, &error_fatal);
> >> =20
> >> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> >> new file mode 100644
> >> index 000000000000..55fa764c85d1
> >> --- /dev/null
> >> +++ b/hw/ppc/spapr_irq.c
> >> @@ -0,0 +1,57 @@
> >> +/*
> >> + * QEMU PowerPC sPAPR IRQ interface
> >> + *
> >> + * Copyright (c) 2018, IBM Corporation.
> >> + *
> >> + * This code is licensed under the GPL version 2 or later. See the
> >> + * COPYING file in the top-level directory.
> >> + */
> >> +
> >> +#include "qemu/osdep.h"
> >> +#include "qemu/log.h"
> >> +#include "qemu/error-report.h"
> >> +#include "qapi/error.h"
> >> +#include "hw/ppc/spapr.h"
> >> +#include "hw/ppc/xics.h"
> >> +
> >> +void spapr_irq_msi_init(sPAPRMachineState *spapr, uint32_t nr_irqs,
> >> +                        Error **errp) =20
> >=20
> > What's the errp for ? It looks like this function can never return
> > an error. Maybe just drop it. =20
>=20
> yes
>=20
> >  =20
> >> +{
> >> +    spapr->irq_map_nr =3D XICS_IRQ_BASE + nr_irqs - SPAPR_IRQ_MSI;
> >> +    spapr->irq_map =3D bitmap_new(spapr->irq_map_nr);
> >> +}
> >> +
> >> +int spapr_irq_msi_alloc(sPAPRMachineState *spapr, uint32_t num, bool =
align,
> >> +                        Error **errp)
> >> +{
> >> +    int irq;
> >> +
> >> +    /*
> >> +     * The 'align_mask' parameter of bitmap_find_next_zero_area()
> >> +     * should be one less than a power of 2; 0 means no
> >> +     * alignment. Adapt the 'align' value of the former allocator
> >> +     * to fit the requirements of bitmap_find_next_zero_area()
> >> +     */
> >> +    align -=3D 1;
> >> +
> >> +    irq =3D bitmap_find_next_zero_area(spapr->irq_map, spapr->irq_map=
_nr, 0, num,
> >> +                                     align);
> >> +    if (irq =3D=3D spapr->irq_map_nr) {
> >> +        error_setg(errp, "can't find a free %d-IRQ block", num);
> >> +        return -1;
> >> +    }
> >> +
> >> +    bitmap_set(spapr->irq_map, irq, num);
> >> +
> >> +    return irq + SPAPR_IRQ_MSI;
> >> +}
> >> +
> >> +void spapr_irq_msi_free(sPAPRMachineState *spapr, int irq, uint32_t n=
um)
> >> +{
> >> +    bitmap_clear(spapr->irq_map, irq - SPAPR_IRQ_MSI, num);
> >> +}
> >> +
> >> +void spapr_irq_msi_reset(sPAPRMachineState *spapr)
> >> +{
> >> +    bitmap_clear(spapr->irq_map, 0, spapr->irq_map_nr);
> >> +}
> >> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> >> index 7394c62b4a8b..f3c4a25fb482 100644
> >> --- a/hw/ppc/spapr_pci.c
> >> +++ b/hw/ppc/spapr_pci.c
> >> @@ -333,6 +333,9 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, s=
PAPRMachineState *spapr,
> >>              return;
> >>          }
> >> =20
> >> +        if (!spapr->xics_legacy) {
> >> +            spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
> >> +        }
> >>          spapr_irq_free(spapr, msi->first_irq, msi->num); =20
> >=20
> > Shouldn't ^^ be in an else block ? =20
>=20
> no. one is for the MSI IRQ allocator, the other for the controller.=20
>=20

Indeed.

> >  =20
> >>          if (msi_present(pdev)) {
> >>              spapr_msi_setmsg(pdev, 0, false, 0, 0);
> >> @@ -371,7 +374,13 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, =
sPAPRMachineState *spapr,
> >>      }
> >> =20
> >>      /* Allocate MSIs */
> >> -    irq =3D spapr_irq_find(spapr, req_num, ret_intr_type =3D=3D RTAS_=
TYPE_MSI, &err);
> >> +    if (spapr->xics_legacy) {
> >> +        irq =3D spapr_irq_find(spapr, req_num, ret_intr_type =3D=3D R=
TAS_TYPE_MSI,
> >> +                             &err);
> >> +    } else {
> >> +        irq =3D spapr_irq_msi_alloc(spapr, req_num,
> >> +                                  ret_intr_type =3D=3D RTAS_TYPE_MSI,=
 &err);
> >> +    }
> >>      if (err) {
> >>          error_reportf_err(err, "Can't allocate MSIs for device %x: ",
> >>                            config_addr);
> >> @@ -388,6 +397,9 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, s=
PAPRMachineState *spapr,
> >> =20
> >>      /* Release previous MSIs */
> >>      if (msi) {
> >> +        if (!spapr->xics_legacy) {
> >> +            spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
> >> +        }
> >>          spapr_irq_free(spapr, msi->first_irq, msi->num);
> >>          g_hash_table_remove(phb->msi, &config_addr);
> >>      }
> >> @@ -1704,11 +1716,15 @@ static void spapr_phb_realize(DeviceState *dev=
, Error **errp)
> >>          uint32_t irq;
> >>          Error *local_err =3D NULL;
> >> =20
> >> -        irq =3D spapr_irq_findone(spapr, &local_err);
> >> -        if (local_err) {
> >> -            error_propagate(errp, local_err);
> >> -            error_prepend(errp, "can't allocate LSIs: ");
> >> -            return;
> >> +        if (spapr->xics_legacy) {
> >> +            irq =3D spapr_irq_findone(spapr, &local_err);
> >> +            if (local_err) {
> >> +                error_propagate(errp, local_err);
> >> +                error_prepend(errp, "can't allocate LSIs: ");
> >> +                return;
> >> +            }
> >> +        } else {
> >> +            irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + =
i;
> >>          }
> >> =20
> >>          spapr_irq_claim(spapr, irq, 1, true, &local_err);
> >> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> >> index ad9b56e28447..7707bda6a38d 100644
> >> --- a/hw/ppc/spapr_vio.c
> >> +++ b/hw/ppc/spapr_vio.c
> >> @@ -436,6 +436,9 @@ static void spapr_vio_busdev_reset(DeviceState *qd=
ev)
> >>      }
> >>  }
> >> =20
> >> +/* TODO : poor VIO device indexing ... */
> >> +static uint32_t vio_index;
> >> +
> >>  static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
> >>  {
> >>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> >> @@ -476,10 +479,14 @@ static void spapr_vio_busdev_realize(DeviceState=
 *qdev, Error **errp)
> >>      }
> >> =20
> >>      if (!dev->irq) {
> >> -        dev->irq =3D spapr_irq_findone(spapr, &local_err);
> >> -        if (local_err) {
> >> -            error_propagate(errp, local_err);
> >> -            return;
> >> +        if (spapr->xics_legacy) {
> >> +            dev->irq =3D spapr_irq_findone(spapr, &local_err);
> >> +            if (local_err) {
> >> +                error_propagate(errp, local_err);
> >> +                return;
> >> +            }
> >> +        } else {
> >> +            dev->irq =3D SPAPR_IRQ_VIO + vio_index++; =20
> >=20
> > This can overlap the next range if we have more than 64 VIO devices... =
=20
>=20
> yes. but claim() should fail.
>=20

Hmm... I have the impression claim() only fails if:
- irq < ics->offset (ie, XICS_IRQ_BASE =3D=3D 4096)
- or irq >=3D ics->offset + ics->nr_irqs (ie, XICS_IRQS_SPAPR =3D=3D 1024)
- or irq is already in use

I can't find code that would prevent dev->irq to reach SPAPR_IRQ_MSI.

> Thanks,
>=20
> C.
>=20
> >>          }
> >>      }
> >> =20
> >> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> >> index 86d82a6ec3ac..4fe3b7804d43 100644
> >> --- a/hw/ppc/Makefile.objs
> >> +++ b/hw/ppc/Makefile.objs
> >> @@ -4,7 +4,7 @@ obj-y +=3D ppc.o ppc_booke.o fdt.o
> >>  obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio.o spapr_eve=
nts.o
> >>  obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o
> >>  obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o spapr_=
rng.o
> >> -obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o
> >> +obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
> >>  # IBM PowerNV
> >>  obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv=
_psi.o pnv_occ.o pnv_bmc.o
> >>  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy) =20
> >  =20
>=20
