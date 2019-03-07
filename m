Received: from eggs.gnu.org ([209.51.188.92]:38713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h234z-0002yw-5H
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:09:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h234x-0002rU-Ky
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:09:37 -0500
Date: Fri, 8 Mar 2019 10:30:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307233006.GV7722@umbus.fritz.box>
References: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
	<20190307180520.13868-5-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q/AGl/UrDvkbRExF"
Content-Disposition: inline
In-Reply-To: <20190307180520.13868-5-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH v2 4/7] target/ppc: introduce
 avr_full_offset() function
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


--Q/AGl/UrDvkbRExF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 06:05:17PM +0000, Mark Cave-Ayland wrote:
> All TCG vector operations require pointers to the base address of the vec=
tor
> rather than separate access to the top and bottom 64-bits. Convert the VM=
X TCG
> instructions to use a new avr_full_offset() function instead of avr64_off=
set()
> which can then itself be written as a simple wrapper onto vsr_full_offset=
().
>=20
> This same function can also reused in cpu_avr_ptr() to avoid having more =
than
> one copy of the offset calculation logic.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  target/ppc/cpu.h                    | 12 +++++++++++-
>  target/ppc/translate/vmx-impl.inc.c | 22 +++++++++++-----------
>  target/ppc/translate/vsx-impl.inc.c |  5 -----
>  3 files changed, 22 insertions(+), 17 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index d0580c6b6d..2a2792306f 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2598,14 +2598,24 @@ static inline int vsrl_offset(int i)
>      return offsetof(CPUPPCState, vsr[i].u64[1]);
>  }
> =20
> +static inline int vsr_full_offset(int i)
> +{
> +    return offsetof(CPUPPCState, vsr[i].u64[0]);
> +}
> +
>  static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
>  {
>      return (uint64_t *)((uintptr_t)env + vsrl_offset(i));
>  }
> =20
> +static inline int avr_full_offset(int i)
> +{
> +    return vsr_full_offset(i + 32);
> +}
> +
>  static inline ppc_avr_t *cpu_avr_ptr(CPUPPCState *env, int i)
>  {
> -    return &env->vsr[32 + i];
> +    return (ppc_avr_t *)((uintptr_t)env + avr_full_offset(i));
>  }
> =20
>  void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env);
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index f1b15ae2cb..4e5d0bc0e0 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -10,7 +10,7 @@
>  static inline TCGv_ptr gen_avr_ptr(int reg)
>  {
>      TCGv_ptr r =3D tcg_temp_new_ptr();
> -    tcg_gen_addi_ptr(r, cpu_env, offsetof(CPUPPCState, vsr[32 + reg].u64=
[0]));
> +    tcg_gen_addi_ptr(r, cpu_env, avr_full_offset(reg));
>      return r;
>  }
> =20
> @@ -205,7 +205,7 @@ static void gen_mtvscr(DisasContext *ctx)
>      }
> =20
>      val =3D tcg_temp_new_i32();
> -    bofs =3D avr64_offset(rB(ctx->opcode), true);
> +    bofs =3D avr_full_offset(rB(ctx->opcode));
>  #ifdef HOST_WORDS_BIGENDIAN
>      bofs +=3D 3 * 4;
>  #endif
> @@ -284,9 +284,9 @@ static void glue(gen_, name)(DisasContext *ctx)      =
                   \
>      }                                                                   \
>                                                                          \
>      tcg_op(vece,                                                        \
> -           avr64_offset(rD(ctx->opcode), true),                         \
> -           avr64_offset(rA(ctx->opcode), true),                         \
> -           avr64_offset(rB(ctx->opcode), true),                         \
> +           avr_full_offset(rD(ctx->opcode)),                            \
> +           avr_full_offset(rA(ctx->opcode)),                            \
> +           avr_full_offset(rB(ctx->opcode)),                            \
>             16, 16);                                                     \
>  }
> =20
> @@ -578,10 +578,10 @@ static void glue(gen_, NAME)(DisasContext *ctx)    =
                     \
>          gen_exception(ctx, POWERPC_EXCP_VPU);                           \
>          return;                                                         \
>      }                                                                   \
> -    tcg_gen_gvec_4(avr64_offset(rD(ctx->opcode), true),                 \
> +    tcg_gen_gvec_4(avr_full_offset(rD(ctx->opcode)),                    \
>                     offsetof(CPUPPCState, vscr_sat),                     \
> -                   avr64_offset(rA(ctx->opcode), true),                 \
> -                   avr64_offset(rB(ctx->opcode), true),                 \
> +                   avr_full_offset(rA(ctx->opcode)),                    \
> +                   avr_full_offset(rB(ctx->opcode)),                    \
>                     16, 16, &g);                                         \
>  }
> =20
> @@ -755,7 +755,7 @@ static void glue(gen_, name)(DisasContext *ctx)      =
                   \
>              return;                                                     \
>          }                                                               \
>          simm =3D SIMM5(ctx->opcode);                                    =
  \
> -        tcg_op(avr64_offset(rD(ctx->opcode), true), 16, 16, simm);      \
> +        tcg_op(avr_full_offset(rD(ctx->opcode)), 16, 16, simm);         \
>      }
> =20
>  GEN_VXFORM_DUPI(vspltisb, tcg_gen_gvec_dup8i, 6, 12);
> @@ -850,8 +850,8 @@ static void gen_vsplt(DisasContext *ctx, int vece)
>      }
> =20
>      uimm =3D UIMM5(ctx->opcode);
> -    bofs =3D avr64_offset(rB(ctx->opcode), true);
> -    dofs =3D avr64_offset(rD(ctx->opcode), true);
> +    bofs =3D avr_full_offset(rB(ctx->opcode));
> +    dofs =3D avr_full_offset(rD(ctx->opcode));
> =20
>      /* Experimental testing shows that hardware masks the immediate.  */
>      bofs +=3D (uimm << vece) & 15;
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index 381ae0f2e9..7d02a235e7 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -10,11 +10,6 @@ static inline void set_vsrl(int n, TCGv_i64 src)
>      tcg_gen_st_i64(src, cpu_env, vsrl_offset(n));
>  }
> =20
> -static inline int vsr_full_offset(int n)
> -{
> -    return offsetof(CPUPPCState, vsr[n].u64[0]);
> -}
> -
>  static inline void get_cpu_vsrh(TCGv_i64 dst, int n)
>  {
>      if (n < 32) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Q/AGl/UrDvkbRExF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBqX4ACgkQbDjKyiDZ
s5KQvBAA2N3ClPnZ8WTNAxx7WQknZl4rQeuLavIY233uDSagVs6sLCXdr7W+Ss4P
NE5IWaRbqGda0d+Ya85u1Mc65MPDZxZh5/CaE/ojN7bx0qZg+78AiV2kb2biOxGH
64OQdU/CMj5KUcboS25dORCX6/8OvlSosUcPz4IdLVIq0FpyIXN9tSrbqro1e1CO
wgk2FaY4xbJz9mhc1GBOQHRgFrxAyBjDB5ekuikQfnd59B1OyQMAtjA1WG+yu+C2
hO8x74XwRh0Fjy9pyYiNaDlOnr2LPtPVYS4JnfDOjzcpKd93y0mpBaiykMictcJu
Oeufheb2KwB6ufOUAQWuwtFXambiU6jbwRIjhb3r4YVNFfjh6203wsbCM5qpIyb4
GMxxZYRVxiRrqy6b9ve3jLvDI/vUFOb0cT28RMtBiW5/GuA//PyHd3Qt+0n7BSsG
qB4hf9ZdmKoaVS+fkK6z8h8Jqc+y002XDDPTFQXR5QdJBrIvxGZn6vVHrZBWPdqx
O21TbMyIOBeNnI7fv6r+3rP1p6J876KVvGGmw1df9wnRDu5qHqQkL0NEaXo/9DXx
r11x2GfO+E3NOHcmiGF6FftklDU98i0IJcSDcK/VZ6eVN8t/aVZ4ucOQVaQtqOfq
EWvQm6VmmnqC8B1voePvW8DX0+QjF5pnhkTrX/lAsP6rwIYhjDQ=
=zemC
-----END PGP SIGNATURE-----

--Q/AGl/UrDvkbRExF--
