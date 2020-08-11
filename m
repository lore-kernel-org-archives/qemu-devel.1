Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CC9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF4220772
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="IjVBAfMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF4220772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5QBl-0000bT-VR
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 05:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k5Q9A-0005Y0-1f
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 05:00:40 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48288 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k5Q97-0005fx-Tw
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 05:00:39 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 94D644C891;
 Tue, 11 Aug 2020 09:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1597136435;
 x=1598950836; bh=TLUxIGIrCoQ+l97qrxDN7W89EQeIFmLtsweJ8KLKis0=; b=
 IjVBAfMNmJvUjkIqLR5a1Z1KcsiOuot5TNl5TjhfceEbcqIYd7SappFDOPirSSZ3
 YseCSFTiru0z3+LjYwgk6HY66hPV244+VLWXEiUc98p+zl9YRrINTDgHMo/ZeUd8
 vDuON8/R1KLvYzh+vxT1Y8d2T1JQcX0ZwDa9ez278Qg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fUixNqVIGzle; Tue, 11 Aug 2020 12:00:35 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 0C7F54C84A;
 Tue, 11 Aug 2020 12:00:35 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 11
 Aug 2020 12:00:34 +0300
Date: Tue, 11 Aug 2020 12:00:34 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC v3 8/8] cpus: extract out hvf-specific code to
 target/i386/hvf/
Message-ID: <20200811090034.GB62204@SPB-NB-133.local>
References: <20200803090533.7410-1-cfontana@suse.de>
 <20200803090533.7410-9-cfontana@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200803090533.7410-9-cfontana@suse.de>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 04:59:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, haxm-team@intel.com,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Wenchao Wang <wenchao.wang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 03, 2020 at 11:05:33AM +0200, Claudio Fontana wrote:
> register a "CpusAccel" interface for HVF as well.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  softmmu/cpus.c                |  63 --------------------
>  target/i386/hvf/Makefile.objs |   2 +-
>  target/i386/hvf/hvf-cpus.c    | 131 ++++++++++++++++++++++++++++++++++++++++++
>  target/i386/hvf/hvf-cpus.h    |  17 ++++++
>  target/i386/hvf/hvf.c         |   3 +
>  5 files changed, 152 insertions(+), 64 deletions(-)
>  create mode 100644 target/i386/hvf/hvf-cpus.c
>  create mode 100644 target/i386/hvf/hvf-cpus.h
> 
> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> index 586b4acaab..d327b2685c 100644
> --- a/softmmu/cpus.c
> +++ b/softmmu/cpus.c
> @@ -33,7 +33,6 @@
>  #include "exec/gdbstub.h"
>  #include "sysemu/hw_accel.h"
>  #include "sysemu/kvm.h"
> -#include "sysemu/hvf.h"

I wonder if the declarations should be moved from sysemu/hvf.h to
someplace inside target/i386/hvf/:

int hvf_init_vcpu(CPUState *);
int hvf_vcpu_exec(CPUState *);
void hvf_cpu_synchronize_state(CPUState *);
void hvf_cpu_synchronize_post_reset(CPUState *);
void hvf_cpu_synchronize_post_init(CPUState *);
void hvf_cpu_synchronize_pre_loadvm(CPUState *);
void hvf_vcpu_destroy(CPUState *);

They're not used outside of target/i386/hvf/

I also wonder if we need stubs at all?

>  #include "exec/exec-all.h"
>  #include "qemu/thread.h"
>  #include "qemu/plugin.h"
> @@ -391,48 +390,6 @@ void qemu_wait_io_event(CPUState *cpu)
>      qemu_wait_io_event_common(cpu);
>  }
>  
> -/* The HVF-specific vCPU thread function. This one should only run when the host
> - * CPU supports the VMX "unrestricted guest" feature. */
> -static void *qemu_hvf_cpu_thread_fn(void *arg)
> -{
> -    CPUState *cpu = arg;
> -
> -    int r;
> -
> -    assert(hvf_enabled());
> -
> -    rcu_register_thread();
> -
> -    qemu_mutex_lock_iothread();
> -    qemu_thread_get_self(cpu->thread);
> -
> -    cpu->thread_id = qemu_get_thread_id();
> -    cpu->can_do_io = 1;
> -    current_cpu = cpu;
> -
> -    hvf_init_vcpu(cpu);
> -
> -    /* signal CPU creation */
> -    cpu_thread_signal_created(cpu);
> -    qemu_guest_random_seed_thread_part2(cpu->random_seed);
> -
> -    do {
> -        if (cpu_can_run(cpu)) {
> -            r = hvf_vcpu_exec(cpu);
> -            if (r == EXCP_DEBUG) {
> -                cpu_handle_guest_debug(cpu);
> -            }
> -        }
> -        qemu_wait_io_event(cpu);
> -    } while (!cpu->unplug || cpu_can_run(cpu));
> -
> -    hvf_vcpu_destroy(cpu);
> -    cpu_thread_signal_destroyed(cpu);
> -    qemu_mutex_unlock_iothread();
> -    rcu_unregister_thread();
> -    return NULL;
> -}
> -
>  void cpus_kick_thread(CPUState *cpu)
>  {
>  #ifndef _WIN32
> @@ -603,24 +560,6 @@ void cpu_remove_sync(CPUState *cpu)
>      qemu_mutex_lock_iothread();
>  }
>  
> -static void qemu_hvf_start_vcpu(CPUState *cpu)
> -{
> -    char thread_name[VCPU_THREAD_NAME_SIZE];
> -
> -    /* HVF currently does not support TCG, and only runs in
> -     * unrestricted-guest mode. */
> -    assert(hvf_enabled());
> -
> -    cpu->thread = g_malloc0(sizeof(QemuThread));
> -    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
> -    qemu_cond_init(cpu->halt_cond);
> -
> -    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
> -             cpu->cpu_index);
> -    qemu_thread_create(cpu->thread, thread_name, qemu_hvf_cpu_thread_fn,
> -                       cpu, QEMU_THREAD_JOINABLE);
> -}
> -
>  void cpus_register_accel(CpusAccel *ca)
>  {
>      assert(ca != NULL);
> @@ -648,8 +587,6 @@ void qemu_init_vcpu(CPUState *cpu)
>      if (cpus_accel) {
>          /* accelerator already implements the CpusAccel interface */
>          cpus_accel->create_vcpu_thread(cpu);
> -    } else if (hvf_enabled()) {
> -        qemu_hvf_start_vcpu(cpu);
>      } else {
>          assert(0);
>      }
> diff --git a/target/i386/hvf/Makefile.objs b/target/i386/hvf/Makefile.objs
> index 927b86bc67..af9f7dcfc1 100644
> --- a/target/i386/hvf/Makefile.objs
> +++ b/target/i386/hvf/Makefile.objs
> @@ -1,2 +1,2 @@
> -obj-y += hvf.o
> +obj-y += hvf.o hvf-cpus.o
>  obj-y += x86.o x86_cpuid.o x86_decode.o x86_descr.o x86_emu.o x86_flags.o x86_mmu.o x86hvf.o x86_task.o
> diff --git a/target/i386/hvf/hvf-cpus.c b/target/i386/hvf/hvf-cpus.c
> new file mode 100644
> index 0000000000..9540157f1e
> --- /dev/null
> +++ b/target/i386/hvf/hvf-cpus.c

I'd prefer singular form in variables and file names. More on that in
the comment to patch 2.

Besides that it works fine,

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>

Regards,
Roman

