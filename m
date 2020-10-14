Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CF8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23622214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0FXE1Gn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23622214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSmbz-00081I-3u
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 15:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSmaD-00072Z-02
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:37:09 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSmaA-0003gN-KO
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:37:08 -0400
Received: by mail-wr1-x441.google.com with SMTP id h7so428979wre.4
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GzAENG6m9S0GUm9ZfHSuS+DUaJn4DZiscUTiSw8yRp4=;
 b=P0FXE1GnTKe9T2SRoMCL6iMlNF7OzP51No/ebuOcoF860My83DFOuEzom/LN5nHMNt
 MO7NCBe4s+nsY53NYG50FN7wBIZqX3ja8nJRQQsB5De4fZgKJ81jJxtwRH0GN3BTbknT
 hXJkfi/oexcOGOguZUw+8/O8rMMB9HmLSf+sYBwFk1kWdmRpPIAXVr9rUrDXCMIhGmNt
 WV76/HoQj5cazJfcfirlGEHMeE4qhhWxXFDzmguxsQ58ddHHja7ruG1R/NhAoSNP8oe1
 1aqob2OESqbudqrLAEf2B0y2Ifld7hHtSC/WnOXAtJoBaor38hGt5ksFfpLvPXJQ53rK
 r3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GzAENG6m9S0GUm9ZfHSuS+DUaJn4DZiscUTiSw8yRp4=;
 b=Lft/3gIi3kSnUNucAFZegLfNkLhGaF0zYLeCZ/uBVTbWjlQt4bLYAuXc77K6daDyjL
 7Q2vLM1G9YwYCoNQlO/CyipP3FXSwODnZ7bDN4quLDPqEk//lgwidODuikVmBTQbncmc
 h079XHreswWTnwknR3azDD4DczWz+wRPeIwdVkuJqCUNyLtiM/baVAAiwGljU+xifY+Y
 SUmUyzqIgfnkg1ptKvZblWmLOujdwIbeZOflCOXmjronkECzBbz4WuENBkQnDXAbJkmi
 MFmDbLF296HTHWaWaTYVgvJ78ySNMcYkL64j5PtdATPT5s+TKeligfFQ3kE3D3e7es+1
 4FAg==
X-Gm-Message-State: AOAM530RLp/iZym5eKNdQVDm1fVfldkwr46FAV9rhk28jZcNDnvd86aZ
 I+QpQKh2ZuQj1HDW24QEda7yeq5ffHk=
X-Google-Smtp-Source: ABdhPJzW0wl0Ri7jZyh/L/5NSPYM6JryOwDNBLjLkd40I8toajAwUEN29JhLBxzMEU3AJC1w+PWZxA==
X-Received: by 2002:a5d:46c2:: with SMTP id g2mr312447wrs.309.1602704224630;
 Wed, 14 Oct 2020 12:37:04 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i14sm617574wml.24.2020.10.14.12.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 12:37:04 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] accel/tcg: split CpusAccel into three TCG variants
To: Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201014192324.6390-1-cfontana@suse.de>
 <20201014192324.6390-2-cfontana@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8dec18a8-4a61-63a2-261f-39e30f8d6e52@amsat.org>
Date: Wed, 14 Oct 2020 21:37:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201014192324.6390-2-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 9:23 PM, Claudio Fontana wrote:
> split up the CpusAccel tcg_cpus into three TCG variants:
> 
> tcg_cpus_rr (single threaded, round robin cpus)
> tcg_cpus_icount (same as rr, but with instruction counting enabled)
> tcg_cpus_mttcg (multi-threaded cpus)
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>   accel/tcg/meson.build       |   9 +-
>   accel/tcg/tcg-all.c         |   8 +-
>   accel/tcg/tcg-cpus-icount.c | 147 +++++++++++
>   accel/tcg/tcg-cpus-icount.h |  17 ++
>   accel/tcg/tcg-cpus-mttcg.c  | 119 +++++++++
>   accel/tcg/tcg-cpus-mttcg.h  |  23 ++
>   accel/tcg/tcg-cpus-rr.c     | 272 ++++++++++++++++++++
>   accel/tcg/tcg-cpus-rr.h     |  21 ++
>   accel/tcg/tcg-cpus.c        | 484 ++----------------------------------
>   accel/tcg/tcg-cpus.h        |  13 +-
>   softmmu/icount.c            |   2 +-
>   11 files changed, 653 insertions(+), 462 deletions(-)
...

> diff --git a/accel/tcg/tcg-cpus-mttcg.c b/accel/tcg/tcg-cpus-mttcg.c
> new file mode 100644
> index 0000000000..723703fa3e
> --- /dev/null
> +++ b/accel/tcg/tcg-cpus-mttcg.c
> @@ -0,0 +1,119 @@
> +/*
> + * QEMU TCG Multi Threaded vCPUs implementation
> + *
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + * Copyright (c) 2014 Red Hat Inc.
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
> +#include "sysemu/tcg.h"
> +#include "sysemu/replay.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/guest-random.h"
> +#include "exec/exec-all.h"
> +#include "hw/boards.h"
> +
> +#include "tcg-cpus.h"
> +#include "tcg-cpus-mttcg.h"
> +
> +/*
> + * Multi-threaded TCG

Can drop this comment ^ and keep v.

> + *
> + * In the multi-threaded case each vCPU has its own thread. The TLS
> + * variable current_cpu can be used deep in the code to find the
> + * current CPUState for a given thread.
> + */
> +
> +void *tcg_cpu_thread_fn(void *arg)
> +{
> +    CPUState *cpu = arg;
> +
> +    assert(tcg_enabled());
> +    g_assert(!icount_enabled());
> +
> +    rcu_register_thread();
> +    tcg_register_thread();
> +
> +    qemu_mutex_lock_iothread();
> +    qemu_thread_get_self(cpu->thread);
> +
> +    cpu->thread_id = qemu_get_thread_id();
> +    cpu->can_do_io = 1;
> +    current_cpu = cpu;
> +    cpu_thread_signal_created(cpu);
> +    qemu_guest_random_seed_thread_part2(cpu->random_seed);
> +
> +    /* process any pending work */
> +    cpu->exit_request = 1;
> +
> +    do {
> +        if (cpu_can_run(cpu)) {
> +            int r;
> +            qemu_mutex_unlock_iothread();
> +            r = tcg_cpu_exec(cpu);
> +            qemu_mutex_lock_iothread();
> +            switch (r) {
> +            case EXCP_DEBUG:
> +                cpu_handle_guest_debug(cpu);
> +                break;
> +            case EXCP_HALTED:
> +                /*
> +                 * during start-up the vCPU is reset and the thread is
> +                 * kicked several times. If we don't ensure we go back
> +                 * to sleep in the halted state we won't cleanly
> +                 * start-up when the vCPU is enabled.
> +                 *
> +                 * cpu->halted should ensure we sleep in wait_io_event
> +                 */
> +                g_assert(cpu->halted);
> +                break;
> +            case EXCP_ATOMIC:
> +                qemu_mutex_unlock_iothread();
> +                cpu_exec_step_atomic(cpu);
> +                qemu_mutex_lock_iothread();
> +            default:
> +                /* Ignore everything else? */
> +                break;
> +            }
> +        }
> +
> +        qatomic_mb_set(&cpu->exit_request, 0);
> +        qemu_wait_io_event(cpu);
> +    } while (!cpu->unplug || cpu_can_run(cpu));
> +
> +    qemu_tcg_destroy_vcpu(cpu);
> +    qemu_mutex_unlock_iothread();
> +    rcu_unregister_thread();
> +    return NULL;
> +}
...

> diff --git a/accel/tcg/tcg-cpus-mttcg.h b/accel/tcg/tcg-cpus-mttcg.h
> new file mode 100644
> index 0000000000..5d203243e8
> --- /dev/null
> +++ b/accel/tcg/tcg-cpus-mttcg.h
> @@ -0,0 +1,23 @@
> +/*
> + * QEMU TCG Multi Threaded vCPUs implementation
> + *
> + * Copyright 2020 SUSE LLC
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef TCG_CPUS_MTTCG_H
> +#define TCG_CPUS_MTTCG_H
> +
> +/*
> + * Multi-threaded TCG

Drop too ^

> + *
> + * In the multi-threaded case each vCPU has its own thread. The TLS
> + * variable current_cpu can be used deep in the code to find the
> + * current CPUState for a given thread.
> + */
> +
> +void *tcg_cpu_thread_fn(void *arg);
> +
> +#endif /* TCG_CPUS_MTTCG_H */
> diff --git a/accel/tcg/tcg-cpus-rr.c b/accel/tcg/tcg-cpus-rr.c
> new file mode 100644
> index 0000000000..82bb7c5ea6
> --- /dev/null
> +++ b/accel/tcg/tcg-cpus-rr.c
> @@ -0,0 +1,272 @@
> +/*
> + * QEMU TCG Single Threaded vCPUs implementation
> + *
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + * Copyright (c) 2014 Red Hat Inc.
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
> +#include "sysemu/tcg.h"
> +#include "sysemu/replay.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/guest-random.h"
> +#include "exec/exec-all.h"
> +#include "hw/boards.h"
> +
> +#include "tcg-cpus.h"
> +#include "tcg-cpus-rr.h"
> +#include "tcg-cpus-icount.h"
> +
> +/* Kick all RR vCPUs */
> +void qemu_cpu_kick_rr_cpus(CPUState *unused)
> +{
> +    CPUState *cpu;
> +
> +    CPU_FOREACH(cpu) {
> +        cpu_exit(cpu);
> +    };
> +}
> +
> +/*
> + * TCG vCPU kick timer
> + *
> + * The kick timer is responsible for moving single threaded vCPU
> + * emulation on to the next vCPU. If more than one vCPU is running a
> + * timer event with force a cpu->exit so the next vCPU can get
> + * scheduled.
> + *
> + * The timer is removed if all vCPUs are idle and restarted again once
> + * idleness is complete.
> + */
> +
> +static QEMUTimer *tcg_kick_vcpu_timer;
> +static CPUState *tcg_current_rr_cpu;
> +
> +#define TCG_KICK_PERIOD (NANOSECONDS_PER_SECOND / 10)
> +
> +static inline int64_t qemu_tcg_next_kick(void)
> +{
> +    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + TCG_KICK_PERIOD;
> +}
> +
> +/* Kick the currently round-robin scheduled vCPU to next */
> +static void qemu_cpu_kick_rr_next_cpu(void)
> +{
> +    CPUState *cpu;
> +    do {
> +        cpu = qatomic_mb_read(&tcg_current_rr_cpu);
> +        if (cpu) {
> +            cpu_exit(cpu);
> +        }
> +    } while (cpu != qatomic_mb_read(&tcg_current_rr_cpu));
> +}
> +
> +static void kick_tcg_thread(void *opaque)
> +{
> +    timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
> +    qemu_cpu_kick_rr_next_cpu();
> +}
> +
> +static void start_tcg_kick_timer(void)
> +{
> +    if (!tcg_kick_vcpu_timer && CPU_NEXT(first_cpu)) {
> +        tcg_kick_vcpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                           kick_tcg_thread, NULL);
> +    }
> +    if (tcg_kick_vcpu_timer && !timer_pending(tcg_kick_vcpu_timer)) {
> +        timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
> +    }
> +}
> +
> +static void stop_tcg_kick_timer(void)
> +{
> +    if (tcg_kick_vcpu_timer && timer_pending(tcg_kick_vcpu_timer)) {
> +        timer_del(tcg_kick_vcpu_timer);
> +    }
> +}
> +
> +static void qemu_tcg_rr_wait_io_event(void)
> +{
> +    CPUState *cpu;
> +
> +    while (all_cpu_threads_idle()) {
> +        stop_tcg_kick_timer();
> +        qemu_cond_wait_iothread(first_cpu->halt_cond);
> +    }
> +
> +    start_tcg_kick_timer();
> +
> +    CPU_FOREACH(cpu) {
> +        qemu_wait_io_event_common(cpu);
> +    }
> +}
> +
> +/*
> + * Destroy any remaining vCPUs which have been unplugged and have
> + * finished running
> + */
> +static void deal_with_unplugged_cpus(void)
> +{
> +    CPUState *cpu;
> +
> +    CPU_FOREACH(cpu) {
> +        if (cpu->unplug && !cpu_can_run(cpu)) {
> +            qemu_tcg_destroy_vcpu(cpu);
> +            break;
> +        }
> +    }
> +}
> +
> +/*
> + * Single-threaded TCG

Drop  ^

> + *
> + * In the single-threaded case each vCPU is simulated in turn. If
> + * there is more than a single vCPU we create a simple timer to kick
> + * the vCPU and ensure we don't get stuck in a tight loop in one vCPU.
> + * This is done explicitly rather than relying on side-effects
> + * elsewhere.
> + */
...

> diff --git a/accel/tcg/tcg-cpus-rr.h b/accel/tcg/tcg-cpus-rr.h
> new file mode 100644
> index 0000000000..12463b0b93
> --- /dev/null
> +++ b/accel/tcg/tcg-cpus-rr.h
> @@ -0,0 +1,21 @@
> +/*
> + * QEMU TCG Single Threaded vCPUs implementation
> + *
> + * Copyright 2020 SUSE LLC
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef TCG_CPUS_RR_H
> +#define TCG_CPUS_RR_H
> +
> +#define TCG_KICK_PERIOD (NANOSECONDS_PER_SECOND / 10)
> +
> +/* Kick all RR vCPUs. */
> +void qemu_cpu_kick_rr_cpus(CPUState *unused);
> +
> +/* Single-threaded TCG */

Comment not helpful.

> +void *tcg_rr_cpu_thread_fn(void *arg);
> +
> +#endif /* TCG_CPUS_RR_H */
> diff --git a/accel/tcg/tcg-cpus.c b/accel/tcg/tcg-cpus.c
> index da1c63d8f6..60d307dba1 100644
> --- a/accel/tcg/tcg-cpus.c
> +++ b/accel/tcg/tcg-cpus.c
> @@ -1,5 +1,7 @@
>   /*
> - * QEMU System Emulator
> + * QEMU TCG vcpu common functionality

"vCPU" as used elsewhere.

> + *
> + * Functionality common to all TCG vcpu variants: mttcg, rr and icount.
>    *
>    * Copyright (c) 2003-2008 Fabrice Bellard
>    * Copyright (c) 2014 Red Hat Inc.
> @@ -33,436 +35,12 @@
>   #include "hw/boards.h"
>   
>   #include "tcg-cpus.h"
> +#include "tcg-cpus-mttcg.h"
> +#include "tcg-cpus-rr.h"
> diff --git a/accel/tcg/tcg-cpus.h b/accel/tcg/tcg-cpus.h
> index 8b1d9d2abc..cb61aed1cc 100644
> --- a/accel/tcg/tcg-cpus.h
> +++ b/accel/tcg/tcg-cpus.h
> @@ -1,5 +1,7 @@
>   /*
> - * Accelerator CPUS Interface
> + * QEMU TCG vcpu common functionality

"vCPU"

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

