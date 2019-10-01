Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF91C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 22:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1AE921D7B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 22:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v680Ng3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AE921D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFQEw-0003Hh-8W
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 18:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFQAp-00013F-17
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 17:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFQAn-00038l-E2
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 17:59:10 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34178)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFQAn-00036u-51
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 17:59:09 -0400
Received: by mail-pl1-x644.google.com with SMTP id k7so6206878pll.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=J5/eJeIokN5k1bQXlKiaJYS2EVVZAhsHGc6k0mM1JIU=;
 b=v680Ng3e3iSu6dkuFeLLAiLG+923AFYCMFSHBU6Bztmey4AdCIsmC2A53DUKjBsNCp
 i/GBVpDHqmMNCPLb5fDxUxv9Zwmk6zpHTsMtTYXAqQiZGArnnMRWU8UTqJRBe3unmEoE
 QT4sWJwqgloVjA3AhOfo9/FhoM5qwmML23iMcOJEmiI3L8Mb7845WCtUqkrooHPsr0yd
 uHTgwjeCMnQpMehO7hezBy+tft7Sj8cNdfMjBOyy5JuFW5k4CauJUndaBskDWEM8hy4T
 TwF+bw4VTTUXBP4OLjZ6qB/w+wWVM3JTvaDmTtWTRyWqLuaDIXbMaADFydW84Wwnj+9i
 CxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J5/eJeIokN5k1bQXlKiaJYS2EVVZAhsHGc6k0mM1JIU=;
 b=jrFrs6utVf2RbvUYiWYMo308unHEbNDQPX3ebIFTffHDJ9hHLRLYMOkkpDH4jCrSD7
 ul6X8h8C/tK5v/HyG+IF7wclIdm1ce1hhokrDTY7ordcVFOtQRaDl+pEfOibr+j0CXHR
 r86ZBZqw3asDw+QHqir0taR93QzAKzJMQAs5fXbOCTjsO5lawRzJjrGsCgQN19VXKKRf
 vy3u7fcubDc9Ke4j/ol1aHDXciv42milwOAg71qFgyqSZ7OhM9FMa6cidGMGeleQ2OsD
 SJ3BGFY29kJsTTvqF44FCS4G7b0RqWzg7TSR03ME0eYNFNCfIkL68v581mQdTxpflTqQ
 3yDA==
X-Gm-Message-State: APjAAAWQ5CLvRJ9iVAUjS133IFh4bfGah9FyquEYZfoco2o1/DWPCn74
 lyk3OQsXXy6ZYvlePMGvM2Sx7A==
X-Google-Smtp-Source: APXvYqyg+HuJvzMWcLvv1edtUBokZ4dTs1GpfKvCxzH0gY2gXqYiFDJTzhis/AVJwFF6657/xQitEA==
X-Received: by 2002:a17:902:820e:: with SMTP id
 x14mr28165393pln.223.1569967147226; 
 Tue, 01 Oct 2019 14:59:07 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b185sm26682334pfg.14.2019.10.01.14.59.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 14:59:06 -0700 (PDT)
Subject: Re: [PATCH v1] s390x/tcg: MVCL: Exit to main loop if there are
 pending interrupts
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20191001181655.25948-1-david@redhat.com>
 <720221d3-84a6-9940-812e-b427acfc99ed@linaro.org>
 <42c78e3f-be24-a919-b1b9-0b52381a9214@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d4af4bce-b7e9-2418-6706-fb9b7010dc8e@linaro.org>
Date: Tue, 1 Oct 2019 14:59:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <42c78e3f-be24-a919-b1b9-0b52381a9214@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 12:47 PM, David Hildenbrand wrote:
> On 01.10.19 21:17, Richard Henderson wrote:
>> On 10/1/19 11:16 AM, David Hildenbrand wrote:
>>> +static inline bool should_interrupt_instruction(CPUState *cs)
>>> +{
>>> +    /*
>>> +     * Something asked us to stop executing chained TBs, e.g.,
>>> +     * cpu_interrupt() or cpu_exit().
>>> +     */
>>> +    if ((int32_t)atomic_read(&cpu_neg(cs)->icount_decr.u32) < 0) {
>>> +        return true;
>>> +    }
>>> +
>>> +    /* We have a deliverable interrupt pending. */
>>> +    if ((atomic_read(&cs->interrupt_request) & CPU_INTERRUPT_HARD) &&
>>> +        s390_cpu_has_int(S390_CPU(cs))) {
>>> +        return true;
>>> +    }
>>> +    return false;
>>> +}
>>
>> The first condition should be true whenever the second condition is true.
> 
> @@ -1018,6 +1018,7 @@ static inline bool should_interrupt_instruction(CPUState *cs)
>      /* We have a deliverable interrupt pending. */
>      if ((atomic_read(&cs->interrupt_request) & CPU_INTERRUPT_HARD) &&
>          s390_cpu_has_int(S390_CPU(cs))) {
> +        g_assert((int32_t)atomic_read(&cpu_neg(cs)->icount_decr.u32) < 0);
>          return true;
>      }
>      return false;
> 
> 
> ...
> 
> 
> [   60.109761] systemd[1]: Set hostname to <rhel8>.
> **
> ERROR:/home/dhildenb/git/qemu/target/s390x/mem_helper.c:1021:should_interrupt_instruction: assertion failed: ((int32_t)atomic_read(&cpu_neg(cs)->icount_decr.u32) < 0)
> 
> 
> A race? Roughly 20-30% pass the first but not the second check. And
> in total, on a Fedora 30 boot, I can maybe see 30 calls of
> should_interrupt_instruction() succeeding.
> 
> I thought these could be pending interrupts that were not deliverable
> when injected but are now deliverable. For these,
> icount_decr.u32.high would already have been set to 0.
> 
> OTOH, I guess we always exit the TB in case we change the "deliverable" state
> of an IRQ, e.g., after LPSW or LCTL. E.g.,
> 
> static DisasJumpType op_lctlg(DisasContext *s, DisasOps *o)
> {
> ...
>     /* Exit to main loop to reevaluate s390_cpu_exec_interrupt.  */
>     return DISAS_PC_STALE_NOCHAIN;
> }
> 
> Maybe really a race then - or we are not properly exiting back to the
> main loop in all scenarios.

I think that it's a race right here in should_interrupt_instruction.

Notice, interrupt_request gets set before icount_decr.  Indeed, the barrier
happens immediately before the set of icount_decr in cpu_exit().

(It is briefly confusing that we have a barrier in cpu_exit and not in
tcg_handle_interrupt.  But that's explained by the cpu_is_self -- no need for a
barrier for the current cpu.  I also think we could usefully use
atomic_store_release instead of a separate smp_wmb.)

Therefore checking interrupt_request after checking icount_decr violates the
ordering rules.

This is confirmed, ish, by noticing putting a breakpoint at that second return
(or assert) and noticing that icount_decr.u16.hi == -1.  It did get set by one
of the other threads, and before gdb managed to stop the world.


r~

