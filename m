Received: from eggs.gnu.org ([2001:4830:134:3::10]:58667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dGSAc-0001fT-3O
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dGSAY-0005MI-W3
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:37:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56119
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dGSAY-0005Kz-Q6
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:37:50 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v51FXrDE023413
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 11:37:49 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ata1nk3x2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 11:37:49 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 1 Jun 2017 11:37:48 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170601015218.9299-4-david@gibson.dropbear.id.au>
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
	<20170601015218.9299-4-david@gibson.dropbear.id.au>
Date: Thu, 01 Jun 2017 10:37:39 -0500
Message-Id: <149633145975.3207.486309081928645378@loki>
Subject: Re: [Qemu-devel] [PATCH 3/4] spapr: Abolish DRC set_configured
 method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, nikunj@linux.vnet.ibm.com, sursingh@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com

Quoting David Gibson (2017-05-31 20:52:17)
> DRConnectorClass has a set_configured method, however:
>   * There is only one implementation, and only ever likely to be one
>   * There's exactly one caller, and that's (now) local
>   * The implementation is very straightforward
> =

> So abolish the method entirely, and just open-code what we need.  We also
> remove the tracepoints associated with it, since they don't look to be
> terribly useful.

Dropping the method makes sense, but the 'configured' state affects a
lot of the state-transitions throughout the code so I think it may
be useful to keep the traces.

> =

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_drc.c         | 20 ++++----------------
>  hw/ppc/trace-events        |  2 --
>  include/hw/ppc/spapr_drc.h |  3 ---
>  3 files changed, 4 insertions(+), 21 deletions(-)
> =

> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index f5b7b68..025453b 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -199,18 +199,6 @@ static const char *get_name(sPAPRDRConnector *drc)
>      return drc->name;
>  }
> =

> -static void set_configured(sPAPRDRConnector *drc)
> -{
> -    trace_spapr_drc_set_configured(get_index(drc));
> -
> -    if (drc->isolation_state !=3D SPAPR_DR_ISOLATION_STATE_UNISOLATED) {
> -        /* guest should be not configuring an isolated device */
> -        trace_spapr_drc_set_configured_skipping(get_index(drc));
> -        return;
> -    }
> -    drc->configured =3D true;
> -}
> -
>  /* has the guest been notified of device attachment? */
>  static void set_signalled(sPAPRDRConnector *drc)
>  {
> @@ -745,7 +733,6 @@ static void spapr_dr_connector_class_init(ObjectClass=
 *k, void *data)
>      drck->get_index =3D get_index;
>      drck->get_type =3D get_type;
>      drck->get_name =3D get_name;
> -    drck->set_configured =3D set_configured;
>      drck->entity_sense =3D entity_sense;
>      drck->attach =3D attach;
>      drck->detach =3D detach;
> @@ -1113,7 +1100,6 @@ static void rtas_ibm_configure_connector(PowerPCCPU=
 *cpu,
>      uint64_t wa_offset;
>      uint32_t drc_index;
>      sPAPRDRConnector *drc;
> -    sPAPRDRConnectorClass *drck;
>      sPAPRConfigureConnectorState *ccs;
>      sPAPRDRCCResponse resp =3D SPAPR_DR_CC_RESPONSE_CONTINUE;
>      int rc;
> @@ -1133,7 +1119,6 @@ static void rtas_ibm_configure_connector(PowerPCCPU=
 *cpu,
>          goto out;
>      }
> =

> -    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>      if (!drc->fdt) {
>          trace_spapr_rtas_ibm_configure_connector_missing_fdt(drc_index);
>          rc =3D SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE;
> @@ -1170,10 +1155,13 @@ static void rtas_ibm_configure_connector(PowerPCC=
PU *cpu,
>          case FDT_END_NODE:
>              ccs->fdt_depth--;
>              if (ccs->fdt_depth =3D=3D 0) {
> +                sPAPRDRIsolationState state =3D drc->isolation_state;
>                  /* done sending the device tree, don't need to track
>                   * the state anymore
>                   */
> -                drck->set_configured(drc);
> +                if (state =3D=3D SPAPR_DR_ISOLATION_STATE_UNISOLATED) {
> +                    drc->configured =3D true;
> +                }
>                  spapr_ccs_remove(spapr, ccs);
>                  ccs =3D NULL;
>                  resp =3D SPAPR_DR_CC_RESPONSE_SUCCESS;
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 43d265f..96ffc02 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -42,8 +42,6 @@ spapr_drc_set_isolation_state_deferring(uint32_t index)=
 "drc: 0x%"PRIx32
>  spapr_drc_set_indicator_state(uint32_t index, int state) "drc: 0x%"PRIx3=
2", state: 0x%x"
>  spapr_drc_set_allocation_state(uint32_t index, int state) "drc: 0x%"PRIx=
32", state: 0x%x"
>  spapr_drc_set_allocation_state_finalizing(uint32_t index) "drc: 0x%"PRIx=
32
> -spapr_drc_set_configured(uint32_t index) "drc: 0x%"PRIx32
> -spapr_drc_set_configured_skipping(uint32_t index) "drc: 0x%"PRIx32", iso=
lated device"
>  spapr_drc_entity_sense(uint32_t index, int state) "drc: 0x%"PRIx32", sta=
te: 0x%x"
>  spapr_drc_attach(uint32_t index) "drc: 0x%"PRIx32
>  spapr_drc_detach(uint32_t index) "drc: 0x%"PRIx32
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index 80db955..90f4953 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -177,9 +177,6 @@ typedef struct sPAPRDRConnectorClass {
> =

>      uint32_t (*entity_sense)(sPAPRDRConnector *drc, sPAPRDREntitySense *=
state);
> =

> -    /* QEMU interfaces for managing FDT/configure-connector */
> -    void (*set_configured)(sPAPRDRConnector *drc);
> -
>      /* QEMU interfaces for managing hotplug operations */
>      void (*attach)(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
>                     int fdt_start_offset, bool coldplug, Error **errp);
> -- =

> 2.9.4
> =

>=20
