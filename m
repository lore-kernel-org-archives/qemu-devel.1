Received: from eggs.gnu.org ([2001:4830:134:3::10]:40199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dGSbh-00010h-UV
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dGSbd-0000wG-QY
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:05:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55805
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dGSbd-0000vZ-Js
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:05:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v51G4OGH070877
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 12:05:48 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2atcj96ju5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 12:05:48 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 1 Jun 2017 10:05:47 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20e745b0-a1ed-8be4-d587-377b4b7610b1@redhat.com>
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
	<20170601015218.9299-2-david@gibson.dropbear.id.au>
	<20e745b0-a1ed-8be4-d587-377b4b7610b1@redhat.com>
Date: Thu, 01 Jun 2017 11:05:37 -0500
Message-Id: <149633313755.3207.17440798093242250707@loki>
Subject: Re: [Qemu-devel] [PATCH 1/4] spapr: Move DRC RTAS calls into
 spapr_drc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>
Cc: sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com

Quoting Laurent Vivier (2017-06-01 08:36:36)
> On 01/06/2017 03:52, David Gibson wrote:
> > Currently implementations of the RTAS calls related to DRCs are in
> > spapr_rtas.c.  They belong better in spapr_drc.c - that way they're clo=
ser
> > to related code, and we'll be able to make some more things local.
> > =

> > spapr_rtas.c was intended to contain the RTAS infrastructure and core c=
alls
> > that don't belong anywhere else, not every RTAS implementation.
> > =

> > Code motion only.
> > =

> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_drc.c  | 322 ++++++++++++++++++++++++++++++++++++++++++++=
++++++--
> >  hw/ppc/spapr_rtas.c | 304 --------------------------------------------=
-----
> >  2 files changed, 315 insertions(+), 311 deletions(-)
> > =

> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index cc2400b..ae8800d 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -27,6 +27,34 @@
> >  #define DRC_INDEX_TYPE_SHIFT 28
> >  #define DRC_INDEX_ID_MASK ((1ULL << DRC_INDEX_TYPE_SHIFT) - 1)
> >  =

> > +static sPAPRConfigureConnectorState *spapr_ccs_find(sPAPRMachineState =
*spapr,
> > +                                                    uint32_t drc_index)
> > +{
> > +    sPAPRConfigureConnectorState *ccs =3D NULL;
> > +
> > +    QTAILQ_FOREACH(ccs, &spapr->ccs_list, next) {
> > +        if (ccs->drc_index =3D=3D drc_index) {
> > +            break;
> > +        }
> > +    }
> > +
> > +    return ccs;
> > +}
> > +
> > +static void spapr_ccs_add(sPAPRMachineState *spapr,
> > +                          sPAPRConfigureConnectorState *ccs)
> > +{
> > +    g_assert(!spapr_ccs_find(spapr, ccs->drc_index));
> > +    QTAILQ_INSERT_HEAD(&spapr->ccs_list, ccs, next);
> > +}
> > +
> > +static void spapr_ccs_remove(sPAPRMachineState *spapr,
> > +                             sPAPRConfigureConnectorState *ccs)
> > +{
> > +    QTAILQ_REMOVE(&spapr->ccs_list, ccs, next);
> > +    g_free(ccs);
> > +}
> > +
> >  static sPAPRDRConnectorTypeShift get_type_shift(sPAPRDRConnectorType t=
ype)
> >  {
> >      uint32_t shift =3D 0;
> > @@ -747,13 +775,6 @@ static const TypeInfo spapr_dr_connector_info =3D {
> >      .class_init    =3D spapr_dr_connector_class_init,
> >  };
> >  =

> > -static void spapr_drc_register_types(void)
> > -{
> > -    type_register_static(&spapr_dr_connector_info);
> > -}
> > -
> > -type_init(spapr_drc_register_types)
> > -
> >  /* helper functions for external users */
> >  =

> >  sPAPRDRConnector *spapr_dr_connector_by_index(uint32_t index)
> > @@ -932,3 +953,290 @@ out:
> >  =

> >      return ret;
> >  }
> > +
> > +/*
> > + * RTAS calls
> > + */
> > +
> > +static bool sensor_type_is_dr(uint32_t sensor_type)
> > +{
> > +    switch (sensor_type) {
> > +    case RTAS_SENSOR_TYPE_ISOLATION_STATE:
> > +    case RTAS_SENSOR_TYPE_DR:
> > +    case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
> > +        return true;
> > +    }
> > +
> > +    return false;
> > +}
> > +
> > +static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState *spa=
pr,
> > +                               uint32_t token, uint32_t nargs,
> > +                               target_ulong args, uint32_t nret,
> > +                               target_ulong rets)
> > +{
> > +    uint32_t sensor_type;
> > +    uint32_t sensor_index;
> > +    uint32_t sensor_state;
> > +    uint32_t ret =3D RTAS_OUT_SUCCESS;
> > +    sPAPRDRConnector *drc;
> > +    sPAPRDRConnectorClass *drck;
> > +
> > +    if (nargs !=3D 3 || nret !=3D 1) {
> > +        ret =3D RTAS_OUT_PARAM_ERROR;
> > +        goto out;
> > +    }
> > +
> > +    sensor_type =3D rtas_ld(args, 0);
> > +    sensor_index =3D rtas_ld(args, 1);
> > +    sensor_state =3D rtas_ld(args, 2);
> > +
> > +    if (!sensor_type_is_dr(sensor_type)) {
> > +        goto out_unimplemented;
> > +    }
> > +
> > +    /* if this is a DR sensor we can assume sensor_index =3D=3D drc_in=
dex */
> > +    drc =3D spapr_dr_connector_by_index(sensor_index);
> > +    if (!drc) {
> > +        trace_spapr_rtas_set_indicator_invalid(sensor_index);
> > +        ret =3D RTAS_OUT_PARAM_ERROR;
> > +        goto out;
> > +    }
> > +    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > +
> > +    switch (sensor_type) {
> > +    case RTAS_SENSOR_TYPE_ISOLATION_STATE:
> > +        /* if the guest is configuring a device attached to this
> > +         * DRC, we should reset the configuration state at this
> > +         * point since it may no longer be reliable (guest released
> > +         * device and needs to start over, or unplug occurred so
> > +         * the FDT is no longer valid)
> > +         */
> > +        if (sensor_state =3D=3D SPAPR_DR_ISOLATION_STATE_ISOLATED) {
> > +            sPAPRConfigureConnectorState *ccs =3D spapr_ccs_find(spapr,
> > +                                                               sensor_=
index);
> > +            if (ccs) {
> > +                spapr_ccs_remove(spapr, ccs);
> > +            }
> > +        }
> > +        ret =3D drck->set_isolation_state(drc, sensor_state);
> > +        break;
> > +    case RTAS_SENSOR_TYPE_DR:
> > +        ret =3D drck->set_indicator_state(drc, sensor_state);
> > +        break;
> > +    case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
> > +        ret =3D drck->set_allocation_state(drc, sensor_state);
> > +        break;
> > +    default:
> > +        goto out_unimplemented;
> > +    }
> > +
> > +out:
> > +    rtas_st(rets, 0, ret);
> > +    return;
> > +
> > +out_unimplemented:
> > +    /* currently only DR-related sensors are implemented */
> > +    trace_spapr_rtas_set_indicator_not_supported(sensor_index, sensor_=
type);
> > +    rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> > +}
> > +
> > +static void rtas_get_sensor_state(PowerPCCPU *cpu, sPAPRMachineState *=
spapr,
> > +                                  uint32_t token, uint32_t nargs,
> > +                                  target_ulong args, uint32_t nret,
> > +                                  target_ulong rets)
> > +{
> > +    uint32_t sensor_type;
> > +    uint32_t sensor_index;
> > +    uint32_t sensor_state =3D 0;
> > +    sPAPRDRConnector *drc;
> > +    sPAPRDRConnectorClass *drck;
> > +    uint32_t ret =3D RTAS_OUT_SUCCESS;
> > +
> > +    if (nargs !=3D 2 || nret !=3D 2) {
> > +        ret =3D RTAS_OUT_PARAM_ERROR;
> > +        goto out;
> > +    }
> > +
> > +    sensor_type =3D rtas_ld(args, 0);
> > +    sensor_index =3D rtas_ld(args, 1);
> > +
> > +    if (sensor_type !=3D RTAS_SENSOR_TYPE_ENTITY_SENSE) {
> > +        /* currently only DR-related sensors are implemented */
> > +        trace_spapr_rtas_get_sensor_state_not_supported(sensor_index,
> > +                                                        sensor_type);
> > +        ret =3D RTAS_OUT_NOT_SUPPORTED;
> > +        goto out;
> > +    }
> > +
> > +    drc =3D spapr_dr_connector_by_index(sensor_index);
> > +    if (!drc) {
> > +        trace_spapr_rtas_get_sensor_state_invalid(sensor_index);
> > +        ret =3D RTAS_OUT_PARAM_ERROR;
> > +        goto out;
> > +    }
> > +    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > +    ret =3D drck->entity_sense(drc, &sensor_state);
> > +
> > +out:
> > +    rtas_st(rets, 0, ret);
> > +    rtas_st(rets, 1, sensor_state);
> > +}
> > +
> > +/* configure-connector work area offsets, int32_t units for field
> > + * indexes, bytes for field offset/len values.
> > + *
> > + * as documented by PAPR+ v2.7, 13.5.3.5
> > + */
> > +#define CC_IDX_NODE_NAME_OFFSET 2
> > +#define CC_IDX_PROP_NAME_OFFSET 2
> > +#define CC_IDX_PROP_LEN 3
> > +#define CC_IDX_PROP_DATA_OFFSET 4
> > +#define CC_VAL_DATA_OFFSET ((CC_IDX_PROP_DATA_OFFSET + 1) * 4)
> > +#define CC_WA_LEN 4096
> > +
> > +static void configure_connector_st(target_ulong addr, target_ulong off=
set,
> > +                                   const void *buf, size_t len)
> > +{
> > +    cpu_physical_memory_write(ppc64_phys_to_real(addr + offset),
> > +                              buf, MIN(len, CC_WA_LEN - offset));
> > +}
> > +
> > +void spapr_ccs_reset_hook(void *opaque)
> > +{
> > +    sPAPRMachineState *spapr =3D opaque;
> > +    sPAPRConfigureConnectorState *ccs, *ccs_tmp;
> > +
> > +    QTAILQ_FOREACH_SAFE(ccs, &spapr->ccs_list, next, ccs_tmp) {
> > +        spapr_ccs_remove(spapr, ccs);
> > +    }
> > +}
> =

> =

> Why do you move this function in the middle of the "RTAS calls" whereas
> previously it was with spapr_ccs_find(), spapr_ccs_add() and
> spapr_ccs_remove() and it is only used by a reset handler in spapr.c?

I think it's as good a spot as any after the move, and allows
spapr_ccs_* functions to remain static.

But all the CCS stuff got hung off of sPAPRMachineState in the first
place due to an attempt to separate "RTAS" state from the DRC state. Now
that we're treating both as internal state, I think a logical follow-up
would be to drop the CCS list completely and instead hang each instance
off of the corresponding DRC. At that point we'd probably want to move
the reset functionality into the DRC reset hook anyway.

> =

> Laurent
>=20
