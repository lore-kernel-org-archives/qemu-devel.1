Received: from eggs.gnu.org ([2001:4830:134:3::10]:41295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gNEF5-0002PG-CJ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:47:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gNEF3-0007We-4Z
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:47:19 -0500
Date: Thu, 15 Nov 2018 20:40:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181115094036.GF2547@umbus.fritz.box>
References: <20181115032259.23968-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SnV5plBeK2Ge1I9g"
Content-Disposition: inline
In-Reply-To: <20181115032259.23968-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH] target/ppc: tcg: Implement
 addex instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, tg@gmplib.org


--SnV5plBeK2Ge1I9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 02:22:59PM +1100, Suraj Jitindar Singh wrote:
> Implement the addex instruction introduced in ISA V3.00 in qemu tcg.
>=20
> The add extended using alternate carry bit (addex) instruction performs
> the same operation as the add extended (adde) instruction, but using the
> overflow (ov) field in the fixed point exception register (xer) as the
> carry in and out instead of the carry (ca) field.
>=20
> The instruction has a Z23-form, not an XO form, as follows:
>=20
>     ------------------------------------------------------------------
>     |   31   |   RT   |   RA   |   RB   |   CY   |     170     |  0  |
>     ------------------------------------------------------------------
>     0        6        11       16       21       23            31    32
>=20
> However since the only valid form of the instruction defined so far is
> CY =3D 0, we can treat this like an XO form instruction.
>=20
> There is no dot form (addex.) of the instruction and the summary overflow
> (so) bit in the xer is not modified by this instruction.
>=20
> For simplicity we reuse the gen_op_arith_add function and add a function
> argument to specify where the carry in input should come from and the
> carry out output be stored (note must be the same location).
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Applied, thanks.

> ---
>  disas/ppc.c            |  2 ++
>  target/ppc/translate.c | 60 +++++++++++++++++++++++++++-----------------=
------
>  2 files changed, 35 insertions(+), 27 deletions(-)
>=20
> diff --git a/disas/ppc.c b/disas/ppc.c
> index 5ab9c35a84..da1140ba2b 100644
> --- a/disas/ppc.c
> +++ b/disas/ppc.c
> @@ -3734,6 +3734,8 @@ const struct powerpc_opcode powerpc_opcodes[] =3D {
>  { "addmeo.", XO(31,234,1,1), XORB_MASK, PPCCOM,		{ RT, RA } },
>  { "ameo.",   XO(31,234,1,1), XORB_MASK, PWRCOM,		{ RT, RA } },
> =20
> +{ "addex",   XO(31,170,0,0), XO_MASK,   POWER9,         { RT, RA, RB } },
> +
>  { "mullw",   XO(31,235,0,0), XO_MASK,	PPCCOM,		{ RT, RA, RB } },
>  { "muls",    XO(31,235,0,0), XO_MASK,	PWRCOM,		{ RT, RA, RB } },
>  { "mullw.",  XO(31,235,0,1), XO_MASK,	PPCCOM,		{ RT, RA, RB } },
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 2b37910248..96894ab9a8 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -849,7 +849,7 @@ static inline void gen_op_arith_compute_ov(DisasConte=
xt *ctx, TCGv arg0,
> =20
>  static inline void gen_op_arith_compute_ca32(DisasContext *ctx,
>                                               TCGv res, TCGv arg0, TCGv a=
rg1,
> -                                             int sub)
> +                                             TCGv ca32, int sub)
>  {
>      TCGv t0;
> =20
> @@ -864,13 +864,14 @@ static inline void gen_op_arith_compute_ca32(DisasC=
ontext *ctx,
>          tcg_gen_xor_tl(t0, arg0, arg1);
>      }
>      tcg_gen_xor_tl(t0, t0, res);
> -    tcg_gen_extract_tl(cpu_ca32, t0, 32, 1);
> +    tcg_gen_extract_tl(ca32, t0, 32, 1);
>      tcg_temp_free(t0);
>  }
> =20
>  /* Common add function */
>  static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv ar=
g1,
> -                                    TCGv arg2, bool add_ca, bool compute=
_ca,
> +                                    TCGv arg2, TCGv ca, TCGv ca32,
> +                                    bool add_ca, bool compute_ca,
>                                      bool compute_ov, bool compute_rc0)
>  {
>      TCGv t0 =3D ret;
> @@ -888,29 +889,29 @@ static inline void gen_op_arith_add(DisasContext *c=
tx, TCGv ret, TCGv arg1,
>              tcg_gen_xor_tl(t1, arg1, arg2);        /* add without carry =
*/
>              tcg_gen_add_tl(t0, arg1, arg2);
>              if (add_ca) {
> -                tcg_gen_add_tl(t0, t0, cpu_ca);
> +                tcg_gen_add_tl(t0, t0, ca);
>              }
> -            tcg_gen_xor_tl(cpu_ca, t0, t1);        /* bits changed w/ ca=
rry */
> +            tcg_gen_xor_tl(ca, t0, t1);        /* bits changed w/ carry =
*/
>              tcg_temp_free(t1);
> -            tcg_gen_extract_tl(cpu_ca, cpu_ca, 32, 1);
> +            tcg_gen_extract_tl(ca, ca, 32, 1);
>              if (is_isa300(ctx)) {
> -                tcg_gen_mov_tl(cpu_ca32, cpu_ca);
> +                tcg_gen_mov_tl(ca32, ca);
>              }
>          } else {
>              TCGv zero =3D tcg_const_tl(0);
>              if (add_ca) {
> -                tcg_gen_add2_tl(t0, cpu_ca, arg1, zero, cpu_ca, zero);
> -                tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, arg2, zero);
> +                tcg_gen_add2_tl(t0, ca, arg1, zero, ca, zero);
> +                tcg_gen_add2_tl(t0, ca, t0, ca, arg2, zero);
>              } else {
> -                tcg_gen_add2_tl(t0, cpu_ca, arg1, zero, arg2, zero);
> +                tcg_gen_add2_tl(t0, ca, arg1, zero, arg2, zero);
>              }
> -            gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, 0);
> +            gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, ca32, 0);
>              tcg_temp_free(zero);
>          }
>      } else {
>          tcg_gen_add_tl(t0, arg1, arg2);
>          if (add_ca) {
> -            tcg_gen_add_tl(t0, t0, cpu_ca);
> +            tcg_gen_add_tl(t0, t0, ca);
>          }
>      }
> =20
> @@ -927,40 +928,44 @@ static inline void gen_op_arith_add(DisasContext *c=
tx, TCGv ret, TCGv arg1,
>      }
>  }
>  /* Add functions with two operands */
> -#define GEN_INT_ARITH_ADD(name, opc3, add_ca, compute_ca, compute_ov)   =
      \
> +#define GEN_INT_ARITH_ADD(name, opc3, ca, add_ca, compute_ca, compute_ov=
)     \
>  static void glue(gen_, name)(DisasContext *ctx)                         =
      \
>  {                                                                       =
      \
>      gen_op_arith_add(ctx, cpu_gpr[rD(ctx->opcode)],                     =
      \
>                       cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],=
      \
> +                     ca, glue(ca, 32),                                  =
      \
>                       add_ca, compute_ca, compute_ov, Rc(ctx->opcode));  =
      \
>  }
>  /* Add functions with one operand and one immediate */
> -#define GEN_INT_ARITH_ADD_CONST(name, opc3, const_val,                  =
      \
> +#define GEN_INT_ARITH_ADD_CONST(name, opc3, const_val, ca,              =
      \
>                                  add_ca, compute_ca, compute_ov)         =
      \
>  static void glue(gen_, name)(DisasContext *ctx)                         =
      \
>  {                                                                       =
      \
>      TCGv t0 =3D tcg_const_tl(const_val);                                =
        \
>      gen_op_arith_add(ctx, cpu_gpr[rD(ctx->opcode)],                     =
      \
>                       cpu_gpr[rA(ctx->opcode)], t0,                      =
      \
> +                     ca, glue(ca, 32),                                  =
      \
>                       add_ca, compute_ca, compute_ov, Rc(ctx->opcode));  =
      \
>      tcg_temp_free(t0);                                                  =
      \
>  }
> =20
>  /* add  add.  addo  addo. */
> -GEN_INT_ARITH_ADD(add, 0x08, 0, 0, 0)
> -GEN_INT_ARITH_ADD(addo, 0x18, 0, 0, 1)
> +GEN_INT_ARITH_ADD(add, 0x08, cpu_ca, 0, 0, 0)
> +GEN_INT_ARITH_ADD(addo, 0x18, cpu_ca, 0, 0, 1)
>  /* addc  addc.  addco  addco. */
> -GEN_INT_ARITH_ADD(addc, 0x00, 0, 1, 0)
> -GEN_INT_ARITH_ADD(addco, 0x10, 0, 1, 1)
> +GEN_INT_ARITH_ADD(addc, 0x00, cpu_ca, 0, 1, 0)
> +GEN_INT_ARITH_ADD(addco, 0x10, cpu_ca, 0, 1, 1)
>  /* adde  adde.  addeo  addeo. */
> -GEN_INT_ARITH_ADD(adde, 0x04, 1, 1, 0)
> -GEN_INT_ARITH_ADD(addeo, 0x14, 1, 1, 1)
> +GEN_INT_ARITH_ADD(adde, 0x04, cpu_ca, 1, 1, 0)
> +GEN_INT_ARITH_ADD(addeo, 0x14, cpu_ca, 1, 1, 1)
>  /* addme  addme.  addmeo  addmeo.  */
> -GEN_INT_ARITH_ADD_CONST(addme, 0x07, -1LL, 1, 1, 0)
> -GEN_INT_ARITH_ADD_CONST(addmeo, 0x17, -1LL, 1, 1, 1)
> +GEN_INT_ARITH_ADD_CONST(addme, 0x07, -1LL, cpu_ca, 1, 1, 0)
> +GEN_INT_ARITH_ADD_CONST(addmeo, 0x17, -1LL, cpu_ca, 1, 1, 1)
> +/* addex */
> +GEN_INT_ARITH_ADD(addex, 0x05, cpu_ov, 1, 1, 0);
>  /* addze  addze.  addzeo  addzeo.*/
> -GEN_INT_ARITH_ADD_CONST(addze, 0x06, 0, 1, 1, 0)
> -GEN_INT_ARITH_ADD_CONST(addzeo, 0x16, 0, 1, 1, 1)
> +GEN_INT_ARITH_ADD_CONST(addze, 0x06, 0, cpu_ca, 1, 1, 0)
> +GEN_INT_ARITH_ADD_CONST(addzeo, 0x16, 0, cpu_ca, 1, 1, 1)
>  /* addi */
>  static void gen_addi(DisasContext *ctx)
>  {
> @@ -979,7 +984,7 @@ static inline void gen_op_addic(DisasContext *ctx, bo=
ol compute_rc0)
>  {
>      TCGv c =3D tcg_const_tl(SIMM(ctx->opcode));
>      gen_op_arith_add(ctx, cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opco=
de)],
> -                     c, 0, 1, 0, compute_rc0);
> +                     c, cpu_ca, cpu_ca32, 0, 1, 0, compute_rc0);
>      tcg_temp_free(c);
>  }
> =20
> @@ -1432,13 +1437,13 @@ static inline void gen_op_arith_subf(DisasContext=
 *ctx, TCGv ret, TCGv arg1,
>              zero =3D tcg_const_tl(0);
>              tcg_gen_add2_tl(t0, cpu_ca, arg2, zero, cpu_ca, zero);
>              tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, inv1, zero);
> -            gen_op_arith_compute_ca32(ctx, t0, inv1, arg2, 0);
> +            gen_op_arith_compute_ca32(ctx, t0, inv1, arg2, cpu_ca32, 0);
>              tcg_temp_free(zero);
>              tcg_temp_free(inv1);
>          } else {
>              tcg_gen_setcond_tl(TCG_COND_GEU, cpu_ca, arg2, arg1);
>              tcg_gen_sub_tl(t0, arg2, arg1);
> -            gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, 1);
> +            gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, cpu_ca32, 1);
>          }
>      } else if (add_ca) {
>          /* Since we're ignoring carry-out, we can simplify the
> @@ -7087,6 +7092,7 @@ GEN_INT_ARITH_ADD(adde, 0x04, 1, 1, 0)
>  GEN_INT_ARITH_ADD(addeo, 0x14, 1, 1, 1)
>  GEN_INT_ARITH_ADD_CONST(addme, 0x07, -1LL, 1, 1, 0)
>  GEN_INT_ARITH_ADD_CONST(addmeo, 0x17, -1LL, 1, 1, 1)
> +GEN_HANDLER_E(addex, 0x1F, 0x0A, 0x05, 0x00000000, PPC_NONE, PPC2_ISA300=
),
>  GEN_INT_ARITH_ADD_CONST(addze, 0x06, 0, 1, 1, 0)
>  GEN_INT_ARITH_ADD_CONST(addzeo, 0x16, 0, 1, 1, 1)
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SnV5plBeK2Ge1I9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvtPxIACgkQbDjKyiDZ
s5KjkRAAmQ6pOrW+p+/ZYN0UsUmBKJvi72OHuRWOpW404uTXrBHEpIAkGJxzAbD2
/NAWReQ64kR4OLgZZ5zgnDeb137PudcrNRlXKZdRvT7VlpDEG8NgLhPbOXArB9qr
FK7lcA/8ti3RfP85T6EAQZiAiV5XWq1Nlmp0Uerxibtq1dkHZomaswl+0M2WoXpW
UH4EFUe0S5KybfKiwTgNmCLbm3Wj/C68sb/ufV5058QaqK5HOzuRLyjKABo4k+XJ
Y0/Qv7k2YDOXEazokdCemK4D1/nxFJlJ1NBo5vbFRBg11HfhwQ+P92NJcN8iu3C3
IQqQKNmzGqc8RJHGX4Fkex1wDRwiPnh4YYyyDvKDGzPYgpKjCY4sUssFrZRZkPoV
oTKmMD00rgO5fmzApP5EkVMTRYCeRFBYbqqQG1cY2GFyzj+KBpmmLALs39UWsKWS
oYW8dj5W3KhAaJdk6zSSLNXTDkCP5Wds5uZK4gOPdbXZJ3FpGLOrTPcE9h363/ou
gswmKbqAyjCnkL/YG5inBFdqunB6G/OfFhKmyVbtdaJcB5/vGcuB7G3bUxNkM4be
PS5H9NU4mHMacJhCBsaG03tn64I4EUpnrGGVsAqJU+SSkvONw63umOQpiQOfgPtG
7DqZnyAwGmbd5j0OWI3cDQUguXNH9Zd1RiHzsXrVB53rsPpeCyw=
=JTf3
-----END PGP SIGNATURE-----

--SnV5plBeK2Ge1I9g--
