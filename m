Received: from eggs.gnu.org ([2001:4830:134:3::10]:35146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dILoy-0008Bl-Aa
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 17:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dILov-0002b4-75
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 17:15:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dILou-0002aB-U6
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 17:15:21 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v56LDrdD113061
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 17:15:18 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2awv2s9vtc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:15:18 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Jun 2017 17:15:17 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170606083221.9299-6-david@gibson.dropbear.id.au>
References: <20170606083221.9299-1-david@gibson.dropbear.id.au>
	<20170606083221.9299-6-david@gibson.dropbear.id.au>
Date: Tue, 06 Jun 2017 15:50:09 -0500
Message-Id: <149678220976.2548.16012212773323423483@loki>
Subject: Re: [Qemu-devel] [PATCH 5/7] spapr: Clean up RTAS set-indicator
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

Quoting David Gibson (2017-06-06 03:32:19)
> In theory the RTAS set-indicator call can be used for a number of
> "indicators" defined by PAPR.  In practice the only ones we're ever likely
> to implement are those used for Dynamic Reconfiguration (i.e. hotplug).
> Because of this, the current implementation determines the associated DRC
> object, before dispatching based on the type of indicator.
> =

> However, this means we also need a check that we're dealing with a DR
> related indicator at all, which duplicates some of the logic from the
> switch further down.
> =

> Even though it means a bit of code duplication, things work out cleaner if
> we delegate the DRC lookup to the individual indicator type functions -
> and it also allows some further cleanups.
> =

> While we're there, remove references to "sensor", a copy/paste artefact
> from the related, but distinct "get-sensor" call.
> =

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  hw/ppc/spapr_drc.c  | 84 ++++++++++++++++++++++++++++-------------------=
------
>  hw/ppc/trace-events |  2 --
>  2 files changed, 44 insertions(+), 42 deletions(-)
> =

> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 1fc51c9..6c2fa93 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -869,74 +869,78 @@ out:
>   * RTAS calls
>   */
> =

> -static bool sensor_type_is_dr(uint32_t sensor_type)
> +static uint32_t rtas_set_isolation_state(uint32_t idx, uint32_t state)
>  {
> -    switch (sensor_type) {
> -    case RTAS_SENSOR_TYPE_ISOLATION_STATE:
> -    case RTAS_SENSOR_TYPE_DR:
> -    case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
> -        return true;
> +    sPAPRDRConnector *drc =3D spapr_drc_by_index(idx);
> +    sPAPRDRConnectorClass *drck;
> +
> +    if (!drc) {
> +        return RTAS_OUT_PARAM_ERROR;
>      }
> =

> -    return false;
> +    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> +    return drck->set_isolation_state(drc, state);
>  }
> =

> -static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> -                               uint32_t token, uint32_t nargs,
> -                               target_ulong args, uint32_t nret,
> -                               target_ulong rets)
> +static uint32_t rtas_set_allocation_state(uint32_t idx, uint32_t state)
>  {
> -    uint32_t sensor_type;
> -    uint32_t sensor_index;
> -    uint32_t sensor_state;
> -    uint32_t ret =3D RTAS_OUT_SUCCESS;
> -    sPAPRDRConnector *drc;
> +    sPAPRDRConnector *drc =3D spapr_drc_by_index(idx);
>      sPAPRDRConnectorClass *drck;
> =

> -    if (nargs !=3D 3 || nret !=3D 1) {
> -        ret =3D RTAS_OUT_PARAM_ERROR;
> -        goto out;
> +    if (!drc) {
> +        return RTAS_OUT_PARAM_ERROR;
>      }
> =

> -    sensor_type =3D rtas_ld(args, 0);
> -    sensor_index =3D rtas_ld(args, 1);
> -    sensor_state =3D rtas_ld(args, 2);
> +    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> +    return drck->set_allocation_state(drc, state);
> +}
> =

> -    if (!sensor_type_is_dr(sensor_type)) {
> -        goto out_unimplemented;
> -    }
> +static uint32_t rtas_set_indicator_state(uint32_t idx, uint32_t state)
> +{
> +    sPAPRDRConnector *drc =3D spapr_drc_by_index(idx);
> +    sPAPRDRConnectorClass *drck;
> =

> -    /* if this is a DR sensor we can assume sensor_index =3D=3D drc_inde=
x */
> -    drc =3D spapr_drc_by_index(sensor_index);
>      if (!drc) {
> -        trace_spapr_rtas_set_indicator_invalid(sensor_index);
> +        return RTAS_OUT_PARAM_ERROR;
> +    }
> +
> +    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> +    return drck->set_indicator_state(drc, state);
> +}
> +
> +static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> +                               uint32_t token,
> +                               uint32_t nargs, target_ulong args,
> +                               uint32_t nret, target_ulong rets)
> +{
> +    uint32_t type, idx, state;
> +    uint32_t ret =3D RTAS_OUT_SUCCESS;
> +
> +    if (nargs !=3D 3 || nret !=3D 1) {
>          ret =3D RTAS_OUT_PARAM_ERROR;
>          goto out;
>      }
> -    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> =

> -    switch (sensor_type) {
> +    type =3D rtas_ld(args, 0);
> +    idx =3D rtas_ld(args, 1);
> +    state =3D rtas_ld(args, 2);
> +
> +    switch (type) {
>      case RTAS_SENSOR_TYPE_ISOLATION_STATE:
> -        ret =3D drck->set_isolation_state(drc, sensor_state);
> +        ret =3D rtas_set_isolation_state(idx, state);
>          break;
>      case RTAS_SENSOR_TYPE_DR:
> -        ret =3D drck->set_indicator_state(drc, sensor_state);
> +        ret =3D rtas_set_indicator_state(idx, state);
>          break;
>      case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
> -        ret =3D drck->set_allocation_state(drc, sensor_state);
> +        ret =3D rtas_set_allocation_state(idx, state);
>          break;
>      default:
> -        goto out_unimplemented;
> +        ret =3D RTAS_OUT_NOT_SUPPORTED;
>      }
> =

>  out:
>      rtas_st(rets, 0, ret);
> -    return;
> -
> -out_unimplemented:
> -    /* currently only DR-related sensors are implemented */
> -    trace_spapr_rtas_set_indicator_not_supported(sensor_index, sensor_ty=
pe);
> -    rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>  }
> =

>  static void rtas_get_sensor_state(PowerPCCPU *cpu, sPAPRMachineState *sp=
apr,
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 4979397..581fa85 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -60,8 +60,6 @@ spapr_ovec_parse_vector(int vector, int byte, uint16_t =
vec_len, uint8_t entry) "
>  spapr_ovec_populate_dt(int byte, uint16_t vec_len, uint8_t entry) "encod=
ing guest vector byte %3d / %3d: 0x%.2x"
> =

>  # hw/ppc/spapr_rtas.c
> -spapr_rtas_set_indicator_invalid(uint32_t index) "sensor index: 0x%"PRIx=
32
> -spapr_rtas_set_indicator_not_supported(uint32_t index, uint32_t type) "s=
ensor index: 0x%"PRIx32", type: %"PRIu32
>  spapr_rtas_get_sensor_state_not_supported(uint32_t index, uint32_t type)=
 "sensor index: 0x%"PRIx32", type: %"PRIu32
>  spapr_rtas_get_sensor_state_invalid(uint32_t index) "sensor index: 0x%"P=
RIx32
>  spapr_rtas_ibm_configure_connector_invalid(uint32_t index) "DRC index: 0=
x%"PRIx32
> -- =

> 2.9.4
>=20
