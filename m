Received: from eggs.gnu.org ([2001:4830:134:3::10]:46461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cXweN-0006Pa-KQ
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cXweI-0000sy-N1
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:04:39 -0500
Received: from mail-yb0-x244.google.com ([2607:f8b0:4002:c09::244]:34359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cXweI-0000sq-I8
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:04:34 -0500
Received: by mail-yb0-x244.google.com with SMTP id w194so24731581ybe.1
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 13:04:34 -0800 (PST)
References: <20170127103922.19658-1-alex.bennee@linaro.org>
	<20170127103922.19658-8-alex.bennee@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
In-reply-to: <20170127103922.19658-8-alex.bennee@linaro.org>
Date: Sun, 29 Jan 2017 16:04:32 -0500
Message-ID: <8737g1r31b.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 07/25] tcg: rename tcg_current_cpu to
 tcg_current_rr_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>


Alex Bennée writes:

> ..and make the definition local to cpus. In preparation for MTTCG the
> concept of a global tcg_current_cpu will no longer make sense. However
> we still need to keep track of it in the single-threaded case to be able
> to exit quickly when required.
>
> qemu_cpu_kick_no_halt() moves and becomes qemu_cpu_kick_rr_cpu() to
> emphasise its use-case. qemu_cpu_kick now kicks the relevant cpu as
> well as qemu_kick_rr_cpu() which will become a no-op in MTTCG.
>
> For the time being the setting of the global exit_request remains.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> ---
> v4:
>   - keep global exit_request setting for now
>   - fix merge conflicts
> v5:
>   - merge conflicts with kick changes
> ---
>  cpu-exec-common.c       |  1 -
>  cpu-exec.c              |  3 ---
>  cpus.c                  | 41 ++++++++++++++++++++++-------------------
>  include/exec/exec-all.h |  1 -
>  4 files changed, 22 insertions(+), 24 deletions(-)
>
> diff --git a/cpu-exec-common.c b/cpu-exec-common.c
> index 767d9c6f0c..e2bc053372 100644
> --- a/cpu-exec-common.c
> +++ b/cpu-exec-common.c
> @@ -24,7 +24,6 @@
>  #include "exec/memory-internal.h"
>  
>  bool exit_request;
> -CPUState *tcg_current_cpu;
>  
>  /* exit the current TB, but without causing any exception to be raised */
>  void cpu_loop_exit_noexc(CPUState *cpu)
> diff --git a/cpu-exec.c b/cpu-exec.c
> index 1b8685dc21..f9e836c8dd 100644
> --- a/cpu-exec.c
> +++ b/cpu-exec.c
> @@ -609,7 +609,6 @@ int cpu_exec(CPUState *cpu)
>          return EXCP_HALTED;
>      }
>  
> -    atomic_mb_set(&tcg_current_cpu, cpu);
>      rcu_read_lock();
>  
>      if (unlikely(atomic_mb_read(&exit_request))) {
> @@ -668,7 +667,5 @@ int cpu_exec(CPUState *cpu)
>      /* fail safe : never use current_cpu outside cpu_exec() */
>      current_cpu = NULL;
>  
> -    /* Does not need atomic_mb_set because a spurious wakeup is okay.  */
> -    atomic_set(&tcg_current_cpu, NULL);
>      return ret;
>  }
> diff --git a/cpus.c b/cpus.c
> index a98925105c..6d64199831 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -779,8 +779,7 @@ void configure_icount(QemuOpts *opts, Error **errp)
>   */
>  
>  static QEMUTimer *tcg_kick_vcpu_timer;
> -
> -static void qemu_cpu_kick_no_halt(void);
> +static CPUState *tcg_current_rr_cpu;
>  
>  #define TCG_KICK_PERIOD (NANOSECONDS_PER_SECOND / 10)
>  
> @@ -789,10 +788,23 @@ static inline int64_t qemu_tcg_next_kick(void)
>      return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + TCG_KICK_PERIOD;
>  }
>  
> +/* Kick the currently round-robin scheduled vCPU */
> +static void qemu_cpu_kick_rr_cpu(void)
> +{
> +    CPUState *cpu;
> +    atomic_mb_set(&exit_request, 1);
> +    do {
> +        cpu = atomic_mb_read(&tcg_current_rr_cpu);
> +        if (cpu) {
> +            cpu_exit(cpu);
> +        }
> +    } while (cpu != atomic_mb_read(&tcg_current_rr_cpu));
> +}
> +
>  static void kick_tcg_thread(void *opaque)
>  {
>      timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
> -    qemu_cpu_kick_no_halt();
> +    qemu_cpu_kick_rr_cpu();
>  }
>  
>  static void start_tcg_kick_timer(void)
> @@ -812,7 +824,6 @@ static void stop_tcg_kick_timer(void)
>      }
>  }
>  
> -
>  /***********************************************************/
>  void hw_error(const char *fmt, ...)
>  {
> @@ -1323,6 +1334,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
>          }
>  
>          for (; cpu != NULL && !exit_request; cpu = CPU_NEXT(cpu)) {
> +            atomic_mb_set(&tcg_current_rr_cpu, cpu);
>  
>              qemu_clock_enable(QEMU_CLOCK_VIRTUAL,
>                                (cpu->singlestep_enabled & SSTEP_NOTIMER) == 0);
> @@ -1342,6 +1354,8 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
>              }
>  
>          } /* for cpu.. */
> +        /* Does not need atomic_mb_set because a spurious wakeup is okay.  */
> +        atomic_set(&tcg_current_rr_cpu, NULL);
>  
>          /* Pairs with smp_wmb in qemu_cpu_kick.  */
>          atomic_mb_set(&exit_request, 0);
> @@ -1420,24 +1434,13 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
>  #endif
>  }
>  
> -static void qemu_cpu_kick_no_halt(void)
> -{
> -    CPUState *cpu;
> -    /* Ensure whatever caused the exit has reached the CPU threads before
> -     * writing exit_request.
> -     */
> -    atomic_mb_set(&exit_request, 1);
> -    cpu = atomic_mb_read(&tcg_current_cpu);
> -    if (cpu) {
> -        cpu_exit(cpu);
> -    }
> -}
> -
>  void qemu_cpu_kick(CPUState *cpu)
>  {
>      qemu_cond_broadcast(cpu->halt_cond);
>      if (tcg_enabled()) {
> -        qemu_cpu_kick_no_halt();
> +        cpu_exit(cpu);
> +        /* Also ensure current RR cpu is kicked */
> +        qemu_cpu_kick_rr_cpu();
>      } else {
>          if (hax_enabled()) {
>              /*
> @@ -1485,7 +1488,7 @@ void qemu_mutex_lock_iothread(void)
>          atomic_dec(&iothread_requesting_mutex);
>      } else {
>          if (qemu_mutex_trylock(&qemu_global_mutex)) {
> -            qemu_cpu_kick_no_halt();
> +            qemu_cpu_kick_rr_cpu();
>              qemu_mutex_lock(&qemu_global_mutex);
>          }
>          atomic_dec(&iothread_requesting_mutex);
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index bbc9478a50..3cbd359dd7 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -404,7 +404,6 @@ bool memory_region_is_unassigned(MemoryRegion *mr);
>  extern int singlestep;
>  
>  /* cpu-exec.c, accessed with atomic_mb_read/atomic_mb_set */
> -extern CPUState *tcg_current_cpu;
>  extern bool exit_request;
>  
>  #endif

Reviewed-by: Pranith Kumar <bobby.prani@gmail.com>

-- 
Pranith
