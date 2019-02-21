Received: from eggs.gnu.org ([209.51.188.92]:33087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwx3c-000258-Bz
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 17:43:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwx3b-000456-09
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 17:43:08 -0500
Date: Fri, 22 Feb 2019 09:29:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190221222903.GB8609@umbus.fritz.box>
References: <1550748288-30598-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
In-Reply-To: <1550748288-30598-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc: Use object_initialize_child for
 correct reference counting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2019 at 12:24:48PM +0100, Thomas Huth wrote:
> Both functions, object_initialize() and object_property_add_child() incre=
ase
> the reference counter of the new object, so one of the references has to =
be
> dropped afterwards to get the reference counting right. Otherwise the chi=
ld
> object will not be properly cleaned up when the parent gets destroyed.
> Thus let's use now object_initialize_child() instead to get the reference
> counting here right.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Nice cleanup for a common pattern, even if it weren't fixing a bug.  Applie=
d.

> ---
>  hw/ppc/pnv.c     | 12 ++++++------
>  hw/ppc/pnv_psi.c |  4 ++--
>  hw/ppc/spapr.c   |  6 +++---
>  3 files changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index da54086..9e03e9c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -736,18 +736,18 @@ static void pnv_chip_power8_instance_init(Object *o=
bj)
>  {
>      Pnv8Chip *chip8 =3D PNV8_CHIP(obj);
> =20
> -    object_initialize(&chip8->psi, sizeof(chip8->psi), TYPE_PNV_PSI);
> -    object_property_add_child(obj, "psi", OBJECT(&chip8->psi), NULL);
> +    object_initialize_child(obj, "psi",  &chip8->psi, sizeof(chip8->psi),
> +                            TYPE_PNV_PSI, &error_abort, NULL);
>      object_property_add_const_link(OBJECT(&chip8->psi), "xics",
>                                     OBJECT(qdev_get_machine()), &error_ab=
ort);
> =20
> -    object_initialize(&chip8->lpc, sizeof(chip8->lpc), TYPE_PNV_LPC);
> -    object_property_add_child(obj, "lpc", OBJECT(&chip8->lpc), NULL);
> +    object_initialize_child(obj, "lpc",  &chip8->lpc, sizeof(chip8->lpc),
> +                            TYPE_PNV_LPC, &error_abort, NULL);
>      object_property_add_const_link(OBJECT(&chip8->lpc), "psi",
>                                     OBJECT(&chip8->psi), &error_abort);
> =20
> -    object_initialize(&chip8->occ, sizeof(chip8->occ), TYPE_PNV_OCC);
> -    object_property_add_child(obj, "occ", OBJECT(&chip8->occ), NULL);
> +    object_initialize_child(obj, "occ",  &chip8->occ, sizeof(chip8->occ),
> +                            TYPE_PNV_OCC, &error_abort, NULL);
>      object_property_add_const_link(OBJECT(&chip8->occ), "psi",
>                                     OBJECT(&chip8->psi), &error_abort);
>  }
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 8ced095..44bc0cb 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -444,8 +444,8 @@ static void pnv_psi_init(Object *obj)
>  {
>      PnvPsi *psi =3D PNV_PSI(obj);
> =20
> -    object_initialize(&psi->ics, sizeof(psi->ics), TYPE_ICS_SIMPLE);
> -    object_property_add_child(obj, "ics-psi", OBJECT(&psi->ics), NULL);
> +    object_initialize_child(obj, "ics-psi",  &psi->ics, sizeof(psi->ics),
> +                            TYPE_ICS_SIMPLE, &error_abort, NULL);
>  }
> =20
>  static const uint8_t irq_to_xivr[] =3D {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index abf9ebc..6c58dca 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1696,9 +1696,9 @@ static void spapr_create_nvram(sPAPRMachineState *s=
papr)
> =20
>  static void spapr_rtc_create(sPAPRMachineState *spapr)
>  {
> -    object_initialize(&spapr->rtc, sizeof(spapr->rtc), TYPE_SPAPR_RTC);
> -    object_property_add_child(OBJECT(spapr), "rtc", OBJECT(&spapr->rtc),
> -                              &error_fatal);
> +    object_initialize_child(OBJECT(spapr), "rtc",
> +                            &spapr->rtc, sizeof(spapr->rtc), TYPE_SPAPR_=
RTC,
> +                            &error_fatal, NULL);
>      object_property_set_bool(OBJECT(&spapr->rtc), true, "realized",
>                                &error_fatal);
>      object_property_add_alias(OBJECT(spapr), "rtc-time", OBJECT(&spapr->=
rtc),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxvJi0ACgkQbDjKyiDZ
s5IGNg/+O0BF3kTUamJXq9NOMlYMwXIXkp4PoJ5robnLdIZqrSEPg2FPi+mFF99Y
M86MFmP8OZ4J27t78BOtFVJc5vwnmtMl13YADF0kRD7UlFr1uTRkA4LFE6GBj+MR
4LFfIZdOwXuvkkK432t3Ripdw49irc/hzci7cyT6aK83t4RSQgle45A+FDrTcBka
r15Wh3gD+HsQQgo9ThhFeT2YB4X0+5gNzOKYk0zyUiPy5C28usvWZ3Z/TDVfEYPv
co/pDFuMR9sddavMx+wUvIX0HRa/vXuMWJC/aB9Otp1BP1ATuakTRvF2o8r2Sx65
HA1QmLsTXHC7dXcJ8r2mfDDb+IQnKtGUdYqfy7O0isRQy3es2WikK/rJ+OFqUIfy
Fvyq70/8jKIR1n6aeAxgnQ6f3BDATmIIa5f8Bx3B1GKIDSwmDq0dbck03zYyBVn1
ZGHIxSHIxXKkr5BI5maFTmjJ+3KerM4kYsg4caiz36e02hWzSD0fhYUf+j1eSHX2
Ob7ZCfqBO+cMVmVYLjzNZ3Zs4Q1KeQTvawcZP2wCiqXCKquvXeN49c1x1T7NO5jk
s/Rk5Zhno6kncLwr8Vbyuapgh385TDwLgk2rNJBt0fyFuVFvUn9O656fyW1O9+Wn
3P4JIwh2PijX5WFU0mtgutUnsloF/STV4EDvijZuDpdMypR6V88=
=HF9q
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
