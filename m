Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C50C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 13:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5E920899
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 13:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5E920899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc84T-0004to-7Q
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 09:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jc83c-000420-WF
 for qemu-devel@nongnu.org; Fri, 22 May 2020 09:49:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:40060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jc83X-0001oi-Nh
 for qemu-devel@nongnu.org; Fri, 22 May 2020 09:49:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AD0B9B00E;
 Fri, 22 May 2020 13:49:45 +0000 (UTC)
Subject: Re: [RFC 2/3] cpu-timers: new module extracted from cpus.c
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200521185407.25311-1-cfontana@suse.de>
 <20200521185407.25311-3-cfontana@suse.de>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <50b4ffbc-ac5c-1278-f5e5-a7339c43e93d@suse.de>
Date: Fri, 22 May 2020 15:49:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200521185407.25311-3-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 23:56:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 "open list:X86 HAXM CPUs" <haxm-team@intel.com>,
 Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


here the obvious next step would be to split icount as its own module,
and make it tcg-only.

The issue I am facing with that is that qtest is actually requiring this,
as it is "using" icount for its qtest_clock_warp functionality.

Does somebody have a good idea here that might save some time?

Thanks,

Claudio

On 5/21/20 8:54 PM, Claudio Fontana wrote:
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  MAINTAINERS                 |   1 +
>  Makefile.target             |   1 +
>  accel/qtest.c               |   3 +-
>  accel/tcg/cpu-exec.c        |  43 ++-
>  accel/tcg/tcg-all.c         |   7 +-
>  accel/tcg/translate-all.c   |   3 +-
>  cpu-timers.c                | 776 ++++++++++++++++++++++++++++++++++++++++++++
>  cpus.c                      | 731 +----------------------------------------
>  docs/replay.txt             |   6 +-
>  exec.c                      |   4 -
>  hw/core/ptimer.c            |   6 +-
>  hw/i386/x86.c               |   1 +
>  include/exec/cpu-all.h      |   4 +
>  include/exec/exec-all.h     |   4 +-
>  include/qemu/timer.h        |  20 --
>  include/sysemu/cpu-timers.h |  73 +++++
>  include/sysemu/cpus.h       |  12 +-
>  include/sysemu/replay.h     |   4 +-
>  qtest.c                     |   2 +-
>  replay/replay.c             |   6 +-
>  softmmu/vl.c                |   8 +-
>  stubs/clock-warp.c          |   4 +-
>  stubs/cpu-get-clock.c       |   2 +-
>  stubs/cpu-get-icount.c      |  14 +-
>  target/alpha/translate.c    |   3 +-
>  target/arm/helper.c         |   7 +-
>  target/riscv/csr.c          |   8 +-
>  tests/ptimer-test-stubs.c   |   6 +
>  tests/test-timed-average.c  |   2 +-
>  util/main-loop.c            |   4 +-
>  util/qemu-timer.c           |   9 +-
>  31 files changed, 965 insertions(+), 809 deletions(-)
>  create mode 100644 cpu-timers.c
>  create mode 100644 include/sysemu/cpu-timers.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 35864a275a..1b3b17fda8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2143,6 +2143,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
>  F: cpus.c
>  F: cpu-throttle.c
> +F: cpu-timers.c
>  F: include/qemu/main-loop.h
>  F: include/sysemu/runstate.h
>  F: util/main-loop.c
> diff --git a/Makefile.target b/Makefile.target
> index 60cfa2a78b..1d40237375 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -155,6 +155,7 @@ ifdef CONFIG_SOFTMMU
>  obj-y += arch_init.o
>  obj-y += cpus.o
>  obj-y += cpu-throttle.o
> +obj-y += cpu-timers.o
>  obj-y += gdbstub.o
>  obj-y += balloon.o
>  obj-y += ioport.o
> diff --git a/accel/qtest.c b/accel/qtest.c
> index 5b88f55921..ef9ee0941a 100644
> --- a/accel/qtest.c
> +++ b/accel/qtest.c
> @@ -19,13 +19,14 @@
>  #include "sysemu/accel.h"
>  #include "sysemu/qtest.h"
>  #include "sysemu/cpus.h"
> +#include "sysemu/cpu-timers.h"
>  
>  static int qtest_init_accel(MachineState *ms)
>  {
>      QemuOpts *opts = qemu_opts_create(qemu_find_opts("icount"), NULL, 0,
>                                        &error_abort);
>      qemu_opt_set(opts, "shift", "0", &error_abort);
> -    configure_icount(opts, &error_abort);
> +    icount_configure(opts, &error_abort);
>      qemu_opts_del(opts);
>      return 0;
>  }
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index d95c4848a4..82155c1db3 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -19,6 +19,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> +#include "qemu/qemu-print.h"
>  #include "cpu.h"
>  #include "trace.h"
>  #include "disas/disas.h"
> @@ -36,6 +37,8 @@
>  #include "hw/i386/apic.h"
>  #endif
>  #include "sysemu/cpus.h"
> +#include "exec/cpu-all.h"
> +#include "sysemu/cpu-timers.h"
>  #include "sysemu/replay.h"
>  
>  /* -icount align implementation. */
> @@ -56,6 +59,9 @@ typedef struct SyncClocks {
>  #define MAX_DELAY_PRINT_RATE 2000000000LL
>  #define MAX_NB_PRINTS 100
>  
> +static int64_t max_delay;
> +static int64_t max_advance;
> +
>  static void align_clocks(SyncClocks *sc, CPUState *cpu)
>  {
>      int64_t cpu_icount;
> @@ -65,7 +71,7 @@ static void align_clocks(SyncClocks *sc, CPUState *cpu)
>      }
>  
>      cpu_icount = cpu->icount_extra + cpu_neg(cpu)->icount_decr.u16.low;
> -    sc->diff_clk += cpu_icount_to_ns(sc->last_cpu_icount - cpu_icount);
> +    sc->diff_clk += icount_to_ns(sc->last_cpu_icount - cpu_icount);
>      sc->last_cpu_icount = cpu_icount;
>  
>      if (sc->diff_clk > VM_CLOCK_ADVANCE) {
> @@ -98,9 +104,9 @@ static void print_delay(const SyncClocks *sc)
>              (-sc->diff_clk / (float)1000000000LL <
>               (threshold_delay - THRESHOLD_REDUCE))) {
>              threshold_delay = (-sc->diff_clk / 1000000000LL) + 1;
> -            printf("Warning: The guest is now late by %.1f to %.1f seconds\n",
> -                   threshold_delay - 1,
> -                   threshold_delay);
> +            qemu_printf("Warning: The guest is now late by %.1f to %.1f seconds\n",
> +                        threshold_delay - 1,
> +                        threshold_delay);
>              nb_prints++;
>              last_realtime_clock = sc->realtime_clock;
>          }
> @@ -597,7 +603,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>  
>      /* Finally, check if we need to exit to the main loop.  */
>      if (unlikely(atomic_read(&cpu->exit_request))
> -        || (use_icount
> +        || (icount_enabled()
>              && cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra == 0)) {
>          atomic_set(&cpu->exit_request, 0);
>          if (cpu->exception_index == -1) {
> @@ -638,10 +644,10 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
>      }
>  
>      /* Instruction counter expired.  */
> -    assert(use_icount);
> +    assert(icount_enabled());
>  #ifndef CONFIG_USER_ONLY
>      /* Ensure global icount has gone forward */
> -    cpu_update_icount(cpu);
> +    icount_update(cpu);
>      /* Refill decrementer and continue execution.  */
>      insns_left = MIN(0xffff, cpu->icount_budget);
>      cpu_neg(cpu)->icount_decr.u16.low = insns_left;
> @@ -741,3 +747,26 @@ int cpu_exec(CPUState *cpu)
>  
>      return ret;
>  }
> +
> +#ifndef CONFIG_USER_ONLY
> +
> +void dump_drift_info(void)
> +{
> +    if (!icount_enabled()) {
> +        return;
> +    }
> +
> +    qemu_printf("Host - Guest clock  %"PRIi64" ms\n",
> +                (cpu_get_clock() - icount_get()) / SCALE_MS);
> +    if (icount_align_option) {
> +        qemu_printf("Max guest delay     %"PRIi64" ms\n",
> +                    -max_delay / SCALE_MS);
> +        qemu_printf("Max guest advance   %"PRIi64" ms\n",
> +                    max_advance / SCALE_MS);
> +    } else {
> +        qemu_printf("Max guest delay     NA\n");
> +        qemu_printf("Max guest advance   NA\n");
> +    }
> +}
> +
> +#endif /* !CONFIG_USER_ONLY */
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 3b4fda5640..e27385d051 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -29,6 +29,7 @@
>  #include "qom/object.h"
>  #include "cpu.h"
>  #include "sysemu/cpus.h"
> +#include "sysemu/cpu-timers.h"
>  #include "qemu/main-loop.h"
>  #include "tcg/tcg.h"
>  #include "qapi/error.h"
> @@ -65,7 +66,7 @@ static void tcg_handle_interrupt(CPUState *cpu, int mask)
>          qemu_cpu_kick(cpu);
>      } else {
>          atomic_set(&cpu_neg(cpu)->icount_decr.u16.high, -1);
> -        if (use_icount &&
> +        if (icount_enabled() &&
>              !cpu->can_do_io
>              && (mask & ~old_mask) != 0) {
>              cpu_abort(cpu, "Raised interrupt while not in I/O function");
> @@ -104,7 +105,7 @@ static bool check_tcg_memory_orders_compatible(void)
>  
>  static bool default_mttcg_enabled(void)
>  {
> -    if (use_icount || TCG_OVERSIZED_GUEST) {
> +    if (icount_enabled() || TCG_OVERSIZED_GUEST) {
>          return false;
>      } else {
>  #ifdef TARGET_SUPPORTS_MTTCG
> @@ -146,7 +147,7 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
>      if (strcmp(value, "multi") == 0) {
>          if (TCG_OVERSIZED_GUEST) {
>              error_setg(errp, "No MTTCG when guest word size > hosts");
> -        } else if (use_icount) {
> +        } else if (icount_enabled()) {
>              error_setg(errp, "No MTTCG when icount is enabled");
>          } else {
>  #ifndef TARGET_SUPPORTS_MTTCG
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 42ce1dfcff..479edeb2ea 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -57,6 +57,7 @@
>  #include "qemu/main-loop.h"
>  #include "exec/log.h"
>  #include "sysemu/cpus.h"
> +#include "sysemu/cpu-timers.h"
>  #include "sysemu/tcg.h"
>  
>  /* #define DEBUG_TB_INVALIDATE */
> @@ -369,7 +370,7 @@ static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
>  
>   found:
>      if (reset_icount && (tb_cflags(tb) & CF_USE_ICOUNT)) {
> -        assert(use_icount);
> +        assert(icount_enabled());
>          /* Reset the cycle counter to the start of the block
>             and shift if to the number of actually executed instructions */
>          cpu_neg(cpu)->icount_decr.u16.low += num_insns - i;
> diff --git a/cpu-timers.c b/cpu-timers.c
> new file mode 100644
> index 0000000000..20fea07625
> --- /dev/null
> +++ b/cpu-timers.c
> @@ -0,0 +1,776 @@
> +/*
> + * QEMU System Emulator
> + *
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qemu/cutils.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "exec/exec-all.h"
> +#include "sysemu/cpus.h"
> +#include "sysemu/qtest.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/option.h"
> +#include "qemu/seqlock.h"
> +#include "sysemu/replay.h"
> +#include "sysemu/runstate.h"
> +#include "hw/core/cpu.h"
> +#include "sysemu/cpu-timers.h"
> +#include "sysemu/cpu-throttle.h"
> +
> +typedef struct TimersState {
> +    /* Protected by BQL.  */
> +    int64_t cpu_ticks_prev;
> +    int64_t cpu_ticks_offset;
> +
> +    /*
> +     * Protect fields that can be respectively read outside the
> +     * BQL, and written from multiple threads.
> +     */
> +    QemuSeqLock vm_clock_seqlock;
> +    QemuSpin vm_clock_lock;
> +
> +    int16_t cpu_ticks_enabled;
> +
> +    /* Conversion factor from emulated instructions to virtual clock ticks.  */
> +    int16_t icount_time_shift;
> +
> +    /* Compensate for varying guest execution speed.  */
> +    int64_t qemu_icount_bias;
> +
> +    int64_t vm_clock_warp_start;
> +    int64_t cpu_clock_offset;
> +
> +    /* Only written by TCG thread */
> +    int64_t qemu_icount;
> +
> +    /* for adjusting icount */
> +    QEMUTimer *icount_rt_timer;
> +    QEMUTimer *icount_vm_timer;
> +    QEMUTimer *icount_warp_timer;
> +} TimersState;
> +
> +static TimersState timers_state;
> +
> +/*
> + * ICOUNT: Instruction Counter
> + */
> +static bool icount_sleep = true;
> +/* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
> +#define MAX_ICOUNT_SHIFT 10
> +
> +/*
> + * 0 = Do not count executed instructions.
> + * 1 = Fixed conversion of insn to ns via "shift" option
> + * 2 = Runtime adaptive algorithm to compute shift
> + */
> +static int use_icount;
> +
> +int icount_enabled(void)
> +{
> +    return use_icount;
> +}
> +
> +static void icount_enable_precise(void)
> +{
> +    use_icount = 1;
> +}
> +
> +static void icount_enable_adaptive(void)
> +{
> +    use_icount = 2;
> +}
> +
> +/*
> + * The current number of executed instructions is based on what we
> + * originally budgeted minus the current state of the decrementing
> + * icount counters in extra/u16.low.
> + */
> +static int64_t icount_get_executed(CPUState *cpu)
> +{
> +    return (cpu->icount_budget -
> +            (cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra));
> +}
> +
> +/*
> + * Update the global shared timer_state.qemu_icount to take into
> + * account executed instructions. This is done by the TCG vCPU
> + * thread so the main-loop can see time has moved forward.
> + */
> +static void icount_update_locked(CPUState *cpu)
> +{
> +    int64_t executed = icount_get_executed(cpu);
> +    cpu->icount_budget -= executed;
> +
> +    atomic_set_i64(&timers_state.qemu_icount,
> +                   timers_state.qemu_icount + executed);
> +}
> +
> +/*
> + * Update the global shared timer_state.qemu_icount to take into
> + * account executed instructions. This is done by the TCG vCPU
> + * thread so the main-loop can see time has moved forward.
> + */
> +void icount_update(CPUState *cpu)
> +{
> +    seqlock_write_lock(&timers_state.vm_clock_seqlock,
> +                       &timers_state.vm_clock_lock);
> +    icount_update_locked(cpu);
> +    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
> +                         &timers_state.vm_clock_lock);
> +}
> +
> +static int64_t icount_get_raw_locked(void)
> +{
> +    CPUState *cpu = current_cpu;
> +
> +    if (cpu && cpu->running) {
> +        if (!cpu->can_do_io) {
> +            error_report("Bad icount read");
> +            exit(1);
> +        }
> +        /* Take into account what has run */
> +        icount_update_locked(cpu);
> +    }
> +    /* The read is protected by the seqlock, but needs atomic64 to avoid UB */
> +    return atomic_read_i64(&timers_state.qemu_icount);
> +}
> +
> +static int64_t icount_get_locked(void)
> +{
> +    int64_t icount = icount_get_raw_locked();
> +    return atomic_read_i64(&timers_state.qemu_icount_bias) +
> +        icount_to_ns(icount);
> +}
> +
> +int64_t icount_get_raw(void)
> +{
> +    int64_t icount;
> +    unsigned start;
> +
> +    do {
> +        start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
> +        icount = icount_get_raw_locked();
> +    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
> +
> +    return icount;
> +}
> +
> +/* Return the virtual CPU time, based on the instruction counter.  */
> +int64_t icount_get(void)
> +{
> +    int64_t icount;
> +    unsigned start;
> +
> +    do {
> +        start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
> +        icount = icount_get_locked();
> +    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
> +
> +    return icount;
> +}
> +
> +int64_t icount_to_ns(int64_t icount)
> +{
> +    return icount << atomic_read(&timers_state.icount_time_shift);
> +}
> +
> +/*
> + * Correlation between real and virtual time is always going to be
> + * fairly approximate, so ignore small variation.
> + * When the guest is idle real and virtual time will be aligned in
> + * the IO wait loop.
> + */
> +#define ICOUNT_WOBBLE (NANOSECONDS_PER_SECOND / 10)
> +
> +static int64_t cpu_get_clock_locked(void);
> +
> +static void icount_adjust(void)
> +{
> +    int64_t cur_time;
> +    int64_t cur_icount;
> +    int64_t delta;
> +
> +    /* Protected by TimersState mutex.  */
> +    static int64_t last_delta;
> +
> +    /* If the VM is not running, then do nothing.  */
> +    if (!runstate_is_running()) {
> +        return;
> +    }
> +
> +    seqlock_write_lock(&timers_state.vm_clock_seqlock,
> +                       &timers_state.vm_clock_lock);
> +    cur_time = cpu_get_clock_locked();
> +    cur_icount = icount_get_locked();
> +
> +    delta = cur_icount - cur_time;
> +    /* FIXME: This is a very crude algorithm, somewhat prone to oscillation.  */
> +    if (delta > 0
> +        && last_delta + ICOUNT_WOBBLE < delta * 2
> +        && timers_state.icount_time_shift > 0) {
> +        /* The guest is getting too far ahead.  Slow time down.  */
> +        atomic_set(&timers_state.icount_time_shift,
> +                   timers_state.icount_time_shift - 1);
> +    }
> +    if (delta < 0
> +        && last_delta - ICOUNT_WOBBLE > delta * 2
> +        && timers_state.icount_time_shift < MAX_ICOUNT_SHIFT) {
> +        /* The guest is getting too far behind.  Speed time up.  */
> +        atomic_set(&timers_state.icount_time_shift,
> +                   timers_state.icount_time_shift + 1);
> +    }
> +    last_delta = delta;
> +    atomic_set_i64(&timers_state.qemu_icount_bias,
> +                   cur_icount - (timers_state.qemu_icount
> +                                 << timers_state.icount_time_shift));
> +    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
> +                         &timers_state.vm_clock_lock);
> +}
> +
> +static void icount_adjust_rt(void *opaque)
> +{
> +    timer_mod(timers_state.icount_rt_timer,
> +              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) + 1000);
> +    icount_adjust();
> +}
> +
> +static void icount_adjust_vm(void *opaque)
> +{
> +    timer_mod(timers_state.icount_vm_timer,
> +                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                   NANOSECONDS_PER_SECOND / 10);
> +    icount_adjust();
> +}
> +
> +int64_t icount_round(int64_t count)
> +{
> +    int shift = atomic_read(&timers_state.icount_time_shift);
> +    return (count + (1 << shift) - 1) >> shift;
> +}
> +
> +static void icount_warp_rt(void)
> +{
> +    unsigned seq;
> +    int64_t warp_start;
> +
> +    /*
> +     * The icount_warp_timer is rescheduled soon after vm_clock_warp_start
> +     * changes from -1 to another value, so the race here is okay.
> +     */
> +    do {
> +        seq = seqlock_read_begin(&timers_state.vm_clock_seqlock);
> +        warp_start = timers_state.vm_clock_warp_start;
> +    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, seq));
> +
> +    if (warp_start == -1) {
> +        return;
> +    }
> +
> +    seqlock_write_lock(&timers_state.vm_clock_seqlock,
> +                       &timers_state.vm_clock_lock);
> +    if (runstate_is_running()) {
> +        int64_t clock = REPLAY_CLOCK_LOCKED(REPLAY_CLOCK_VIRTUAL_RT,
> +                                            cpu_get_clock_locked());
> +        int64_t warp_delta;
> +
> +        warp_delta = clock - timers_state.vm_clock_warp_start;
> +        if (icount_enabled() == 2) {
> +            /*
> +             * In adaptive mode, do not let QEMU_CLOCK_VIRTUAL run too
> +             * far ahead of real time.
> +             */
> +            int64_t cur_icount = icount_get_locked();
> +            int64_t delta = clock - cur_icount;
> +            warp_delta = MIN(warp_delta, delta);
> +        }
> +        atomic_set_i64(&timers_state.qemu_icount_bias,
> +                       timers_state.qemu_icount_bias + warp_delta);
> +    }
> +    timers_state.vm_clock_warp_start = -1;
> +    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
> +                       &timers_state.vm_clock_lock);
> +
> +    if (qemu_clock_expired(QEMU_CLOCK_VIRTUAL)) {
> +        qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
> +    }
> +}
> +
> +static void icount_timer_cb(void *opaque)
> +{
> +    /*
> +     * No need for a checkpoint because the timer already synchronizes
> +     * with CHECKPOINT_CLOCK_VIRTUAL_RT.
> +     */
> +    icount_warp_rt();
> +}
> +
> +void icount_start_warp_timer(void)
> +{
> +    int64_t clock;
> +    int64_t deadline;
> +
> +    if (!icount_enabled()) {
> +        return;
> +    }
> +
> +    /*
> +     * Nothing to do if the VM is stopped: QEMU_CLOCK_VIRTUAL timers
> +     * do not fire, so computing the deadline does not make sense.
> +     */
> +    if (!runstate_is_running()) {
> +        return;
> +    }
> +
> +    if (replay_mode != REPLAY_MODE_PLAY) {
> +        if (!all_cpu_threads_idle()) {
> +            return;
> +        }
> +
> +        if (qtest_enabled()) {
> +            /* When testing, qtest commands advance icount.  */
> +            return;
> +        }
> +
> +        replay_checkpoint(CHECKPOINT_CLOCK_WARP_START);
> +    } else {
> +        /* warp clock deterministically in record/replay mode */
> +        if (!replay_checkpoint(CHECKPOINT_CLOCK_WARP_START)) {
> +            /*
> +             * vCPU is sleeping and warp can't be started.
> +             * It is probably a race condition: notification sent
> +             * to vCPU was processed in advance and vCPU went to sleep.
> +             * Therefore we have to wake it up for doing someting.
> +             */
> +            if (replay_has_checkpoint()) {
> +                qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
> +            }
> +            return;
> +        }
> +    }
> +
> +    /* We want to use the earliest deadline from ALL vm_clocks */
> +    clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT);
> +    deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
> +                                          ~QEMU_TIMER_ATTR_EXTERNAL);
> +    if (deadline < 0) {
> +        static bool notified;
> +        if (!icount_sleep && !notified) {
> +            warn_report("icount sleep disabled and no active timers");
> +            notified = true;
> +        }
> +        return;
> +    }
> +
> +    if (deadline > 0) {
> +        /*
> +         * Ensure QEMU_CLOCK_VIRTUAL proceeds even when the virtual CPU goes to
> +         * sleep.  Otherwise, the CPU might be waiting for a future timer
> +         * interrupt to wake it up, but the interrupt never comes because
> +         * the vCPU isn't running any insns and thus doesn't advance the
> +         * QEMU_CLOCK_VIRTUAL.
> +         */
> +        if (!icount_sleep) {
> +            /*
> +             * We never let VCPUs sleep in no sleep icount mode.
> +             * If there is a pending QEMU_CLOCK_VIRTUAL timer we just advance
> +             * to the next QEMU_CLOCK_VIRTUAL event and notify it.
> +             * It is useful when we want a deterministic execution time,
> +             * isolated from host latencies.
> +             */
> +            seqlock_write_lock(&timers_state.vm_clock_seqlock,
> +                               &timers_state.vm_clock_lock);
> +            atomic_set_i64(&timers_state.qemu_icount_bias,
> +                           timers_state.qemu_icount_bias + deadline);
> +            seqlock_write_unlock(&timers_state.vm_clock_seqlock,
> +                                 &timers_state.vm_clock_lock);
> +            qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
> +        } else {
> +            /*
> +             * We do stop VCPUs and only advance QEMU_CLOCK_VIRTUAL after some
> +             * "real" time, (related to the time left until the next event) has
> +             * passed. The QEMU_CLOCK_VIRTUAL_RT clock will do this.
> +             * This avoids that the warps are visible externally; for example,
> +             * you will not be sending network packets continuously instead of
> +             * every 100ms.
> +             */
> +            seqlock_write_lock(&timers_state.vm_clock_seqlock,
> +                               &timers_state.vm_clock_lock);
> +            if (timers_state.vm_clock_warp_start == -1
> +                || timers_state.vm_clock_warp_start > clock) {
> +                timers_state.vm_clock_warp_start = clock;
> +            }
> +            seqlock_write_unlock(&timers_state.vm_clock_seqlock,
> +                                 &timers_state.vm_clock_lock);
> +            timer_mod_anticipate(timers_state.icount_warp_timer,
> +                                 clock + deadline);
> +        }
> +    } else if (deadline == 0) {
> +        qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
> +    }
> +}
> +
> +void icount_account_warp_timer(void)
> +{
> +    if (!use_icount || !icount_sleep) {
> +        return;
> +    }
> +
> +    /*
> +     * Nothing to do if the VM is stopped: QEMU_CLOCK_VIRTUAL timers
> +     * do not fire, so computing the deadline does not make sense.
> +     */
> +    if (!runstate_is_running()) {
> +        return;
> +    }
> +
> +    /* warp clock deterministically in record/replay mode */
> +    if (!replay_checkpoint(CHECKPOINT_CLOCK_WARP_ACCOUNT)) {
> +        return;
> +    }
> +
> +    timer_del(timers_state.icount_warp_timer);
> +    icount_warp_rt();
> +}
> +
> +void icount_configure(QemuOpts *opts, Error **errp)
> +{
> +    const char *option = qemu_opt_get(opts, "shift");
> +    bool sleep = qemu_opt_get_bool(opts, "sleep", true);
> +    bool align = qemu_opt_get_bool(opts, "align", false);
> +    long time_shift = -1;
> +
> +    if (!option && qemu_opt_get(opts, "align")) {
> +        error_setg(errp, "Please specify shift option when using align");
> +        return;
> +    }
> +
> +    if (align && !sleep) {
> +        error_setg(errp, "align=on and sleep=off are incompatible");
> +        return;
> +    }
> +
> +    if (strcmp(option, "auto") != 0) {
> +        if (qemu_strtol(option, NULL, 0, &time_shift) < 0
> +            || time_shift < 0 || time_shift > MAX_ICOUNT_SHIFT) {
> +            error_setg(errp, "icount: Invalid shift value");
> +            return;
> +        }
> +    } else if (icount_align_option) {
> +        error_setg(errp, "shift=auto and align=on are incompatible");
> +        return;
> +    } else if (!icount_sleep) {
> +        error_setg(errp, "shift=auto and sleep=off are incompatible");
> +        return;
> +    }
> +
> +    icount_sleep = sleep;
> +    if (icount_sleep) {
> +        timers_state.icount_warp_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
> +                                         icount_timer_cb, NULL);
> +    }
> +
> +    icount_align_option = align;
> +
> +    if (time_shift >= 0) {
> +        timers_state.icount_time_shift = time_shift;
> +        icount_enable_precise();
> +        return;
> +    }
> +
> +    icount_enable_adaptive();
> +
> +    /*
> +     * 125MIPS seems a reasonable initial guess at the guest speed.
> +     * It will be corrected fairly quickly anyway.
> +     */
> +    timers_state.icount_time_shift = 3;
> +
> +    /*
> +     * Have both realtime and virtual time triggers for speed adjustment.
> +     * The realtime trigger catches emulated time passing too slowly,
> +     * the virtual time trigger catches emulated time passing too fast.
> +     * Realtime triggers occur even when idle, so use them less frequently
> +     * than VM triggers.
> +     */
> +    timers_state.vm_clock_warp_start = -1;
> +    timers_state.icount_rt_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL_RT,
> +                                   icount_adjust_rt, NULL);
> +    timer_mod(timers_state.icount_rt_timer,
> +                   qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) + 1000);
> +    timers_state.icount_vm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                        icount_adjust_vm, NULL);
> +    timer_mod(timers_state.icount_vm_timer,
> +                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                   NANOSECONDS_PER_SECOND / 10);
> +}
> +
> +/* clock and ticks */
> +
> +static int64_t cpu_get_ticks_locked(void)
> +{
> +    int64_t ticks = timers_state.cpu_ticks_offset;
> +    if (timers_state.cpu_ticks_enabled) {
> +        ticks += cpu_get_host_ticks();
> +    }
> +
> +    if (timers_state.cpu_ticks_prev > ticks) {
> +        /* Non increasing ticks may happen if the host uses software suspend. */
> +        timers_state.cpu_ticks_offset += timers_state.cpu_ticks_prev - ticks;
> +        ticks = timers_state.cpu_ticks_prev;
> +    }
> +
> +    timers_state.cpu_ticks_prev = ticks;
> +    return ticks;
> +}
> +
> +/*
> + * return the time elapsed in VM between vm_start and vm_stop.  Unless
> + * icount is active, cpu_get_ticks() uses units of the host CPU cycle
> + * counter.
> + */
> +int64_t cpu_get_ticks(void)
> +{
> +    int64_t ticks;
> +
> +    if (icount_enabled()) {
> +        return icount_get();
> +    }
> +
> +    qemu_spin_lock(&timers_state.vm_clock_lock);
> +    ticks = cpu_get_ticks_locked();
> +    qemu_spin_unlock(&timers_state.vm_clock_lock);
> +    return ticks;
> +}
> +
> +static int64_t cpu_get_clock_locked(void)
> +{
> +    int64_t time;
> +
> +    time = timers_state.cpu_clock_offset;
> +    if (timers_state.cpu_ticks_enabled) {
> +        time += get_clock();
> +    }
> +
> +    return time;
> +}
> +
> +/*
> + * Return the monotonic time elapsed in VM, i.e.,
> + * the time between vm_start and vm_stop
> + */
> +int64_t cpu_get_clock(void)
> +{
> +    int64_t ti;
> +    unsigned start;
> +
> +    do {
> +        start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
> +        ti = cpu_get_clock_locked();
> +    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
> +
> +    return ti;
> +}
> +
> +/*
> + * enable cpu_get_ticks()
> + * Caller must hold BQL which serves as mutex for vm_clock_seqlock.
> + */
> +void cpu_enable_ticks(void)
> +{
> +    seqlock_write_lock(&timers_state.vm_clock_seqlock,
> +                       &timers_state.vm_clock_lock);
> +    if (!timers_state.cpu_ticks_enabled) {
> +        timers_state.cpu_ticks_offset -= cpu_get_host_ticks();
> +        timers_state.cpu_clock_offset -= get_clock();
> +        timers_state.cpu_ticks_enabled = 1;
> +    }
> +    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
> +                       &timers_state.vm_clock_lock);
> +}
> +
> +/*
> + * disable cpu_get_ticks() : the clock is stopped. You must not call
> + * cpu_get_ticks() after that.
> + * Caller must hold BQL which serves as mutex for vm_clock_seqlock.
> + */
> +void cpu_disable_ticks(void)
> +{
> +    seqlock_write_lock(&timers_state.vm_clock_seqlock,
> +                       &timers_state.vm_clock_lock);
> +    if (timers_state.cpu_ticks_enabled) {
> +        timers_state.cpu_ticks_offset += cpu_get_host_ticks();
> +        timers_state.cpu_clock_offset = cpu_get_clock_locked();
> +        timers_state.cpu_ticks_enabled = 0;
> +    }
> +    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
> +                         &timers_state.vm_clock_lock);
> +}
> +
> +void qtest_clock_warp(int64_t dest)
> +{
> +    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    AioContext *aio_context;
> +    assert(qtest_enabled());
> +    aio_context = qemu_get_aio_context();
> +    while (clock < dest) {
> +        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
> +                                                      QEMU_TIMER_ATTR_ALL);
> +        int64_t warp = qemu_soonest_timeout(dest - clock, deadline);
> +
> +        seqlock_write_lock(&timers_state.vm_clock_seqlock,
> +                           &timers_state.vm_clock_lock);
> +        atomic_set_i64(&timers_state.qemu_icount_bias,
> +                       timers_state.qemu_icount_bias + warp);
> +        seqlock_write_unlock(&timers_state.vm_clock_seqlock,
> +                             &timers_state.vm_clock_lock);
> +
> +        qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
> +        timerlist_run_timers(aio_context->tlg.tl[QEMU_CLOCK_VIRTUAL]);
> +        clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    }
> +    qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
> +}
> +
> +static bool icount_state_needed(void *opaque)
> +{
> +    return icount_enabled();
> +}
> +
> +static bool warp_timer_state_needed(void *opaque)
> +{
> +    TimersState *s = opaque;
> +    return s->icount_warp_timer != NULL;
> +}
> +
> +static bool adjust_timers_state_needed(void *opaque)
> +{
> +    TimersState *s = opaque;
> +    return s->icount_rt_timer != NULL;
> +}
> +
> +/*
> + * Subsection for warp timer migration is optional, because may not be created
> + */
> +static const VMStateDescription icount_vmstate_warp_timer = {
> +    .name = "timer/icount/warp_timer",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = warp_timer_state_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_INT64(vm_clock_warp_start, TimersState),
> +        VMSTATE_TIMER_PTR(icount_warp_timer, TimersState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription icount_vmstate_adjust_timers = {
> +    .name = "timer/icount/timers",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = adjust_timers_state_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_TIMER_PTR(icount_rt_timer, TimersState),
> +        VMSTATE_TIMER_PTR(icount_vm_timer, TimersState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +/*
> + * This is a subsection for icount migration.
> + */
> +static const VMStateDescription icount_vmstate_timers = {
> +    .name = "timer/icount",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = icount_state_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_INT64(qemu_icount_bias, TimersState),
> +        VMSTATE_INT64(qemu_icount, TimersState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * []) {
> +        &icount_vmstate_warp_timer,
> +        &icount_vmstate_adjust_timers,
> +        NULL
> +    }
> +};
> +
> +static const VMStateDescription vmstate_timers = {
> +    .name = "timer",
> +    .version_id = 2,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_INT64(cpu_ticks_offset, TimersState),
> +        VMSTATE_UNUSED(8),
> +        VMSTATE_INT64_V(cpu_clock_offset, TimersState, 2),
> +        VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * []) {
> +        &icount_vmstate_timers,
> +        NULL
> +    }
> +};
> +
> +static void do_nothing(CPUState *cpu, run_on_cpu_data unused)
> +{
> +}
> +
> +void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
> +{
> +    if (!icount_enabled() || type != QEMU_CLOCK_VIRTUAL) {
> +        qemu_notify_event();
> +        return;
> +    }
> +
> +    if (qemu_in_vcpu_thread()) {
> +        /*
> +         * A CPU is currently running; kick it back out to the
> +         * tcg_cpu_exec() loop so it will recalculate its
> +         * icount deadline immediately.
> +         */
> +        qemu_cpu_kick(current_cpu);
> +    } else if (first_cpu) {
> +        /*
> +         * qemu_cpu_kick is not enough to kick a halted CPU out of
> +         * qemu_tcg_wait_io_event.  async_run_on_cpu, instead,
> +         * causes cpu_thread_is_idle to return false.  This way,
> +         * handle_icount_deadline can run.
> +         * If we have no CPUs at all for some reason, we don't
> +         * need to do anything.
> +         */
> +        async_run_on_cpu(first_cpu, do_nothing, RUN_ON_CPU_NULL);
> +    }
> +}
> +
> +/* initialize this module and the cpu throttle for convenience as well */
> +void cpu_timers_init(void)
> +{
> +    seqlock_init(&timers_state.vm_clock_seqlock);
> +    qemu_spin_init(&timers_state.vm_clock_lock);
> +    vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
> +
> +    cpu_throttle_init();
> +}
> diff --git a/cpus.c b/cpus.c
> index 3a46a4fc2b..7e9f545be8 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -58,11 +58,10 @@
>  #include "hw/nmi.h"
>  #include "sysemu/replay.h"
>  #include "sysemu/runstate.h"
> +#include "sysemu/cpu-timers.h"
>  #include "hw/boards.h"
>  #include "hw/hw.h"
>  
> -#include "sysemu/cpu-throttle.h"
> -
>  #ifdef CONFIG_LINUX
>  
>  #include <sys/prctl.h>
> @@ -83,9 +82,6 @@
>  
>  static QemuMutex qemu_global_mutex;
>  
> -int64_t max_delay;
> -int64_t max_advance;
> -
>  bool cpu_is_stopped(CPUState *cpu)
>  {
>      return cpu->stopped || !runstate_is_running();
> @@ -106,7 +102,7 @@ static bool cpu_thread_is_idle(CPUState *cpu)
>      return true;
>  }
>  
> -static bool all_cpu_threads_idle(void)
> +bool all_cpu_threads_idle(void)
>  {
>      CPUState *cpu;
>  
> @@ -118,668 +114,8 @@ static bool all_cpu_threads_idle(void)
>      return true;
>  }
>  
> -/***********************************************************/
> -/* guest cycle counter */
> -
> -/* Protected by TimersState seqlock */
> -
> -static bool icount_sleep = true;
> -/* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
> -#define MAX_ICOUNT_SHIFT 10
> -
> -typedef struct TimersState {
> -    /* Protected by BQL.  */
> -    int64_t cpu_ticks_prev;
> -    int64_t cpu_ticks_offset;
> -
> -    /* Protect fields that can be respectively read outside the
> -     * BQL, and written from multiple threads.
> -     */
> -    QemuSeqLock vm_clock_seqlock;
> -    QemuSpin vm_clock_lock;
> -
> -    int16_t cpu_ticks_enabled;
> -
> -    /* Conversion factor from emulated instructions to virtual clock ticks.  */
> -    int16_t icount_time_shift;
> -
> -    /* Compensate for varying guest execution speed.  */
> -    int64_t qemu_icount_bias;
> -
> -    int64_t vm_clock_warp_start;
> -    int64_t cpu_clock_offset;
> -
> -    /* Only written by TCG thread */
> -    int64_t qemu_icount;
> -
> -    /* for adjusting icount */
> -    QEMUTimer *icount_rt_timer;
> -    QEMUTimer *icount_vm_timer;
> -    QEMUTimer *icount_warp_timer;
> -} TimersState;
> -
> -static TimersState timers_state;
>  bool mttcg_enabled;
>  
> -
> -/* The current number of executed instructions is based on what we
> - * originally budgeted minus the current state of the decrementing
> - * icount counters in extra/u16.low.
> - */
> -static int64_t cpu_get_icount_executed(CPUState *cpu)
> -{
> -    return (cpu->icount_budget -
> -            (cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra));
> -}
> -
> -/*
> - * Update the global shared timer_state.qemu_icount to take into
> - * account executed instructions. This is done by the TCG vCPU
> - * thread so the main-loop can see time has moved forward.
> - */
> -static void cpu_update_icount_locked(CPUState *cpu)
> -{
> -    int64_t executed = cpu_get_icount_executed(cpu);
> -    cpu->icount_budget -= executed;
> -
> -    atomic_set_i64(&timers_state.qemu_icount,
> -                   timers_state.qemu_icount + executed);
> -}
> -
> -/*
> - * Update the global shared timer_state.qemu_icount to take into
> - * account executed instructions. This is done by the TCG vCPU
> - * thread so the main-loop can see time has moved forward.
> - */
> -void cpu_update_icount(CPUState *cpu)
> -{
> -    seqlock_write_lock(&timers_state.vm_clock_seqlock,
> -                       &timers_state.vm_clock_lock);
> -    cpu_update_icount_locked(cpu);
> -    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
> -                         &timers_state.vm_clock_lock);
> -}
> -
> -static int64_t cpu_get_icount_raw_locked(void)
> -{
> -    CPUState *cpu = current_cpu;
> -
> -    if (cpu && cpu->running) {
> -        if (!cpu->can_do_io) {
> -            error_report("Bad icount read");
> -            exit(1);
> -        }
> -        /* Take into account what has run */
> -        cpu_update_icount_locked(cpu);
> -    }
> -    /* The read is protected by the seqlock, but needs atomic64 to avoid UB */
> -    return atomic_read_i64(&timers_state.qemu_icount);
> -}
> -
> -static int64_t cpu_get_icount_locked(void)
> -{
> -    int64_t icount = cpu_get_icount_raw_locked();
> -    return atomic_read_i64(&timers_state.qemu_icount_bias) +
> -        cpu_icount_to_ns(icount);
> -}
> -
> -int64_t cpu_get_icount_raw(void)
> -{
> -    int64_t icount;
> -    unsigned start;
> -
> -    do {
> -        start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
> -        icount = cpu_get_icount_raw_locked();
> -    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
> -
> -    return icount;
> -}
> -
> -/* Return the virtual CPU time, based on the instruction counter.  */
> -int64_t cpu_get_icount(void)
> -{
> -    int64_t icount;
> -    unsigned start;
> -
> -    do {
> -        start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
> -        icount = cpu_get_icount_locked();
> -    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
> -
> -    return icount;
> -}
> -
> -int64_t cpu_icount_to_ns(int64_t icount)
> -{
> -    return icount << atomic_read(&timers_state.icount_time_shift);
> -}
> -
> -static int64_t cpu_get_ticks_locked(void)
> -{
> -    int64_t ticks = timers_state.cpu_ticks_offset;
> -    if (timers_state.cpu_ticks_enabled) {
> -        ticks += cpu_get_host_ticks();
> -    }
> -
> -    if (timers_state.cpu_ticks_prev > ticks) {
> -        /* Non increasing ticks may happen if the host uses software suspend.  */
> -        timers_state.cpu_ticks_offset += timers_state.cpu_ticks_prev - ticks;
> -        ticks = timers_state.cpu_ticks_prev;
> -    }
> -
> -    timers_state.cpu_ticks_prev = ticks;
> -    return ticks;
> -}
> -
> -/* return the time elapsed in VM between vm_start and vm_stop.  Unless
> - * icount is active, cpu_get_ticks() uses units of the host CPU cycle
> - * counter.
> - */
> -int64_t cpu_get_ticks(void)
> -{
> -    int64_t ticks;
> -
> -    if (use_icount) {
> -        return cpu_get_icount();
> -    }
> -
> -    qemu_spin_lock(&timers_state.vm_clock_lock);
> -    ticks = cpu_get_ticks_locked();
> -    qemu_spin_unlock(&timers_state.vm_clock_lock);
> -    return ticks;
> -}
> -
> -static int64_t cpu_get_clock_locked(void)
> -{
> -    int64_t time;
> -
> -    time = timers_state.cpu_clock_offset;
> -    if (timers_state.cpu_ticks_enabled) {
> -        time += get_clock();
> -    }
> -
> -    return time;
> -}
> -
> -/* Return the monotonic time elapsed in VM, i.e.,
> - * the time between vm_start and vm_stop
> - */
> -int64_t cpu_get_clock(void)
> -{
> -    int64_t ti;
> -    unsigned start;
> -
> -    do {
> -        start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
> -        ti = cpu_get_clock_locked();
> -    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
> -
> -    return ti;
> -}
> -
> -/* enable cpu_get_ticks()
> - * Caller must hold BQL which serves as mutex for vm_clock_seqlock.
> - */
> -void cpu_enable_ticks(void)
> -{
> -    seqlock_write_lock(&timers_state.vm_clock_seqlock,
> -                       &timers_state.vm_clock_lock);
> -    if (!timers_state.cpu_ticks_enabled) {
> -        timers_state.cpu_ticks_offset -= cpu_get_host_ticks();
> -        timers_state.cpu_clock_offset -= get_clock();
> -        timers_state.cpu_ticks_enabled = 1;
> -    }
> -    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
> -                       &timers_state.vm_clock_lock);
> -}
> -
> -/* disable cpu_get_ticks() : the clock is stopped. You must not call
> - * cpu_get_ticks() after that.
> - * Caller must hold BQL which serves as mutex for vm_clock_seqlock.
> - */
> -void cpu_disable_ticks(void)
> -{
> -    seqlock_write_lock(&timers_state.vm_clock_seqlock,
> -                       &timers_state.vm_clock_lock);
> -    if (timers_state.cpu_ticks_enabled) {
> -        timers_state.cpu_ticks_offset += cpu_get_host_ticks();
> -        timers_state.cpu_clock_offset = cpu_get_clock_locked();
> -        timers_state.cpu_ticks_enabled = 0;
> -    }
> -    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
> -                         &timers_state.vm_clock_lock);
> -}
> -
> -/* Correlation between real and virtual time is always going to be
> -   fairly approximate, so ignore small variation.
> -   When the guest is idle real and virtual time will be aligned in
> -   the IO wait loop.  */
> -#define ICOUNT_WOBBLE (NANOSECONDS_PER_SECOND / 10)
> -
> -static void icount_adjust(void)
> -{
> -    int64_t cur_time;
> -    int64_t cur_icount;
> -    int64_t delta;
> -
> -    /* Protected by TimersState mutex.  */
> -    static int64_t last_delta;
> -
> -    /* If the VM is not running, then do nothing.  */
> -    if (!runstate_is_running()) {
> -        return;
> -    }
> -
> -    seqlock_write_lock(&timers_state.vm_clock_seqlock,
> -                       &timers_state.vm_clock_lock);
> -    cur_time = cpu_get_clock_locked();
> -    cur_icount = cpu_get_icount_locked();
> -
> -    delta = cur_icount - cur_time;
> -    /* FIXME: This is a very crude algorithm, somewhat prone to oscillation.  */
> -    if (delta > 0
> -        && last_delta + ICOUNT_WOBBLE < delta * 2
> -        && timers_state.icount_time_shift > 0) {
> -        /* The guest is getting too far ahead.  Slow time down.  */
> -        atomic_set(&timers_state.icount_time_shift,
> -                   timers_state.icount_time_shift - 1);
> -    }
> -    if (delta < 0
> -        && last_delta - ICOUNT_WOBBLE > delta * 2
> -        && timers_state.icount_time_shift < MAX_ICOUNT_SHIFT) {
> -        /* The guest is getting too far behind.  Speed time up.  */
> -        atomic_set(&timers_state.icount_time_shift,
> -                   timers_state.icount_time_shift + 1);
> -    }
> -    last_delta = delta;
> -    atomic_set_i64(&timers_state.qemu_icount_bias,
> -                   cur_icount - (timers_state.qemu_icount
> -                                 << timers_state.icount_time_shift));
> -    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
> -                         &timers_state.vm_clock_lock);
> -}
> -
> -static void icount_adjust_rt(void *opaque)
> -{
> -    timer_mod(timers_state.icount_rt_timer,
> -              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) + 1000);
> -    icount_adjust();
> -}
> -
> -static void icount_adjust_vm(void *opaque)
> -{
> -    timer_mod(timers_state.icount_vm_timer,
> -                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> -                   NANOSECONDS_PER_SECOND / 10);
> -    icount_adjust();
> -}
> -
> -static int64_t qemu_icount_round(int64_t count)
> -{
> -    int shift = atomic_read(&timers_state.icount_time_shift);
> -    return (count + (1 << shift) - 1) >> shift;
> -}
> -
> -static void icount_warp_rt(void)
> -{
> -    unsigned seq;
> -    int64_t warp_start;
> -
> -    /* The icount_warp_timer is rescheduled soon after vm_clock_warp_start
> -     * changes from -1 to another value, so the race here is okay.
> -     */
> -    do {
> -        seq = seqlock_read_begin(&timers_state.vm_clock_seqlock);
> -        warp_start = timers_state.vm_clock_warp_start;
> -    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, seq));
> -
> -    if (warp_start == -1) {
> -        return;
> -    }
> -
> -    seqlock_write_lock(&timers_state.vm_clock_seqlock,
> -                       &timers_state.vm_clock_lock);
> -    if (runstate_is_running()) {
> -        int64_t clock = REPLAY_CLOCK_LOCKED(REPLAY_CLOCK_VIRTUAL_RT,
> -                                            cpu_get_clock_locked());
> -        int64_t warp_delta;
> -
> -        warp_delta = clock - timers_state.vm_clock_warp_start;
> -        if (use_icount == 2) {
> -            /*
> -             * In adaptive mode, do not let QEMU_CLOCK_VIRTUAL run too
> -             * far ahead of real time.
> -             */
> -            int64_t cur_icount = cpu_get_icount_locked();
> -            int64_t delta = clock - cur_icount;
> -            warp_delta = MIN(warp_delta, delta);
> -        }
> -        atomic_set_i64(&timers_state.qemu_icount_bias,
> -                       timers_state.qemu_icount_bias + warp_delta);
> -    }
> -    timers_state.vm_clock_warp_start = -1;
> -    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
> -                       &timers_state.vm_clock_lock);
> -
> -    if (qemu_clock_expired(QEMU_CLOCK_VIRTUAL)) {
> -        qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
> -    }
> -}
> -
> -static void icount_timer_cb(void *opaque)
> -{
> -    /* No need for a checkpoint because the timer already synchronizes
> -     * with CHECKPOINT_CLOCK_VIRTUAL_RT.
> -     */
> -    icount_warp_rt();
> -}
> -
> -void qtest_clock_warp(int64_t dest)
> -{
> -    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    AioContext *aio_context;
> -    assert(qtest_enabled());
> -    aio_context = qemu_get_aio_context();
> -    while (clock < dest) {
> -        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
> -                                                      QEMU_TIMER_ATTR_ALL);
> -        int64_t warp = qemu_soonest_timeout(dest - clock, deadline);
> -
> -        seqlock_write_lock(&timers_state.vm_clock_seqlock,
> -                           &timers_state.vm_clock_lock);
> -        atomic_set_i64(&timers_state.qemu_icount_bias,
> -                       timers_state.qemu_icount_bias + warp);
> -        seqlock_write_unlock(&timers_state.vm_clock_seqlock,
> -                             &timers_state.vm_clock_lock);
> -
> -        qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
> -        timerlist_run_timers(aio_context->tlg.tl[QEMU_CLOCK_VIRTUAL]);
> -        clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    }
> -    qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
> -}
> -
> -void qemu_start_warp_timer(void)
> -{
> -    int64_t clock;
> -    int64_t deadline;
> -
> -    if (!use_icount) {
> -        return;
> -    }
> -
> -    /* Nothing to do if the VM is stopped: QEMU_CLOCK_VIRTUAL timers
> -     * do not fire, so computing the deadline does not make sense.
> -     */
> -    if (!runstate_is_running()) {
> -        return;
> -    }
> -
> -    if (replay_mode != REPLAY_MODE_PLAY) {
> -        if (!all_cpu_threads_idle()) {
> -            return;
> -        }
> -
> -        if (qtest_enabled()) {
> -            /* When testing, qtest commands advance icount.  */
> -            return;
> -        }
> -
> -        replay_checkpoint(CHECKPOINT_CLOCK_WARP_START);
> -    } else {
> -        /* warp clock deterministically in record/replay mode */
> -        if (!replay_checkpoint(CHECKPOINT_CLOCK_WARP_START)) {
> -            /* vCPU is sleeping and warp can't be started.
> -               It is probably a race condition: notification sent
> -               to vCPU was processed in advance and vCPU went to sleep.
> -               Therefore we have to wake it up for doing someting. */
> -            if (replay_has_checkpoint()) {
> -                qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
> -            }
> -            return;
> -        }
> -    }
> -
> -    /* We want to use the earliest deadline from ALL vm_clocks */
> -    clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT);
> -    deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
> -                                          ~QEMU_TIMER_ATTR_EXTERNAL);
> -    if (deadline < 0) {
> -        static bool notified;
> -        if (!icount_sleep && !notified) {
> -            warn_report("icount sleep disabled and no active timers");
> -            notified = true;
> -        }
> -        return;
> -    }
> -
> -    if (deadline > 0) {
> -        /*
> -         * Ensure QEMU_CLOCK_VIRTUAL proceeds even when the virtual CPU goes to
> -         * sleep.  Otherwise, the CPU might be waiting for a future timer
> -         * interrupt to wake it up, but the interrupt never comes because
> -         * the vCPU isn't running any insns and thus doesn't advance the
> -         * QEMU_CLOCK_VIRTUAL.
> -         */
> -        if (!icount_sleep) {
> -            /*
> -             * We never let VCPUs sleep in no sleep icount mode.
> -             * If there is a pending QEMU_CLOCK_VIRTUAL timer we just advance
> -             * to the next QEMU_CLOCK_VIRTUAL event and notify it.
> -             * It is useful when we want a deterministic execution time,
> -             * isolated from host latencies.
> -             */
> -            seqlock_write_lock(&timers_state.vm_clock_seqlock,
> -                               &timers_state.vm_clock_lock);
> -            atomic_set_i64(&timers_state.qemu_icount_bias,
> -                           timers_state.qemu_icount_bias + deadline);
> -            seqlock_write_unlock(&timers_state.vm_clock_seqlock,
> -                                 &timers_state.vm_clock_lock);
> -            qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
> -        } else {
> -            /*
> -             * We do stop VCPUs and only advance QEMU_CLOCK_VIRTUAL after some
> -             * "real" time, (related to the time left until the next event) has
> -             * passed. The QEMU_CLOCK_VIRTUAL_RT clock will do this.
> -             * This avoids that the warps are visible externally; for example,
> -             * you will not be sending network packets continuously instead of
> -             * every 100ms.
> -             */
> -            seqlock_write_lock(&timers_state.vm_clock_seqlock,
> -                               &timers_state.vm_clock_lock);
> -            if (timers_state.vm_clock_warp_start == -1
> -                || timers_state.vm_clock_warp_start > clock) {
> -                timers_state.vm_clock_warp_start = clock;
> -            }
> -            seqlock_write_unlock(&timers_state.vm_clock_seqlock,
> -                                 &timers_state.vm_clock_lock);
> -            timer_mod_anticipate(timers_state.icount_warp_timer,
> -                                 clock + deadline);
> -        }
> -    } else if (deadline == 0) {
> -        qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
> -    }
> -}
> -
> -static void qemu_account_warp_timer(void)
> -{
> -    if (!use_icount || !icount_sleep) {
> -        return;
> -    }
> -
> -    /* Nothing to do if the VM is stopped: QEMU_CLOCK_VIRTUAL timers
> -     * do not fire, so computing the deadline does not make sense.
> -     */
> -    if (!runstate_is_running()) {
> -        return;
> -    }
> -
> -    /* warp clock deterministically in record/replay mode */
> -    if (!replay_checkpoint(CHECKPOINT_CLOCK_WARP_ACCOUNT)) {
> -        return;
> -    }
> -
> -    timer_del(timers_state.icount_warp_timer);
> -    icount_warp_rt();
> -}
> -
> -static bool icount_state_needed(void *opaque)
> -{
> -    return use_icount;
> -}
> -
> -static bool warp_timer_state_needed(void *opaque)
> -{
> -    TimersState *s = opaque;
> -    return s->icount_warp_timer != NULL;
> -}
> -
> -static bool adjust_timers_state_needed(void *opaque)
> -{
> -    TimersState *s = opaque;
> -    return s->icount_rt_timer != NULL;
> -}
> -
> -/*
> - * Subsection for warp timer migration is optional, because may not be created
> - */
> -static const VMStateDescription icount_vmstate_warp_timer = {
> -    .name = "timer/icount/warp_timer",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> -    .needed = warp_timer_state_needed,
> -    .fields = (VMStateField[]) {
> -        VMSTATE_INT64(vm_clock_warp_start, TimersState),
> -        VMSTATE_TIMER_PTR(icount_warp_timer, TimersState),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
> -static const VMStateDescription icount_vmstate_adjust_timers = {
> -    .name = "timer/icount/timers",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> -    .needed = adjust_timers_state_needed,
> -    .fields = (VMStateField[]) {
> -        VMSTATE_TIMER_PTR(icount_rt_timer, TimersState),
> -        VMSTATE_TIMER_PTR(icount_vm_timer, TimersState),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
> -/*
> - * This is a subsection for icount migration.
> - */
> -static const VMStateDescription icount_vmstate_timers = {
> -    .name = "timer/icount",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> -    .needed = icount_state_needed,
> -    .fields = (VMStateField[]) {
> -        VMSTATE_INT64(qemu_icount_bias, TimersState),
> -        VMSTATE_INT64(qemu_icount, TimersState),
> -        VMSTATE_END_OF_LIST()
> -    },
> -    .subsections = (const VMStateDescription*[]) {
> -        &icount_vmstate_warp_timer,
> -        &icount_vmstate_adjust_timers,
> -        NULL
> -    }
> -};
> -
> -static const VMStateDescription vmstate_timers = {
> -    .name = "timer",
> -    .version_id = 2,
> -    .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> -        VMSTATE_INT64(cpu_ticks_offset, TimersState),
> -        VMSTATE_UNUSED(8),
> -        VMSTATE_INT64_V(cpu_clock_offset, TimersState, 2),
> -        VMSTATE_END_OF_LIST()
> -    },
> -    .subsections = (const VMStateDescription*[]) {
> -        &icount_vmstate_timers,
> -        NULL
> -    }
> -};
> -
> -void cpu_ticks_init(void)
> -{
> -    seqlock_init(&timers_state.vm_clock_seqlock);
> -    qemu_spin_init(&timers_state.vm_clock_lock);
> -    vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
> -    cpu_throttle_init();
> -}
> -
> -void configure_icount(QemuOpts *opts, Error **errp)
> -{
> -    const char *option = qemu_opt_get(opts, "shift");
> -    bool sleep = qemu_opt_get_bool(opts, "sleep", true);
> -    bool align = qemu_opt_get_bool(opts, "align", false);
> -    long time_shift = -1;
> -
> -    if (!option && qemu_opt_get(opts, "align")) {
> -        error_setg(errp, "Please specify shift option when using align");
> -        return;
> -    }
> -
> -    if (align && !sleep) {
> -        error_setg(errp, "align=on and sleep=off are incompatible");
> -        return;
> -    }
> -
> -    if (strcmp(option, "auto") != 0) {
> -        if (qemu_strtol(option, NULL, 0, &time_shift) < 0
> -            || time_shift < 0 || time_shift > MAX_ICOUNT_SHIFT) {
> -            error_setg(errp, "icount: Invalid shift value");
> -            return;
> -        }
> -    } else if (icount_align_option) {
> -        error_setg(errp, "shift=auto and align=on are incompatible");
> -        return;
> -    } else if (!icount_sleep) {
> -        error_setg(errp, "shift=auto and sleep=off are incompatible");
> -        return;
> -    }
> -
> -    icount_sleep = sleep;
> -    if (icount_sleep) {
> -        timers_state.icount_warp_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
> -                                         icount_timer_cb, NULL);
> -    }
> -
> -    icount_align_option = align;
> -
> -    if (time_shift >= 0) {
> -        timers_state.icount_time_shift = time_shift;
> -        use_icount = 1;
> -        return;
> -    }
> -
> -    use_icount = 2;
> -
> -    /* 125MIPS seems a reasonable initial guess at the guest speed.
> -       It will be corrected fairly quickly anyway.  */
> -    timers_state.icount_time_shift = 3;
> -
> -    /* Have both realtime and virtual time triggers for speed adjustment.
> -       The realtime trigger catches emulated time passing too slowly,
> -       the virtual time trigger catches emulated time passing too fast.
> -       Realtime triggers occur even when idle, so use them less frequently
> -       than VM triggers.  */
> -    timers_state.vm_clock_warp_start = -1;
> -    timers_state.icount_rt_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL_RT,
> -                                   icount_adjust_rt, NULL);
> -    timer_mod(timers_state.icount_rt_timer,
> -                   qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) + 1000);
> -    timers_state.icount_vm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                        icount_adjust_vm, NULL);
> -    timer_mod(timers_state.icount_vm_timer,
> -                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> -                   NANOSECONDS_PER_SECOND / 10);
> -}
> -
>  /***********************************************************/
>  /* TCG vCPU kick timer
>   *
> @@ -824,35 +160,6 @@ static void qemu_cpu_kick_rr_cpus(void)
>      };
>  }
>  
> -static void do_nothing(CPUState *cpu, run_on_cpu_data unused)
> -{
> -}
> -
> -void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
> -{
> -    if (!use_icount || type != QEMU_CLOCK_VIRTUAL) {
> -        qemu_notify_event();
> -        return;
> -    }
> -
> -    if (qemu_in_vcpu_thread()) {
> -        /* A CPU is currently running; kick it back out to the
> -         * tcg_cpu_exec() loop so it will recalculate its
> -         * icount deadline immediately.
> -         */
> -        qemu_cpu_kick(current_cpu);
> -    } else if (first_cpu) {
> -        /* qemu_cpu_kick is not enough to kick a halted CPU out of
> -         * qemu_tcg_wait_io_event.  async_run_on_cpu, instead,
> -         * causes cpu_thread_is_idle to return false.  This way,
> -         * handle_icount_deadline can run.
> -         * If we have no CPUs at all for some reason, we don't
> -         * need to do anything.
> -         */
> -        async_run_on_cpu(first_cpu, do_nothing, RUN_ON_CPU_NULL);
> -    }
> -}
> -
>  static void kick_tcg_thread(void *opaque)
>  {
>      timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
> @@ -1254,7 +561,7 @@ static int64_t tcg_get_icount_limit(void)
>              deadline = INT32_MAX;
>          }
>  
> -        return qemu_icount_round(deadline);
> +        return icount_round(deadline);
>      } else {
>          return replay_get_instructions();
>      }
> @@ -1263,7 +570,7 @@ static int64_t tcg_get_icount_limit(void)
>  static void handle_icount_deadline(void)
>  {
>      assert(qemu_in_vcpu_thread());
> -    if (use_icount) {
> +    if (icount_enabled()) {
>          int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
>                                                        QEMU_TIMER_ATTR_ALL);
>  
> @@ -1277,7 +584,7 @@ static void handle_icount_deadline(void)
>  
>  static void prepare_icount_for_run(CPUState *cpu)
>  {
> -    if (use_icount) {
> +    if (icount_enabled()) {
>          int insns_left;
>  
>          /* These should always be cleared by process_icount_data after
> @@ -1298,9 +605,9 @@ static void prepare_icount_for_run(CPUState *cpu)
>  
>  static void process_icount_data(CPUState *cpu)
>  {
> -    if (use_icount) {
> +    if (icount_enabled()) {
>          /* Account for executed instructions */
> -        cpu_update_icount(cpu);
> +        icount_update(cpu);
>  
>          /* Reset the counters */
>          cpu_neg(cpu)->icount_decr.u16.low = 0;
> @@ -1401,7 +708,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
>          replay_mutex_lock();
>          qemu_mutex_lock_iothread();
>          /* Account partial waits to QEMU_CLOCK_VIRTUAL.  */
> -        qemu_account_warp_timer();
> +        icount_account_warp_timer();
>  
>          /* Run the timers here.  This is much more efficient than
>           * waking up the I/O thread and waiting for completion.
> @@ -1459,7 +766,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
>              atomic_mb_set(&cpu->exit_request, 0);
>          }
>  
> -        if (use_icount && all_cpu_threads_idle()) {
> +        if (icount_enabled() && all_cpu_threads_idle()) {
>              /*
>               * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
>               * in the main_loop, wake it up in order to start the warp timer.
> @@ -1612,7 +919,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
>      CPUState *cpu = arg;
>  
>      assert(tcg_enabled());
> -    g_assert(!use_icount);
> +    g_assert(!icount_enabled());
>  
>      rcu_register_thread();
>      tcg_register_thread();
> @@ -2191,21 +1498,3 @@ void qmp_inject_nmi(Error **errp)
>      nmi_monitor_handle(monitor_get_cpu_index(), errp);
>  }
>  
> -void dump_drift_info(void)
> -{
> -    if (!use_icount) {
> -        return;
> -    }
> -
> -    qemu_printf("Host - Guest clock  %"PRIi64" ms\n",
> -                (cpu_get_clock() - cpu_get_icount())/SCALE_MS);
> -    if (icount_align_option) {
> -        qemu_printf("Max guest delay     %"PRIi64" ms\n",
> -                    -max_delay / SCALE_MS);
> -        qemu_printf("Max guest advance   %"PRIi64" ms\n",
> -                    max_advance / SCALE_MS);
> -    } else {
> -        qemu_printf("Max guest delay     NA\n");
> -        qemu_printf("Max guest advance   NA\n");
> -    }
> -}
> diff --git a/docs/replay.txt b/docs/replay.txt
> index 70c27edb36..8952e6d852 100644
> --- a/docs/replay.txt
> +++ b/docs/replay.txt
> @@ -184,11 +184,11 @@ is then incremented (which is called "warping" the virtual clock) as
>  soon as the timer fires or the CPUs need to go out of the idle state.
>  Two functions are used for this purpose; because these actions change
>  virtual machine state and must be deterministic, each of them creates a
> -checkpoint.  qemu_start_warp_timer checks if the CPUs are idle and if so
> -starts accounting real time to virtual clock.  qemu_account_warp_timer
> +checkpoint.  icount_start_warp_timer checks if the CPUs are idle and if so
> +starts accounting real time to virtual clock.  icount_account_warp_timer
>  is called when the CPUs get an interrupt or when the warp timer fires,
>  and it warps the virtual clock by the amount of real time that has passed
> -since qemu_start_warp_timer.
> +since icount_start_warp_timer.
>  
>  Bottom halves
>  -------------
> diff --git a/exec.c b/exec.c
> index 5162f0d12f..db9a90469b 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -104,10 +104,6 @@ uintptr_t qemu_host_page_size;
>  intptr_t qemu_host_page_mask;
>  
>  #if !defined(CONFIG_USER_ONLY)
> -/* 0 = Do not count executed instructions.
> -   1 = Precise instruction counting.
> -   2 = Adaptive rate instruction counting.  */
> -int use_icount;
>  
>  typedef struct PhysPageEntry PhysPageEntry;
>  
> diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
> index b5a54e2536..6c9f33208a 100644
> --- a/hw/core/ptimer.c
> +++ b/hw/core/ptimer.c
> @@ -7,11 +7,11 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qemu/timer.h"
>  #include "hw/ptimer.h"
>  #include "migration/vmstate.h"
>  #include "qemu/host-utils.h"
>  #include "sysemu/replay.h"
> +#include "sysemu/cpu-timers.h"
>  #include "sysemu/qtest.h"
>  #include "block/aio.h"
>  #include "sysemu/cpus.h"
> @@ -134,7 +134,7 @@ static void ptimer_reload(ptimer_state *s, int delta_adjust)
>       * on the current generation of host machines.
>       */
>  
> -    if (s->enabled == 1 && (delta * period < 10000) && !use_icount) {
> +    if (s->enabled == 1 && (delta * period < 10000) && !icount_enabled()) {
>          period = 10000 / delta;
>          period_frac = 0;
>      }
> @@ -217,7 +217,7 @@ uint64_t ptimer_get_count(ptimer_state *s)
>              uint32_t period_frac = s->period_frac;
>              uint64_t period = s->period;
>  
> -            if (!oneshot && (s->delta * period < 10000) && !use_icount) {
> +            if (!oneshot && (s->delta * period < 10000) && !icount_enabled()) {
>                  period = 10000 / s->delta;
>                  period_frac = 0;
>              }
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 7a3bc7ab66..002b3cabc2 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -34,6 +34,7 @@
>  #include "sysemu/numa.h"
>  #include "sysemu/replay.h"
>  #include "sysemu/sysemu.h"
> +#include "sysemu/cpu-timers.h"
>  #include "trace.h"
>  
>  #include "hw/i386/x86.h"
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index d14374bdd4..49eedd714d 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -409,8 +409,12 @@ static inline bool tlb_hit(target_ulong tlb_addr, target_ulong addr)
>      return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
>  }
>  
> +#ifdef CONFIG_TCG
> +void dump_drift_info(void);
>  void dump_exec_info(void);
>  void dump_opcount_info(void);
> +#endif /* CONFIG_TCG */
> +
>  #endif /* !CONFIG_USER_ONLY */
>  
>  int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 8792bea07a..c1f51e37af 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -25,7 +25,7 @@
>  #ifdef CONFIG_TCG
>  #include "exec/cpu_ldst.h"
>  #endif
> -#include "sysemu/cpus.h"
> +#include "sysemu/cpu-timers.h"
>  
>  /* allow to see translation results - the slowdown should be negligible, so we leave it */
>  #define DEBUG_DISAS
> @@ -489,7 +489,7 @@ static inline uint32_t tb_cflags(const TranslationBlock *tb)
>  static inline uint32_t curr_cflags(void)
>  {
>      return (parallel_cpus ? CF_PARALLEL : 0)
> -         | (use_icount ? CF_USE_ICOUNT : 0);
> +         | (icount_enabled() ? CF_USE_ICOUNT : 0);
>  }
>  
>  /* TranslationBlock invalidate API */
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index 6a8b48b5a9..c54b1b2813 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -224,13 +224,6 @@ void qemu_clock_notify(QEMUClockType type);
>   */
>  void qemu_clock_enable(QEMUClockType type, bool enabled);
>  
> -/**
> - * qemu_start_warp_timer:
> - *
> - * Starts a timer for virtual clock update
> - */
> -void qemu_start_warp_timer(void);
> -
>  /**
>   * qemu_clock_run_timers:
>   * @type: clock on which to operate
> @@ -791,12 +784,6 @@ static inline int64_t qemu_soonest_timeout(int64_t timeout1, int64_t timeout2)
>   */
>  void init_clocks(QEMUTimerListNotifyCB *notify_cb);
>  
> -int64_t cpu_get_ticks(void);
> -/* Caller must hold BQL */
> -void cpu_enable_ticks(void);
> -/* Caller must hold BQL */
> -void cpu_disable_ticks(void);
> -
>  static inline int64_t get_max_clock_jump(void)
>  {
>      /* This should be small enough to prevent excessive interrupts from being
> @@ -850,13 +837,6 @@ static inline int64_t get_clock(void)
>  }
>  #endif
>  
> -/* icount */
> -int64_t cpu_get_icount_raw(void);
> -int64_t cpu_get_icount(void);
> -int64_t cpu_get_clock(void);
> -int64_t cpu_icount_to_ns(int64_t icount);
> -void    cpu_update_icount(CPUState *cpu);
> -
>  /*******************************************/
>  /* host CPU ticks (if available) */
>  
> diff --git a/include/sysemu/cpu-timers.h b/include/sysemu/cpu-timers.h
> new file mode 100644
> index 0000000000..3db579fde7
> --- /dev/null
> +++ b/include/sysemu/cpu-timers.h
> @@ -0,0 +1,73 @@
> +#ifndef SYSEMU_CPU_TIMERS_H
> +#define SYSEMU_CPU_TIMERS_H
> +
> +#include "qemu/timer.h"
> +
> +/* init the whole cpu timers API, including icount, ticks, and cpu_throttle */
> +void cpu_timers_init(void);
> +
> +/* icount - Instruction Counter API */
> +
> +/*
> + * Return the icount enablement state:
> + *
> + * 0 = Disabled - Do not count executed instructions.
> + * 1 = Enabled - Fixed conversion of insn to ns via "shift" option
> + * 2 = Enabled - Runtime adaptive algorithm to compute shift
> + */
> +int icount_enabled(void);
> +/*
> + * Update the icount with the executed instructions. Called by
> + * cpus-tcg vCPU thread so the main-loop can see time has moved forward.
> + */
> +void icount_update(CPUState *cpu);
> +
> +/* get raw icount value */
> +int64_t icount_get_raw(void);
> +
> +/* return the virtual CPU time in ns, based on the instruction counter. */
> +int64_t icount_get(void);
> +/*
> + * convert an instruction counter value to ns, based on the icount shift.
> + * This shift is set as a fixed value with the icount "shift" option
> + * (precise mode), or it is constantly approximated and corrected at
> + * runtime in adaptive mode.
> + */
> +int64_t icount_to_ns(int64_t icount);
> +
> +/* configure the icount options, including "shift" */
> +void icount_configure(QemuOpts *opts, Error **errp);
> +
> +/* used by tcg vcpu thread to calc icount budget */
> +int64_t icount_round(int64_t count);
> +
> +/* if the CPUs are idle, start accounting real time to virtual clock. */
> +void icount_start_warp_timer(void);
> +void icount_account_warp_timer(void);
> +
> +/*
> + * CPU Ticks and Clock
> + */
> +
> +/* Caller must hold BQL */
> +void cpu_enable_ticks(void);
> +/* Caller must hold BQL */
> +void cpu_disable_ticks(void);
> +
> +/*
> + * return the time elapsed in VM between vm_start and vm_stop.  Unless
> + * icount is active, cpu_get_ticks() uses units of the host CPU cycle
> + * counter.
> + */
> +int64_t cpu_get_ticks(void);
> +
> +/*
> + * Returns the monotonic time elapsed in VM, i.e.,
> + * the time between vm_start and vm_stop
> + */
> +int64_t cpu_get_clock(void);
> +
> +void qemu_timer_notify_cb(void *opaque, QEMUClockType type);
> +void qtest_clock_warp(int64_t dest);
> +
> +#endif /* SYSEMU_CPU_TIMERS_H */
> diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
> index 3c1da6a018..149de000a0 100644
> --- a/include/sysemu/cpus.h
> +++ b/include/sysemu/cpus.h
> @@ -4,33 +4,23 @@
>  #include "qemu/timer.h"
>  
>  /* cpus.c */
> +bool all_cpu_threads_idle(void);
>  bool qemu_in_vcpu_thread(void);
>  void qemu_init_cpu_loop(void);
>  void resume_all_vcpus(void);
>  void pause_all_vcpus(void);
>  void cpu_stop_current(void);
> -void cpu_ticks_init(void);
>  
> -void configure_icount(QemuOpts *opts, Error **errp);
> -extern int use_icount;
>  extern int icount_align_option;
>  
> -/* drift information for info jit command */
> -extern int64_t max_delay;
> -extern int64_t max_advance;
> -void dump_drift_info(void);
> -
>  /* Unblock cpu */
>  void qemu_cpu_kick_self(void);
> -void qemu_timer_notify_cb(void *opaque, QEMUClockType type);
>  
>  void cpu_synchronize_all_states(void);
>  void cpu_synchronize_all_post_reset(void);
>  void cpu_synchronize_all_post_init(void);
>  void cpu_synchronize_all_pre_loadvm(void);
>  
> -void qtest_clock_warp(int64_t dest);
> -
>  #ifndef CONFIG_USER_ONLY
>  /* vl.c */
>  /* *-user doesn't have configurable SMP topology */
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index 5471bb514d..a140d69a73 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -109,12 +109,12 @@ int64_t replay_read_clock(ReplayClockKind kind);
>  #define REPLAY_CLOCK(clock, value)                                      \
>      (replay_mode == REPLAY_MODE_PLAY ? replay_read_clock((clock))       \
>          : replay_mode == REPLAY_MODE_RECORD                             \
> -            ? replay_save_clock((clock), (value), cpu_get_icount_raw()) \
> +            ? replay_save_clock((clock), (value), icount_get_raw()) \
>          : (value))
>  #define REPLAY_CLOCK_LOCKED(clock, value)                               \
>      (replay_mode == REPLAY_MODE_PLAY ? replay_read_clock((clock))       \
>          : replay_mode == REPLAY_MODE_RECORD                             \
> -            ? replay_save_clock((clock), (value), cpu_get_icount_raw_locked()) \
> +            ? replay_save_clock((clock), (value), icount_get_raw_locked()) \
>          : (value))
>  
>  /* Processing data from random generators */
> diff --git a/qtest.c b/qtest.c
> index 5672b75c35..a1b92853c9 100644
> --- a/qtest.c
> +++ b/qtest.c
> @@ -21,7 +21,7 @@
>  #include "exec/memory.h"
>  #include "hw/irq.h"
>  #include "sysemu/accel.h"
> -#include "sysemu/cpus.h"
> +#include "sysemu/cpu-timers.h"
>  #include "qemu/config-file.h"
>  #include "qemu/option.h"
>  #include "qemu/error-report.h"
> diff --git a/replay/replay.c b/replay/replay.c
> index 706c7b4f4b..9896a3b6f5 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -11,10 +11,10 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "sysemu/cpu-timers.h"
>  #include "sysemu/replay.h"
>  #include "sysemu/runstate.h"
>  #include "replay-internal.h"
> -#include "qemu/timer.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/option.h"
>  #include "sysemu/cpus.h"
> @@ -64,7 +64,7 @@ bool replay_next_event_is(int event)
>  
>  uint64_t replay_get_current_icount(void)
>  {
> -    return cpu_get_icount_raw();
> +    return icount_get_raw();
>  }
>  
>  int replay_get_instructions(void)
> @@ -345,7 +345,7 @@ void replay_start(void)
>          error_reportf_err(replay_blockers->data, "Record/replay: ");
>          exit(1);
>      }
> -    if (!use_icount) {
> +    if (!icount_enabled()) {
>          error_report("Please enable icount to use record/replay");
>          exit(1);
>      }
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index ae5451bc23..ed53cd1b62 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -73,6 +73,7 @@
>  #include "hw/audio/soundhw.h"
>  #include "audio/audio.h"
>  #include "sysemu/cpus.h"
> +#include "sysemu/cpu-timers.h"
>  #include "migration/colo.h"
>  #include "migration/postcopy-ram.h"
>  #include "sysemu/kvm.h"
> @@ -2675,7 +2676,7 @@ static void user_register_global_props(void)
>  
>  static int do_configure_icount(void *opaque, QemuOpts *opts, Error **errp)
>  {
> -    configure_icount(opts, errp);
> +    icount_configure(opts, errp);
>      return 0;
>  }
>  
> @@ -2785,7 +2786,7 @@ static void configure_accelerators(const char *progname)
>          error_report("falling back to %s", ac->name);
>      }
>  
> -    if (use_icount && !(tcg_enabled() || qtest_enabled())) {
> +    if (icount_enabled() && !(tcg_enabled() || qtest_enabled())) {
>          error_report("-icount is not allowed with hardware virtualization");
>          exit(1);
>      }
> @@ -4233,7 +4234,8 @@ void qemu_init(int argc, char **argv, char **envp)
>      /* spice needs the timers to be initialized by this point */
>      qemu_spice_init();
>  
> -    cpu_ticks_init();
> +    /* initialize cpu timers and VCPU throttle modules */
> +    cpu_timers_init();
>  
>      if (default_net) {
>          QemuOptsList *net = qemu_find_opts("net");
> diff --git a/stubs/clock-warp.c b/stubs/clock-warp.c
> index b53e5dd94c..304da5091c 100644
> --- a/stubs/clock-warp.c
> +++ b/stubs/clock-warp.c
> @@ -1,7 +1,7 @@
>  #include "qemu/osdep.h"
> -#include "qemu/timer.h"
> +#include "sysemu/cpu-timers.h"
>  
> -void qemu_start_warp_timer(void)
> +void icount_start_warp_timer(void)
>  {
>  }
>  
> diff --git a/stubs/cpu-get-clock.c b/stubs/cpu-get-clock.c
> index 5a92810e87..6102338743 100644
> --- a/stubs/cpu-get-clock.c
> +++ b/stubs/cpu-get-clock.c
> @@ -1,5 +1,5 @@
>  #include "qemu/osdep.h"
> -#include "qemu/timer.h"
> +#include "sysemu/cpu-timers.h"
>  
>  int64_t cpu_get_clock(void)
>  {
> diff --git a/stubs/cpu-get-icount.c b/stubs/cpu-get-icount.c
> index b35f844638..23f9154ef3 100644
> --- a/stubs/cpu-get-icount.c
> +++ b/stubs/cpu-get-icount.c
> @@ -1,20 +1,22 @@
>  #include "qemu/osdep.h"
> -#include "qemu/timer.h"
> -#include "sysemu/cpus.h"
> +#include "sysemu/cpu-timers.h"
>  #include "qemu/main-loop.h"
>  
> -int use_icount;
> -
> -int64_t cpu_get_icount(void)
> +int64_t icount_get(void)
>  {
>      abort();
>  }
>  
> -int64_t cpu_get_icount_raw(void)
> +int64_t icount_get_raw(void)
>  {
>      abort();
>  }
>  
> +int icount_enabled(void)
> +{
> +    return 0;
> +}
> +
>  void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
>  {
>      qemu_notify_event();
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index 8870284f57..36be602179 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -20,6 +20,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "sysemu/cpus.h"
> +#include "sysemu/cpu-timers.h"
>  #include "disas/disas.h"
>  #include "qemu/host-utils.h"
>  #include "exec/exec-all.h"
> @@ -1329,7 +1330,7 @@ static DisasJumpType gen_mfpr(DisasContext *ctx, TCGv va, int regno)
>      case 249: /* VMTIME */
>          helper = gen_helper_get_vmtime;
>      do_helper:
> -        if (use_icount) {
> +        if (icount_enabled()) {
>              gen_io_start();
>              helper(va);
>              return DISAS_PC_STALE;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index a92ae55672..c9f99f7952 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -24,6 +24,7 @@
>  #include "hw/irq.h"
>  #include "hw/semihosting/semihost.h"
>  #include "sysemu/cpus.h"
> +#include "sysemu/cpu-timers.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/tcg.h"
>  #include "qemu/range.h"
> @@ -1205,17 +1206,17 @@ static int64_t cycles_ns_per(uint64_t cycles)
>  
>  static bool instructions_supported(CPUARMState *env)
>  {
> -    return use_icount == 1 /* Precise instruction counting */;
> +    return icount_enabled() == 1; /* Precise instruction counting */
>  }
>  
>  static uint64_t instructions_get_count(CPUARMState *env)
>  {
> -    return (uint64_t)cpu_get_icount_raw();
> +    return (uint64_t)icount_get_raw();
>  }
>  
>  static int64_t instructions_ns_per(uint64_t icount)
>  {
> -    return cpu_icount_to_ns((int64_t)icount);
> +    return icount_to_ns((int64_t)icount);
>  }
>  #endif
>  
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 11d184cd16..6093f73e3a 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -194,8 +194,8 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
>  static int read_instret(CPURISCVState *env, int csrno, target_ulong *val)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    if (use_icount) {
> -        *val = cpu_get_icount();
> +    if (icount_enabled()) {
> +        *val = icount_get();
>      } else {
>          *val = cpu_get_host_ticks();
>      }
> @@ -209,8 +209,8 @@ static int read_instret(CPURISCVState *env, int csrno, target_ulong *val)
>  static int read_instreth(CPURISCVState *env, int csrno, target_ulong *val)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    if (use_icount) {
> -        *val = cpu_get_icount() >> 32;
> +    if (icount_enabled()) {
> +        *val = icount_get() >> 32;
>      } else {
>          *val = cpu_get_host_ticks() >> 32;
>      }
> diff --git a/tests/ptimer-test-stubs.c b/tests/ptimer-test-stubs.c
> index ed393d9082..320dcf99b7 100644
> --- a/tests/ptimer-test-stubs.c
> +++ b/tests/ptimer-test-stubs.c
> @@ -12,6 +12,7 @@
>  #include "qemu/main-loop.h"
>  #include "sysemu/replay.h"
>  #include "migration/vmstate.h"
> +#include "sysemu/cpu-timers.h"
>  
>  #include "ptimer-test.h"
>  
> @@ -126,3 +127,8 @@ void replay_bh_schedule_event(QEMUBH *bh)
>  {
>      bh->cb(bh->opaque);
>  }
> +
> +int icount_enabled(void)
> +{
> +    return 0;
> +}
> diff --git a/tests/test-timed-average.c b/tests/test-timed-average.c
> index e2bcf5fe13..82c92500df 100644
> --- a/tests/test-timed-average.c
> +++ b/tests/test-timed-average.c
> @@ -11,7 +11,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -
> +#include "sysemu/cpu-timers.h"
>  #include "qemu/timed-average.h"
>  
>  /* This is the clock for QEMU_CLOCK_VIRTUAL */
> diff --git a/util/main-loop.c b/util/main-loop.c
> index eda63fe4e0..f1af697572 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -27,7 +27,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/timer.h"
>  #include "sysemu/qtest.h"
> -#include "sysemu/cpus.h"
> +#include "sysemu/cpu-timers.h"
>  #include "sysemu/replay.h"
>  #include "qemu/main-loop.h"
>  #include "block/aio.h"
> @@ -521,7 +521,7 @@ void main_loop_wait(int nonblocking)
>  
>      /* CPU thread can infinitely wait for event after
>         missing the warp */
> -    qemu_start_warp_timer();
> +    icount_start_warp_timer();
>      qemu_clock_run_all_timers();
>  }
>  
> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
> index b6575a2cd5..da2883f914 100644
> --- a/util/qemu-timer.c
> +++ b/util/qemu-timer.c
> @@ -26,6 +26,7 @@
>  #include "qemu/main-loop.h"
>  #include "qemu/timer.h"
>  #include "qemu/lockable.h"
> +#include "sysemu/cpu-timers.h"
>  #include "sysemu/replay.h"
>  #include "sysemu/cpus.h"
>  
> @@ -134,7 +135,7 @@ static void qemu_clock_init(QEMUClockType type, QEMUTimerListNotifyCB *notify_cb
>  
>  bool qemu_clock_use_for_deadline(QEMUClockType type)
>  {
> -    return !(use_icount && (type == QEMU_CLOCK_VIRTUAL));
> +    return !(icount_enabled() && (type == QEMU_CLOCK_VIRTUAL));
>  }
>  
>  void qemu_clock_notify(QEMUClockType type)
> @@ -417,7 +418,7 @@ static void timerlist_rearm(QEMUTimerList *timer_list)
>  {
>      /* Interrupt execution to force deadline recalculation.  */
>      if (timer_list->clock->type == QEMU_CLOCK_VIRTUAL) {
> -        qemu_start_warp_timer();
> +        icount_start_warp_timer();
>      }
>      timerlist_notify(timer_list);
>  }
> @@ -647,8 +648,8 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
>          return get_clock();
>      default:
>      case QEMU_CLOCK_VIRTUAL:
> -        if (use_icount) {
> -            return cpu_get_icount();
> +        if (icount_enabled()) {
> +            return icount_get();
>          } else {
>              return cpu_get_clock();
>          }
> 


