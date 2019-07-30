Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93512C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 00:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F19620651
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 00:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NtXXzMJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F19620651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsGN0-0001ud-Ht
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 20:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33769)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsGMU-0001K7-Ed
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsGMT-0000WT-6H
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:51:30 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45215)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsGMS-0000WB-UL
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:51:29 -0400
Received: by mail-pf1-x442.google.com with SMTP id r1so28872795pfq.12
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 17:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LF7L82GhpFbVdHeg16Q5O7ojfqytaYQnqcY5Dv+kQXE=;
 b=NtXXzMJ7KGT3WpJqKxX+cIhueHC2Ibnsyt2qtYuc2Z1DU7yxoYbD7FcgcAgBuWNhDi
 YtmLbSb9z5QP9E8ytviq1US9YNaa+VG1O3bHv879uEAW4Y+KSkltrWsaKeDrdfj3JWeU
 uncm0JC6EywytvBvuoy7LtWyf4W+8XEYWIje3sZRzZZ64sR3Siv9GqsKU+DOEDpr92N6
 OdoGR7j+MjnNDN8WMSrXL/P3nRATUaP5rNbuK0BMGXLIcsYDHevb6iyW2ukzLrA1JrZW
 tqCa4k7jk0GJYINLrQ5M+6Prbckgec+P8V/4/2jXdcDPJBQIlvzFApLeKmjsgV0cdjn0
 fiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LF7L82GhpFbVdHeg16Q5O7ojfqytaYQnqcY5Dv+kQXE=;
 b=Qqgquatg5fu01BuDUjdxIbfGXX6Z28rEE6ZZTzHlFabIWiTXj6Ra9qa/seDNBieqY3
 UD03VjTNtMxVZfp6aysbuoCRaZ6d3gFjK/Kr+WnsiNSIrhB0Z4SkJryTSJJogxkNPJ4H
 u5aTB4Ae4VwAWq04Yatz+CALqK/UIZPp1DXILSAlThw6bLZ6a1KVO6/SHkUxxJb6AZg5
 wb5fKfZ2Mkq5GB8cXsZqrECikSQLqurdt2r7sO5hBCvUAuEkkKTS6rKldMsuPTBsHbzx
 FHl4cLClYX/BZnGEKsaTGm6g+vtF6gUGzajcdIDNbNLB8eULpaOKY7anFcZWSoVzWuIb
 U7YQ==
X-Gm-Message-State: APjAAAUAjUgG+tnwXeG7RoPoloKLJNPjGVVRRyvfyjTsiEY+wo426lMH
 iMsnDBYcsHvQHlxcfBeohoTwpA==
X-Google-Smtp-Source: APXvYqwVUWMV/I2EwAyVhIPt4QCisbkYAWEZCrNNPH1c4HBBAvF1u5ilKo4jqCfcFZBw21dWJljlqA==
X-Received: by 2002:a62:35c6:: with SMTP id c189mr39285539pfa.96.1564447887584; 
 Mon, 29 Jul 2019 17:51:27 -0700 (PDT)
Received: from [192.168.101.105] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id g2sm103342035pfq.88.2019.07.29.17.51.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 17:51:26 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-8-richard.henderson@linaro.org>
 <CAFEAcA_HY=WuGEPxTEm5g5tYuCDHXRDs=9EXQd6r+zvsL6_=Uw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <af4f9f07-ac63-dfeb-9f2d-734ffff3fe7d@linaro.org>
Date: Mon, 29 Jul 2019 17:51:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_HY=WuGEPxTEm5g5tYuCDHXRDs=9EXQd6r+zvsL6_=Uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 07/67] target/arm: Introduce add_reg_for_lit
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

On 7/29/19 7:15 AM, Peter Maydell wrote:
> On Fri, 26 Jul 2019 at 18:50, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Used only on the thumb side so far, but will be more obvious
>> once we start unifying the implementation of A32+T32.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate-vfp.inc.c |  34 +------
>>  target/arm/translate.c         | 163 +++++++++++++++------------------
>>  2 files changed, 76 insertions(+), 121 deletions(-)
>>
>> diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
>> index e7389bc057..4066b2febf 100644
>> --- a/target/arm/translate-vfp.inc.c
>> +++ b/target/arm/translate-vfp.inc.c
>> @@ -941,14 +941,7 @@ static bool trans_VLDR_VSTR_sp(DisasContext *s, arg_VLDR_VSTR_sp *a)
>>          offset = -offset;
>>      }
>>
>> -    if (s->thumb && a->rn == 15) {
>> -        /* This is actually UNPREDICTABLE */
>> -        addr = tcg_temp_new_i32();
>> -        tcg_gen_movi_i32(addr, s->pc & ~2);
>> -    } else {
>> -        addr = load_reg(s, a->rn);
>> -    }
>> -    tcg_gen_addi_i32(addr, addr, offset);
>> +    addr = add_reg_for_lit(s, a->rn, offset);
>>      tmp = tcg_temp_new_i32();
>>      if (a->l) {
>>          gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
>> @@ -983,14 +976,7 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_dp *a)
>>          offset = -offset;
>>      }
>>
>> -    if (s->thumb && a->rn == 15) {
>> -        /* This is actually UNPREDICTABLE */
>> -        addr = tcg_temp_new_i32();
>> -        tcg_gen_movi_i32(addr, s->pc & ~2);
>> -    } else {
>> -        addr = load_reg(s, a->rn);
>> -    }
>> -    tcg_gen_addi_i32(addr, addr, offset);
>> +    addr = add_reg_for_lit(s, a->rn, offset);
>>      tmp = tcg_temp_new_i64();
>>      if (a->l) {
>>          gen_aa32_ld64(s, tmp, addr, get_mem_index(s));
>> @@ -1029,13 +1015,7 @@ static bool trans_VLDM_VSTM_sp(DisasContext *s, arg_VLDM_VSTM_sp *a)
>>          return true;
>>      }
>>
>> -    if (s->thumb && a->rn == 15) {
>> -        /* This is actually UNPREDICTABLE */
>> -        addr = tcg_temp_new_i32();
>> -        tcg_gen_movi_i32(addr, s->pc & ~2);
>> -    } else {
>> -        addr = load_reg(s, a->rn);
>> -    }
>> +    addr = add_reg_for_lit(s, a->rn, 0);
>>      if (a->p) {
>>          /* pre-decrement */
>>          tcg_gen_addi_i32(addr, addr, -(a->imm << 2));
>> @@ -1112,13 +1092,7 @@ static bool trans_VLDM_VSTM_dp(DisasContext *s, arg_VLDM_VSTM_dp *a)
>>          return true;
>>      }
>>
>> -    if (s->thumb && a->rn == 15) {
>> -        /* This is actually UNPREDICTABLE */
>> -        addr = tcg_temp_new_i32();
>> -        tcg_gen_movi_i32(addr, s->pc & ~2);
>> -    } else {
>> -        addr = load_reg(s, a->rn);
>> -    }
>> +    addr = add_reg_for_lit(s, a->rn, 0);
>>      if (a->p) {
>>          /* pre-decrement */
>>          tcg_gen_addi_i32(addr, addr, -(a->imm << 2));
>> diff --git a/target/arm/translate.c b/target/arm/translate.c
>> index a48e9a90f8..5e2dd8bb16 100644
>> --- a/target/arm/translate.c
>> +++ b/target/arm/translate.c
>> @@ -214,6 +214,23 @@ static inline TCGv_i32 load_reg(DisasContext *s, int reg)
>>      return tmp;
>>  }
>>
>> +/*
>> + * Create a new temp, incremented by OFS, except PC is aligned but not
>> + * incremented for thumb.  This is used for load/store for which use of
>> + * PC implies (literal), or ADD that implies ADR.
>> + */
>> +static TCGv_i32 add_reg_for_lit(DisasContext *s, int reg, int ofs)
>> +{
>> +    TCGv_i32 tmp = tcg_temp_new_i32();
>> +
>> +    if (reg == 15) {
>> +        tcg_gen_movi_i32(tmp, (s->pc_read & ~3) + ofs);
>> +    } else {
>> +        tcg_gen_addi_i32(tmp, cpu_R[reg], ofs);
>> +    }
>> +    return tmp;
>> +}
> 
> This is losing the information in the comments about the UNPREDICTABLE
> cases. Are there callsites where the new function is called where
> "thumb and reg == 15" is not UNPREDICTABLE, or are they all
> that way?

These call sites are that way, but this function will eventually be used for
LDR (literal) and ADR, which obviously are not UNPREDICTABLE.

I don't think this comment attached to this code is useful as-is.  Either we do
the natural a32-ish behaviour and use ALIGN(PC,4), or we should
gen_illegal_op() and be done with it.

Would you prefer a function like

/* Use of PC is UNPREDICTABLE in thumb mode, but allowed in arm mode. */
static TCGv_i32 load_reg_nothumbpc(DisasContext *s, int reg)
{
    if (unlikely(reg == 15) && s->thumb) {
        gen_illegal_op(s);
        /* Unreachable tcg ops will be deleted but must still be legal. */
        return tcg_const_i32(0);
    }
    return load_reg(s, reg);
}

for these specific usages?


r~

