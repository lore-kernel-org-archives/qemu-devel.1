Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B54C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C09F20760
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pi5XQzIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C09F20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqvgU-0001rx-Cn
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 05:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqvfs-0001Bi-AZ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:38:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45020
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqvfq-0002xl-Ho
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593682709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K+kep/6PTdEq7a0AnNqp2iJmiToKRXvyzwxbbiCaJ3w=;
 b=Pi5XQzILutZHRmpGDvAWy58GM/rniUKizIzwty4aLeQ+uCzYKppLVzOcaEI4CBOAdQQ+sO
 AgAtblGnUGOnUIWAsUnvbO6fNAdr7chv+KjJOZpftxpQWbhdkDku5OIXPHz9ajjPjl1o91
 22cJ6wSGL6NNpBJX9u0qeptM2aPZ0WU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-BBJcF08DNBmm39LP3_ak9Q-1; Thu, 02 Jul 2020 05:38:27 -0400
X-MC-Unique: BBJcF08DNBmm39LP3_ak9Q-1
Received: by mail-wm1-f72.google.com with SMTP id g6so21823583wmk.4
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 02:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K+kep/6PTdEq7a0AnNqp2iJmiToKRXvyzwxbbiCaJ3w=;
 b=MOHz+2m8Ct0cLfmL1U1sFbkVJNTjb2oi1rz76q3K+cOH5wwIKETD2+CB4j6ps6QGYI
 ehOVNBg4LfGbjhtQDKDus8bh50lQuzuOItus5QDsGlN+ZRxYdLFapveZHC7S0eWyB/cH
 oMMdm1QC4Ni/irJu61hqj3sfoCM2dDTFC4FIha4QjNEYPOehEEIF6S3Gk4PdPXgct4rt
 h6hxkU/4r9LWy68CHK5uLz4I/NOtjWYZCN2gM9VriustU+q5Lzlsz7lNJKxq1iuV7ogn
 IIHRSsTivDlsSbwYhOyrUCgTAt9yQIZMydDV98z5wmPgY1T1sL+Uqm83n8FNS1UPV04b
 1IUA==
X-Gm-Message-State: AOAM533huD7sgWe7Zt3e7vu7NC57H7Gcma+CgnC3dV9uWVGUKkunTCTk
 VyBLfimQ8cuNWMYFsGpQ7L2OQvrMjOJbMej+jQx2CXXE/wUlnR0rkHNvuRkl/sJzTHSI63F7WNQ
 KjHTd2lqpfQkQMSw=
X-Received: by 2002:a1c:7d54:: with SMTP id y81mr31803634wmc.110.1593682705960; 
 Thu, 02 Jul 2020 02:38:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrgYZt3ACOTUmbfuSzqhYTvaj1ZA2EAGpGfhMsXFInr5rQYPi5mgDb2BmRS2Phkrai8n1BYQ==
X-Received: by 2002:a1c:7d54:: with SMTP id y81mr31803617wmc.110.1593682705741; 
 Thu, 02 Jul 2020 02:38:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2cad:376b:7d21:868e?
 ([2001:b07:6468:f312:2cad:376b:7d21:868e])
 by smtp.gmail.com with ESMTPSA id e8sm10427072wrp.26.2020.07.02.02.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 02:38:25 -0700 (PDT)
Subject: Re: [PATCH] cpus: Move CPU code from exec.c to cpus.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200701175432.18892-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b476ded8-fbd6-f9d5-66b7-67e7128e86fd@redhat.com>
Date: Thu, 2 Jul 2020 11:38:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200701175432.18892-1-philmd@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/07/20 19:54, Philippe Mathieu-Daudé wrote:
> This code was introduced with SMP support in commit 6a00d60127,
> later commit 296af7c952 moved CPU parts to cpus.c but forgot this
> code. Move now and simplify ifdef'ry.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  cpus.c | 18 ++++++++++++++++++
>  exec.c | 22 ----------------------
>  2 files changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index 41d1c5099f..472686cbbc 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -92,6 +92,11 @@ static unsigned int throttle_percentage;
>  #define CPU_THROTTLE_PCT_MAX 99
>  #define CPU_THROTTLE_TIMESLICE_NS 10000000
>  
> +CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
> +
> +/* current CPU in the current thread. It is only valid inside cpu_exec() */
> +__thread CPUState *current_cpu;
> +
>  bool cpu_is_stopped(CPUState *cpu)
>  {
>      return cpu->stopped || !runstate_is_running();
> @@ -134,6 +139,19 @@ static bool all_cpu_threads_idle(void)
>      return true;
>  }
>  
> +CPUState *qemu_get_cpu(int index)
> +{
> +    CPUState *cpu;
> +
> +    CPU_FOREACH(cpu) {
> +        if (cpu->cpu_index == index) {
> +            return cpu;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
>  /***********************************************************/
>  /* guest cycle counter */
>  
> diff --git a/exec.c b/exec.c
> index 21926dc9c7..997b7db15f 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -98,12 +98,6 @@ AddressSpace address_space_memory;
>  static MemoryRegion io_mem_unassigned;
>  #endif
>  
> -CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
> -
> -/* current CPU in the current thread. It is only valid inside
> -   cpu_exec() */
> -__thread CPUState *current_cpu;
> -
>  uintptr_t qemu_host_page_size;
>  intptr_t qemu_host_page_mask;
>  
> @@ -832,22 +826,6 @@ const VMStateDescription vmstate_cpu_common = {
>      }
>  };
>  
> -#endif
> -
> -CPUState *qemu_get_cpu(int index)
> -{
> -    CPUState *cpu;
> -
> -    CPU_FOREACH(cpu) {
> -        if (cpu->cpu_index == index) {
> -            return cpu;
> -        }
> -    }
> -
> -    return NULL;
> -}
> -
> -#if !defined(CONFIG_USER_ONLY)
>  void cpu_address_space_init(CPUState *cpu, int asidx,
>                              const char *prefix, MemoryRegion *mr)
>  {
> 

Queued, thanks.

Paolo


