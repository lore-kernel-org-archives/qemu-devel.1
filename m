Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9549AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 21:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6DB207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 21:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U14PPH+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6DB207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwB7Y-0004p5-MY
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 17:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwB6z-0004PD-IE
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 17:08:13 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:36100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwB6x-0002M1-N5
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 17:08:13 -0400
Received: by mail-pj1-x1041.google.com with SMTP id md7so5267481pjb.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 14:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7DEg+OZIWDAeTnpbYm8S7jNyD2rEII/fi6B1dlZnA5o=;
 b=U14PPH+1y+OUejBANDIqGR5941t3Gvab4Gr5sEXTMkTtaBgIn8wdIPM0U9lenF3MSz
 v5Sz83rbvfLDptstn3S/8y1Q6FozbftKzMZQ6mAHwS0kgs0EE6wGr2qz+1GknwN4jfhh
 9Hffnil++I1rXx8KQa1I4P0kR1Oa3pIEfV4/HJGJov3EyDJVDANXMQvfbkHOwLwXHDaq
 Mbw8S9Jz2IdtUVEV4RZWQuQdbf3MsFSrdsUrU886OCpukMS8+TKaZaUPacDXZ/DcQtkB
 ylcek6vCSb9tFTrVUbUSBSpZAszsgyuqf6Er1esAU/FWSrWSK2ClIjG2EWgY/YeNfYi7
 Rw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7DEg+OZIWDAeTnpbYm8S7jNyD2rEII/fi6B1dlZnA5o=;
 b=mXXx47o/74IXWBrP0pM/q00qVFMtPnED54A7Kf1cUAcC5ppAIOQVlim7iYjNOpiYL3
 Hs5aTcf72YxD3ynhYl5L6Qt6x2wnp6zdH89gl41S2qglPDrR/qmhUc/e9uON/ZALL+QJ
 CjyHY38N6KZ5CGpiuk0cbdxMFc6C3v/XSgzc8pJsBtpUkybgrGAZz8O15odyuvhhxLQB
 PUeLKwlPECoWD6XMYkK0AI+BE1TmrbzLOkZWFNTZAovI4CvbQou08Rcy06XztarmDg2j
 65+06N3pl7OI2HFunM+EfdcL2uKnwx9BClaDUZsHbCqW85F9onDCdD215dUKjKeargeG
 Tj/w==
X-Gm-Message-State: AOAM532wR8P/Gsv88BliHP4Kpm8AHWEge7i/KBzY/k7NcRixyKgQFJKT
 ebcXauA43Udxv/QBy2bgGqTwbQ==
X-Google-Smtp-Source: ABdhPJywKFSrTf0YjbefVQnbqbrlhDSRSwvrc3Ri2wS8JkzpQDCDaQRRb/rpG93sUR8oQPz9xndxyg==
X-Received: by 2002:a17:90a:7483:: with SMTP id
 p3mr6819242pjk.64.1594933690016; 
 Thu, 16 Jul 2020 14:08:10 -0700 (PDT)
Received: from [192.168.1.11] (174-21-148-13.tukw.qwest.net. [174.21.148.13])
 by smtp.gmail.com with ESMTPSA id
 w1sm5859532pfq.53.2020.07.16.14.08.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 14:08:09 -0700 (PDT)
Subject: Re: [RFC PATCH] tcg/cpu-exec: precise single-stepping after an
 exception
To: Peter Maydell <peter.maydell@linaro.org>,
 Luc Michel <luc.michel@greensocs.com>
References: <20200716100445.3748740-1-luc.michel@greensocs.com>
 <CAFEAcA_fGQoPXGg_t0jsXk7R+aSbWp9S+mpVJbAVZRr9FyUSpw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8e78c1c1-dd3f-fe07-5bd2-a0d8b0bc48ac@linaro.org>
Date: Thu, 16 Jul 2020 14:08:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_fGQoPXGg_t0jsXk7R+aSbWp9S+mpVJbAVZRr9FyUSpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/20 1:12 PM, Peter Maydell wrote:
> On Thu, 16 Jul 2020 at 11:08, Luc Michel <luc.michel@greensocs.com> wrote:
>>
>> When single-stepping with a debugger attached to QEMU, and when an
>> exception is raised, the debugger misses the first instruction after the
>> exception:
> 
> This is a long-standing bug; thanks for looking at it.
> (https://bugs.launchpad.net/qemu/+bug/757702)
> 
> 
>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>> index d95c4848a4..e85fab5d40 100644
>> --- a/accel/tcg/cpu-exec.c
>> +++ b/accel/tcg/cpu-exec.c
>> @@ -502,10 +502,21 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>>              CPUClass *cc = CPU_GET_CLASS(cpu);
>>              qemu_mutex_lock_iothread();
>>              cc->do_interrupt(cpu);
>>              qemu_mutex_unlock_iothread();
>>              cpu->exception_index = -1;
>> +
>> +            if (unlikely(cpu->singlestep_enabled)) {
>> +                /*
>> +                 * After processing the exception, ensure an EXCP_DEBUG is
>> +                 * raised when single-stepping so that GDB doesn't miss the
>> +                 * next instruction.
>> +                 */
>> +                cpu->exception_index = EXCP_DEBUG;
>> +                return cpu_handle_exception(cpu, ret);
>> +            }
> 
> I like the idea of being able to do this generically in
> the main loop.
> 
> How about interrupts? If we are single-stepping and we
> take an interrupt I guess we want to stop before the first
> insn of the interrupt handler rather than after it, which
> would imply a similar change to cpu_handle_interrupt().

Fair.  I think something like this:

            if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
                replay_interrupt();
-               cpu->exception_index = -1;
+               cpu->exception_index =
+                   (cpu->singlestep_enabled ? EXCP_DEBUG : -1);
                *last_tb = NULL;
            }

I'm not quite sure how to test this though...

Probably best to keep this a separate patch anyway.


r~

