Received: from eggs.gnu.org ([2001:4830:134:3::10]:48726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dHHd7-0001is-4O
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 18:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dHHd3-00035L-UP
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 18:34:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50588
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dHHd3-00030u-NW
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 18:34:41 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v53MY2ee007592
	for <qemu-devel@nongnu.org>; Sat, 3 Jun 2017 18:34:39 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2auvmenuea-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 03 Jun 2017 18:34:39 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Sat, 3 Jun 2017 16:34:38 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170602072952.25454-3-david@gibson.dropbear.id.au>
References: <20170602072952.25454-1-david@gibson.dropbear.id.au>
	<20170602072952.25454-3-david@gibson.dropbear.id.au>
Date: Sat, 03 Jun 2017 17:16:36 -0500
Message-Id: <149652819608.2695.9298279172135290127@loki>
Subject: Re: [Qemu-devel] [PATCH 2/5] spapr: Clean up
 spapr_dr_connector_by_*()
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

Quoting David Gibson (2017-06-02 02:29:49)
>  * Change names to something less ludicrously verbose
>  * Now that we have QOM subclasses for the different DRC types, use a QOM
>    typename instead of a PAPR type value parameter
> =

> The latter allows removal of the get_type_shift() helper.
> =

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  hw/ppc/spapr.c             | 28 ++++++++++++++--------------
>  hw/ppc/spapr_drc.c         | 34 ++++++++++------------------------
>  hw/ppc/spapr_events.c      |  2 +-
>  hw/ppc/spapr_pci.c         |  6 ++----
>  include/hw/ppc/spapr_drc.h |  5 ++---
>  5 files changed, 29 insertions(+), 46 deletions(-)
> =

> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 456f9e7..7aac3b9 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -460,7 +460,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
>      uint32_t radix_AP_encodings[PPC_PAGE_SIZES_MAX_SZ];
>      int i;
> =

> -    drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index);
> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index);
>      if (drc) {
>          drc_index =3D spapr_drc_index(drc);
>          _FDT((fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_inde=
x)));
> @@ -653,7 +653,7 @@ static int spapr_populate_drconf_memory(sPAPRMachineS=
tate *spapr, void *fdt)
>          if (i >=3D hotplug_lmb_start) {
>              sPAPRDRConnector *drc;
> =

> -            drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB=
, i);
> +            drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, i);
>              g_assert(drc);
> =

>              dynamic_memory[0] =3D cpu_to_be32(addr >> 32);
> @@ -2528,8 +2528,8 @@ static void spapr_add_lmbs(DeviceState *dev, uint64=
_t addr_start, uint64_t size,
>      uint64_t addr =3D addr_start;
> =

>      for (i =3D 0; i < nr_lmbs; i++) {
> -        drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
> -                addr/SPAPR_MEMORY_BLOCK_SIZE);
> +        drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
> +                              addr / SPAPR_MEMORY_BLOCK_SIZE);
>          g_assert(drc);
> =

>          fdt =3D create_device_tree(&fdt_size);
> @@ -2550,8 +2550,8 @@ static void spapr_add_lmbs(DeviceState *dev, uint64=
_t addr_start, uint64_t size,
>       */
>      if (dev->hotplugged) {
>          if (dedicated_hp_event_source) {
> -            drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
> -                    addr_start / SPAPR_MEMORY_BLOCK_SIZE);
> +            drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
> +                                  addr_start / SPAPR_MEMORY_BLOCK_SIZE);
>              drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>              spapr_hotplug_req_add_by_count_indexed(SPAPR_DR_CONNECTOR_TY=
PE_LMB,
>                                                     nr_lmbs,
> @@ -2668,8 +2668,8 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_s=
tate(sPAPRMachineState *ms,
> =

>      addr =3D addr_start;
>      for (i =3D 0; i < nr_lmbs; i++) {
> -        drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
> -                                       addr / SPAPR_MEMORY_BLOCK_SIZE);
> +        drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
> +                              addr / SPAPR_MEMORY_BLOCK_SIZE);
>          g_assert(drc);
>          if (drc->indicator_state !=3D SPAPR_DR_INDICATOR_STATE_INACTIVE)=
 {
>              avail_lmbs++;
> @@ -2752,8 +2752,8 @@ static void spapr_memory_unplug_request(HotplugHand=
ler *hotplug_dev,
> =

>      addr =3D addr_start;
>      for (i =3D 0; i < nr_lmbs; i++) {
> -        drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
> -                addr / SPAPR_MEMORY_BLOCK_SIZE);
> +        drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
> +                              addr / SPAPR_MEMORY_BLOCK_SIZE);
>          g_assert(drc);
> =

>          drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> @@ -2761,8 +2761,8 @@ static void spapr_memory_unplug_request(HotplugHand=
ler *hotplug_dev,
>          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
>      }
> =

> -    drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
> -                                   addr_start / SPAPR_MEMORY_BLOCK_SIZE);
> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
> +                          addr_start / SPAPR_MEMORY_BLOCK_SIZE);
>      drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>      spapr_hotplug_req_remove_by_count_indexed(SPAPR_DR_CONNECTOR_TYPE_LM=
B,
>                                                nr_lmbs, spapr_drc_index(d=
rc));
> @@ -2833,7 +2833,7 @@ void spapr_core_unplug_request(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>          return;
>      }
> =

> -    drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index =
* smt);
> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * smt);
>      g_assert(drc);
> =

>      drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> @@ -2868,7 +2868,7 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
>                     cc->core_id);
>          return;
>      }
> -    drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index =
* smt);
> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * smt);
> =

>      g_assert(drc || !mc->has_hotpluggable_cpus);
> =

> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 690b41f..2514f87 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -55,21 +55,6 @@ static void spapr_ccs_remove(sPAPRMachineState *spapr,
>      g_free(ccs);
>  }
> =

> -static sPAPRDRConnectorTypeShift get_type_shift(sPAPRDRConnectorType typ=
e)
> -{
> -    uint32_t shift =3D 0;
> -
> -    /* make sure this isn't SPAPR_DR_CONNECTOR_TYPE_ANY, or some
> -     * other wonky value.
> -     */
> -    g_assert(is_power_of_2(type));
> -
> -    while (type !=3D (1 << shift)) {
> -        shift++;
> -    }
> -    return shift;
> -}
> -
>  sPAPRDRConnectorType spapr_drc_type(sPAPRDRConnector *drc)
>  {
>      sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> @@ -805,7 +790,7 @@ static const TypeInfo spapr_drc_lmb_info =3D {
> =

>  /* helper functions for external users */
> =

> -sPAPRDRConnector *spapr_dr_connector_by_index(uint32_t index)
> +sPAPRDRConnector *spapr_drc_by_index(uint32_t index)
>  {
>      Object *obj;
>      char name[256];
> @@ -816,12 +801,13 @@ sPAPRDRConnector *spapr_dr_connector_by_index(uint3=
2_t index)
>      return !obj ? NULL : SPAPR_DR_CONNECTOR(obj);
>  }
> =

> -sPAPRDRConnector *spapr_dr_connector_by_id(sPAPRDRConnectorType type,
> -                                           uint32_t id)
> +sPAPRDRConnector *spapr_drc_by_id(const char *type, uint32_t id)
>  {
> -    return spapr_dr_connector_by_index(
> -            (get_type_shift(type) << DRC_INDEX_TYPE_SHIFT) |
> -            (id & DRC_INDEX_ID_MASK));
> +    sPAPRDRConnectorClass *drck
> +        =3D SPAPR_DR_CONNECTOR_CLASS(object_class_by_name(type));
> +
> +    return spapr_drc_by_index(drck->typeshift << DRC_INDEX_TYPE_SHIFT
> +                              | (id & DRC_INDEX_ID_MASK));
>  }
> =

>  /* generate a string the describes the DRC to encode into the
> @@ -1024,7 +1010,7 @@ static void rtas_set_indicator(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
>      }
> =

>      /* if this is a DR sensor we can assume sensor_index =3D=3D drc_inde=
x */
> -    drc =3D spapr_dr_connector_by_index(sensor_index);
> +    drc =3D spapr_drc_by_index(sensor_index);
>      if (!drc) {
>          trace_spapr_rtas_set_indicator_invalid(sensor_index);
>          ret =3D RTAS_OUT_PARAM_ERROR;
> @@ -1097,7 +1083,7 @@ static void rtas_get_sensor_state(PowerPCCPU *cpu, =
sPAPRMachineState *spapr,
>          goto out;
>      }
> =

> -    drc =3D spapr_dr_connector_by_index(sensor_index);
> +    drc =3D spapr_drc_by_index(sensor_index);
>      if (!drc) {
>          trace_spapr_rtas_get_sensor_state_invalid(sensor_index);
>          ret =3D RTAS_OUT_PARAM_ERROR;
> @@ -1162,7 +1148,7 @@ static void rtas_ibm_configure_connector(PowerPCCPU=
 *cpu,
>      wa_addr =3D ((uint64_t)rtas_ld(args, 1) << 32) | rtas_ld(args, 0);
> =

>      drc_index =3D rtas_ld(wa_addr, 0);
> -    drc =3D spapr_dr_connector_by_index(drc_index);
> +    drc =3D spapr_drc_by_index(drc_index);
>      if (!drc) {
>          trace_spapr_rtas_ibm_configure_connector_invalid(drc_index);
>          rc =3D RTAS_OUT_PARAM_ERROR;
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 6b01b04..4ab2312 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -478,7 +478,7 @@ static void spapr_powerdown_req(Notifier *n, void *op=
aque)
> =

>  static void spapr_hotplug_set_signalled(uint32_t drc_index)
>  {
> -    sPAPRDRConnector *drc =3D spapr_dr_connector_by_index(drc_index);
> +    sPAPRDRConnector *drc =3D spapr_drc_by_index(drc_index);
>      sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>      drck->set_signalled(drc);
>  }
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 50d673b..0c181bb 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1400,10 +1400,8 @@ static sPAPRDRConnector *spapr_phb_get_pci_func_dr=
c(sPAPRPHBState *phb,
>                                                      uint32_t busnr,
>                                                      int32_t devfn)
>  {
> -    return spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_PCI,
> -                                    (phb->index << 16) |
> -                                    (busnr << 8) |
> -                                    devfn);
> +    return spapr_drc_by_id(TYPE_SPAPR_DRC_PCI,
> +                           (phb->index << 16) | (busnr << 8) | devfn);
>  }
> =

>  static sPAPRDRConnector *spapr_phb_get_pci_drc(sPAPRPHBState *phb,
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index f77be38..d8cb84b 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -230,9 +230,8 @@ sPAPRDRConnectorType spapr_drc_type(sPAPRDRConnector =
*drc);
> =

>  sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
>                                           uint32_t id);
> -sPAPRDRConnector *spapr_dr_connector_by_index(uint32_t index);
> -sPAPRDRConnector *spapr_dr_connector_by_id(sPAPRDRConnectorType type,
> -                                           uint32_t id);
> +sPAPRDRConnector *spapr_drc_by_index(uint32_t index);
> +sPAPRDRConnector *spapr_drc_by_id(const char *type, uint32_t id);
>  int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
>                            uint32_t drc_type_mask);
> =

> -- =

> 2.9.4
>=20
