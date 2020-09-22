Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA64C4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2492396D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTI0mBiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2492396D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfbt-0005xQ-LI
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKfZa-0003Vl-PF
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKfZW-0006N6-Ux
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600770654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aeC1d0suPO6COpBh6ctF9xV8ka5nwhD/y7ZxKS/7wXg=;
 b=NTI0mBiyJZcAlgwt7XkjiqjwPX0sIjoCW+LLTaKNZAZ09T4cp59ye8zZCVibvOgbv2vjIf
 V5GefugqQUwF69sKTN1v6dMSAXWg/YliWyn3McFNNYuh9Z1u03wfuVcf1/Wcv8nszfw+rK
 z0r5a+R3a1lKa0zmLYJXJo8wf8U2EDg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-d1iCwh8TO62Yor9TivcElA-1; Tue, 22 Sep 2020 06:30:52 -0400
X-MC-Unique: d1iCwh8TO62Yor9TivcElA-1
Received: by mail-wr1-f71.google.com with SMTP id b7so7223183wrn.6
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 03:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=aeC1d0suPO6COpBh6ctF9xV8ka5nwhD/y7ZxKS/7wXg=;
 b=OwJG7Dh1dvNWJ9h8KEMHhIUIpo3/v7rPRT/iCHlZ+bkR2VDVCMp+N3zJqV8ccJzkFl
 YiWNKED693B0xq9/YS7Evn3w3R3GIOOuYmfRktFC7YHLgb2uVNSZ108bJlZ5seYmtMFC
 5DBzDUfC7+BtICkXctD5U9qFEWVOKVTbebdUAsBLCKC8itI0Om+qN0d00yWVzrBt6WuN
 wavnwVnh/9QN7r0u/UaiMUc81fLtFT6CaUI66tMSSEEcPUKR+yuuqbWcXXneaUXfKqu9
 qTu3+oSbBvtPHCgUJ3AB0azqwFjE7E8tRNMbXCMebSz9PIzAyH/pwd5SrGMYQoeNPJKr
 CoJw==
X-Gm-Message-State: AOAM530U+2iMX0j88DArMNawnwPrJDiAF2qaBZK4wLMTRCOcEU+iHSLD
 SYPr9KfG1Pjf+DHig4acFk6CBovqx6ERWsIrZp6JnaxruDOJTEw3Tf2lc8vW0XjLpVN08jW6HUO
 fxuucPb5R0Kflayk=
X-Received: by 2002:a1c:dd45:: with SMTP id u66mr237368wmg.117.1600770651125; 
 Tue, 22 Sep 2020 03:30:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmUdD/U75JiNzMebzTelwLDoagOVmr1S+QaeIFV3W2xai8vY3M+jOJ1dLEobqEit5LrKLxng==
X-Received: by 2002:a1c:dd45:: with SMTP id u66mr237349wmg.117.1600770650878; 
 Tue, 22 Sep 2020 03:30:50 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 11sm3972254wmi.14.2020.09.22.03.30.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 03:30:49 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] target-i386: post memory failure event to uplayer
To: zhenwei pi <pizhenwei@bytedance.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org
References: <20200922095630.394893-1-pizhenwei@bytedance.com>
 <20200922095630.394893-4-pizhenwei@bytedance.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <776b6afe-022e-f304-4bc9-f1f486d75af2@redhat.com>
Date: Tue, 22 Sep 2020 12:30:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922095630.394893-4-pizhenwei@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: mtosatti@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 11:56 AM, zhenwei pi wrote:
> Post memory failure event to uplayer to handle hardware memory
> corrupted event. Rather than simple QEMU log, QEMU could report more
> effective message to uplayer. For example, guest crashes by MCE,
> selecting another host server is a better choice.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  target/i386/helper.c | 15 +++++++++++++++
>  target/i386/kvm.c    |  7 ++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index 0c7fd32491..47823c29e4 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -18,6 +18,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qapi/qapi-events-run-state.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "qemu/qemu-print.h"
> @@ -858,6 +859,7 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
>      CPUX86State *cenv = &cpu->env;
>      uint64_t *banks = cenv->mce_banks + 4 * params->bank;
>      char msg[64];
> +    MemoryFailureFlags mf_flags = {0};
>      bool need_reset = false;
>  
>      cpu_synchronize_state(cs);
> @@ -869,6 +871,12 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
>      if (!(params->flags & MCE_INJECT_UNCOND_AO)
>          && !(params->status & MCI_STATUS_AR)
>          && (cenv->mcg_status & MCG_STATUS_MCIP)) {
> +        mf_flags.has_action_required = true;
> +        mf_flags.action_required = false;
> +        mf_flags.has_recursive = true;
> +        mf_flags.recursive = true;
> +        qapi_event_send_memory_failure(MEMORY_FAILURE_ACTION_GUEST_MCE_INJECT,
> +                                       true, &mf_flags);

Can you extract a function such:

static void emit_guest_mce_failure(bool action_required, bool recursive)
{
  ...
}

To use as:

           emit_guest_mce_failure(true, true);

>          return;
>      }
>  
> @@ -909,6 +917,8 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
>          }
>  
>          if (need_reset) {
> +            qapi_event_send_memory_failure(
> +                 MEMORY_FAILURE_ACTION_GUEST_MCE_FATAL, false, NULL);
>              monitor_printf(params->mon, "%s", msg);
>              qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
>              qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> @@ -934,6 +944,11 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
>      } else {
>          banks[1] |= MCI_STATUS_OVER;
>      }
> +
> +    mf_flags.has_action_required = true;
> +    mf_flags.action_required = !!(params->status & MCI_STATUS_AR);
> +    qapi_event_send_memory_failure(MEMORY_FAILURE_ACTION_GUEST_MCE_INJECT,
> +                                   true, &mf_flags);

And here:

       emit_guest_mce_failure(params->status & MCI_STATUS_AR, false);

>  }
>  
>  void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 9efb07e7c8..989889c291 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -14,6 +14,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-events-run-state.h"
>  #include <sys/ioctl.h>
>  #include <sys/utsname.h>
>  
> @@ -577,6 +578,8 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
>  
>  static void hardware_memory_error(void *host_addr)
>  {
> +    qapi_event_send_memory_failure(MEMORY_FAILURE_ACTION_HYPERVISOR_FATAL,
> +                                   false, NULL);
>      error_report("QEMU got Hardware memory error at addr %p", host_addr);
>      exit(1);
>  }
> @@ -631,7 +634,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>          hardware_memory_error(addr);
>      }
>  
> -    /* Hope we are lucky for AO MCE */
> +    /* Hope we are lucky for AO MCE, just notify a event */
> +    qapi_event_send_memory_failure(MEMORY_FAILURE_ACTION_HYPERVISOR_IGNORE,
> +                                   false, NULL);
>  }
>  
>  static void kvm_reset_exception(CPUX86State *env)
> 


