Received: from eggs.gnu.org ([2001:4830:134:3::10]:33950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dMthz-0002BW-GL
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dMthv-0004cI-C8
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:14:59 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:42405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dMthv-0004bW-5r
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:14:55 -0400
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id B7A4248E7E
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 12:14:53 +0200 (CEST)
Date: Mon, 19 Jun 2017 12:14:47 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170619121447.53bec317@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170608050930.2613-4-david@gibson.dropbear.id.au>
References: <20170608050930.2613-1-david@gibson.dropbear.id.au>
	<20170608050930.2613-4-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/2JJulu2Zw_KxYugSJ1Y9V+n";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 3/6] spapr: Split DRC release from DRC
 detach
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/2JJulu2Zw_KxYugSJ1Y9V+n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu,  8 Jun 2017 15:09:27 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> spapr_drc_detach() is called when qemu generic code requests a device be
> unplugged.  It makes a number of tests, which could well delay further
> action until later, before actually detach the device from the DRC.
>=20
> This splits out the part which actually removes the device from the DRC
> into spapr_drc_release().  This will be useful for further cleanups.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_drc.c | 54 ++++++++++++++++++++++++++++++------------------=
------
>  1 file changed, 30 insertions(+), 24 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index afd68f4..dc4ac77 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -326,31 +326,9 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceS=
tate *d, void *fdt,
>                               NULL, 0, NULL);
>  }
> =20
> -void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **err=
p)
> -{
> -    trace_spapr_drc_detach(spapr_drc_index(drc));
> -
> -    if (drc->isolation_state !=3D SPAPR_DR_ISOLATION_STATE_ISOLATED) {
> -        trace_spapr_drc_awaiting_isolated(spapr_drc_index(drc));
> -        drc->awaiting_release =3D true;
> -        return;
> -    }
> -
> -    if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI &&
> -        drc->allocation_state !=3D SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
> -        trace_spapr_drc_awaiting_unusable(spapr_drc_index(drc));
> -        drc->awaiting_release =3D true;
> -        return;
> -    }
> -
> -    if (drc->awaiting_allocation) {
> -        if (!drc->awaiting_allocation_skippable) {
> -            drc->awaiting_release =3D true;
> -            trace_spapr_drc_awaiting_allocation(spapr_drc_index(drc));
> -            return;
> -        }
> -    }
> =20
> +static void spapr_drc_release(sPAPRDRConnector *drc)
> +{
>      drc->dr_indicator =3D SPAPR_DR_INDICATOR_INACTIVE;
> =20
>      /* Calling release callbacks based on spapr_drc_type(drc). */
> @@ -379,6 +357,34 @@ void spapr_drc_detach(sPAPRDRConnector *drc, DeviceS=
tate *d, Error **errp)
>      drc->dev =3D NULL;
>  }
> =20
> +void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **err=
p)
> +{
> +    trace_spapr_drc_detach(spapr_drc_index(drc));
> +
> +    if (drc->isolation_state !=3D SPAPR_DR_ISOLATION_STATE_ISOLATED) {
> +        trace_spapr_drc_awaiting_isolated(spapr_drc_index(drc));
> +        drc->awaiting_release =3D true;
> +        return;
> +    }
> +
> +    if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI &&
> +        drc->allocation_state !=3D SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
> +        trace_spapr_drc_awaiting_unusable(spapr_drc_index(drc));
> +        drc->awaiting_release =3D true;
> +        return;
> +    }
> +
> +    if (drc->awaiting_allocation) {
> +        if (!drc->awaiting_allocation_skippable) {
> +            drc->awaiting_release =3D true;
> +            trace_spapr_drc_awaiting_allocation(spapr_drc_index(drc));
> +            return;
> +        }
> +    }
> +
> +    spapr_drc_release(drc);
> +}
> +
>  static bool release_pending(sPAPRDRConnector *drc)
>  {
>      return drc->awaiting_release;


--Sig_/2JJulu2Zw_KxYugSJ1Y9V+n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllHpBcACgkQAvw66wEB28JcrQCeJnX1Lv72N1noE9ZaBnQHR9TE
AsYAn1SfBJGUELXj5uPj/HQTqPZyRVsc
=W5gp
-----END PGP SIGNATURE-----

--Sig_/2JJulu2Zw_KxYugSJ1Y9V+n--
