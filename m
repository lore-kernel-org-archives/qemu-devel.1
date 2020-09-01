Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E29C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801FC206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="GjGcRnMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801FC206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2l6-0007Bl-O7
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kD2kM-0006ak-3a
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:38:34 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:47324 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kD2kJ-0001eK-Mh
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:38:33 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 5250752215;
 Tue,  1 Sep 2020 09:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1598953107;
 x=1600767508; bh=X3Gk2XeTBjoOCM/H6LmDrAf1ntAV3mfPsyyK5v7TkCA=; b=
 GjGcRnMa13zfw3wxHwOgtasw/Jyzns9Q5+NZ2iGjX+OhJuyyTO5veQY4TvNNgNf9
 aBkua/S2BrCK9Rl1Y5ua6rVbYKLZgoK1LLM6jg3hA5LUUxxFptS3qDSUjANFXPJt
 ygQxHUNk2Yw6deCvv5Djp+QzzWlTtznmcq14i1tChoA=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ju_sQ5fLboxz; Tue,  1 Sep 2020 12:38:27 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 2B76A50202;
 Tue,  1 Sep 2020 12:38:27 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 1 Sep
 2020 12:38:27 +0300
Date: Tue, 1 Sep 2020 12:38:26 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 12/16] cpus: add handle_interrupt to the CpusAccel
 interface
Message-ID: <20200901093826.GD22344@SPB-NB-133.local>
References: <20200901072201.7133-1-cfontana@suse.de>
 <20200901072201.7133-13-cfontana@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200901072201.7133-13-cfontana@suse.de>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:30:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
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

On Tue, Sep 01, 2020 at 09:21:57AM +0200, Claudio Fontana wrote:
> kvm: uses the generic handler
> qtest: uses the generic handler
> whpx: changed to use the generic handler (identical implementation)
> hax: changed to use the generic handler (identical implementation)
> hvf: changed to use the generic handler (identical implementation)
> tcg: adapt tcg-cpus to point to the tcg-specific handler
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  accel/tcg/tcg-all.c    | 26 --------------------------
>  accel/tcg/tcg-cpus.c   | 28 ++++++++++++++++++++++++++++
>  hw/core/cpu.c          | 13 -------------
>  include/hw/core/cpu.h  | 14 --------------
>  include/sysemu/cpus.h  |  2 ++
>  softmmu/cpus.c         | 18 ++++++++++++++++++
>  target/i386/hax-all.c  | 10 ----------
>  target/i386/hvf/hvf.c  |  9 ---------
>  target/i386/whpx-all.c | 10 ----------
>  9 files changed, 48 insertions(+), 82 deletions(-)
> 
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 01957b130d..af9bf5c5bb 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -47,31 +47,6 @@ typedef struct TCGState {
>  #define TCG_STATE(obj) \
>          OBJECT_CHECK(TCGState, (obj), TYPE_TCG_ACCEL)
>  
> -/* mask must never be zero, except for A20 change call */
> -static void tcg_handle_interrupt(CPUState *cpu, int mask)
> -{
> -    int old_mask;
> -    g_assert(qemu_mutex_iothread_locked());
> -
> -    old_mask = cpu->interrupt_request;
> -    cpu->interrupt_request |= mask;
> -
> -    /*
> -     * If called from iothread context, wake the target cpu in
> -     * case its halted.
> -     */
> -    if (!qemu_cpu_is_self(cpu)) {
> -        qemu_cpu_kick(cpu);
> -    } else {
> -        atomic_set(&cpu_neg(cpu)->icount_decr.u16.high, -1);
> -        if (icount_enabled() &&
> -            !cpu->can_do_io
> -            && (mask & ~old_mask) != 0) {
> -            cpu_abort(cpu, "Raised interrupt while not in I/O function");
> -        }
> -    }
> -}
> -
>  /*
>   * We default to false if we know other options have been enabled
>   * which are currently incompatible with MTTCG. Otherwise when each
> @@ -128,7 +103,6 @@ static int tcg_init(MachineState *ms)
>      TCGState *s = TCG_STATE(current_accel());
>  
>      tcg_exec_init(s->tb_size * 1024 * 1024);
> -    cpu_interrupt_handler = tcg_handle_interrupt;
>      mttcg_enabled = s->mttcg_enabled;
>      cpus_register_accel(&tcg_cpus);
>  
> diff --git a/accel/tcg/tcg-cpus.c b/accel/tcg/tcg-cpus.c
> index 72696f6d86..2bb209e2c6 100644
> --- a/accel/tcg/tcg-cpus.c
> +++ b/accel/tcg/tcg-cpus.c
> @@ -533,9 +533,37 @@ static int64_t tcg_get_elapsed_ticks(void)
>      return cpu_get_ticks();
>  }
>  
> +/* mask must never be zero, except for A20 change call */
> +static void tcg_handle_interrupt(CPUState *cpu, int mask)
> +{
> +    int old_mask;
> +    g_assert(qemu_mutex_iothread_locked());
> +
> +    old_mask = cpu->interrupt_request;
> +    cpu->interrupt_request |= mask;
> +
> +    /*
> +     * If called from iothread context, wake the target cpu in
> +     * case its halted.
> +     */
> +    if (!qemu_cpu_is_self(cpu)) {
> +        qemu_cpu_kick(cpu);
> +    } else {
> +        atomic_set(&cpu_neg(cpu)->icount_decr.u16.high, -1);
> +        if (icount_enabled() &&
> +            !cpu->can_do_io
> +            && (mask & ~old_mask) != 0) {
> +            cpu_abort(cpu, "Raised interrupt while not in I/O function");
> +        }
> +    }
> +}
> +
>  const CpusAccel tcg_cpus = {
>      .create_vcpu_thread = tcg_start_vcpu_thread,
>      .kick_vcpu_thread = tcg_kick_vcpu_thread,
> +
> +    .handle_interrupt = tcg_handle_interrupt,
> +
>      .get_virtual_clock = tcg_get_virtual_clock,
>      .get_elapsed_ticks = tcg_get_elapsed_ticks,
>  };
> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
> index fa8602493b..451b3d5ee7 100644
> --- a/hw/core/cpu.c
> +++ b/hw/core/cpu.c
> @@ -35,8 +35,6 @@
>  #include "qemu/plugin.h"
>  #include "sysemu/hw_accel.h"
>  
> -CPUInterruptHandler cpu_interrupt_handler;
> -
>  CPUState *cpu_by_arch_id(int64_t id)
>  {
>      CPUState *cpu;
> @@ -394,17 +392,6 @@ static vaddr cpu_adjust_watchpoint_address(CPUState *cpu, vaddr addr, int len)
>      return addr;
>  }
>  
> -static void generic_handle_interrupt(CPUState *cpu, int mask)
> -{
> -    cpu->interrupt_request |= mask;
> -
> -    if (!qemu_cpu_is_self(cpu)) {
> -        qemu_cpu_kick(cpu);
> -    }
> -}
> -
> -CPUInterruptHandler cpu_interrupt_handler = generic_handle_interrupt;
> -
>  static void cpu_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 8f145733ce..efd33d87fd 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -838,12 +838,6 @@ bool cpu_exists(int64_t id);
>   */
>  CPUState *cpu_by_arch_id(int64_t id);
>  
> -#ifndef CONFIG_USER_ONLY
> -
> -typedef void (*CPUInterruptHandler)(CPUState *, int);
> -
> -extern CPUInterruptHandler cpu_interrupt_handler;
> -
>  /**
>   * cpu_interrupt:
>   * @cpu: The CPU to set an interrupt on.
> @@ -851,17 +845,9 @@ extern CPUInterruptHandler cpu_interrupt_handler;
>   *
>   * Invokes the interrupt handler.
>   */
> -static inline void cpu_interrupt(CPUState *cpu, int mask)
> -{
> -    cpu_interrupt_handler(cpu, mask);
> -}
> -
> -#else /* USER_ONLY */
>  
>  void cpu_interrupt(CPUState *cpu, int mask);
>  
> -#endif /* USER_ONLY */
> -
>  #ifdef NEED_CPU_H
>  
>  #ifdef CONFIG_SOFTMMU
> diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
> index 26171697f5..231685955d 100644
> --- a/include/sysemu/cpus.h
> +++ b/include/sysemu/cpus.h
> @@ -16,6 +16,8 @@ typedef struct CpusAccel {
>      void (*synchronize_state)(CPUState *cpu);
>      void (*synchronize_pre_loadvm)(CPUState *cpu);
>  
> +    void (*handle_interrupt)(CPUState *cpu, int mask);
> +
>      int64_t (*get_virtual_clock)(void);
>      int64_t (*get_elapsed_ticks)(void);
>  } CpusAccel;
> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> index f32ecb4bb9..7068666579 100644
> --- a/softmmu/cpus.c
> +++ b/softmmu/cpus.c
> @@ -225,6 +225,24 @@ int64_t cpus_get_elapsed_ticks(void)
>      return cpu_get_ticks();
>  }
>  
> +static void generic_handle_interrupt(CPUState *cpu, int mask)
> +{
> +    cpu->interrupt_request |= mask;
> +
> +    if (!qemu_cpu_is_self(cpu)) {
> +        qemu_cpu_kick(cpu);
> +    }
> +}
> +
> +void cpu_interrupt(CPUState *cpu, int mask)
> +{
> +    if (cpus_accel->handle_interrupt) {
> +        cpus_accel->handle_interrupt(cpu, mask);
> +    } else {
> +        generic_handle_interrupt(cpu, mask);
> +    }
> +}
> +

The handlers is not something that dynamically changes, the functions
can be assigned once during accel registration. Accel registraton is
also the place where the checks can take place.

Regards,
Roman

>  static int do_vm_stop(RunState state, bool send_stop)
>  {
>      int ret = 0;
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index b66ddeb8bf..fd1ab673d7 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -297,15 +297,6 @@ int hax_vm_destroy(struct hax_vm *vm)
>      return 0;
>  }
>  
> -static void hax_handle_interrupt(CPUState *cpu, int mask)
> -{
> -    cpu->interrupt_request |= mask;
> -
> -    if (!qemu_cpu_is_self(cpu)) {
> -        qemu_cpu_kick(cpu);
> -    }
> -}
> -
>  static int hax_init(ram_addr_t ram_size, int max_cpus)
>  {
>      struct hax_state *hax = NULL;
> @@ -350,7 +341,6 @@ static int hax_init(ram_addr_t ram_size, int max_cpus)
>      qversion.cur_version = hax_cur_version;
>      qversion.min_version = hax_min_version;
>      hax_notify_qemu_version(hax->vm->fd, &qversion);
> -    cpu_interrupt_handler = hax_handle_interrupt;
>  
>      return ret;
>    error:
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 7ac6987c1b..ed9356565c 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -262,14 +262,6 @@ static void update_apic_tpr(CPUState *cpu)
>  
>  #define VECTORING_INFO_VECTOR_MASK     0xff
>  
> -static void hvf_handle_interrupt(CPUState * cpu, int mask)
> -{
> -    cpu->interrupt_request |= mask;
> -    if (!qemu_cpu_is_self(cpu)) {
> -        qemu_cpu_kick(cpu);
> -    }
> -}
> -
>  void hvf_handle_io(CPUArchState *env, uint16_t port, void *buffer,
>                    int direction, int size, int count)
>  {
> @@ -894,7 +886,6 @@ static int hvf_accel_init(MachineState *ms)
>      }
>    
>      hvf_state = s;
> -    cpu_interrupt_handler = hvf_handle_interrupt;
>      memory_listener_register(&hvf_memory_listener, &address_space_memory);
>      cpus_register_accel(&hvf_cpus);
>      return 0;
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index 8b6986c864..b3d17fbe04 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -1413,15 +1413,6 @@ static void whpx_memory_init(void)
>      memory_listener_register(&whpx_memory_listener, &address_space_memory);
>  }
>  
> -static void whpx_handle_interrupt(CPUState *cpu, int mask)
> -{
> -    cpu->interrupt_request |= mask;
> -
> -    if (!qemu_cpu_is_self(cpu)) {
> -        qemu_cpu_kick(cpu);
> -    }
> -}
> -
>  /*
>   * Load the functions from the given library, using the given handle. If a
>   * handle is provided, it is used, otherwise the library is opened. The
> @@ -1576,7 +1567,6 @@ static int whpx_accel_init(MachineState *ms)
>  
>      whpx_memory_init();
>  
> -    cpu_interrupt_handler = whpx_handle_interrupt;
>      cpus_register_accel(&whpx_cpus);
>  
>      printf("Windows Hypervisor Platform accelerator is operational\n");
> -- 
> 2.26.2
> 

