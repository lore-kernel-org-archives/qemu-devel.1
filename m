Received: from eggs.gnu.org ([2001:4830:134:3::10]:54078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE8Oc-0006tq-2Y
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE8OX-0002Mn-VN
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:11:18 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:40611)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fE8OX-0002Lw-Li
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:11:13 -0400
Received: from player714.ha.ovh.net (unknown [10.109.105.2])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 2B05715F12
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 09:11:12 +0200 (CEST)
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
	<20180503062145.17899-3-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9c969ebd-3636-adbc-53da-f3d94da77c2c@kaod.org>
Date: Thu, 3 May 2018 09:11:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180503062145.17899-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/8] spapr: Clean up rtas_start_cpu() &
 rtas_stop_self()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com

On 05/03/2018 08:21 AM, David Gibson wrote:
> This makes several minor cleanups to these functions:
>   * Follow usual convention of an early exit on error, rather than havi=
ng
>     most of the body in an if
>   * Clearer naming of cpu and cpu_.  Now callcpu is the cpu from which =
the
>     RTAS call is invoked, newcpu is the cpu which we're starting
>   * Use cpu_synchronize_state() instead of kvm_cpu_synchronize_state()
>     directly
>   * Remove pointless comment describing what cpu_synchronize_state() do=
es
>   * Use ppc_store_lpcr() instead of directly writing the register field
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr_rtas.c | 66 ++++++++++++++++++++++-----------------------
>  1 file changed, 32 insertions(+), 34 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 0ec5fa4cfe..b251c130cb 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -32,7 +32,7 @@
>  #include "hw/qdev.h"
>  #include "sysemu/device_tree.h"
>  #include "sysemu/cpus.h"
> -#include "sysemu/kvm.h"
> +#include "sysemu/hw_accel.h"
> =20
>  #include "hw/ppc/spapr.h"
>  #include "hw/ppc/spapr_vio.h"
> @@ -45,6 +45,7 @@
>  #include "qemu/cutils.h"
>  #include "trace.h"
>  #include "hw/ppc/fdt.h"
> +#include "target/ppc/mmu-hash64.h"
> =20
>  static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState =
*spapr,
>                                     uint32_t token, uint32_t nargs,
> @@ -140,13 +141,15 @@ static void spapr_cpu_set_endianness(PowerPCCPU *=
cpu)
>      }
>  }
> =20
> -static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
> +static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPRMachineState *spa=
pr,
>                             uint32_t token, uint32_t nargs,
>                             target_ulong args,
>                             uint32_t nret, target_ulong rets)
>  {
>      target_ulong id, start, r3;
> -    PowerPCCPU *cpu;
> +    PowerPCCPU *newcpu;
> +    CPUPPCState *env;
> +    PowerPCCPUClass *pcc;
> =20
>      if (nargs !=3D 3 || nret !=3D 1) {
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> @@ -157,41 +160,37 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAP=
RMachineState *spapr,
>      start =3D rtas_ld(args, 1);
>      r3 =3D rtas_ld(args, 2);
> =20
> -    cpu =3D spapr_find_cpu(id);
> -    if (cpu !=3D NULL) {
> -        CPUState *cs =3D CPU(cpu);
> -        CPUPPCState *env =3D &cpu->env;
> -        PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> +    newcpu =3D spapr_find_cpu(id);
> +    if (!newcpu) {
> +        /* Didn't find a matching cpu */
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> =20
> -        if (!cs->halted) {
> -            rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> -            return;
> -        }
> +    env =3D &newcpu->env;
> +    pcc =3D POWERPC_CPU_GET_CLASS(newcpu);
> =20
> -        /* This will make sure qemu state is up to date with kvm, and
> -         * mark it dirty so our changes get flushed back before the
> -         * new cpu enters */
> -        kvm_cpu_synchronize_state(cs);
> +    if (!CPU(newcpu)->halted) {
> +        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> +        return;
> +    }
> =20
> -        env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
> +    cpu_synchronize_state(CPU(newcpu));
> =20
> -        /* Enable Power-saving mode Exit Cause exceptions for the new =
CPU */
> -        env->spr[SPR_LPCR] |=3D pcc->lpcr_pm;
> +    env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
> +    spapr_cpu_set_endianness(newcpu);
> +    spapr_cpu_update_tb_offset(newcpu);
> +    /* Enable Power-saving mode Exit Cause exceptions for the new CPU =
*/
> +    ppc_store_lpcr(newcpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
> =20
> -        env->nip =3D start;
> -        env->gpr[3] =3D r3;
> -        cs->halted =3D 0;
> -        spapr_cpu_set_endianness(cpu);
> -        spapr_cpu_update_tb_offset(cpu);
> +    env->nip =3D start;
> +    env->gpr[3] =3D r3;
> =20
> -        qemu_cpu_kick(cs);
> +    CPU(newcpu)->halted =3D 0;
> =20
> -        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> -        return;
> -    }
> +    qemu_cpu_kick(CPU(newcpu));
> =20
> -    /* Didn't find a matching cpu */
> -    rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> =20
>  static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> @@ -203,13 +202,12 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPR=
MachineState *spapr,
>      CPUPPCState *env =3D &cpu->env;
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> =20
> -    cs->halted =3D 1;
> -    qemu_cpu_kick(cs);
> -
>      /* Disable Power-saving mode Exit Cause exceptions for the CPU.
>       * This could deliver an interrupt on a dying CPU and crash the
>       * guest */
> -    env->spr[SPR_LPCR] &=3D ~pcc->lpcr_pm;
> +    ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
> +    cs->halted =3D 1;
> +    qemu_cpu_kick(cs);
>  }
> =20
>  static inline int sysparm_st(target_ulong addr, target_ulong len,
>=20
