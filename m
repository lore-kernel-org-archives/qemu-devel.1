Received: from eggs.gnu.org ([2001:4830:134:3::10]:44966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFw3U-00076W-99
	for qemu-devel@nongnu.org; Wed, 31 May 2017 01:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFw3P-0002UP-Gh
	for qemu-devel@nongnu.org; Wed, 31 May 2017 01:20:24 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFw3P-0002Tm-9C
	for qemu-devel@nongnu.org; Wed, 31 May 2017 01:20:19 -0400
Received: by mail-oi0-x244.google.com with SMTP id v80so356913oie.2
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 22:20:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170517145259.28979-1-alex.bennee@linaro.org>
	<20170517145259.28979-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <aecdaf51-ab66-1d58-26c4-8cb18dff5f6c@amsat.org>
Date: Wed, 31 May 2017 02:20:16 -0300
MIME-Version: 1.0
In-Reply-To: <20170517145259.28979-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 5/6] cputlb: add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, stefanha@redhat.com
Cc: Richard Henderson <rth@twiddle.net>, cota@braap.org, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 05/17/2017 11:52 AM, Alex Bennée wrote:
> Given the range of costs for various SoftMMU TLB operations from
> deferring work for the currently running vCPU to bring the whole
> emulated machine to a stop for synchronised updates simple counters
> are less useful. Instead we log events via the trace infrastructure
> and we can then post-process the data in a range of ways.
>
>   tlb_flush_self - the vCPU flushed its own TLB
>   tlb_flush_async_schedule - work was scheduled and the vCPU kicked
>   tlb_flush_synced_schedule - exclusive work was scheduled on a vCPU
>   tlb_flush_work - scheduled work was done
>
> We can use the difference between the work being scheduled and
> tlb_flush_work to calculate the latency introduced.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  cputlb.c     | 34 +++++++++++++++++++++++++++++++++-
>  trace-events |  7 +++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/cputlb.c b/cputlb.c
> index d1859c3f37..b2490863e4 100644
> --- a/cputlb.c
> +++ b/cputlb.c
> @@ -127,6 +127,7 @@ static void tlb_flush_nocheck(CPUState *cpu)
>
>  static void tlb_flush_global_async_work(CPUState *cpu, run_on_cpu_data data)
>  {
> +    trace_tlb_flush_work(__func__, cpu->cpu_index);
>      tlb_flush_nocheck(cpu);
>  }
>
> @@ -135,17 +136,22 @@ void tlb_flush(CPUState *cpu)
>      if (cpu->created && !qemu_cpu_is_self(cpu)) {
>          if (atomic_mb_read(&cpu->pending_tlb_flush) != ALL_MMUIDX_BITS) {
>              atomic_mb_set(&cpu->pending_tlb_flush, ALL_MMUIDX_BITS);
> +            trace_tlb_flush_async_schedule(__func__, current_cpu ?
> +                                           current_cpu->cpu_index :
> +                                           cpu->cpu_index, cpu->cpu_index);
>              async_run_on_cpu(cpu, tlb_flush_global_async_work,
>                               RUN_ON_CPU_NULL);
>          }
>      } else {
> +        trace_tlb_flush_self(__func__, cpu->cpu_index);
> -        tlb_flush_nocheck(cpu);
> +        tlb_flush_global_async_work(cpu, RUN_ON_CPU_NULL);

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      }
>  }
>
>  void tlb_flush_all_cpus(CPUState *src_cpu)
>  {
>      const run_on_cpu_func fn = tlb_flush_global_async_work;
> +    trace_tlb_flush_async_schedule(__func__, src_cpu->cpu_index, -1);
>      flush_all_helper(src_cpu, fn, RUN_ON_CPU_NULL);
>      fn(src_cpu, RUN_ON_CPU_NULL);
>  }
> @@ -153,6 +159,7 @@ void tlb_flush_all_cpus(CPUState *src_cpu)
>  void tlb_flush_all_cpus_synced(CPUState *src_cpu)
>  {
>      const run_on_cpu_func fn = tlb_flush_global_async_work;
> +    trace_tlb_flush_synced_schedule(__func__, src_cpu->cpu_index, -1);
>      flush_all_helper(src_cpu, fn, RUN_ON_CPU_NULL);
>      async_safe_run_on_cpu(src_cpu, fn, RUN_ON_CPU_NULL);
>  }
> @@ -163,6 +170,8 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
>      unsigned long mmu_idx_bitmask = data.host_int;
>      int mmu_idx;
>
> +    trace_tlb_flush_work(__func__, cpu->cpu_index);
> +
>      assert_cpu_is_self(cpu);
>
>      tb_lock();
> @@ -196,12 +205,16 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
>
>          if (pending_flushes) {
>              tlb_debug("reduced mmu_idx: 0x%" PRIx16 "\n", pending_flushes);
> +            trace_tlb_flush_async_schedule(__func__,
> +                                           current_cpu->cpu_index,
> +                                           cpu->cpu_index);
>
>              atomic_or(&cpu->pending_tlb_flush, pending_flushes);
>              async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
>                               RUN_ON_CPU_HOST_INT(pending_flushes));
>          }
>      } else {
> +        trace_tlb_flush_self(__func__, cpu->cpu_index);
>          tlb_flush_by_mmuidx_async_work(cpu,
>                                         RUN_ON_CPU_HOST_INT(idxmap));
>      }
> @@ -212,6 +225,7 @@ void tlb_flush_by_mmuidx_all_cpus(CPUState *src_cpu, uint16_t idxmap)
>      const run_on_cpu_func fn = tlb_flush_by_mmuidx_async_work;
>
>      tlb_debug("mmu_idx: 0x%"PRIx16"\n", idxmap);
> +    trace_tlb_flush_async_schedule(__func__, src_cpu->cpu_index, -1);
>
>      flush_all_helper(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
>      fn(src_cpu, RUN_ON_CPU_HOST_INT(idxmap));
> @@ -223,6 +237,7 @@ void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
>      const run_on_cpu_func fn = tlb_flush_by_mmuidx_async_work;
>
>      tlb_debug("mmu_idx: 0x%"PRIx16"\n", idxmap);
> +    trace_tlb_flush_synced_schedule(__func__, src_cpu->cpu_index, -1);
>
>      flush_all_helper(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
>      async_safe_run_on_cpu(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
> @@ -252,6 +267,7 @@ static void tlb_flush_page_async_work(CPUState *cpu, run_on_cpu_data data)
>      assert_cpu_is_self(cpu);
>
>      tlb_debug("page :" TARGET_FMT_lx "\n", addr);
> +    trace_tlb_flush_work(__func__, cpu->cpu_index);
>
>      /* Check if we need to flush due to large pages.  */
>      if ((addr & env->tlb_flush_mask) == env->tlb_flush_addr) {
> @@ -285,9 +301,12 @@ void tlb_flush_page(CPUState *cpu, target_ulong addr)
>      tlb_debug("page :" TARGET_FMT_lx "\n", addr);
>
>      if (!qemu_cpu_is_self(cpu)) {
> +        trace_tlb_flush_async_schedule(__func__, current_cpu->cpu_index,
> +                                       cpu->cpu_index);
>          async_run_on_cpu(cpu, tlb_flush_page_async_work,
>                           RUN_ON_CPU_TARGET_PTR(addr));
>      } else {
> +        trace_tlb_flush_self(__func__, cpu->cpu_index);
>          tlb_flush_page_async_work(cpu, RUN_ON_CPU_TARGET_PTR(addr));
>      }
>  }
> @@ -312,6 +331,7 @@ static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
>
>      tlb_debug("page:%d addr:"TARGET_FMT_lx" mmu_idx:0x%lx\n",
>                page, addr, mmu_idx_bitmap);
> +    trace_tlb_flush_work(__func__, cpu->cpu_index);
>
>      for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
>          if (test_bit(mmu_idx, &mmu_idx_bitmap)) {
> @@ -336,6 +356,7 @@ static void tlb_check_page_and_flush_by_mmuidx_async_work(CPUState *cpu,
>      unsigned long mmu_idx_bitmap = addr_and_mmuidx & ALL_MMUIDX_BITS;
>
>      tlb_debug("addr:"TARGET_FMT_lx" mmu_idx: %04lx\n", addr, mmu_idx_bitmap);
> +    trace_tlb_flush_work(__func__, cpu->cpu_index);
>
>      /* Check if we need to flush due to large pages.  */
>      if ((addr & env->tlb_flush_mask) == env->tlb_flush_addr) {
> @@ -343,9 +364,11 @@ static void tlb_check_page_and_flush_by_mmuidx_async_work(CPUState *cpu,
>                    TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
>                    env->tlb_flush_addr, env->tlb_flush_mask);
>
> +        trace_tlb_flush_self(__func__, cpu->cpu_index);
>          tlb_flush_by_mmuidx_async_work(cpu,
>                                         RUN_ON_CPU_HOST_INT(mmu_idx_bitmap));
>      } else {
> +        trace_tlb_flush_self(__func__, cpu->cpu_index);
>          tlb_flush_page_by_mmuidx_async_work(cpu, data);
>      }
>  }
> @@ -361,9 +384,12 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
>      addr_and_mmu_idx |= idxmap;
>
>      if (!qemu_cpu_is_self(cpu)) {
> +        trace_tlb_flush_async_schedule(__func__, current_cpu->cpu_index,
> +                                       cpu->cpu_index);
>          async_run_on_cpu(cpu, tlb_check_page_and_flush_by_mmuidx_async_work,
>                           RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
>      } else {
> +        trace_tlb_flush_self(__func__, cpu->cpu_index);
>          tlb_check_page_and_flush_by_mmuidx_async_work(
>              cpu, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
>      }
> @@ -376,6 +402,7 @@ void tlb_flush_page_by_mmuidx_all_cpus(CPUState *src_cpu, target_ulong addr,
>      target_ulong addr_and_mmu_idx;
>
>      tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:%"PRIx16"\n", addr, idxmap);
> +    trace_tlb_flush_async_schedule(__func__, src_cpu->cpu_index, -1);
>
>      /* This should already be page aligned */
>      addr_and_mmu_idx = addr & TARGET_PAGE_MASK;
> @@ -393,6 +420,7 @@ void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
>      target_ulong addr_and_mmu_idx;
>
>      tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:%"PRIx16"\n", addr, idxmap);
> +    trace_tlb_flush_synced_schedule(__func__, src_cpu->cpu_index, -1);
>
>      /* This should already be page aligned */
>      addr_and_mmu_idx = addr & TARGET_PAGE_MASK;
> @@ -406,6 +434,8 @@ void tlb_flush_page_all_cpus(CPUState *src, target_ulong addr)
>  {
>      const run_on_cpu_func fn = tlb_flush_page_async_work;
>
> +    trace_tlb_flush_async_schedule(__func__, src->cpu_index, -1);
> +
>      flush_all_helper(src, fn, RUN_ON_CPU_TARGET_PTR(addr));
>      fn(src, RUN_ON_CPU_TARGET_PTR(addr));
>  }
> @@ -415,6 +445,8 @@ void tlb_flush_page_all_cpus_synced(CPUState *src,
>  {
>      const run_on_cpu_func fn = tlb_flush_page_async_work;
>
> +    trace_tlb_flush_synced_schedule(__func__, src->cpu_index, -1);
> +
>      flush_all_helper(src, fn, RUN_ON_CPU_TARGET_PTR(addr));
>      async_safe_run_on_cpu(src, fn, RUN_ON_CPU_TARGET_PTR(addr));
>  }
> diff --git a/trace-events b/trace-events
> index e582d6315d..500f84b8c4 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -78,6 +78,13 @@ disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
>  disable exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
>  disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=%x"
>
> +# SoftMMU TLB flushes
> +#   - setting to=-1 indicates work scheduled on all vCPUs
> +tlb_flush_self(const char *fn, int vcpu) "%s: cpu %d"
> +tlb_flush_async_schedule(const char *fn, int from, int to) "%s: from_cpu=%d to_cpu=%d"
> +tlb_flush_synced_schedule(const char *fn, int from, int to) "%s: from_cpu=%d to_cpu=%d"
> +tlb_flush_work(const char *fn, int vcpu) "%s: cpu %d"
> +
>  # translate-all.c
>  translate_block(void *tb, uintptr_t pc, uint8_t *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
>
>
