Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06597C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58A82467C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUd2Q6Xn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58A82467C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44167 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idItp-00010M-Nn
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 14:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1idIqH-0007b7-KT
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1idIqF-0004WN-K1
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:00:41 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:36608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1idIqF-0004TN-B4
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:00:39 -0500
Received: by mail-pj1-x1041.google.com with SMTP id n96so3117897pjc.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 11:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Qx3R7o+LwEg1u5/7KnGTceZA+sAoyfLf7UAHNGfMsls=;
 b=jUd2Q6XnR4DNESbuGWwQmseInMVt0ARohFv+YqkDlHSLLAkV6BT39sK8pQ+O1xpY7+
 Gwg9dOf0AsmeJzYRf7cdr1UMPmiRYBrWNNTDfrRZjcMJWjbd/2OqwrApgZh/jeQM3+MI
 rwZZuM6+JW/gAB1rjTf/3Z4a8uLJN0AG3J5Kxxm7jDmeKE0y9WlBVLkVqUmCxt0VP1bB
 DGSjq2Bjo2jaJf6wr/qn9Llcf29SMvg5JGVsw3dBfg8/iK+I8ZdQaZ8gk1I/2Pn0GLqU
 wbCr60l+kQYSfr8PeBnqhCfIaadyLvmiKRqhXHer+awnRcvX0pe7yjTcNDT/FP9NY0VE
 NZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Qx3R7o+LwEg1u5/7KnGTceZA+sAoyfLf7UAHNGfMsls=;
 b=C+HnmR7LErmNRnRAvMi5PwGNWG2UqFXLRgDboK9r0tyC5fRMUSqRVchoIwkEfjQr8v
 0sgE9U9QsZxApaxACL6G/GXXRtGbGLx/rOtJt+yknoC4Z6QIxogKlugRX5bwM6KOxt1/
 javPdXV6BTGqYbVo0RHV4E8m7yddDa3fRGNWC3uAGSYRBo1WyOHuKvjhiIS/xLLf5546
 8adLW6qyDhcRSKMJNLYf25LK0yuNvzI5qtaEBnKslUpZQthTy06Vn/Yu/Xpsns/mTKWd
 mwT2nn2kAv6LRz4xxLr0imjSp4qfAhzMT0GIyczJhpsMsdHTkHeN9Ybsv4IH4pXXsm5v
 VmaQ==
X-Gm-Message-State: APjAAAUK2gvpRATrSGjgysw7Ef2w3Q2ZTuyusEoBM4PvkEyKO3jd0EIe
 AOzvYOQyP/qOcdSSIXjFZrjKnVEG7po=
X-Google-Smtp-Source: APXvYqyYw7T6Zl/aX1+1uOjOh5cXSTTCr/HgzXb1oVQwfzaaXkHS7W2Cx0AcZx7UQypt+Xe+7aam/Q==
X-Received: by 2002:a17:90a:260c:: with SMTP id
 l12mr17870252pje.58.1575658835196; 
 Fri, 06 Dec 2019 11:00:35 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id u3sm4169202pjn.0.2019.12.06.11.00.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 11:00:34 -0800 (PST)
Subject: Re: [PATCH 2/4] target/arm: Update MSR access to UAO
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191203234244.9124-1-richard.henderson@linaro.org>
 <20191203234244.9124-3-richard.henderson@linaro.org>
 <CAFEAcA914CO2vfMAkr4aeEA_FV0Vub6S9eF43qN=14e7nU1uHg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d14445cf-f0f1-bf76-b8f4-2e5845df5a35@linaro.org>
Date: Fri, 6 Dec 2019 11:00:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA914CO2vfMAkr4aeEA_FV0Vub6S9eF43qN=14e7nU1uHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 10:30 AM, Peter Maydell wrote:
>> +    if (cpu_isar_feature(aa64_uao, cpu)) {
>> +        static const ARMCPRegInfo uao_reginfo[] = {
>> +            { .name = "UAO", .state = ARM_CP_STATE_AA64,
>> +              .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 2, .opc2 = 4,
>> +              .type = ARM_CP_NO_RAW, .access = PL1_RW,
>> +              .readfn = aa64_uao_read, .writefn = aa64_uao_write, },
>> +            REGINFO_SENTINEL
>> +        };
> 
> This could just be a file-scope global, right?
> Also, you can just use define_one_arm_cp_reg() rather
> than having a list with one entry. (cf zcr_el1_reginfo).

Can do.

>> +    case 0x03: /* UAO */
>> +        if (!dc_isar_feature(aa64_uao, s) || s->current_el == 0) {
>> +            goto do_unallocated;
>> +        }
>> +        if (crm & 1) {
>> +            set_pstate_bits(PSTATE_UAO);
>> +        } else {
>> +            clear_pstate_bits(PSTATE_UAO);
>> +        }
>> +        t1 = tcg_const_i32(s->current_el);
>> +        gen_helper_rebuild_hflags_a64(cpu_env, t1);
>> +        tcg_temp_free_i32(t1);
>> +        break;
> 
> Do we also need to end the TB since we've messed with
> the hflags, or is some bit of code not in the patch
> context handling that?

Outside the patch context, at the start of the function, we default to ending
the TB.

> Does the "on exception entry PSTATE.UAO is zeroed" behaviour
> fall out automatically for us? How about "on exception entry
> from aarch32 to aarch64 SPSR_ELx.UAO is set to zero" ?

Yes to both -- new_mode (perhaps better renamed as new_pstate) is initialized
as 0 + stuff required to be non-zero.  Thus PAN required special handling but
UAO does not.

> I think we may also want a minor code change so that an exception
> return from aarch64 to aarch32 doesn't copy a bogus SPSR UAO==1
> into the pstate/cpsr.

Ah, good catch.


r~

