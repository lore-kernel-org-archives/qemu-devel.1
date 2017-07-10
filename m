Received: from eggs.gnu.org ([2001:4830:134:3::10]:55129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUVX2-0005bP-EE
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUVWz-0007Lv-7D
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:03:08 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:35098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUVWy-0007LM-T5
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:03:05 -0400
Received: by mail-wr0-x234.google.com with SMTP id k67so131151565wrc.2
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 03:03:04 -0700 (PDT)
References: <20170628050003.1809-1-bobby.prani@gmail.com>
	<20170628050003.1809-3-bobby.prani@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170628050003.1809-3-bobby.prani@gmail.com>
Date: Mon, 10 Jul 2017 11:03:01 +0100
Message-ID: <87van0a9t6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] [TEST] Collect TLB and victim TLB
 hit/miss stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net


Pranith Kumar <bobby.prani@gmail.com> writes:

> I used the following patch to collect hit/miss TLB ratios for a few
> benchmarks. The results can be found here: http://imgur.com/a/gee1o
>
> Please note that these results also include boot/shutdown as the
> per-region instrumentation patch came later.
>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  accel/tcg/cputlb.c        | 12 ++++++++++++
>  cpus.c                    | 26 ++++++++++++++++++++++++++
>  include/exec/cpu-defs.h   |  4 ++++
>  include/sysemu/cpus.h     |  2 ++
>  target/arm/helper.c       |  6 +++++-
>  tcg/i386/tcg-target.inc.c | 16 ++++++++++++++--
>  vl.c                      |  3 +++
>  7 files changed, 66 insertions(+), 3 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index ef52a7e5e0..2ac2397431 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -864,12 +864,19 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>      }
>  }
>
> +extern bool enable_instrumentation;
> +

Is there a better place for this than a static global? I was pondering
tcg_ctx but that's not really visible to the runtime. Making it part of
the TB flags might be useful for only instrumenting certain segments of
the code but I suspect I'm bike-shedding at this point.

>  /* Return true if ADDR is present in the victim tlb, and has been copied
>     back to the main tlb.  */
>  static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
>                             size_t elt_ofs, target_ulong page)
>  {
>      size_t vidx;
> +
> +    if (enable_instrumentation) {
> +        env->tlb_access_victim++;
> +    }
> +
>      for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
>          CPUTLBEntry *vtlb = &env->tlb_v_table[mmu_idx][vidx];
>          target_ulong cmp = *(target_ulong *)((uintptr_t)vtlb + elt_ofs);
> @@ -885,6 +892,11 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
>              CPUIOTLBEntry tmpio, *io = &env->iotlb[mmu_idx][index];
>              CPUIOTLBEntry *vio = &env->iotlb_v[mmu_idx][vidx];
>              tmpio = *io; *io = *vio; *vio = tmpio;
> +
> +            if (enable_instrumentation) {
> +                env->tlb_access_victim_hit++;
> +            }
> +
>              return true;
>          }
>      }
> diff --git a/cpus.c b/cpus.c
> index 14bb8d552e..14669b3469 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1602,6 +1602,32 @@ static bool all_vcpus_paused(void)
>      return true;
>  }
>
> +void print_tlb_stats(void)
> +{
> +    CPUState *cpu;
> +    CPU_FOREACH(cpu) {
> +        CPUArchState *cs = cpu->env_ptr;
> +
> +        fprintf(stderr, "TLB accesses %lu, hits %lu, victim accesses %lu, hits %lu\n",
> +                cs->tlb_access_total, cs->tlb_access_hit, cs->tlb_access_victim,
> +                cs->tlb_access_victim_hit);
> +    }
> +}
> +
> +void clear_tlb_stats(void)
> +{
> +    CPUState *cpu;
> +    CPU_FOREACH(cpu) {
> +        CPUArchState *cs = cpu->env_ptr;
> +
> +        cs->tlb_access_total        = 0;
> +        cs->tlb_access_hit          = 0;
> +        cs->tlb_access_victim       = 0;
> +        cs->tlb_access_victim       = 0;

Duplicate line here.

> +        cs->tlb_access_victim_hit   = 0;
> +    }
> +}
> +
>  void pause_all_vcpus(void)
>  {
>      CPUState *cpu;
> diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
> index 5f4e303635..29b3c2ada8 100644
> --- a/include/exec/cpu-defs.h
> +++ b/include/exec/cpu-defs.h
> @@ -138,6 +138,10 @@ typedef struct CPUIOTLBEntry {
>      target_ulong tlb_flush_addr;                                        \
>      target_ulong tlb_flush_mask;                                        \
>      target_ulong vtlb_index;                                            \
> +    target_ulong tlb_access_hit;                                        \
> +    target_ulong tlb_access_total;                                      \
> +    target_ulong tlb_access_victim;                                     \
> +    target_ulong tlb_access_victim_hit;                                 \
>
>  #else
>
> diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
> index 731756d948..7d8d92646c 100644
> --- a/include/sysemu/cpus.h
> +++ b/include/sysemu/cpus.h
> @@ -10,6 +10,8 @@ void resume_all_vcpus(void);
>  void pause_all_vcpus(void);
>  void cpu_stop_current(void);
>  void cpu_ticks_init(void);
> +void print_tlb_stats(void);
> +void clear_tlb_stats(void);
>
>  void configure_icount(QemuOpts *opts, Error **errp);
>  extern int use_icount;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index dfbf03676c..d2e75b0f20 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1124,7 +1124,9 @@ static uint64_t pmxevtyper_read(CPUARMState *env, const ARMCPRegInfo *ri)
>      }
>  }
>
> -bool enable_instrumentation;
> +extern bool enable_instrumentation;
> +extern void print_tlb_stats(void);
> +extern void clear_tlb_stats(void);
>
>  static void pmuserenr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                              uint64_t value)
> @@ -1139,6 +1141,8 @@ static void pmuserenr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      } else if (value == 0xfa11dead) {
>          printf("Disabling instrumentation\n");
>          enable_instrumentation = false;
> +        print_tlb_stats();
> +        clear_tlb_stats();
>          tb_flush(cs);
>      }

This needs to be part of the cputlb API so only one call is made from
the architecture helpers. I would expect this patch to be the first and
the pmuserenr_el0 (or whatever else) to be a per-arch enhancement patch
on top.

>
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 9d7d25c017..b75bd54c35 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -1250,6 +1250,8 @@ static void * const qemu_st_helpers[16] = {
>      [MO_BEQ]  = helper_be_stq_mmu,
>  };
>
> +extern bool enable_instrumentation;
> +
>  /* Perform the TLB load and compare.
>
>     Inputs:
> @@ -1300,6 +1302,12 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
>          }
>      }
>
> +    if (enable_instrumentation) {

Certainly inside the code generation I'd see this being controlled by
TCGContext, e.g. s->tlb_instruction

> +        tcg_out_ld(s, TCG_TYPE_I64, r0, TCG_AREG0, offsetof(CPUArchState, tlb_access_total));
> +        tcg_out_addi(s, r0, 1);
> +        tcg_out_st(s, TCG_TYPE_I64, r0, TCG_AREG0, offsetof(CPUArchState, tlb_access_total));
> +    }
> +
>      tcg_out_mov(s, tlbtype, r0, addrlo);
>      tlb_mask = (target_ulong)TARGET_PAGE_MASK | a_mask;
>
> @@ -1348,11 +1356,15 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
>          s->code_ptr += 4;
>      }
>
> -    /* TLB Hit.  */
> -

why drop this comment?

>      /* add addend(r0), r1 */
>      tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, r1, r0,
>                           offsetof(CPUTLBEntry, addend) - which);
> +
> +    if (enable_instrumentation) {
> +        tcg_out_ld(s, TCG_TYPE_I64, r0, TCG_AREG0, offsetof(CPUArchState, tlb_access_hit));
> +        tcg_out_addi(s, r0, 1);
> +        tcg_out_st(s, TCG_TYPE_I64, r0, TCG_AREG0, offsetof(CPUArchState, tlb_access_hit));
> +    }
>  }
>
>  /*
> diff --git a/vl.c b/vl.c
> index 59fea15488..7fa392c79e 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -192,6 +192,8 @@ int only_migratable; /* turn it off unless user states otherwise */
>
>  int icount_align_option;
>
> +bool enable_instrumentation;
> +
>  /* The bytes in qemu_uuid are in the order specified by RFC4122, _not_ in the
>   * little-endian "wire format" described in the SMBIOS 2.6 specification.
>   */
> @@ -4761,5 +4763,6 @@ int main(int argc, char **argv, char **envp)
>      qemu_chr_cleanup();
>      /* TODO: unref root container, check all devices are ok */
>
> +    print_tlb_stats();
>      return 0;
>  }

I appreciate this is currently test code for gathering numbers but it
would be nice to see if there is a nice way to integrate it upstream
(maybe for --enable-debug-tcg builds).

--
Alex Bennée
