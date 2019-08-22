Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47387C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1467C23402
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JB0y47A+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1467C23402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0qnj-0003zH-U1
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 13:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0qmg-0003RR-6s
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0qme-0001v8-OZ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:22:01 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0qme-0001uN-FV
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:22:00 -0400
Received: by mail-pf1-x443.google.com with SMTP id c81so4378618pfc.11
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=U+h11xSdzMrGrqS1io0flecvYnccMNHcrfEYrykolK4=;
 b=JB0y47A+0unA2+UW5rzSDdDs5nuZVcUcWXqbypCgkmlvP1daIbF4tftGQKEJYUGzyU
 6QxYg/jNDzS2FQZOzdmwfWYhZGEUPHOVZJv7qXYfIXBhYH4qckqZbnT0by5vhwVdahH5
 1BtZhVM9rmVTS91Nr0XxJ5PUWAgFZn4FCc3bK+Tjgqci1BTyXJBUg/pztJdOU/O81F5J
 kJSefAqEAoeiUhCzAIKUxqvnVBoN2dFV9FNS5L1L+aR9WS5Bw4tjkNGTQPaArPaRlqP+
 hu34mwe2qWIMXkVuoEhrYtoAnz0IatYG5SeUcD6JlkARTFyEjQAhHLSqpZs/8zdlPwe2
 4fQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U+h11xSdzMrGrqS1io0flecvYnccMNHcrfEYrykolK4=;
 b=mTPys3m/YFW6Le0T4F3npqgepU3x9KoSsdOFIkHIJf9Lr7VNTQcBiBE/LAq88dlGqV
 fZ/3/aDFyCAH7RO666eooUBJUKKrZtZpLSRTH2Qhr0R5QT04the8BgsWzKkyvQejfkAi
 mQ+ISy9sPnswXbv5j2Ed2cait4g85BEPJe5zSNMeSxjgsSCt5KWN5LQbCsh6RyXR7lm7
 y1wz+CtO9nz+gVPEpLPhX/ziUZGm7qSiw7BpScbBrmmvOoujdiTAj7ycoJvk9GJh/0xS
 Yj5j1dSCqi0V7Xdwt9dlgNrgjbe/oQ0J2aFb8S/Mf9znt90z1wX16eo0If4aGJmfjsJn
 K6fw==
X-Gm-Message-State: APjAAAWiIA6oOD6wd6rpQlGdyiizj1nsI20K9TWSLoKG4n2f5bOl+f2m
 Bp2xoYcy6CqyTJO7assubxrVsg==
X-Google-Smtp-Source: APXvYqyO/eNRWu8KHnJaCZoy+NJAxfNAgIBwCKEGlXGvVqsnE2a/+43lYn8xRR/h/JcyqFk0v8kKfQ==
X-Received: by 2002:a17:90a:e983:: with SMTP id v3mr739997pjy.81.1566494518721; 
 Thu, 22 Aug 2019 10:21:58 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id p189sm28886044pfb.112.2019.08.22.10.21.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 22 Aug 2019 10:21:57 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-4-richard.henderson@linaro.org>
 <CAFEAcA9abuRJXTXkEE+2M4tHQuKc+VwsqfJqEmw-w_+Fcwh0rw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b06858c3-68c1-62e4-f4fc-df61941c29e1@linaro.org>
Date: Thu, 22 Aug 2019 10:21:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9abuRJXTXkEE+2M4tHQuKc+VwsqfJqEmw-w_+Fcwh0rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v2 03/68] target/arm: Convert Data
 Processing (register)
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/22/19 9:00 AM, Peter Maydell wrote:
> On Mon, 19 Aug 2019 at 22:38, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Convert the register shifted by immediate form of the data
>> processing insns.  For A32, we cannot yet remove any code
>> because the legacy decoder intertwines the reg-shifted-reg
>> and immediate forms.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate.c | 229 ++++++++++++++++++++++++++++++++++-------
>>  target/arm/a32.decode  |  28 +++++
>>  target/arm/t32.decode  |  43 ++++++++
>>  3 files changed, 264 insertions(+), 36 deletions(-)
> 
> 
>> +#define DO_ANY3(NAME, OP, L, K)                                         \
>> +    static bool trans_##NAME##_rrri(DisasContext *s, arg_s_rrr_shi *a)  \
>> +    { StoreRegKind k = (K); return op_s_rrr_shi(s, a, OP, L, k); }
> 
> It's a bit non-obvious that we can return early via the expression K
> here (for the "trying to do an old-style exception return in usermode"
> case for SUB and MOV), but it does put the check early where we need it.

Yes, I know.  I tried several different alternatives, but the macro expands 3
different functions with 3 different structures, and I couldn't find a way to
work around that.  Especially...

>> +DO_ANY3(SUB, a->s ? gen_sub_CC : tcg_gen_sub_i32, false,
>> +        ({
>> +            StoreRegKind ret = STREG_NORMAL;
>> +            if (a->rd == 15 && a->s) {
>> +                /*
>> +                 * See ALUExceptionReturn:
>> +                 * In User mode, UNPREDICTABLE; we choose UNDEF.
>> +                 * In Hyp mode, UNDEFINED.
>> +                 */
>> +                if (IS_USER(s) || s->current_el == 2) {
>> +                    return false;
>> +                }
>> +                /* There is no writeback of nzcv to PSTATE.  */
>> +                a->s = 0;

... with this modification.  I suppose I could expand the comment above.


r~

