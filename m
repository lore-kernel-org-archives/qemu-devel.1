Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D3CC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 03:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B95E120838
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 03:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="qDfZRAhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95E120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKvEQ-0006MW-K1
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 23:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kKvDM-0005tY-83
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 23:13:04 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kKvDF-0007gJ-8t
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 23:13:00 -0400
Received: by mail-pg1-x543.google.com with SMTP id 34so13474467pgo.13
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 20:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=plzlo3709EalLAixaGiVhGPWAijq6aDS+pD50YzgiD4=;
 b=qDfZRAhJ6/dDSy76RrBm8VId0YNMclgSaVVigHukqSaUpGysVxwrxsQt0Dy/aNuVO+
 ArxbIzObco6itV4Sq1NQoFoHsSFMJywnwdMEdTvouu9rgXT9eCzppLVtPvy/L9FUQazL
 YQtl+qndKXIAScfmFNuJEg/8DNwRLHcyBYOkX0TTPpidI0QHRFY6wh21dDTihtEKEwsU
 61rPB6D6y6sRJhAwDkeqEIDzIq3bfCA15sa/TNSJR/tOpIoHtahWpPv/9Tatvg6yAhzT
 aO+XQHxEq68bgzlc/lLaUHgETBWHKJfsBiV4pznJfCMxrrjXBg40lD4vLpWA6xRsBsEE
 8OMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=plzlo3709EalLAixaGiVhGPWAijq6aDS+pD50YzgiD4=;
 b=MuV+s5dkZvuRPc8iBFsDnxUv9pVS/Cx54zSOaaw2TRtbSfYEKco0IZXxluZN3QJB35
 GF18PaNHjzk4Yvv2vYoBiM0krR9JpmDLhMZeKOMaviXMSwuWzTz3QRYj9JqeLlRbu2bv
 0V3pBHyv4oZhLwFBA8xmFzPjWjNuY83PyKn/2GHcDyOYEb4/htbDcqgS+vkYgHGeGthZ
 9H4Hp9DbXm+ITXGqjg5XwS9YKjXmYpcr3chWkB80vHuiBAuRtzR9VtngAM+vXqZ0kQY/
 QQqOYZO11x4N4p2lzXTPcVqm4g6MfeuFcSROAHy/IePL6LGT30iX0wlM8vZNuIDYNs8x
 HUoQ==
X-Gm-Message-State: AOAM532OYW8vB3FjCD8ApmEFRT8awpKN8WB4vw6nWR4EYuMFXfHbD6Co
 UKK6m2Gg/T5l+EbF8D+aD0iSQe+W3EXv+asx
X-Google-Smtp-Source: ABdhPJyoAmvPiGxMgEyUkIGn2eclaW7KmgJhIb+ywetncUSSqX24A7QIvikgc62bKRgC0hkWYfl97A==
X-Received: by 2002:a65:6104:: with SMTP id z4mr6173491pgu.184.1600830774531; 
 Tue, 22 Sep 2020 20:12:54 -0700 (PDT)
Received: from [10.2.24.220] ([61.120.150.77])
 by smtp.gmail.com with ESMTPSA id a15sm16546333pfi.119.2020.09.22.20.12.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Sep 2020 20:12:54 -0700 (PDT)
Subject: Re: [External] Re: [PATCH v2 3/3] target-i386: post memory failure
 event to uplayer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 pbonzini@redhat.com, peter.maydell@linaro.org
References: <20200922095630.394893-1-pizhenwei@bytedance.com>
 <20200922095630.394893-4-pizhenwei@bytedance.com>
 <776b6afe-022e-f304-4bc9-f1f486d75af2@redhat.com>
From: zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <1d31682f-e42a-2674-1122-65eaea474488@bytedance.com>
Date: Wed, 23 Sep 2020 11:12:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <776b6afe-022e-f304-4bc9-f1f486d75af2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: mtosatti@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/22/20 6:30 PM, Philippe Mathieu-Daudé wrote:
> On 9/22/20 11:56 AM, zhenwei pi wrote:
>> Post memory failure event to uplayer to handle hardware memory
>> corrupted event. Rather than simple QEMU log, QEMU could report more
>> effective message to uplayer. For example, guest crashes by MCE,
>> selecting another host server is a better choice.
>>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   target/i386/helper.c | 15 +++++++++++++++
>>   target/i386/kvm.c    |  7 ++++++-
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/helper.c b/target/i386/helper.c
>> index 0c7fd32491..47823c29e4 100644
>> --- a/target/i386/helper.c
>> +++ b/target/i386/helper.c
>> @@ -18,6 +18,7 @@
>>    */
>>   
>>   #include "qemu/osdep.h"
>> +#include "qapi/qapi-events-run-state.h"
>>   #include "cpu.h"
>>   #include "exec/exec-all.h"
>>   #include "qemu/qemu-print.h"
>> @@ -858,6 +859,7 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
>>       CPUX86State *cenv = &cpu->env;
>>       uint64_t *banks = cenv->mce_banks + 4 * params->bank;
>>       char msg[64];
>> +    MemoryFailureFlags mf_flags = {0};
>>       bool need_reset = false;
>>   
>>       cpu_synchronize_state(cs);
>> @@ -869,6 +871,12 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
>>       if (!(params->flags & MCE_INJECT_UNCOND_AO)
>>           && !(params->status & MCI_STATUS_AR)
>>           && (cenv->mcg_status & MCG_STATUS_MCIP)) {
>> +        mf_flags.has_action_required = true;
>> +        mf_flags.action_required = false;
>> +        mf_flags.has_recursive = true;
>> +        mf_flags.recursive = true;
>> +        qapi_event_send_memory_failure(MEMORY_FAILURE_ACTION_GUEST_MCE_INJECT,
>> +                                       true, &mf_flags);
> 
> Can you extract a function such:
> 
> static void emit_guest_mce_failure(bool action_required, bool recursive)
> {
>    ...
> }
> 
> To use as:
> 
>             emit_guest_mce_failure(true, true);
> 
>>           return;
>>       }
>>

There are 2 field in struct MemoryFailureFlags currently, maybe more 
fields need to be added in the future, and emit_guest_mce_failure need 
more arguments too. So is it worth wrapping a function now?


>> @@ -909,6 +917,8 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
>>           }
>>   
>>           if (need_reset) {
>> +            qapi_event_send_memory_failure(
>> +                 MEMORY_FAILURE_ACTION_GUEST_MCE_FATAL, false, NULL);
>>               monitor_printf(params->mon, "%s", msg);
>>               qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
>>               qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>> @@ -934,6 +944,11 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
>>       } else {
>>           banks[1] |= MCI_STATUS_OVER;
>>       }
>> +
>> +    mf_flags.has_action_required = true;
>> +    mf_flags.action_required = !!(params->status & MCI_STATUS_AR);
>> +    qapi_event_send_memory_failure(MEMORY_FAILURE_ACTION_GUEST_MCE_INJECT,
>> +                                   true, &mf_flags);
> 
> And here:
> 
>         emit_guest_mce_failure(params->status & MCI_STATUS_AR, false);
> 
>>   }
>>   
>>   void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index 9efb07e7c8..989889c291 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -14,6 +14,7 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "qapi/error.h"
>> +#include "qapi/qapi-events-run-state.h"
>>   #include <sys/ioctl.h>
>>   #include <sys/utsname.h>
>>   
>> @@ -577,6 +578,8 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
>>   
>>   static void hardware_memory_error(void *host_addr)
>>   {
>> +    qapi_event_send_memory_failure(MEMORY_FAILURE_ACTION_HYPERVISOR_FATAL,
>> +                                   false, NULL);
>>       error_report("QEMU got Hardware memory error at addr %p", host_addr);
>>       exit(1);
>>   }
>> @@ -631,7 +634,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>           hardware_memory_error(addr);
>>       }
>>   
>> -    /* Hope we are lucky for AO MCE */
>> +    /* Hope we are lucky for AO MCE, just notify a event */
>> +    qapi_event_send_memory_failure(MEMORY_FAILURE_ACTION_HYPERVISOR_IGNORE,
>> +                                   false, NULL);
>>   }
>>   
>>   static void kvm_reset_exception(CPUX86State *env)
>>
> 

-- 
zhenwei pi

