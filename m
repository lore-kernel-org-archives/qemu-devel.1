Received: from eggs.gnu.org ([2001:4830:134:3::10]:45911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgk4b-0004Mb-HP
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgk4Z-00027T-Vl
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:28:05 -0500
Date: Thu, 23 Feb 2017 14:21:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223032118.GD12577@umbus.fritz.box>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-4-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FSGgxso9lj1d9SFz"
Content-Disposition: inline
In-Reply-To: <1487763883-4877-4-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/10] target/ppc: support for 32-bit
 carry and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--FSGgxso9lj1d9SFz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2017 at 05:14:36PM +0530, Nikunj A Dadhania wrote:
> POWER ISA 3.0 adds CA32 and OV32 status in 64-bit mode. Add the flags
> and corresponding defines.
>=20
> Moreover, CA32 is updated when CA is updated and OV32 is updated when OV
> is updated.
>=20
> Arithmetic instructions:
>     * Addition and Substractions:
>=20
>         addic, addic., subfic, addc, subfc, adde, subfe, addme, subfme,
>         addze, and subfze always updates CA and CA32.
>=20
>         =3D> CA reflects the carry out of bit 0 in 64-bit mode and out of
>            bit 32 in 32-bit mode.
>         =3D> CA32 reflects the carry out of bit 32 independent of the
>            mode.
>=20
>         =3D> SO and OV reflects overflow of the 64-bit result in 64-bit
>            mode and overflow of the low-order 32-bit result in 32-bit
>            mode
>         =3D> OV32 reflects overflow of the low-order 32-bit independent of
>            the mode
>=20
>     * Multiply Low and Divide:
>=20
>         For mulld, divd, divde, divdu and divdeu: SO, OV, and OV32 bits
>         reflects overflow of the 64-bit result
>=20
>         For mullw, divw, divwe, divwu and divweu: SO, OV, and OV32 bits
>         reflects overflow of the 32-bit result
>=20
>      * Negate with OE=3D1 (nego)
>=20
>        For 64-bit mode if the register RA contains
>        0x8000_0000_0000_0000, OV and OV32 are set to 1.
>=20
>        For 32-bit mode if the register RA contains 0x8000_0000, OV and
>        OV32 are set to 1.
>=20
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target/ppc/cpu.c            | 19 +++++++++++++++++--
>  target/ppc/cpu.h            |  7 +++++++
>  target/ppc/translate.c      | 29 ++++++++++++++++++++++++-----
>  target/ppc/translate_init.c |  4 ++--
>  4 files changed, 50 insertions(+), 9 deletions(-)
>=20
> diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
> index de3004b..89c1ccb 100644
> --- a/target/ppc/cpu.c
> +++ b/target/ppc/cpu.c
> @@ -23,8 +23,15 @@
> =20
>  target_ulong cpu_read_xer(CPUPPCState *env)
>  {
> -    return env->xer | (env->so << XER_SO) | (env->ov << XER_OV) |
> +    target_ulong xer;
> +
> +    xer =3D env->xer | (env->so << XER_SO) | (env->ov << XER_OV) |
>          (env->ca << XER_CA);
> +
> +    if (is_isa300(env)) {
> +        xer |=3D (env->ov32 << XER_OV32) | (env->ca32 << XER_CA32);
> +    }
> +    return xer;
>  }
> =20
>  void cpu_write_xer(CPUPPCState *env, target_ulong xer)
> @@ -32,5 +39,13 @@ void cpu_write_xer(CPUPPCState *env, target_ulong xer)
>      env->so =3D (xer >> XER_SO) & 1;
>      env->ov =3D (xer >> XER_OV) & 1;
>      env->ca =3D (xer >> XER_CA) & 1;
> -    env->xer =3D xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA=
));
> +    if (is_isa300(env)) {
> +        env->ov32 =3D (xer >> XER_OV32) & 1;
> +        env->ca32 =3D (xer >> XER_CA32) & 1;

I think these might as well be unconditional - as long as the read_xer
doesn't read the bits back, the guest won't care that we track them in
internal state.

I'm also wondering if it might be worth adding a xer_mask to the env,
instead of explicitly checking isa300 all over the place.

> +        env->xer =3D xer & ~((1ul << XER_SO) |
> +                           (1ul << XER_OV) | (1ul << XER_CA) |
> +                           (1ul << XER_OV32) | (1ul << XER_CA32));
> +    } else {
> +        env->xer =3D xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XE=
R_CA));
> +    }

And you can definitely use the stricer mask for both archs.  If it's
ISA300, you've stashed them elsewhere, if it's not those bits are
invalid anyway,

(Incidentally given the modern balance between the cost of
instructions and cachelines, I wonder if all these split out bits of
the XER are a good idea in any case, but that would be a big change
out  of scope for what you're attempting here)

>  }
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index b559b67..ee2eb45 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -965,6 +965,8 @@ struct CPUPPCState {
>      target_ulong so;
>      target_ulong ov;
>      target_ulong ca;
> +    target_ulong ov32;
> +    target_ulong ca32;
>      /* Reservation address */
>      target_ulong reserve_addr;
>      /* Reservation value */
> @@ -1372,11 +1374,15 @@ int ppc_compat_max_threads(PowerPCCPU *cpu);
>  #define XER_SO  31
>  #define XER_OV  30
>  #define XER_CA  29
> +#define XER_OV32  19
> +#define XER_CA32  18
>  #define XER_CMP  8
>  #define XER_BC   0
>  #define xer_so  (env->so)
>  #define xer_ov  (env->ov)
>  #define xer_ca  (env->ca)
> +#define xer_ov32  (env->ov)
> +#define xer_ca32  (env->ca)
>  #define xer_cmp ((env->xer >> XER_CMP) & 0xFF)
>  #define xer_bc  ((env->xer >> XER_BC)  & 0x7F)
> =20
> @@ -2343,6 +2349,7 @@ enum {
> =20
>  /***********************************************************************=
******/
> =20
> +#define is_isa300(ctx) (!!(ctx->insns_flags2 & PPC2_ISA300))
>  target_ulong cpu_read_xer(CPUPPCState *env);
>  void cpu_write_xer(CPUPPCState *env, target_ulong xer);
> =20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b09e16f..c9f6768 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -71,7 +71,7 @@ static TCGv cpu_lr;
>  #if defined(TARGET_PPC64)
>  static TCGv cpu_cfar;
>  #endif
> -static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca;
> +static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca, cpu_ov32, cpu_ca32;
>  static TCGv cpu_reserve;
>  static TCGv cpu_fpscr;
>  static TCGv_i32 cpu_access_type;
> @@ -173,6 +173,10 @@ void ppc_translate_init(void)
>                                  offsetof(CPUPPCState, ov), "OV");
>      cpu_ca =3D tcg_global_mem_new(cpu_env,
>                                  offsetof(CPUPPCState, ca), "CA");
> +    cpu_ov32 =3D tcg_global_mem_new(cpu_env,
> +                                  offsetof(CPUPPCState, ov32), "OV32");
> +    cpu_ca32 =3D tcg_global_mem_new(cpu_env,
> +                                  offsetof(CPUPPCState, ca32), "CA32");
> =20
>      cpu_reserve =3D tcg_global_mem_new(cpu_env,
>                                       offsetof(CPUPPCState, reserve_addr),
> @@ -3703,7 +3707,7 @@ static void gen_tdi(DisasContext *ctx)
> =20
>  /***                          Processor control                         =
   ***/
> =20
> -static void gen_read_xer(TCGv dst)
> +static void gen_read_xer(DisasContext *ctx, TCGv dst)
>  {
>      TCGv t0 =3D tcg_temp_new();
>      TCGv t1 =3D tcg_temp_new();
> @@ -3715,15 +3719,30 @@ static void gen_read_xer(TCGv dst)
>      tcg_gen_or_tl(t0, t0, t1);
>      tcg_gen_or_tl(dst, dst, t2);
>      tcg_gen_or_tl(dst, dst, t0);
> +    if (is_isa300(ctx)) {
> +        tcg_gen_shli_tl(t0, cpu_ov32, XER_OV32);
> +        tcg_gen_or_tl(dst, dst, t0);
> +        tcg_gen_shli_tl(t0, cpu_ca32, XER_CA32);
> +        tcg_gen_or_tl(dst, dst, t0);

Could you use 2 deposits here, instead of 2 shifts and 2 ors?

> +    }
>      tcg_temp_free(t0);
>      tcg_temp_free(t1);
>      tcg_temp_free(t2);
>  }
> =20
> -static void gen_write_xer(TCGv src)
> +static void gen_write_xer(DisasContext *ctx, TCGv src)
>  {
> -    tcg_gen_andi_tl(cpu_xer, src,
> -                    ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA)));
> +    if (is_isa300(ctx)) {
> +        tcg_gen_andi_tl(cpu_xer, src,
> +                        ~((1u << XER_SO) |
> +                          (1u << XER_OV) | (1u << XER_OV32) |
> +                          (1u << XER_CA) | (1u << XER_CA32)));
> +        tcg_gen_extract_tl(cpu_ov32, src, XER_OV32, 1);
> +        tcg_gen_extract_tl(cpu_ca32, src, XER_CA32, 1);
> +    } else {
> +        tcg_gen_andi_tl(cpu_xer, src,
> +                        ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_C=
A)));
> +    }
>      tcg_gen_extract_tl(cpu_so, src, XER_SO, 1);
>      tcg_gen_extract_tl(cpu_ov, src, XER_OV, 1);
>      tcg_gen_extract_tl(cpu_ca, src, XER_CA, 1);
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index be35cbd..eb667bb 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -107,12 +107,12 @@ static void spr_access_nop(DisasContext *ctx, int s=
prn, int gprn)
>  /* XER */
>  static void spr_read_xer (DisasContext *ctx, int gprn, int sprn)
>  {
> -    gen_read_xer(cpu_gpr[gprn]);
> +    gen_read_xer(ctx, cpu_gpr[gprn]);
>  }
> =20
>  static void spr_write_xer (DisasContext *ctx, int sprn, int gprn)
>  {
> -    gen_write_xer(cpu_gpr[gprn]);
> +    gen_write_xer(ctx, cpu_gpr[gprn]);
>  }
> =20
>  /* LR */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FSGgxso9lj1d9SFz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrlUsAAoJEGw4ysog2bOSb9EQAOZWyvVmKxmoToO6NouTz3qB
XjcbonnVIqBA6T148ERKupHvSlS3O0U17VTJPhuTZbRANnlVXr3uuFKptFzba3AC
tCk6KBeZyTGX4KNjjLqPczN4DrB6OUmaxaQ7hZNpNzbS3ZnP9AceBtQ2Q9GEkaS1
aorOHrsC8GapemAh5vrTJJI1xOLMsGwuAiehhZh89BEchjHjfg2qS68pOh76R0K5
jkTFgwnFDhr7PppRVQSRrnVilAD13+JKZ2ColAhNev7i69JgghfEysLsaIi9mV0o
Zb7cAweTa7Ki9HKXzXp9OE+W67fWU2Yjna4E2laYaPj8LV4W8pdg8M2G/2Ha9fee
gZy24F3BDd2KV3Kw+H/3Bg7Ep7GV/f64Bc4n92GF7IUrzJmVPUZDo4S4Q3OSBEEO
wHl/xdVRzg4MYIozw50W32QtCtX9H/Drm5BheqzL/XtqVd5Ht6dNttE0C0Qk8slp
lZKNi99bKjecqXxjMK1Q52zc+ShVWV64Qzi54AXIgf2vuBTDiJnh8AzkXWojGGlm
lMM3rE6XYQBWjtTGPqRbOxMenyDe/IUYp7t1/PMKVMQ3GZbZipbkUTa5lcHOddOz
mX3jrtqVqCnk1ziTwkXgdWAqP0g4U0mtxvJ4+zjXFJDkLk+ftJdsFIH44g3uo669
BbHQgybF9QaQxHA5jeuF
=yy6e
-----END PGP SIGNATURE-----

--FSGgxso9lj1d9SFz--
