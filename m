Received: from eggs.gnu.org ([2001:4830:134:3::10]:56611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE8Vq-0002TS-1Q
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE8Vl-0005Zb-Us
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:18:45 -0400
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:50496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fE8Vl-0005ZI-MW
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:18:41 -0400
Received: from player714.ha.ovh.net (unknown [10.109.108.108])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 0D268BC4EA
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 09:18:39 +0200 (CEST)
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
	<20180503062145.17899-4-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9010bc50-8b51-b6c3-6ecf-4a905b036798@kaod.org>
Date: Thu, 3 May 2018 09:18:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180503062145.17899-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/8] spapr: Remove unhelpful helpers from
 rtas_start_cpu()
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
> rtas_start_cpu() calls spapr_cpu_update_tb_offset() and
> spapr_cpu_set_endianness() to initialize certain things in the new cpu'=
s
> state.  This is the only caller of those helpers, and they're each only
> a few lines long, so we might as well just fold them into the caller.
>=20
> In addition, those helpers initialize state on the new cpu to match tha=
t of
> the first cpu.  That will generally work, but might be at least logical=
ly
> incorrect if the first cpu has been set offline by the guest.  So, inst=
ead
> base the state on that of the cpu invoking the RTAS call, which is
> obviously active already.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr_rtas.c | 38 ++++++++++++++------------------------
>  1 file changed, 14 insertions(+), 24 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index b251c130cb..df073447c5 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -120,27 +120,6 @@ static void rtas_query_cpu_stopped_state(PowerPCCP=
U *cpu_,
>      rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>  }
> =20
> -/*
> - * Set the timebase offset of the CPU to that of first CPU.
> - * This helps hotplugged CPU to have the correct timebase offset.
> - */
> -static void spapr_cpu_update_tb_offset(PowerPCCPU *cpu)
> -{
> -    PowerPCCPU *fcpu =3D POWERPC_CPU(first_cpu);
> -
> -    cpu->env.tb_env->tb_offset =3D fcpu->env.tb_env->tb_offset;
> -}
> -
> -static void spapr_cpu_set_endianness(PowerPCCPU *cpu)
> -{
> -    PowerPCCPU *fcpu =3D POWERPC_CPU(first_cpu);
> -    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(fcpu);
> -
> -    if (!pcc->interrupts_big_endian(fcpu)) {
> -        cpu->env.spr[SPR_LPCR] |=3D LPCR_ILE;
> -    }
> -}
> -
>  static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPRMachineState *spa=
pr,
>                             uint32_t token, uint32_t nargs,
>                             target_ulong args,
> @@ -150,6 +129,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, sPA=
PRMachineState *spapr,
>      PowerPCCPU *newcpu;
>      CPUPPCState *env;
>      PowerPCCPUClass *pcc;
> +    target_ulong lpcr;
> =20
>      if (nargs !=3D 3 || nret !=3D 1) {
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> @@ -178,10 +158,20 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, s=
PAPRMachineState *spapr,
>      cpu_synchronize_state(CPU(newcpu));
> =20
>      env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
> -    spapr_cpu_set_endianness(newcpu);
> -    spapr_cpu_update_tb_offset(newcpu);
> +
>      /* Enable Power-saving mode Exit Cause exceptions for the new CPU =
*/
> -    ppc_store_lpcr(newcpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
> +    lpcr =3D env->spr[SPR_LPCR] | pcc->lpcr_pm;
> +    if (!pcc->interrupts_big_endian(callcpu)) {
> +        lpcr |=3D LPCR_ILE;
> +    }
> +    ppc_store_lpcr(newcpu, lpcr);
> +
> +    /*
> +     * Set the timebase offset of the new CPU to that of the invoking
> +     * CPU.  This helps hotplugged CPU to have the correct timebase
> +     * offset.
> +     */
> +    newcpu->env.tb_env->tb_offset =3D callcpu->env.tb_env->tb_offset;
> =20
>      env->nip =3D start;
>      env->gpr[3] =3D r3;
>=20
