Received: from eggs.gnu.org ([2001:4830:134:3::10]:38710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQ2I3-0003gH-9Y
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 23:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQ2I1-0002a2-T3
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 23:05:43 -0400
Date: Tue, 5 Jun 2018 12:59:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180605025928.GT5140@umbus.fritz.box>
References: <20180604084513.8298-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7Ha3rcGc4ZVRbLT1"
Content-Disposition: inline
In-Reply-To: <20180604084513.8298-1-joel@jms.id.au>
Subject: Re: [Qemu-devel] [PATCH v3] target/ppc: Allow privileged access to
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


--7Ha3rcGc4ZVRbLT1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 06:15:13PM +0930, Joel Stanley wrote:
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

Applied to ppc-for-3.0, thanks.

> ---
> v2:
>  - Change error message to say Invalid instead of Unimplemented
>  - Fix compile warning on other powerpc targets, thanks patchew
> v3:
>  - Mask against pcr_mask before storing
>  - Drop check for non-zero value
> ---
>  target/ppc/helper.h             | 1 +
>  target/ppc/misc_helper.c        | 9 +++++++++
>  target/ppc/translate_init.inc.c | 9 +++++++--
>  3 files changed, 17 insertions(+), 2 deletions(-)
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
> index 8c8cba5cc6f1..b88493009609 100644
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
> @@ -98,6 +99,14 @@ void helper_store_ptcr(CPUPPCState *env, target_ulong =
val)
>          tlb_flush(CPU(cpu));
>      }
>  }
> +
> +void helper_store_pcr(CPUPPCState *env, target_ulong value)
> +{
> +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> +
> +    env->spr[SPR_PCR] =3D value & pcc->pcr_mask;
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

--7Ha3rcGc4ZVRbLT1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsV/I4ACgkQbDjKyiDZ
s5L2lA/+OzDgytAcOdasueTxsgdzxAKEisefWIg0Qu1OZwrt/ovLfehmxwC2hvpk
0eiHwivK/XY6SjcDT5kh6llUsZ8/9IHWCMvZUFjtRSwZoTjNscDA4G2WFbM+FRpf
dsJOtdw8rJusO92VBGz9voJayPmBnMd43J1xM9iiUu2cGgi6cqsi2s8Zpk5Lp7TN
xJBLVS7ixZcmurCz8YpDbrl6Dv4u/lIGPJ5ZrraqKTCgqntgu7I/W+gqjxhQTY6R
5TSWu0c8QMu1Eg0N/9gl51pi09pLhKgaHKsQwaD1cqY4tYgmOEXPh7Ue53pQM/Nb
2oHOxfHmELLdOR8SwQxyze3LIaAUXZHazUJAduR123O5qONnlTbH2V7JN8h6TgxM
vIp5v61RFyZoM+TRZcUU4WANFH/JuZapZPEaXoqNvFZkfy0EASSdVzMbFR6bKyNE
5L+c+CfzRzcoURpXyaoH/VD+9icvTEgw/TSwDctXHu7bS2iZm6tNpZh9DVPNzH8c
ubyqDIGmU5CfvBqLAguKgkDOYyj6Bnb6ijESpmTcwJ5X5Vs/2xvjMndNWvnv9P5y
l6qKc5jxHtBg9msbdr90M5whBSW9OsZ00iLEG7osFxlN/OoNC/d3sB2e/CPxijp9
rk5ouj9n03kAl8J+UpOG7XmdMNSe2EqPFYrM7yKfWcICh9R3Zdk=
=8068
-----END PGP SIGNATURE-----

--7Ha3rcGc4ZVRbLT1--
