Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47908C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF41218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGucbvKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF41218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr52q-0006RC-Ub
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47334)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr52e-000617-8n
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 14:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr52d-0005F9-31
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 14:34:08 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr52c-000582-QD
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 14:34:07 -0400
Received: by mail-pf1-x444.google.com with SMTP id g2so24910192pfq.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 11:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wkSx0OalOfQUYo0gvwfAvDMu6TklzMt4esDAb6i7vsM=;
 b=zGucbvKMTMdz8tPJMPMB8Q6aR8acVZMipNc8MMaMUKnm7UNZSqetfMY+w1jR5xDMqq
 fdE8g5LXfnRXbyDbCnlXC4M2ab15qXC7DDJyJCDtCO7DdvzAvLXNa6qH86h/WC75En8N
 f7OIiPjGoBDE9l0hDDtibf//APVG6XQGEi04CY53nV0Jse+opsDCjCvXp++Nv456+MfN
 oE8tUEOHh5xUVofTixr6pU8O+bt2NHKzXS7AT4xx7R/2QHaLTfsYjgXO58ag2P8U09cU
 DtjG6Cx0OIPeXoxC5ei5h0KBbQp+FRU1doVhKmaxbX1HbFeyBmzZ0SXC2WbH+Rx7t7ra
 9T+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wkSx0OalOfQUYo0gvwfAvDMu6TklzMt4esDAb6i7vsM=;
 b=tJlZbanH+2uPEyx2lOowuQnC2fFtEN/xeFRs6N3oZWWp1JHgzUcD5E+wUewFzrDDqf
 NfF/BpOo2f/TlLxw1JB+Eo79/jVVe6MQOkiEuQCLtTfpHjY7NyT9fdMcwnXDf2gUzFup
 r6P31t/hYE4EXYYbtKvxO1WuQ/EfNg2mkKjAt0ze0+YGIoaDjecU8C+ap0OJtefFDMTt
 ZjTar0uPE/lWRJl/Z23wzalbOlaJcVULxYecclTj0phAMAabDytJKOYVaukZ8FNi+xEw
 IOr866ncUaX5qclR2Se2QjA95m62mK1Dxnlj/7SjamuwU5PrHTey8UmDrBzfO+Tdg8EB
 xHoA==
X-Gm-Message-State: APjAAAWKzc3WraWs1FCbukcCSqYBOT8h59WFcEv0WkzNODmm6UYNwxjk
 BpiiIsQ620PWI8vXIVU8jCL0OA==
X-Google-Smtp-Source: APXvYqxW+DkdA1INys4b3oTci2eLSXQ6MqdQ9ho0zZVcXIAi92r45eN3JmJe7+Pxb352rqS09J7OUw==
X-Received: by 2002:a63:1d4:: with SMTP id 203mr17677684pgb.441.1564166045241; 
 Fri, 26 Jul 2019 11:34:05 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id v7sm10908081pff.87.2019.07.26.11.34.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 11:34:04 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-67-richard.henderson@linaro.org>
 <CAFEAcA9s44Lc58X=C1DzPRRCyi_KOpx0CiMfhKWEzAdDoU326A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <77302caf-9111-8341-c05a-aff996437c2b@linaro.org>
Date: Fri, 26 Jul 2019 11:34:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9s44Lc58X=C1DzPRRCyi_KOpx0CiMfhKWEzAdDoU326A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 66/67] target/arm: Move singlestep check
 from gen_jmp to gen_goto_tb
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/26/19 11:13 AM, Peter Maydell wrote:
> On Fri, 26 Jul 2019 at 18:51, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> We miss quite a number of single-step events by having
>> the check in the wrong place.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate.c | 16 ++++++----------
>>  1 file changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/target/arm/translate.c b/target/arm/translate.c
>> index c2b8b86fd2..9ae9b23823 100644
>> --- a/target/arm/translate.c
>> +++ b/target/arm/translate.c
>> @@ -2740,7 +2740,10 @@ static void gen_goto_ptr(void)
>>   */
>>  static void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
>>  {
>> -    if (use_goto_tb(s, dest)) {
>> +    if (unlikely(is_singlestepping(s))) {
>> +        gen_set_pc_im(s, dest);
>> +        gen_singlestep_exception(s);
>> +    } else if (use_goto_tb(s, dest)) {
>>          tcg_gen_goto_tb(n);
>>          gen_set_pc_im(s, dest);
>>          tcg_gen_exit_tb(s->base.tb, n);
>> @@ -2751,16 +2754,9 @@ static void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
>>      s->base.is_jmp = DISAS_NORETURN;
>>  }
>>
>> -static inline void gen_jmp (DisasContext *s, uint32_t dest)
>> +static inline void gen_jmp(DisasContext *s, uint32_t dest)
>>  {
>> -    if (unlikely(is_singlestepping(s))) {
>> -        /* An indirect jump so that we still trigger the debug exception.  */
>> -        if (s->thumb)
>> -            dest |= 1;
>> -        gen_bx_im(s, dest);
>> -    } else {
>> -        gen_goto_tb(s, 0, dest);
>> -    }
>> +    gen_goto_tb(s, 0, dest);
>>  }
>>
>>  static inline void gen_mulxy(TCGv_i32 t0, TCGv_i32 t1, int x, int y)
> 
> I haven't tested but I'm not sure this change is right.
> The idea of the current code is that we handle generating
> the actual singlestep exception in arm_tr_tb_stop() at the
> end, rather than in the process of generating code for the
> insn. This change means we now do a gen_singlestep_exception()
> in the gen_jmp()/gen_goto_tb() part of the code, but we haven't
> removed the handling of it in arm_tr_tb_stop(), so we're now
> doing this in two places. Why doesn't the current design work?

Note that the existing gen_goto_tb does not test for single-step, and always
emits NORETURN code, either via tcg_gen_goto_tb() or
tcg_gen_lookup_and_goto_ptr().  The singlestep exception is neither generated
nor would it be reachable.

Another way to do handle this would be to test single-step but set DISAS_JUMP
instead of actually generate the singlestep exception in gen_goto_tb.  Do you
prefer that method?

> And if we need to do something different for the route to
> "change the PC via gen_jmp()" why don't we need to do it
> also when we change the PC via eg gen_bx_im() ?

See patch 67.

>  * four places for barrier insns where we use a
>    gen_goto_tb to end the TB -- this isn't consistent
>    with how we end the TB for other situations...)

Fixing this sounds like a good cleanup.


r~

