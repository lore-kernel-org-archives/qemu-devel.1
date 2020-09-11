Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6A9C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C57920758
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eeNFaUcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C57920758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGlBp-0002YM-QZ
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGlAV-0001Zp-Lb
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:40:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53605
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGlAS-0000wI-Vh
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599838851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UN2bSryhvMepP4zHQ4+jKVbp9eMdmEqnfMuafjliiLg=;
 b=eeNFaUcjE0eUPgfEfOTyN3rZKoUdOoJHSa2OfUX5X2wWU2x9TuScTWaMwIEwEdNfhEKOec
 4JyFSOV7TszO2kL0Dr7yqs5BEtjK8ZWjA0NDAo7ojwwCoGiKphi1WkkcnFb+09lV9srEla
 ivbFE7jjIFK4Lr9EO8j2TDJOviRyfew=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-4hc2uPJ7NV6JMRNnsTqu8Q-1; Fri, 11 Sep 2020 11:40:47 -0400
X-MC-Unique: 4hc2uPJ7NV6JMRNnsTqu8Q-1
Received: by mail-wm1-f71.google.com with SMTP id l26so1506489wmg.7
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 08:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UN2bSryhvMepP4zHQ4+jKVbp9eMdmEqnfMuafjliiLg=;
 b=X6abIhWoAaQZNYIOdIWmGuYO4y8C2xI1eH8y7mzkrRYPDHCcflH9ETvOCpYfNvj6+3
 ss6IR9lr7TQ2pMefVLEyNDMa5ehsTjiROYQtpNY5DOEe3R60sGmvvN8kWNhhtMYXtg/5
 KSpXzanucf1q6jB/EMclUC3iz6WzW3CbwRFOkBKzXVVKiY3bW9qXGVHufNKaQy5+/pY5
 JLDxUTyJ99KnY207HJYngaxosVbcT8T8nG+tgnLoWjPBItkmUr3lpe6hqUiJPAvAJQXb
 MhJl5+4wDmt7Mwev+uwxeP/dGhjblpu5+VskQoJLhMnULpfxHkaLs/9rapy7K9wUMmKb
 Y5zQ==
X-Gm-Message-State: AOAM533vz33DOKEEFwH4hvQIWOzsF8hAirqOpmK2Yd0evAZ099Zqcq/k
 4EDVGv+E98Bn1qpcLzxxEtUiJ1UbxUT92chNmiTztlLmngsv/nveVGSQdzop7qOERaiX66ZGREj
 N3rOpH6P40ORMR6g=
X-Received: by 2002:a5d:620e:: with SMTP id y14mr2877898wru.371.1599838846165; 
 Fri, 11 Sep 2020 08:40:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuzgssgt31uqAU2mill+ZTkVC1lG4++ir/jKidgmYmnmab9oN6h9amU+4Gg9oLYIEH8XgYYg==
X-Received: by 2002:a5d:620e:: with SMTP id y14mr2877877wru.371.1599838845801; 
 Fri, 11 Sep 2020 08:40:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5568:7f99:4893:a5b6?
 ([2001:b07:6468:f312:5568:7f99:4893:a5b6])
 by smtp.gmail.com with ESMTPSA id v2sm5288456wrm.16.2020.09.11.08.40.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 08:40:45 -0700 (PDT)
Subject: Re: [PATCH] WHPX: vmware cpuid leaf for tsc and apic frequency
To: Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
References: <SN4PR2101MB08808DFDDC3F442BBEAADFF4C0710@SN4PR2101MB0880.namprd21.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8509c09e-20ba-9480-0966-7fe83cf8ca35@redhat.com>
Date: Fri, 11 Sep 2020 17:40:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB08808DFDDC3F442BBEAADFF4C0710@SN4PR2101MB0880.namprd21.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:28:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Weil <sw@weilnetz.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/07/20 00:11, Sunil Muthuswamy wrote:
> Newer versions of WHPX provide the capability to query the tsc
> and apic frequency. Expose these through the vmware cpuid leaf.
> This patch doesnt support setting the tsc frequency; that will
> come as a separate fix.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
>  target/i386/whp-dispatch.h |  3 +-
>  target/i386/whpx-all.c     | 94 ++++++++++++++++++++++++++++++++++----
>  2 files changed, 86 insertions(+), 11 deletions(-)
> 
> diff --git a/target/i386/whp-dispatch.h b/target/i386/whp-dispatch.h
> index e4695c349f..b18aba20ed 100644
> --- a/target/i386/whp-dispatch.h
> +++ b/target/i386/whp-dispatch.h
> @@ -2,10 +2,11 @@
>  #define WHP_DISPATCH_H
>  
>  #include <windows.h>
> -
>  #include <WinHvPlatform.h>
>  #include <WinHvEmulation.h>
>  
> +#define WHV_E_UNKNOWN_CAPABILITY 0x80370300L
> +
>  #define LIST_WINHVPLATFORM_FUNCTIONS(X) \
>    X(HRESULT, WHvGetCapability, (WHV_CAPABILITY_CODE CapabilityCode, VOID* CapabilityBuffer, UINT32 CapabilityBufferSizeInBytes, UINT32* WrittenSizeInBytes)) \
>    X(HRESULT, WHvCreatePartition, (WHV_PARTITION_HANDLE* Partition)) \
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index c78baac6df..da4c135925 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -27,6 +27,8 @@
>  #include <WinHvPlatform.h>
>  #include <WinHvEmulation.h>
>  
> +#define HYPERV_APIC_BUS_FREQUENCY      (200000000ULL)
> +
>  struct whpx_state {
>      uint64_t mem_quota;
>      WHV_PARTITION_HANDLE partition;
> @@ -1061,6 +1063,18 @@ static int whpx_vcpu_run(CPUState *cpu)
>              cpu_x86_cpuid(env, cpuid_fn, 0, (UINT32 *)&rax, (UINT32 *)&rbx,
>                  (UINT32 *)&rcx, (UINT32 *)&rdx);
>              switch (cpuid_fn) {
> +            case 0x40000000:
> +                /* Expose the vmware cpu frequency cpuid leaf */
> +                rax = 0x40000010;
> +                rbx = rcx = rdx = 0;
> +                break;
> +
> +            case 0x40000010:
> +                rax = env->tsc_khz;
> +                rbx = env->apic_bus_freq / 1000; /* Hz to KHz */
> +                rcx = rdx = 0;
> +                break;
> +
>              case 0x80000001:
>                  /* Remove any support of OSVW */
>                  rcx &= ~CPUID_EXT3_OSVW;
> @@ -1193,6 +1207,10 @@ int whpx_init_vcpu(CPUState *cpu)
>      struct whpx_state *whpx = &whpx_global;
>      struct whpx_vcpu *vcpu;
>      Error *local_error = NULL;
> +    struct CPUX86State *env = (CPUArchState *)(cpu->env_ptr);
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    UINT64 freq = 0;
> +    int ret;
>  
>      /* Add migration blockers for all unsupported features of the
>       * Windows Hypervisor Platform
> @@ -1207,7 +1225,8 @@ int whpx_init_vcpu(CPUState *cpu)
>              error_report_err(local_error);
>              migrate_del_blocker(whpx_migration_blocker);
>              error_free(whpx_migration_blocker);
> -            return -EINVAL;
> +            ret = -EINVAL;
> +            goto error;
>          }
>      }
>  
> @@ -1215,7 +1234,8 @@ int whpx_init_vcpu(CPUState *cpu)
>  
>      if (!vcpu) {
>          error_report("WHPX: Failed to allocte VCPU context.");
> -        return -ENOMEM;
> +        ret = -ENOMEM;
> +        goto error;
>      }
>  
>      hr = whp_dispatch.WHvEmulatorCreateEmulator(
> @@ -1224,8 +1244,8 @@ int whpx_init_vcpu(CPUState *cpu)
>      if (FAILED(hr)) {
>          error_report("WHPX: Failed to setup instruction completion support,"
>                       " hr=%08lx", hr);
> -        g_free(vcpu);
> -        return -EINVAL;
> +        ret = -EINVAL;
> +        goto error;
>      }
>  
>      hr = whp_dispatch.WHvCreateVirtualProcessor(
> @@ -1234,17 +1254,72 @@ int whpx_init_vcpu(CPUState *cpu)
>          error_report("WHPX: Failed to create a virtual processor,"
>                       " hr=%08lx", hr);
>          whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
> -        g_free(vcpu);
> -        return -EINVAL;
> +        ret = -EINVAL;
> +        goto error;
>      }
>  
> -    vcpu->interruptable = true;
> +    /*
> +     * vcpu's TSC frequency is either specified by user, or use the value
> +     * provided by Hyper-V if the former is not present. In the latter case, we
> +     * query it from Hyper-V and record in env->tsc_khz, so that vcpu's TSC
> +     * frequency can be migrated later via this field.
> +     */
> +    if (!env->tsc_khz) {
> +        hr = whp_dispatch.WHvGetCapability(
> +            WHvCapabilityCodeProcessorClockFrequency, &freq, sizeof(freq),
> +                NULL);
> +        if (hr != WHV_E_UNKNOWN_CAPABILITY) {
> +            if (FAILED(hr)) {
> +                printf("WHPX: Failed to query tsc frequency, hr=0x%08lx\n", hr);
> +            } else {
> +                env->tsc_khz = freq / 1000; /* Hz to KHz */
> +            }
> +        }
> +    }
>  
> +    env->apic_bus_freq = HYPERV_APIC_BUS_FREQUENCY;
> +    hr = whp_dispatch.WHvGetCapability(
> +        WHvCapabilityCodeInterruptClockFrequency, &freq, sizeof(freq), NULL);
> +    if (hr != WHV_E_UNKNOWN_CAPABILITY) {
> +        if (FAILED(hr)) {
> +            printf("WHPX: Failed to query apic bus frequency hr=0x%08lx\n", hr);
> +        } else {
> +            env->apic_bus_freq = freq;
> +        }
> +    }
> +
> +    /*
> +     * If the vmware cpuid frequency leaf option is set, and we have a valid
> +     * tsc value, trap the corresponding cpuid's.
> +     */
> +    if (x86_cpu->vmware_cpuid_freq && env->tsc_khz) {
> +        UINT32 cpuidExitList[] = {1, 0x80000001, 0x40000000, 0x40000010};
> +
> +        hr = whp_dispatch.WHvSetPartitionProperty(
> +                whpx->partition,
> +                WHvPartitionPropertyCodeCpuidExitList,
> +                cpuidExitList,
> +                RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
> +
> +        if (FAILED(hr)) {
> +            error_report("WHPX: Failed to set partition CpuidExitList hr=%08lx",
> +                        hr);
> +            ret = -EINVAL;
> +            goto error;
> +        }
> +    }
> +
> +    vcpu->interruptable = true;
>      cpu->vcpu_dirty = true;
>      cpu->hax_vcpu = (struct hax_vcpu_state *)vcpu;
>      qemu_add_vm_change_state_handler(whpx_cpu_update_state, cpu->env_ptr);
>  
>      return 0;
> +
> +error:
> +    g_free(vcpu);
> +
> +    return ret;
>  }
>  
>  int whpx_vcpu_exec(CPUState *cpu)
> @@ -1493,6 +1568,7 @@ static int whpx_accel_init(MachineState *ms)
>      WHV_CAPABILITY whpx_cap;
>      UINT32 whpx_cap_size;
>      WHV_PARTITION_PROPERTY prop;
> +    UINT32 cpuidExitList[] = {1, 0x80000001};
>  
>      whpx = &whpx_global;
>  
> @@ -1551,7 +1627,6 @@ static int whpx_accel_init(MachineState *ms)
>          goto error;
>      }
>  
> -    UINT32 cpuidExitList[] = {1, 0x80000001};
>      hr = whp_dispatch.WHvSetPartitionProperty(
>          whpx->partition,
>          WHvPartitionPropertyCodeCpuidExitList,
> @@ -1579,14 +1654,13 @@ static int whpx_accel_init(MachineState *ms)
>      printf("Windows Hypervisor Platform accelerator is operational\n");
>      return 0;
>  
> -  error:
> +error:
>  
>      if (NULL != whpx->partition) {
>          whp_dispatch.WHvDeletePartition(whpx->partition);
>          whpx->partition = NULL;
>      }
>  
> -
>      return ret;
>  }
>  
> 

Queued, thanks.

Paolo


