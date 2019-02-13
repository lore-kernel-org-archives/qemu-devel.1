Received: from eggs.gnu.org ([209.51.188.92]:45701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtn6V-0008MQ-Oc
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtmwX-0005NV-EZ
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:18:49 -0500
Date: Wed, 13 Feb 2019 16:06:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213050613.GM1884@umbus.fritz.box>
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-12-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eUGqGfkt69yEwRle"
Content-Disposition: inline
In-Reply-To: <20190128094625.4428-12-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 11/19] target/ppc: Move "wakeup reset" code
 to a separate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--eUGqGfkt69yEwRle
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 10:46:17AM +0100, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> This moves the code to handle waking up from the 0x100 vector
> from powerpc_excp() to a separate function, as the former is
> already way too big as it is.
>=20
> No functional change.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/excp_helper.c | 75 ++++++++++++++++++++++------------------
>  1 file changed, 41 insertions(+), 34 deletions(-)
>=20
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 97503193ef43..489a54f51b90 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -65,6 +65,46 @@ static inline void dump_syscall(CPUPPCState *env)
>                    ppc_dump_gpr(env, 6), env->nip);
>  }
> =20
> +static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp,
> +                                target_ulong *msr)
> +{
> +    /* We no longer are in a PM state */
> +    env->in_pm_state =3D false;
> +
> +    /* Pretend to be returning from doze always as we don't lose state */
> +    *msr |=3D (0x1ull << (63 - 47));
> +
> +    /* Machine checks are sent normally */
> +    if (excp =3D=3D POWERPC_EXCP_MCHECK) {
> +        return excp;
> +    }
> +    switch (excp) {
> +    case POWERPC_EXCP_RESET:
> +        *msr |=3D 0x4ull << (63 - 45);
> +        break;
> +    case POWERPC_EXCP_EXTERNAL:
> +        *msr |=3D 0x8ull << (63 - 45);
> +        break;
> +    case POWERPC_EXCP_DECR:
> +        *msr |=3D 0x6ull << (63 - 45);
> +        break;
> +    case POWERPC_EXCP_SDOOR:
> +        *msr |=3D 0x5ull << (63 - 45);
> +        break;
> +    case POWERPC_EXCP_SDOOR_HV:
> +        *msr |=3D 0x3ull << (63 - 45);
> +        break;
> +    case POWERPC_EXCP_HV_MAINT:
> +        *msr |=3D 0xaull << (63 - 45);
> +        break;
> +    default:
> +        cpu_abort(cs, "Unsupported exception %d in Power Save mode\n",
> +                  excp);
> +    }
> +    return POWERPC_EXCP_RESET;
> +}
> +
> +
>  /* Note that this function should be greatly optimized
>   * when called with a constant excp, from ppc_hw_interrupt
>   */
> @@ -102,40 +142,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
>       * P7/P8/P9
>       */
>      if (env->in_pm_state) {
> -        env->in_pm_state =3D false;
> -
> -        /* Pretend to be returning from doze always as we don't lose sta=
te */
> -        msr |=3D (0x1ull << (63 - 47));
> -
> -        /* Non-machine check are routed to 0x100 with a wakeup cause
> -         * encoded in SRR1
> -         */
> -        if (excp !=3D POWERPC_EXCP_MCHECK) {
> -            switch (excp) {
> -            case POWERPC_EXCP_RESET:
> -                msr |=3D 0x4ull << (63 - 45);
> -                break;
> -            case POWERPC_EXCP_EXTERNAL:
> -                msr |=3D 0x8ull << (63 - 45);
> -                break;
> -            case POWERPC_EXCP_DECR:
> -                msr |=3D 0x6ull << (63 - 45);
> -                break;
> -            case POWERPC_EXCP_SDOOR:
> -                msr |=3D 0x5ull << (63 - 45);
> -                break;
> -            case POWERPC_EXCP_SDOOR_HV:
> -                msr |=3D 0x3ull << (63 - 45);
> -                break;
> -            case POWERPC_EXCP_HV_MAINT:
> -                msr |=3D 0xaull << (63 - 45);
> -                break;
> -            default:
> -                cpu_abort(cs, "Unsupported exception %d in Power Save mo=
de\n",
> -                          excp);
> -            }
> -            excp =3D POWERPC_EXCP_RESET;
> -        }
> +        excp =3D powerpc_reset_wakeup(cs, env, excp, &msr);
>      }
> =20
>      /* Exception targetting modifiers

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eUGqGfkt69yEwRle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjpcQACgkQbDjKyiDZ
s5IQ3Q//UboMgA/96O7TGouUbY31FmOMYN/fbLM9URaLLkcrxaeQALwkweMkO+9k
qaPwHQWTgNtPCWxSkvv/zAIyzro8GpghF4Z0crcHCY2atsn7VkqeeHmiQxp7v3p2
p1g7Y1yAFdKsczBnN7ARkx82vHOlFY7jSQyiZkDrA4BwkfXhLR1JRYcvlghMhZGE
kc9X11rvCttYCJ9HMzLH2+cidZR8zz5f68fJD03p16oARfghgpXPdW6Nr8CnX3Za
gSpqV7bYnrAyUMZKirdfhcCqvcYjdbKowVlafv2rlq7JKC6aDOaTBirj/fXnIClf
IWNCV8YnZNJOJzoOduGH05Nj2aUGTiCcC7oT+BWktazUPVz1xLREYra7L5jIOonL
ilL0C+tXiMHOVdgwK/KuJrFS2kGXuUjdUhqlmTxON8YIRnF51gUdz7UNGxiUqcK6
g05oDA2YHdO3oCQrHJj1EmeJysaPJfUoqP9vA8G9h6dOPPJASlq48mGDi94gysMQ
d20Ln3N1rMjdxn46dqQTdlXMpkTspxAArYUs9ETty3s6FOh593CNmwIkA5k5GhWN
TcJ74uZKailSniwZwDyplpohf5A+bAHnjIMTFaeUEnWGAyNi49z6K/GRhD/kpTsa
FCF0b48tOxJQ+rQ5HdNFb/cpcRyoIjxCzgMh1tqypoApm4VbwzY=
=yyKX
-----END PGP SIGNATURE-----

--eUGqGfkt69yEwRle--
