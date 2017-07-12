Received: from eggs.gnu.org ([2001:4830:134:3::10]:55085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVHf9-0006mA-9r
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVHf5-00066j-PT
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:26:43 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVHf5-000658-Hx
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:26:39 -0400
Received: by mail-wr0-x232.google.com with SMTP id r103so33759031wrb.0
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 06:26:39 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-4-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1499586614-20507-4-git-send-email-cota@braap.org>
Date: Wed, 12 Jul 2017 14:26:36 +0100
Message-ID: <87pod5946r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/22] cputlb: bring back tlb_flush_count
 under !TLB_DEBUG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> Commit f0aff0f124 ("cputlb: add assert_cpu_is_self checks") buried
> the increment of tlb_flush_count under TLB_DEBUG. This results in
> "info jit" always (mis)reporting 0 TLB flushes when !TLB_DEBUG.
>
> Besides, under MTTCG tlb_flush_count is updated by several threads,
> so in order not to lose counts we'd either have to use atomic ops
> or distribute the counter, which is more scalable.
>
> This patch does the latter by embedding tlb_flush_count in CPUArchState.
> The global count is then easily obtained by iterating over the CPU list.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

As it actually fixes unintentional breakage:

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

That said I'm not sure if this number alone is helpful given the range
of flushes we have. Really from a performance point of view we should
differentiate between inline per-vCPU flushes as well as the cross-vCPU
flushes of both asynchronus and synced varieties.

I had a go at this using QEMUs tracing infrastructure:

  https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg04076.html

But I guess the ideal way would be something that both keeps counters
and optionally enable tracepoints.

> ---
>  include/exec/cpu-defs.h   |  1 +
>  include/exec/cputlb.h     |  3 +--
>  accel/tcg/cputlb.c        | 17 ++++++++++++++---
>  accel/tcg/translate-all.c |  2 +-
>  4 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
> index bc8e7f8..e43ff83 100644
> --- a/include/exec/cpu-defs.h
> +++ b/include/exec/cpu-defs.h
> @@ -137,6 +137,7 @@ typedef struct CPUIOTLBEntry {
>      CPUTLBEntry tlb_v_table[NB_MMU_MODES][CPU_VTLB_SIZE];               \
>      CPUIOTLBEntry iotlb[NB_MMU_MODES][CPU_TLB_SIZE];                    \
>      CPUIOTLBEntry iotlb_v[NB_MMU_MODES][CPU_VTLB_SIZE];                 \
> +    size_t tlb_flush_count;                                             \
>      target_ulong tlb_flush_addr;                                        \
>      target_ulong tlb_flush_mask;                                        \
>      target_ulong vtlb_index;                                            \
> diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
> index 3f94178..c91db21 100644
> --- a/include/exec/cputlb.h
> +++ b/include/exec/cputlb.h
> @@ -23,7 +23,6 @@
>  /* cputlb.c */
>  void tlb_protect_code(ram_addr_t ram_addr);
>  void tlb_unprotect_code(ram_addr_t ram_addr);
> -extern int tlb_flush_count;
> -
> +size_t tlb_flush_count(void);
>  #endif
>  #endif
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 85635ae..9377110 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -92,8 +92,18 @@ static void flush_all_helper(CPUState *src, run_on_cpu_func fn,
>      }
>  }
>
> -/* statistics */
> -int tlb_flush_count;
> +size_t tlb_flush_count(void)
> +{
> +    CPUState *cpu;
> +    size_t count = 0;
> +
> +    CPU_FOREACH(cpu) {
> +        CPUArchState *env = cpu->env_ptr;
> +
> +        count += atomic_read(&env->tlb_flush_count);
> +    }
> +    return count;
> +}
>
>  /* This is OK because CPU architectures generally permit an
>   * implementation to drop entries from the TLB at any time, so
> @@ -112,7 +122,8 @@ static void tlb_flush_nocheck(CPUState *cpu)
>      }
>
>      assert_cpu_is_self(cpu);
> -    tlb_debug("(count: %d)\n", tlb_flush_count++);
> +    atomic_set(&env->tlb_flush_count, env->tlb_flush_count + 1);
> +    tlb_debug("(count: %zu)\n", tlb_flush_count());
>
>      tb_lock();
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index f768681..a936a5f 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1909,7 +1909,7 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
>              atomic_read(&tcg_ctx.tb_ctx.tb_flush_count));
>      cpu_fprintf(f, "TB invalidate count %d\n",
>              tcg_ctx.tb_ctx.tb_phys_invalidate_count);
> -    cpu_fprintf(f, "TLB flush count     %d\n", tlb_flush_count);
> +    cpu_fprintf(f, "TLB flush count     %zu\n", tlb_flush_count());
>      tcg_dump_info(f, cpu_fprintf);
>
>      tb_unlock();


--
Alex Bennée
