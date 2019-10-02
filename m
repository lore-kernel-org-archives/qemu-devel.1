Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A716C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E47521920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZU2ijE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E47521920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFhoU-0003wC-Fq
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 12:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFhnJ-0003TN-F3
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFhnG-0000Tj-RG
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:48:04 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFhnF-0000Rv-TD
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:48:02 -0400
Received: by mail-pg1-x541.google.com with SMTP id q1so4134769pgb.0
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aFh0KZ8ZuSk6TleyDGx/pvDXFGqFdjXOgnQi5+o+DcU=;
 b=pZU2ijE+Zt5ndvwmZvnpbO5CbRzUEff0zO/PB/jeku07xnLYcJPtq8pimG20XGsmbA
 sEA40ZyvtDcGtU1XD6vAkj6bpFCTi9+uqNekavpUBXB5D/ybmXMIBZn9f7phtQ76vwm2
 MuUy/A+vu2x4yO/YTZXhWrMJSynSMIej4sjO82mB+2S6yUoD6EGIfHSbZw2YmgKzfyk1
 v2ozKGE0OOAkbprCoSQ9CAHlUu7DkMHFlUZLfE3f57gIYN/D7rlhhZKmPHaelU6n+gYs
 Y65sXmHy6asWTATsAaHZ2bMVOQkF6HywcgqrsY9LSkJDzBX8nb+VSREuo5zGjx/jLRlT
 UetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aFh0KZ8ZuSk6TleyDGx/pvDXFGqFdjXOgnQi5+o+DcU=;
 b=beFej5uBdi4kE4nsWnsX6kC88Utmqe1OP6QBRVees+kSmHS2OYgoNRaqOWgOGu+vlP
 tsrrHpA8SxDL9rzXou3g+Y151WkJWM/ulMzFLIIil9+FPujls3luRRvhWxfpkgEFoyAB
 JgiZHb4y6uF8wHzn+WiyqoKqOnkrJTPjIJKCgQhbAFmCuuR8A/2cnhoYfiZMoDwGEE1n
 iSgmWt8Q7NwrOs4BXoFMiCJGxsDKpWIE/kYqfDrWmZJPh5biH8rGnjdRkQugCqSiCQEf
 OX4MhdBJ1QjbuA2ItnTgfOMbBYdxlknng70AjmQ3GzZrdv7ciLQV9rpz9ifxpSrevRWV
 Wvaw==
X-Gm-Message-State: APjAAAXGpfLPJytfJ7WfoeiPaWZMr41P1r2bsq+tzPW1zcUT8xvGQ48A
 HUf62SJBjUkS9ZrVzpbz9TQuSg==
X-Google-Smtp-Source: APXvYqwtDOC9EZHIjU9PUakntyrYlOfkUoZOgNIj/RqzgmsHaC6fR/SGNu0nxg4dbPctbLNzw+zXKA==
X-Received: by 2002:aa7:9d8d:: with SMTP id f13mr5789100pfq.196.1570034880013; 
 Wed, 02 Oct 2019 09:48:00 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d22sm23947989pfq.168.2019.10.02.09.47.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:47:59 -0700 (PDT)
Subject: Re: [PATCH v2] s390x/tcg: MVCL: Exit to main loop if requested
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191002082636.7739-1-david@redhat.com>
 <87zhijjwph.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0479ad1f-348e-ed40-c2c6-aef168afdb7e@linaro.org>
Date: Wed, 2 Oct 2019 09:47:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87zhijjwph.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/19 2:58 AM, Alex Bennée wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> MVCL is interruptible and we should check for interrupts and process
>> them after writing back the variables to the registers. Let's check
>> for any exit requests and exit to the main loop.
>>
>> When booting Fedora 30, I can see a handful of these exits and it seems
>> to work reliable. (it never get's triggered via EXECUTE, though)
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>
>> v1 -> v2:
>> - Check only if icount_decr.u32 < 0
>> - Drop should_interrupt_instruction() and perform the check inline
>> - Rephrase comment, subject, and description
>>
>> ---
>>  target/s390x/mem_helper.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
>> index 4254548935..87e4ebd169 100644
>> --- a/target/s390x/mem_helper.c
>> +++ b/target/s390x/mem_helper.c
>> @@ -1015,6 +1015,7 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
>>      uint64_t srclen = env->regs[r2 + 1] & 0xffffff;
>>      uint64_t src = get_address(env, r2);
>>      uint8_t pad = env->regs[r2 + 1] >> 24;
>> +    CPUState *cs = env_cpu(env);
>>      S390Access srca, desta;
>>      uint32_t cc, cur_len;
>>
>> @@ -1065,7 +1066,14 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
>>          env->regs[r1 + 1] = deposit64(env->regs[r1 + 1], 0, 24, destlen);
>>          set_address_zero(env, r1, dest);
>>
>> -        /* TODO: Deliver interrupts. */
>> +        /*
>> +         * MVCL is interruptible. Check if somebody (e.g., cpu_interrupt() or
>> +         * cpu_exit()) asked us to return to the main loop. In case there is
>> +         * no deliverable interrupt, we'll end up back in this handler.
>> +         */
>> +        if
>> (unlikely((int32_t)atomic_read(&cpu_neg(cs)->icount_decr.u32) < 0)) {
> 
> I'm not sure about directly checking the icount_decr here. It really is
> an internal implementation detail for the generated code.

But it's also the exact right thing to test.


> Having said
> that is seems cpu_interrupt() is messing with this directly rather than
> calling cpu_exit() which sets the more easily checked &cpu->exit_request.
> 
> This is potentially problematic as in other points in the cpu loop code
> you see checks like this:
> 
>     /* Finally, check if we need to exit to the main loop.  */
>     if (unlikely(atomic_read(&cpu->exit_request))
>         || (use_icount
>             && cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra == 0)) {
>         atomic_set(&cpu->exit_request, 0);
>         if (cpu->exception_index == -1) {
>             cpu->exception_index = EXCP_INTERRUPT;
>         }
>         return true;
>     }
> 
> although I guess this is because interrupts and "exits" take subtly
> different paths through the outer loop. Given that exits and interrupts
> are slightly different is what you want to check
> atomic_read(&cpu->interrupt_request))?

No, this is not about interrupts per se.

The thing we're trying to solve here is MVCL running for a long time.  The
length operand is 24 bits, so max 16MB can be copied with one instruction.  We
want to exit back to the main loop early when told to do so, as the insn is
officially restartable.

Ordinarily, I would say move the loop out to the tcg level, but that creates
further complications and I'd rather not open up that can of worms.

There is still the special case of EXECUTE of MVCL, which I suspect must have
some failure mode that we're not considering -- the setting and clearing of
ex_value can't help.  I have a suspicion that we need to special case that
within helper_ex, just so that ex_value doesn't enter into it.


r~

