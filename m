Received: from eggs.gnu.org ([2001:4830:134:3::10]:49013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSxwd-0004O2-LB
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 01:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSxwa-0001Oe-C9
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 01:03:43 -0400
Date: Wed, 13 Jun 2018 15:00:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613050028.GV30690@umbus.fritz.box>
References: <20180518164405.11804-1-clg@kaod.org>
	<20180518164405.11804-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="87MiR7gHvrw39A9h"
Content-Disposition: inline
In-Reply-To: <20180518164405.11804-4-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 3/4] spapr: introduce a generic IRQ
 frontend to the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>


--87MiR7gHvrw39A9h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2018 at 06:44:04PM +0200, C=E9dric Le Goater wrote:
> This proposal moves all the related IRQ routines of the sPAPR machine
> behind a class interface to prepare for future changes in the IRQ
> controller model. First of which is a reorganization of the IRQ number
> space layout and a second, coming later, will be to integrate the
> support for the new POWER9 XIVE IRQ controller.
>=20
> The new interface defines a set of fixed IRQ number ranges, for each
> IRQ type, in which devices allocate the IRQ numbers they need
> depending on a unique device index. Here is the layout :
>=20
>     SPAPR_IRQ_IPI        0x0        /*  1 IRQ per CPU      */
>     SPAPR_IRQ_EPOW       0x1000     /*  1 IRQ per device   */
>     SPAPR_IRQ_HOTPLUG    0x1001     /*  1 IRQ per device   */
>     SPAPR_IRQ_VIO        0x1100     /*  1 IRQ per device   */
>     SPAPR_IRQ_PCI_LSI    0x1200     /*  4 IRQs per device  */
>     SPAPR_IRQ_PCI_MSI    0x1400     /* 1K IRQs per device  */
>=20
>     The IPI range is reserved for future use when XIVE support
>     comes in.
>=20
> The routines of this interface encompass the previous needs and the
> new ones and seem complex but the provided IRQ backend should
> implement what we have today without any functional changes.
>=20
> Each device model is modified to take the new interface into account
> using the IRQ range/type definitions and a device index. A part from
> the VIO devices, lacking an id, the changes are relatively simple.

I find your use of "back end" vs. "front end" in this patch and the
next kind of confusing.

> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/spapr.h     |  10 +-
>  include/hw/ppc/spapr_irq.h |  46 +++++++++
>  hw/ppc/spapr.c             | 177 +---------------------------------
>  hw/ppc/spapr_events.c      |   7 +-
>  hw/ppc/spapr_irq.c         | 233 +++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/spapr_pci.c         |  21 +++-
>  hw/ppc/spapr_vio.c         |   5 +-
>  hw/ppc/Makefile.objs       |   2 +-
>  8 files changed, 308 insertions(+), 193 deletions(-)
>  create mode 100644 include/hw/ppc/spapr_irq.h
>  create mode 100644 hw/ppc/spapr_irq.c
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 2cfdfdd67eaf..4eb212b16a51 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -3,10 +3,10 @@
> =20
>  #include "sysemu/dma.h"
>  #include "hw/boards.h"
> -#include "hw/ppc/xics.h"
>  #include "hw/ppc/spapr_drc.h"
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/ppc/spapr_ovec.h"
> +#include "hw/ppc/spapr_irq.h"
> =20
>  struct VIOsPAPRBus;
>  struct sPAPRPHBState;
> @@ -104,6 +104,7 @@ struct sPAPRMachineClass {
>                            unsigned n_dma, uint32_t *liobns, Error **errp=
);
>      sPAPRResizeHPT resize_hpt_default;
>      sPAPRCapabilities default_caps;
> +    sPAPRIrq *irq;
>  };
> =20
>  /**
> @@ -773,13 +774,6 @@ int spapr_get_vcpu_id(PowerPCCPU *cpu);
>  void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp);
>  PowerPCCPU *spapr_find_cpu(int vcpu_id);
> =20
> -int spapr_irq_alloc(sPAPRMachineState *spapr, bool lsi, Error **errp);
> -int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi,
> -                          bool align, Error **errp);
> -void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
> -qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
> -
> -
>  int spapr_caps_pre_load(void *opaque);
>  int spapr_caps_pre_save(void *opaque);
> =20
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> new file mode 100644
> index 000000000000..caf4c33d4cec
> --- /dev/null
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -0,0 +1,46 @@
> +/*
> + * QEMU PowerPC sPAPR IRQ backend definitions
> + *
> + * Copyright (c) 2018, IBM Corporation.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +#ifndef HW_SPAPR_IRQ_H
> +#define HW_SPAPR_IRQ_H
> +
> +#include "hw/ppc/xics.h"
> +
> +/*
> + * IRQ ranges
> + */
> +#define SPAPR_IRQ_IPI        0x0     /* 1 IRQ per CPU */
> +#define SPAPR_IRQ_EPOW       0x1000  /* 1 IRQ per device */
> +#define SPAPR_IRQ_HOTPLUG    0x1001  /* 1 IRQ per device */
> +#define SPAPR_IRQ_VIO        0x1100  /* 1 IRQ per device */
> +#define SPAPR_IRQ_PCI_LSI    0x1200  /* 4 IRQs per device */
> +#define SPAPR_IRQ_PCI_MSI    0x1400  /* 1K IRQs per device covered by
> +                                      * a bitmap allocator */

These look like they belong in the next patch with the fixed allocations.

> +typedef struct sPAPRIrq {

Much of this structure doesn't make sense to me.  AIUI, the idea is
that this method structure will vary with the xics vs. xive backend,
yes?  Comments below are based on that assumption.

> +    uint32_t    nr_irqs;
> +
> +    void (*init)(sPAPRMachineState *spapr, Error **errp);
> +    int (*alloc)(sPAPRMachineState *spapr, uint32_t range, uint32_t inde=
x,
> +                 Error **errp);

'range' has no place here - working out the indices should be entirely
on the spapr side, only the final irq number should need to go to the
backend.

I'd also prefer to call it "claim" to distinguish it from the existing
"alloc" function which finds a free irq as well as setting it up for
our exclusive use.

> +    int (*alloc_block)(sPAPRMachineState *spapr, uint32_t range,
> +                       uint32_t index, int num, bool align, Error **errp=
);

There should be no need for this.  We needed an alloc_block routine
before, because we wanted to ensure that we got a contiguous (and
maybe aligned) block of irqs.  By the time we go to the backend we
should already have absolute irq numbers, so we can just claim each of
them separately.

> +    void (*free)(sPAPRMachineState *spapr, int irq, int num, Error **err=
p);
> +    qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
> +} sPAPRIrq;
> +
> +extern sPAPRIrq spapr_irq_default;
> +
> +int spapr_irq_alloc(sPAPRMachineState *spapr, uint32_t range, uint32_t i=
ndex,
> +                    Error **errp);
> +int spapr_irq_alloc_block(sPAPRMachineState *spapr, uint32_t range,
> +                          uint32_t index, int num, bool align, Error **e=
rrp);
> +void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num, Error **=
errp);
> +qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
> +
> +#endif /* HW_SPAPR_IRQ_H */
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 05a924a5f2da..09f095d73eae 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -116,33 +116,6 @@ static bool spapr_is_thread0_in_vcore(sPAPRMachineSt=
ate *spapr,
>      return spapr_get_vcpu_id(cpu) % spapr->vsmt =3D=3D 0;
>  }
> =20
> -static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
> -                                  const char *type_ics,
> -                                  int nr_irqs, Error **errp)
> -{
> -    Error *local_err =3D NULL;
> -    Object *obj;
> -
> -    obj =3D object_new(type_ics);
> -    object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
> -    object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
> -                                   &error_abort);
> -    object_property_set_int(obj, nr_irqs, "nr-irqs", &local_err);
> -    if (local_err) {
> -        goto error;
> -    }
> -    object_property_set_bool(obj, true, "realized", &local_err);
> -    if (local_err) {
> -        goto error;
> -    }
> -
> -    return ICS_SIMPLE(obj);
> -
> -error:
> -    error_propagate(errp, local_err);
> -    return NULL;
> -}
> -
>  static bool pre_2_10_vmstate_dummy_icp_needed(void *opaque)
>  {
>      /* Dummy entries correspond to unused ICPState objects in older QEMU=
s,
> @@ -183,32 +156,6 @@ static int xics_max_server_number(sPAPRMachineState =
*spapr)
>      return DIV_ROUND_UP(max_cpus * spapr->vsmt, smp_threads);
>  }
> =20
> -static void xics_system_init(MachineState *machine, int nr_irqs, Error *=
*errp)
> -{
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> -
> -    if (kvm_enabled()) {
> -        if (machine_kernel_irqchip_allowed(machine) &&
> -            !xics_kvm_init(spapr, errp)) {
> -            spapr->icp_type =3D TYPE_KVM_ICP;
> -            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs=
, errp);
> -        }
> -        if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
> -            error_prepend(errp, "kernel_irqchip requested but unavailabl=
e: ");
> -            return;
> -        }
> -    }
> -
> -    if (!spapr->ics) {
> -        xics_spapr_init(spapr);
> -        spapr->icp_type =3D TYPE_ICP;
> -        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,=
 errp);
> -        if (!spapr->ics) {
> -            return;
> -        }
> -    }
> -}
> -
>  static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
>                                    int smt_threads)
>  {
> @@ -2580,7 +2527,7 @@ static void spapr_machine_init(MachineState *machin=
e)
>      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
> =20
>      /* Set up Interrupt Controller before we create the VCPUs */
> -    xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
> +    smc->irq->init(spapr, &error_fatal);
> =20
>      /* Set up containers for ibm,client-architecture-support negotiated =
options
>       */
> @@ -3766,127 +3713,6 @@ static ICPState *spapr_icp_get(XICSFabric *xi, in=
t vcpu_id)
>      return cpu ? ICP(cpu->intc) : NULL;
>  }
> =20
> -#define ICS_IRQ_FREE(ics, srcno)   \
> -    (!((ics)->irqs[(srcno)].flags & (XICS_FLAGS_IRQ_MASK)))
> -
> -static int ics_find_free_block(ICSState *ics, int num, int alignnum)
> -{
> -    int first, i;
> -
> -    for (first =3D 0; first < ics->nr_irqs; first +=3D alignnum) {
> -        if (num > (ics->nr_irqs - first)) {
> -            return -1;
> -        }
> -        for (i =3D first; i < first + num; ++i) {
> -            if (!ICS_IRQ_FREE(ics, i)) {
> -                break;
> -            }
> -        }
> -        if (i =3D=3D (first + num)) {
> -            return first;
> -        }
> -    }
> -
> -    return -1;
> -}
> -
> -/*
> - * Allocate the IRQ number and set the IRQ type, LSI or MSI
> - */
> -static void spapr_irq_set_lsi(sPAPRMachineState *spapr, int irq, bool ls=
i)
> -{
> -    ics_set_irq_type(spapr->ics, irq - spapr->ics->offset, lsi);
> -}
> -
> -int spapr_irq_alloc(sPAPRMachineState *spapr, bool lsi, Error **errp)
> -{
> -    ICSState *ics =3D spapr->ics;
> -    int irq;
> -
> -    assert(ics);
> -
> -    irq =3D ics_find_free_block(ics, 1, 1);
> -    if (irq < 0) {
> -        error_setg(errp, "can't allocate IRQ: no IRQ left");
> -        return -1;
> -    }
> -    irq +=3D ics->offset;
> -
> -    spapr_irq_set_lsi(spapr, irq, lsi);
> -    trace_spapr_irq_alloc(irq);
> -
> -    return irq;
> -}
> -
> -/*
> - * Allocate block of consecutive IRQs, and return the number of the firs=
t IRQ in
> - * the block. If align=3D=3Dtrue, aligns the first IRQ number to num.
> - */
> -int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi,
> -                          bool align, Error **errp)
> -{
> -    ICSState *ics =3D spapr->ics;
> -    int i, first =3D -1;
> -
> -    assert(ics);
> -
> -    /*
> -     * MSIMesage::data is used for storing VIRQ so
> -     * it has to be aligned to num to support multiple
> -     * MSI vectors. MSI-X is not affected by this.
> -     * The hint is used for the first IRQ, the rest should
> -     * be allocated continuously.
> -     */
> -    if (align) {
> -        assert((num =3D=3D 1) || (num =3D=3D 2) || (num =3D=3D 4) ||
> -               (num =3D=3D 8) || (num =3D=3D 16) || (num =3D=3D 32));
> -        first =3D ics_find_free_block(ics, num, num);
> -    } else {
> -        first =3D ics_find_free_block(ics, num, 1);
> -    }
> -    if (first < 0) {
> -        error_setg(errp, "can't find a free %d-IRQ block", num);
> -        return -1;
> -    }
> -
> -    first +=3D ics->offset;
> -    for (i =3D first; i < first + num; ++i) {
> -        spapr_irq_set_lsi(spapr, i, lsi);
> -    }
> -
> -    trace_spapr_irq_alloc_block(first, num, lsi, align);
> -
> -    return first;
> -}
> -
> -void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num)
> -{
> -    ICSState *ics =3D spapr->ics;
> -    int srcno =3D irq - ics->offset;
> -    int i;
> -
> -    if (ics_valid_irq(ics, irq)) {
> -        trace_spapr_irq_free(0, irq, num);
> -        for (i =3D srcno; i < srcno + num; ++i) {
> -            if (ICS_IRQ_FREE(ics, i)) {
> -                trace_spapr_irq_free_warn(0, i + ics->offset);
> -            }
> -            memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
> -        }
> -    }
> -}
> -
> -qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq)
> -{
> -    ICSState *ics =3D spapr->ics;
> -
> -    if (ics_valid_irq(ics, irq)) {
> -        return ics->qirqs[irq - ics->offset];
> -    }
> -
> -    return NULL;
> -}
> -
>  static void spapr_pic_print_info(InterruptStatsProvider *obj,
>                                   Monitor *mon)
>  {
> @@ -4007,6 +3833,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
>      spapr_caps_add_properties(smc, &error_abort);
> +    smc->irq =3D &spapr_irq_default;
>  }
> =20
>  static const TypeInfo spapr_machine_info =3D {
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 64a67439beac..e457c5f18189 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -712,7 +712,8 @@ void spapr_events_init(sPAPRMachineState *spapr)
>      spapr->event_sources =3D spapr_event_sources_new();
> =20
>      spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_EPOW,
> -                                 spapr_irq_alloc(spapr, false, &error_fa=
tal));
> +                                 spapr_irq_alloc(spapr, SPAPR_IRQ_EPOW, =
0,
> +                                                 &error_fatal));
> =20
>      /* NOTE: if machine supports modern/dedicated hotplug event source,
>       * we add it to the device-tree unconditionally. This means we may
> @@ -724,8 +725,8 @@ void spapr_events_init(sPAPRMachineState *spapr)
>       */
>      if (spapr->use_hotplug_event_source) {
>          spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_H=
OT_PLUG,
> -                                     spapr_irq_alloc(spapr, false,
> -                                                     &error_fatal));
> +                                     spapr_irq_alloc(spapr, SPAPR_IRQ_HO=
TPLUG,
> +                                                     0, &error_fatal));
>      }
> =20
>      spapr->epow_notifier.notify =3D spapr_powerdown_req;
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> new file mode 100644
> index 000000000000..ff6cb1aafd25
> --- /dev/null
> +++ b/hw/ppc/spapr_irq.c
> @@ -0,0 +1,233 @@
> +/*
> + * QEMU PowerPC sPAPR IRQ backend
> + *
> + * Copyright (c) 2018, IBM Corporation.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "hw/pci/pci.h"
> +#include "hw/ppc/spapr.h"
> +#include "sysemu/kvm.h"
> +#include "trace.h"
> +
> +/*
> + * Legacy XICS IRQ backend.
> + *
> + * The device IRQ 'range' is used to identify LSIs, and the device
> + * 'index' is unused
> + */

Ugh.. ok.  This backend/frontend interface seems to be conflating
things that vary with xics vs. xive (what I'd think of as the "back
end") and things that vary with our irq allocation model.  Those
really need to be separate.

An ops structure might make sense for the xics vs. xive stuff.  I'm
pretty sure it will be overkill for the allocation model.

> +static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
> +                                  const char *type_ics,
> +                                  int nr_irqs, Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    Object *obj;
> +
> +    obj =3D object_new(type_ics);
> +    object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
> +    object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
> +                                   &error_abort);
> +    object_property_set_int(obj, nr_irqs, "nr-irqs", &local_err);
> +    if (local_err) {
> +        goto error;
> +    }
> +    object_property_set_bool(obj, true, "realized", &local_err);
> +    if (local_err) {
> +        goto error;
> +    }
> +
> +    return ICS_SIMPLE(obj);
> +
> +error:
> +    error_propagate(errp, local_err);
> +    return NULL;
> +}
> +
> +static void spapr_irq_init_2_12(sPAPRMachineState *spapr, Error **errp)
> +{
> +    MachineState *machine =3D MACHINE(spapr);
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
> +    uint32_t nr_irqs =3D smc->irq->nr_irqs;
> +
> +    if (kvm_enabled()) {
> +        if (machine_kernel_irqchip_allowed(machine) &&
> +            !xics_kvm_init(spapr, errp)) {
> +            spapr->icp_type =3D TYPE_KVM_ICP;
> +            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs=
, errp);
> +        }
> +        if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
> +            error_prepend(errp, "kernel_irqchip requested but unavailabl=
e: ");
> +            return;
> +        }
> +    }
> +
> +    if (!spapr->ics) {
> +        xics_spapr_init(spapr);
> +        spapr->icp_type =3D TYPE_ICP;
> +        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,=
 errp);
> +        if (!spapr->ics) {
> +            return;
> +        }
> +    }
> +}
> +
> +#define ICS_IRQ_FREE(ics, srcno)                                \
> +    (!((ics)->irqs[(srcno)].flags & (XICS_FLAGS_IRQ_MASK)))
> +
> +static int ics_find_free_block(ICSState *ics, int num, int alignnum)
> +{
> +    int first, i;
> +
> +    for (first =3D 0; first < ics->nr_irqs; first +=3D alignnum) {
> +        if (num > (ics->nr_irqs - first)) {
> +            return -1;
> +        }
> +        for (i =3D first; i < first + num; ++i) {
> +            if (!ICS_IRQ_FREE(ics, i)) {
> +                break;
> +            }
> +        }
> +        if (i =3D=3D (first + num)) {
> +            return first;
> +        }
> +    }
> +
> +    return -1;
> +}
> +
> +static int spapr_irq_alloc_2_12(sPAPRMachineState *spapr,
> +                                uint32_t range, uint32_t index, Error **=
errp)
> +{
> +    ICSState *ics =3D spapr->ics;
> +    bool lsi =3D (range =3D=3D SPAPR_IRQ_PCI_LSI);
> +    int srcno;
> +
> +    assert(ics);
> +
> +    srcno =3D ics_find_free_block(ics, 1, 1);
> +    if (srcno < 0) {
> +        error_setg(errp, "can't allocate IRQ: no IRQ left");
> +        return -1;
> +    }
> +
> +    ics_set_irq_type(ics, srcno, lsi);
> +    trace_spapr_irq_alloc(srcno);
> +
> +    return ics->offset + srcno;
> +}
> +
> +/*
> + * Allocate block of consecutive IRQs, and return the number of the firs=
t IRQ in
> + * the block. If align=3D=3Dtrue, aligns the first IRQ number to num.
> + */
> +static int spapr_irq_alloc_block_2_12(sPAPRMachineState *spapr, uint32_t=
 range,
> +                                      uint32_t index, int num, bool alig=
n,
> +                                      Error **errp)
> +{
> +    ICSState *ics =3D spapr->ics;
> +    bool lsi =3D (range =3D=3D SPAPR_IRQ_PCI_LSI);
> +    int i, srcno;
> +
> +    assert(ics);
> +
> +    /*
> +     * MSIMessage::data is used for storing VIRQ so it has to be
> +     * aligned to num to support multiple MSI vectors. MSI-X is not
> +     * affected by this.
> +     */
> +    if (align) {
> +        assert((num =3D=3D 1) || (num =3D=3D 2) || (num =3D=3D 4) ||
> +               (num =3D=3D 8) || (num =3D=3D 16) || (num =3D=3D 32));
> +        srcno =3D ics_find_free_block(ics, num, num);
> +    } else {
> +        srcno =3D ics_find_free_block(ics, num, 1);
> +    }
> +
> +    if (srcno < 0) {
> +        error_setg(errp, "can't find a free %d-IRQ block", num);
> +        return -1;
> +    }
> +
> +    for (i =3D srcno; i < srcno + num; ++i) {
> +        ics_set_irq_type(ics, i, lsi);
> +    }
> +
> +    trace_spapr_irq_alloc_block(srcno, num, lsi, align);
> +
> +    return ics->offset + srcno;
> +}
> +
> +static void spapr_irq_free_2_12(sPAPRMachineState *spapr, int irq, int n=
um,
> +                                Error **errp)
> +{
> +    ICSState *ics =3D spapr->ics;
> +    uint32_t srcno =3D irq - ics->offset;
> +    int i;
> +
> +    if (ics_valid_irq(ics, irq)) {
> +        trace_spapr_irq_free(0, irq, num);
> +        for (i =3D srcno; i < srcno + num; ++i) {
> +            if (ICS_IRQ_FREE(ics, i)) {
> +                trace_spapr_irq_free_warn(0, i);
> +            }
> +            memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
> +        }
> +    }
> +}
> +
> +static qemu_irq spapr_qirq_2_12(sPAPRMachineState *spapr, int irq)
> +{
> +    ICSState *ics =3D spapr->ics;
> +    uint32_t srcno =3D irq - ics->offset;
> +
> +    if (ics_valid_irq(ics, irq)) {
> +        return ics->qirqs[srcno];
> +    }
> +
> +    return NULL;
> +}
> +
> +sPAPRIrq spapr_irq_default =3D {
> +    .nr_irqs     =3D XICS_IRQS_SPAPR,
> +    .init        =3D spapr_irq_init_2_12,
> +    .alloc       =3D spapr_irq_alloc_2_12,
> +    .alloc_block =3D spapr_irq_alloc_block_2_12,
> +    .free        =3D spapr_irq_free_2_12,
> +    .qirq        =3D spapr_qirq_2_12,
> +};
> +
> +int spapr_irq_alloc(sPAPRMachineState *spapr, uint32_t range, uint32_t i=
ndex,
> +                    Error **errp)
> +{
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +
> +    return smc->irq->alloc(spapr, range, index, errp);
> +}
> +
> +int spapr_irq_alloc_block(sPAPRMachineState *spapr, uint32_t range,
> +                          uint32_t index, int num, bool align, Error **e=
rrp)
> +{
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +
> +    return smc->irq->alloc_block(spapr, range, index, num, align, errp);
> +}
> +
> +void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num,
> +                    Error **errp)
> +{
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +
> +    smc->irq->free(spapr, irq, num, errp);
> +}
> +
> +qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq)
> +{
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +
> +    return smc->irq->qirq(spapr, irq);
> +}
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 4fd97ffe4c6e..cca4169fa10b 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -333,7 +333,12 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
>              return;
>          }
> =20
> -        spapr_irq_free(spapr, msi->first_irq, msi->num);
> +        spapr_irq_free(spapr, msi->first_irq, msi->num, &err);
> +        if (err) {
> +            error_reportf_err(err, "Can't remove MSIs for device %x: ",
> +                              config_addr);
> +            rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> +        }
>          if (msi_present(pdev)) {
>              spapr_msi_setmsg(pdev, 0, false, 0, 0);
>          }
> @@ -371,8 +376,8 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
>      }
> =20
>      /* Allocate MSIs */
> -    irq =3D spapr_irq_alloc_block(spapr, req_num, false,
> -                           ret_intr_type =3D=3D RTAS_TYPE_MSI, &err);
> +    irq =3D spapr_irq_alloc_block(spapr, SPAPR_IRQ_PCI_MSI, phb->index, =
req_num,
> +                                ret_intr_type =3D=3D RTAS_TYPE_MSI, &err=
);
>      if (err) {
>          error_reportf_err(err, "Can't allocate MSIs for device %x: ",
>                            config_addr);
> @@ -382,7 +387,11 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
> =20
>      /* Release previous MSIs */
>      if (msi) {
> -        spapr_irq_free(spapr, msi->first_irq, msi->num);
> +        spapr_irq_free(spapr, msi->first_irq, msi->num, &err);
> +        if (err) {
> +            error_reportf_err(err, "Can't remove MSIs for device %x: ",
> +                              config_addr);
> +        }
>          g_hash_table_remove(phb->msi, &config_addr);
>      }
> =20
> @@ -1696,7 +1705,8 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>      QLIST_INSERT_HEAD(&spapr->phbs, sphb, list);
> =20
>      /* Initialize the LSI table */
> -    irq =3D spapr_irq_alloc_block(spapr, PCI_NUM_PINS, true, false, &loc=
al_err);
> +    irq =3D spapr_irq_alloc_block(spapr, SPAPR_IRQ_PCI_LSI, sphb->index,
> +                                PCI_NUM_PINS, false, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          error_prepend(errp, "can't allocate LSIs: ");
> @@ -2112,6 +2122,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
>      _FDT(fdt_setprop(fdt, bus_off, "ranges", &ranges, sizeof_ranges));
>      _FDT(fdt_setprop(fdt, bus_off, "reg", &bus_reg, sizeof(bus_reg)));
>      _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pci-config-space-type", 0x1=
));
> +    /* TODO: fix the total count of allocatable MSIs per PHB */
>      _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", XICS_IRQS_S=
PAPR));
> =20
>      /* Dynamic DMA window */
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index cc064f64fccf..7ec69a29d806 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -416,6 +416,9 @@ static void spapr_vio_busdev_reset(DeviceState *qdev)
>      }
>  }
> =20
> +/* TODO : poor VIO device indexing ... */
> +static uint32_t vio_index;
> +
>  static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> @@ -455,7 +458,7 @@ static void spapr_vio_busdev_realize(DeviceState *qde=
v, Error **errp)
>          dev->qdev.id =3D id;
>      }
> =20
> -    dev->irq =3D spapr_irq_alloc(spapr, false, &local_err);
> +    dev->irq =3D spapr_irq_alloc(spapr, SPAPR_IRQ_VIO, vio_index++, &loc=
al_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index 86d82a6ec3ac..4fe3b7804d43 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -4,7 +4,7 @@ obj-y +=3D ppc.o ppc_booke.o fdt.o
>  obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio.o spapr_events=
=2Eo
>  obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o
>  obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o spapr_rng=
=2Eo
> -obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o
> +obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
>  # IBM PowerNV
>  obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o pnv_occ.o pnv_bmc.o
>  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--87MiR7gHvrw39A9h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsgpOoACgkQbDjKyiDZ
s5JRWQ/+JDeK4fKJa6J4Qld4xXbEbTtFR08tPK4l20O4KQ51aFSxjGuxsdPrI5BD
hknajb5ONKjUCqteNkpHY5gnJnIBIU/v/8BLt70iq/u6PfeocCUwBbNekk/jmnRp
eD42pQTMJmj55MlR6Pozqzr3GQe15Q9YEi6K4u/kLtE3/Sf2EwLXTuRDGaU00nri
CR4/3RDr1fyfS6TKC0Ovycgc4M6ZtDvpqGwJl8WOWn0T5ndyBJpqtSX1cfrHj9WY
AlB0xAAQfhci/unQKxtvJvhaUo9DEivoTTnVC0o3SiU1Z4yOKpfAMWjXxyhY5Rdk
eZ7q1QEEZGQyfOUYE1eJaH92qrMS4pXlwrJh516AoGC5aO/kmCKHVQrm3LvqJIyh
u5+ykP9daw3NVSEqkhX7rjpTwHYf7GycbcP1wbmXSfCewtqRBk2De/AZ1X+FCqmz
psw5YQYC8xtx3udOckN36paxwxcb8eDDXTjetjxV+JygP9HwoltetxT3X5aBDmY+
b6Mmbf9IVxzkjRZw1WS+nP9bkwgoj9/dWADHrmaJQFUFihAWJBneb4o6NNEx/7xs
fJNPr0SdpG75w/xn9pO3BjVlMUgrqhsqffcNZCf5/ZWsGinTDgQkcTmBrrnspAvD
WjkM7qpf8MTxWU6tsNDE+fvBOZUlcQasAFgTzhKd8NhU9wVXE2A=
=6bnN
-----END PGP SIGNATURE-----

--87MiR7gHvrw39A9h--
