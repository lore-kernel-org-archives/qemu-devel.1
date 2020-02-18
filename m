Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5E9C34022
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 01:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 859FB20836
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 01:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ERpKGZxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859FB20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3rYx-0005yB-OS
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 20:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3rYI-0005Nv-B4
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 20:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3rYG-0001La-P6
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 20:19:54 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38138)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3rYG-0001L6-IE
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 20:19:52 -0500
Received: by mail-pl1-x643.google.com with SMTP id t6so7385632plj.5
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 17:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CYrO/D8KJAMhS037X/pkNXzB3gKmOBzMimqrdkjZz3w=;
 b=ERpKGZxppnYAoUAa+BXKAjAw3S0VV2qQUztptRdeaQMMgxxJ3zfHQEE+F23eSk5yMI
 UAeTCl6BoPhJsquoAVU/AGK1XGXgRPThNIV7QUAew717ufOavwfTIWOAO81bj7+PJmjo
 7hQkfrCXQg/gdxhQY/7w21SzVOYBlrAcYvbIUJYoUnzQ+3z1TWxSvaCFEgZF3xuLkgBt
 GJUSdwtLzfLI+tpSVBWeI7202IuQuSLV8gIWvuwj28/7vsR9vT4A4aF6nz3jqJf0GEKm
 tN0IHrWFCfqmDgQY7q4kBvRVAsZshSHbmheTcx4DljZCrwDsNj6OPFZv4Zke7IAGHeaZ
 IJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CYrO/D8KJAMhS037X/pkNXzB3gKmOBzMimqrdkjZz3w=;
 b=bNccTwesHMTdqM9AL+psoEAR23pf/hWxR7ROIxNYUG3YsLSaecNHAnGk2XqiL/mtbm
 NbUSrNceQxqJChSKuaFZvMaAVm+unENbq6zafi785fDCEdJ1C7Pvy6sd7qj7mjp41lXj
 ns2fZIVN9ULJ89zw3gSMfeob4kzXrySoqxvV0Cwpz7m49ntiVWAOjlRRQ2VZ69HAArLO
 uRSYLMpMiCylPG3I25YM7F8/7QQZ0GKscqbLqh342CYTelVYZd85X3kQ0CfLgfmBvpdZ
 srAqx5lzmh447U963xy+ZASmbLkAsE8KcxEVw5HrTCuVZ8ibSLLrT9cdO5jT5yxVq3Na
 yYKg==
X-Gm-Message-State: APjAAAWKTqbymtLg0EQ4s3+gf0ptkIVrhckhiUSieNRYSylAX79WHXMN
 eShHzgxJYhZXusi9cfd/qmDlAg==
X-Google-Smtp-Source: APXvYqyPmcD8rn7Y//hqcz7kdN0f2OGNmDbELfePOSzvdUSGN4WKfyob5w8d9dXnAp1Krbex24YYFA==
X-Received: by 2002:a17:90a:3603:: with SMTP id
 s3mr2110194pjb.61.1581988790963; 
 Mon, 17 Feb 2020 17:19:50 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 13sm2144217pgo.13.2020.02.17.17.19.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 17:19:50 -0800 (PST)
Subject: Re: [PATCH v5 16/22] target/arm: Implement data cache set allocation
 tags
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-17-richard.henderson@linaro.org>
 <CAFEAcA_K4wreQRXxEdDB4M-NCBC3NmGTyT0aEZxfAwBbSp23Rg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8cf8350c-9f98-6c97-9260-aaf3fda792e8@linaro.org>
Date: Mon, 17 Feb 2020 17:19:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_K4wreQRXxEdDB4M-NCBC3NmGTyT0aEZxfAwBbSp23Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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

On 12/5/19 10:17 AM, Peter Maydell wrote:
> On Fri, 11 Oct 2019 at 14:50, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This is DC GVA and DC GZVA.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> v2: Use allocation_tag_mem + memset.
>> v3: Require pre-cleaned addresses.
>> ---
> 
>> diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
>> index f1315bae37..e8d8a6bedb 100644
>> --- a/target/arm/mte_helper.c
>> +++ b/target/arm/mte_helper.c
>> @@ -510,3 +510,31 @@ void HELPER(stzgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
>>          }
>>      }
>>  }
>> +
>> +void HELPER(dc_gva)(CPUARMState *env, uint64_t ptr)
>> +{
>> +    ARMCPU *cpu = env_archcpu(env);
>> +    size_t blocklen = 4 << cpu->dcz_blocksize;
>> +    int el;
>> +    uint64_t sctlr;
>> +    uint8_t *mem;
>> +    int rtag;
>> +
>> +    ptr = QEMU_ALIGN_DOWN(ptr, blocklen);
>> +
>> +    /* Trap if accessing an invalid page.  */
>> +    mem = allocation_tag_mem(env, ptr, true, GETPC());
>> +
>> +    /* No action if page does not support tags, or if access is disabled.  */
>> +    el = arm_current_el(env);
>> +    sctlr = arm_sctlr(env, el);
>> +    if (!mem || !allocation_tag_access_enabled(env, el, sctlr)) {
>> +        return;
>> +    }
>> +
>> +    rtag = allocation_tag_from_addr(ptr);
>> +    rtag |= rtag << 4;
>> +
>> +    assert(QEMU_IS_ALIGNED(blocklen, 2 * TAG_GRANULE));
> 
> Could we assert this on CPU init rather than in this helper?
> That way if anybody tries to create a CPU whose dcz_blocksize
> doesn't work with the TAG_GRANULE they'll realize immediately
> rather than only if they happen to run a guest workload that
> use DC GVA or DC GZVA.

Sure.  I've moved it to realize.

> I also had to think a bit to work out which way round this
> assert is checking: it's testing that the ZVA block length
> (usually 64 bytes) is a multiple of (twice the TAG_GRANULE),
> which is to say a multiple of 32. Given that the blocksize
> is stored as a log2 value, this can only fail for blocksizes
> 16, 8, 4, 2 or 1, which are all fairly unlikely.

Indeed.

>> +    case ARM_CP_DC_GVA:
>> +        tcg_rt = clean_data_tbi(s, cpu_reg(s, rt), false);
>> +        gen_helper_dc_gva(cpu_env, tcg_rt);
>> +        return;
>> +    case ARM_CP_DC_GZVA:
>> +        tcg_rt = clean_data_tbi(s, cpu_reg(s, rt), false);
>> +        gen_helper_dc_zva(cpu_env, tcg_rt);
>> +        gen_helper_dc_gva(cpu_env, tcg_rt);
> 
> I think this means that if there's a watchpoint set on the memory
> partway through the block we're zeroing then we'll take the
> watchpoint with some of the memory zeroed but without the
> corresponding tags having been updated. But that's probably OK
> (at any rate I wouldn't worry about it for now...)

The relatively new probe_{access,write} functions take care of watchpoints.  On
the next round I'll have another look at what may or may not be missing to use
that here.  It's something that I've been thinking about to get right for SVE
as well.


r~

