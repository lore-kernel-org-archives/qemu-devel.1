Received: from eggs.gnu.org ([2001:4830:134:3::10]:46202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNLm4-0006rm-2W
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNLm0-0004lr-1B
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:13:04 -0400
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:58166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dNLlz-0004kp-QE
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:12:59 -0400
Received: from player789.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 42D3E5EE29
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 18:12:56 +0200 (CEST)
Date: Tue, 20 Jun 2017 18:12:48 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170620181248.1679d41f@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20170620015332.13874-2-david@gibson.dropbear.id.au>
References: <20170620015332.13874-1-david@gibson.dropbear.id.au>
	<20170620015332.13874-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/NvebB3/QusfOt3GjewlWh/m";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 1/5] spapr: Leave DR-indicator management
 to the guest
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

--Sig_/NvebB3/QusfOt3GjewlWh/m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jun 2017 09:53:28 +0800
David Gibson <david@gibson.dropbear.id.au> wrote:

> The DR-indicator is essentially a "virtual LED" attached to a hotpluggable
> device, which the guest can set to various states for the attention of
> the operator or management layers.
>=20
> It's mostly guest managed, except that we once-off set it to
> ACTIVE/INACTIVE in the attach/detach path.  While that makes certain sens=
e,
> there's no indication in PAPR that the hypervisor should do this, and the
> drmgr code on the guest side doesn't appear to need it (it will already s=
et
> the indicator to ACTIVE on hotplug, and INACTIVE on remove).
>=20
> So, leave the DR-indicator entirely to the guest; the only thing we need
> to do is ensure it's in a sane state on reset.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_drc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index fd9e07d..0bc9046 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -353,8 +353,6 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceSt=
ate *d, void *fdt,
>      }
>      g_assert(fdt || coldplug);
> =20
> -    drc->dr_indicator =3D SPAPR_DR_INDICATOR_ACTIVE;
> -
>      drc->dev =3D d;
>      drc->fdt =3D fdt;
>      drc->fdt_start_offset =3D fdt_start_offset;
> @@ -372,8 +370,6 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceSt=
ate *d, void *fdt,
> =20
>  static void spapr_drc_release(sPAPRDRConnector *drc)
>  {
> -    drc->dr_indicator =3D SPAPR_DR_INDICATOR_INACTIVE;
> -
>      /* Calling release callbacks based on spapr_drc_type(drc). */
>      switch (spapr_drc_type(drc)) {
>      case SPAPR_DR_CONNECTOR_TYPE_CPU:
> @@ -452,12 +448,14 @@ static void reset(DeviceState *d)
>          if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
>              drc->allocation_state =3D SPAPR_DR_ALLOCATION_STATE_USABLE;
>          }
> +        drc->dr_indicator =3D SPAPR_DR_INDICATOR_ACTIVE;
>      } else {
>          /* Otherwise device is absent, but might be hotplugged */
>          drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_ISOLATED;
>          if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
>              drc->allocation_state =3D SPAPR_DR_ALLOCATION_STATE_UNUSABLE;
>          }
> +        drc->dr_indicator =3D SPAPR_DR_INDICATOR_INACTIVE;
>      }
>  }
> =20


--Sig_/NvebB3/QusfOt3GjewlWh/m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllJSYAACgkQAvw66wEB28JjEQCgo4O+NpjACg7jS2o/qYqkVIeN
90wAn15e/UR3n+f7uGmYM5urVSYoWNuI
=B0gY
-----END PGP SIGNATURE-----

--Sig_/NvebB3/QusfOt3GjewlWh/m--
