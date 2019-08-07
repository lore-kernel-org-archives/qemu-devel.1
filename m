Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A01C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5FF922305
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s3riSf2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FF922305
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQJC-0007l3-1P
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 14:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33996)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvQIj-00072H-2b
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvQIi-0008J7-0i
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:04:41 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:33504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvQIh-0008H5-Nz
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:04:39 -0400
Received: by mail-pl1-x643.google.com with SMTP id c14so41864395plo.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 11:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4Ht3Xb3OUB4vYkmrYsa4/SfHlW4yw444r3BHGm6YfjA=;
 b=s3riSf2ApSTxNZmZBm7KL2xc6RrVcnctRRmtVYRPIwcjrHboIQvGjEwo7ZWu7646eG
 zqWbSWXRtB19TkvT3u8hv3b+op3fswSIpDtv4n2+d7hA9UENsKISUQqoU3AbUvPjz/UB
 XlZkhBXNIZzXvMgOh9AtRNnhpJpL7rRoPW2XItjlPPjWx7GhMwg+Wk3ky7TXboVdGm9l
 Iak+RGcT1l99xWEMUx+0IVBISto7dtxwJyOKbg0Rk4eOAknjTobkw3R3RXptswUf+002
 FK4bi/szC4pa/sdtUDHKkAz8VZv4tTd4M9k++m4LxlsPcTZSE4fLJh0T1onaQIcAWPF7
 +qUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4Ht3Xb3OUB4vYkmrYsa4/SfHlW4yw444r3BHGm6YfjA=;
 b=qgSKAW5CgU9IRpkR7yrXQKJ9OdQLk2VCduifNzSko5SGAvsQ0tFHJ4hjZGDVMpSYxJ
 9GgEdhN+BU24bIty2BrtuLDpXcoqw6e8uTiHpfg44k9uDBX/iBK2qKGr09hT+NVMJ+On
 0WhFE/5Z11+NR9l2yRz5JGdp4Hkwl367khRnQ9dWwO9BKfBB457uftIEVqkCT+3fz6O7
 XGk1TZV8rcN3yMoejPxY4fXKSyIsdnUPuNrbhSi1ntVxiEB3aWq32R/qWKYRhei0NQwa
 mSPOjQ6jHowxURrJh3TK4diu6k8kP3wzKH4KCjx0u0ijQS5uX5wpRc+lASdO4upDnixj
 Glrg==
X-Gm-Message-State: APjAAAU7v+Nrg1Nu1krkKICxnu3x+6iaMIV9hQw3KJPA4yhDs9T3dXD/
 g5TieEkTJgjVApIlKjRdAcqGqQ==
X-Google-Smtp-Source: APXvYqyXb69sSny+uxsD1xySKM2AexG2GBmPirziRG7kly2KfvGPdptDJxZJSQbrkkWCPuuFgdWhNw==
X-Received: by 2002:a17:902:b497:: with SMTP id
 y23mr9441484plr.68.1565201078711; 
 Wed, 07 Aug 2019 11:04:38 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id j6sm653961pjd.19.2019.08.07.11.04.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 11:04:37 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190807045335.1361-1-richard.henderson@linaro.org>
 <20190807045335.1361-4-richard.henderson@linaro.org>
 <CAFEAcA_MFg1_gpaT5+X71s8r5SYZFTizdXs2vQ_6mLooP7E+kg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <061145be-4cd4-b8e6-ae5c-562a59e8088f@linaro.org>
Date: Wed, 7 Aug 2019 11:04:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_MFg1_gpaT5+X71s8r5SYZFTizdXs2vQ_6mLooP7E+kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH 03/11] target/arm: Introduce read_pc
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

On 8/7/19 10:27 AM, Peter Maydell wrote:
>> +/* The architectural value of PC.  */
>> +static uint32_t read_pc(DisasContext *s)
>> +{
>> +    return s->pc_curr + (s->thumb ? 4 : 8);
>> +}
>> +
>>  /* Set a variable to the value of a CPU register.  */
>>  static void load_reg_var(DisasContext *s, TCGv_i32 var, int reg)
>>  {
>>      if (reg == 15) {
>> -        uint32_t addr;
>> -        /* normally, since we updated PC, we need only to add one insn */
>> -        if (s->thumb)
>> -            addr = (long)s->pc + 2;
>> -        else
>> -            addr = (long)s->pc + 4;
>> -        tcg_gen_movi_i32(var, addr);
>> +        tcg_gen_movi_i32(var, read_pc(s));
> 
> So previously:
>  * for A32 we would return s->pc + 4, which is the same as s->pc_curr + 8
>  * for T16 we would return s->pc + 2, which is the same as s->pc_curr + 4
>  * for T32 we would return s->pc + 2 -- but that's not the same as
>    s->pc_curr + 4, it's s->pc_curr + 6...
> 
> Since s->pc_curr + 4 is the right architectural answer, are we
> fixing a bug here? Or are all the places where T32 code calls
> this function UNPREDICTABLE for the reg == 15 case ?

I believe that this is UNPREDICTABLE.

The T32 cases that reference the PC that are not UNPREDICTABLE, literal memory
references and adr, are all of the form (s->pc & ~3) and do not come through
load_reg_var().  Those will be unified by add_reg_for_lit() in the next patch.


r~

