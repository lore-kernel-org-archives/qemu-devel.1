Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C11CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 21:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A1A2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 21:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WECYIXPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A1A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO6yK-0004xC-HX
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 17:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iO6ww-0001As-EF
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 17:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iO6wt-00017J-Vw
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 17:16:45 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:46511)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iO6ws-000173-Lr
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 17:16:42 -0400
Received: by mail-yw1-xc42.google.com with SMTP id l64so1344307ywe.13
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 14:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JGlYHS/84KhZi5NqUT8zMYlFvSm3aB4CLlmPYx6j0I0=;
 b=WECYIXPRcjy338Ek6i1mpgiTKESYaEpPcmQ7bPvcnnKH+NX3aryT8ILnuBm8jBkdE5
 xUfLBsxWuVVbOZRtUclI1RAZZD2nl5BQDn7+PIZQ4a8X/Kg3B0FFZWjH37tQ4CRO6kiY
 W/GfUzHlbIkxqvuT1c8xF0ZtpRMJ6hBaSY9y2Q2Ik9hdc+vyHuUZdYVi2Tz/EawwhsSU
 1GpkRP3iOMoHnHbzmQeiQSjG4vKKkrtFbVxA7dvItXh9NF1/z6XaR29QWQ59tdgFoKwD
 4VukKxMyEQ+f2RWOWJGkDBEbwH8AfUXKVs2DMGNZ8h1ZUuxlIzmKYd5sXEOuI6qKkIJQ
 UirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JGlYHS/84KhZi5NqUT8zMYlFvSm3aB4CLlmPYx6j0I0=;
 b=oIQF962OD63LFyE6oQqcRNHBNEfQpYxrUQAihZKW3cejtVn76+TpFlOPW1HLvru6xI
 +hQDTUOTmEVYqBpaM2e58X36uA2d/VfTqs7Dry0vmhHpatbaFwvlUXmHOVCPpdmuZbX4
 xunOVOzBoFwFoZde9gDiu/iqJ4coxRQymj20/CeAIaXxVfdngyVsvS6IXVVM9kndd5i2
 Z70uqnDZr+KGbkPIfOuGb690yfPhaweBPjuizdDEWcZarGZ0Sjk9NO0014v2szcMxs/3
 +2WAzng2uumBwle9bNH3p0TvaL9gNNlKu32n6jSw05WuuQLYUhARbnslLGz1JRvC9l3+
 Mbeg==
X-Gm-Message-State: APjAAAUc/Dve1XdLyHQZnpgmKBq06U5cWSl9cSZSFpn8H2u4fGH3rXXl
 4bkgOFmqFMUkUJrHxkpC/stX9g==
X-Google-Smtp-Source: APXvYqxO63ANnK7p5BNOMmZJKnO1EH1RyAVk3H9GK5sJz7TRx+JZ5fzPNrzosZvzTYNSA2Kcf/NmjA==
X-Received: by 2002:a0d:ee07:: with SMTP id x7mr3910829ywe.461.1572038201576; 
 Fri, 25 Oct 2019 14:16:41 -0700 (PDT)
Received: from [172.20.40.202] ([206.121.8.178])
 by smtp.gmail.com with ESMTPSA id f194sm4172507ywb.53.2019.10.25.14.16.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Oct 2019 14:16:40 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] exec: Use const alias for TARGET_PAGE_BITS_VARY
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191023154505.30521-1-richard.henderson@linaro.org>
 <20191023154505.30521-5-richard.henderson@linaro.org>
 <CAFEAcA8unCxb-4E561fnOFd=LCXv1y7YSd9xUb2GAutjcYXeGg@mail.gmail.com>
 <2d65342e-ed48-1fe6-7e6c-97f51ac21a76@linaro.org>
 <CAFEAcA99ABj9LU4fox-7Zaz4NG-yKQ7cD21M9xv=AwtSSOr1mA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5225af4a-51db-5e21-ad67-77d50b365786@linaro.org>
Date: Fri, 25 Oct 2019 17:16:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA99ABj9LU4fox-7Zaz4NG-yKQ7cD21M9xv=AwtSSOr1mA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/19 5:01 PM, Peter Maydell wrote:
> On Fri, 25 Oct 2019 at 21:43, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 10/25/19 10:51 AM, Peter Maydell wrote:
>>>> + * We want to declare the "target_page" variable as const, which tells
>>>> + * the compiler that it can cache any value that it reads across calls.
>>>> + * This avoids multiple assertions and multiple reads within any one user.
>>>> + *
>>>> + * This works because we initialize the target_page data very early, in a
>>>> + * location far removed from the functions that require the final results.
>>>
>>> I have to say that this feels like a worryingly large amount
>>> of magic. Is this actually guaranteed to work by the compiler?
>>
>> Yes.
> 
> I'm curious to know how the compiler engineers define
> "very early" and "far removed" -- in my experience they
> usually prefer to be more precise than that :-)

I remembered putting more precise language in there, but I don't see it now.
Perhaps I just dreamt it.

The last write to the non-const variable happens before the first time we
access the const variable.  At the first access to the const variable, we
assert that it has been initialized.

There's no specific barrier to avoid that first read of the const variable not
be hoisted by the compiler before the last store of the non-const variable,
except for being in a separate function, in a separate compilation unit, and
thus "far away".

We could, perhaps, put a barrier() at the end of finalize_target_page_bits(),
documenting this fact against some future date when compilation with -flto is
viable.  I will say, though, that I've tried that recently and quite some work
is required before one could enable -flto.  In the meantime, the barrier()
would compile away to nothing.


r~

