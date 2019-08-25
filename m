Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C494C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 17:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 158832173E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 17:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J/CMLLwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158832173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1wKG-0002YF-BT
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 13:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1wJN-000210-VU
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 13:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1wJM-00073P-FO
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 13:28:17 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1wJM-00073A-8r
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 13:28:16 -0400
Received: by mail-pf1-x441.google.com with SMTP id w16so10052162pfn.7
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 10:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VV2xxxc22WiXjDePmylZfc03QMdFsnHN3+k11KLZ/pU=;
 b=J/CMLLwtjwteBboyx+qHoHdufC0jYcedk6WAElyAQgdcWRr9Oe9Oo0gA3L5AQfwNBN
 hdG71oLqbTcCDbV/AA5ceH2T1Pgt0K9wN0dPUJyEChMYPBH9YdnFgh/wIBfYIdJfatAO
 5nEuD+L98kj3SQohPeVS29PiUJaqa0cEOmKs7CtE0MXL2JBdtuGtS1BjfQtfhml4SIwp
 J4VsEg7xKzyvLjRaqIAKknYPA/JlHNpxWoWXnWBrrBr4Y8/dDAvnOL4HbQbTXSXZqVji
 ea5aT54892zqSKKoyVbrjDro1xR/RQ6rIkQdjQaFH1KjSHnMm2DAs2JOYz/30x9nOiQN
 u1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VV2xxxc22WiXjDePmylZfc03QMdFsnHN3+k11KLZ/pU=;
 b=q6KD6TC3981AMM+8irAGt6XMS9oyYWSnAi/x6PUqxRi8gC2QnJRScue3z0IPX9mqTu
 zj2L3x26NLrceRUSz8ZyWEUSlHZNiJVU74saHHiXkBterL0p0zvzgnqBpf4xL5XJFQJo
 AU2DMT+GJhZWQCqSxonIBf0aRDDEfhymMs4NdpSwblIHKVaBDOuwk8Pmzikxhue8DLBg
 jv4YWZYxitTizX3pFZKaJ5YIKlc4Oe/6s0mkfWaDwjP7sYmWJtFpihfx0XObU4+MVz+3
 nanPDGQIXQBJEF0V0KSwe54WUEnkBwH4yUyWZbdNCEnjrGTgwI9EJ3J7o1isic54FQe7
 DrHA==
X-Gm-Message-State: APjAAAWsJXsz9cYbmpazBop4xrhpGJUQciQHDVmHZymGitxwd9X8a2/g
 VxIItPFGi58wJP4oOrBHktZdJtgsFio=
X-Google-Smtp-Source: APXvYqzv4/02jq9IREq1vNDXA9Us0tBejOHBEKt8mdgfIWTr2S/QHUFjjJDe56KnJFw9Ao8i5Pm2nw==
X-Received: by 2002:a63:6146:: with SMTP id v67mr13456645pgb.271.1566754094749; 
 Sun, 25 Aug 2019 10:28:14 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id h20sm10167110pfq.156.2019.08.25.10.28.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 10:28:13 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-36-richard.henderson@linaro.org>
 <CAFEAcA8JGUdM5v0MCb98Jw+iJNC+ZMD5SDrPVR0dHGgtMOdk6A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <162644ea-ae46-576f-7dea-6696db364c68@linaro.org>
Date: Sun, 25 Aug 2019 10:28:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8JGUdM5v0MCb98Jw+iJNC+ZMD5SDrPVR0dHGgtMOdk6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2 35/68] target/arm: Convert CPS
 (privileged)
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

On 8/25/19 9:20 AM, Peter Maydell wrote:
> On Mon, 19 Aug 2019 at 22:38, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate.c       | 87 +++++++++++++++---------------------
>>  target/arm/a32-uncond.decode |  3 ++
>>  target/arm/t32.decode        |  3 ++
>>  3 files changed, 42 insertions(+), 51 deletions(-)
>> diff --git a/target/arm/t32.decode b/target/arm/t32.decode
>> index 18c268e712..354ad77fe6 100644
>> --- a/target/arm/t32.decode
>> +++ b/target/arm/t32.decode
>> @@ -44,6 +44,7 @@
>>  &bfi             !extern rd rn lsb msb
>>  &sat             !extern rd rn satimm imm sh
>>  &pkh             !extern rd rn rm imm tb
>> +&cps             !extern mode imod M A I F
>>
>>  # Data-processing (register)
>>
>> @@ -340,6 +341,8 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
>>      SMC          1111 0111 1111 imm:4 1000 0000 0000 0000     &i
>>      HVC          1111 0111 1110 ....  1000 .... .... ....     \
>>                   &i imm=%imm16_16_0
>> +    CPS          1111 0011 1010 1111 1000 0 imod:2 M:1 A:1 I:1 F:1 mode:5 \
>> +                 &cps
> 
> In T32 the CPS insn overlaps with the hint space (hint insns have
> bits [10:8] all-zeroes, whereas all the valid CPS insns have either
> M set or one of the imod bits set) -- why doesn't it need to be
> in the same insn group as the hints? If we're going to put it
> separated in the .decode file from the insns it overlaps with
> I guess a comment to that effect would help so it doesn't get
> inadvertently reordered with them.

It is grouped.  It's not immediately visible in the patch because there are a
*lot* of insns that overlap with the hints and 3 lines of context are
insufficient to see that.

But the grouping is semi-visible in the indentation here.

> CPS shouldn't exist at all for M-profile, but the legacy decoder
> got this wrong too, so we should put that on the todo list for
> fixing later (along, maybe, with UNDEFing on some of the
> unpredictable combinations of M/imod/etc for A profile?).

Fixing m-profile is just as easy as as commenting.
I'll leave a TODO for the unpredictable combinations.


r~

