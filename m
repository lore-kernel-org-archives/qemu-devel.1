Received: from eggs.gnu.org ([2001:4830:134:3::10]:56296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cHm3b-0006ca-75
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 01:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cHm3Y-0004LW-Lx
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 01:31:51 -0500
Date: Fri, 16 Dec 2016 15:21:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161216042139.GG12146@umbus.fritz.box>
References: <20161215123656.27985-1-alex.bennee@linaro.org>
	<20161215123656.27985-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fCcDWlUEdh43YKr8"
Content-Disposition: inline
In-Reply-To: <20161215123656.27985-2-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qom/cpu: move tlb_flush to
 cpu_common_reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: rth@twiddle.net, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>


--fCcDWlUEdh43YKr8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 15, 2016 at 12:36:55PM +0000, Alex Benn=E9e wrote:
> It is a common thing amongst the various cpu reset functions want to
> flush the SoftMMU's TLB entries. This is done either by calling
> tlb_flush directly or by way of a general memset of the CPU
> structure (sometimes both).
>=20
> This moves the tlb_flush call to the common reset function and
> additionally ensures it is only done for the CONFIG_SOFTMMU case and
> when tcg is enabled.
>=20
> In some target cases we add an empty end_of_reset_fields structure to the
> target vCPU structure so have a clear end point for any memset which
> is resetting value in the structure before CPU_COMMON (where the TLB
> structures are).
>=20
> While this is a nice clean-up in general it is also a precursor for
> changes coming to cputlb for MTTCG where the clearing of entries
> can't be done arbitrarily across vCPUs. Currently the cpu_reset
> function is usually called from the context of another vCPU as the
> architectural power up sequence is run. By using the cputlb API
> functions we can ensure the right behaviour in the future.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

target-ppc portions

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  qom/cpu.c                   | 10 ++++++++--
>  target-arm/cpu.c            |  5 ++---
>  target-arm/cpu.h            |  5 ++++-
>  target-cris/cpu.c           |  3 +--
>  target-cris/cpu.h           |  9 ++++++---
>  target-i386/cpu.c           |  2 --
>  target-i386/cpu.h           |  6 ++++--
>  target-lm32/cpu.c           |  3 +--
>  target-lm32/cpu.h           |  3 +++
>  target-m68k/cpu.c           |  3 +--
>  target-m68k/cpu.h           |  3 +++
>  target-microblaze/cpu.c     |  3 +--
>  target-microblaze/cpu.h     |  3 +++
>  target-mips/cpu.c           |  3 +--
>  target-mips/cpu.h           |  3 +++
>  target-moxie/cpu.c          |  4 +---
>  target-moxie/cpu.h          |  3 +++
>  target-openrisc/cpu.c       |  9 +--------
>  target-openrisc/cpu.h       |  3 +++
>  target-ppc/translate_init.c |  3 ---
>  target-s390x/cpu.c          |  7 ++-----
>  target-s390x/cpu.h          |  5 +++--
>  target-sh4/cpu.c            |  3 +--
>  target-sh4/cpu.h            |  3 +++
>  target-sparc/cpu.c          |  3 +--
>  target-sparc/cpu.h          |  3 +++
>  target-tilegx/cpu.c         |  3 +--
>  target-tilegx/cpu.h         |  3 +++
>  target-tricore/cpu.c        |  2 --
>  29 files changed, 66 insertions(+), 52 deletions(-)
>=20
> diff --git a/qom/cpu.c b/qom/cpu.c
> index 03d9190f8c..61ee0cb88c 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -270,8 +270,14 @@ static void cpu_common_reset(CPUState *cpu)
>      cpu->exception_index =3D -1;
>      cpu->crash_occurred =3D false;
> =20
> -    for (i =3D 0; i < TB_JMP_CACHE_SIZE; ++i) {
> -        atomic_set(&cpu->tb_jmp_cache[i], NULL);
> +    if (tcg_enabled()) {
> +        for (i =3D 0; i < TB_JMP_CACHE_SIZE; ++i) {
> +            atomic_set(&cpu->tb_jmp_cache[i], NULL);
> +        }
> +
> +#ifdef CONFIG_SOFTMMU
> +        tlb_flush(cpu, 0);
> +#endif
>      }
>  }
> =20
> diff --git a/target-arm/cpu.c b/target-arm/cpu.c
> index 99f0dbebb9..fb05d2e4ec 100644
> --- a/target-arm/cpu.c
> +++ b/target-arm/cpu.c
> @@ -122,7 +122,8 @@ static void arm_cpu_reset(CPUState *s)
> =20
>      acc->parent_reset(s);
> =20
> -    memset(env, 0, offsetof(CPUARMState, features));
> +    memset(env, 0, offsetof(CPUARMState, end_reset_fields));
> +
>      g_hash_table_foreach(cpu->cp_regs, cp_reg_reset, cpu);
>      g_hash_table_foreach(cpu->cp_regs, cp_reg_check_reset, cpu);
> =20
> @@ -226,8 +227,6 @@ static void arm_cpu_reset(CPUState *s)
>                                &env->vfp.fp_status);
>      set_float_detect_tininess(float_tininess_before_rounding,
>                                &env->vfp.standard_fp_status);
> -    tlb_flush(s, 1);
> -
>  #ifndef CONFIG_USER_ONLY
>      if (kvm_enabled()) {
>          kvm_arm_reset_vcpu(cpu);
> diff --git a/target-arm/cpu.h b/target-arm/cpu.h
> index ca5c849ed6..53e9d55adf 100644
> --- a/target-arm/cpu.h
> +++ b/target-arm/cpu.h
> @@ -491,9 +491,12 @@ typedef struct CPUARMState {
>      struct CPUBreakpoint *cpu_breakpoint[16];
>      struct CPUWatchpoint *cpu_watchpoint[16];
> =20
> +    /* Fields up to this point are cleared by a CPU reset */
> +    struct {} end_reset_fields;
> +
>      CPU_COMMON
> =20
> -    /* These fields after the common ones so they are preserved on reset=
=2E  */
> +    /* Fields after CPU_COMMON are preserved across CPU reset. */
> =20
>      /* Internal CPU feature flags.  */
>      uint64_t features;
> diff --git a/target-cris/cpu.c b/target-cris/cpu.c
> index 2e9ab9700e..5f766f09d6 100644
> --- a/target-cris/cpu.c
> +++ b/target-cris/cpu.c
> @@ -52,9 +52,8 @@ static void cris_cpu_reset(CPUState *s)
>      ccc->parent_reset(s);
> =20
>      vr =3D env->pregs[PR_VR];
> -    memset(env, 0, offsetof(CPUCRISState, load_info));
> +    memset(env, 0, offsetof(CPUCRISState, end_reset_fields));
>      env->pregs[PR_VR] =3D vr;
> -    tlb_flush(s, 1);
> =20
>  #if defined(CONFIG_USER_ONLY)
>      /* start in user mode with interrupts enabled.  */
> diff --git a/target-cris/cpu.h b/target-cris/cpu.h
> index 43d5f9d1da..920e1c33ba 100644
> --- a/target-cris/cpu.h
> +++ b/target-cris/cpu.h
> @@ -167,10 +167,13 @@ typedef struct CPUCRISState {
>  	 */
>          TLBSet tlbsets[2][4][16];
> =20
> -	CPU_COMMON
> +        /* Fields up to this point are cleared by a CPU reset */
> +        struct {} end_reset_fields;
> =20
> -    /* Members from load_info on are preserved across resets.  */
> -    void *load_info;
> +        CPU_COMMON
> +
> +        /* Members from load_info on are preserved across resets.  */
> +        void *load_info;
>  } CPUCRISState;
> =20
>  /**
> diff --git a/target-i386/cpu.c b/target-i386/cpu.c
> index de1f30eeda..810893952a 100644
> --- a/target-i386/cpu.c
> +++ b/target-i386/cpu.c
> @@ -2815,8 +2815,6 @@ static void x86_cpu_reset(CPUState *s)
> =20
>      memset(env, 0, offsetof(CPUX86State, end_reset_fields));
> =20
> -    tlb_flush(s, 1);
> -
>      env->old_exception =3D -1;
> =20
>      /* init to reset state */
> diff --git a/target-i386/cpu.h b/target-i386/cpu.h
> index c605724022..95ed91d8d1 100644
> --- a/target-i386/cpu.h
> +++ b/target-i386/cpu.h
> @@ -1119,10 +1119,12 @@ typedef struct CPUX86State {
>      uint8_t nmi_injected;
>      uint8_t nmi_pending;
> =20
> +    /* Fields up to this point are cleared by a CPU reset */
> +    struct {} end_reset_fields;
> +
>      CPU_COMMON
> =20
> -    /* Fields from here on are preserved across CPU reset. */
> -    struct {} end_reset_fields;
> +    /* Fields after CPU_COMMON are preserved across CPU reset. */
> =20
>      /* processor features (e.g. for CPUID insn) */
>      /* Minimum level/xlevel/xlevel2, based on CPU model + features */
> diff --git a/target-lm32/cpu.c b/target-lm32/cpu.c
> index 8d939a7779..2b8c36b6d0 100644
> --- a/target-lm32/cpu.c
> +++ b/target-lm32/cpu.c
> @@ -128,10 +128,9 @@ static void lm32_cpu_reset(CPUState *s)
>      lcc->parent_reset(s);
> =20
>      /* reset cpu state */
> -    memset(env, 0, offsetof(CPULM32State, eba));
> +    memset(env, 0, offsetof(CPULM32State, end_reset_fields));
> =20
>      lm32_cpu_init_cfg_reg(cpu);
> -    tlb_flush(s, 1);
>  }
> =20
>  static void lm32_cpu_disas_set_info(CPUState *cpu, disassemble_info *inf=
o)
> diff --git a/target-lm32/cpu.h b/target-lm32/cpu.h
> index d8a3515244..1d972cb26b 100644
> --- a/target-lm32/cpu.h
> +++ b/target-lm32/cpu.h
> @@ -165,6 +165,9 @@ struct CPULM32State {
>      struct CPUBreakpoint *cpu_breakpoint[4];
>      struct CPUWatchpoint *cpu_watchpoint[4];
> =20
> +    /* Fields up to this point are cleared by a CPU reset */
> +    struct {} end_reset_fields;
> +
>      CPU_COMMON
> =20
>      /* Fields from here on are preserved across CPU reset. */
> diff --git a/target-m68k/cpu.c b/target-m68k/cpu.c
> index ba17480098..fa10b6e4cd 100644
> --- a/target-m68k/cpu.c
> +++ b/target-m68k/cpu.c
> @@ -52,7 +52,7 @@ static void m68k_cpu_reset(CPUState *s)
> =20
>      mcc->parent_reset(s);
> =20
> -    memset(env, 0, offsetof(CPUM68KState, features));
> +    memset(env, 0, offsetof(CPUM68KState, end_reset_fields));
>  #if !defined(CONFIG_USER_ONLY)
>      env->sr =3D 0x2700;
>  #endif
> @@ -61,7 +61,6 @@ static void m68k_cpu_reset(CPUState *s)
>      cpu_m68k_set_ccr(env, 0);
>      /* TODO: We should set PC from the interrupt vector.  */
>      env->pc =3D 0;
> -    tlb_flush(s, 1);
>  }
> =20
>  static void m68k_cpu_disas_set_info(CPUState *s, disassemble_info *info)
> diff --git a/target-m68k/cpu.h b/target-m68k/cpu.h
> index 6dfb54eb70..8e7b51b756 100644
> --- a/target-m68k/cpu.h
> +++ b/target-m68k/cpu.h
> @@ -115,6 +115,9 @@ typedef struct CPUM68KState {
> =20
>      uint32_t qregs[MAX_QREGS];
> =20
> +    /* Fields up to this point are cleared by a CPU reset */
> +    struct {} end_reset_fields;
> +
>      CPU_COMMON
> =20
>      /* Fields from here on are preserved across CPU reset. */
> diff --git a/target-microblaze/cpu.c b/target-microblaze/cpu.c
> index 389c7b691e..3d58869716 100644
> --- a/target-microblaze/cpu.c
> +++ b/target-microblaze/cpu.c
> @@ -103,9 +103,8 @@ static void mb_cpu_reset(CPUState *s)
> =20
>      mcc->parent_reset(s);
> =20
> -    memset(env, 0, offsetof(CPUMBState, pvr));
> +    memset(env, 0, offsetof(CPUMBState, end_reset_fields));
>      env->res_addr =3D RES_ADDR_NONE;
> -    tlb_flush(s, 1);
> =20
>      /* Disable stack protector.  */
>      env->shr =3D ~0;
> diff --git a/target-microblaze/cpu.h b/target-microblaze/cpu.h
> index beb75ffd26..bf6963bcb7 100644
> --- a/target-microblaze/cpu.h
> +++ b/target-microblaze/cpu.h
> @@ -267,6 +267,9 @@ struct CPUMBState {
>      struct microblaze_mmu mmu;
>  #endif
> =20
> +    /* Fields up to this point are cleared by a CPU reset */
> +    struct {} end_reset_fields;
> +
>      CPU_COMMON
> =20
>      /* These fields are preserved on reset.  */
> diff --git a/target-mips/cpu.c b/target-mips/cpu.c
> index 65ca607f88..1bb66b7a5a 100644
> --- a/target-mips/cpu.c
> +++ b/target-mips/cpu.c
> @@ -100,8 +100,7 @@ static void mips_cpu_reset(CPUState *s)
> =20
>      mcc->parent_reset(s);
> =20
> -    memset(env, 0, offsetof(CPUMIPSState, mvp));
> -    tlb_flush(s, 1);
> +    memset(env, 0, offsetof(CPUMIPSState, end_reset_fields));
> =20
>      cpu_state_reset(env);
> =20
> diff --git a/target-mips/cpu.h b/target-mips/cpu.h
> index 5182dc74ff..3146a6017d 100644
> --- a/target-mips/cpu.h
> +++ b/target-mips/cpu.h
> @@ -607,6 +607,9 @@ struct CPUMIPSState {
>      uint32_t CP0_TCStatus_rw_bitmask; /* Read/write bits in CP0_TCStatus=
 */
>      int insn_flags; /* Supported instruction set */
> =20
> +    /* Fields up to this point are cleared by a CPU reset */
> +    struct {} end_reset_fields;
> +
>      CPU_COMMON
> =20
>      /* Fields from here on are preserved across CPU reset. */
> diff --git a/target-moxie/cpu.c b/target-moxie/cpu.c
> index b0be4a7551..927b1a1e44 100644
> --- a/target-moxie/cpu.c
> +++ b/target-moxie/cpu.c
> @@ -45,10 +45,8 @@ static void moxie_cpu_reset(CPUState *s)
> =20
>      mcc->parent_reset(s);
> =20
> -    memset(env, 0, sizeof(CPUMoxieState));
> +    memset(env, 0, offsetof(CPUMoxieState, end_reset_fields));
>      env->pc =3D 0x1000;
> -
> -    tlb_flush(s, 1);
>  }
> =20
>  static void moxie_cpu_disas_set_info(CPUState *cpu, disassemble_info *in=
fo)
> diff --git a/target-moxie/cpu.h b/target-moxie/cpu.h
> index 3e880facf4..8991aaef9a 100644
> --- a/target-moxie/cpu.h
> +++ b/target-moxie/cpu.h
> @@ -56,6 +56,9 @@ typedef struct CPUMoxieState {
> =20
>      void *irq[8];
> =20
> +    /* Fields up to this point are cleared by a CPU reset */
> +    struct {} end_reset_fields;
> +
>      CPU_COMMON
> =20
>  } CPUMoxieState;
> diff --git a/target-openrisc/cpu.c b/target-openrisc/cpu.c
> index 698e87bb25..422139d29f 100644
> --- a/target-openrisc/cpu.c
> +++ b/target-openrisc/cpu.c
> @@ -44,14 +44,7 @@ static void openrisc_cpu_reset(CPUState *s)
> =20
>      occ->parent_reset(s);
> =20
> -#ifndef CONFIG_USER_ONLY
> -    memset(&cpu->env, 0, offsetof(CPUOpenRISCState, tlb));
> -#else
> -    memset(&cpu->env, 0, offsetof(CPUOpenRISCState, irq));
> -#endif
> -
> -    tlb_flush(s, 1);
> -    /*tb_flush(&cpu->env);    FIXME: Do we need it?  */
> +    memset(&cpu->env, 0, offsetof(CPUOpenRISCState, end_reset_fields));
> =20
>      cpu->env.pc =3D 0x100;
>      cpu->env.sr =3D SR_FO | SR_SM;
> diff --git a/target-openrisc/cpu.h b/target-openrisc/cpu.h
> index aaf153579a..508ef568b4 100644
> --- a/target-openrisc/cpu.h
> +++ b/target-openrisc/cpu.h
> @@ -300,6 +300,9 @@ typedef struct CPUOpenRISCState {
>                                   in solt so far.  */
>      uint32_t btaken;          /* the SR_F bit */
> =20
> +    /* Fields up to this point are cleared by a CPU reset */
> +    struct {} end_reset_fields;
> +
>      CPU_COMMON
> =20
>      /* Fields from here on are preserved across CPU reset. */
> diff --git a/target-ppc/translate_init.c b/target-ppc/translate_init.c
> index 626e03186c..4ff987226e 100644
> --- a/target-ppc/translate_init.c
> +++ b/target-ppc/translate_init.c
> @@ -10415,9 +10415,6 @@ static void ppc_cpu_reset(CPUState *s)
>          }
>          env->spr[i] =3D spr->default_value;
>      }
> -
> -    /* Flush all TLBs */
> -    tlb_flush(s, 1);
>  }
> =20
>  #ifndef CONFIG_USER_ONLY
> diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
> index 0a39d31237..066dcd17df 100644
> --- a/target-s390x/cpu.c
> +++ b/target-s390x/cpu.c
> @@ -82,7 +82,6 @@ static void s390_cpu_reset(CPUState *s)
>      scc->parent_reset(s);
>      cpu->env.sigp_order =3D 0;
>      s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
> -    tlb_flush(s, 1);
>  }
> =20
>  /* S390CPUClass::initial_reset() */
> @@ -94,7 +93,7 @@ static void s390_cpu_initial_reset(CPUState *s)
> =20
>      s390_cpu_reset(s);
>      /* initial reset does not touch regs,fregs and aregs */
> -    memset(&env->fpc, 0, offsetof(CPUS390XState, cpu_num) -
> +    memset(&env->fpc, 0, offsetof(CPUS390XState, end_reset_fields) -
>                           offsetof(CPUS390XState, fpc));
> =20
>      /* architectured initial values for CR 0 and 14 */
> @@ -118,7 +117,6 @@ static void s390_cpu_initial_reset(CPUState *s)
>      if (kvm_enabled()) {
>          kvm_s390_reset_vcpu(cpu);
>      }
> -    tlb_flush(s, 1);
>  }
> =20
>  /* CPUClass:reset() */
> @@ -133,7 +131,7 @@ static void s390_cpu_full_reset(CPUState *s)
>      cpu->env.sigp_order =3D 0;
>      s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
> =20
> -    memset(env, 0, offsetof(CPUS390XState, cpu_num));
> +    memset(env, 0, offsetof(CPUS390XState, end_reset_fields));
> =20
>      /* architectured initial values for CR 0 and 14 */
>      env->cregs[0] =3D CR0_RESET;
> @@ -156,7 +154,6 @@ static void s390_cpu_full_reset(CPUState *s)
>      if (kvm_enabled()) {
>          kvm_s390_reset_vcpu(cpu);
>      }
> -    tlb_flush(s, 1);
>  }
> =20
>  #if !defined(CONFIG_USER_ONLY)
> diff --git a/target-s390x/cpu.h b/target-s390x/cpu.h
> index fd36a25cf5..058ddad83a 100644
> --- a/target-s390x/cpu.h
> +++ b/target-s390x/cpu.h
> @@ -139,9 +139,10 @@ typedef struct CPUS390XState {
> =20
>      uint8_t riccb[64];
> =20
> -    CPU_COMMON
> +    /* Fields up to this point are cleared by a CPU reset */
> +    struct {} end_reset_fields;
> =20
> -    /* reset does memset(0) up to here */
> +    CPU_COMMON
> =20
>      uint32_t cpu_num;
>      uint32_t machine_type;
> diff --git a/target-sh4/cpu.c b/target-sh4/cpu.c
> index a38f6a6ded..9a481c35dc 100644
> --- a/target-sh4/cpu.c
> +++ b/target-sh4/cpu.c
> @@ -56,8 +56,7 @@ static void superh_cpu_reset(CPUState *s)
> =20
>      scc->parent_reset(s);
> =20
> -    memset(env, 0, offsetof(CPUSH4State, id));
> -    tlb_flush(s, 1);
> +    memset(env, 0, offsetof(CPUSH4State, end_reset_fields));
> =20
>      env->pc =3D 0xA0000000;
>  #if defined(CONFIG_USER_ONLY)
> diff --git a/target-sh4/cpu.h b/target-sh4/cpu.h
> index 478ab55868..cad8989f7e 100644
> --- a/target-sh4/cpu.h
> +++ b/target-sh4/cpu.h
> @@ -175,6 +175,9 @@ typedef struct CPUSH4State {
> =20
>      uint32_t ldst;
> =20
> +    /* Fields up to this point are cleared by a CPU reset */
> +    struct {} end_reset_fields;
> +
>      CPU_COMMON
> =20
>      /* Fields from here on are preserved over CPU reset. */
> diff --git a/target-sparc/cpu.c b/target-sparc/cpu.c
> index 4e07b92fbd..d6583f1c2a 100644
> --- a/target-sparc/cpu.c
> +++ b/target-sparc/cpu.c
> @@ -36,8 +36,7 @@ static void sparc_cpu_reset(CPUState *s)
> =20
>      scc->parent_reset(s);
> =20
> -    memset(env, 0, offsetof(CPUSPARCState, version));
> -    tlb_flush(s, 1);
> +    memset(env, 0, offsetof(CPUSPARCState, end_reset_fields));
>      env->cwp =3D 0;
>  #ifndef TARGET_SPARC64
>      env->wim =3D 1;
> diff --git a/target-sparc/cpu.h b/target-sparc/cpu.h
> index 5fb0ed1aad..601c018a05 100644
> --- a/target-sparc/cpu.h
> +++ b/target-sparc/cpu.h
> @@ -419,6 +419,9 @@ struct CPUSPARCState {
>      /* NOTE: we allow 8 more registers to handle wrapping */
>      target_ulong regbase[MAX_NWINDOWS * 16 + 8];
> =20
> +    /* Fields up to this point are cleared by a CPU reset */
> +    struct {} end_reset_fields;
> +
>      CPU_COMMON
> =20
>      /* Fields from here on are preserved across CPU reset. */
> diff --git a/target-tilegx/cpu.c b/target-tilegx/cpu.c
> index 454793f94a..d90e38e88c 100644
> --- a/target-tilegx/cpu.c
> +++ b/target-tilegx/cpu.c
> @@ -84,8 +84,7 @@ static void tilegx_cpu_reset(CPUState *s)
> =20
>      tcc->parent_reset(s);
> =20
> -    memset(env, 0, sizeof(CPUTLGState));
> -    tlb_flush(s, 1);
> +    memset(env, 0, offsetof(CPUTLGState, end_reset_fields));
>  }
> =20
>  static void tilegx_cpu_realizefn(DeviceState *dev, Error **errp)
> diff --git a/target-tilegx/cpu.h b/target-tilegx/cpu.h
> index 1735427233..f32be49f65 100644
> --- a/target-tilegx/cpu.h
> +++ b/target-tilegx/cpu.h
> @@ -97,6 +97,9 @@ typedef struct CPUTLGState {
>      uint32_t sigcode;                  /* Signal code */
>  #endif
> =20
> +    /* Fields up to this point are cleared by a CPU reset */
> +    struct {} end_reset_fields;
> +
>      CPU_COMMON
>  } CPUTLGState;
> =20
> diff --git a/target-tricore/cpu.c b/target-tricore/cpu.c
> index 785b76bd3a..08f50e2ba7 100644
> --- a/target-tricore/cpu.c
> +++ b/target-tricore/cpu.c
> @@ -53,8 +53,6 @@ static void tricore_cpu_reset(CPUState *s)
> =20
>      tcc->parent_reset(s);
> =20
> -    tlb_flush(s, 1);
> -
>      cpu_state_reset(env);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fCcDWlUEdh43YKr8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYU2vSAAoJEGw4ysog2bOSdZ0P/Ry3Mf4goCwnqO2OBkvpV8z3
h2moIOGw1E6RNYjv0g68vBYDxb6UY7Mv4HjEeBWIWcidEQ2YeTWAxb/01TwkYlbT
UW+HzYLfbK2fhyDvGKfExukAb0VwJ5DYFCOIKmQEFnin+6cmPJTS6mzPWz4od5Kd
X3HxPP4XZNlpx3FzajnCf4MKhJ7T4wlcux4rHaRSIh1UHEGm8J+UR6iXW2j7wqgI
Zhbh/W4p4z8IzWUAOPuAyiO4+OGaSSdnH/+c7Hs8KKJRROMs/ZRhtxrbhMbWR1O5
rhDcPY1SkoV94u2YFwXi4F90Uxnm8dB24YklvfoRLp2tzCDStLrqFqch4e3LSAbh
IIDrc5s3byTekz/0L7lvyXvES6GX8ANyrN1xN9PXtQBxgMACPTBrj6KJnTMnyBwu
j4RELAwN+SIUe/jax7sxcbtn1ndjvwD9xhJbZz4HRUb1PUfowSMEbfL9McwpxV3u
y+oTSOQHA0n22Xx3oxd7UhYN2ZZRrHGsXxP29uQ9xelfey+icgxXNYlH1x344zuv
zUdYSUS4GiGBO1FSzAvOTiTC7z0lizPHcw6KYE5H60oI4tfSmdx3LEOBJ5XB8Y8X
B3fNThmUXhIlwMHgp0GTnVQkr8dhtkwqzDdaB2nLzCmInbeNIQ1rkXUpvi+yeY79
1AsTxIlYt5nUVanrK2hz
=BfWh
-----END PGP SIGNATURE-----

--fCcDWlUEdh43YKr8--
