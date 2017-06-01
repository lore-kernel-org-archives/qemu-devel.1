Received: from eggs.gnu.org ([2001:4830:134:3::10]:41795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGSf8-0003wO-1J
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGSf4-0002UW-0v
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:09:25 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:47978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dGSf3-0002U7-OF
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:09:21 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 8D3A81008ED
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 18:09:20 +0200 (CEST)
Date: Thu, 1 Jun 2017 18:09:12 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170601180912.4e24d6e0@bahia.lan>
In-Reply-To: <20170601015218.9299-3-david@gibson.dropbear.id.au>
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
	<20170601015218.9299-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Bs=Q6d9DsLrp3hLTBLxEAuB";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/4] spapr: Abolish DRC get_fdt
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
Cc: mdroth@linux.vnet.ibm.com, lvivier@redhat.com, sursingh@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com

--Sig_/Bs=Q6d9DsLrp3hLTBLxEAuB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu,  1 Jun 2017 11:52:16 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> The DRConnectorClass includes a get_fdt method.  However
>   * There's only one implementation, and there's only likely to ever be o=
ne
>   * Both callers are local to spapr_drc
>   * Each caller only uses one half of the actual implementation
>=20
> So abolish get_fdt() entirely, and just open-code what we need.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_drc.c         | 23 ++++++-----------------
>  include/hw/ppc/spapr_drc.h |  1 -
>  2 files changed, 6 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index ae8800d..f5b7b68 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -199,14 +199,6 @@ static const char *get_name(sPAPRDRConnector *drc)
>      return drc->name;
>  }
> =20
> -static const void *get_fdt(sPAPRDRConnector *drc, int *fdt_start_offset)
> -{
> -    if (fdt_start_offset) {
> -        *fdt_start_offset =3D drc->fdt_start_offset;
> -    }
> -    return drc->fdt;
> -}
> -
>  static void set_configured(sPAPRDRConnector *drc)
>  {
>      trace_spapr_drc_set_configured(get_index(drc));
> @@ -753,7 +745,6 @@ static void spapr_dr_connector_class_init(ObjectClass=
 *k, void *data)
>      drck->get_index =3D get_index;
>      drck->get_type =3D get_type;
>      drck->get_name =3D get_name;
> -    drck->get_fdt =3D get_fdt;
>      drck->set_configured =3D set_configured;
>      drck->entity_sense =3D entity_sense;
>      drck->attach =3D attach;
> @@ -1126,7 +1117,6 @@ static void rtas_ibm_configure_connector(PowerPCCPU=
 *cpu,
>      sPAPRConfigureConnectorState *ccs;
>      sPAPRDRCCResponse resp =3D SPAPR_DR_CC_RESPONSE_CONTINUE;
>      int rc;
> -    const void *fdt;
> =20
>      if (nargs !=3D 2 || nret !=3D 1) {
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> @@ -1144,8 +1134,7 @@ static void rtas_ibm_configure_connector(PowerPCCPU=
 *cpu,
>      }
> =20
>      drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -    fdt =3D drck->get_fdt(drc, NULL);
> -    if (!fdt) {
> +    if (!drc->fdt) {
>          trace_spapr_rtas_ibm_configure_connector_missing_fdt(drc_index);
>          rc =3D SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE;
>          goto out;
> @@ -1154,7 +1143,7 @@ static void rtas_ibm_configure_connector(PowerPCCPU=
 *cpu,
>      ccs =3D spapr_ccs_find(spapr, drc_index);
>      if (!ccs) {
>          ccs =3D g_new0(sPAPRConfigureConnectorState, 1);
> -        (void)drck->get_fdt(drc, &ccs->fdt_offset);
> +        ccs->fdt_offset =3D drc->fdt_start_offset;
>          ccs->drc_index =3D drc_index;
>          spapr_ccs_add(spapr, ccs);
>      }
> @@ -1165,12 +1154,12 @@ static void rtas_ibm_configure_connector(PowerPCC=
PU *cpu,
>          const struct fdt_property *prop;
>          int fdt_offset_next, prop_len;
> =20
> -        tag =3D fdt_next_tag(fdt, ccs->fdt_offset, &fdt_offset_next);
> +        tag =3D fdt_next_tag(drc->fdt, ccs->fdt_offset, &fdt_offset_next=
);
> =20
>          switch (tag) {
>          case FDT_BEGIN_NODE:
>              ccs->fdt_depth++;
> -            name =3D fdt_get_name(fdt, ccs->fdt_offset, NULL);
> +            name =3D fdt_get_name(drc->fdt, ccs->fdt_offset, NULL);
> =20
>              /* provide the name of the next OF node */
>              wa_offset =3D CC_VAL_DATA_OFFSET;
> @@ -1193,9 +1182,9 @@ static void rtas_ibm_configure_connector(PowerPCCPU=
 *cpu,
>              }
>              break;
>          case FDT_PROP:
> -            prop =3D fdt_get_property_by_offset(fdt, ccs->fdt_offset,
> +            prop =3D fdt_get_property_by_offset(drc->fdt, ccs->fdt_offse=
t,
>                                                &prop_len);
> -            name =3D fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
> +            name =3D fdt_string(drc->fdt, fdt32_to_cpu(prop->nameoff));
> =20
>              /* provide the name of the next OF property */
>              wa_offset =3D CC_VAL_DATA_OFFSET;
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index 813b9ff..80db955 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -178,7 +178,6 @@ typedef struct sPAPRDRConnectorClass {
>      uint32_t (*entity_sense)(sPAPRDRConnector *drc, sPAPRDREntitySense *=
state);
> =20
>      /* QEMU interfaces for managing FDT/configure-connector */
> -    const void *(*get_fdt)(sPAPRDRConnector *drc, int *fdt_start_offset);
>      void (*set_configured)(sPAPRDRConnector *drc);
> =20
>      /* QEMU interfaces for managing hotplug operations */


--Sig_/Bs=Q6d9DsLrp3hLTBLxEAuB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkwPCkACgkQAvw66wEB28LAOQCgnAVAHWww+3zWFU/XeBY3RVA+
rzsAniqxTekClxHWf2gLzuIVWBDNWpr+
=spNd
-----END PGP SIGNATURE-----

--Sig_/Bs=Q6d9DsLrp3hLTBLxEAuB--
