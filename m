Received: from eggs.gnu.org ([2001:4830:134:3::10]:59380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE8hE-00010m-Ql
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE8hB-00035c-Ec
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:30:32 -0400
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:55420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fE8hB-00033t-4E
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:30:29 -0400
Received: from player714.ha.ovh.net (unknown [10.109.120.40])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id A79AABC86E
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 09:30:27 +0200 (CEST)
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
	<20180503062145.17899-8-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2f9a024c-a5d9-8a9c-b086-15255fcebc85@kaod.org>
Date: Thu, 3 May 2018 09:30:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180503062145.17899-8-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/8] spapr: Move PAPR mode cpu setup fully
 to spapr code
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
> cpu_ppc_set_papr() does several things:
>     1) it sets up the virtual hypervisor interface
>     2) it prevents the cpu from ever entering hypervisor mode
>     3) it tells KVM that we're emulating a cpu in PAPR mode
> and 4) it configures the LPCR and AMOR (hypervisor privileged registers=
)
>        so that TCG will behave correctly for PAPR guests, without
>        attempting to emulate the cpu in hypervisor mode
>=20
> (1) & (2) make sense for any virtual hypervisor (if another one ever
> exists).
>=20
> (3) belongs more properly in the machine type specific to a PAPR guest,=
 so
> move it to spapr_cpu_init().  While we're at it, remove an ugly test on
> kvm_enabled() by making kvmppc_set_papr() a safe no-op on non-KVM.
>=20
> (4) also belongs more properly in the machine type specific code.  (4) =
is
> done by mangling the default values of the SPRs, so that they will be s=
et
> correctly at reset time.  Manipulating usually-static parameters of the=
 cpu
> model like this is kind of ugly, especially since the values used reall=
y
> have more to do with the platform than the cpu.
>=20
> The spapr code already has places for PAPR specific initializations of
> register state in spapr_cpu_reset(), so move this handling there.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr_cpu_core.c     | 36 ++++++++++++++++++++++++++++---
>  target/ppc/cpu.h            |  2 +-
>  target/ppc/kvm.c            |  4 ++++
>  target/ppc/translate_init.c | 42 +------------------------------------
>  4 files changed, 39 insertions(+), 45 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index a98c7b04c6..a52ddade5e 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -28,6 +28,7 @@ static void spapr_cpu_reset(void *opaque)
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> +    target_ulong lpcr;
> =20
>      cpu_reset(cs);
> =20
> @@ -43,13 +44,42 @@ static void spapr_cpu_reset(void *opaque)
> =20
>      env->spr[SPR_HIOR] =3D 0;
> =20
> +    lpcr =3D env->spr[SPR_LPCR];
> +
> +    /* Set emulated LPCR to not send interrupts to hypervisor. Note th=
at
> +     * under KVM, the actual HW LPCR will be set differently by KVM it=
self,
> +     * the settings below ensure proper operations with TCG in absence=
 of
> +     * a real hypervisor.
> +     *
> +     * Clearing VPM0 will also cause us to use RMOR in mmu-hash64.c fo=
r
> +     * real mode accesses, which thankfully defaults to 0 and isn't
> +     * accessible in guest mode.
> +     */
> +    lpcr &=3D ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV);
> +    lpcr |=3D LPCR_LPES0 | LPCR_LPES1;
> +
> +    /* Set RMLS to the max (ie, 16G) */
> +    lpcr &=3D ~LPCR_RMLS;
> +    lpcr |=3D 1ull << LPCR_RMLS_SHIFT;
> +
> +    /* Only enable Power-saving mode Exit Cause exceptions on the boot
> +     * CPU. The RTAS command start-cpu will enable them on secondaries=
.
> +     */
> +    if (cs =3D=3D first_cpu) {
> +        lpcr |=3D pcc->lpcr_pm;
> +    }
> +
>      /* Disable Power-saving mode Exit Cause exceptions for the CPU.
>       * This can cause issues when rebooting the guest if a secondary
>       * is awaken */
>      if (cs !=3D first_cpu) {
> -        env->spr[SPR_LPCR] &=3D ~pcc->lpcr_pm;
> +        lpcr &=3D ~pcc->lpcr_pm;
>      }
> =20
> +    ppc_store_lpcr(cpu, lpcr);
> +
> +    /* Set a full AMOR so guest can use the AMR as it sees fit */
> +    env->spr[SPR_AMOR] =3D 0xffffffffffffffffull;
>  }
> =20
>  void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, targ=
et_ulong r3)
> @@ -74,8 +104,8 @@ static void spapr_cpu_init(sPAPRMachineState *spapr,=
 PowerPCCPU *cpu,
>      /* Set time-base frequency to 512 MHz */
>      cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
> =20
> -    /* Enable PAPR mode in TCG or KVM */
> -    cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> +    cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> +    kvmppc_set_papr(cpu);
> =20
>      qemu_register_reset(spapr_cpu_reset, cpu);
>      spapr_cpu_reset(cpu);
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 2f619f39d3..7ccd2f460e 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1332,7 +1332,7 @@ void store_booke_tcr (CPUPPCState *env, target_ul=
ong val);
>  void store_booke_tsr (CPUPPCState *env, target_ulong val);
>  void ppc_tlb_invalidate_all (CPUPPCState *env);
>  void ppc_tlb_invalidate_one (CPUPPCState *env, target_ulong addr);
> -void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
> +void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
>  #endif
>  #endif
> =20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 6de59c5b21..28311a98e0 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2090,6 +2090,10 @@ void kvmppc_set_papr(PowerPCCPU *cpu)
>      CPUState *cs =3D CPU(cpu);
>      int ret;
> =20
> +    if (!kvm_enabled()) {
> +        return;
> +    }
> +
>      ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_PAPR, 0);
>      if (ret) {
>          error_report("This vCPU type or KVM version does not support P=
APR");
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index d92a84c622..118631efbe 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8882,13 +8882,9 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *da=
ta)
>  }
> =20
>  #if !defined(CONFIG_USER_ONLY)
> -void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
> +void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
>  {
> -    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>      CPUPPCState *env =3D &cpu->env;
> -    ppc_spr_t *lpcr =3D &env->spr_cb[SPR_LPCR];
> -    ppc_spr_t *amor =3D &env->spr_cb[SPR_AMOR];
> -    CPUState *cs =3D CPU(cpu);
> =20
>      cpu->vhyp =3D vhyp;
> =20
> @@ -8897,42 +8893,6 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtua=
lHypervisor *vhyp)
>       * hypervisor mode itself
>       */
>      env->msr_mask &=3D ~MSR_HVB;
> -
> -    /* Set emulated LPCR to not send interrupts to hypervisor. Note th=
at
> -     * under KVM, the actual HW LPCR will be set differently by KVM it=
self,
> -     * the settings below ensure proper operations with TCG in absence=
 of
> -     * a real hypervisor.
> -     *
> -     * Clearing VPM0 will also cause us to use RMOR in mmu-hash64.c fo=
r
> -     * real mode accesses, which thankfully defaults to 0 and isn't
> -     * accessible in guest mode.
> -     */
> -    lpcr->default_value &=3D ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR=
_KBV);
> -    lpcr->default_value |=3D LPCR_LPES0 | LPCR_LPES1;
> -
> -    /* Set RMLS to the max (ie, 16G) */
> -    lpcr->default_value &=3D ~LPCR_RMLS;
> -    lpcr->default_value |=3D 1ull << LPCR_RMLS_SHIFT;
> -
> -    /* Only enable Power-saving mode Exit Cause exceptions on the boot
> -     * CPU. The RTAS command start-cpu will enable them on secondaries=
.
> -     */
> -    if (cs =3D=3D first_cpu) {
> -        lpcr->default_value |=3D pcc->lpcr_pm;
> -    }
> -
> -    /* We should be followed by a CPU reset but update the active valu=
e
> -     * just in case...
> -     */
> -    ppc_store_lpcr(cpu, lpcr->default_value);
> -
> -    /* Set a full AMOR so guest can use the AMR as it sees fit */
> -    env->spr[SPR_AMOR] =3D amor->default_value =3D 0xffffffffffffffffu=
ll;
> -
> -    /* Tell KVM that we're in PAPR mode */
> -    if (kvm_enabled()) {
> -        kvmppc_set_papr(cpu);
> -    }
>  }
> =20
>  #endif /* !defined(CONFIG_USER_ONLY) */
>=20
