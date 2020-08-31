Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2067C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 22:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65E82065F
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 22:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+rOkWxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65E82065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrtT-0004XT-SG
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 18:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCrsm-0003yo-IR
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 18:02:32 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:47071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCrsj-0006T7-Hn
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 18:02:32 -0400
Received: by mail-pg1-x544.google.com with SMTP id 31so1472954pgy.13
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 15:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=X0cFCtxK4xl55T5MuZgphvDqnW4fkCQ//cpbpdaWuII=;
 b=Q+rOkWxjgJi2ChGk3eRGNT7q1L2VezWMZouczsGSnq/pGfBV7SH5gcXWq9CO8IsN4/
 DboCRiPyTikwG1bGDNRI/XKFN+dPdTNE5TPcDEgfcAArzWtJJkhcQSFUIfzUZvFfgdWT
 0krwWTVKkhsF4IcNcAJI883hZUiN6asUoLxHE7SwUghI918R+8Wdrvk5sAE59Fw/2lrz
 TW1S+OeG3fWwyMfeshrf18PanPDDw+FwU5lx3gXeTZfZazn/3+f17hqerOQdrDYuf2Eh
 pGtc7lxDHLALV5Ai4T0vrwWU4wPo0WZ/wCCT+GZX7XZNCUBQYgOiwaw3k3tBocHGrZCT
 9kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X0cFCtxK4xl55T5MuZgphvDqnW4fkCQ//cpbpdaWuII=;
 b=dxCA+mVnyPLIzVwZcMBLoDdos8YRe+Z1UoK4cqgSvkeDtgq576Ch2RZXUUDmfeJPP7
 YXCl8j2ilfq4u/pH86yA1DB7zDS++Us6zGayv/jmrE98ymrk+V1hq10wqGimgJZlrtYG
 bCKWUNevtEKmAJhUp4KdVVAdXl8eDZQ1NgHuCUFrqSFY93g4q1/QWq973GWH2LLm1dgb
 e/CBxfKpC8J8eTuWWwDz+TJXd6B7cpeKFLR7Fkm6Vm+hGBQaH8lOm8cnKsHTsThaQxjT
 jLYLK9MdWMzhgUjYWQclfIs5BUgPzcb8uy9OxgAiVRID/yiAAQFLhJ9fx5+oaFxb3yxY
 6xjw==
X-Gm-Message-State: AOAM530VOyYbE8X2jm29hOTxNY/qGiXDExshll/szPhFDPqRqXIMHzwl
 OaR7FB3l3QIuVNq3CBlDH3Qp9g==
X-Google-Smtp-Source: ABdhPJzu3nRvymJP3v2mQhcPt4yPiSsA88UUSsh0vzQCCZFZfpeeIkARyNeuHPoSJi+Ery/QJ9Jeig==
X-Received: by 2002:a62:760e:: with SMTP id r14mr2857257pfc.309.1598911347876; 
 Mon, 31 Aug 2020 15:02:27 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w66sm9581237pfb.126.2020.08.31.15.02.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 15:02:27 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] target/arm: add ARMCPUClass->do_interrupt_locked
From: Richard Henderson <richard.henderson@linaro.org>
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200819182856.4893-1-robert.foley@linaro.org>
 <20200819182856.4893-3-robert.foley@linaro.org>
 <439e8b14-adc1-b7ea-edaa-d11069863007@linaro.org>
Message-ID: <e324f958-8c9e-ebe1-e624-7eec610fe5aa@linaro.org>
Date: Mon, 31 Aug 2020 15:02:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <439e8b14-adc1-b7ea-edaa-d11069863007@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alex.bennee@linaro.org,
 pbonzini@redhat.com, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/31/20 2:18 PM, Richard Henderson wrote:
> On 8/19/20 11:28 AM, Robert Foley wrote:
>> Adding ->do_interrupt_locked to ARMCPUClass is preparation for
>> pushing the BQL down into the per-arch implementation of ->do_interrupt.
>>
>> This is needed since ARM's *_cpu_exec_interrupt calls to *_do_interrupt.
>> With the push down of the BQL into *_cpu_exec_interrupt and
>> *_do_interrupt, *_cpu_exec_interrupt will call to ->do_interrupt
>> with lock held.  Since ->do_interrupt also has the lock, we need a way
>> to allow cpu_exec_interrupt to call do_interrupt with lock held.
>> This patch solves this issue of *_cpu_exec_interrupt needing
>> to call do_interrupt with lock held.
>>
>> This patch is part of a series of transitions to move the
>> BQL down into the do_interrupt per arch functions.  This set of
>> transitions is needed to maintain bisectability.
>>
>> This approach was suggested by Paolo Bonzini.
>> For reference, here are two key posts in the discussion, explaining
>> the reasoning/benefits of this approach.
>> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00784.html
>> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg01517.html
>> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html
>> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html
>>
>> Signed-off-by: Robert Foley <robert.foley@linaro.org>
>> ---
>>  target/arm/cpu-qom.h | 3 +++
>>  target/arm/cpu.c     | 5 +++--
>>  target/arm/cpu_tcg.c | 5 +++--
>>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I take it back.  These two cc->do_interrupt calls can be replaced with direct
calls.

> #ifndef CONFIG_USER_ONLY
>     cc->do_interrupt = arm_v7m_cpu_do_interrupt;
> #endif
> 
>     cc->cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt;

If we are in arm_v7m_cpu_exec_interrupt we will always call
arm_v7m_cpu_do_interrupt.

I think the mismatch of #ifdef, which implies a different destination is
possible, is a bug -- cc->do_interrupt is not otherwise assigned and in fact
would be NULL.

I suspect that some of these slots themselves should be ifdefed, so that we
cannot assign to them when they are unused.  That would help keep the ifdefs in
the cpu init functions in sync.

This same condition is *not* true for cris -- there is no
crisv10_cpu_exec_interrupt -- so you do need the new do_interrupt_locked field
there.


r~

