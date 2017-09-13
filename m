Received: from eggs.gnu.org ([2001:4830:134:3::10]:57167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ds25i-0005cQ-Ci
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ds25e-0001QR-By
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:28:10 -0400
Date: Wed, 13 Sep 2017 17:12:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170913071249.GI7550@umbus.fritz.box>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-5-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZY5CS28jBCfb727c"
Content-Disposition: inline
In-Reply-To: <1505054255-2990-5-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 4/4] ppc: ensure we update the decrementer
 value during migration
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


--ZY5CS28jBCfb727c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 10, 2017 at 03:37:35PM +0100, Mark Cave-Ayland wrote:
> During local testing with TCG, intermittent errors were found when trying=
 to
> migrate Darwin OS images.
>=20
> The underlying cause was that Darwin resets the decrementer value to fair=
ly
> small values on each interrupt. cpu_ppc_set_tb_clk() sets the default val=
ue
> of the decrementer to 0xffffffff during initialisation which typically
> corresponds to several seconds. Hence when restoring the image, the guest
> would effectively "lose" decrementer interrupts during this time causing
> confusion in the guest.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is subtly incorrect.  It sets the DECR on load to exactly the
value that was saved.  That effectively means that the DECR is frozen
for the migration downtime, which probably isn't what we want.

Instead we need to save the DECR as an offset from the timebase, and
restore it relative to the (downtime adjusted) timebase on the
destination.

The complication with that is that the timebase is generally migrated
at the machine level, not the cpu level: the timebase is generally
synchronized between cpus in the machine, and migrating it at the
individual cpu could break that.  Which means we probably need a
machine level hook to handle the decrementer too, even though it
logically *is* per-cpu, because otherwise we'll be trying to restore
it before the timebase is restored.

> ---
>  target/ppc/machine.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 10b3c41..a16a856 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -176,6 +176,7 @@ static void cpu_pre_save(void *opaque)
>      env->spr[SPR_CFAR] =3D env->cfar;
>  #endif
>      env->spr[SPR_BOOKE_SPEFSCR] =3D env->spe_fscr;
> +    env->spr[SPR_DECR] =3D cpu_ppc_load_decr(env);
> =20
>      for (i =3D 0; (i < 4) && (i < env->nb_BATs); i++) {
>          env->spr[SPR_DBAT0U + 2*i] =3D env->DBAT[0][i];
> @@ -280,6 +281,7 @@ static int cpu_post_load(void *opaque, int version_id)
>      env->cfar =3D env->spr[SPR_CFAR];
>  #endif
>      env->spe_fscr =3D env->spr[SPR_BOOKE_SPEFSCR];
> +    cpu_ppc_store_decr(env, env->spr[SPR_DECR]);
> =20
>      for (i =3D 0; (i < 4) && (i < env->nb_BATs); i++) {
>          env->DBAT[0][i] =3D env->spr[SPR_DBAT0U + 2*i];

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZY5CS28jBCfb727c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm42nEACgkQbDjKyiDZ
s5LtJxAAuVRJw7DhvokMaN1zifZX6I/PAQGnbV03hC50h/EuYqbNndTBz+t21eYS
cbepiP7op5j05MzaQ4wWdwg9XdDsOrpSljxbxGhmbFySv5EfXI9Kp8g+nOyk4d1v
LY6A1qKd/tUjpqeb/Kc2uzPdfqepdkMDv62dYHdpOxPR78UasfRrt33JYFtBlOUE
Ui2NznVYyKqwzLHpScQyCDZ5h/6cM8vOT/b3OvhkkTHmLB8tHXfMnN7J8ubVjOVr
IpJcVs/bpyHBa5NsEKNPAT2UxyabQhzu+39+Ae9e5RUiPkM1YduLPqSly0LZ+HHh
nox+s8ttKIAIxHPS/8yA6Z8St5mU3slxmHnPrgYblHyBvef1DldyCPmyo4FarFV8
jvfxFOgMf6ZWQ3rT9Dr+OV3Y5uyDsVdrycrGlW2/3/eKnWRRySr2wCRb8bLQqIq+
HE7UhxAbzFjNqW3xO/IS9RGHjbPfjy3g7U7FBQVMN4945FrUDJInjOJcaMk3YLiF
BR3MmVZf1VNpuIpV8Khna0rrD0PBCTw1Ng0/oI6VVvNbfH/+VaLgXB7wNaLsifZo
st5E/Lc4LF/IQc1NG5p6CfEgvLudHwerChzz3g89CcC0nvjyQhWhefAKGwF59iLt
q3mCWay50lfK38fVTuh3SQkEJVC1ksGI7tN7qat2sT2EM5UI/aU=
=eWne
-----END PGP SIGNATURE-----

--ZY5CS28jBCfb727c--
