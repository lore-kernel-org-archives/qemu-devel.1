Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CA3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 20:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8092C214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 20:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n2X+bCz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8092C214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixcgE-00057r-MI
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 15:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixcfT-0004Nf-Jx
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 15:13:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixcfS-0003Gi-9J
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 15:13:31 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:54539)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixcfS-00037i-0n
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 15:13:30 -0500
Received: by mail-pj1-x1043.google.com with SMTP id dw13so3315189pjb.4
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 12:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=o3919dblkSdIXdjN5TCsJ1/E4ceLSZMj7P+LF/Xc1NI=;
 b=n2X+bCz4FDCd5OYDCFgQI/GJ7sisZ+eP83iZALRsuxvQZOQWudPNqeAiDAFPok9dON
 Yc8UlHvf0RXTGFOXrs8/61iI/Lx1PFn5Kd21Mc716n07VVjssP3jtkkVpjmX5V/X1ebn
 /Z3bzF6eD3XiQbP8B4dw5rhEkbZHOrkyTlngpUZA9D3+Zt8/ndEh3aI88r6PnTKp2G3/
 sFJKIpuYlLLh1RyJYrIwsNPLV5DiFZ/5+8UVuXOBVkaqsaKxRdtSScWBnQn3U996VlN8
 vov1WN1Lv6/cqr4jGKqgWNmYQeon9GyihhIessaRV3HmL7ptFVY1seexGSyok2NeLkBs
 sEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o3919dblkSdIXdjN5TCsJ1/E4ceLSZMj7P+LF/Xc1NI=;
 b=LVsQy8rNwYcoOEHNs/f1jgp/VRWsp06J5GlkgilnyUtOuTMPA23g8HHB4MwO63SZBz
 U3gV0aJO8PYXlr/+V7gYrFLlWb8KTJybLIoPLEaXKst5o2qJ2moL3vn25kLZdnsdtDU1
 SF3erfyARHoClvHhogz7+g/iHzNx/jLwoEGTg3LkQUva7kPvbziQ23KVeMS2mik4lEPs
 ukDX7VS7+faxD8RuL+jjekzE1OocZbfW9tkIKleaozBpAtG2sSk9a0LEKAdjYNvcPHBv
 +CTt211n91A/c5zOttvH+y5kyW/bZ3A/x01cNnp7fi1FMcYkoQaq6CAcnjXmTZDxI/r6
 wXow==
X-Gm-Message-State: APjAAAVVScDc15DdJSFA85mRoSTFfN6WrdJ48Xua9zUVz3Z/VtmQuHRf
 P5EJ80C74tNt2e7DtsfbYjojQw==
X-Google-Smtp-Source: APXvYqwPUNHuCeS8dDc6aUsOIhhTnGz2qTz+E38bviwOLcgvWqPHcJDcHAKgA+A25mvMk3Mf2Ir58g==
X-Received: by 2002:a17:90a:ff15:: with SMTP id
 ce21mr14225773pjb.124.1580501608449; 
 Fri, 31 Jan 2020 12:13:28 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 r11sm1816138pgi.9.2020.01.31.12.13.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 12:13:27 -0800 (PST)
Subject: Re: [PATCH v5 02/41] target/arm: Enable HCR_E2H for VHE
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
 <20200129235614.29829-3-richard.henderson@linaro.org>
 <CAFEAcA8bX4h1hjOaRv7n0wH+F+2QAVjx4wPBXCdk+RbGW0g6Sw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b109bbe1-50a5-65fd-d656-337482de7f85@linaro.org>
Date: Fri, 31 Jan 2020 12:13:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8bX4h1hjOaRv7n0wH+F+2QAVjx4wPBXCdk+RbGW0g6Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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

On 1/31/20 5:06 AM, Peter Maydell wrote:
> On Wed, 29 Jan 2020 at 23:56, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/cpu.h    | 7 -------
>>  target/arm/helper.c | 6 +++++-
>>  2 files changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 0477cef1ea..239c9eb783 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -1417,13 +1417,6 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
>>  #define HCR_ATA       (1ULL << 56)
>>  #define HCR_DCT       (1ULL << 57)
>>
>> -/*
>> - * When we actually implement ARMv8.1-VHE we should add HCR_E2H to
>> - * HCR_MASK and then clear it again if the feature bit is not set in
>> - * hcr_write().
>> - */
>> -#define HCR_MASK      ((1ULL << 34) - 1)
>> -
>>  #define SCR_NS                (1U << 0)
>>  #define SCR_IRQ               (1U << 1)
>>  #define SCR_FIQ               (1U << 2)
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 19a57a17da..f5ce05fdf3 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -4721,7 +4721,8 @@ static const ARMCPRegInfo el3_no_el2_v8_cp_reginfo[] = {
>>  static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>>  {
>>      ARMCPU *cpu = env_archcpu(env);
>> -    uint64_t valid_mask = HCR_MASK;
>> +    /* Begin with bits defined in base ARMv8.0.  */
>> +    uint64_t valid_mask = MAKE_64BIT_MASK(0, 34);
>>
>>      if (arm_feature(env, ARM_FEATURE_EL3)) {
>>          valid_mask &= ~HCR_HCD;
>> @@ -4735,6 +4736,9 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>>           */
>>          valid_mask &= ~HCR_TSC;
>>      }
>> +    if (cpu_isar_feature(aa64_vh, cpu)) {
>> +        valid_mask |= HCR_E2H;
>> +    }
>>      if (cpu_isar_feature(aa64_lor, cpu)) {
>>          valid_mask |= HCR_TLOR;
>>      }
> 
> Should HCR_E2H be in the list of bits for which we do
> a tlb_flush () in hcr_write()? (Currently we do this for
> VM, PTW and DC.) Given some of the later TLB-flushing
> changes have code that is "we only need to flush these
> TLB indexes when this register is written if E2H==1",
> it makes it easier to be sure we have the right behaviour
> if we don't need to think through scenarios of "write
> to the register, then set E2H==1"...

I don't think so, because when E2H changes, we change mmu_idx entirely.
Between E2 and E20_2 for el2, and (if TGE is also set) E10_0 and E20_0 for el0.


r~

