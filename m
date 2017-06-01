Received: from eggs.gnu.org ([2001:4830:134:3::10]:43519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGSkM-0007na-Cr
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGSkI-0004yp-D1
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:14:50 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:59742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dGSkI-0004x6-2t
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:14:46 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 437C610095B
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 18:14:41 +0200 (CEST)
Date: Thu, 1 Jun 2017 18:14:32 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170601181432.74e92e60@bahia.lan>
In-Reply-To: <20170601015218.9299-4-david@gibson.dropbear.id.au>
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
	<20170601015218.9299-4-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/bLe9PoPskiK1S_IdwAN9Xt9";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/4] spapr: Abolish DRC
 set_configured method
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

--Sig_/bLe9PoPskiK1S_IdwAN9Xt9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu,  1 Jun 2017 11:52:17 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> DRConnectorClass has a set_configured method, however:
>   * There is only one implementation, and only ever likely to be one
>   * There's exactly one caller, and that's (now) local
>   * The implementation is very straightforward
>=20
> So abolish the method entirely, and just open-code what we need.  We also
> remove the tracepoints associated with it, since they don't look to be
> terribly useful.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_drc.c         | 20 ++++----------------
>  hw/ppc/trace-events        |  2 --
>  include/hw/ppc/spapr_drc.h |  3 ---
>  3 files changed, 4 insertions(+), 21 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index f5b7b68..025453b 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -199,18 +199,6 @@ static const char *get_name(sPAPRDRConnector *drc)
>      return drc->name;
>  }
> =20
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
> =20
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
> =20
>      uint32_t (*entity_sense)(sPAPRDRConnector *drc, sPAPRDREntitySense *=
state);
> =20
> -    /* QEMU interfaces for managing FDT/configure-connector */
> -    void (*set_configured)(sPAPRDRConnector *drc);
> -
>      /* QEMU interfaces for managing hotplug operations */
>      void (*attach)(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
>                     int fdt_start_offset, bool coldplug, Error **errp);


--Sig_/bLe9PoPskiK1S_IdwAN9Xt9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkwPWgACgkQAvw66wEB28JTtQCcD8RKFSp59pWbTOZzlVSdkl++
xpsAn1KxkVYlXXBVbG0qfj9lzy5PdBjp
=9J4f
-----END PGP SIGNATURE-----

--Sig_/bLe9PoPskiK1S_IdwAN9Xt9--
