Received: from eggs.gnu.org ([209.51.188.92]:39710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gthds-0005Qf-FB
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 18:39:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gthdr-0002zl-D5
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 18:39:08 -0500
Date: Tue, 12 Feb 2019 17:02:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190212060227.GO1884@umbus.fritz.box>
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-9-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YC8Ek3FeOE8ywfXk"
Content-Disposition: inline
In-Reply-To: <20190128094625.4428-9-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 08/19] target/ppc: Fix nip on power
 management instructions
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


--YC8Ek3FeOE8ywfXk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 10:46:14AM +0100, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> Those instructions currently raise an exception from within
> the helper. This tends to result in a bogus nip value in
> the env context (typically the beginning of the TB). Such
> a helper needs a gen_update_nip() first.
>=20
> This fixes it with a different approach which is to throw
> the exception from translate.c instead of the helper using
> gen_exception_nip() which does the right thing.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  target/ppc/excp_helper.c |  1 -
>  target/ppc/translate.c   | 12 ++++++++----
>  2 files changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 751d759fcc1d..8407e0ade938 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -958,7 +958,6 @@ void helper_pminsn(CPUPPCState *env, powerpc_pm_insn_=
t insn)
>       * but this doesn't seem to be a problem.
>       */
>      env->msr |=3D (1ull << MSR_EE);
> -    raise_exception(env, EXCP_HLT);
>  }
>  #endif /* defined(TARGET_PPC64) */
> =20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 7d40a1fbe6bd..55281a8975e0 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3571,7 +3571,8 @@ static void gen_doze(DisasContext *ctx)
>      t =3D tcg_const_i32(PPC_PM_DOZE);
>      gen_helper_pminsn(cpu_env, t);
>      tcg_temp_free_i32(t);
> -    gen_stop_exception(ctx);
> +    /* Stop translation, as the CPU is supposed to sleep from now */
> +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);

IIUC this also changes from EXCP_STOP to EXCP_HLT, is that intentional?

>  #endif /* defined(CONFIG_USER_ONLY) */
>  }
> =20
> @@ -3586,7 +3587,8 @@ static void gen_nap(DisasContext *ctx)
>      t =3D tcg_const_i32(PPC_PM_NAP);
>      gen_helper_pminsn(cpu_env, t);
>      tcg_temp_free_i32(t);
> -    gen_stop_exception(ctx);
> +    /* Stop translation, as the CPU is supposed to sleep from now */
> +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>  #endif /* defined(CONFIG_USER_ONLY) */
>  }
> =20
> @@ -3606,7 +3608,8 @@ static void gen_sleep(DisasContext *ctx)
>      t =3D tcg_const_i32(PPC_PM_SLEEP);
>      gen_helper_pminsn(cpu_env, t);
>      tcg_temp_free_i32(t);
> -    gen_stop_exception(ctx);
> +    /* Stop translation, as the CPU is supposed to sleep from now */
> +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>  #endif /* defined(CONFIG_USER_ONLY) */
>  }
> =20
> @@ -3621,7 +3624,8 @@ static void gen_rvwinkle(DisasContext *ctx)
>      t =3D tcg_const_i32(PPC_PM_RVWINKLE);
>      gen_helper_pminsn(cpu_env, t);
>      tcg_temp_free_i32(t);
> -    gen_stop_exception(ctx);
> +    /* Stop translation, as the CPU is supposed to sleep from now */
> +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>  #endif /* defined(CONFIG_USER_ONLY) */
>  }
>  #endif /* #if defined(TARGET_PPC64) */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YC8Ek3FeOE8ywfXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxiYXMACgkQbDjKyiDZ
s5KxtBAAkgKzuKjzHiWEO2Pi0y4g9fznmkZonye5ock6ZPCTCW2ulWJAQs/GHDRJ
d1DSm8EgL3uM6EtWStf3RRmTVcfAjCpFVeQDwcN2TJzJoRbQ+8Z28IPW+6jxz5+b
CDKUXc11QOO3EMUFvBIh0i/5xyKiWkxDyDaFsS7TNABxuuMEXfZuuQZvCaq+gENQ
rHDqGLkcMNCLalXothRLFfvG3i4lYF12I3ykjXQKp4a843U+8TEDxwfdL1ucHLqA
TqLnC/WIHpyRrysT3pjaVBbrGq4Su4n6eeAnU99b12Gy5FbKWB3m9txAWd13fdic
RSI5SqOJvmDQpIJJla/MiKjj4n+IeH5q0OlvGrQTkG0PO9/zFA2GFGdwa/bXQA3h
kaVsOlqDWLsXhT8BrCM5D6bh4Z8ExUszhd0gtaQni/zh/4peq0MmEIHmbo+kG7KN
PEGlVnsnbRyynwa6gzTFaQ7RnNB6F2DQxnuVlWbHHzB884Tkir2bkYl2qZZG5v2x
o33GNeyCgJ661rhpEkATjgkZB6gFApawBDs3QHfTDM5y/MmzT2zkb5kyI+UpH3aj
GeZQjNdOjet+MIsGZS8mjxTab1OI7UqJw63WxDnd1P1X54oeCzLhOtW245ePjlid
oO8oj/HYEj5RTJ9DX5Z0Eq5KdKKKU98JZXWe3UFzQCz1ZEaULi0=
=fp2b
-----END PGP SIGNATURE-----

--YC8Ek3FeOE8ywfXk--
