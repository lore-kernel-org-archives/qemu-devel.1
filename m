Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68DEC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 14:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2387208C4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 14:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmqlEyRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2387208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw6JB-0002A4-QM
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 10:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43791)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hw6Ij-0001ac-Dd
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 10:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hw6Ii-0002pA-9L
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 10:55:29 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hw6Ii-0002oZ-1S
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 10:55:28 -0400
Received: by mail-pg1-x542.google.com with SMTP id w10so45987378pgj.7
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PWPVVDThU0nmtKU2IIgFUotz4Rs66obF2GGJu8gYVwo=;
 b=VmqlEyRT7YAE11NjNjlF9MlXe5TwYyOvLEOXW5bFzlB/pw6DEmcii1eRhXCoUqJQwO
 AEp4WWvl0C1XmO++1W1MhaFKpus3yDc5NUamWbHFro8ynuP/5p4LnhxGuq1EHQei7QN0
 35wPnjafj+uBQnJnNQlGDSBRMcyGnrWdhSWfbQpXBrVEzvDz5WTpaWuFx9XMLk+YALuq
 Qu7O16A08ZFLjjgq4QTV+fWjMCNx1zem5jBKw4haETF2MwsfmC/dpLOX0JKMtv8aBq/x
 wf3LaVYEbPi27++RDK2T8hM/4vHkr2leMtRQnx4/GO7B9hB3/RHRfTBOF8GEcn0jfyX+
 LTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PWPVVDThU0nmtKU2IIgFUotz4Rs66obF2GGJu8gYVwo=;
 b=YvJ53hHYBzrfs1XPtOHtk09VitMMymdw05vrJHc8xREbIde60edGJV+wVQvYlIS3rq
 1fts5CnsY5vqxHQy7r6WXAeL/P+xTWdsokY1cPYEANvnG1L066tRNtgvhoxzdXiCzz4w
 sLsP+jDyOjGnmHf8O9N0+FyHbLjP6FU57p/KjnJqwZAOZIuZaHut+rOdMGsJX/SAS24j
 bnmvQRDlO7M6BJ5aJJcJp+C1l5JHvtoqmIbwC2K7WZ+DSVhVAdEEF7ZW2nCGyDDgqw06
 xyPy01dypwzUL94tjI8od1hc4+z+FCjYRSm4gBjFVGXSlDteP8C7EpGBsI119NFe8gyG
 9ycw==
X-Gm-Message-State: APjAAAXFYtPfv7oq/P2cRpMLJDFHXF2hgpyPm2YLV2atVDeDRfJ0lX4W
 KoRT8bMCeqIB29NU5UuD/zMETg==
X-Google-Smtp-Source: APXvYqxWc6Af9XIn36KXzp+yo/Kp8sg6Oifk7UhtBk8ZtOiwXdqeP7YIxwpVWhfFRexCytODbvWekg==
X-Received: by 2002:a65:5043:: with SMTP id k3mr18388880pgo.406.1565362526523; 
 Fri, 09 Aug 2019 07:55:26 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id o14sm5007235pjp.29.2019.08.09.07.55.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 07:55:25 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-12-richard.henderson@linaro.org>
 <CAL1e-=gwyGB4ibo_B5W1MpFy-9bB7=5juqTJVBdD9N6XFOOsSQ@mail.gmail.com>
 <0f37edc5-2fb6-c92d-fb47-a381af649072@linaro.org>
 <CAL1e-=hWVfYVYySkMCF4NUkHbe=47qUTuAA0vK23TGMBzuA+PQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0b6556a5-7db8-bedf-89f3-7ead8e9b19e6@linaro.org>
Date: Fri, 9 Aug 2019 07:55:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hWVfYVYySkMCF4NUkHbe=47qUTuAA0vK23TGMBzuA+PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH 11/67] target/arm: Add stubs for aa32
 decodetree
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
 "open list:Stellaris" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/9/19 3:31 AM, Aleksandar Markovic wrote:
> 
> 
> On Thu, Aug 8, 2019 at 5:43 PM Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     On 8/8/19 4:41 AM, Aleksandar Markovic wrote:
>     >     +/*
>     >     + * Include the generated decoders.
>     >     + * Note that the T32 decoder reuses some of the trans_* functions
>     >     + * initially declared by the A32 decoder, which results in duplicate
>     >     + * declaration warnings.  Suppress them.
>     >     + */
>     >     +
>     >     +#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
>     >     +# pragma GCC diagnostic push
>     >     +# pragma GCC diagnostic ignored "-Wredundant-decls"
>     >     +# ifdef __clang__
>     >     +#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
>     >     +# endif
>     >     +#endif
>     >     +
>     >
>     >
>     > This looks more like a "band aid" solution rather than the right one.
> 
>     What would the "right" solution be, would you say?
> 
> 
> The right (without quotation marks) solution is not to generate the code that
> generates compiler complaints.

That would be impossible with the information supplied.

Emitting zero declarations will result in invalid C.  We ensure that each
individual decodetree file does not emit duplicates.  However, there is no
knowledge across separate decodetree files about which declarations are duplicate.

In this particular case, I do not even agree that the warnings themselves are
useful.  I suppose it's not impossible that they could diagnose some weirdness
in a code base, where a function is declared in multiple headers or a patch
application has gone awry leaving multiple sequential declarations, but
honestly how often does that happen?

I suppose with some work, we could not invoke decodetree multiple times, but
give it all of the input files at once, producing a single output file.


> Obviously, in this case, decodetree-generated code shows that it is
> inferior to human-generated code.

That is not obvious at all.  Moreover, I disagree strongly.


r~

