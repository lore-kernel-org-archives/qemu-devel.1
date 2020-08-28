Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35AAC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A560320936
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/0xtH7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A560320936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBk1g-0007jL-TU
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 15:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBk0z-0007HT-Pj
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 15:26:23 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBk0w-0004O8-SB
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 15:26:21 -0400
Received: by mail-pl1-x644.google.com with SMTP id q3so122002pls.11
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 12:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7fkBZbokuPvjTC6/RKOkYG3g2rJyBtcw6fBtTNquT7c=;
 b=g/0xtH7qh9Do4yeiiVQ9VPt18rWmlRlGSqQZCxdH9Red7Gx2oTAkEVqvrO8FTHY8Bz
 l2oUMsdJa7MmkjERx7ABwzyh4Hi8Me84H2k8ueje6zd3S9kwat6AXOfm5Gfw/7foMLHG
 EgW+yc2uJGZKVF8iQb1YaL46jl3h8xfHlk/T4LR109QQGrbmooVAypUmmpsqVpaKXYIc
 iDH7I1qfQYGGHbfDoGEKwC4VlgTOaQ8DgkbN32Wk6tY7Nbs+JiDI8vwyE01Q4BFjlmAU
 4GR4j8DJjTlxLZT+zjiKDcQ5HB3QS2cp4po7zU1NVdA/NRxJvLwUjU5KiOBTQFtatALQ
 B8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7fkBZbokuPvjTC6/RKOkYG3g2rJyBtcw6fBtTNquT7c=;
 b=pzZm8KsmKklvBHUyQ5BcCB/DKE2G5nf7SBDIg+S2pie9WNTHa2KZCEZAJaSZdKKsK7
 HTvU6e0lXEaAMaJD0W8HX8DL1vVgLoGj1G8EIVxwZ6e8BabLZysUDQ136kirrot0n/gp
 /i8JybV2Wasec71BHtykfq5iW5yHMiRIIzgOycNeypeClJ0pqwN8W4QEWRoxKoTXoJBc
 qNWO0wYjF33xUEkwP0ywvT6Mz3+RSqLnc3X9M2twsnP6v6JwNN0aExgjZTVq4Q96tsBu
 JpJ+rwWipgnzc0XHHKtesNpwCtMougLs6iGxLWy5Y5uYkqYWng63UeDEvbl0XrcfVfad
 1gpw==
X-Gm-Message-State: AOAM530ok6qDf4lNFWKIst4chjROzmVcAkPVha8m6XKlkqN6LLVsyzR2
 ITkK+OzhQ2hb6Pv+c8FpBZdCoQ==
X-Google-Smtp-Source: ABdhPJxjYR74/8OJzCMezENUfDf6lNlxDmQO2Ibw58JKOpaOuIgrSF4JzoJw1M7wE93r7KJ4Q7Bg8g==
X-Received: by 2002:a17:90a:2b4d:: with SMTP id
 y13mr427212pjc.200.1598642775514; 
 Fri, 28 Aug 2020 12:26:15 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h9sm223810pfq.18.2020.08.28.12.26.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 12:26:14 -0700 (PDT)
Subject: Re: [PATCH 16/20] target/arm: Fix sve_zip_p vs odd vector lengths
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-17-richard.henderson@linaro.org>
 <CAFEAcA8s==-CGT88P97xFaxcNkOf6WdNYi-3HSwjWRBXh+KQxw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b3f1beff-c524-a4a7-1202-e9b317ac263b@linaro.org>
Date: Fri, 28 Aug 2020 12:26:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8s==-CGT88P97xFaxcNkOf6WdNYi-3HSwjWRBXh+KQxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/25/20 6:49 AM, Peter Maydell wrote:
> On Sat, 15 Aug 2020 at 02:32, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Wrote too much with low-half zip (zip1) with vl % 512 != 0.
>>
>> Adjust all of the x + (y << s) to x | (y << s) as a style fix.
>>
>> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/sve_helper.c | 25 ++++++++++++++-----------
>>  1 file changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
>> index fcb46f150f..b8651ae173 100644
>> --- a/target/arm/sve_helper.c
>> +++ b/target/arm/sve_helper.c
>> @@ -1870,6 +1870,7 @@ void HELPER(sve_zip_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
>>      intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
>>      int esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);
>>      intptr_t high = extract32(pred_desc, SIMD_DATA_SHIFT + 2, 1);
>> +    int esize = 1 << esz;
>>      uint64_t *d = vd;
>>      intptr_t i;
>>
>> @@ -1882,33 +1883,35 @@ void HELPER(sve_zip_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
>>          mm = extract64(mm, high * half, half);
>>          nn = expand_bits(nn, esz);
>>          mm = expand_bits(mm, esz);
>> -        d[0] = nn + (mm << (1 << esz));
>> +        d[0] = nn | (mm << esize);
>>      } else {
>> -        ARMPredicateReg tmp_n, tmp_m;
>> +        ARMPredicateReg tmp;
>>
>>          /* We produce output faster than we consume input.
>>             Therefore we must be mindful of possible overlap.  */
>> -        if ((vn - vd) < (uintptr_t)oprsz) {
>> -            vn = memcpy(&tmp_n, vn, oprsz);
>> -        }
>> -        if ((vm - vd) < (uintptr_t)oprsz) {
>> -            vm = memcpy(&tmp_m, vm, oprsz);
>> +        if (vd == vn) {
>> +            vn = memcpy(&tmp, vn, oprsz);
>> +            if (vd == vm) {
>> +                vm = vn;
>> +            }
>> +        } else if (vd == vm) {
>> +            vm = memcpy(&tmp, vm, oprsz);
> 
> Why is it OK to only check vd==vn etc rather than checking for
> overlap the way the old code did ? The commit message doesn't
> mention this.

We only ever pass pred_full_reg_offset, so there will only ever be exact
overlap.  I can either split this out as a separate change or simply add it to
the patch description.


r~


