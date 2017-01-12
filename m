Received: from eggs.gnu.org ([2001:4830:134:3::10]:34858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRp0M-0008SS-M8
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRp0I-00023L-I9
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:42:02 -0500
Date: Fri, 13 Jan 2017 10:34:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170112233437.GG13656@umbus.fritz.box>
References: <20170112154731.1028-1-alex.bennee@linaro.org>
	<20170112154731.1028-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bO4vSxwwZtUjUWHo"
Content-Disposition: inline
In-Reply-To: <20170112154731.1028-4-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] cputlb: drop flush_global flag from
 tlb_flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Jia Liu <proljc@gmail.com>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>


--bO4vSxwwZtUjUWHo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2017 at 03:47:31PM +0000, Alex Benn=E9e wrote:
> We have never has the concept of global TLB entries which would avoid
> the flush so we never actually use this flag. Drop it and make clear
> that tlb_flush is the sledge-hammer it has always been.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

For ppc:

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  cputlb.c                           | 21 ++++++---------------
>  exec.c                             |  4 ++--
>  hw/sh4/sh7750.c                    |  2 +-
>  include/exec/exec-all.h            | 14 ++++++--------
>  target/alpha/cpu.c                 |  2 +-
>  target/alpha/sys_helper.c          |  2 +-
>  target/arm/helper.c                | 26 +++++++++++++-------------
>  target/i386/fpu_helper.c           |  2 +-
>  target/i386/helper.c               |  8 ++++----
>  target/i386/machine.c              |  2 +-
>  target/i386/misc_helper.c          |  2 +-
>  target/i386/svm_helper.c           |  2 +-
>  target/microblaze/mmu.c            |  2 +-
>  target/mips/cpu.h                  |  2 +-
>  target/mips/helper.c               |  6 +++---
>  target/mips/op_helper.c            |  8 ++++----
>  target/openrisc/interrupt.c        |  2 +-
>  target/openrisc/interrupt_helper.c |  2 +-
>  target/openrisc/sys_helper.c       |  2 +-
>  target/ppc/helper_regs.h           |  4 ++--
>  target/ppc/misc_helper.c           |  4 ++--
>  target/ppc/mmu_helper.c            | 32 ++++++++++++++++----------------
>  target/s390x/gdbstub.c             |  2 +-
>  target/s390x/mem_helper.c          |  8 ++++----
>  target/sh4/helper.c                |  2 +-
>  target/sparc/ldst_helper.c         | 12 ++++++------
>  target/unicore32/cpu.c             |  2 +-
>  target/unicore32/helper.c          |  2 +-
>  target/xtensa/op_helper.c          |  2 +-
>  29 files changed, 85 insertions(+), 96 deletions(-)
>=20
> diff --git a/cputlb.c b/cputlb.c
> index 813279f3bc..6c39927455 100644
> --- a/cputlb.c
> +++ b/cputlb.c
> @@ -60,24 +60,15 @@
>  /* statistics */
>  int tlb_flush_count;
> =20
> -/* NOTE:
> - * If flush_global is true (the usual case), flush all tlb entries.
> - * If flush_global is false, flush (at least) all tlb entries not
> - * marked global.
> - *
> - * Since QEMU doesn't currently implement a global/not-global flag
> - * for tlb entries, at the moment tlb_flush() will also flush all
> - * tlb entries in the flush_global =3D=3D false case. This is OK because
> - * CPU architectures generally permit an implementation to drop
> - * entries from the TLB at any time, so flushing more entries than
> - * required is only an efficiency issue, not a correctness issue.
> +/* This is OK because CPU architectures generally permit an
> + * implementation to drop entries from the TLB at any time, so
> + * flushing more entries than required is only an efficiency issue,
> + * not a correctness issue.
>   */
> -void tlb_flush(CPUState *cpu, int flush_global)
> +void tlb_flush(CPUState *cpu)
>  {
>      CPUArchState *env =3D cpu->env_ptr;
> =20
> -    tlb_debug("(%d)\n", flush_global);
> -
>      memset(env->tlb_table, -1, sizeof(env->tlb_table));
>      memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
>      memset(cpu->tb_jmp_cache, 0, sizeof(cpu->tb_jmp_cache));
> @@ -144,7 +135,7 @@ void tlb_flush_page(CPUState *cpu, target_ulong addr)
>                    TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
>                    env->tlb_flush_addr, env->tlb_flush_mask);
> =20
> -        tlb_flush(cpu, 1);
> +        tlb_flush(cpu);
>          return;
>      }
> =20
> diff --git a/exec.c b/exec.c
> index 47835c1dc1..401a9127c2 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -544,7 +544,7 @@ static int cpu_common_post_load(void *opaque, int ver=
sion_id)
>      /* 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
>         version_id is increased. */
>      cpu->interrupt_request &=3D ~0x01;
> -    tlb_flush(cpu, 1);
> +    tlb_flush(cpu);
> =20
>      return 0;
>  }
> @@ -2426,7 +2426,7 @@ static void tcg_commit(MemoryListener *listener)
>       */
>      d =3D atomic_rcu_read(&cpuas->as->dispatch);
>      atomic_rcu_set(&cpuas->memory_dispatch, d);
> -    tlb_flush(cpuas->cpu, 1);
> +    tlb_flush(cpuas->cpu);
>  }
> =20
>  void address_space_init_dispatch(AddressSpace *as)
> diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
> index 3132d559d7..166e4bd947 100644
> --- a/hw/sh4/sh7750.c
> +++ b/hw/sh4/sh7750.c
> @@ -417,7 +417,7 @@ static void sh7750_mem_writel(void *opaque, hwaddr ad=
dr,
>      case SH7750_PTEH_A7:
>          /* If asid changes, clear all registered tlb entries. */
>          if ((s->cpu->env.pteh & 0xff) !=3D (mem_value & 0xff)) {
> -            tlb_flush(CPU(s->cpu), 1);
> +            tlb_flush(CPU(s->cpu));
>          }
>          s->cpu->env.pteh =3D mem_value;
>          return;
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index a8c13cee66..bbc9478a50 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -95,15 +95,13 @@ void tlb_flush_page(CPUState *cpu, target_ulong addr);
>  /**
>   * tlb_flush:
>   * @cpu: CPU whose TLB should be flushed
> - * @flush_global: ignored
>   *
> - * Flush the entire TLB for the specified CPU.
> - * The flush_global flag is in theory an indicator of whether the whole
> - * TLB should be flushed, or only those entries not marked global.
> - * In practice QEMU does not implement any global/not global flag for
> - * TLB entries, and the argument is ignored.
> + * Flush the entire TLB for the specified CPU. Most CPU architectures
> + * allow the implementation to drop entries from the TLB at any time
> + * so this is generally safe. If more selective flushing is required
> + * use one of the other functions for efficiency.
>   */
> -void tlb_flush(CPUState *cpu, int flush_global);
> +void tlb_flush(CPUState *cpu);
>  /**
>   * tlb_flush_page_by_mmuidx:
>   * @cpu: CPU whose TLB should be flushed
> @@ -165,7 +163,7 @@ static inline void tlb_flush_page(CPUState *cpu, targ=
et_ulong addr)
>  {
>  }
> =20
> -static inline void tlb_flush(CPUState *cpu, int flush_global)
> +static inline void tlb_flush(CPUState *cpu)
>  {
>  }
> =20
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index 30d77ce71c..b4f97983e5 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -273,7 +273,7 @@ static void alpha_cpu_initfn(Object *obj)
>      CPUAlphaState *env =3D &cpu->env;
> =20
>      cs->env_ptr =3D env;
> -    tlb_flush(cs, 1);
> +    tlb_flush(cs);
> =20
>      alpha_translate_init();
> =20
> diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
> index bec1e178be..652195de6f 100644
> --- a/target/alpha/sys_helper.c
> +++ b/target/alpha/sys_helper.c
> @@ -44,7 +44,7 @@ uint64_t helper_load_pcc(CPUAlphaState *env)
>  #ifndef CONFIG_USER_ONLY
>  void helper_tbia(CPUAlphaState *env)
>  {
> -    tlb_flush(CPU(alpha_env_get_cpu(env)), 1);
> +    tlb_flush(CPU(alpha_env_get_cpu(env)));
>  }
> =20
>  void helper_tbis(CPUAlphaState *env, uint64_t p)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 8dcabbf576..b1f16f4193 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -464,7 +464,7 @@ static void dacr_write(CPUARMState *env, const ARMCPR=
egInfo *ri, uint64_t value)
>      ARMCPU *cpu =3D arm_env_get_cpu(env);
> =20
>      raw_write(env, ri, value);
> -    tlb_flush(CPU(cpu), 1); /* Flush TLB as domain not tracked in TLB */
> +    tlb_flush(CPU(cpu)); /* Flush TLB as domain not tracked in TLB */
>  }
> =20
>  static void fcse_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_=
t value)
> @@ -475,7 +475,7 @@ static void fcse_write(CPUARMState *env, const ARMCPR=
egInfo *ri, uint64_t value)
>          /* Unlike real hardware the qemu TLB uses virtual addresses,
>           * not modified virtual addresses, so this causes a TLB flush.
>           */
> -        tlb_flush(CPU(cpu), 1);
> +        tlb_flush(CPU(cpu));
>          raw_write(env, ri, value);
>      }
>  }
> @@ -491,7 +491,7 @@ static void contextidr_write(CPUARMState *env, const =
ARMCPRegInfo *ri,
>           * format) this register includes the ASID, so do a TLB flush.
>           * For PMSA it is purely a process ID and no action is needed.
>           */
> -        tlb_flush(CPU(cpu), 1);
> +        tlb_flush(CPU(cpu));
>      }
>      raw_write(env, ri, value);
>  }
> @@ -502,7 +502,7 @@ static void tlbiall_write(CPUARMState *env, const ARM=
CPRegInfo *ri,
>      /* Invalidate all (TLBIALL) */
>      ARMCPU *cpu =3D arm_env_get_cpu(env);
> =20
> -    tlb_flush(CPU(cpu), 1);
> +    tlb_flush(CPU(cpu));
>  }
> =20
>  static void tlbimva_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -520,7 +520,7 @@ static void tlbiasid_write(CPUARMState *env, const AR=
MCPRegInfo *ri,
>      /* Invalidate by ASID (TLBIASID) */
>      ARMCPU *cpu =3D arm_env_get_cpu(env);
> =20
> -    tlb_flush(CPU(cpu), value =3D=3D 0);
> +    tlb_flush(CPU(cpu));
>  }
> =20
>  static void tlbimvaa_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -539,7 +539,7 @@ static void tlbiall_is_write(CPUARMState *env, const =
ARMCPRegInfo *ri,
>      CPUState *other_cs;
> =20
>      CPU_FOREACH(other_cs) {
> -        tlb_flush(other_cs, 1);
> +        tlb_flush(other_cs);
>      }
>  }
> =20
> @@ -549,7 +549,7 @@ static void tlbiasid_is_write(CPUARMState *env, const=
 ARMCPRegInfo *ri,
>      CPUState *other_cs;
> =20
>      CPU_FOREACH(other_cs) {
> -        tlb_flush(other_cs, value =3D=3D 0);
> +        tlb_flush(other_cs);
>      }
>  }
> =20
> @@ -2304,7 +2304,7 @@ static void pmsav7_write(CPUARMState *env, const AR=
MCPRegInfo *ri,
>      }
> =20
>      u32p +=3D env->cp15.c6_rgnr;
> -    tlb_flush(CPU(cpu), 1); /* Mappings may have changed - purge! */
> +    tlb_flush(CPU(cpu)); /* Mappings may have changed - purge! */
>      *u32p =3D value;
>  }
> =20
> @@ -2449,7 +2449,7 @@ static void vmsa_ttbcr_write(CPUARMState *env, cons=
t ARMCPRegInfo *ri,
>          /* With LPAE the TTBCR could result in a change of ASID
>           * via the TTBCR.A1 bit, so do a TLB flush.
>           */
> -        tlb_flush(CPU(cpu), 1);
> +        tlb_flush(CPU(cpu));
>      }
>      vmsa_ttbcr_raw_write(env, ri, value);
>  }
> @@ -2473,7 +2473,7 @@ static void vmsa_tcr_el1_write(CPUARMState *env, co=
nst ARMCPRegInfo *ri,
>      TCR *tcr =3D raw_ptr(env, ri);
> =20
>      /* For AArch64 the A1 bit could result in a change of ASID, so TLB f=
lush. */
> -    tlb_flush(CPU(cpu), 1);
> +    tlb_flush(CPU(cpu));
>      tcr->raw_tcr =3D value;
>  }
> =20
> @@ -2486,7 +2486,7 @@ static void vmsa_ttbr_write(CPUARMState *env, const=
 ARMCPRegInfo *ri,
>      if (cpreg_field_is_64bit(ri)) {
>          ARMCPU *cpu =3D arm_env_get_cpu(env);
> =20
> -        tlb_flush(CPU(cpu), 1);
> +        tlb_flush(CPU(cpu));
>      }
>      raw_write(env, ri, value);
>  }
> @@ -3154,7 +3154,7 @@ static void sctlr_write(CPUARMState *env, const ARM=
CPRegInfo *ri,
>      raw_write(env, ri, value);
>      /* ??? Lots of these bits are not implemented.  */
>      /* This may enable/disable the MMU, so do a TLB flush.  */
> -    tlb_flush(CPU(cpu), 1);
> +    tlb_flush(CPU(cpu));
>  }
> =20
>  static CPAccessResult fpexc32_access(CPUARMState *env, const ARMCPRegInf=
o *ri,
> @@ -3622,7 +3622,7 @@ static void hcr_write(CPUARMState *env, const ARMCP=
RegInfo *ri, uint64_t value)
>       * HCR_DC Disables stage1 and enables stage2 translation
>       */
>      if ((raw_read(env, ri) ^ value) & (HCR_VM | HCR_PTW | HCR_DC)) {
> -        tlb_flush(CPU(cpu), 1);
> +        tlb_flush(CPU(cpu));
>      }
>      raw_write(env, ri, value);
>  }
> diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
> index 2049a8c01d..66474ad98e 100644
> --- a/target/i386/fpu_helper.c
> +++ b/target/i386/fpu_helper.c
> @@ -1465,7 +1465,7 @@ void helper_xrstor(CPUX86State *env, target_ulong p=
tr, uint64_t rfbm)
>          }
>          if (env->pkru !=3D old_pkru) {
>              CPUState *cs =3D CPU(x86_env_get_cpu(env));
> -            tlb_flush(cs, 1);
> +            tlb_flush(cs);
>          }
>      }
>  }
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index 43e87ddba0..c86272efab 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -586,7 +586,7 @@ void x86_cpu_set_a20(X86CPU *cpu, int a20_state)
> =20
>          /* when a20 is changed, all the MMU mappings are invalid, so
>             we must flush everything */
> -        tlb_flush(cs, 1);
> +        tlb_flush(cs);
>          env->a20_mask =3D ~(1 << 20) | (a20_state << 20);
>      }
>  }
> @@ -599,7 +599,7 @@ void cpu_x86_update_cr0(CPUX86State *env, uint32_t ne=
w_cr0)
>      qemu_log_mask(CPU_LOG_MMU, "CR0 update: CR0=3D0x%08x\n", new_cr0);
>      if ((new_cr0 & (CR0_PG_MASK | CR0_WP_MASK | CR0_PE_MASK)) !=3D
>          (env->cr[0] & (CR0_PG_MASK | CR0_WP_MASK | CR0_PE_MASK))) {
> -        tlb_flush(CPU(cpu), 1);
> +        tlb_flush(CPU(cpu));
>      }
> =20
>  #ifdef TARGET_X86_64
> @@ -641,7 +641,7 @@ void cpu_x86_update_cr3(CPUX86State *env, target_ulon=
g new_cr3)
>      if (env->cr[0] & CR0_PG_MASK) {
>          qemu_log_mask(CPU_LOG_MMU,
>                          "CR3 update: CR3=3D" TARGET_FMT_lx "\n", new_cr3=
);
> -        tlb_flush(CPU(cpu), 0);
> +        tlb_flush(CPU(cpu));
>      }
>  }
> =20
> @@ -656,7 +656,7 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t ne=
w_cr4)
>      if ((new_cr4 ^ env->cr[4]) &
>          (CR4_PGE_MASK | CR4_PAE_MASK | CR4_PSE_MASK |
>           CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_LA57_MASK)) {
> -        tlb_flush(CPU(cpu), 1);
> +        tlb_flush(CPU(cpu));
>      }
> =20
>      /* Clear bits we're going to recompute.  */
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 760f82b6c7..e002b4fc6d 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -387,7 +387,7 @@ static int cpu_post_load(void *opaque, int version_id)
>          env->dr[7] =3D dr7 & ~(DR7_GLOBAL_BP_MASK | DR7_LOCAL_BP_MASK);
>          cpu_x86_update_dr7(env, dr7);
>      }
> -    tlb_flush(cs, 1);
> +    tlb_flush(cs);
> =20
>      if (tcg_enabled()) {
>          cpu_smm_update(cpu);
> diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
> index 3f666b4b87..5029efef47 100644
> --- a/target/i386/misc_helper.c
> +++ b/target/i386/misc_helper.c
> @@ -635,5 +635,5 @@ void helper_wrpkru(CPUX86State *env, uint32_t ecx, ui=
nt64_t val)
>      }
> =20
>      env->pkru =3D val;
> -    tlb_flush(cs, 1);
> +    tlb_flush(cs);
>  }
> diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
> index 782b3f12f0..210f6aa7b5 100644
> --- a/target/i386/svm_helper.c
> +++ b/target/i386/svm_helper.c
> @@ -289,7 +289,7 @@ void helper_vmrun(CPUX86State *env, int aflag, int ne=
xt_eip_addend)
>          break;
>      case TLB_CONTROL_FLUSH_ALL_ASID:
>          /* FIXME: this is not 100% correct but should work for now */
> -        tlb_flush(cs, 1);
> +        tlb_flush(cs);
>          break;
>      }
> =20
> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> index a22a496ebb..a0f06758f8 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -255,7 +255,7 @@ void mmu_write(CPUMBState *env, uint32_t rn, uint32_t=
 v)
>              /* Changes to the zone protection reg flush the QEMU TLB.
>                 Fortunately, these are very uncommon.  */
>              if (v !=3D env->mmu.regs[rn]) {
> -                tlb_flush(CPU(cpu), 1);
> +                tlb_flush(CPU(cpu));
>              }
>              env->mmu.regs[rn] =3D v;
>              break;
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 3146a6017d..e1c78f55ec 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -1054,7 +1054,7 @@ static inline void compute_hflags(CPUMIPSState *env)
>      }
>  }
> =20
> -void cpu_mips_tlb_flush(CPUMIPSState *env, int flush_global);
> +void cpu_mips_tlb_flush(CPUMIPSState *env);
>  void sync_c0_status(CPUMIPSState *env, CPUMIPSState *cpu, int tc);
>  void cpu_mips_store_status(CPUMIPSState *env, target_ulong val);
>  void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val);
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index c864b15b97..d2e77958fd 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -223,12 +223,12 @@ static int get_physical_address (CPUMIPSState *env,=
 hwaddr *physical,
>      return ret;
>  }
> =20
> -void cpu_mips_tlb_flush(CPUMIPSState *env, int flush_global)
> +void cpu_mips_tlb_flush(CPUMIPSState *env)
>  {
>      MIPSCPU *cpu =3D mips_env_get_cpu(env);
> =20
>      /* Flush qemu's TLB and discard all shadowed entries.  */
> -    tlb_flush(CPU(cpu), flush_global);
> +    tlb_flush(CPU(cpu));
>      env->tlb->tlb_in_use =3D env->tlb->nb_tlb;
>  }
> =20
> @@ -290,7 +290,7 @@ void cpu_mips_store_status(CPUMIPSState *env, target_=
ulong val)
>  #if defined(TARGET_MIPS64)
>      if ((env->CP0_Status ^ old) & (old & (7 << CP0St_UX))) {
>          /* Access to at least one of the 64-bit segments has been disabl=
ed */
> -        cpu_mips_tlb_flush(env, 1);
> +        cpu_mips_tlb_flush(env);
>      }
>  #endif
>      if (env->CP0_Config3 & (1 << CP0C3_MT)) {
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 7af4c2f084..047d11e423 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -1431,7 +1431,7 @@ void helper_mtc0_entryhi(CPUMIPSState *env, target_=
ulong arg1)
>      /* If the ASID changes, flush qemu's TLB.  */
>      if ((old & env->CP0_EntryHi_ASID_mask) !=3D
>          (val & env->CP0_EntryHi_ASID_mask)) {
> -        cpu_mips_tlb_flush(env, 1);
> +        cpu_mips_tlb_flush(env);
>      }
>  }
> =20
> @@ -2021,7 +2021,7 @@ void r4k_helper_tlbinv(CPUMIPSState *env)
>              tlb->EHINV =3D 1;
>          }
>      }
> -    cpu_mips_tlb_flush(env, 1);
> +    cpu_mips_tlb_flush(env);
>  }
> =20
>  void r4k_helper_tlbinvf(CPUMIPSState *env)
> @@ -2031,7 +2031,7 @@ void r4k_helper_tlbinvf(CPUMIPSState *env)
>      for (idx =3D 0; idx < env->tlb->nb_tlb; idx++) {
>          env->tlb->mmu.r4k.tlb[idx].EHINV =3D 1;
>      }
> -    cpu_mips_tlb_flush(env, 1);
> +    cpu_mips_tlb_flush(env);
>  }
> =20
>  void r4k_helper_tlbwi(CPUMIPSState *env)
> @@ -2145,7 +2145,7 @@ void r4k_helper_tlbr(CPUMIPSState *env)
> =20
>      /* If this will change the current ASID, flush qemu's TLB.  */
>      if (ASID !=3D tlb->ASID)
> -        cpu_mips_tlb_flush (env, 1);
> +        cpu_mips_tlb_flush(env);
> =20
>      r4k_mips_tlb_flush_extra(env, env->tlb->nb_tlb);
> =20
> diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
> index 5fe3f11ffc..e43fc84ef7 100644
> --- a/target/openrisc/interrupt.c
> +++ b/target/openrisc/interrupt.c
> @@ -45,7 +45,7 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
> =20
>      /* For machine-state changed between user-mode and supervisor mode,
>         we need flush TLB when we enter&exit EXCP.  */
> -    tlb_flush(cs, 1);
> +    tlb_flush(cs);
> =20
>      env->esr =3D env->sr;
>      env->sr &=3D ~SR_DME;
> diff --git a/target/openrisc/interrupt_helper.c b/target/openrisc/interru=
pt_helper.c
> index 116f9109a7..0ed5146e8d 100644
> --- a/target/openrisc/interrupt_helper.c
> +++ b/target/openrisc/interrupt_helper.c
> @@ -53,7 +53,7 @@ void HELPER(rfe)(CPUOpenRISCState *env)
>      }
> =20
>      if (need_flush_tlb) {
> -        tlb_flush(cs, 1);
> +        tlb_flush(cs);
>      }
>  #endif
>      cs->interrupt_request |=3D CPU_INTERRUPT_EXITTB;
> diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
> index a719e452be..daea902856 100644
> --- a/target/openrisc/sys_helper.c
> +++ b/target/openrisc/sys_helper.c
> @@ -47,7 +47,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
>      case TO_SPR(0, 17): /* SR */
>          if ((env->sr & (SR_IME | SR_DME | SR_SM)) ^
>              (rb & (SR_IME | SR_DME | SR_SM))) {
> -            tlb_flush(cs, 1);
> +            tlb_flush(cs);
>          }
>          env->sr =3D rb;
>          env->sr |=3D SR_FO;      /* FO is const equal to 1 */
> diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
> index 62138163a5..2627a70176 100644
> --- a/target/ppc/helper_regs.h
> +++ b/target/ppc/helper_regs.h
> @@ -161,7 +161,7 @@ static inline void check_tlb_flush(CPUPPCState *env, =
bool global)
>  {
>      CPUState *cs =3D CPU(ppc_env_get_cpu(env));
>      if (env->tlb_need_flush & TLB_NEED_LOCAL_FLUSH) {
> -        tlb_flush(cs, 1);
> +        tlb_flush(cs);
>          env->tlb_need_flush &=3D ~TLB_NEED_LOCAL_FLUSH;
>      }
> =20
> @@ -176,7 +176,7 @@ static inline void check_tlb_flush(CPUPPCState *env, =
bool global)
>                  CPUPPCState *other_env =3D &cpu->env;
> =20
>                  other_env->tlb_need_flush &=3D ~TLB_NEED_LOCAL_FLUSH;
> -                tlb_flush(other_cs, 1);
> +                tlb_flush(other_cs);
>              }
>          }
>          env->tlb_need_flush &=3D ~TLB_NEED_GLOBAL_FLUSH;
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index 1e6e705a4e..ab432bafaf 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -85,7 +85,7 @@ void helper_store_sdr1(CPUPPCState *env, target_ulong v=
al)
>      if (!env->external_htab) {
>          if (env->spr[SPR_SDR1] !=3D val) {
>              ppc_store_sdr1(env, val);
> -            tlb_flush(CPU(cpu), 1);
> +            tlb_flush(CPU(cpu));
>          }
>      }
>  }
> @@ -114,7 +114,7 @@ void helper_store_403_pbr(CPUPPCState *env, uint32_t =
num, target_ulong value)
>      if (likely(env->pb[num] !=3D value)) {
>          env->pb[num] =3D value;
>          /* Should be optimized */
> -        tlb_flush(CPU(cpu), 1);
> +        tlb_flush(CPU(cpu));
>      }
>  }
> =20
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index d09fc0a85f..f746f53615 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -248,7 +248,7 @@ static inline void ppc6xx_tlb_invalidate_all(CPUPPCSt=
ate *env)
>          tlb =3D &env->tlb.tlb6[nr];
>          pte_invalidate(&tlb->pte0);
>      }
> -    tlb_flush(CPU(cpu), 1);
> +    tlb_flush(CPU(cpu));
>  }
> =20
>  static inline void ppc6xx_tlb_invalidate_virt2(CPUPPCState *env,
> @@ -661,7 +661,7 @@ static inline void ppc4xx_tlb_invalidate_all(CPUPPCSt=
ate *env)
>          tlb =3D &env->tlb.tlbe[i];
>          tlb->prot &=3D ~PAGE_VALID;
>      }
> -    tlb_flush(CPU(cpu), 1);
> +    tlb_flush(CPU(cpu));
>  }
> =20
>  static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
> @@ -863,7 +863,7 @@ static void booke206_flush_tlb(CPUPPCState *env, int =
flags,
>          tlb +=3D booke206_tlb_size(env, i);
>      }
> =20
> -    tlb_flush(CPU(cpu), 1);
> +    tlb_flush(CPU(cpu));
>  }
> =20
>  static hwaddr booke206_tlb_to_page_size(CPUPPCState *env,
> @@ -1769,7 +1769,7 @@ void helper_store_ibatu(CPUPPCState *env, uint32_t =
nr, target_ulong value)
>  #if !defined(FLUSH_ALL_TLBS)
>          do_invalidate_BAT(env, env->IBAT[0][nr], mask);
>  #else
> -        tlb_flush(CPU(cpu), 1);
> +        tlb_flush(CPU(cpu));
>  #endif
>      }
>  }
> @@ -1804,7 +1804,7 @@ void helper_store_dbatu(CPUPPCState *env, uint32_t =
nr, target_ulong value)
>  #if !defined(FLUSH_ALL_TLBS)
>          do_invalidate_BAT(env, env->DBAT[0][nr], mask);
>  #else
> -        tlb_flush(CPU(cpu), 1);
> +        tlb_flush(CPU(cpu));
>  #endif
>      }
>  }
> @@ -1852,7 +1852,7 @@ void helper_store_601_batu(CPUPPCState *env, uint32=
_t nr, target_ulong value)
>          }
>  #if defined(FLUSH_ALL_TLBS)
>          if (do_inval) {
> -            tlb_flush(CPU(cpu), 1);
> +            tlb_flush(CPU(cpu));
>          }
>  #endif
>      }
> @@ -1892,7 +1892,7 @@ void helper_store_601_batl(CPUPPCState *env, uint32=
_t nr, target_ulong value)
>          env->DBAT[1][nr] =3D value;
>  #if defined(FLUSH_ALL_TLBS)
>          if (do_inval) {
> -            tlb_flush(CPU(cpu), 1);
> +            tlb_flush(CPU(cpu));
>          }
>  #endif
>      }
> @@ -1921,7 +1921,7 @@ void ppc_tlb_invalidate_all(CPUPPCState *env)
>          cpu_abort(CPU(cpu), "MPC8xx MMU model is not implemented\n");
>          break;
>      case POWERPC_MMU_BOOKE:
> -        tlb_flush(CPU(cpu), 1);
> +        tlb_flush(CPU(cpu));
>          break;
>      case POWERPC_MMU_BOOKE206:
>          booke206_flush_tlb(env, -1, 0);
> @@ -1937,7 +1937,7 @@ void ppc_tlb_invalidate_all(CPUPPCState *env)
>      case POWERPC_MMU_2_07a:
>  #endif /* defined(TARGET_PPC64) */
>          env->tlb_need_flush =3D 0;
> -        tlb_flush(CPU(cpu), 1);
> +        tlb_flush(CPU(cpu));
>          break;
>      default:
>          /* XXX: TODO */
> @@ -2433,13 +2433,13 @@ void helper_440_tlbwe(CPUPPCState *env, uint32_t =
word, target_ulong entry,
>          }
>          tlb->PID =3D env->spr[SPR_440_MMUCR] & 0x000000FF;
>          if (do_flush_tlbs) {
> -            tlb_flush(CPU(cpu), 1);
> +            tlb_flush(CPU(cpu));
>          }
>          break;
>      case 1:
>          RPN =3D value & 0xFFFFFC0F;
>          if ((tlb->prot & PAGE_VALID) && tlb->RPN !=3D RPN) {
> -            tlb_flush(CPU(cpu), 1);
> +            tlb_flush(CPU(cpu));
>          }
>          tlb->RPN =3D RPN;
>          break;
> @@ -2555,7 +2555,7 @@ void helper_booke_setpid(CPUPPCState *env, uint32_t=
 pidn, target_ulong pid)
> =20
>      env->spr[pidn] =3D pid;
>      /* changing PIDs mean we're in a different address space now */
> -    tlb_flush(CPU(cpu), 1);
> +    tlb_flush(CPU(cpu));
>  }
> =20
>  void helper_booke206_tlbwe(CPUPPCState *env)
> @@ -2650,7 +2650,7 @@ void helper_booke206_tlbwe(CPUPPCState *env)
>      if (booke206_tlb_to_page_size(env, tlb) =3D=3D TARGET_PAGE_SIZE) {
>          tlb_flush_page(CPU(cpu), tlb->mas2 & MAS2_EPN_MASK);
>      } else {
> -        tlb_flush(CPU(cpu), 1);
> +        tlb_flush(CPU(cpu));
>      }
>  }
> =20
> @@ -2775,7 +2775,7 @@ void helper_booke206_tlbivax(CPUPPCState *env, targ=
et_ulong address)
>          /* flush TLB1 entries */
>          booke206_invalidate_ea_tlb(env, 1, address);
>          CPU_FOREACH(cs) {
> -            tlb_flush(cs, 1);
> +            tlb_flush(cs);
>          }
>      } else {
>          /* flush TLB0 entries */
> @@ -2811,7 +2811,7 @@ void helper_booke206_tlbilx1(CPUPPCState *env, targ=
et_ulong address)
>          }
>          tlb +=3D booke206_tlb_size(env, i);
>      }
> -    tlb_flush(CPU(cpu), 1);
> +    tlb_flush(CPU(cpu));
>  }
> =20
>  void helper_booke206_tlbilx3(CPUPPCState *env, target_ulong address)
> @@ -2852,7 +2852,7 @@ void helper_booke206_tlbilx3(CPUPPCState *env, targ=
et_ulong address)
>              tlb->mas1 &=3D ~MAS1_VALID;
>          }
>      }
> -    tlb_flush(CPU(cpu), 1);
> +    tlb_flush(CPU(cpu));
>  }
> =20
>  void helper_booke206_tlbflush(CPUPPCState *env, target_ulong type)
> diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
> index 3d223dec97..ea4dc22eeb 100644
> --- a/target/s390x/gdbstub.c
> +++ b/target/s390x/gdbstub.c
> @@ -199,7 +199,7 @@ static int cpu_write_c_reg(CPUS390XState *env, uint8_=
t *mem_buf, int n)
>      case S390_C0_REGNUM ... S390_C15_REGNUM:
>          env->cregs[n] =3D ldtul_p(mem_buf);
>          if (tcg_enabled()) {
> -            tlb_flush(ENV_GET_CPU(env), 1);
> +            tlb_flush(ENV_GET_CPU(env));
>          }
>          cpu_synchronize_post_init(ENV_GET_CPU(env));
>          return 8;
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 99bc5e2834..675aba2e44 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -872,7 +872,7 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, u=
int64_t a2, uint32_t r3)
>          s390_cpu_recompute_watchpoints(CPU(cpu));
>      }
> =20
> -    tlb_flush(CPU(cpu), 1);
> +    tlb_flush(CPU(cpu));
>  }
> =20
>  void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t=
 r3)
> @@ -900,7 +900,7 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, ui=
nt64_t a2, uint32_t r3)
>          s390_cpu_recompute_watchpoints(CPU(cpu));
>      }
> =20
> -    tlb_flush(CPU(cpu), 1);
> +    tlb_flush(CPU(cpu));
>  }
> =20
>  void HELPER(stctg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_=
t r3)
> @@ -1036,7 +1036,7 @@ uint32_t HELPER(csp)(CPUS390XState *env, uint32_t r=
1, uint64_t r2)
>          cpu_stl_data(env, a2, env->regs[(r1 + 1) & 15]);
>          if (r2 & 0x3) {
>              /* flush TLB / ALB */
> -            tlb_flush(CPU(cpu), 1);
> +            tlb_flush(CPU(cpu));
>          }
>          cc =3D 0;
>      } else {
> @@ -1121,7 +1121,7 @@ void HELPER(ptlb)(CPUS390XState *env)
>  {
>      S390CPU *cpu =3D s390_env_get_cpu(env);
> =20
> -    tlb_flush(CPU(cpu), 1);
> +    tlb_flush(CPU(cpu));
>  }
> =20
>  /* load using real address */
> diff --git a/target/sh4/helper.c b/target/sh4/helper.c
> index a33ac697c5..036c5ca56c 100644
> --- a/target/sh4/helper.c
> +++ b/target/sh4/helper.c
> @@ -583,7 +583,7 @@ void cpu_load_tlb(CPUSH4State * env)
>          entry->v =3D 0;
>      }
> =20
> -    tlb_flush(CPU(sh_env_get_cpu(s)), 1);
> +    tlb_flush(CPU(sh_env_get_cpu(s)));
>  }
> =20
>  uint32_t cpu_sh4_read_mmaped_itlb_addr(CPUSH4State *s,
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index de7d53ae20..a0171f73f7 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -816,7 +816,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong a=
ddr, uint64_t val,
>              case 2: /* flush region (16M) */
>              case 3: /* flush context (4G) */
>              case 4: /* flush entire */
> -                tlb_flush(CPU(cpu), 1);
> +                tlb_flush(CPU(cpu));
>                  break;
>              default:
>                  break;
> @@ -841,7 +841,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong a=
ddr, uint64_t val,
>                     are invalid in normal mode.  */
>                  if ((oldreg ^ env->mmuregs[reg])
>                      & (MMU_NF | env->def->mmu_bm)) {
> -                    tlb_flush(CPU(cpu), 1);
> +                    tlb_flush(CPU(cpu));
>                  }
>                  break;
>              case 1: /* Context Table Pointer Register */
> @@ -852,7 +852,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong a=
ddr, uint64_t val,
>                  if (oldreg !=3D env->mmuregs[reg]) {
>                      /* we flush when the MMU context changes because
>                         QEMU has no MMU context support */
> -                    tlb_flush(CPU(cpu), 1);
> +                    tlb_flush(CPU(cpu));
>                  }
>                  break;
>              case 3: /* Synchronous Fault Status Register with Clear */
> @@ -1509,13 +1509,13 @@ void helper_st_asi(CPUSPARCState *env, target_ulo=
ng addr, target_ulong val,
>                  env->dmmu.mmu_primary_context =3D val;
>                  /* can be optimized to only flush MMU_USER_IDX
>                     and MMU_KERNEL_IDX entries */
> -                tlb_flush(CPU(cpu), 1);
> +                tlb_flush(CPU(cpu));
>                  break;
>              case 2: /* Secondary context */
>                  env->dmmu.mmu_secondary_context =3D val;
>                  /* can be optimized to only flush MMU_USER_SECONDARY_IDX
>                     and MMU_KERNEL_SECONDARY_IDX entries */
> -                tlb_flush(CPU(cpu), 1);
> +                tlb_flush(CPU(cpu));
>                  break;
>              case 5: /* TSB access */
>                  DPRINTF_MMU("dmmu TSB write: 0x%016" PRIx64 " -> 0x%016"
> @@ -1654,7 +1654,7 @@ void sparc_cpu_unassigned_access(CPUState *cs, hwad=
dr addr,
>      /* flush neverland mappings created during no-fault mode,
>         so the sequential MMU faults report proper fault types */
>      if (env->mmuregs[0] & MMU_NF) {
> -        tlb_flush(cs, 1);
> +        tlb_flush(cs);
>      }
>  }
>  #else
> diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
> index c169972b59..c9b78ce68e 100644
> --- a/target/unicore32/cpu.c
> +++ b/target/unicore32/cpu.c
> @@ -133,7 +133,7 @@ static void uc32_cpu_initfn(Object *obj)
>      env->regs[31] =3D 0x03000000;
>  #endif
> =20
> -    tlb_flush(cs, 1);
> +    tlb_flush(cs);
> =20
>      if (tcg_enabled() && !inited) {
>          inited =3D true;
> diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
> index d603bde237..9454efa665 100644
> --- a/target/unicore32/helper.c
> +++ b/target/unicore32/helper.c
> @@ -116,7 +116,7 @@ void helper_cp0_set(CPUUniCore32State *env, uint32_t =
val, uint32_t creg,
>      case 6:
>          if ((cop <=3D 6) && (cop >=3D 2)) {
>              /* invalid all tlb */
> -            tlb_flush(CPU(cpu), 1);
> +            tlb_flush(CPU(cpu));
>              return;
>          }
>          break;
> diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
> index 0a4b2147bc..63c89f80c5 100644
> --- a/target/xtensa/op_helper.c
> +++ b/target/xtensa/op_helper.c
> @@ -492,7 +492,7 @@ void HELPER(wsr_rasid)(CPUXtensaState *env, uint32_t =
v)
>      v =3D (v & 0xffffff00) | 0x1;
>      if (v !=3D env->sregs[RASID]) {
>          env->sregs[RASID] =3D v;
> -        tlb_flush(CPU(cpu), 1);
> +        tlb_flush(CPU(cpu));
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bO4vSxwwZtUjUWHo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYeBKMAAoJEGw4ysog2bOSGVgP/3WfArzhiduCKEBHUyUWr/JO
c2MLc+CuvPaWHTf4WVjlpzujFRf7o4FC1nBTT0B+tGsNJsB31I9Pym5PmoBCcBGc
Gcx1Joli4gp4NnBXNODrOopxiYKSvPD6NG4o3LFgIzufA211d5fYQAoi1QKXVsx2
76rCwpOM/jeM1wsyNXrPAZelEKyFs3ypWb0dTcJP4P8uQxvLM8+IvwnEYyKxaHRr
s9P+1t11vijRkyGYE4dHhrSCZhdl92vSqmHqO/uq0Bmf13a5fdlRxcnKeDWO7TbI
8eGbkPEjKkk8WUioumV4FazLiLPEat/69rL5SHWd0u7Vme953KQD3Kg5RncZc0e8
dyJgt7XpLB8nuK2Y7ZjjTJICMvb/VBN9mvm/qK2UfkQZJG98Zu29lJq1ICYoTWTU
vWNBTUBC6q90VJAKgMHTMN73R/aJhcoaoRWL3ltFev9VMSQyxled1yv+/eOedSDO
HdnvkcQ/sfKPSoZbi75a382QjpJ1eprZ6jqgUGHsU+dx2zKsmcJNJ/Q+rf/DlLpu
w1acNpT5wC4MWWYAVThIjYrn5zUx3+NsVyHwC6F09rXWjUdAzFBB1o1ACa6kE8A9
qrtdoPv/Zv/GoO2JTvZIDTgshxCZlrZUIHfm8/vHh3CtBcf2LckDwSB6fUCaFD1s
+Blk7n9wBNScme1ols/n
=wx1C
-----END PGP SIGNATURE-----

--bO4vSxwwZtUjUWHo--
