Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40961C31E44
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 03:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B17217D4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 03:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B17217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44112 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcico-000198-8G
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 23:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45038)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hcibQ-0008WI-4d
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 23:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hcibO-0006Mi-69
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 23:46:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46018)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hcibN-0006IK-Tf
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 23:46:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9305E5AFE9;
 Mon, 17 Jun 2019 03:46:34 +0000 (UTC)
Received: from xz-x1 (ovpn-12-34.pek2.redhat.com [10.72.12.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 545AE2E03F;
 Mon, 17 Jun 2019 03:46:32 +0000 (UTC)
Date: Mon, 17 Jun 2019 11:46:28 +0800
From: Peter Xu <peterx@redhat.com>
To: Cosmin Marin <cosmin@nutanix.com>
Message-ID: <20190617034628.GA12456@xz-x1>
References: <20190614161106.218854-1-cosmin@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190614161106.218854-1-cosmin@nutanix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 17 Jun 2019 03:46:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: Improve accuracy of vCPU
 throttling with per-vCPU timers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 14, 2019 at 09:11:06AM -0700, Cosmin Marin wrote:
> During auto-convergence live migration, the configured throttling rate
> is not matched in practice. Experimental measurements of throughput for
> a memory-write intensive workload indicate disparities between expected
> and measured throttle rate - when set to 99%, the actual throttle rate
> was 95%. The workload spawns multiple threads (#threads equals #vCPUs)
> that dirty most of the VM's memory in an infinite loop.
> 
> The root cause is the usage of a VM-wide timer to schedule and execute
> asynchronously cpu_throttle_thread() on the vCPUs. Firstly, there are
> scalability limitations at scheduling time as a VM-wide (global) loop
> must iterate over all vCPUs while running atomic operations (i.e., may
> induce delays between vCPUs); moreover, if a vCPU is already running
> cpu_throttle_thread() (!DONE) it is skipped (i.e., may induce uneven
> aggregate sleep times across vCPUs). Secondly, there is a race condition
> between the vCPU threads and the 'scheduling' (migration) thread as a
> vCPU thread needs to release the iothread lock, sleep, reacquire the
> lock and mark "itself" as completed (DONE). Configuring correct per-vCPU
> sleep intervals using this model is non-trivial.
> 
> To address the above issues, per-vCPU timers replace the per-VM timer.
> The migration thread globally decides the throttling level while each
> vCPU thread calculates the equivalent sleep times and sleeps
> accordingly. The following table summarizes the results obtained by
> running the workload on a 22vCPUs/45GB VM in both scenarios.
> 
> +----------------------------------------------------------------+
> |          |      per-VM Timer        |   per-vCPU Timer         |
> |  Target  |==========================|==========================|
> | Throttle | Throughput |    Actual   | Throughput |    Actual   |
> |    (%)   |   (GBps)   | Throttle(%) |   (GBps)   | Throttle(%) |
> |----------|------------|-------------|------------|-------------|
> |         0|     ~493.50|            0|     ~493.50|           0 |
> |        20|      395.65|        19.81|      390.35|        20.88|
> |        30|      356.43|        27.76|      342.39|        30.60|
> |        40|      317.26|        35.69|      293.99|        40.41|
> |        50|      268.78|        45.52|      244.95|        50.35|
> |        60|      214.61|        56.50|      195.23|        60.43|
> |        70|      164.72|        66.61|      147.55|        70.09|
> |        80|      112.62|        77.17|       98.52|        80.03|
> |        90|       57.09|        88.43|       47.90|        90.29|
> |        99|       26.87|        94.55|        3.11|        99.36|
> +----------------------------------------------------------------+

Hi, Cosmin,

The numbers are really nice... though I am unsure about whether this
patch will help in scalability or even make it worth?  After all it'll
create N timers instead of one when we have N vcpus.

What I feel like is that async_run_on_cpu() should be fairly fast
except the fact you mentioned that we'll skip the throttling
conditionally if it's still ongoing, as if we see the numbers the old
code throttling is always less than the target.

Have you tried to simply remove the throttle_thread_scheduled
variable, and trigger the throttle unconditionally (but still with one
timer)?

> 
> The results support a per-vCPU timer model as it produces more accurate
> throttling.
> 
> Signed-off-by: Cosmin Marin <cosmin@nutanix.com>
> ---
>  cpus.c            | 29 +++++++++++++++--------------
>  include/qom/cpu.h |  4 ++--
>  2 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index dde3b7b981..c2bd3babf6 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -80,7 +80,6 @@ int64_t max_delay;
>  int64_t max_advance;
>  
>  /* vcpu throttling controls */
> -static QEMUTimer *throttle_timer;
>  static unsigned int throttle_percentage;
>  
>  #define CPU_THROTTLE_PCT_MIN 1
> @@ -792,40 +791,42 @@ static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
>      qemu_mutex_unlock_iothread();
>      g_usleep(sleeptime_ns / 1000); /* Convert ns to us for usleep call */
>      qemu_mutex_lock_iothread();
> -    atomic_set(&cpu->throttle_thread_scheduled, 0);
>  }
>  
>  static void cpu_throttle_timer_tick(void *opaque)
>  {
> -    CPUState *cpu;
> +    CPUState *cpu = (CPUState *)opaque;
>      double pct;
>  
>      /* Stop the timer if needed */
>      if (!cpu_throttle_get_percentage()) {
>          return;
>      }
> -    CPU_FOREACH(cpu) {
> -        if (!atomic_xchg(&cpu->throttle_thread_scheduled, 1)) {
> -            async_run_on_cpu(cpu, cpu_throttle_thread,
> -                             RUN_ON_CPU_NULL);
> -        }
> -    }
> +    
> +    async_run_on_cpu(cpu, cpu_throttle_thread, RUN_ON_CPU_NULL);
>  
>      pct = (double)cpu_throttle_get_percentage()/100;
> -    timer_mod(throttle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) +
> +    timer_mod(cpu->throttle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) +
>                                     CPU_THROTTLE_TIMESLICE_NS / (1-pct));
>  }
>  
>  void cpu_throttle_set(int new_throttle_pct)
>  {
> +    CPUState *cpu;
> +    double pct;
> +
>      /* Ensure throttle percentage is within valid range */
>      new_throttle_pct = MIN(new_throttle_pct, CPU_THROTTLE_PCT_MAX);
>      new_throttle_pct = MAX(new_throttle_pct, CPU_THROTTLE_PCT_MIN);
>  
>      atomic_set(&throttle_percentage, new_throttle_pct);
>  
> -    timer_mod(throttle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) +
> -                                       CPU_THROTTLE_TIMESLICE_NS);
> +    pct = (double)new_throttle_pct/100;
> +    CPU_FOREACH(cpu) {
> +        timer_mod_anticipate(cpu->throttle_timer,
> +                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) +
> +                CPU_THROTTLE_TIMESLICE_NS / (1-pct));
> +    }
>  }
>  
>  void cpu_throttle_stop(void)
> @@ -848,8 +849,6 @@ void cpu_ticks_init(void)
>      seqlock_init(&timers_state.vm_clock_seqlock);
>      qemu_spin_init(&timers_state.vm_clock_lock);
>      vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
> -    throttle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
> -                                           cpu_throttle_timer_tick, NULL);
>  }
>  
>  void configure_icount(QemuOpts *opts, Error **errp)
> @@ -1267,6 +1266,8 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
>      qemu_thread_get_self(cpu->thread);
>      cpu->thread_id = qemu_get_thread_id();
>      cpu->can_do_io = 1;
> +    cpu->throttle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
> +            cpu_throttle_timer_tick, cpu);
>      current_cpu = cpu;
>  
>      r = kvm_init_vcpu(cpu);
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 5ee0046b62..5a11baec69 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -439,10 +439,10 @@ struct CPUState {
>      /* shared by kvm, hax and hvf */
>      bool vcpu_dirty;
>  
> -    /* Used to keep track of an outstanding cpu throttle thread for migration
> +    /* Used to cyclically trigger vCPU throttling during VM migration
>       * autoconverge
>       */
> -    bool throttle_thread_scheduled;
> +    QEMUTimer *throttle_timer;
>  
>      bool ignore_memory_transaction_failures;
>  
> -- 
> 2.16.5
> 
> 

Regards,

-- 
Peter Xu

