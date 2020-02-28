Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF47C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D2DC24697
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCNdL1Yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2DC24697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7d9a-0007X5-Oa
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j7d8v-0006zf-FN
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:45:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j7d8t-0007XN-NZ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:45:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35512
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j7d8t-0007Wn-IO
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582886715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uo2rfkBfSja+x0Q+JOySMcaB7AokwZ6OJRj/Vr0cWiE=;
 b=ZCNdL1YxD4C6wXxxAqbxF/gsDOktKVkJBdXLa4KzeHVm0s/Td+qVFlAKrDQJ9kv7ZkLJe2
 LhBlooKPLuBqVV/zqK66okP5NVbl3POARR/cMNwEDvg1MxjtB8R8UBYN7clOTNTvg4hy21
 yE5KH0pg0n5tU2cp4mcwZXfFAiNWXOI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-gaylZ8AEMqaG3uE3V04TQg-1; Fri, 28 Feb 2020 05:45:13 -0500
X-MC-Unique: gaylZ8AEMqaG3uE3V04TQg-1
Received: by mail-wr1-f70.google.com with SMTP id n12so1152054wrp.19
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 02:45:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Uo2rfkBfSja+x0Q+JOySMcaB7AokwZ6OJRj/Vr0cWiE=;
 b=Nan9nd1aIEqfYZtk2E05IVDQUy2bfF37rzMVFvrpd2eHF5qL+baErgwZD6He2MZ+ap
 UILz1xzW+nFHMPmwSz+nU4lfqiZv+UYoi1GE66V7/c3L3MxcDRoPJop9wxW0cyMO+dN3
 4j3r0LALQd7witKGXSgjDx7EhNjyOFQfDmYL/I0SmzZDnuHLKxViu7dFaAv7SgHwC7y8
 5dhhsmgrxK3wilytK/NMyN/tlGr4ATEHN07ii9IZMX+NXDb0Jl/iTJIZQpDk39VdCBrB
 cJfbJgGry7RxJeoQSzFY+EHNOn+opVD1RR60+Tum9Utyv17YXZY6lcxGc1pa4ckYrBVV
 Jx8Q==
X-Gm-Message-State: APjAAAV+zykdDVLG8c9vHqSoLFIGj9n65wr7fa3lgJRYiUWqSJZ45XdO
 fuWN4z++5pxXIL/0slVgNYJbpKk7GsGqLBjBRGve/GQrv1ykjnvYQZYW07xEaWU1LvHmeTlro6Y
 2ihMKR+mIoIdn39o=
X-Received: by 2002:a7b:cc69:: with SMTP id n9mr4418193wmj.163.1582886711899; 
 Fri, 28 Feb 2020 02:45:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxVEO3y6UTn1PlPeIpvNcO/ra4YrBgq1ZgJCusemqM8H7SoKaRDdLmr2MBaaRny1S6OfiJFuw==
X-Received: by 2002:a7b:cc69:: with SMTP id n9mr4418156wmj.163.1582886711487; 
 Fri, 28 Feb 2020 02:45:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f?
 ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id m19sm1624870wmc.34.2020.02.28.02.45.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 02:45:09 -0800 (PST)
Subject: Re: PATCH] WHPX: TSC get and set should be dependent on VM state
To: Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
References: <SN4PR2101MB08804D23439166E81FF151F7C0EA0@SN4PR2101MB0880.namprd21.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <37e639a1-eb9f-b769-d61c-112d148bcff3@redhat.com>
Date: Fri, 28 Feb 2020 11:45:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB08804D23439166E81FF151F7C0EA0@SN4PR2101MB0880.namprd21.prod.outlook.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Stefan Weil <sw@weilnetz.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/02/20 21:54, Sunil Muthuswamy wrote:
> Currently, TSC is set as part of the VM runtime state. Setting TSC at
> runtime is heavy and additionally can have side effects on the guest,
> which are not very resilient to variances in the TSC. This patch uses
> the VM state to determine whether to set TSC or not. Some minor
> enhancements for getting TSC values as well that considers the VM state.
> 
> Additionally, while setting the TSC, the partition is suspended to
> reduce the variance in the TSC value across vCPUs.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>

Looks good.  Do you want me to queue this until you can have your GPG
key signed?  (And also, I can help you sign it of course).

Thanks,

> ---
>  include/sysemu/whpx.h      |   7 +++
>  target/i386/whp-dispatch.h |   9 ++++
>  target/i386/whpx-all.c     | 103 +++++++++++++++++++++++++++++++++----
>  3 files changed, 110 insertions(+), 9 deletions(-)
> 
> diff --git a/include/sysemu/whpx.h b/include/sysemu/whpx.h
> index 4794e8effe..a84b49e749 100644
> --- a/include/sysemu/whpx.h
> +++ b/include/sysemu/whpx.h
> @@ -35,4 +35,11 @@ int whpx_enabled(void);
>  
>  #endif /* CONFIG_WHPX */
>  
> +/* state subset only touched by the VCPU itself during runtime */
> +#define WHPX_SET_RUNTIME_STATE   1
> +/* state subset modified during VCPU reset */
> +#define WHPX_SET_RESET_STATE     2
> +/* full state set, modified during initialization or on vmload */
> +#define WHPX_SET_FULL_STATE      3
> +
>  #endif /* QEMU_WHPX_H */
> diff --git a/target/i386/whp-dispatch.h b/target/i386/whp-dispatch.h
> index 87d049ceab..e4695c349f 100644
> --- a/target/i386/whp-dispatch.h
> +++ b/target/i386/whp-dispatch.h
> @@ -23,6 +23,12 @@
>    X(HRESULT, WHvGetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, const WHV_REGISTER_NAME* RegisterNames, UINT32 RegisterCount, WHV_REGISTER_VALUE* RegisterValues)) \
>    X(HRESULT, WHvSetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, const WHV_REGISTER_NAME* RegisterNames, UINT32 RegisterCount, const WHV_REGISTER_VALUE* RegisterValues)) \
>  
> +/*
> + * These are supplemental functions that may not be present
> + * on all versions and are not critical for basic functionality.
> + */
> +#define LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(X) \
> +  X(HRESULT, WHvSuspendPartitionTime, (WHV_PARTITION_HANDLE Partition)) \
>  
>  #define LIST_WINHVEMULATION_FUNCTIONS(X) \
>    X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS* Callbacks, WHV_EMULATOR_HANDLE* Emulator)) \
> @@ -40,10 +46,12 @@
>  /* Define function typedef */
>  LIST_WINHVPLATFORM_FUNCTIONS(WHP_DEFINE_TYPE)
>  LIST_WINHVEMULATION_FUNCTIONS(WHP_DEFINE_TYPE)
> +LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DEFINE_TYPE)
>  
>  struct WHPDispatch {
>      LIST_WINHVPLATFORM_FUNCTIONS(WHP_DECLARE_MEMBER)
>      LIST_WINHVEMULATION_FUNCTIONS(WHP_DECLARE_MEMBER)
> +    LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DECLARE_MEMBER)
>  };
>  
>  extern struct WHPDispatch whp_dispatch;
> @@ -53,6 +61,7 @@ bool init_whp_dispatch(void);
>  typedef enum WHPFunctionList {
>      WINHV_PLATFORM_FNS_DEFAULT,
>      WINHV_EMULATION_FNS_DEFAULT,
> +    WINHV_PLATFORM_FNS_SUPPLEMENTAL
>  } WHPFunctionList;
>  
>  #endif /* WHP_DISPATCH_H */
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index 35601b8176..6a885c0fb3 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -114,7 +114,6 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
>      WHvX64RegisterXmmControlStatus,
>  
>      /* X64 MSRs */
> -    WHvX64RegisterTsc,
>      WHvX64RegisterEfer,
>  #ifdef TARGET_X86_64
>      WHvX64RegisterKernelGsBase,
> @@ -215,7 +214,44 @@ static SegmentCache whpx_seg_h2q(const WHV_X64_SEGMENT_REGISTER *hs)
>      return qs;
>  }
>  
> -static void whpx_set_registers(CPUState *cpu)
> +static int whpx_set_tsc(CPUState *cpu)
> +{
> +    struct CPUX86State *env = (CPUArchState *)(cpu->env_ptr);
> +    WHV_REGISTER_NAME tsc_reg = WHvX64RegisterTsc;
> +    WHV_REGISTER_VALUE tsc_val;
> +    HRESULT hr;
> +    struct whpx_state *whpx = &whpx_global;
> +
> +    /*
> +     * Suspend the partition prior to setting the TSC to reduce the variance
> +     * in TSC across vCPUs. When the first vCPU runs post suspend, the
> +     * partition is automatically resumed.
> +     */
> +    if (whp_dispatch.WHvSuspendPartitionTime) {
> +
> +        /*
> +         * Unable to suspend partition while setting TSC is not a fatal
> +         * error. It just increases the likelihood of TSC variance between
> +         * vCPUs and some guest OS are able to handle that just fine.
> +         */
> +        hr = whp_dispatch.WHvSuspendPartitionTime(whpx->partition);
> +        if (FAILED(hr)) {
> +            warn_report("WHPX: Failed to suspend partition, hr=%08lx", hr);
> +        }
> +    }
> +
> +    tsc_val.Reg64 = env->tsc;
> +    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
> +        whpx->partition, cpu->cpu_index, &tsc_reg, 1, &tsc_val);
> +    if (FAILED(hr)) {
> +        error_report("WHPX: Failed to set TSC, hr=%08lx", hr);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static void whpx_set_registers(CPUState *cpu, int level)
>  {
>      struct whpx_state *whpx = &whpx_global;
>      struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
> @@ -230,6 +266,14 @@ static void whpx_set_registers(CPUState *cpu)
>  
>      assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
>  
> +    /*
> +     * Following MSRs have side effects on the guest or are too heavy for
> +     * runtime. Limit them to full state update.
> +     */
> +    if (level >= WHPX_SET_RESET_STATE) {
> +        whpx_set_tsc(cpu);
> +    }
> +
>      memset(&vcxt, 0, sizeof(struct whpx_register_set));
>  
>      v86 = (env->eflags & VM_MASK);
> @@ -330,8 +374,6 @@ static void whpx_set_registers(CPUState *cpu)
>      idx += 1;
>  
>      /* MSRs */
> -    assert(whpx_register_names[idx] == WHvX64RegisterTsc);
> -    vcxt.values[idx++].Reg64 = env->tsc;
>      assert(whpx_register_names[idx] == WHvX64RegisterEfer);
>      vcxt.values[idx++].Reg64 = env->efer;
>  #ifdef TARGET_X86_64
> @@ -379,6 +421,25 @@ static void whpx_set_registers(CPUState *cpu)
>      return;
>  }
>  
> +static int whpx_get_tsc(CPUState *cpu)
> +{
> +    struct CPUX86State *env = (CPUArchState *)(cpu->env_ptr);
> +    WHV_REGISTER_NAME tsc_reg = WHvX64RegisterTsc;
> +    WHV_REGISTER_VALUE tsc_val;
> +    HRESULT hr;
> +    struct whpx_state *whpx = &whpx_global;
> +
> +    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(
> +        whpx->partition, cpu->cpu_index, &tsc_reg, 1, &tsc_val);
> +    if (FAILED(hr)) {
> +        error_report("WHPX: Failed to get TSC, hr=%08lx", hr);
> +        return -1;
> +    }
> +
> +    env->tsc = tsc_val.Reg64;
> +    return 0;
> +}
> +
>  static void whpx_get_registers(CPUState *cpu)
>  {
>      struct whpx_state *whpx = &whpx_global;
> @@ -394,6 +455,11 @@ static void whpx_get_registers(CPUState *cpu)
>  
>      assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
>  
> +    if (!env->tsc_valid) {
> +        whpx_get_tsc(cpu);
> +        env->tsc_valid = !runstate_is_running();
> +    }
> +
>      hr = whp_dispatch.WHvGetVirtualProcessorRegisters(
>          whpx->partition, cpu->cpu_index,
>          whpx_register_names,
> @@ -492,8 +558,6 @@ static void whpx_get_registers(CPUState *cpu)
>      idx += 1;
>  
>      /* MSRs */
> -    assert(whpx_register_names[idx] == WHvX64RegisterTsc);
> -    env->tsc = vcxt.values[idx++].Reg64;
>      assert(whpx_register_names[idx] == WHvX64RegisterEfer);
>      env->efer = vcxt.values[idx++].Reg64;
>  #ifdef TARGET_X86_64
> @@ -896,7 +960,7 @@ static int whpx_vcpu_run(CPUState *cpu)
>  
>      do {
>          if (cpu->vcpu_dirty) {
> -            whpx_set_registers(cpu);
> +            whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
>              cpu->vcpu_dirty = false;
>          }
>  
> @@ -1074,14 +1138,14 @@ static void do_whpx_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
>  static void do_whpx_cpu_synchronize_post_reset(CPUState *cpu,
>                                                 run_on_cpu_data arg)
>  {
> -    whpx_set_registers(cpu);
> +    whpx_set_registers(cpu, WHPX_SET_RESET_STATE);
>      cpu->vcpu_dirty = false;
>  }
>  
>  static void do_whpx_cpu_synchronize_post_init(CPUState *cpu,
>                                                run_on_cpu_data arg)
>  {
> -    whpx_set_registers(cpu);
> +    whpx_set_registers(cpu, WHPX_SET_FULL_STATE);
>      cpu->vcpu_dirty = false;
>  }
>  
> @@ -1123,6 +1187,15 @@ void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu)
>  
>  static Error *whpx_migration_blocker;
>  
> +static void whpx_cpu_update_state(void *opaque, int running, RunState state)
> +{
> +    CPUX86State *env = opaque;
> +
> +    if (running) {
> +        env->tsc_valid = false;
> +    }
> +}
> +
>  int whpx_init_vcpu(CPUState *cpu)
>  {
>      HRESULT hr;
> @@ -1178,6 +1251,7 @@ int whpx_init_vcpu(CPUState *cpu)
>  
>      cpu->vcpu_dirty = true;
>      cpu->hax_vcpu = (struct hax_vcpu_state *)vcpu;
> +    qemu_add_vm_change_state_handler(whpx_cpu_update_state, cpu->env_ptr);
>  
>      return 0;
>  }
> @@ -1367,6 +1441,10 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
>  
>      #define WINHV_PLATFORM_DLL "WinHvPlatform.dll"
>      #define WINHV_EMULATION_DLL "WinHvEmulation.dll"
> +    #define WHP_LOAD_FIELD_OPTIONAL(return_type, function_name, signature) \
> +        whp_dispatch.function_name = \
> +            (function_name ## _t)GetProcAddress(hLib, #function_name); \
> +
>      #define WHP_LOAD_FIELD(return_type, function_name, signature) \
>          whp_dispatch.function_name = \
>              (function_name ## _t)GetProcAddress(hLib, #function_name); \
> @@ -1394,6 +1472,11 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
>          WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
>          LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
>          break;
> +
> +    case WINHV_PLATFORM_FNS_SUPPLEMENTAL:
> +        WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
> +        LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_LOAD_FIELD_OPTIONAL)
> +        break;
>      }
>  
>      *handle = hLib;
> @@ -1554,6 +1637,8 @@ bool init_whp_dispatch(void)
>          goto error;
>      }
>  
> +    assert(load_whp_dispatch_fns(&hWinHvPlatform,
> +        WINHV_PLATFORM_FNS_SUPPLEMENTAL));
>      whp_dispatch_initialized = true;
>  
>      return true;
> 


