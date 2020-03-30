Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33E7C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:46:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED8C206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQdmsOIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED8C206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jItod-0005uU-Jx
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 08:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jItky-0004av-5u
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jItkw-00022y-Gc
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:43:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44535)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jItkw-000227-Cf
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585572185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pcrFptVGfoSj3ap6kbIVgPnC4c8cKboLtH4qynP+4fE=;
 b=jQdmsOIOdajOWJTAKxwasThbgiXGJqI4oS53RQgEBYeN45RXztk32bI+Ejpfr/aoQkigcY
 xAIp+P+r6yYRHYcxFG4CgPHDVRTGN6nlRExEBkJVlWcVVTukuHi8LeYtv1UDy0ETA8iflG
 sEVyUpQLjMe09+NmNjjks816gI293G0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-DQasrH9dNHmP5iFPgnAykg-1; Mon, 30 Mar 2020 08:43:03 -0400
X-MC-Unique: DQasrH9dNHmP5iFPgnAykg-1
Received: by mail-wr1-f71.google.com with SMTP id r15so3392586wrm.22
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 05:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pcrFptVGfoSj3ap6kbIVgPnC4c8cKboLtH4qynP+4fE=;
 b=OZigKSOw8ARqmVihWZBBtgCBIlOdcr0DFa3PH9EIzh9RWQpb2xtRIU6OSt1ErSX1FZ
 ABZkwdSVho0WDJFwG9EmwAILjGLQkVoPKycK8zs9Spezmh/zS5evzgip0aQam/fXJDlA
 xQm/Lr35u7ucz8fUjWhbYURYPzzK04XEL0kL5ol1xiwEg4tqee+kqnyM+f1YwGrE2zps
 xYhs11ERQjnViWS1NrPZolXm3v6x3BcnMOG1GfqF3G9TWwIbPW41QSTauHkUJVEg/YsI
 1Y0ktBiJTMPB51U8iuITz6pTh/X8NT2WIany+x7TvPARV1i1YyrjwdPvPtD8i1hjyQ7h
 1iKA==
X-Gm-Message-State: ANhLgQ3TO80D12+d4P5rgxvwFDJXYRXQWHQrunTqYe8+RQ4HF5etty7J
 jPqlScgHDQwa/g2lBZAIDfU5mzQ7NbqVMnP39HPijM0nOxnXuo6u1hfhg8m92FTxnEQarKthae2
 0g9/6QnFmAY+UtC0=
X-Received: by 2002:a5d:4cc4:: with SMTP id c4mr14532668wrt.346.1585572182661; 
 Mon, 30 Mar 2020 05:43:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvyhOC4V2M/6JX/si7fj+5gw8IZRUOjbQcqZz+w6Im/n3OQVVkYd6/5CM6j59DSp6n8ao7Brw==
X-Received: by 2002:a5d:4cc4:: with SMTP id c4mr14532647wrt.346.1585572182338; 
 Mon, 30 Mar 2020 05:43:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b55d:5ed2:8a41:41ea?
 ([2001:b07:6468:f312:b55d:5ed2:8a41:41ea])
 by smtp.gmail.com with ESMTPSA id n11sm18201469wrg.72.2020.03.30.05.43.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2020 05:43:01 -0700 (PDT)
Subject: Re: [PATCH] i386: hvf: Reset IRQ inhibition after moving RIP
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200328174411.51491-1-r.bolshakov@yadro.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f013fab5-7a78-5c1c-6070-c23fd2f7ea53@redhat.com>
Date: Mon, 30 Mar 2020 14:43:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200328174411.51491-1-r.bolshakov@yadro.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/03/20 18:44, Roman Bolshakov wrote:
> The sequence of instructions exposes an issue:
>   sti
>   hlt
> 
> Interrupts cannot be delivered to hvf after hlt instruction cpu because
> HF_INHIBIT_IRQ_MASK is set just before hlt is handled and never reset
> after moving instruction pointer beyond hlt.
> 
> So, after hvf_vcpu_exec() returns, CPU thread gets locked up forever in
> qemu_wait_io_event() (cpu_thread_is_idle() evaluates inhibition
> flag and considers the CPU idle if the flag is set).
> 
> Cc: Cameron Esfahani <dirty@apple.com>
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  target/i386/hvf/vmx.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
> index 03d2c79b9c..ce2a1532d5 100644
> --- a/target/i386/hvf/vmx.h
> +++ b/target/i386/hvf/vmx.h
> @@ -167,6 +167,8 @@ static inline void macvm_set_cr4(hv_vcpuid_t vcpu, uint64_t cr4)
>  
>  static inline void macvm_set_rip(CPUState *cpu, uint64_t rip)
>  {
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
>      uint64_t val;
>  
>      /* BUG, should take considering overlap.. */
> @@ -176,6 +178,7 @@ static inline void macvm_set_rip(CPUState *cpu, uint64_t rip)
>     val = rvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY);
>     if (val & (VMCS_INTERRUPTIBILITY_STI_BLOCKING |
>                 VMCS_INTERRUPTIBILITY_MOVSS_BLOCKING)) {
> +        env->hflags &= ~HF_INHIBIT_IRQ_MASK;
>          wvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY,
>                 val & ~(VMCS_INTERRUPTIBILITY_STI_BLOCKING |
>                 VMCS_INTERRUPTIBILITY_MOVSS_BLOCKING));
> 

Queued, thanks!

Paolo


