Received: from eggs.gnu.org ([2001:4830:134:3::10]:59059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dIICI-0005kH-2F
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dIICD-0000L4-3R
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:23:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46028
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dIICC-0000Ks-SL
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:23:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v56HIXF9129925
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 13:23:07 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2awp6c2uug-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 13:23:07 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Jun 2017 13:23:07 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170606083221.9299-2-david@gibson.dropbear.id.au>
References: <20170606083221.9299-1-david@gibson.dropbear.id.au>
	<20170606083221.9299-2-david@gibson.dropbear.id.au>
Date: Tue, 06 Jun 2017 11:19:56 -0500
Message-Id: <149676599639.2548.15222278548733163033@loki>
Subject: Re: [Qemu-devel] [PATCH 1/7] spapr: Clean up DR entity sense
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org

Quoting David Gibson (2017-06-06 03:32:15)
> DRC classes have an entity_sense method to determine (in a specific PAPR
> sense) the presence or absence of a device plugged into a DRC.  However,
> we only have one implementation of the method, which explicitly tests for
> different DRC types.  This changes it to instead have different method
> implementations for the two cases: "logical" and "physical" DRCs.
> =

> While we're at it, the entity sense method always returns RTAS_OUT_SUCCES=
S,
> and the interesting value is returned via pass-by-reference.  Simplify th=
is
> to directly return the value we care about
> =

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_drc.c         | 76 ++++++++++++++++++++++++----------------=
------
>  hw/ppc/spapr_pci.c         |  6 ++--
>  hw/ppc/trace-events        |  1 -
>  include/hw/ppc/spapr_drc.h |  4 +--
>  4 files changed, 44 insertions(+), 43 deletions(-)
> =

> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 39e7f30..da3779e 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -185,39 +185,29 @@ static void set_signalled(sPAPRDRConnector *drc)
>   * based on the current allocation/indicator/power states
>   * for the DR connector.
>   */
> -static uint32_t entity_sense(sPAPRDRConnector *drc, sPAPRDREntitySense *=
state)
> +static sPAPRDREntitySense physical_entity_sense(sPAPRDRConnector *drc)
>  {
> -    if (drc->dev) {
> -        if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI &&
> -            drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_UNUSA=
BLE) {
> -            /* for logical DR, we return a state of UNUSABLE
> -             * iff the allocation state UNUSABLE.
> -             * Otherwise, report the state as USABLE/PRESENT,
> -             * as we would for PCI.
> -             */
> -            *state =3D SPAPR_DR_ENTITY_SENSE_UNUSABLE;
> -        } else {
> -            /* this assumes all PCI devices are assigned to
> -             * a 'live insertion' power domain, where QEMU
> -             * manages power state automatically as opposed
> -             * to the guest. present, non-PCI resources are
> -             * unaffected by power state.
> -             */
> -            *state =3D SPAPR_DR_ENTITY_SENSE_PRESENT;
> -        }
> +    /* this assumes all PCI devices are assigned to a 'live insertion'
> +     * power domain, where QEMU manages power state automatically as
> +     * opposed to the guest. present, non-PCI resources are unaffected
> +     * by power state.
> +     */
> +    return drc->dev ? SPAPR_DR_ENTITY_SENSE_PRESENT
> +        : SPAPR_DR_ENTITY_SENSE_EMPTY;
> +}
> +
> +static sPAPRDREntitySense logical_entity_sense(sPAPRDRConnector *drc)
> +{
> +    /* for logical DR, we return a state of UNUSABLE iff the
> +     * allocation state UNUSABLE.  Otherwise, report the state as
> +     * USABLE/PRESENT, as we would for PCI.
> +     */

Now that it's outside of the drc->dev block this comment isn't quite
accurate. And any rewordings I come up with in this new context
basically end up just describing the code (nice), so I think it should
just be dropped.

Otherwise:

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> +    if (drc->dev
> +        && (drc->allocation_state !=3D SPAPR_DR_ALLOCATION_STATE_UNUSABL=
E)) {
> +        return SPAPR_DR_ENTITY_SENSE_PRESENT;
>      } else {
> -        if (spapr_drc_type(drc) =3D=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> -            /* PCI devices, and only PCI devices, use EMPTY
> -             * in cases where we'd otherwise use UNUSABLE
> -             */
> -            *state =3D SPAPR_DR_ENTITY_SENSE_EMPTY;
> -        } else {
> -            *state =3D SPAPR_DR_ENTITY_SENSE_UNUSABLE;
> -        }
> +        return SPAPR_DR_ENTITY_SENSE_UNUSABLE;
>      }
> -
> -    trace_spapr_drc_entity_sense(spapr_drc_index(drc), *state);
> -    return RTAS_OUT_SUCCESS;
>  }
> =

>  static void prop_get_index(Object *obj, Visitor *v, const char *name,
> @@ -445,7 +435,6 @@ static void reset(DeviceState *d)
>  {
>      sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
>      sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -    sPAPRDREntitySense state;
> =

>      trace_spapr_drc_reset(spapr_drc_index(drc));
> =

> @@ -477,8 +466,7 @@ static void reset(DeviceState *d)
>          }
>      }
> =

> -    drck->entity_sense(drc, &state);
> -    if (state =3D=3D SPAPR_DR_ENTITY_SENSE_PRESENT) {
> +    if (drck->dr_entity_sense(drc) =3D=3D SPAPR_DR_ENTITY_SENSE_PRESENT)=
 {
>          drck->set_signalled(drc);
>      }
>  }
> @@ -488,8 +476,7 @@ static bool spapr_drc_needed(void *opaque)
>      sPAPRDRConnector *drc =3D (sPAPRDRConnector *)opaque;
>      sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>      bool rc =3D false;
> -    sPAPRDREntitySense value;
> -    drck->entity_sense(drc, &value);
> +    sPAPRDREntitySense value =3D drck->dr_entity_sense(drc);
> =

>      /* If no dev is plugged in there is no need to migrate the DRC state=
 */
>      if (value !=3D SPAPR_DR_ENTITY_SENSE_PRESENT) {
> @@ -667,7 +654,6 @@ static void spapr_dr_connector_class_init(ObjectClass=
 *k, void *data)
>      drck->set_indicator_state =3D set_indicator_state;
>      drck->set_allocation_state =3D set_allocation_state;
>      drck->get_name =3D get_name;
> -    drck->entity_sense =3D entity_sense;
>      drck->attach =3D attach;
>      drck->detach =3D detach;
>      drck->release_pending =3D release_pending;
> @@ -678,6 +664,20 @@ static void spapr_dr_connector_class_init(ObjectClas=
s *k, void *data)
>      dk->user_creatable =3D false;
>  }
> =

> +static void spapr_drc_physical_class_init(ObjectClass *k, void *data)
> +{
> +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
> +
> +    drck->dr_entity_sense =3D physical_entity_sense;
> +}
> +
> +static void spapr_drc_logical_class_init(ObjectClass *k, void *data)
> +{
> +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
> +
> +    drck->dr_entity_sense =3D logical_entity_sense;
> +}
> +
>  static void spapr_drc_cpu_class_init(ObjectClass *k, void *data)
>  {
>      sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
> @@ -716,6 +716,7 @@ static const TypeInfo spapr_drc_physical_info =3D {
>      .name          =3D TYPE_SPAPR_DRC_PHYSICAL,
>      .parent        =3D TYPE_SPAPR_DR_CONNECTOR,
>      .instance_size =3D sizeof(sPAPRDRConnector),
> +    .class_init    =3D spapr_drc_physical_class_init,
>      .abstract      =3D true,
>  };
> =

> @@ -723,6 +724,7 @@ static const TypeInfo spapr_drc_logical_info =3D {
>      .name          =3D TYPE_SPAPR_DRC_LOGICAL,
>      .parent        =3D TYPE_SPAPR_DR_CONNECTOR,
>      .instance_size =3D sizeof(sPAPRDRConnector),
> +    .class_init    =3D spapr_drc_logical_class_init,
>      .abstract      =3D true,
>  };
> =

> @@ -1010,7 +1012,7 @@ static void rtas_get_sensor_state(PowerPCCPU *cpu, =
sPAPRMachineState *spapr,
>          goto out;
>      }
>      drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -    ret =3D drck->entity_sense(drc, &sensor_state);
> +    sensor_state =3D drck->dr_entity_sense(drc);
> =

>  out:
>      rtas_st(rets, 0, ret);
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 0c181bb..5cba8f9 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1481,7 +1481,7 @@ static void spapr_phb_hot_plug_child(HotplugHandler=
 *plug_handler,
>              func_drc =3D spapr_phb_get_pci_func_drc(phb, pci_bus_num(bus=
),
>                                                    PCI_DEVFN(slotnr, i));
>              func_drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(func_drc);
> -            func_drck->entity_sense(func_drc, &state);
> +            state =3D func_drck->dr_entity_sense(func_drc);
> =

>              if (state =3D=3D SPAPR_DR_ENTITY_SENSE_PRESENT) {
>                  spapr_hotplug_req_add_by_index(func_drc);
> @@ -1522,7 +1522,7 @@ static void spapr_phb_hot_unplug_child(HotplugHandl=
er *plug_handler,
>                  func_drc =3D spapr_phb_get_pci_func_drc(phb, pci_bus_num=
(bus),
>                                                        PCI_DEVFN(slotnr, =
i));
>                  func_drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(func_drc);
> -                func_drck->entity_sense(func_drc, &state);
> +                state =3D func_drck->dr_entity_sense(func_drc);
>                  if (state =3D=3D SPAPR_DR_ENTITY_SENSE_PRESENT
>                      && !func_drck->release_pending(func_drc)) {
>                      error_setg(errp,
> @@ -1548,7 +1548,7 @@ static void spapr_phb_hot_unplug_child(HotplugHandl=
er *plug_handler,
>                  func_drc =3D spapr_phb_get_pci_func_drc(phb, pci_bus_num=
(bus),
>                                                        PCI_DEVFN(slotnr, =
i));
>                  func_drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(func_drc);
> -                func_drck->entity_sense(func_drc, &state);
> +                state =3D func_drck->dr_entity_sense(func_drc);
>                  if (state =3D=3D SPAPR_DR_ENTITY_SENSE_PRESENT) {
>                      spapr_hotplug_req_remove_by_index(func_drc);
>                  }
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 43d265f..4979397 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -44,7 +44,6 @@ spapr_drc_set_allocation_state(uint32_t index, int stat=
e) "drc: 0x%"PRIx32", sta
>  spapr_drc_set_allocation_state_finalizing(uint32_t index) "drc: 0x%"PRIx=
32
>  spapr_drc_set_configured(uint32_t index) "drc: 0x%"PRIx32
>  spapr_drc_set_configured_skipping(uint32_t index) "drc: 0x%"PRIx32", iso=
lated device"
> -spapr_drc_entity_sense(uint32_t index, int state) "drc: 0x%"PRIx32", sta=
te: 0x%x"
>  spapr_drc_attach(uint32_t index) "drc: 0x%"PRIx32
>  spapr_drc_detach(uint32_t index) "drc: 0x%"PRIx32
>  spapr_drc_awaiting_isolated(uint32_t index) "drc: 0x%"PRIx32
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index c88e1be..f892b94 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -214,6 +214,8 @@ typedef struct sPAPRDRConnectorClass {
>      sPAPRDRConnectorTypeShift typeshift;
>      const char *typename; /* used in device tree, PAPR 13.5.2.6 & C.6.1 =
*/
> =

> +    sPAPRDREntitySense (*dr_entity_sense)(sPAPRDRConnector *drc);
> +
>      /* accessors for guest-visible (generally via RTAS) DR state */
>      uint32_t (*set_isolation_state)(sPAPRDRConnector *drc,
>                                      sPAPRDRIsolationState state);
> @@ -223,8 +225,6 @@ typedef struct sPAPRDRConnectorClass {
>                                       sPAPRDRAllocationState state);
>      const char *(*get_name)(sPAPRDRConnector *drc);
> =

> -    uint32_t (*entity_sense)(sPAPRDRConnector *drc, sPAPRDREntitySense *=
state);
> -
>      /* QEMU interfaces for managing hotplug operations */
>      void (*attach)(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
>                     int fdt_start_offset, bool coldplug, Error **errp);
> -- =

> 2.9.4
>=20
