Received: from eggs.gnu.org ([2001:4830:134:3::10]:51061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtS-0001Al-Qp
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtQ-0002mz-Fm
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:42 -0400
Date: Tue, 19 Sep 2017 08:44:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170918224423.GF27153@umbus>
References: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505668548-16616-8-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wtjvnLv0o8UUzur2"
Content-Disposition: inline
In-Reply-To: <1505668548-16616-8-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 7/8] openpic: add missing timer fields to
 vmstate_openpic_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, benh@kernel.crashing.org


--wtjvnLv0o8UUzur2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2017 at 06:15:47PM +0100, Mark Cave-Ayland wrote:
> Observation of the code shows indicates that several timer fields are
> missing from the migration stream.

So, adding new things to the migration stream always requires some
thought.  The commit message should contain a rationale for why the
proposed representation is a good one.  In particular is it one that's
unlikely to be difficult if the device changes internal details in
future.  When possible it's best to stick to architected documented
state of the modelled hardware, though I can see you're probably going
to need some extras in this case.

>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/intc/openpic.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
> index 10d6e87..debfcbf 100644
> --- a/hw/intc/openpic.c
> +++ b/hw/intc/openpic.c
> @@ -1570,11 +1570,14 @@ static const VMStateDescription vmstate_openpic_i=
rqsource =3D {
> =20
>  static const VMStateDescription vmstate_openpic_timer =3D {
>      .name =3D "openpic_timer",
> -    .version_id =3D 0,
> -    .minimum_version_id =3D 0,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINT32(tccr, OpenPICTimer),
>          VMSTATE_UINT32(tbcr, OpenPICTimer),
> +        VMSTATE_BOOL(qemu_timer_active, OpenPICTimer),
> +        VMSTATE_TIMER_PTR(qemu_timer, OpenPICTimer),
> +        VMSTATE_UINT64(origin_time, OpenPICTimer),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -1620,7 +1623,7 @@ static const VMStateDescription vmstate_openpic =3D=
 {
>          VMSTATE_UINT32_EQUAL(nb_cpus, OpenPICState, NULL),
>          VMSTATE_STRUCT_VARRAY_UINT32(dst, OpenPICState, nb_cpus, 0,
>                                       vmstate_openpic_irqdest, IRQDest),
> -        VMSTATE_STRUCT_ARRAY(timers, OpenPICState, OPENPIC_MAX_TMR, 0,
> +        VMSTATE_STRUCT_ARRAY(timers, OpenPICState, OPENPIC_MAX_TMR, 1,
>                               vmstate_openpic_timer, OpenPICTimer),
>          VMSTATE_STRUCT_ARRAY(msi, OpenPICState, MAX_MSI, 0,
>                               vmstate_openpic_msi, OpenPICMSI),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wtjvnLv0o8UUzur2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnATEUACgkQbDjKyiDZ
s5IY8BAAvG3o7xK9lJlL03w2tG/soEuT4x2wtlJgKlGKfD2MRZjJA1ljY7VApx6O
qMg1+7o1+CmJ80aCsnn+ac7wTLo8sJ0AswWSvMhj/uIE2Ey0OE9hyf7D0f28Fd+A
jhf8Evko22L6yZXQJaGCU2ThwnZGt0h9Lt8/we7ZCmVWwPsTRu3dPQzqYO7+MHwY
fceFAr7eNyCArPrytQsGOx2Te8Mp6xdNNbOOxW7H46UCa517qKgDdlXu6nvo/0wA
sbmteaPhzgeZghQr++gJ4rNTTAIuQzBgibao3+e+WNml9RKas8baYSXHNU/V0liq
b4Uf8owm4QGocl9Z/N1AaGPEfx0nn6VpUx0PCIPEkw3voF4oPyr2ohR4rne/kLJS
cHdEhNrh11YF9VfYixjWWMVFN3iqUjnI6k/WCVMYGRXjR22AZXUZzLsO/9AKyfQC
tj7YGY5354uz2GBniBQXKx0yUnJ+cB3dYQrHiO4zZpO9H4Z9/0zLZEJ7cfdjFOGF
2xBwh1phJntaiMD8lR6y6Xa2CyhvRPEh5hiRnjANKi6j+YL3OgX8UE+wyFstvejJ
7LZj40w/m65SIkWCSAqNlvdeJ8429eJ5fYy948GXze0rK0a4cGVfqJYTPIysoSzE
MAo8+nQtJ2J/Pukl+5xOb+ShnFd7b8CWc07KLtMl24W0LaFbYKE=
=eVei
-----END PGP SIGNATURE-----

--wtjvnLv0o8UUzur2--
