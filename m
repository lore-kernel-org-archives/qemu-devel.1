Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61215C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330BF2087C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+xf214n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330BF2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1ZNs-0007Vv-HQ
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 14:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1ZMv-0006sT-59
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:02:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31973
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1ZMq-0003JT-Jm
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596218571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BRN/3Wt3ViPal7QMstF/fwN3sKlIzUZO0/oIBlWXA7A=;
 b=K+xf214nPdFoX5zMLHR38S7mjOVuoOFE8PV4BIafcgL/VUNm0CiVYKFDq6KRXs1adbPxey
 0dfj8+5KAlIkvMaXq8ANEAsrOb/yhOmKp5o3H2oNVVU7dNgeg+NOBy5VmBfJ3mUpWuVmpn
 Z++T0rnZYNoorwY5yT8rWoss40PVssI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-j1fzBf4DPFeJP3zQlDgP3w-1; Fri, 31 Jul 2020 14:02:50 -0400
X-MC-Unique: j1fzBf4DPFeJP3zQlDgP3w-1
Received: by mail-wr1-f72.google.com with SMTP id f14so9400742wrm.22
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 11:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BRN/3Wt3ViPal7QMstF/fwN3sKlIzUZO0/oIBlWXA7A=;
 b=hGrvZgTMbiFC84/EkwpLrUW1/ddP7zegKlrntBsQGkzYP9HkgA+BK5hkVt8xie0oz/
 fMsOTNVNT6P6nJ5YDKI9muvk9o/VlwEFsxjixHOb5dMsgGGXRwWYu7ObBaOgQc3w7QpT
 4FYwDv7fMlOQdFjM3ntBoFy31vO35RPVWileKKVNYTZEqIGlKB1RxZebSUQ8WPVNpTlA
 hgr27NOK665aF9JWLgNQ7vo67SvqZj5qfulquyLfVioIdbGALddXnN3joJeW2RsPSu5S
 7QWmjO1mN4hH7seLZFqYffLqGVwfCOY37jCdUCrosxByWQ1pUKAMEQaMkG85Ll9lGZKn
 AARQ==
X-Gm-Message-State: AOAM532stitZNUJSQqnFtzN1+C59aaOm1PHKYvDLsW7e3Q9jVLWZwMmf
 y2pONh8OMpRxV9b9mC9e7AQgfXbAGXYt4HNBeXP3yR65Y9LaVhqqycBK+Gt4oWWR4cDvSSPs5El
 AmTmtn66/U6FOnrI=
X-Received: by 2002:a1c:b188:: with SMTP id a130mr4567614wmf.125.1596218568845; 
 Fri, 31 Jul 2020 11:02:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxPjJ+Oyx3PbYhI97AXkkmbD5tZEr5U7l1nrUN68HYIGlsuoWoTNV1byXoWRuzvaoCCattVw==
X-Received: by 2002:a1c:b188:: with SMTP id a130mr4567598wmf.125.1596218568560; 
 Fri, 31 Jul 2020 11:02:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:90a5:f767:5f9f:3445?
 ([2001:b07:6468:f312:90a5:f767:5f9f:3445])
 by smtp.gmail.com with ESMTPSA id f17sm15860029wme.14.2020.07.31.11.02.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 11:02:48 -0700 (PDT)
Subject: Re: [PATCH 2/2] accel/tcg: interrupt/exception handling uses
 bql_interrupt flag
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200731125127.30866-1-robert.foley@linaro.org>
 <20200731125127.30866-3-robert.foley@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <67497c73-d2b9-941e-471d-de0ccd61bb7f@redhat.com>
Date: Fri, 31 Jul 2020 20:02:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200731125127.30866-3-robert.foley@linaro.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 12:28:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/07/20 14:51, Robert Foley wrote:
> This change removes the implied BQL from the cpu_handle_interrupt,
> and cpu_handle_exception paths. We can now select per-arch if
> the BQL is needed or not by using the bql_interrupt flag.
> By default, the core code holds the BQL.
> One benefit of this change is that it leaves it up to the arch
> to make the change to remove BQL when it makes sense.
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>

No, please just modify all implementation to do lock/unlock.  It's a
simpler patch than this on.

Paolo

> ---
>  accel/tcg/cpu-exec.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 80d0e649b2..cde27ee0bf 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -517,9 +517,13 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>  #else
>          if (replay_exception()) {
>              CPUClass *cc = CPU_GET_CLASS(cpu);
> -            qemu_mutex_lock_iothread();
> +            if (cc->bql_interrupt) {
> +                qemu_mutex_lock_iothread();
> +            }
>              cc->do_interrupt(cpu);
> -            qemu_mutex_unlock_iothread();
> +            if (cc->bql_interrupt) {
> +                qemu_mutex_unlock_iothread();
> +            }
>              cpu->exception_index = -1;
>  
>              if (unlikely(cpu->singlestep_enabled)) {
> @@ -558,7 +562,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>      if (unlikely(cpu_interrupt_request(cpu))) {
>          int interrupt_request;
>  
> -        qemu_mutex_lock_iothread();
> +        cpu_mutex_lock(cpu);
>          interrupt_request = cpu_interrupt_request(cpu);
>          if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
>              /* Mask out external interrupts for this step. */
> @@ -567,7 +571,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>          if (interrupt_request & CPU_INTERRUPT_DEBUG) {
>              cpu_reset_interrupt(cpu, CPU_INTERRUPT_DEBUG);
>              cpu->exception_index = EXCP_DEBUG;
> -            qemu_mutex_unlock_iothread();
> +            cpu_mutex_unlock(cpu);
>              return true;
>          }
>          if (replay_mode == REPLAY_MODE_PLAY && !replay_has_interrupt()) {
> @@ -577,13 +581,15 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>              cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);
>              cpu_halted_set(cpu, 1);
>              cpu->exception_index = EXCP_HLT;
> -            qemu_mutex_unlock_iothread();
> +            cpu_mutex_unlock(cpu);
>              return true;
>          }
>  #if defined(TARGET_I386)
>          else if (interrupt_request & CPU_INTERRUPT_INIT) {
>              X86CPU *x86_cpu = X86_CPU(cpu);
>              CPUArchState *env = &x86_cpu->env;
> +            cpu_mutex_unlock(cpu);
> +            qemu_mutex_lock_iothread();
>              replay_interrupt();
>              cpu_svm_check_intercept_param(env, SVM_EXIT_INIT, 0, 0);
>              do_cpu_init(x86_cpu);
> @@ -595,7 +601,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>          else if (interrupt_request & CPU_INTERRUPT_RESET) {
>              replay_interrupt();
>              cpu_reset(cpu);
> -            qemu_mutex_unlock_iothread();
> +            cpu_mutex_unlock(cpu);
>              return true;
>          }
>  #endif
> @@ -604,7 +610,15 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>             True when it is, and we should restart on a new TB,
>             and via longjmp via cpu_loop_exit.  */
>          else {
> +            cpu_mutex_unlock(cpu);
> +            if (cc->bql_interrupt) {
> +                qemu_mutex_lock_iothread();
> +            }
>              if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
> +                if (cc->bql_interrupt) {
> +                    qemu_mutex_unlock_iothread();
> +                }
> +                cpu_mutex_lock(cpu);
>                  replay_interrupt();
>                  /*
>                   * After processing the interrupt, ensure an EXCP_DEBUG is
> @@ -614,6 +628,11 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>                  cpu->exception_index =
>                      (cpu->singlestep_enabled ? EXCP_DEBUG : -1);
>                  *last_tb = NULL;
> +            } else {
> +                if (cc->bql_interrupt) {
> +                    qemu_mutex_unlock_iothread();
> +                }
> +                cpu_mutex_lock(cpu);
>              }
>              /* The target hook may have updated the 'cpu->interrupt_request';
>               * reload the 'interrupt_request' value */
> @@ -627,7 +646,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>          }
>  
>          /* If we exit via cpu_loop_exit/longjmp it is reset in cpu_exec */
> -        qemu_mutex_unlock_iothread();
> +        cpu_mutex_unlock(cpu);
>      }
>  
>      /* Finally, check if we need to exit to the main loop.  */
> @@ -691,7 +710,6 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
>      }
>  #endif
>  }
> -
>  /* main execution loop */
>  
>  int cpu_exec(CPUState *cpu)
> 


