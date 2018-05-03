Received: from eggs.gnu.org ([2001:4830:134:3::10]:34972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE8xe-0007QI-3P
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE8xb-000373-F0
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:47:30 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:53041)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fE8xb-00036Y-8J
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:47:27 -0400
Received: from player714.ha.ovh.net (unknown [10.109.122.48])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 7F5B214F15
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 09:47:25 +0200 (CEST)
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
	<20180503062145.17899-9-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0d815d7c-42de-c89e-4481-21b32e04ed7c@kaod.org>
Date: Thu, 3 May 2018 09:47:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180503062145.17899-9-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 8/8] spapr: Clean up handling of LPCR
 power-saving exit bits
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
> To prevent spurious wakeups on cpus that are supposed to be disabled, w=
e
> need to clear the LPCR bits which control certain wakeup events.
> spapr_cpu_reset() has separate cases here for boot and non-boot (initia=
lly
> inactive) cpus.  rtas_start_cpu() then turns the LPCR bits on when the
> non-boot cpus are activated.
>=20
> But explicit checks against first_cpu are not how we usually do things:
> instead spapr_cpu_reset() generally sets things up for non-boot (inacti=
ve)
> cpus, then spapr_machine_reset() and/or rtas_start_cpu() override as
> necessary.
>=20
> So, do that instead.  Because the LPCR activation is identical for boot
> cpus and non-boot cpus just activated with rtas_start_cpu() we can put =
the
> code common in spapr_cpu_set_entry_state().

This is much nicer.

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

and for the patchset :

Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>

under KVM & TCG with cpu hotplug and unplug.


There is still a spapr_cpu_reset() call under spapr_cpu_init().
Is that on purpose ?=20

Thanks,

C.

> ---
>  hw/ppc/spapr_cpu_core.c | 22 +++++++---------------
>  hw/ppc/spapr_rtas.c     |  2 +-
>  2 files changed, 8 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index a52ddade5e..f3e9b879b2 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -54,28 +54,17 @@ static void spapr_cpu_reset(void *opaque)
>       * Clearing VPM0 will also cause us to use RMOR in mmu-hash64.c fo=
r
>       * real mode accesses, which thankfully defaults to 0 and isn't
>       * accessible in guest mode.
> +     *
> +     * Disable Power-saving mode Exit Cause exceptions for the CPU, so
> +     * we don't get spurious wakups before an RTAS start-cpu call.
>       */
> -    lpcr &=3D ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV);
> +    lpcr &=3D ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV | pcc->lpc=
r_pm);
>      lpcr |=3D LPCR_LPES0 | LPCR_LPES1;
> =20
>      /* Set RMLS to the max (ie, 16G) */
>      lpcr &=3D ~LPCR_RMLS;
>      lpcr |=3D 1ull << LPCR_RMLS_SHIFT;
> =20
> -    /* Only enable Power-saving mode Exit Cause exceptions on the boot
> -     * CPU. The RTAS command start-cpu will enable them on secondaries=
.
> -     */
> -    if (cs =3D=3D first_cpu) {
> -        lpcr |=3D pcc->lpcr_pm;
> -    }
> -
> -    /* Disable Power-saving mode Exit Cause exceptions for the CPU.
> -     * This can cause issues when rebooting the guest if a secondary
> -     * is awaken */
> -    if (cs !=3D first_cpu) {
> -        lpcr &=3D ~pcc->lpcr_pm;
> -    }
> -
>      ppc_store_lpcr(cpu, lpcr);
> =20
>      /* Set a full AMOR so guest can use the AMR as it sees fit */
> @@ -84,11 +73,14 @@ static void spapr_cpu_reset(void *opaque)
> =20
>  void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, targ=
et_ulong r3)
>  {
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>      CPUPPCState *env =3D &cpu->env;
> =20
>      env->nip =3D nip;
>      env->gpr[3] =3D r3;
>      CPU(cpu)->halted =3D 0;
> +    /* Enable Power-saving mode Exit Cause exceptions */
> +    ppc_store_lpcr(cpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
>  }
> =20
>  static void spapr_cpu_destroy(PowerPCCPU *cpu)
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 652233bdf1..7f9738daed 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -162,7 +162,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, sPA=
PRMachineState *spapr,
>      env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
> =20
>      /* Enable Power-saving mode Exit Cause exceptions for the new CPU =
*/
> -    lpcr =3D env->spr[SPR_LPCR] | pcc->lpcr_pm;
> +    lpcr =3D env->spr[SPR_LPCR];
>      if (!pcc->interrupts_big_endian(callcpu)) {
>          lpcr |=3D LPCR_ILE;
>      }
>=20
