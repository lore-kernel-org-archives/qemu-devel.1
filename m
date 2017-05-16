Received: from eggs.gnu.org ([2001:4830:134:3::10]:49668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAUTj-0000K8-2f
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAUTg-0003VB-0y
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:52:59 -0400
Date: Tue, 16 May 2017 14:39:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170516043934.GH30022@umbus.fritz.box>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484838558.20089.5029926585755792842.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h3LYUU6HlUDSAOzy"
Content-Disposition: inline
In-Reply-To: <149484838558.20089.5029926585755792842.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 4/6] spapr: sanitize error handling in
 spapr_ics_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>


--h3LYUU6HlUDSAOzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 01:39:45PM +0200, Greg Kurz wrote:
> The spapr_ics_create() function handles errors in a rather convoluted
> way, with two local Error * variables. Moreover, failing to parent the
> ICS object to the machine should be considered as a bug but it is
> currently ignored.
>=20
> This patch addresses both issues.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.10

> ---
>  hw/ppc/spapr.c |   19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 44f7dc7f40e9..c53989bb10b1 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -101,21 +101,26 @@ static ICSState *spapr_ics_create(sPAPRMachineState=
 *spapr,
>                                    const char *type_ics,
>                                    int nr_irqs, Error **errp)
>  {
> -    Error *err =3D NULL, *local_err =3D NULL;
> +    Error *local_err =3D NULL;
>      Object *obj;
> =20
>      obj =3D object_new(type_ics);
> -    object_property_add_child(OBJECT(spapr), "ics", obj, NULL);
> +    object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
>      object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_ab=
ort);
> -    object_property_set_int(obj, nr_irqs, "nr-irqs", &err);
> +    object_property_set_int(obj, nr_irqs, "nr-irqs", &local_err);
> +    if (local_err) {
> +        goto error;
> +    }
>      object_property_set_bool(obj, true, "realized", &local_err);
> -    error_propagate(&err, local_err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return NULL;
> +    if (local_err) {
> +        goto error;
>      }
> =20
>      return ICS_SIMPLE(obj);
> +
> +error:
> +    error_propagate(errp, local_err);
> +    return NULL;
>  }
> =20
>  static void xics_system_init(MachineState *machine, int nr_irqs, Error *=
*errp)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--h3LYUU6HlUDSAOzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZGoKGAAoJEGw4ysog2bOSD1UQANdUvAIFeJOoJbHrkCpkIzb3
69v7r15+zpqUxqMIyJy9FMTG5+aE2eD/GXxFfj+O7bCrJcKcKec7Fkm3MvVpu6S/
lBHS0Y2eqZ4Keb09fL6b6yDCF1IvLa4tJmuAqa+1GIQUxJZ8gFf+fyLFF5L05axS
bT8txbq1dsJt0gZfVe266JgZ8rTBmTqnj5p1620kgg+VlLoPQbLHDZkmJQsn5BVS
5QulFVK4F2Z//bLVH/Q1W4nG5PUOrqAb3UPhjF4xXmMKIjLI+cXQaNrFrhI8q1u5
q3PhP4+hAkWoVlTFreGKM7tdJtI3rposmhWQWRyJeKGbWfkB9Xg718bsvoM3SoAp
Yf2DDN9eihscLOlZold/tpz7w98lnyq62tZ28w+rBew7iphBZcbSYo6tu4LO9cZL
ke3EPznlFIGB2xHLqcnA53/HNmZ6CRoUbsFfQZI75v85yg5BVWNpf3CTopFwjH8v
r6lp5nZJ1xh0Gwr1wG53/0+TMnivj15S+A7CYjkIdULh8u/TCgq7Ft0trET9Rhad
o0z6Rk5QgJE8XkfCXDSDjJlZSYX/NtizznaSZGVilN4nwg4IYaRYJ+hWyppLM0Zl
lu5imogfgZI4UkzBVNOz3bzVkp4w6uq2lszVg7cdj1m30vTPhze0AtiT5gMNRuZe
bz58vFOaktVzOO8446+U
=BPlT
-----END PGP SIGNATURE-----

--h3LYUU6HlUDSAOzy--
