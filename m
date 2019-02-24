Received: from eggs.gnu.org ([209.51.188.92]:37031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gy3Kz-0002bj-Tw
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 18:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gy3Ky-0003LN-GM
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 18:37:37 -0500
Date: Mon, 25 Feb 2019 10:27:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190224232755.GB7668@umbus.fritz.box>
References: <1550748288-30598-1-git-send-email-thuth@redhat.com>
	<895254c7-745e-e594-ceed-df09a1dc84c5@redhat.com>
	<f672e31f-8b68-24ad-f0bc-75c83e84dad5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <f672e31f-8b68-24ad-f0bc-75c83e84dad5@redhat.com>
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 07:20:14AM +0100, Thomas Huth wrote:
> On 21/02/2019 19.14, Philippe Mathieu-Daud=E9 wrote:
> > On 2/21/19 12:24 PM, Thomas Huth wrote:
> >> Both functions, object_initialize() and object_property_add_child() in=
crease
> >> the reference counter of the new object, so one of the references has =
to be
> >> dropped afterwards to get the reference counting right. Otherwise the =
child
> >> object will not be properly cleaned up when the parent gets destroyed.
> >> Thus let's use now object_initialize_child() instead to get the refere=
nce
> >> counting here right.
> >>
> >> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  hw/ppc/pnv.c     | 12 ++++++------
> >>  hw/ppc/pnv_psi.c |  4 ++--
> >>  hw/ppc/spapr.c   |  6 +++---
> >>  3 files changed, 11 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> >> index da54086..9e03e9c 100644
> >> --- a/hw/ppc/pnv.c
> >> +++ b/hw/ppc/pnv.c
> >> @@ -736,18 +736,18 @@ static void pnv_chip_power8_instance_init(Object=
 *obj)
> >>  {
> >>      Pnv8Chip *chip8 =3D PNV8_CHIP(obj);
> >> =20
> >> -    object_initialize(&chip8->psi, sizeof(chip8->psi), TYPE_PNV_PSI);
> >> -    object_property_add_child(obj, "psi", OBJECT(&chip8->psi), NULL);
> >> +    object_initialize_child(obj, "psi",  &chip8->psi, sizeof(chip8->p=
si),
> >> +                            TYPE_PNV_PSI, &error_abort, NULL);
> >>      object_property_add_const_link(OBJECT(&chip8->psi), "xics",
> >>                                     OBJECT(qdev_get_machine()), &error=
_abort);
> >> =20
> >> -    object_initialize(&chip8->lpc, sizeof(chip8->lpc), TYPE_PNV_LPC);
> >> -    object_property_add_child(obj, "lpc", OBJECT(&chip8->lpc), NULL);
> >> +    object_initialize_child(obj, "lpc",  &chip8->lpc, sizeof(chip8->l=
pc),
> >> +                            TYPE_PNV_LPC, &error_abort, NULL);
> >>      object_property_add_const_link(OBJECT(&chip8->lpc), "psi",
> >>                                     OBJECT(&chip8->psi), &error_abort);
> >> =20
> >> -    object_initialize(&chip8->occ, sizeof(chip8->occ), TYPE_PNV_OCC);
> >> -    object_property_add_child(obj, "occ", OBJECT(&chip8->occ), NULL);
> >> +    object_initialize_child(obj, "occ",  &chip8->occ, sizeof(chip8->o=
cc),
> >> +                            TYPE_PNV_OCC, &error_abort, NULL);
> >>      object_property_add_const_link(OBJECT(&chip8->occ), "psi",
> >>                                     OBJECT(&chip8->psi), &error_abort);
> >>  }
> >> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> >> index 8ced095..44bc0cb 100644
> >> --- a/hw/ppc/pnv_psi.c
> >> +++ b/hw/ppc/pnv_psi.c
> >> @@ -444,8 +444,8 @@ static void pnv_psi_init(Object *obj)
> >>  {
> >>      PnvPsi *psi =3D PNV_PSI(obj);
> >> =20
> >> -    object_initialize(&psi->ics, sizeof(psi->ics), TYPE_ICS_SIMPLE);
> >> -    object_property_add_child(obj, "ics-psi", OBJECT(&psi->ics), NULL=
);
> >> +    object_initialize_child(obj, "ics-psi",  &psi->ics, sizeof(psi->i=
cs),
> >> +                            TYPE_ICS_SIMPLE, &error_abort, NULL);
> >>  }
> >> =20
> >>  static const uint8_t irq_to_xivr[] =3D {
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index abf9ebc..6c58dca 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -1696,9 +1696,9 @@ static void spapr_create_nvram(sPAPRMachineState=
 *spapr)
> >> =20
> >>  static void spapr_rtc_create(sPAPRMachineState *spapr)
> >>  {
> >> -    object_initialize(&spapr->rtc, sizeof(spapr->rtc), TYPE_SPAPR_RTC=
);
> >> -    object_property_add_child(OBJECT(spapr), "rtc", OBJECT(&spapr->rt=
c),
> >> -                              &error_fatal);
> >> +    object_initialize_child(OBJECT(spapr), "rtc",
> >> +                            &spapr->rtc, sizeof(spapr->rtc), TYPE_SPA=
PR_RTC,
> >> +                            &error_fatal, NULL);
> >>      object_property_set_bool(OBJECT(&spapr->rtc), true, "realized",
> >>                                &error_fatal);
> >>      object_property_add_alias(OBJECT(spapr), "rtc-time", OBJECT(&spap=
r->rtc),
> >>
> >=20
> > What about intc/spapr_xive.c?
>=20
> Good hint. I missed that one since it's in hw/intc, not in hw/ppc...
>=20
> David, could you please squash this on top:
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 290a290..ac5f5ef 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -244,13 +244,12 @@ static void spapr_xive_instance_init(Object *obj)
>  {
>      sPAPRXive *xive =3D SPAPR_XIVE(obj);
> =20
> -    object_initialize(&xive->source, sizeof(xive->source), TYPE_XIVE_SOU=
RCE);
> -    object_property_add_child(obj, "source", OBJECT(&xive->source), NULL=
);
> +    object_initialize_child(obj, "source", &xive->source, sizeof(xive->s=
ource),
> +                            TYPE_XIVE_SOURCE, &error_abort, NULL);
> =20
> -    object_initialize(&xive->end_source, sizeof(xive->end_source),
> -                      TYPE_XIVE_END_SOURCE);
> -    object_property_add_child(obj, "end_source", OBJECT(&xive->end_sourc=
e),
> -                              NULL);
> +    object_initialize_child(obj, "end_source", &xive->end_source,
> +                            sizeof(xive->end_source), TYPE_XIVE_END_SOUR=
CE,
> +                            &error_abort, NULL);
>  }
> =20
>  static void spapr_xive_realize(DeviceState *dev, Error **errp)
>=20
>=20
> ... or shall I rather send a v2 or a separate patch for this?

Folded as requested, thanks.

>=20
>  Thomas
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxzKHsACgkQbDjKyiDZ
s5JfCBAApaE3upRqlva+gtE4D48huvQXKhn4n1sQS9YRzBcr+LjZhIQp7qqWbxxb
Sbw90x8CnQQoAcFS1DIcZYlaNm6v1Z71RJyOeYLVtjzgrWWzL/MsVlC3hVkqde7G
bDGmJl7cOftxZepboqzU4QdoTl/hM4XLNk46rZCFOU5hinClqYE0MEOP+ZVbztrB
7U4u3VuGtrgrljZotXMWrPAKMDh3WQugF1/nwMGiGcA9mOaV289elLbi/a3JjZoW
tdTVoUtyjMXURe/5avO2JL85dmQEBU4kSrKM5PZaGvAeKvyxG1Yc2Lj2RPbTAnDz
enMxEHZx5QlddZZ+5kCCX1mE3NvYgaXS+AFm3ooHJg/krDoaiqtE7sVuj+REAqbv
8bKHKHdPsoJBvWGyy0m/mGbX3+GkoEVaBCSI7K4+D2hvkG/IZFtElA94dAIYvI3W
ZvbSVech06UrMYCo3NT6fkpWclYXWxBvHOTbSxYJG92MkRwfXvBAxdGeAijjwCGL
IaSxUvfOVsEasiaQVlUEBYcOKWKtISud8le1zGfELnrVPBYHyO5DvGdXvhIjzSBs
WjuH2jCFqWmVoWedcqxohSNzRJ5UnH4g5DE37IDsGA7CxoaRJsg0Sc89gJUrp3tE
DybYeHZ0Bzv+O/SEX9HKX4+s/73eCT0PVehbkbNpbrsc3AvdZ0s=
=wUej
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
