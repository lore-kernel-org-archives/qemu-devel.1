Received: from eggs.gnu.org ([209.51.188.92]:38716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h234z-0002yx-7d
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:09:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h234x-0002sN-Q3
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:09:37 -0500
Date: Fri, 8 Mar 2019 10:23:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307232304.GT7722@umbus.fritz.box>
References: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
	<20190307180520.13868-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0M7E0x35R+W+EAky"
Content-Disposition: inline
In-Reply-To: <20190307180520.13868-3-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH v2 2/7] target/ppc: introduce single
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


--0M7E0x35R+W+EAky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 06:05:15PM +0000, Mark Cave-Ayland wrote:
> Instead of having multiple copies of the offset calculation logic, move i=
t to a
> single vsrl_offset() function.
>=20
> This commit also renames the existing get_vsr()/set_vsr() functions to
> get_vsrl()/set_vsrl() which better describes their purpose.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Applied, thanks.

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

--0M7E0x35R+W+EAky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBp9gACgkQbDjKyiDZ
s5JqDw//QkfCpaSKln4DfEsgjYbUY2gTBbxK/E6YVgU2e4aiz5BqOVLyp30uNdnY
2bgG8cXpOpPccohqMwSTiiC3b028vb2bjIEEsLJHJNFIOoQOz1SbMjuORa96C6ht
w4RjbToc7njr8bh4i/+2UXb1vROqu/3B5NRty+1f7DWQZ8/AhDB+STnlndusCSHj
cHTUC2o4MVNAeFyQj+CzStFbOqYJb4CQKw4+PUjAHsSOYYrxRGpeokTxAXCIdh7d
LrBS+WiKQH4XHtGZ9tInMQkzCfcSk/z5nivaxh2zDDcHBTsweubS8PZp7VfAC/Ub
GLc3tBnViO/pIv/H6r/Eh45qAtY6JU8NZJLFsKEpm5MpMvncMSNB6p1VQhzaOELb
lh9hfNpJDsbKqtJYpdjlVAmmYDCteyYembh18GWVrDGNShbu4+JdSYrq+bnBvx3w
yXMvMprGZgDovOoZFeQC8zxgt3MmZDFC9VKCcwucWZWGoDA8d7rdmFko8Z1+0tuC
5gB3nnftxcBKy3K+N4RfwOWDkwaiqvSTksX1pktCVm7rVwX++w2VzusxpjmF6JNA
PShFhHCS8SdZ4/vtuI4Nn1TxYhpQ5YLz3EQkeZWZDr9yZt4QbW+zLY7SUAotVBRk
YQrcNrqiNhf0rVn1JX8N1PBAcv8pKLh8oJuVDg2bF9LZYgK2oLk=
=6Ida
-----END PGP SIGNATURE-----

--0M7E0x35R+W+EAky--
