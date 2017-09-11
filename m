Received: from eggs.gnu.org ([2001:4830:134:3::10]:39387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drMPQ-0007n1-9a
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drMPP-0002HG-CO
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:57:44 -0400
Date: Mon, 11 Sep 2017 20:57:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170911105729.GC2784@umbus.fritz.box>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-4-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
In-Reply-To: <1505054255-2990-4-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 3/4] ppc: add CPU access_type into the
 migration stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, lvivier@redhat.com


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 10, 2017 at 03:37:34PM +0100, Mark Cave-Ayland wrote:
> This is referenced in cpu_ppc_handle_mmu_fault() and so should be included
> in the migration stream.

That is not, on its own, sufficient reason.

> Note: the vmstate_ppc version number has already been bumped by the previ=
ous
> patch in this series.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

As with 2/4 it breaks backwards migration.

But more, I really disklike the idea of migrating this.  It's internal
state for one, and it's also essentially transitory state.  Can we
avoid putting it in the otherwise persistent structure at all? Can we
derive the state from elsewhere?  Can we prevent migration from
occurring in the small windows where this data is live?

> ---
>  target/ppc/machine.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 8fec1a4..10b3c41 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -676,7 +676,7 @@ const VMStateDescription vmstate_ppc_cpu =3D {
> =20
>          /* Internal state */
>          VMSTATE_UINTTL(env.hflags_nmsr, PowerPCCPU),
> -        /* FIXME: access_type? */
> +        VMSTATE_UINT8_V(env.access_type, PowerPCCPU, 6),
> =20
>          /* Interrupt state */
>          VMSTATE_UINT32_V(env.pending_interrupts, PowerPCCPU, 6),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm2bBkACgkQbDjKyiDZ
s5K28hAA5CMwesw0dTbFMFgWJdkMfVOmp3o41cfHfww/KXGjVjZjB9zTTzn7GovA
gyZfSNW0GeZ51qzekADwW/RlCZ3v0wzGqWGS7cMvPpEdmTCoWGL1mOyl141MQerc
6l4S75rCSC/Uv0EApnC2xy5Lx0Hw8ZxoNG4s+p/zHfyD4YGJ6tM1wArVXSnj+MQA
Fj4sUX4aqKttnXq08RarLOcALksUmoQzQmWiaLi6+wcxgrHtzKjXLv7axqPvpFE5
Q1q30QowJG36tBqT4jcIIJxV//z7QcTfhG7Q3PccLERA0XYUWGFRYiD7dTpbcK7R
ZHMKTz9P0rhSXF/FX6GDSvmP56pATHFO1gTffnOFptqxnnOpTKqIdO2lIavstZFp
Ubx5IzIi0Esg/cfCKVWal2CA+e6ViJDNXgh+3JmPgbSdpvPhwgiqplnzM9m94pPM
fXgjcyVwNW/hjldhqHIHQL/oO3eFXHkSUN7L8zoQsO7qj7gYYaM+h4lONgYSzV1t
Xy5UNr4SdDyaqL6OWOwKWxhaeTkU+hZAfiN6pdDFSG7325ItxSba5LCIN+VsZD/b
cXGg5cLdXnCsICJ+ZLjYMe+g16BpwD8fYMeTb3YVFiu+1Ik6LVaalXhdbk71EUqW
fIVUkl333DBjfbiJiQdSCzbPVH1ZTW4jX9MHPLDlOrTzQCuTZo4=
=9Sh9
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
