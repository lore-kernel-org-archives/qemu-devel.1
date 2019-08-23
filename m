Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497FBC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173E222CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oXznldTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173E222CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1DAq-0005K7-9Z
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 13:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1D9n-0004aV-LB
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1D9m-00088X-LV
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:15:23 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46187)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1D9m-00088K-Fy
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:15:22 -0400
Received: by mail-pg1-x541.google.com with SMTP id m3so6081391pgv.13
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 10:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=x2fzjTMcwWvStholZAH/1CBqkcdUgXqzPVFgSSANG00=;
 b=oXznldTrp3my+RD7FO7PUvPlkpXOZ/31q+qlaIETLSAc3XlWkf04gf6d18NnTQMo/d
 u7lVi/Pi7v23AdLOiVVEskVIsh7KVuQrPTXaMuzfRL4qbvl4KnChjD7aJfrFFbjqtEZS
 Le25ettyHQiDTSbio+cFo0NvmoAsD0C6c9pYu36Zd+6DXdrR3+ZibJmUv9CDM1ZX/v+p
 r+JCmJsq4QsFUgrfaPl5c8BVgl/4PBMj7Vw3GJpeXTyqBsitfAv/tjthoC/5GY3H8bWG
 IPrbEHO2yolrYqXOeZFDtR6M6CaSLuBHPUkcB73n0s1KG3L+O1NFmifAl3ojYgO3xelK
 f3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x2fzjTMcwWvStholZAH/1CBqkcdUgXqzPVFgSSANG00=;
 b=ojnribTJdlJDp9ERPSE1epoEmWqHTZv+9aZJ9ebf0hdtJ9pn4b1EufNOpAVfQ3/O2p
 qaDnx002EawpBDz2/ASp6pPBKA2Cp9ml3hHVTuT4kf9uNp9xJgHl7082tgL1vrN72HPz
 1ResBd7T0YkKuY9cvHXchjFNqIcqoS1T3gZZQirIX5QR37SAnpGKshJJ52/Q7tXK1X8V
 2BuauZ6hM0bWK+G1t3O/X8L94kiIJiHfPo2gvs0vrXxqCZGFBnFH4weebJZqveffDDd7
 GHAFppspuy2LQHK8vZtZ2y0sV9SnLrp4SYhvrNWLg0/YgdUnCUIfMZ8aQS24jLjDZfvi
 9YsQ==
X-Gm-Message-State: APjAAAVJkCfetdwfnKhaPfoakt8hWzKedO2fdTORlk8EtlcYYmIalSxZ
 d37saX1XujUCWGX3L2aUWKSctWYirAw=
X-Google-Smtp-Source: APXvYqzDMxwmYg6nfdkEICBnZTL8SNyyGC2WJX6KVPiNj4kwz4MyOM/yYZSb03Ad9w6s65fSXBunFg==
X-Received: by 2002:a62:5250:: with SMTP id g77mr6567147pfb.158.1566580521651; 
 Fri, 23 Aug 2019 10:15:21 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z4sm3030898pfg.166.2019.08.23.10.15.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 10:15:21 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-26-richard.henderson@linaro.org>
 <CAFEAcA-gsP30Be2wZi-UeUUjond05A3HuFKN3znz60WmPPnCxA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <22cecc22-2de8-7130-0bde-6391a31c1076@linaro.org>
Date: Fri, 23 Aug 2019 10:15:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-gsP30Be2wZi-UeUUjond05A3HuFKN3znz60WmPPnCxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v2 25/68] target/arm: Convert Signed
 multiply, signed and unsigned divide
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

On 8/23/19 10:00 AM, Peter Maydell wrote:
> On Mon, 19 Aug 2019 at 22:38, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate.c | 463 ++++++++++++++++++-----------------------
>>  target/arm/a32.decode  |  22 ++
>>  target/arm/t32.decode  |  18 ++
>>  3 files changed, 247 insertions(+), 256 deletions(-)
>>
> 
>> +static bool op_smmla(DisasContext *s, arg_rrrr *a, bool round, bool sub)
>> +{
>> +    TCGv_i32 t1, t2;
>> +
>> +    if (s->thumb
>> +        ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
>> +        : !ENABLE_ARCH_6) {
>> +        return false;
>> +    }
>> +
>> +    t1 = load_reg(s, a->rn);
>> +    t2 = load_reg(s, a->rm);
>> +    tcg_gen_muls2_i32(t2, t1, t1, t2);
>> +
>> +    if (a->ra != 15) {
>> +        TCGv_i32 t3 = load_reg(s, a->ra);
>> +        if (sub) {
>> +            tcg_gen_sub_i32(t1, t1, t3);
>> +        } else {
>> +            tcg_gen_add_i32(t1, t1, t3);
>> +        }
>> +        tcg_temp_free_i32(t3);
>> +    }
>> +    if (round) {
>> +        tcg_gen_shri_i32(t2, t2, 31);
>> +        tcg_gen_add_i32(t1, t1, t2);
> 
> Can we keep the comment the old decoder had for this case?
> 
> 
>> +    }
>> +    tcg_temp_free_i32(t2);
>> +    store_reg(s, a->rd, t1);
>> +    return true;
>> +}
>> +
> 
> This one:
> 
>> -                if (insn & (1 << 4)) {
>> -                    /*
>> -                     * Adding 0x80000000 to the 64-bit quantity
>> -                     * means that we have carry in to the high
>> -                     * word when the low word has the high bit set.
>> -                     */
>> -                    tcg_gen_shri_i32(tmp2, tmp2, 31);
>> -                    tcg_gen_add_i32(tmp, tmp, tmp2);

Oops, rebase fail.

>> -                }
> 
> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM
> 


