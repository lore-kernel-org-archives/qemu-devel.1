Received: from eggs.gnu.org ([2001:4830:134:3::10]:46929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbzF7-0002Ji-6s
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbzF6-000651-49
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:39:17 -0500
Date: Fri, 10 Feb 2017 11:10:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210001035.GJ27610@umbus.fritz.box>
References: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1486636445-24109-6-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GlnCQLZWzqLRJED8"
Content-Disposition: inline
In-Reply-To: <1486636445-24109-6-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 5/6] target-ppc: support for 32-bit carry
 and overflow
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


--GlnCQLZWzqLRJED8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 04:04:04PM +0530, Nikunj A Dadhania wrote:
> POWER ISA 3.0 adds CA32 and OV32 status in 64-bit mode. Add the flags
> and corresponding defines. Moreover, CA32 is set when CA is set and
> OV32 is set when OV is set, there is no need to have a new
> fields in the CPUPPCState structure.
>=20
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Um.. I don't quite understand this.  If CA always has the same value
as CA32, what's the point?

> ---
>  target/ppc/cpu.h       | 26 ++++++++++++++++++++++++++
>  target/ppc/translate.c |  6 ++++++
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index bc2a2ce..181919b 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1354,11 +1354,15 @@ int ppc_compat_max_threads(PowerPCCPU *cpu);
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
> @@ -2325,11 +2329,21 @@ enum {
> =20
>  /***********************************************************************=
******/
> =20
> +#ifndef TARGET_PPC64
>  static inline target_ulong cpu_read_xer(CPUPPCState *env)
>  {
>      return env->xer | (env->so << XER_SO) | (env->ov << XER_OV) | (env->=
ca << XER_CA);
>  }
> +#else
> +static inline target_ulong cpu_read_xer(CPUPPCState *env)
> +{
> +    return env->xer | (env->so << XER_SO) |
> +        (env->ov << XER_OV) | (env->ca << XER_CA) |
> +        (env->ov << XER_OV32) | (env->ca << XER_CA32);
> +}
> +#endif
> =20
> +#ifndef TARGET_PPC64
>  static inline void cpu_write_xer(CPUPPCState *env, target_ulong xer)
>  {
>      env->so =3D (xer >> XER_SO) & 1;
> @@ -2337,6 +2351,18 @@ static inline void cpu_write_xer(CPUPPCState *env,=
 target_ulong xer)
>      env->ca =3D (xer >> XER_CA) & 1;
>      env->xer =3D xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA=
));
>  }
> +#else
> +static inline void cpu_write_xer(CPUPPCState *env, target_ulong xer)
> +{
> +    env->so =3D (xer >> XER_SO) & 1;
> +    env->ov =3D ((xer >> XER_OV) & 1) | ((xer >> XER_OV32) & 1);
> +    env->ca =3D ((xer >> XER_CA) & 1) | ((xer >> XER_CA32) & 1);
> +    env->xer =3D xer & ~((1ul << XER_SO) |
> +                       (1ul << XER_OV) | (1ul << XER_CA) |
> +                       (1ul << XER_OV32) | (1ul << XER_CA32));
> +}
> +#endif
> +
> =20
>  static inline void cpu_get_tb_cpu_state(CPUPPCState *env, target_ulong *=
pc,
>                                          target_ulong *cs_base, uint32_t =
*flags)
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 3ba2616..724ad17 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3715,6 +3715,12 @@ static void gen_read_xer(TCGv dst)
>      tcg_gen_or_tl(t0, t0, t1);
>      tcg_gen_or_tl(dst, dst, t2);
>      tcg_gen_or_tl(dst, dst, t0);
> +#ifdef TARGET_PPC64
> +    tcg_gen_shli_tl(t0, cpu_ov, XER_OV32);
> +    tcg_gen_or_tl(dst, dst, t0);
> +    tcg_gen_shli_tl(t0, cpu_ca, XER_CA32);
> +    tcg_gen_or_tl(dst, dst, t0);
> +#endif
>      tcg_temp_free(t0);
>      tcg_temp_free(t1);
>      tcg_temp_free(t2);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GlnCQLZWzqLRJED8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnQT4AAoJEGw4ysog2bOS2kkP/0tVK3CztNUrnpt5LB6zyioq
phkAxMstFYwM/69J7q/DcXquKqrILgRAEHLCSMtu+efCAe3x+ljdLPcMXxeGM4IB
peWitoVCUelqtf3xjsuGVeKz0r431jbTPmx8215tgRDRZtf1bpP35GWVcdHD18bH
gNlE0yfQAWoRV2C9GmBJRWcV4MHkuaHn/EQr2RBSIntNmU3LWMIaFhtKPsVdCIy2
J5WvnhbfVHWi4HC0/EoBfBJFqTYJ6ihGj7FVYf6u2zIBYv713t36u8K1r9Hcrt9C
GKlQBxF3UIj+NiELOgwCSN/PyN5v3He/d42EEIj2M+hd54/KCIVE3FagSTySwJgm
m/aLrroIiW7SkElP21fqxnNcNRzJx5VUUXiVLhnzgMA+O3RndsheDH0O/Z1gNmuH
I5tPvFfA656/Mb85s/6RM3sw7vhX2ufz7ZOqBIZgiUfXA2vbwmTcZC688BtevY4M
2bibrrecm5qk46azvTNLZ3O7qP9ilE+0uv4DpazTpQZvlWiEwLY4q8D0ENXLF5lM
0uI9Ci6lgt0eKToXSNlU3CX4ScWs81m/ZSptFji0C/MgI0Loy16NFeFklef0iZQJ
tf3XhYJCCsnseGzHrSndc26NB9pPlcByxZ5pps5ERgSCwIzsjZGY+xKDHRD5FqRI
Uya556SlvAXz0p0ikyPZ
=zkHF
-----END PGP SIGNATURE-----

--GlnCQLZWzqLRJED8--
