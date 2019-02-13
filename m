Received: from eggs.gnu.org ([209.51.188.92]:45416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtn6T-0008Gf-OH
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:29:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtmwg-0005yw-VD
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:18:56 -0500
Date: Wed, 13 Feb 2019 16:08:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213050849.GO1884@umbus.fritz.box>
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-14-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9rRS2CJFk/mxouRY"
Content-Disposition: inline
In-Reply-To: <20190128094625.4428-14-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 13/19] target/ppc: Rename "in_pm_state" to
 "resume_as_sreset"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--9rRS2CJFk/mxouRY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 10:46:19AM +0100, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> To better reflect what this does, as it's specific to some of the
> P7/P8/P9 PM states, not generic.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/cpu.h         | 6 +++---
>  hw/ppc/ppc.c             | 2 +-
>  target/ppc/excp_helper.c | 8 ++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 7ff65c804b57..b69410ea2541 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1116,10 +1116,10 @@ struct CPUPPCState {
> =20
>      /*
>       * On P7/P8/P9, set when in PM state, we need to handle resume in
> -     * a special way (such as routing some resume causes to 0x100), so
> -     * flag this here.
> +     * a special way (such as routing some resume causes to 0x100, ie,
> +     * sreset), so flag this here.
>       */
> -    bool in_pm_state;
> +    bool resume_as_sreset;
>  #endif
> =20
>      /* Those resources are used only during code translation */
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 9292f986eba7..608405f6f2ca 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -722,7 +722,7 @@ static inline void cpu_ppc_hdecr_excp(PowerPCCPU *cpu)
>       * interrupts in a PM state. Not only they don't cause a
>       * wakeup but they also get effectively discarded.
>       */
> -    if (!env->in_pm_state) {
> +    if (!env->resume_as_sreset) {
>          ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 1);
>      }
>  }
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 489a54f51b90..7536620a4133 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -69,7 +69,7 @@ static int powerpc_reset_wakeup(CPUState *cs, CPUPPCSta=
te *env, int excp,
>                                  target_ulong *msr)
>  {
>      /* We no longer are in a PM state */
> -    env->in_pm_state =3D false;
> +    env->resume_as_sreset =3D false;
> =20
>      /* Pretend to be returning from doze always as we don't lose state */
>      *msr |=3D (0x1ull << (63 - 47));
> @@ -141,7 +141,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
>       * check for special resume at 0x100 from doze/nap/sleep/winkle on
>       * P7/P8/P9
>       */
> -    if (env->in_pm_state) {
> +    if (env->resume_as_sreset) {
>          excp =3D powerpc_reset_wakeup(cs, env, excp, &msr);
>      }
> =20
> @@ -787,7 +787,7 @@ static void ppc_hw_interrupt(CPUPPCState *env)
>       * clear when coming out of some power management states (in order
>       * for them to become a 0x100).
>       */
> -    async_deliver =3D (msr_ee !=3D 0) || env->in_pm_state;
> +    async_deliver =3D (msr_ee !=3D 0) || env->resume_as_sreset;
> =20
>      /* Hypervisor decrementer exception */
>      if (env->pending_interrupts & (1 << PPC_INTERRUPT_HDECR)) {
> @@ -970,7 +970,7 @@ void helper_pminsn(CPUPPCState *env, powerpc_pm_insn_=
t insn)
>      env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_HDECR);
> =20
>      /* Condition for waking up at 0x100 */
> -    env->in_pm_state =3D (insn !=3D PPC_PM_STOP) ||
> +    env->resume_as_sreset =3D (insn !=3D PPC_PM_STOP) ||
>          (env->spr[SPR_PSSCR] & PSSCR_EC);
>  }
>  #endif /* defined(TARGET_PPC64) */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9rRS2CJFk/mxouRY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjpmAACgkQbDjKyiDZ
s5JI0BAArnQXPsUNjUN3F5w4dbZDwGNn8TpStJen6+oelQNFbQR8r8KWTGbTchqs
s3B7KLbCm643bF0lgxlzFozBSjmmZN+AMnWHWvDOVEqfefGkOVB8ZPxNzpB5QOtQ
Ip4POImzkFQU3K7XH91W9qbLdpKy/kklL/e3qf1/LPEMa0irBHT8PboxJ0WYKWZH
RIJzgFsUcbP5aUlJ/D76VhqQ+DS1nmLT6EQ2Yjyw7d5lJDlCpOidP3tgiAzA1v3V
yvXTqcX/x9tzI/TpS24NCMq9B2EPZSy+zvWWTGYIs2gjsEjVGOvQ2oa21w72pVRW
KqSpizAxPgfff16mkCjbXcuX9DCPMcVRKpROmb2BEWgVvJpA+v6eyEM2vwKTwpnU
WmOkpuiLcA04K59sCuOj/Fj5/tsYnlZ0ts/AvxNAnhKSHfI7cnu5tOlaeqq1tdwF
NZsV4yfBOQjRIYfQlkgMKzR6HcQ8a+k23+oHFyT63lt3P4JoBOh6UQnKIfAtKPXL
imGzjuMKIiI/DB/83fewBT3AQjsVdtbgbF5Cy+DcCav3WjuHgu3K6oPt1dC8aRi1
xNqyWfOJHrN0mYre5l1v4vLlMaHgpuoLQgEboN2GI5VtRSunmuxSejejRO70+1uJ
h4N6zMNppKDpUd4cCqbTcu1mjVnQH4LP5n1dmWgS0fTWEKpo2Vk=
=rtLB
-----END PGP SIGNATURE-----

--9rRS2CJFk/mxouRY--
