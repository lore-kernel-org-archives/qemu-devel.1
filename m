Received: from eggs.gnu.org ([2001:4830:134:3::10]:51590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPkUC-0003f4-Nz
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPkU8-0002r9-O6
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:05:04 -0400
Date: Mon, 4 Jun 2018 18:04:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180604080448.GM4251@umbus>
References: <20180531130429.24911-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WuedheRyq6FDfQ9j"
Content-Disposition: inline
In-Reply-To: <20180531130429.24911-1-joel@jms.id.au>
Subject: Re: [Qemu-devel] [PATCH v2] target/ppc: Allow privileged access to
 SPR_PCR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>


--WuedheRyq6FDfQ9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 31, 2018 at 10:34:29PM +0930, Joel Stanley wrote:
> The powerpc Linux kernel[1] and skiboot firmware[2] recently gained chang=
es
> that cause the Processor Compatibility Register (PCR) SPR to be cleared.
>=20
> These changes cause Linux to fail to boot on the Qemu powernv machine
> with an error:
>=20
>  Trying to write privileged spr 338 (0x152) at 0000000030017f0c
>=20
> With this patch Qemu makes this register available as a hypervisor
> privileged register.
>=20
> Note that bits set in this register disable features of the processor.
> Currently the only register state that is supported is when the register
> is zeroed (enable all features). This is sufficient for guests to
> once again boot.
>=20
> [1] https://lkml.kernel.org/r/20180518013742.24095-1-mikey@neuling.org
> [2] https://patchwork.ozlabs.org/patch/915932/
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2:
>  - Change error message to say Invalid instead of Unimplemented
>  - Fix compile warning on other powerpc targets, thanks patchew
> ---
>  target/ppc/helper.h             |  1 +
>  target/ppc/misc_helper.c        | 10 ++++++++++
>  target/ppc/translate_init.inc.c |  9 +++++++--
>  3 files changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 19453c68138a..d751f0e21909 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -17,6 +17,7 @@ DEF_HELPER_2(pminsn, void, env, i32)
>  DEF_HELPER_1(rfid, void, env)
>  DEF_HELPER_1(hrfid, void, env)
>  DEF_HELPER_2(store_lpcr, void, env, tl)
> +DEF_HELPER_2(store_pcr, void, env, tl)
>  #endif
>  DEF_HELPER_1(check_tlb_flush_local, void, env)
>  DEF_HELPER_1(check_tlb_flush_global, void, env)
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index 8c8cba5cc6f1..1870f4c47f1a 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -20,6 +20,7 @@
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "exec/helper-proto.h"
> +#include "qemu/error-report.h"
> =20
>  #include "helper_regs.h"
> =20
> @@ -98,6 +99,15 @@ void helper_store_ptcr(CPUPPCState *env, target_ulong =
val)
>          tlb_flush(CPU(cpu));
>      }
>  }
> +
> +void helper_store_pcr(CPUPPCState *env, target_ulong value)
> +{
> +    if (value !=3D 0) {
> +        error_report("Invalid PCR value 0x"TARGET_FMT_lx, value);
> +        return;
> +    }

I don't see a lot of point to this check.  For now the only user just
clears the PCR, but why limit yourself to that explicitly?

> +    env->spr[SPR_PCR] =3D value;

You definitely should be masking against pcr_mask too.

> +}
>  #endif /* defined(TARGET_PPC64) */
> =20
>  void helper_store_pidr(CPUPPCState *env, target_ulong val)
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index ab782cb32aaa..1a89017ddea8 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -424,6 +424,10 @@ static void spr_write_ptcr(DisasContext *ctx, int sp=
rn, int gprn)
>      gen_helper_store_ptcr(cpu_env, cpu_gpr[gprn]);
>  }
> =20
> +static void spr_write_pcr(DisasContext *ctx, int sprn, int gprn)
> +{
> +    gen_helper_store_pcr(cpu_env, cpu_gpr[gprn]);
> +}
>  #endif
>  #endif
> =20
> @@ -7957,11 +7961,12 @@ static void gen_spr_power6_common(CPUPPCState *en=
v)
>  #endif
>      /*
>       * Register PCR to report POWERPC_EXCP_PRIV_REG instead of
> -     * POWERPC_EXCP_INVAL_SPR.
> +     * POWERPC_EXCP_INVAL_SPR in userspace. Permit hypervisor access.
>       */
> -    spr_register(env, SPR_PCR, "PCR",
> +    spr_register_hv(env, SPR_PCR, "PCR",
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_pcr,
>                   0x00000000);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WuedheRyq6FDfQ9j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsU8qAACgkQbDjKyiDZ
s5IazRAAvVicvlNjEbmegWPBrfU86ymD41oIRVp+AamLJr3Iv2z1Y9VQ+MsSaFTK
FjmNRLlDVnkyvvz7YwEIcRvgxqT/lYK3dBuGMkRCd27Fbi3rcR38SgMLfuAkXmtN
G6IDsilLd7CUlOgeComp/6KXXLHqcb36bnJIEzex8h4px/rtcZzyfi9hiPB5CskW
XLLGc0JgsH0clLT/DuN7Kw+O8G37oaNyFAvipFJp2IVD+z5t91spS9xPBmdMlQPO
ysWlqOGAH5CTfF10c/HNSrpI91I6CTl4lREw70o7IK9dat16FWRkh5TSS7fCOTgB
Kalw9VcO+Qv9naD2vEWMfp/l8uMgYNwWq+ngsHQ3t0oFnHYkcZApg3kozO5Vcuql
pjvfxbD1l4uf011V3lXp/4NkAblvaWJjZP/ikaxefe9kiYRtOvHGYGCp4ygHYHVN
JNXzNDX5mcOUYE0E8ovBNCqrI2NzzZUpGNa7GqoPCChiYe/Mn3a/fBBjlmuCWa36
+nHn22+oB1Ja93ZfrDXyJjTnmevrLHcvsCQ+P/+dlztSxp4m0O6SMniwnxdWHhTz
alQpKGe9NwsSh3/AC58wAMHHmVC5Coll9X9uZdsI3qJMvAfEn2apM+OU+RZS7Dv2
vwQvC4LyWvzxSD2QwGShrnC62nXzhrWQGI5ukZJiQFCLMxoGHUI=
=Szsv
-----END PGP SIGNATURE-----

--WuedheRyq6FDfQ9j--
