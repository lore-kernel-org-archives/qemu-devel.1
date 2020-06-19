Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FE9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:46:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDF1206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KGzl57pm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDF1206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmMxj-0006QS-Lp
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 15:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmMwv-0005UM-8q
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:45:17 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmMws-00066C-Jf
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:45:16 -0400
Received: by mail-pl1-x643.google.com with SMTP id j4so4318464plk.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 12:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Lo+f81iqbjMelgFVu9zSInVEJjPZTe6mOs11ccnBRuQ=;
 b=KGzl57pm2iA6vG3M+8YqVviH4kcpmdfxU/Ipy0sMwMsupdbsdGxfX+WQpWUkf6TaGS
 GcjPQQrnqYex87M/EQLB+UdWTwOird/C3Qpenbw/jAKlgj4VWQxxD6/U2GXlPJo/EXmp
 kstK5XOUHau/8CZSZ51RdhXxQqliz8A74Krzv2V8+b7s57v3BfnUtWf9VALOcFWhA8ZH
 5sEMgpFeQ3sJUkTcaAe6CjoH1nUFDa3JI56yYPpx9Ev9DwU/f8LDT59623OKFJ4+Frsv
 SVq2ksHSG9aP2rzAxvZtTWvJlEzltM7lMW3CfRrhk837jGnCwI9lCQHdZzRgED7QxwDj
 a6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Lo+f81iqbjMelgFVu9zSInVEJjPZTe6mOs11ccnBRuQ=;
 b=sh4SHXzVShmkDoGWq8dzdXd67Ssmh8z6KwPFnYvu8K46croLdVhO1QL838wK66ydw0
 /VLrbAGqp6EFYb+urZeV0Jd2cYuehx1zlSSqNB8GqUnVaXIPoEohQzZHQpoKbayLShcR
 G7RML+ni5Jck0l4acWRMOAzqed/+yIq3+XMReTNLqSDkNU3HDykLZAIZPNIWsl2x1G8f
 Kmfbr7cvtaLalpOWKBxaooH8Jha4YMn0JB38mj/arDoNGgU1VbkpqKCCY2aElEAUcaD3
 hp0BVBbuSGyDo/LQPxl3fw1O7YbTFUtNvAF6i2xcxc61ycvDkqxnBol8BF9oI6kTQZp9
 mxXQ==
X-Gm-Message-State: AOAM5304vIml2kpYni/lSAjAuLlqy2H89XfLBYZ0k1zYFFA1qW2UBWWt
 hhvvopE1pgDOAYPVSWA663xHMw==
X-Google-Smtp-Source: ABdhPJw1OLWKQBQlhSScvoeZJLc2mix96i+TL1hvSklLvp48CVM3NMnH5Kd3BcDhKgA3GFPpl5zL4A==
X-Received: by 2002:a17:90b:3d1:: with SMTP id
 go17mr4869952pjb.114.1592595913123; 
 Fri, 19 Jun 2020 12:45:13 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o207sm6720190pfd.56.2020.06.19.12.45.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 12:45:12 -0700 (PDT)
Subject: Re: [PATCH v7 31/42] target/arm: Add mte helpers for sve scalar + int
 loads
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-32-richard.henderson@linaro.org>
 <CAFEAcA8870uLGsGW+A5_QC4PPFnwMfywyvF5KV4yCkqbT6==Qw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0dff6f5e-72a5-8061-2688-fa408cf4b2ef@linaro.org>
Date: Fri, 19 Jun 2020 12:45:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8870uLGsGW+A5_QC4PPFnwMfywyvF5KV4yCkqbT6==Qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/20 7:06 AM, Peter Maydell wrote:
> On Wed, 3 Jun 2020 at 02:14, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Because the elements are sequential, we can eliminate many tests all
>> at once when the tag hits TCMA, or if the page(s) are not Tagged.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> +static inline QEMU_ALWAYS_INLINE
>> +void sve_cont_ldst_mte_check_int(SVEContLdSt *info, CPUARMState *env,
>> +                                 uint64_t *vg, target_ulong addr, int esize,
>> +                                 int msize, uint32_t mtedesc, uintptr_t ra,
>> +                                 mte_check_fn *check)
>> +{
>> +    intptr_t mem_off, reg_off, reg_last;
>> +
>> +    /* Process the page only if MemAttr == Tagged. */
>> +    if (info->page[0].attrs.target_tlb_bit1) {
> 
> It's a bit odd to use this bit here when you don't define what
> it is until patch 40. (Similarly for the next few patches.)

Perhaps.  What do you suggest to resolve this?
Moving the system patches earlier?
Just defining some inline functions for self-documentation?


r~

