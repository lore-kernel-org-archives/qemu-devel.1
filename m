Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84564C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:46:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1FA206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NaKeMtdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1FA206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd8kH-0003kZ-Ey
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 04:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jd8jT-00030Z-VO
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:45:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24740
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jd8jR-0006Mb-VV
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590396312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=/BgEXHyxlhWqor0SDMdSKEJYgxW/mcMiE1Bb/o2gWag=;
 b=NaKeMtdFnsCTkeaq7MXAwqT8Iy2V0B6BkwdA2VHd7RwfBsofXRhtr4H+7ci2goE2o/bgEF
 5YvmaagmUs+XPkeJSdVZb4DTEzJ0IYZhVJhT3HlqoRtM8VVgt7ekxlfhmq7G1ATiLDG/sE
 seMMdvp8NuKGZ4S9m4La6nnLfjmvx4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-WxEAOhBAMMOvrbUGAvpVcA-1; Mon, 25 May 2020 04:45:09 -0400
X-MC-Unique: WxEAOhBAMMOvrbUGAvpVcA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4B75460;
 Mon, 25 May 2020 08:45:07 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-78.ams2.redhat.com [10.36.113.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F12FF5D9C5;
 Mon, 25 May 2020 08:44:58 +0000 (UTC)
Subject: Re: [RFC v2 1/3] cpu-throttle: new module, extracted from cpus.c
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200522171013.27597-1-cfontana@suse.de>
 <20200522171013.27597-2-cfontana@suse.de>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3c30d830-cd4b-63f6-b942-afd4bc0fb6d6@redhat.com>
Date: Mon, 25 May 2020 10:44:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200522171013.27597-2-cfontana@suse.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:44:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Roman Bolshakov <r.bolshakov@yadro.com>,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/05/2020 19.10, Claudio Fontana wrote:
> move the vcpu throttling functionality into its own module.
> 
> This functionality is not specific to any accelerator,
> and it is used currently by migration to slow down guests to try to
> have migrations converge, and by the cocoa MacOS UI to throttle speed.
> 
> cpu-throttle contains the controls to adjust and inspect throttle
> settings, start (set) and stop vcpu throttling, and the throttling
> function itself that is run periodically on vcpus to make them take a nap.
> 
> Execution of the throttling function on all vcpus is triggered by a timer,
> registered at module initialization.
> 
> No functionality change.

Thanks for the update, sounds better now!

> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  MAINTAINERS                   |   1 +
>  Makefile.target               |   8 ++-
>  cpu-throttle.c                | 122 ++++++++++++++++++++++++++++++++++++++++++
>  cpus.c                        |  95 +++-----------------------------
>  include/hw/core/cpu.h         |  37 -------------
>  include/qemu/main-loop.h      |   5 ++
>  include/sysemu/cpu-throttle.h |  50 +++++++++++++++++
>  migration/migration.c         |   1 +
>  migration/ram.c               |   1 +
>  9 files changed, 195 insertions(+), 125 deletions(-)
>  create mode 100644 cpu-throttle.c
>  create mode 100644 include/sysemu/cpu-throttle.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3690f313c3..95be18c0b5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2148,6 +2148,7 @@ Main loop
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
>  F: cpus.c
> +F: cpu-throttle.c
>  F: include/qemu/main-loop.h
>  F: include/sysemu/runstate.h
>  F: util/main-loop.c
> diff --git a/Makefile.target b/Makefile.target
> index 8ed1eba95b..60cfa2a78b 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -152,7 +152,13 @@ endif #CONFIG_BSD_USER
>  #########################################################
>  # System emulator target
>  ifdef CONFIG_SOFTMMU
> -obj-y += arch_init.o cpus.o gdbstub.o balloon.o ioport.o
> +obj-y += arch_init.o
> +obj-y += cpus.o
> +obj-y += cpu-throttle.o

Hmm, maybe the new files should rather be created in the softmmu/ folder
(now that we've got it)? And cpus.c could finally be moved there, too...
well, it's just an idea, I've got no strong opinion about this.

> +obj-y += gdbstub.o
> +obj-y += balloon.o
> +obj-y += ioport.o
> +
>  obj-y += qtest.o
>  obj-y += dump/
>  obj-y += hw/
> diff --git a/cpu-throttle.c b/cpu-throttle.c
> new file mode 100644
> index 0000000000..4e6b2818ca
> --- /dev/null
> +++ b/cpu-throttle.c
> @@ -0,0 +1,122 @@
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
> +#include "qemu/thread.h"
> +#include "hw/core/cpu.h"
> +#include "qemu/main-loop.h"
> +#include "sysemu/cpus.h"
> +#include "sysemu/cpu-throttle.h"
> +
> +/* vcpu throttling controls */
> +static QEMUTimer *throttle_timer;
> +static unsigned int throttle_percentage;
> +
> +#define CPU_THROTTLE_PCT_MIN 1
> +#define CPU_THROTTLE_PCT_MAX 99
> +#define CPU_THROTTLE_TIMESLICE_NS 10000000
> +
> +static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
> +{
> +    double pct;
> +    double throttle_ratio;
> +    int64_t sleeptime_ns, endtime_ns;
> +
> +    if (!cpu_throttle_get_percentage()) {
> +        return;
> +    }
> +
> +    pct = (double)cpu_throttle_get_percentage() / 100;
> +    throttle_ratio = pct / (1 - pct);
> +    /* Add 1ns to fix double's rounding error (like 0.9999999...) */
> +    sleeptime_ns = (int64_t)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS + 1);
> +    endtime_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + sleeptime_ns;
> +    while (sleeptime_ns > 0 && !cpu->stop) {
> +        if (sleeptime_ns > SCALE_MS) {
> +            qemu_cond_timedwait_iothread(cpu->halt_cond,
> +                                         sleeptime_ns / SCALE_MS);
> +        } else {
> +            qemu_mutex_unlock_iothread();
> +            g_usleep(sleeptime_ns / SCALE_US);
> +            qemu_mutex_lock_iothread();
> +        }
> +        sleeptime_ns = endtime_ns - qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> +    }
> +    atomic_set(&cpu->throttle_thread_scheduled, 0);
> +}
> +
> +static void cpu_throttle_timer_tick(void *opaque)
> +{
> +    CPUState *cpu;
> +    double pct;
> +
> +    /* Stop the timer if needed */
> +    if (!cpu_throttle_get_percentage()) {
> +        return;
> +    }
> +    CPU_FOREACH(cpu) {
> +        if (!atomic_xchg(&cpu->throttle_thread_scheduled, 1)) {
> +            async_run_on_cpu(cpu, cpu_throttle_thread,
> +                             RUN_ON_CPU_NULL);
> +        }
> +    }
> +
> +    pct = (double)cpu_throttle_get_percentage() / 100;
> +    timer_mod(throttle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) +
> +                                   CPU_THROTTLE_TIMESLICE_NS / (1 - pct));
> +}
> +
> +void cpu_throttle_set(int new_throttle_pct)
> +{
> +    /* Ensure throttle percentage is within valid range */
> +    new_throttle_pct = MIN(new_throttle_pct, CPU_THROTTLE_PCT_MAX);
> +    new_throttle_pct = MAX(new_throttle_pct, CPU_THROTTLE_PCT_MIN);
> +
> +    atomic_set(&throttle_percentage, new_throttle_pct);
> +
> +    timer_mod(throttle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) +
> +                                       CPU_THROTTLE_TIMESLICE_NS);
> +}
> +
> +void cpu_throttle_stop(void)
> +{
> +    atomic_set(&throttle_percentage, 0);
> +}
> +
> +bool cpu_throttle_active(void)
> +{
> +    return (cpu_throttle_get_percentage() != 0);
> +}
> +
> +int cpu_throttle_get_percentage(void)
> +{
> +    return atomic_read(&throttle_percentage);
> +}
> +
> +void cpu_throttle_init(void)
> +{
> +    throttle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
> +                                  cpu_throttle_timer_tick, NULL);
> +}
> diff --git a/cpus.c b/cpus.c
> index 5670c96bcf..3a46a4fc2b 100644
> --- a/cpus.c
> +++ b/cpus.c
[...]
>  
> +void qemu_cond_timedwait_iothread(QemuCond *cond, int ms)
> +{
> +    qemu_cond_timedwait(cond, &qemu_global_mutex, ms);
> +}

So the new function is in cpus.c ...

> diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
> index a6d20b0719..2fa3d90ad6 100644
> --- a/include/qemu/main-loop.h
> +++ b/include/qemu/main-loop.h
> @@ -263,6 +263,11 @@ int qemu_add_child_watch(pid_t pid);
>   */
>  bool qemu_mutex_iothread_locked(void);
>  
> +/*
> + * qemu_cond_timedwait_iothread: like the previous, but with timeout
> + */
> +void qemu_cond_timedwait_iothread(QemuCond *cond, int ms);

... but it's prototype is in main-loop.h ? That's a little bit
confusing... I'd rather expect it in include/sysemu/cpus.h instead? Or
should the new function rather be moved to softmmu/vl.c ?

 Thomas


