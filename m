Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F8AC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2322083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x9nepgtx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2322083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrZN-0005Hy-0y
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCrUk-0006ey-Po
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:37:42 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCrUh-0003h9-Sp
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:37:42 -0400
Received: by mail-pg1-x542.google.com with SMTP id 67so1437372pgd.12
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aF1TYW9+DmXTOxP0rCa7SthEkQoCWC6+zXjV5LlvHMQ=;
 b=x9nepgtxkHBfFxTs3l5K+WI7B4/dG6sa5gTKjEPEGKA1i5vT6JzRQJaSdCrvAj2qcj
 l4AgJLy+SFSEe6+fHkBRVCvjtfGQ74mPaSBEjO6Ch6+EmgbmHf6htxPuY2j6nJalxYn5
 HTw1NQ6UG+mo4m0s7Z3oUNl6YTjT2/nS3VdjRu1iYp0Aiqmq6J+YstIkF0HbaZTkoIst
 WJiO3EuBHTYr4TFqufi+VQ1i6tKkPobaZKkzV+v+JsjyoV45ByZGhAKD8j0kOrW+rHZN
 TJz99ZJ9Bb/z1O8MMzb+2SrIRiUduIdIQIvB1EcEhMN0vEFe0ZLFyxYMi+GjW10eBvjV
 4F9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aF1TYW9+DmXTOxP0rCa7SthEkQoCWC6+zXjV5LlvHMQ=;
 b=ljjkBHZ7EwwRYSNZxSJhzCjn16spX6sNcnr/xkeAaRVAMRZYq4Dk89GqxYtrKL16Pn
 1b5hOcwmWUW/IEKAspu8Ay0QFQFF8CWn4lU100QsM4LKTLwMrYEHbj3jVh+i1GRqWDp0
 nyvQGVfB4gN9gDEoEE54Jnem5Gzr6Cf8YdquWpylbmPsxaaF6UjZyb4166LdqxurkKAr
 4nwfzjadSDLDXkmqf78plcsnutZFOxwBnROA/fZjU9OJ9yyqSMxa8s1aHuBVrTvpUgUB
 LCIlLA/8fTWPTpmCS1Szg9LpX+2/H4xBytFZTkutmmtX6cTseRzFqsiWLbcO7RPOxbDU
 6dpg==
X-Gm-Message-State: AOAM5310g5f+0oG1oU8r/TnJAP+HVTEywaVdYOi5ADLlJM/fgzBMVFVN
 XYAmXghPlsj2nycDUsSJk4QyZA==
X-Google-Smtp-Source: ABdhPJzY9pX9FAI2tHfXc+NCEv0qzRv6gNhJkv6mav6Bw3GJSowl8ysxOYGftSt9JXFwE7ENfBsMbg==
X-Received: by 2002:aa7:9556:: with SMTP id w22mr2885120pfq.245.1598909858396; 
 Mon, 31 Aug 2020 14:37:38 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c1sm7936988pfi.136.2020.08.31.14.37.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 14:37:37 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] target: Push BQL on ->do_interrupt down into
 per-arch implementation
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200819182856.4893-1-robert.foley@linaro.org>
 <20200819182856.4893-5-robert.foley@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <047fe2b3-c51b-1840-8b93-f747684abea0@linaro.org>
Date: Mon, 31 Aug 2020 14:37:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819182856.4893-5-robert.foley@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Michael Rolnik <mrolnik@gmail.com>, peter.puhov@linaro.org,
 Stafford Horne <shorne@gmail.com>, alex.bennee@linaro.org,
 Richard Henderson <rth@twiddle.net>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>, pbonzini@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/20 11:28 AM, Robert Foley wrote:
> avr is another exception.  avr, arm and cris all had a similar
> case where their *_cpu_exec_interrupt was calling to
> the CPUClass ->do_interrupt.  This causes an issue when we push
> the lock down since ->do_interrupt will try to acquire the BQL, but
> the calling context already has it.

Alpha is in this lest as well, correct?

> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index 4c6753df34..be29bdd530 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -276,7 +276,7 @@ struct AlphaCPU {
>  extern const VMStateDescription vmstate_alpha_cpu;
>  #endif
>  
> -void alpha_cpu_do_interrupt_locked(CPUState *cpu);
> +void alpha_cpu_do_interrupt(CPUState *cpu);
>  bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
>  hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index ff9a2a7765..e497dd269e 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -295,7 +295,7 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
>  }
>  #endif /* USER_ONLY */
>  
> -void alpha_cpu_do_interrupt_locked(CPUState *cs)
> +static void alpha_cpu_do_interrupt_locked(CPUState *cs)
>  {
>      AlphaCPU *cpu = ALPHA_CPU(cs);
>      CPUAlphaState *env = &cpu->env;
> @@ -407,6 +407,13 @@ void alpha_cpu_do_interrupt_locked(CPUState *cs)
>  #endif /* !USER_ONLY */
>  }
>  
> +void alpha_cpu_do_interrupt(CPUState *cs)
> +{
> +    qemu_mutex_lock_iothread();
> +    alpha_cpu_do_interrupt_locked(cs);
> +    qemu_mutex_unlock_iothread();
> +}
> +
>  bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  {
>      AlphaCPU *cpu = ALPHA_CPU(cs);

This rename should have been done in patch 1, as with all others.
Moreover, this leaves a bug in alpha_cpu_exec_interrupt in that it should be
calling alpha_cpu_do_interrupt_locked.

That seems to be the only instance of this mistake.


r~

