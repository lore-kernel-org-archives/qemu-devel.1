Received: from eggs.gnu.org ([2001:4830:134:3::10]:41595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGSeo-0003fv-Qa
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGSek-0002Ms-NY
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:09:06 -0400
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:51966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dGSek-0002MH-AF
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:09:02 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id E5E3C1008E1
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 18:09:00 +0200 (CEST)
Date: Thu, 1 Jun 2017 18:08:52 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170601180852.02ffe0fd@bahia.lan>
In-Reply-To: <20170601015218.9299-2-david@gibson.dropbear.id.au>
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
	<20170601015218.9299-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/QuU41SeRHbqXjFA4NIA.3eZ";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/4] spapr: Move DRC RTAS calls
 into spapr_drc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mdroth@linux.vnet.ibm.com, lvivier@redhat.com, sursingh@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com

--Sig_/QuU41SeRHbqXjFA4NIA.3eZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu,  1 Jun 2017 11:52:15 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Currently implementations of the RTAS calls related to DRCs are in
> spapr_rtas.c.  They belong better in spapr_drc.c - that way they're closer
> to related code, and we'll be able to make some more things local.
>=20
> spapr_rtas.c was intended to contain the RTAS infrastructure and core cal=
ls
> that don't belong anywhere else, not every RTAS implementation.
>=20
> Code motion only.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_drc.c  | 322 ++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  hw/ppc/spapr_rtas.c | 304 ----------------------------------------------=
---
>  2 files changed, 315 insertions(+), 311 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index cc2400b..ae8800d 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -27,6 +27,34 @@
>  #define DRC_INDEX_TYPE_SHIFT 28
>  #define DRC_INDEX_ID_MASK ((1ULL << DRC_INDEX_TYPE_SHIFT) - 1)
> =20
> +static sPAPRConfigureConnectorState *spapr_ccs_find(sPAPRMachineState *s=
papr,
> +                                                    uint32_t drc_index)
> +{
> +    sPAPRConfigureConnectorState *ccs =3D NULL;
> +
> +    QTAILQ_FOREACH(ccs, &spapr->ccs_list, next) {
> +        if (ccs->drc_index =3D=3D drc_index) {
> +            break;
> +        }
> +    }
> +
> +    return ccs;
> +}
> +
> +static void spapr_ccs_add(sPAPRMachineState *spapr,
> +                          sPAPRConfigureConnectorState *ccs)
> +{
> +    g_assert(!spapr_ccs_find(spapr, ccs->drc_index));
> +    QTAILQ_INSERT_HEAD(&spapr->ccs_list, ccs, next);
> +}
> +
> +static void spapr_ccs_remove(sPAPRMachineState *spapr,
> +                             sPAPRConfigureConnectorState *ccs)
> +{
> +    QTAILQ_REMOVE(&spapr->ccs_list, ccs, next);
> +    g_free(ccs);
> +}
> +
>  static sPAPRDRConnectorTypeShift get_type_shift(sPAPRDRConnectorType typ=
e)
>  {
>      uint32_t shift =3D 0;
> @@ -747,13 +775,6 @@ static const TypeInfo spapr_dr_connector_info =3D {
>      .class_init    =3D spapr_dr_connector_class_init,
>  };
> =20
> -static void spapr_drc_register_types(void)
> -{
> -    type_register_static(&spapr_dr_connector_info);
> -}
> -
> -type_init(spapr_drc_register_types)
> -
>  /* helper functions for external users */
> =20
>  sPAPRDRConnector *spapr_dr_connector_by_index(uint32_t index)
> @@ -932,3 +953,290 @@ out:
> =20
>      return ret;
>  }
> +
> +/*
> + * RTAS calls
> + */
> +
> +static bool sensor_type_is_dr(uint32_t sensor_type)
> +{
> +    switch (sensor_type) {
> +    case RTAS_SENSOR_TYPE_ISOLATION_STATE:
> +    case RTAS_SENSOR_TYPE_DR:
> +    case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> +                               uint32_t token, uint32_t nargs,
> +                               target_ulong args, uint32_t nret,
> +                               target_ulong rets)
> +{
> +    uint32_t sensor_type;
> +    uint32_t sensor_index;
> +    uint32_t sensor_state;
> +    uint32_t ret =3D RTAS_OUT_SUCCESS;
> +    sPAPRDRConnector *drc;
> +    sPAPRDRConnectorClass *drck;
> +
> +    if (nargs !=3D 3 || nret !=3D 1) {
> +        ret =3D RTAS_OUT_PARAM_ERROR;
> +        goto out;
> +    }
> +
> +    sensor_type =3D rtas_ld(args, 0);
> +    sensor_index =3D rtas_ld(args, 1);
> +    sensor_state =3D rtas_ld(args, 2);
> +
> +    if (!sensor_type_is_dr(sensor_type)) {
> +        goto out_unimplemented;
> +    }
> +
> +    /* if this is a DR sensor we can assume sensor_index =3D=3D drc_inde=
x */
> +    drc =3D spapr_dr_connector_by_index(sensor_index);
> +    if (!drc) {
> +        trace_spapr_rtas_set_indicator_invalid(sensor_index);
> +        ret =3D RTAS_OUT_PARAM_ERROR;
> +        goto out;
> +    }
> +    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> +
> +    switch (sensor_type) {
> +    case RTAS_SENSOR_TYPE_ISOLATION_STATE:
> +        /* if the guest is configuring a device attached to this
> +         * DRC, we should reset the configuration state at this
> +         * point since it may no longer be reliable (guest released
> +         * device and needs to start over, or unplug occurred so
> +         * the FDT is no longer valid)
> +         */
> +        if (sensor_state =3D=3D SPAPR_DR_ISOLATION_STATE_ISOLATED) {
> +            sPAPRConfigureConnectorState *ccs =3D spapr_ccs_find(spapr,
> +                                                               sensor_in=
dex);
> +            if (ccs) {
> +                spapr_ccs_remove(spapr, ccs);
> +            }
> +        }
> +        ret =3D drck->set_isolation_state(drc, sensor_state);
> +        break;
> +    case RTAS_SENSOR_TYPE_DR:
> +        ret =3D drck->set_indicator_state(drc, sensor_state);
> +        break;
> +    case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
> +        ret =3D drck->set_allocation_state(drc, sensor_state);
> +        break;
> +    default:
> +        goto out_unimplemented;
> +    }
> +
> +out:
> +    rtas_st(rets, 0, ret);
> +    return;
> +
> +out_unimplemented:
> +    /* currently only DR-related sensors are implemented */
> +    trace_spapr_rtas_set_indicator_not_supported(sensor_index, sensor_ty=
pe);
> +    rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +}
> +
> +static void rtas_get_sensor_state(PowerPCCPU *cpu, sPAPRMachineState *sp=
apr,
> +                                  uint32_t token, uint32_t nargs,
> +                                  target_ulong args, uint32_t nret,
> +                                  target_ulong rets)
> +{
> +    uint32_t sensor_type;
> +    uint32_t sensor_index;
> +    uint32_t sensor_state =3D 0;
> +    sPAPRDRConnector *drc;
> +    sPAPRDRConnectorClass *drck;
> +    uint32_t ret =3D RTAS_OUT_SUCCESS;
> +
> +    if (nargs !=3D 2 || nret !=3D 2) {
> +        ret =3D RTAS_OUT_PARAM_ERROR;
> +        goto out;
> +    }
> +
> +    sensor_type =3D rtas_ld(args, 0);
> +    sensor_index =3D rtas_ld(args, 1);
> +
> +    if (sensor_type !=3D RTAS_SENSOR_TYPE_ENTITY_SENSE) {
> +        /* currently only DR-related sensors are implemented */
> +        trace_spapr_rtas_get_sensor_state_not_supported(sensor_index,
> +                                                        sensor_type);
> +        ret =3D RTAS_OUT_NOT_SUPPORTED;
> +        goto out;
> +    }
> +
> +    drc =3D spapr_dr_connector_by_index(sensor_index);
> +    if (!drc) {
> +        trace_spapr_rtas_get_sensor_state_invalid(sensor_index);
> +        ret =3D RTAS_OUT_PARAM_ERROR;
> +        goto out;
> +    }
> +    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> +    ret =3D drck->entity_sense(drc, &sensor_state);
> +
> +out:
> +    rtas_st(rets, 0, ret);
> +    rtas_st(rets, 1, sensor_state);
> +}
> +
> +/* configure-connector work area offsets, int32_t units for field
> + * indexes, bytes for field offset/len values.
> + *
> + * as documented by PAPR+ v2.7, 13.5.3.5
> + */
> +#define CC_IDX_NODE_NAME_OFFSET 2
> +#define CC_IDX_PROP_NAME_OFFSET 2
> +#define CC_IDX_PROP_LEN 3
> +#define CC_IDX_PROP_DATA_OFFSET 4
> +#define CC_VAL_DATA_OFFSET ((CC_IDX_PROP_DATA_OFFSET + 1) * 4)
> +#define CC_WA_LEN 4096
> +
> +static void configure_connector_st(target_ulong addr, target_ulong offse=
t,
> +                                   const void *buf, size_t len)
> +{
> +    cpu_physical_memory_write(ppc64_phys_to_real(addr + offset),
> +                              buf, MIN(len, CC_WA_LEN - offset));
> +}
> +
> +void spapr_ccs_reset_hook(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +    sPAPRConfigureConnectorState *ccs, *ccs_tmp;
> +
> +    QTAILQ_FOREACH_SAFE(ccs, &spapr->ccs_list, next, ccs_tmp) {
> +        spapr_ccs_remove(spapr, ccs);
> +    }
> +}
> +
> +static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
> +                                         sPAPRMachineState *spapr,
> +                                         uint32_t token, uint32_t nargs,
> +                                         target_ulong args, uint32_t nre=
t,
> +                                         target_ulong rets)
> +{
> +    uint64_t wa_addr;
> +    uint64_t wa_offset;
> +    uint32_t drc_index;
> +    sPAPRDRConnector *drc;
> +    sPAPRDRConnectorClass *drck;
> +    sPAPRConfigureConnectorState *ccs;
> +    sPAPRDRCCResponse resp =3D SPAPR_DR_CC_RESPONSE_CONTINUE;
> +    int rc;
> +    const void *fdt;
> +
> +    if (nargs !=3D 2 || nret !=3D 1) {
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
> +    wa_addr =3D ((uint64_t)rtas_ld(args, 1) << 32) | rtas_ld(args, 0);
> +
> +    drc_index =3D rtas_ld(wa_addr, 0);
> +    drc =3D spapr_dr_connector_by_index(drc_index);
> +    if (!drc) {
> +        trace_spapr_rtas_ibm_configure_connector_invalid(drc_index);
> +        rc =3D RTAS_OUT_PARAM_ERROR;
> +        goto out;
> +    }
> +
> +    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> +    fdt =3D drck->get_fdt(drc, NULL);
> +    if (!fdt) {
> +        trace_spapr_rtas_ibm_configure_connector_missing_fdt(drc_index);
> +        rc =3D SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE;
> +        goto out;
> +    }
> +
> +    ccs =3D spapr_ccs_find(spapr, drc_index);
> +    if (!ccs) {
> +        ccs =3D g_new0(sPAPRConfigureConnectorState, 1);
> +        (void)drck->get_fdt(drc, &ccs->fdt_offset);
> +        ccs->drc_index =3D drc_index;
> +        spapr_ccs_add(spapr, ccs);
> +    }
> +
> +    do {
> +        uint32_t tag;
> +        const char *name;
> +        const struct fdt_property *prop;
> +        int fdt_offset_next, prop_len;
> +
> +        tag =3D fdt_next_tag(fdt, ccs->fdt_offset, &fdt_offset_next);
> +
> +        switch (tag) {
> +        case FDT_BEGIN_NODE:
> +            ccs->fdt_depth++;
> +            name =3D fdt_get_name(fdt, ccs->fdt_offset, NULL);
> +
> +            /* provide the name of the next OF node */
> +            wa_offset =3D CC_VAL_DATA_OFFSET;
> +            rtas_st(wa_addr, CC_IDX_NODE_NAME_OFFSET, wa_offset);
> +            configure_connector_st(wa_addr, wa_offset, name, strlen(name=
) + 1);
> +            resp =3D SPAPR_DR_CC_RESPONSE_NEXT_CHILD;
> +            break;
> +        case FDT_END_NODE:
> +            ccs->fdt_depth--;
> +            if (ccs->fdt_depth =3D=3D 0) {
> +                /* done sending the device tree, don't need to track
> +                 * the state anymore
> +                 */
> +                drck->set_configured(drc);
> +                spapr_ccs_remove(spapr, ccs);
> +                ccs =3D NULL;
> +                resp =3D SPAPR_DR_CC_RESPONSE_SUCCESS;
> +            } else {
> +                resp =3D SPAPR_DR_CC_RESPONSE_PREV_PARENT;
> +            }
> +            break;
> +        case FDT_PROP:
> +            prop =3D fdt_get_property_by_offset(fdt, ccs->fdt_offset,
> +                                              &prop_len);
> +            name =3D fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
> +
> +            /* provide the name of the next OF property */
> +            wa_offset =3D CC_VAL_DATA_OFFSET;
> +            rtas_st(wa_addr, CC_IDX_PROP_NAME_OFFSET, wa_offset);
> +            configure_connector_st(wa_addr, wa_offset, name, strlen(name=
) + 1);
> +
> +            /* provide the length and value of the OF property. data gets
> +             * placed immediately after NULL terminator of the OF proper=
ty's
> +             * name string
> +             */
> +            wa_offset +=3D strlen(name) + 1,
> +            rtas_st(wa_addr, CC_IDX_PROP_LEN, prop_len);
> +            rtas_st(wa_addr, CC_IDX_PROP_DATA_OFFSET, wa_offset);
> +            configure_connector_st(wa_addr, wa_offset, prop->data, prop_=
len);
> +            resp =3D SPAPR_DR_CC_RESPONSE_NEXT_PROPERTY;
> +            break;
> +        case FDT_END:
> +            resp =3D SPAPR_DR_CC_RESPONSE_ERROR;
> +        default:
> +            /* keep seeking for an actionable tag */
> +            break;
> +        }
> +        if (ccs) {
> +            ccs->fdt_offset =3D fdt_offset_next;
> +        }
> +    } while (resp =3D=3D SPAPR_DR_CC_RESPONSE_CONTINUE);
> +
> +    rc =3D resp;
> +out:
> +    rtas_st(rets, 0, rc);
> +}
> +
> +static void spapr_drc_register_types(void)
> +{
> +    type_register_static(&spapr_dr_connector_info);
> +
> +    spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
> +                        rtas_set_indicator);
> +    spapr_rtas_register(RTAS_GET_SENSOR_STATE, "get-sensor-state",
> +                        rtas_get_sensor_state);
> +    spapr_rtas_register(RTAS_IBM_CONFIGURE_CONNECTOR, "ibm,configure-con=
nector",
> +                        rtas_ibm_configure_connector);
> +}
> +type_init(spapr_drc_register_types)
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 128d993..0bdb5fc 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -48,44 +48,6 @@
>  #include "trace.h"
>  #include "hw/ppc/fdt.h"
> =20
> -static sPAPRConfigureConnectorState *spapr_ccs_find(sPAPRMachineState *s=
papr,
> -                                                    uint32_t drc_index)
> -{
> -    sPAPRConfigureConnectorState *ccs =3D NULL;
> -
> -    QTAILQ_FOREACH(ccs, &spapr->ccs_list, next) {
> -        if (ccs->drc_index =3D=3D drc_index) {
> -            break;
> -        }
> -    }
> -
> -    return ccs;
> -}
> -
> -static void spapr_ccs_add(sPAPRMachineState *spapr,
> -                          sPAPRConfigureConnectorState *ccs)
> -{
> -    g_assert(!spapr_ccs_find(spapr, ccs->drc_index));
> -    QTAILQ_INSERT_HEAD(&spapr->ccs_list, ccs, next);
> -}
> -
> -static void spapr_ccs_remove(sPAPRMachineState *spapr,
> -                             sPAPRConfigureConnectorState *ccs)
> -{
> -    QTAILQ_REMOVE(&spapr->ccs_list, ccs, next);
> -    g_free(ccs);
> -}
> -
> -void spapr_ccs_reset_hook(void *opaque)
> -{
> -    sPAPRMachineState *spapr =3D opaque;
> -    sPAPRConfigureConnectorState *ccs, *ccs_tmp;
> -
> -    QTAILQ_FOREACH_SAFE(ccs, &spapr->ccs_list, next, ccs_tmp) {
> -        spapr_ccs_remove(spapr, ccs);
> -    }
> -}
> -
>  static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
>                                     uint32_t token, uint32_t nargs,
>                                     target_ulong args,
> @@ -390,266 +352,6 @@ static void rtas_get_power_level(PowerPCCPU *cpu, s=
PAPRMachineState *spapr,
>      rtas_st(rets, 1, 100);
>  }
> =20
> -static bool sensor_type_is_dr(uint32_t sensor_type)
> -{
> -    switch (sensor_type) {
> -    case RTAS_SENSOR_TYPE_ISOLATION_STATE:
> -    case RTAS_SENSOR_TYPE_DR:
> -    case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
> -        return true;
> -    }
> -
> -    return false;
> -}
> -
> -static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> -                               uint32_t token, uint32_t nargs,
> -                               target_ulong args, uint32_t nret,
> -                               target_ulong rets)
> -{
> -    uint32_t sensor_type;
> -    uint32_t sensor_index;
> -    uint32_t sensor_state;
> -    uint32_t ret =3D RTAS_OUT_SUCCESS;
> -    sPAPRDRConnector *drc;
> -    sPAPRDRConnectorClass *drck;
> -
> -    if (nargs !=3D 3 || nret !=3D 1) {
> -        ret =3D RTAS_OUT_PARAM_ERROR;
> -        goto out;
> -    }
> -
> -    sensor_type =3D rtas_ld(args, 0);
> -    sensor_index =3D rtas_ld(args, 1);
> -    sensor_state =3D rtas_ld(args, 2);
> -
> -    if (!sensor_type_is_dr(sensor_type)) {
> -        goto out_unimplemented;
> -    }
> -
> -    /* if this is a DR sensor we can assume sensor_index =3D=3D drc_inde=
x */
> -    drc =3D spapr_dr_connector_by_index(sensor_index);
> -    if (!drc) {
> -        trace_spapr_rtas_set_indicator_invalid(sensor_index);
> -        ret =3D RTAS_OUT_PARAM_ERROR;
> -        goto out;
> -    }
> -    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -
> -    switch (sensor_type) {
> -    case RTAS_SENSOR_TYPE_ISOLATION_STATE:
> -        /* if the guest is configuring a device attached to this
> -         * DRC, we should reset the configuration state at this
> -         * point since it may no longer be reliable (guest released
> -         * device and needs to start over, or unplug occurred so
> -         * the FDT is no longer valid)
> -         */
> -        if (sensor_state =3D=3D SPAPR_DR_ISOLATION_STATE_ISOLATED) {
> -            sPAPRConfigureConnectorState *ccs =3D spapr_ccs_find(spapr,
> -                                                               sensor_in=
dex);
> -            if (ccs) {
> -                spapr_ccs_remove(spapr, ccs);
> -            }
> -        }
> -        ret =3D drck->set_isolation_state(drc, sensor_state);
> -        break;
> -    case RTAS_SENSOR_TYPE_DR:
> -        ret =3D drck->set_indicator_state(drc, sensor_state);
> -        break;
> -    case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
> -        ret =3D drck->set_allocation_state(drc, sensor_state);
> -        break;
> -    default:
> -        goto out_unimplemented;
> -    }
> -
> -out:
> -    rtas_st(rets, 0, ret);
> -    return;
> -
> -out_unimplemented:
> -    /* currently only DR-related sensors are implemented */
> -    trace_spapr_rtas_set_indicator_not_supported(sensor_index, sensor_ty=
pe);
> -    rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> -}
> -
> -static void rtas_get_sensor_state(PowerPCCPU *cpu, sPAPRMachineState *sp=
apr,
> -                                  uint32_t token, uint32_t nargs,
> -                                  target_ulong args, uint32_t nret,
> -                                  target_ulong rets)
> -{
> -    uint32_t sensor_type;
> -    uint32_t sensor_index;
> -    uint32_t sensor_state =3D 0;
> -    sPAPRDRConnector *drc;
> -    sPAPRDRConnectorClass *drck;
> -    uint32_t ret =3D RTAS_OUT_SUCCESS;
> -
> -    if (nargs !=3D 2 || nret !=3D 2) {
> -        ret =3D RTAS_OUT_PARAM_ERROR;
> -        goto out;
> -    }
> -
> -    sensor_type =3D rtas_ld(args, 0);
> -    sensor_index =3D rtas_ld(args, 1);
> -
> -    if (sensor_type !=3D RTAS_SENSOR_TYPE_ENTITY_SENSE) {
> -        /* currently only DR-related sensors are implemented */
> -        trace_spapr_rtas_get_sensor_state_not_supported(sensor_index,
> -                                                        sensor_type);
> -        ret =3D RTAS_OUT_NOT_SUPPORTED;
> -        goto out;
> -    }
> -
> -    drc =3D spapr_dr_connector_by_index(sensor_index);
> -    if (!drc) {
> -        trace_spapr_rtas_get_sensor_state_invalid(sensor_index);
> -        ret =3D RTAS_OUT_PARAM_ERROR;
> -        goto out;
> -    }
> -    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -    ret =3D drck->entity_sense(drc, &sensor_state);
> -
> -out:
> -    rtas_st(rets, 0, ret);
> -    rtas_st(rets, 1, sensor_state);
> -}
> -
> -/* configure-connector work area offsets, int32_t units for field
> - * indexes, bytes for field offset/len values.
> - *
> - * as documented by PAPR+ v2.7, 13.5.3.5
> - */
> -#define CC_IDX_NODE_NAME_OFFSET 2
> -#define CC_IDX_PROP_NAME_OFFSET 2
> -#define CC_IDX_PROP_LEN 3
> -#define CC_IDX_PROP_DATA_OFFSET 4
> -#define CC_VAL_DATA_OFFSET ((CC_IDX_PROP_DATA_OFFSET + 1) * 4)
> -#define CC_WA_LEN 4096
> -
> -static void configure_connector_st(target_ulong addr, target_ulong offse=
t,
> -                                   const void *buf, size_t len)
> -{
> -    cpu_physical_memory_write(ppc64_phys_to_real(addr + offset),
> -                              buf, MIN(len, CC_WA_LEN - offset));
> -}
> -
> -static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
> -                                         sPAPRMachineState *spapr,
> -                                         uint32_t token, uint32_t nargs,
> -                                         target_ulong args, uint32_t nre=
t,
> -                                         target_ulong rets)
> -{
> -    uint64_t wa_addr;
> -    uint64_t wa_offset;
> -    uint32_t drc_index;
> -    sPAPRDRConnector *drc;
> -    sPAPRDRConnectorClass *drck;
> -    sPAPRConfigureConnectorState *ccs;
> -    sPAPRDRCCResponse resp =3D SPAPR_DR_CC_RESPONSE_CONTINUE;
> -    int rc;
> -    const void *fdt;
> -
> -    if (nargs !=3D 2 || nret !=3D 1) {
> -        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> -        return;
> -    }
> -
> -    wa_addr =3D ((uint64_t)rtas_ld(args, 1) << 32) | rtas_ld(args, 0);
> -
> -    drc_index =3D rtas_ld(wa_addr, 0);
> -    drc =3D spapr_dr_connector_by_index(drc_index);
> -    if (!drc) {
> -        trace_spapr_rtas_ibm_configure_connector_invalid(drc_index);
> -        rc =3D RTAS_OUT_PARAM_ERROR;
> -        goto out;
> -    }
> -
> -    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -    fdt =3D drck->get_fdt(drc, NULL);
> -    if (!fdt) {
> -        trace_spapr_rtas_ibm_configure_connector_missing_fdt(drc_index);
> -        rc =3D SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE;
> -        goto out;
> -    }
> -
> -    ccs =3D spapr_ccs_find(spapr, drc_index);
> -    if (!ccs) {
> -        ccs =3D g_new0(sPAPRConfigureConnectorState, 1);
> -        (void)drck->get_fdt(drc, &ccs->fdt_offset);
> -        ccs->drc_index =3D drc_index;
> -        spapr_ccs_add(spapr, ccs);
> -    }
> -
> -    do {
> -        uint32_t tag;
> -        const char *name;
> -        const struct fdt_property *prop;
> -        int fdt_offset_next, prop_len;
> -
> -        tag =3D fdt_next_tag(fdt, ccs->fdt_offset, &fdt_offset_next);
> -
> -        switch (tag) {
> -        case FDT_BEGIN_NODE:
> -            ccs->fdt_depth++;
> -            name =3D fdt_get_name(fdt, ccs->fdt_offset, NULL);
> -
> -            /* provide the name of the next OF node */
> -            wa_offset =3D CC_VAL_DATA_OFFSET;
> -            rtas_st(wa_addr, CC_IDX_NODE_NAME_OFFSET, wa_offset);
> -            configure_connector_st(wa_addr, wa_offset, name, strlen(name=
) + 1);
> -            resp =3D SPAPR_DR_CC_RESPONSE_NEXT_CHILD;
> -            break;
> -        case FDT_END_NODE:
> -            ccs->fdt_depth--;
> -            if (ccs->fdt_depth =3D=3D 0) {
> -                /* done sending the device tree, don't need to track
> -                 * the state anymore
> -                 */
> -                drck->set_configured(drc);
> -                spapr_ccs_remove(spapr, ccs);
> -                ccs =3D NULL;
> -                resp =3D SPAPR_DR_CC_RESPONSE_SUCCESS;
> -            } else {
> -                resp =3D SPAPR_DR_CC_RESPONSE_PREV_PARENT;
> -            }
> -            break;
> -        case FDT_PROP:
> -            prop =3D fdt_get_property_by_offset(fdt, ccs->fdt_offset,
> -                                              &prop_len);
> -            name =3D fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
> -
> -            /* provide the name of the next OF property */
> -            wa_offset =3D CC_VAL_DATA_OFFSET;
> -            rtas_st(wa_addr, CC_IDX_PROP_NAME_OFFSET, wa_offset);
> -            configure_connector_st(wa_addr, wa_offset, name, strlen(name=
) + 1);
> -
> -            /* provide the length and value of the OF property. data gets
> -             * placed immediately after NULL terminator of the OF proper=
ty's
> -             * name string
> -             */
> -            wa_offset +=3D strlen(name) + 1,
> -            rtas_st(wa_addr, CC_IDX_PROP_LEN, prop_len);
> -            rtas_st(wa_addr, CC_IDX_PROP_DATA_OFFSET, wa_offset);
> -            configure_connector_st(wa_addr, wa_offset, prop->data, prop_=
len);
> -            resp =3D SPAPR_DR_CC_RESPONSE_NEXT_PROPERTY;
> -            break;
> -        case FDT_END:
> -            resp =3D SPAPR_DR_CC_RESPONSE_ERROR;
> -        default:
> -            /* keep seeking for an actionable tag */
> -            break;
> -        }
> -        if (ccs) {
> -            ccs->fdt_offset =3D fdt_offset_next;
> -        }
> -    } while (resp =3D=3D SPAPR_DR_CC_RESPONSE_CONTINUE);
> -
> -    rc =3D resp;
> -out:
> -    rtas_st(rets, 0, rc);
> -}
> -
>  static struct rtas_call {
>      const char *name;
>      spapr_rtas_fn fn;
> @@ -791,12 +493,6 @@ static void core_rtas_register_types(void)
>                          rtas_set_power_level);
>      spapr_rtas_register(RTAS_GET_POWER_LEVEL, "get-power-level",
>                          rtas_get_power_level);
> -    spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
> -                        rtas_set_indicator);
> -    spapr_rtas_register(RTAS_GET_SENSOR_STATE, "get-sensor-state",
> -                        rtas_get_sensor_state);
> -    spapr_rtas_register(RTAS_IBM_CONFIGURE_CONNECTOR, "ibm,configure-con=
nector",
> -                        rtas_ibm_configure_connector);
>  }
> =20
>  type_init(core_rtas_register_types)


--Sig_/QuU41SeRHbqXjFA4NIA.3eZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkwPBQACgkQAvw66wEB28LwuwCeM1ca4nzkE21yR2/U3Ml/OJbD
2VYAoJdMA3GDPIEVMpS+7F7hr0OrGXAJ
=9GSg
-----END PGP SIGNATURE-----

--Sig_/QuU41SeRHbqXjFA4NIA.3eZ--
