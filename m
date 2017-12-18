Received: from eggs.gnu.org ([2001:4830:134:3::10]:41796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQm49-0006oz-PR
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 22:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQm48-0002UF-Ka
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 22:26:09 -0500
Date: Mon, 18 Dec 2017 13:39:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171218023905.GM7753@umbus.fritz.box>
References: <20171217054953.28500-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8c07nsHwQobhlezh"
Content-Disposition: inline
In-Reply-To: <20171217054953.28500-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target-ppc: optimize cmp translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dgibson@redhat.com, qemu-ppc@nongnu.org


--8c07nsHwQobhlezh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2017 at 06:49:53AM +0100, Paolo Bonzini wrote:
> We know that only one bit (in addition to SO) is going to be set in
> the condition register, so do two movconds instead of three setconds,
> three shifts and two ORs.
>=20
> For ppc64-linux-user, the code size reduction is around 5% and the
> performance improvement slightly less than 10%.  For softmmu, the
> improvement is around 5%.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Applied to ppc-for-2.12, thanks.


> ---
>  target/ppc/translate.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 998fbed848..0e9e6823a3 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -605,27 +605,22 @@ static opc_handler_t invalid_handler =3D {
>  static inline void gen_op_cmp(TCGv arg0, TCGv arg1, int s, int crf)
>  {
>      TCGv t0 =3D tcg_temp_new();
> -    TCGv_i32 t1 =3D tcg_temp_new_i32();
> -
> -    tcg_gen_trunc_tl_i32(cpu_crf[crf], cpu_so);
> -
> -    tcg_gen_setcond_tl((s ? TCG_COND_LT: TCG_COND_LTU), t0, arg0, arg1);
> -    tcg_gen_trunc_tl_i32(t1, t0);
> -    tcg_gen_shli_i32(t1, t1, CRF_LT_BIT);
> -    tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t1);
> +    TCGv t1 =3D tcg_temp_new();
> +    TCGv_i32 t =3D tcg_temp_new_i32();
> =20
> -    tcg_gen_setcond_tl((s ? TCG_COND_GT: TCG_COND_GTU), t0, arg0, arg1);
> -    tcg_gen_trunc_tl_i32(t1, t0);
> -    tcg_gen_shli_i32(t1, t1, CRF_GT_BIT);
> -    tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t1);
> +    tcg_gen_movi_tl(t0, CRF_EQ);
> +    tcg_gen_movi_tl(t1, CRF_LT);
> +    tcg_gen_movcond_tl((s ? TCG_COND_LT : TCG_COND_LTU), t0, arg0, arg1,=
 t1, t0);
> +    tcg_gen_movi_tl(t1, CRF_GT);
> +    tcg_gen_movcond_tl((s ? TCG_COND_GT : TCG_COND_GTU), t0, arg0, arg1,=
 t1, t0);
> =20
> -    tcg_gen_setcond_tl(TCG_COND_EQ, t0, arg0, arg1);
> -    tcg_gen_trunc_tl_i32(t1, t0);
> -    tcg_gen_shli_i32(t1, t1, CRF_EQ_BIT);
> -    tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t1);
> +    tcg_gen_trunc_tl_i32(t, t0);
> +    tcg_gen_trunc_tl_i32(cpu_crf[crf], cpu_so);
> +    tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t);
> =20
>      tcg_temp_free(t0);
> -    tcg_temp_free_i32(t1);
> +    tcg_temp_free(t1);
> +    tcg_temp_free_i32(t);
>  }
> =20
>  static inline void gen_op_cmpi(TCGv arg0, target_ulong arg1, int s, int =
crf)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8c07nsHwQobhlezh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo3KkYACgkQbDjKyiDZ
s5KftBAAso0cIP1CqKehAo0t0k97zBMUbXPu/cBRbZtScqs53WahgQxYMApNTEyY
1KmPdfYBugZv8Rz8TlrGVwKR+aMEfEqleoVPlsRhAk37RWnHnhnjpbZSictkodlD
Rr3mIKpMtJPpi7bgHhiVh4TuTyXyZh8GpaW+Q82ZTfoxu/B5DAI+P9D5QuuV+kE1
AiV/kdyO5uXDNY5DdrVmoK2Ucc10gpxT2hA/HqEdEtyGIfs6P6vgWjK2OpuKIovy
kIIarJPZtCctdq1iQdTfPikQ9EeUFf1oO+naPjVADw3OjxECblkoof5W+NjZm5Ne
1wbH5/ETcPz7g5sryYFdKYaktv3Jv6Xt6y0pZtz9Axqkbk/BgYZdgJ5IaFs+jnJ9
EEWYB1bWEUPC4T80DundgOAHhkGo1NWhVCT/qYTVsPza3BAeg9r5bvCHApI1rF0K
Sr+gUtvbne0eSqtNQ/D2e6Gee+WPoAA3zbg77uGbI0Ro8i3qSUa3/jmxaB1P5heP
51Jg46cC/Y5W6xCIDpmpsW/i3298CpudIso05dxjroBN6gORo4g9KG7vy6khZJVk
fUKrfwNIDk+e3GyX2TanUiyoDKeu+wh5ZQHVQCQHkaMtJKKMldSA+NX0ZXmkPuFG
y+7/FEF7P3Swf3qBWOHrZUdjxgUp88oKWTPgAIgImV0nNtNTCyA=
=W97D
-----END PGP SIGNATURE-----

--8c07nsHwQobhlezh--
