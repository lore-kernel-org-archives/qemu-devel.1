Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A9DC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56474206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6R1CMji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56474206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icXYn-0001oi-Bk
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 11:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icXNg-0001Iu-Ez
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:20:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icXNf-000839-D3
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:20:00 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icXNe-00082W-Uh
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:19:59 -0500
Received: by mail-pl1-x642.google.com with SMTP id x13so3351192plr.9
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 08:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JB0TVAz+9UHryDP3Z7x+pIufhUFoHIE7WhkCCe/6Tug=;
 b=E6R1CMjii8hqfgI5doJ9ZwfZd45dwf5PgKOKlN8i2BpxwidveFhulRXF9/tksItrm5
 JDeb7yyZart5bpiWWZxtezxK6OP+rfY7DwMJGfzq85RUdV1P+OAazPVeqwx4h/ZPYxWy
 ghBtkEPgZgFvansX/gdotms7Ked135xjpkEHY/UstD75T9N8Mw9LXb2/xSi4J9W9c94s
 xZg9WlG6RSAzoYiaC9Fo/2AJ7SjhJObz3RtDVl1fiCHdrUN6vYY80nEFMjurOQrst29j
 4GYIJlR8FLndKfMnV14ZM+o/uDWUizXZuGYiQs6z45esbXHe3eX4Nj5IPcJyi4oRP/3W
 BIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JB0TVAz+9UHryDP3Z7x+pIufhUFoHIE7WhkCCe/6Tug=;
 b=Rwy3+qc42qVVzoGeLMx6KCBT6KqXL5w7XKBkPb+IoqFOV8dQXkTb3TdtUh4MKZvMIg
 zEmLB3qnbe+EkwtO1nGwXr0T198IZgYHsVB4VPevn4ZDEsH1XCOBbweGA+nKH+dgUclR
 f7piot67OdCWZdh+1mX1dOa89CtGhy+ahKBDiDnoL+tEVsisFmHg/tDEVYMhRHJMOmAu
 nU99itzBapi4TfmVpdCURYm1PiXQJIY/NUVbFbcP20NaoRS2XInFVmaYcoAe0vMmiLvg
 N8MXxbd4o2E6+bB6aAo/B4CBNWWYcWSmiLsoMuw0E0ORBeUmgw4JZXF+YHzeO9reIuuW
 hxoQ==
X-Gm-Message-State: APjAAAVN0nHa7pEoHuidUYLXuldvBLAmMhCq3YtN69+479AH07TQlCTL
 cYmamjXpSpdaoAxMAAKF57Ksug==
X-Google-Smtp-Source: APXvYqw+///S9LhOr1uW6DcEiUQqXoWT864JvfvJRvWznjvN/0keFQkMosrm0rAWDVoVuKhrtjv/Xg==
X-Received: by 2002:a17:90a:7f89:: with SMTP id
 m9mr4137316pjl.143.1575476397715; 
 Wed, 04 Dec 2019 08:19:57 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 136sm7940957pgg.74.2019.12.04.08.19.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 08:19:56 -0800 (PST)
Subject: Re: [PATCH v4 14/40] target/arm: Recover 4 bits from TBFLAGs
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-15-richard.henderson@linaro.org>
 <87y2vs8gf1.fsf@linaro.org> <dd46a349-cbe2-d114-90f4-5d9b8c7d6d84@linaro.org>
 <8736e084ux.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a86c86f5-3352-46d5-94ec-716156c27968@linaro.org>
Date: Wed, 4 Dec 2019 08:19:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <8736e084ux.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/4/19 7:53 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 12/4/19 3:43 AM, Alex Bennée wrote:
> <snip>
>>>>  void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int max_insns)
>>>>  {
>>>> -    DisasContext dc;
>>>> +    DisasContext dc = { };
>>>
>>> We seemed to have dropped an initialise here which seems unrelated.
>>
>> Added, not dropped.
> 
> But is it related to this patch or fixing another bug?

It is related to the patch.

We used to initialize all of the a32 and m32 fields in DisasContext by
assignment.  Now we only initialize either the a32 or m32 by assignment,
because the bits overlap in tbflags.  So zero out the other bits here.

I'll add this to the commit message.


r~

