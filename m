Received: from eggs.gnu.org ([2001:4830:134:3::10]:51256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYi4g-0004m0-Ds
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 21:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYi4f-0007lz-4t
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 21:19:46 -0400
Date: Fri, 29 Jun 2018 11:11:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180629011132.GG23134@umbus.fritz.box>
References: <20180628203524.16221-1-mail@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FwyhczKCDPOVeYh6"
Content-Disposition: inline
In-Reply-To: <20180628203524.16221-1-mail@sebastianbauer.info>
Subject: Re: [Qemu-devel] [RFC] ppc/tcg: send cpu to sleep for simple
 endless guest loops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: qemu-devel@nongnu.org, agraf@suse.de, qemu-ppc@nongnu.org


--FwyhczKCDPOVeYh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2018 at 10:35:24PM +0200, Sebastian Bauer wrote:
> When a branch instructions points to itself, only external events will
> change the internally observable cpu state. This change will adjust the
> behaviour of QEMU such that it sends the emulated cpu into a sleep state
> if this case is detected.
>=20
> The effect for guests whose idle task contains this endless loop (e.g.,
> AmigaOS) is that they no longer hog the cpu of the host if they are idle.
>=20
> Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
>=20
> ---
>=20
> This is a RFC because I'm not really familiar with the internals
> of QEMU. There are probably other (better) ways to achive a similar
> behaviour. For that reason I haven't tested the change thoroughly
> yet, except that it produces the desired effect.
>=20
> The patch will change the behaviour wrt. the instruction count which
> is no longer the same. But I don't think that this will matter.
>=20
> I will be grateful for any expressed concerns and suggestion of that
> matter.
>=20
> Patch is based on ppc-for-3.0.

Doesn't look insane to me, though I'm really not a TCG expert.

I will note that its utility is probably pretty limited.  I think most
OSes have a more complex idle loop than an unconditional branch to
self.

> ---
>  target/ppc/helper.h    |  2 ++
>  target/ppc/translate.c | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index d751f0e219..5f9b157417 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -799,3 +799,5 @@ DEF_HELPER_4(dscliq, void, env, fprp, fprp, i32)
> =20
>  DEF_HELPER_1(tbegin, void, env)
>  DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
> +
> +DEF_HELPER_1(sleep, void, env)
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 3a215a1dc6..7db53003ea 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3469,6 +3469,18 @@ static inline void gen_setlr(DisasContext *ctx, ta=
rget_ulong nip)
>      tcg_gen_movi_tl(cpu_lr, nip);
>  }
> =20
> +/* Helper for bringing the cpu to the sleep state so it will
> + * react only on "external" events */
> +void helper_sleep(CPUPPCState *env)
> +{
> +    CPUState *cs =3D CPU(ppc_env_get_cpu(env));
> +
> +    cs->exception_index =3D EXCP_HALTED;
> +    cs->exit_request =3D 1;
> +    cs->halted =3D 1;
> +    cpu_loop_exit(cs);
> +}
> +
>  /* b ba bl bla */
>  static void gen_b(DisasContext *ctx)
>  {
> @@ -3483,6 +3495,13 @@ static void gen_b(DisasContext *ctx)
>      } else {
>          target =3D li;
>      }
> +
> +    if (target =3D=3D ctx->base.pc_next - 4) {
> +        /* Endless-loop, CPU can now react on "external" events only, so=
 we
> +         * simply go to sleep in order to save host processing resources=
 */
> +        gen_helper_sleep(cpu_env);
> +    }
> +
>      if (LK(ctx->opcode)) {
>          gen_setlr(ctx, ctx->base.pc_next);
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FwyhczKCDPOVeYh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls1h0QACgkQbDjKyiDZ
s5LB6A/+Nv6bZrp+Q41UcarlmEAH/KRR7WBIKCfPYsGT31EJHCsv6CgjhRn1h6Xl
SvBKcqCeBOG/1pPx9rI/Sd4Pu+GzclNRwUfQUg2mJaxgSoZcxGjBHtijTIlZVTO4
mJk6zpdHFMIBxJ2UgxXnXVydPaeJFC1yDTaVbaPp0vJsquIQ1zVC7QiheNSh6x5H
i1BZ9KIS2tYtCXL9axsZw+ULs6TZBn+E+ZwcluC+EATpe3AM+kK3SU5U5oOHkSrE
18CEHDaFe9nk0CgNH7l0h4j5Txo+3Doh2tdCkBJme1B8HYmc/h5COZSQzyg55bqQ
pHlNA708bgM/H/72f3cBs2KiHX/BEj7/qgzylI7/K/XG4Z9WFhVx9Toy81XYQYjD
wFnV8QE5xnLNO95hIokBkNO/fHBud8tUHXTgvlmr7Qj/wTwUOlN5INT1PzVro5NB
LlQSBjWmy2nOi3ExVpngDWCEcn7qbQkhJ2bH2d5d+2DrgGFPCDs2TL3uzBCLET+b
C3ydku5IddH9V2gofAOesojboFQf9TCnzEHgaop9zA5ZbvsElFwDOJvbhmQnzwyN
49VLgEzl05Ul2rRRz0CFUrWiF4y0+JZyEqeizr3Iceoanx6NqLsAShIcBs17iMqI
AJkeNbz8weT+O+XdyksWRhWubV0/j8LPsC0SyZ3pl5TJ+zvmRRI=
=27rf
-----END PGP SIGNATURE-----

--FwyhczKCDPOVeYh6--
