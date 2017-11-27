Received: from eggs.gnu.org ([2001:4830:134:3::10]:45336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJE02-0008Ca-5Y
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 02:38:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJE00-00005G-Ng
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 02:38:42 -0500
Date: Mon, 27 Nov 2017 18:18:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171127071825.GG11775@umbus.fritz.box>
References: <20171124070550.6433-1-clg@kaod.org>
	<20171124070550.6433-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jt0yj30bxbg11sci"
Content-Disposition: inline
In-Reply-To: <20171124070550.6433-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v4 1/3] spapr/rtas: disable the decrementer
 interrupt when a CPU is unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>


--jt0yj30bxbg11sci
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2017 at 08:05:48AM +0100, C=E9dric Le Goater wrote:
> When a CPU is stopped with the 'stop-self' RTAS call, its state
> 'halted' is switched to 1 and, in this case, the MSR is not taken into
> account anymore in the cpu_has_work() routine. Only the pending
> hardware interrupts are checked with their LPCR:PECE* enablement bit.
>=20
> If the DECR timer fires after 'stop-self' is called and before the CPU
> 'stop' state is reached, the nearly-dead CPU will have some work to do
> and the guest will crash. This case happens very frequently with the
> not yet upstream P9 XIVE exploitation mode. In XICS mode, the DECR is
> occasionally fired but after 'stop' state, so no work is to be done
> and the guest survives.
>=20
> I suspect there is a race between the QEMU mainloop triggering the
> timers and the TCG CPU thread but I could not quite identify the root
> cause. To be safe, let's disable in the LPCR all the exceptions which
> can cause an exit while the CPU is in power-saving mode and reenable
> them when the CPU is started.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-2.12.

> ---
>=20
> Changes in v4:
>=20
>  - used the 'lpcr_pm' field of PowerPCCPUClass
>=20
> Changes in v3:
>=20
>  - introduced a cpu_ppc_papr_pece_bits() helper to gather the PECE
>    bits depending on the CPU family.  =20
>  - enabled Power-saving mode Exit Cause exceptions only on the boot CPU.
> =20
> Changes in v2:
>=20
>  - used a new routine ppc_cpu_pvr_match() to discriminate CPU versions
>  - removed the LPCR:PECE* enablement bit when the CPU is initialized
>    if it is a secondary
>=20
>  hw/ppc/spapr_rtas.c         | 11 +++++++++++
>  target/ppc/translate_init.c |  9 ++++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index cdf0b607a0a0..858adb1bf3a9 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -162,6 +162,7 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMac=
hineState *spapr,
>      if (cpu !=3D NULL) {
>          CPUState *cs =3D CPU(cpu);
>          CPUPPCState *env =3D &cpu->env;
> +        PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> =20
>          if (!cs->halted) {
>              rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> @@ -174,6 +175,10 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMa=
chineState *spapr,
>          kvm_cpu_synchronize_state(cs);
> =20
>          env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
> +
> +        /* Enable Power-saving mode Exit Cause exceptions for the new CP=
U */
> +        env->spr[SPR_LPCR] |=3D pcc->lpcr_pm;
> +
>          env->nip =3D start;
>          env->gpr[3] =3D r3;
>          cs->halted =3D 0;
> @@ -197,6 +202,7 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMach=
ineState *spapr,
>  {
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> =20
>      cs->halted =3D 1;
>      qemu_cpu_kick(cs);
> @@ -210,6 +216,11 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
>       * no need to bother with specific bits, we just clear it.
>       */
>      env->msr =3D 0;
> +
> +    /* Disable Power-saving mode Exit Cause exceptions for the CPU.
> +     * This could deliver an interrupt on a dying CPU and crash the
> +     * guest */
> +    env->spr[SPR_LPCR] &=3D ~pcc->lpcr_pm;
>  }
> =20
>  static inline int sysparm_st(target_ulong addr, target_ulong len,
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 828d7e778c3b..78a4a581bab7 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8911,6 +8911,7 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHy=
pervisor *vhyp)
>      CPUPPCState *env =3D &cpu->env;
>      ppc_spr_t *lpcr =3D &env->spr_cb[SPR_LPCR];
>      ppc_spr_t *amor =3D &env->spr_cb[SPR_AMOR];
> +    CPUState *cs =3D CPU(cpu);
> =20
>      cpu->vhyp =3D vhyp;
> =20
> @@ -8953,10 +8954,12 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtual=
Hypervisor *vhyp)
>          }
>      }
> =20
> -    /* Also set the power-saving mode bits which depend on the CPU
> -     * family
> +    /* Only enable Power-saving mode Exit Cause exceptions on the boot
> +     * CPU. The RTAS command start-cpu will enable them on secondaries.
>       */
> -    lpcr->default_value |=3D pcc->lpcr_pm;
> +    if (cs =3D=3D first_cpu) {
> +        lpcr->default_value |=3D pcc->lpcr_pm;
> +    }
> =20
>      /* We should be followed by a CPU reset but update the active value
>       * just in case...

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jt0yj30bxbg11sci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlobvEEACgkQbDjKyiDZ
s5LvPQ//SokstHFsV4d+LqfdewocaTEV4PSNSabrEE89Ng2MmK4st3PFB0N8qMLv
ZOpWCw3WzrcV0MqbVXqn9ebvmYAGF6MS+QDsKO95XfeypsMYoc6CQSalmviTu+p7
m+h7huj2cTW+TU7VkC7GchkQb7+6YNTAZUfMXrqu4xFP66zrrkVRSjH3ph71orT9
Vw0+4/k+YOjvPkByDYAmcv5k8CZEpsbO0O/YNPXIfP5ZnJFKkF1DNVqJxoRgfIoj
r8qxQEi5p5yMM3ZeiLNuUOYfqgs0zP95psxUalXaUx+mpBTBu2DmnBuYbFKBZbTi
OOrCXTgFp37fh6djxM9l5A/Q5MI8aqYMTi/F8FE33dVDjxV7/O+unBc0D/rXaAHf
PLTYhZnPRCfQ4jexGzKXbKNVluFn1XdVBGilIBEodTG9lT9TQg7fTAImiyInxyjQ
XGAq167If2dD+rMNZTX1Ms46PVNhjHo1Ku/boCvh2QoQ3jOiMTwSqCBLja6jkfS8
N9V9pudvMcm+mCMXaQd5xYvMPY3HLZ2vnxTC5ucbMieM+MBcjabmVWu+farfDw4U
mtP+9O94IWEMPok8VUdz2eer2NWAqk7FAuEsFxNPpiPOtsUSp3K5CXql4/xZ8I61
WLxTsqfsTkVkhus2jjG6GiJgEKSyRGaanDMJ9/itl0cLsuU6yrM=
=dtRy
-----END PGP SIGNATURE-----

--jt0yj30bxbg11sci--
