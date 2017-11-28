Received: from eggs.gnu.org ([2001:4830:134:3::10]:46337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eJdaZ-0001Lf-4C
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eJdaS-0003ED-8m
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:58:07 -0500
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:45948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eJdaR-0003Dq-Ve
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:58:00 -0500
Received: from player690.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 5F0717C665
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 11:57:58 +0100 (CET)
Date: Tue, 28 Nov 2017 11:57:53 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171128115753.0c498235@bahia.lan>
In-Reply-To: <20171123132955.1261-5-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 04/25] spapr: move the IRQ
 allocation routines under the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Thu, 23 Nov 2017 14:29:34 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> Also change the prototype to use a sPAPRMachineState and prefix them
> with spapr_irq_. It will let us synchronise the IRQ allocation with
> the XIVE interrupt mode when available.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/intc/trace-events   |   4 --
>  hw/intc/xics_spapr.c   | 114 -------------------------------------------=
------
>  hw/ppc/spapr.c         | 114 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/spapr_events.c  |   4 +-
>  hw/ppc/spapr_pci.c     |   8 ++--
>  hw/ppc/spapr_vio.c     |   2 +-
>  hw/ppc/trace-events    |   4 ++
>  include/hw/ppc/spapr.h |   6 +++
>  include/hw/ppc/xics.h  |   4 --
>  9 files changed, 131 insertions(+), 129 deletions(-)
>=20
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index b298fac7c6a8..7077aaaee6d0 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -64,10 +64,6 @@ xics_ics_simple_set_irq_lsi(int srcno, int nr) "set_ir=
q_lsi: srcno %d [irq 0x%x]
>  xics_ics_simple_write_xive(int nr, int srcno, int server, uint8_t priori=
ty) "ics_write_xive: irq 0x%x [src %d] server 0x%x prio 0x%x"
>  xics_ics_simple_reject(int nr, int srcno) "reject irq 0x%x [src %d]"
>  xics_ics_simple_eoi(int nr) "ics_eoi: irq 0x%x"
> -xics_alloc(int irq) "irq %d"
> -xics_alloc_block(int first, int num, bool lsi, int align) "first irq %d,=
 %d irqs, lsi=3D%d, alignnum %d"
> -xics_ics_free(int src, int irq, int num) "Source#%d, first irq %d, %d ir=
qs"
> -xics_ics_free_warn(int src, int irq) "Source#%d, irq %d is already free"
> =20
>  # hw/intc/s390_flic_kvm.c
>  flic_create_device(int err) "flic: create device failed %d"
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index e8c0a1b3e903..5a0967caf430 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -245,120 +245,6 @@ void xics_spapr_init(sPAPRMachineState *spapr)
>      spapr_register_hypercall(H_IPOLL, h_ipoll);
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
> -int spapr_ics_alloc(ICSState *ics, int irq_hint, bool lsi, Error **errp)
> -{
> -    int irq;
> -
> -    if (!ics) {
> -        return -1;
> -    }
> -    if (irq_hint) {
> -        if (!ICS_IRQ_FREE(ics, irq_hint - ics->offset)) {
> -            error_setg(errp, "can't allocate IRQ %d: already in use", ir=
q_hint);
> -            return -1;
> -        }
> -        irq =3D irq_hint;
> -    } else {
> -        irq =3D ics_find_free_block(ics, 1, 1);
> -        if (irq < 0) {
> -            error_setg(errp, "can't allocate IRQ: no IRQ left");
> -            return -1;
> -        }
> -        irq +=3D ics->offset;
> -    }
> -
> -    ics_set_irq_type(ics, irq - ics->offset, lsi);
> -    trace_xics_alloc(irq);
> -
> -    return irq;
> -}
> -
> -/*
> - * Allocate block of consecutive IRQs, and return the number of the firs=
t IRQ in
> - * the block. If align=3D=3Dtrue, aligns the first IRQ number to num.
> - */
> -int spapr_ics_alloc_block(ICSState *ics, int num, bool lsi,
> -                          bool align, Error **errp)
> -{
> -    int i, first =3D -1;
> -
> -    if (!ics) {
> -        return -1;
> -    }
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
> -    for (i =3D first; i < first + num; ++i) {
> -        ics_set_irq_type(ics, i, lsi);
> -    }
> -    first +=3D ics->offset;
> -
> -    trace_xics_alloc_block(first, num, lsi, align);
> -
> -    return first;
> -}
> -
> -static void ics_free(ICSState *ics, int srcno, int num)
> -{
> -    int i;
> -
> -    for (i =3D srcno; i < srcno + num; ++i) {
> -        if (ICS_IRQ_FREE(ics, i)) {
> -            trace_xics_ics_free_warn(0, i + ics->offset);
> -        }
> -        memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
> -    }
> -}
> -
> -void spapr_ics_free(ICSState *ics, int irq, int num)
> -{
> -    if (ics_valid_irq(ics, irq)) {
> -        trace_xics_ics_free(0, irq, num);
> -        ics_free(ics, irq - ics->offset, num);
> -    }
> -}
> -
>  void spapr_dt_xics(int nr_servers, void *fdt, uint32_t phandle)
>  {
>      uint32_t interrupt_server_ranges_prop[] =3D {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 925cbd3c1bf4..7ae84d40bdb4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3570,6 +3570,120 @@ Object *spapr_icp_create(sPAPRMachineState *spapr=
, CPUState *cs, Error **errp)
>      return obj;
>  }
> =20
> +#define ICS_IRQ_FREE(ics, srcno)   \
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
> +int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
> +                    Error **errp)
> +{
> +    ICSState *ics =3D spapr->ics;
> +    int irq;
> +
> +    if (!ics) {
> +        return -1;
> +    }
> +    if (irq_hint) {
> +        if (!ICS_IRQ_FREE(ics, irq_hint - ics->offset)) {
> +            error_setg(errp, "can't allocate IRQ %d: already in use", ir=
q_hint);
> +            return -1;
> +        }
> +        irq =3D irq_hint;
> +    } else {
> +        irq =3D ics_find_free_block(ics, 1, 1);
> +        if (irq < 0) {
> +            error_setg(errp, "can't allocate IRQ: no IRQ left");
> +            return -1;
> +        }
> +        irq +=3D ics->offset;
> +    }
> +
> +    ics_set_irq_type(ics, irq - ics->offset, lsi);
> +    trace_spapr_irq_alloc(irq);
> +
> +    return irq;
> +}
> +
> +/*
> + * Allocate block of consecutive IRQs, and return the number of the firs=
t IRQ in
> + * the block. If align=3D=3Dtrue, aligns the first IRQ number to num.
> + */
> +int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi,
> +                          bool align, Error **errp)
> +{
> +    ICSState *ics =3D spapr->ics;
> +    int i, first =3D -1;
> +
> +    if (!ics) {
> +        return -1;
> +    }
> +
> +    /*
> +     * MSIMesage::data is used for storing VIRQ so
> +     * it has to be aligned to num to support multiple
> +     * MSI vectors. MSI-X is not affected by this.
> +     * The hint is used for the first IRQ, the rest should
> +     * be allocated continuously.
> +     */
> +    if (align) {
> +        assert((num =3D=3D 1) || (num =3D=3D 2) || (num =3D=3D 4) ||
> +               (num =3D=3D 8) || (num =3D=3D 16) || (num =3D=3D 32));
> +        first =3D ics_find_free_block(ics, num, num);
> +    } else {
> +        first =3D ics_find_free_block(ics, num, 1);
> +    }
> +    if (first < 0) {
> +        error_setg(errp, "can't find a free %d-IRQ block", num);
> +        return -1;
> +    }
> +
> +    for (i =3D first; i < first + num; ++i) {
> +        ics_set_irq_type(ics, i, lsi);
> +    }
> +    first +=3D ics->offset;
> +
> +    trace_spapr_irq_alloc_block(first, num, lsi, align);
> +
> +    return first;
> +}
> +
> +void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num)
> +{
> +    ICSState *ics =3D spapr->ics;
> +    int srcno =3D irq - ics->offset;
> +    int i;
> +
> +    if (ics_valid_irq(ics, irq)) {
> +        trace_spapr_irq_free(0, irq, num);
> +        for (i =3D srcno; i < srcno + num; ++i) {
> +            if (ICS_IRQ_FREE(ics, i)) {
> +                trace_spapr_irq_free_warn(0, i + ics->offset);
> +            }
> +            memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
> +        }
> +    }
> +}
> +
>  static void spapr_pic_print_info(InterruptStatsProvider *obj,
>                                   Monitor *mon)
>  {
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index e377fc7ddea2..cead596f3e7a 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -718,7 +718,7 @@ void spapr_events_init(sPAPRMachineState *spapr)
>      spapr->event_sources =3D spapr_event_sources_new();
> =20
>      spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_EPOW,
> -                                 spapr_ics_alloc(spapr->ics, 0, false,
> +                                 spapr_irq_alloc(spapr, 0, false,
>                                                    &error_fatal));
> =20
>      /* NOTE: if machine supports modern/dedicated hotplug event source,
> @@ -731,7 +731,7 @@ void spapr_events_init(sPAPRMachineState *spapr)
>       */
>      if (spapr->use_hotplug_event_source) {
>          spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_H=
OT_PLUG,
> -                                     spapr_ics_alloc(spapr->ics, 0, fals=
e,
> +                                     spapr_irq_alloc(spapr, 0, false,
>                                                        &error_fatal));
>      }
> =20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 5a3122a9f9f9..e0ef77a480e5 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -314,7 +314,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
>              return;
>          }
> =20
> -        spapr_ics_free(spapr->ics, msi->first_irq, msi->num);
> +        spapr_irq_free(spapr, msi->first_irq, msi->num);
>          if (msi_present(pdev)) {
>              spapr_msi_setmsg(pdev, 0, false, 0, 0);
>          }
> @@ -352,7 +352,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
>      }
> =20
>      /* Allocate MSIs */
> -    irq =3D spapr_ics_alloc_block(spapr->ics, req_num, false,
> +    irq =3D spapr_irq_alloc_block(spapr, req_num, false,
>                             ret_intr_type =3D=3D RTAS_TYPE_MSI, &err);
>      if (err) {
>          error_reportf_err(err, "Can't allocate MSIs for device %x: ",
> @@ -363,7 +363,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
> =20
>      /* Release previous MSIs */
>      if (msi) {
> -        spapr_ics_free(spapr->ics, msi->first_irq, msi->num);
> +        spapr_irq_free(spapr, msi->first_irq, msi->num);
>          g_hash_table_remove(phb->msi, &config_addr);
>      }
> =20
> @@ -1675,7 +1675,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>          uint32_t irq;
>          Error *local_err =3D NULL;
> =20
> -        irq =3D spapr_ics_alloc_block(spapr->ics, 1, true, false, &local=
_err);
> +        irq =3D spapr_irq_alloc_block(spapr, 1, true, false, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
>              error_prepend(errp, "can't allocate LSIs: ");
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index ea3bc8bd9e21..bb7ed2c537b0 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -454,7 +454,7 @@ static void spapr_vio_busdev_realize(DeviceState *qde=
v, Error **errp)
>          dev->qdev.id =3D id;
>      }
> =20
> -    dev->irq =3D spapr_ics_alloc(spapr->ics, dev->irq, false, &local_err=
);
> +    dev->irq =3D spapr_irq_alloc(spapr, dev->irq, false, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 4a6a6490fa78..b7c3e64b5ee7 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -12,6 +12,10 @@ spapr_pci_msi_retry(unsigned config_addr, unsigned req=
_num, unsigned max_irqs) "
>  # hw/ppc/spapr.c
>  spapr_cas_failed(unsigned long n) "DT diff buffer is too small: %ld byte=
s"
>  spapr_cas_continue(unsigned long n) "Copy changes to the guest: %ld byte=
s"
> +spapr_irq_alloc(int irq) "irq %d"
> +spapr_irq_alloc_block(int first, int num, bool lsi, int align) "first ir=
q %d, %d irqs, lsi=3D%d, alignnum %d"
> +spapr_irq_free(int src, int irq, int num) "Source#%d, first irq %d, %d i=
rqs"
> +spapr_irq_free_warn(int src, int irq) "Source#%d, irq %d is already free"
> =20
>  # hw/ppc/spapr_hcall.c
>  spapr_cas_pvr_try(uint32_t pvr) "0x%x"
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9da38de34277..7a133f80411a 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -709,4 +709,10 @@ PowerPCCPU *spapr_find_cpu(int vcpu_id);
> =20
>  Object *spapr_icp_create(sPAPRMachineState *spapr, CPUState *cs, Error *=
*errp);
> =20
> +int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
> +                    Error **errp);
> +int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi,
> +                          bool align, Error **errp);
> +void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
> +
>  #endif /* HW_SPAPR_H */
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 126b47dec38b..cea462bc7f3e 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -181,10 +181,6 @@ typedef struct XICSFabricClass {
> =20
>  #define XICS_IRQS_SPAPR               1024
> =20
> -int spapr_ics_alloc(ICSState *ics, int irq_hint, bool lsi, Error **errp);
> -int spapr_ics_alloc_block(ICSState *ics, int num, bool lsi, bool align,
> -                           Error **errp);
> -void spapr_ics_free(ICSState *ics, int irq, int num);
>  void spapr_dt_xics(int nr_servers, void *fdt, uint32_t phandle);
> =20
>  qemu_irq xics_get_qirq(XICSFabric *xi, int irq);
