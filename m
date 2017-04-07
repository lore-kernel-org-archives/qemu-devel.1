Received: from eggs.gnu.org ([2001:4830:134:3::10]:58418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cwMaI-0008HB-NG
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 01:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cwMaH-0002Tk-GU
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 01:37:22 -0400
Date: Fri, 7 Apr 2017 15:23:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170407052348.GA27571@umbus>
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<20170406102249.20383-2-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <20170406102249.20383-2-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v1 1/3] target/ppc: Emulate LL/SC using
 cmpxchg helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, alex.bennee@linaro.org, programmingkidx@gmail.com, bharata@linux.vnet.ibm.com


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2017 at 03:52:47PM +0530, Nikunj A Dadhania wrote:
> Emulating LL/SC with cmpxchg is not correct, since it can suffer from
> the ABA problem. However, portable parallel code is written assuming
> only cmpxchg which means that in practice this is a viable alternative.
>=20
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target/ppc/translate.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b6abc60..a9c733d 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -73,6 +73,7 @@ static TCGv cpu_cfar;
>  #endif
>  static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca, cpu_ov32, cpu_ca32;
>  static TCGv cpu_reserve;
> +static TCGv cpu_reserve_val;
>  static TCGv cpu_fpscr;
>  static TCGv_i32 cpu_access_type;
> =20
> @@ -181,6 +182,9 @@ void ppc_translate_init(void)
>      cpu_reserve =3D tcg_global_mem_new(cpu_env,
>                                       offsetof(CPUPPCState, reserve_addr),
>                                       "reserve_addr");
> +    cpu_reserve_val =3D tcg_global_mem_new(cpu_env,
> +                                     offsetof(CPUPPCState, reserve_val),
> +                                     "reserve_val");

I notice that lqarx is not updated.  Does that matter?

>      cpu_fpscr =3D tcg_global_mem_new(cpu_env,
>                                     offsetof(CPUPPCState, fpscr), "fpscr"=
);
> @@ -3023,7 +3027,7 @@ static void gen_##name(DisasContext *ctx)          =
                  \
>      }                                                                \
>      tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop);                \
>      tcg_gen_mov_tl(cpu_reserve, t0);                                 \
> -    tcg_gen_st_tl(gpr, cpu_env, offsetof(CPUPPCState, reserve_val)); \
> +    tcg_gen_mov_tl(cpu_reserve_val, gpr);                            \
>      tcg_temp_free(t0);                                               \
>  }
> =20
> @@ -3156,14 +3160,28 @@ static void gen_conditional_store(DisasContext *c=
tx, TCGv EA,
>                                    int reg, int memop)
>  {
>      TCGLabel *l1;
> +    TCGv_i32 tmp =3D tcg_temp_local_new_i32();
> +    TCGv t0;
> =20
> +    tcg_gen_movi_i32(tmp, 0);
>      tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
>      l1 =3D gen_new_label();
>      tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, l1);
> -    tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], CRF_EQ);
> -    tcg_gen_qemu_st_tl(cpu_gpr[reg], EA, ctx->mem_idx, memop);
> +
> +    t0 =3D tcg_temp_new();
> +    tcg_gen_atomic_cmpxchg_tl(t0, EA, cpu_reserve_val, cpu_gpr[reg],
> +                              ctx->mem_idx, DEF_MEMOP(memop));
> +    tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_reserve_val);
> +    tcg_gen_trunc_tl_i32(tmp, t0);
> +
>      gen_set_label(l1);
> +    tcg_gen_shli_i32(tmp, tmp, CRF_EQ_BIT);
> +    tcg_gen_or_i32(cpu_crf[0], cpu_crf[0], tmp);
>      tcg_gen_movi_tl(cpu_reserve, -1);
> +    tcg_gen_movi_tl(cpu_reserve_val, 0);
> +
> +    tcg_temp_free(t0);
> +    tcg_temp_free_i32(tmp);
>  }
>  #endif
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY5yJhAAoJEGw4ysog2bOSzSwP/3JNaSyLKNJDGXh56++cbrb/
EFp5gz+3S7YHFtqgC0RAq11NG6J/kv9PvaUVV9o7YpwWg0Hf/iLTKUaLcxxKIAE8
xefZK8BTFGrVO0BK3EqgxrPSHvc+3RPQe8615g7KnhrhTPZrtVBZ7UVRbOmxA/Ir
dXru6vWNecU41p3tOdvx1At5Dl7kIrOM/G7JJRfX59cxCCWDj/eXjUEriSIAoGtv
7BtSAQjqb1nKli3yH+4k+At/TeC/mCSEs48CdKYB6eDw4U3A/weid0YfWh158pee
F1uof0DY60bnLs1zp6CrSm6Ml635b/Q+ZK+Sx+HH+tTdGGx+MOQ6UC5r8JUiJKy+
s26ka0AY3Fw9pLhZ9C6QFBQf3SBcb7oaAN0L6p+KWMjgH99L52vp+9eHOLavCwCB
HrUfyjsmHkLuaol5NfNmmUA4Mafylinllf1DlENTjrQykl3QmtCjWwKJ1w7iJEgk
cDLsV/iTf5acjaugf66mMPXswikYKuD184EDLt3DokaFp3qigwLju7d9xBQu+SN0
V1oqxO0qWNuGux2D9E+HjwLKOaEO5xlM70GhwZYQ2O8VBn0YMjn6HNcdNgU21xmP
AXjSOZmWdX6rCXQevYs+Dr8TDQ5zlBOcKfvtMCQcM/3CfwdL+ai2U/eMHcbFnGyi
6/Jz34ubOPh9BOKqi2u/
=03Wi
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
