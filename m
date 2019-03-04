Received: from eggs.gnu.org ([209.51.188.92]:58490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0gNq-0005B8-BZ
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 00:43:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0gNm-0005fN-LA
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 00:43:24 -0500
Date: Mon, 4 Mar 2019 16:39:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190304053938.GK7792@umbus.fritz.box>
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
	<20190303172343.13406-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rnP2AJ7yb1j09OW/"
Content-Disposition: inline
In-Reply-To: <20190303172343.13406-3-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 2/8] target/ppc: introduce single
 vsrl_offset() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org


--rnP2AJ7yb1j09OW/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 03, 2019 at 05:23:37PM +0000, Mark Cave-Ayland wrote:
> Instead of having multiple copies of the offset calculation logic, move i=
t to a
> single vsrl_offset() function.
>=20
> This commit also renames the existing get_vsr()/set_vsr() functions to
> get_vsrl()/set_vsrl() which better describes their purpose.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-4.0, thanks.

> ---
>  target/ppc/cpu.h                    |  7 ++++++-
>  target/ppc/translate/vsx-impl.inc.c | 12 ++++++------
>  2 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 4bb4e42670..4a7df13c2d 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2573,9 +2573,14 @@ static inline uint64_t *cpu_fpr_ptr(CPUPPCState *e=
nv, int i)
>      return (uint64_t *)((uintptr_t)env + fpr_offset(i));
>  }
> =20
> +static inline int vsrl_offset(int i)
> +{
> +    return offsetof(CPUPPCState, vsr[i].u64[1]);
> +}
> +
>  static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
>  {
> -    return &env->vsr[i].u64[1];
> +    return (uint64_t *)((uintptr_t)env + vsrl_offset(i));
>  }
> =20
>  static inline ppc_avr_t *cpu_avr_ptr(CPUPPCState *env, int i)
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index e73197e717..381ae0f2e9 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -1,13 +1,13 @@
>  /***                           VSX extension                            =
   ***/
> =20
> -static inline void get_vsr(TCGv_i64 dst, int n)
> +static inline void get_vsrl(TCGv_i64 dst, int n)
>  {
> -    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState, vsr[n].u64[1]));
> +    tcg_gen_ld_i64(dst, cpu_env, vsrl_offset(n));
>  }
> =20
> -static inline void set_vsr(int n, TCGv_i64 src)
> +static inline void set_vsrl(int n, TCGv_i64 src)
>  {
> -    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, vsr[n].u64[1]));
> +    tcg_gen_st_i64(src, cpu_env, vsrl_offset(n));
>  }
> =20
>  static inline int vsr_full_offset(int n)
> @@ -27,7 +27,7 @@ static inline void get_cpu_vsrh(TCGv_i64 dst, int n)
>  static inline void get_cpu_vsrl(TCGv_i64 dst, int n)
>  {
>      if (n < 32) {
> -        get_vsr(dst, n);
> +        get_vsrl(dst, n);
>      } else {
>          get_avr64(dst, n - 32, false);
>      }
> @@ -45,7 +45,7 @@ static inline void set_cpu_vsrh(int n, TCGv_i64 src)
>  static inline void set_cpu_vsrl(int n, TCGv_i64 src)
>  {
>      if (n < 32) {
> -        set_vsr(n, src);
> +        set_vsrl(n, src);
>      } else {
>          set_avr64(n - 32, src, false);
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rnP2AJ7yb1j09OW/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx8uhoACgkQbDjKyiDZ
s5J5HBAAzpXZtkt2tczUUqM5EbYoibJxxS0JyqWKhtpwpZGzzR/kqA5Fi42httIF
DXyx6QneQePQJ9wfqgmPXyEzSa6IHS04UjDh1Clxc5Lh7LHJ+zbZoo77wHgq8AYB
75Hm8/SNyluabZOjpM17+iGfs6+fArQDLHyxcyz2V5EX2oM7OwTdqrAHrY7MFzwS
zRnCi5KPWT+20Ga3Zbu4c5pHD/ZWBO84y500w4CnTUI8o0xCRqcvZyhHDO38ytne
4kuWiU5gTZKJWRQOqsOyt3wC3l/Csv6SYupypxnZuKp6tIYmvk0LHtyIFHHX9cWZ
SKT2p4pakXwLGK28dhjGIGcPh931fHsc69GT0PQX0f9E7mKS2G64jfbhZazfKhLY
lPnc8tgdN6rTjrhN7Kx9C/BNTNN6Xfs1WbloonH7QJh/7qzF6yQy72j6Rem756ap
vcJQBfrcqzlb7uhoF3c+TKfjJxs3qSEkWSKNRmC9Xmz7UQln7qaC0tBY0uYTS10I
HG9uTuFCqTZiOYq3MinCoFP2OvZ2cgGSSawXwy4Y/AYY1dpP+vwcYqiy+X+lsKHR
mm4w+WK4i18sHJilcWE0pSh5l412GtsdKa6Uc2/X75ge+vsbtvh2DrEfO8Y15r62
sQngGWuk9YKE1hCLaVsdiCZz+Q8BdP+7d3lOU9s0bIahUE8pwk8=
=d/zD
-----END PGP SIGNATURE-----

--rnP2AJ7yb1j09OW/--
