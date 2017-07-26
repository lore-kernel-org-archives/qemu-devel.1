Received: from eggs.gnu.org ([2001:4830:134:3::10]:60331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDr9-0002Vm-6Q
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDr6-0005lL-5E
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:23:31 -0400
Date: Wed, 26 Jul 2017 14:06:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170726040629.GU8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100558414.27487.6550654617210440325.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="REOXmE5zpOGz6VLu"
Content-Disposition: inline
In-Reply-To: <150100558414.27487.6550654617210440325.stgit@bahia>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 08/26] spapr_drc: add unrealize
 method to physical DRC class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--REOXmE5zpOGz6VLu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 07:59:44PM +0200, Greg Kurz wrote:
> When hot-unplugging a PHB, all its PCI DRC connectors get unrealized. This
> patch adds an unrealize method to the physical DRC class, in order to undo
> registrations performed in realize_physical().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.  In a sense this is fix that could be applied
to ppc-for-2.10, but unlike the last patch, AFAICT there's no way this
bug can be triggered in the current code.

> ---
>  hw/ppc/spapr_drc.c |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index d72453bcb42f..105ce85b6d04 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -626,12 +626,28 @@ static void realize_physical(DeviceState *d, Error =
**errp)
>      qemu_register_reset(drc_physical_reset, drcp);
>  }
> =20
> +static void unrealize_physical(DeviceState *d, Error **errp)
> +{
> +    sPAPRDRCPhysical *drcp =3D SPAPR_DRC_PHYSICAL(d);
> +    Error *local_err =3D NULL;
> +
> +    unrealize(d, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    vmstate_unregister(DEVICE(drcp), &vmstate_spapr_drc_physical, drcp);
> +    qemu_unregister_reset(drc_physical_reset, drcp);
> +}
> +
>  static void spapr_drc_physical_class_init(ObjectClass *k, void *data)
>  {
>      DeviceClass *dk =3D DEVICE_CLASS(k);
>      sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
> =20
>      dk->realize =3D realize_physical;
> +    dk->unrealize =3D unrealize_physical;
>      drck->dr_entity_sense =3D physical_entity_sense;
>      drck->isolate =3D drc_isolate_physical;
>      drck->unisolate =3D drc_unisolate_physical;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--REOXmE5zpOGz6VLu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll4FUUACgkQbDjKyiDZ
s5IdsxAAwRJQHGR3mXyCnZv/OgxpKESgz2YdJ+3QRBW7A0UoaVyogXIo7b7QGA3F
Yl0O1pb71e7de1Ogp3hRSrwgEZpe6K7IdYPXlycq5D3wsP2be1Yy7v86wJO3Rae2
0RQAoWR2OaKgvSeynXpAE8ebanNRctkbGlgS0OJYkw65pZ4M6nlCXirADEn1mtFI
UtiVQEWQlEcfnpsFtOhmPxQYBp52dXrRqpPUyHcOETEq3WV47wTeDR5AOl8bT//i
uonJ0YJMBnAyDlD2SYyFE0ikK7vSaNmKx5lxRBwRFXE493hcDlQWF+F9muwDood9
wqHUbhfIEAPlZrOf/gYe0Fizyh4f+u0SlW6q/X3V0y+KDncMLQ+iSq8gFSQial3F
gXROdCOh3KZLdmqg1+lG33opVE7k2jiAn1SdsxGg2ILJIyQRKH4SoYGAMZCCZOGJ
xB5Avk7YEnFswGd/rTFaNFX/xulCXqClbeCtpQGE6X0QIBAmOvHTPpRVP15drPHO
s9pZgGl8HTx8xjzgl6AldWPYxl2j93fOOpkuPZoq+44FXTPo67Hw6DWwz2E5ScwA
ziK3cG9AGDH1jUd3xHrk8gh5AS8Ao/i2+ryFwWKNess4IHDef92R5VHihZwE7f7H
vBdUEjYyPbw3nVNQOyUTkKQW/SytSA/XHAcQKPWc/3T2WS5Bwpw=
=UoE9
-----END PGP SIGNATURE-----

--REOXmE5zpOGz6VLu--
