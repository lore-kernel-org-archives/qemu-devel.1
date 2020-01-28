Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179A2C32771
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 00:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10F52173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 00:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FMbr/Q+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10F52173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwENt-00018T-0Z
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 19:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwENA-0000Jw-FU
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 19:04:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwEN9-0002d8-Cz
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 19:04:52 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36163)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwEN9-0002cf-5r
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 19:04:51 -0500
Received: by mail-pf1-x442.google.com with SMTP id 185so1907758pfv.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 16:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=T7t1MXsPVviLhXgv7hxfGRZSnDG0LkdWhBaGF4qkcQU=;
 b=FMbr/Q+wy8byUDDzftlQevnTLqGFXK55UgWQba5qik//JOMN6TQQU9/lI6YuJxrDbq
 cysRGJK2w3QHBDkZTLA3QZDYtk9LeDXgBWpw++Fnmn4yv3NS8Q+rjEsYJydWZxuYGYAg
 oaEFH12oBU/x0EAM+nulpXREYCW49Qot85Uj/Vy2RHieqES9vaK88D28D9d8XGv3ORdF
 /KFvGxlZMEdwRgocDbKGOkoSIk8eWqT/aeNTpEm/rs9YGtKzRm0SAx/sbIxn8q26bV4z
 enESgs0EpMdEomTvWydiSYTOYug2fIYdqyBIKLxiE6RdYxH1kpUZWDB+Ze5pWtBgG5nq
 Wyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T7t1MXsPVviLhXgv7hxfGRZSnDG0LkdWhBaGF4qkcQU=;
 b=tYhxj6+Y5NQs5FkFZ6TOl0hV+RgI00jsOFKzMkRDKBhFMBt2gOExYzAlMeP5tlmGoV
 VzlCz09UkkKfnmfrX4qA/h4ZxpLCgOKFJ8dHYJ0fvTKeh61rGL86a7d+NAicGxIFp2IQ
 mBDJnM0Zo7AiWPiPNyF8xqW7qKyHaJgP6Jj41TPpQsWBZBsGHQNzRdKJ9DFpgLx0/7CP
 bvJwCfMEr338oyI64He8t+boDdIA6+SdZro0I6njN3m23jZCV0RbLQ6JlYW7f6DusUYq
 xQDuQ6kfwqxum9POwPPgGIhX3641vY36p4AAsIyS9gpveZRzZlD17tcNnvoD3sr3FWik
 Wa2Q==
X-Gm-Message-State: APjAAAV0OjhZjFWowWmifgXlZCo90Q+2zpE6o1Vbl5sHlA1RyOb877kc
 gST8XQbZgcVVpe0PqWXzCWgfiA==
X-Google-Smtp-Source: APXvYqzNQUET7nU3jdb1lpkuPbFgARPvCCNwkhaZcZlLrV0SG8faYc/iDhw9mC+z71uDrNapXVBzWA==
X-Received: by 2002:a65:4b89:: with SMTP id t9mr7845848pgq.102.1580169889828; 
 Mon, 27 Jan 2020 16:04:49 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 p24sm16893088pff.69.2020.01.27.16.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 16:04:49 -0800 (PST)
Subject: Re: [PATCH v4 29/40] target/arm: Flush tlb for ASID changes in EL2&0
 translation regime
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-30-richard.henderson@linaro.org>
 <CAFEAcA9=4MXFEnVbPpa1CmG8xHx-xuVt8MXwsNGyT+nB2+L1Mw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a78956ca-4327-f25b-67d5-f7c0c7fdd513@linaro.org>
Date: Mon, 27 Jan 2020 16:04:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9=4MXFEnVbPpa1CmG8xHx-xuVt8MXwsNGyT+nB2+L1Mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 9:05 AM, Peter Maydell wrote:
> On Tue, 3 Dec 2019 at 02:30, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Since we only support a single ASID, flush the tlb when it changes.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/helper.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 9df55a8d6b..2a4d4c2c0d 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -3740,6 +3740,15 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>  static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>                                      uint64_t value)
>>  {
>> +    /*
>> +     * If we are running with E2&0 regime, then the ASID is active.
>> +     * Flush if that changes.
>> +     */
>> +    if ((arm_hcr_el2_eff(env) & HCR_E2H) &&
>> +        extract64(raw_read(env, ri) ^ value, 48, 16)) {
>> +        tlb_flush_by_mmuidx(env_cpu(env),
>> +                            ARMMMUIdxBit_EL20_2 | ARMMMUIdxBit_EL20_0);
>> +    }
>>      raw_write(env, ri, value);
>>  }
> 
> For the existing EL1 setup we have separate write functions
> for TTBR registers and for TCR_EL1 (vmsa_tcr_el1_write()
> and vmsa_ttbr_write()), rather than a single one, and they
> don't do the same thing. Why do we use a single writefn
> here? It looks particularly odd because we're actually looking
> at the value written here.

Yes, Laurent noticed the same problem wrt patch 4.
Fixed.


r~


