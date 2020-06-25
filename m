Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97198C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:00:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6105C20679
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+uO64l8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6105C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joX7K-0001yV-Hm
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 15:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joX5y-00008z-Lk
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:59:34 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joX5w-0003tN-2Y
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:59:34 -0400
Received: by mail-pj1-x1043.google.com with SMTP id cm23so3725990pjb.5
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=umvmDDY1FkvIo094HtO7DiL5pPHWkImB8dWtY33IdGQ=;
 b=u+uO64l8ZFFB53cDCBLJ1kKly5wIlNfXpDQizGl6SlOqn5hzVWf4VDraDQ+3LfbqrM
 lc1mkq1bNOArKueEAaWdypTNNM/SwsRiimglgVX9H+h0hRLpArw2Gq8f8KIOYLsmovuJ
 OyeCnw8IR7+BtQ78h5y6Q7wx8NYLJmC6ASnmXNORnw1BQaC6sbgQqXmwwW22ig5vi5NI
 g0rjPu5ykaLAmgXY9/+MIwiVHv7NFJFUTjf6ZN1BTaVBQCNcsA8NvE4D1qOQZOQqPpMO
 mkgWr7Si6ZzMAcyyOA3hU3kb3CPsVXCOatYJrEkakszFqTMksXlFfc1Nj2d50DcU7+nl
 1U7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=umvmDDY1FkvIo094HtO7DiL5pPHWkImB8dWtY33IdGQ=;
 b=OFdFxfP844mjuJtAMeS1xF5Z0qU5cQQ8ews4Gh0fEji28WNJNk6eifew+SUOn48Ilv
 N4ler01n7Ulugh530F6Hsa8sIp84KI/pFbHfHc9L2/gFKuJYcoNfajNd81hYld2mjqSd
 +E3OjyhR6uBOU1/w0Kvy5AaQ5IUbyGAsMDmqqM+JqyBFmHk9RFjJVDH0HCl4tNaK6Ost
 kTBE9XK/6pGkjbQU6vEzJLgbQYb7VUmLgVVIPFSCkt1Fjh6qsUw/buETffFgkuzWGEio
 uSttzLlA3WnImhi62Gnt0wmAVXLlF7VLZvC52w3qOVO/QgtJq+KOkdn9IVkRUwyoImxK
 BJNA==
X-Gm-Message-State: AOAM533eRz2+vk+XQ4PSOWnchIHcIFaesYIpebDEkFRlU9JTmXlTnGC1
 SdbbfX2bYo3oFCx6fm6Ov6bu6Q==
X-Google-Smtp-Source: ABdhPJzgG7YSMox/Lv6geezNZ+Nis08rSipaXwFIZRWAEJ9HrD4MH9lQwVEtkW/PCZxFhuTIig0X7Q==
X-Received: by 2002:a17:90a:9ea:: with SMTP id 97mr4858329pjo.8.1593111570316; 
 Thu, 25 Jun 2020 11:59:30 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u19sm25385540pfk.98.2020.06.25.11.59.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 11:59:29 -0700 (PDT)
Subject: Re: [PATCH v8 32/45] target/arm: Add arm_tlb_bti_gp
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-33-richard.henderson@linaro.org>
 <CAFEAcA9+-MoV23aFk_7fcWR29HUREbRt3qaDD59iPvSP2AMrew@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <103ac967-fd67-4261-e750-001107b793f9@linaro.org>
Date: Thu, 25 Jun 2020 11:59:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9+-MoV23aFk_7fcWR29HUREbRt3qaDD59iPvSP2AMrew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
Cc: david.spickett@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 5:29 AM, Peter Maydell wrote:
> On Tue, 23 Jun 2020 at 20:37, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Introduce an lvalue macro to wrap target_tlb_bit0.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> +/* Helper for the macros below, validating the argument type. */
>> +static inline MemTxAttrs *typecheck_memtxattrs(MemTxAttrs *x)
>> +{
>> +    return x;
>> +}
>> +
>> +/*
>> + * Lvalue macros for ARM TLB bits that we must cache in the TCG TLB.
>> + * Using these should be a bit more self-documenting than using the
>> + * generic target bits directly.
>> + */
>> +#define arm_tlb_bti_gp(x) (typecheck_memtxattrs(x)->target_tlb_bit0)
> 
> It seems unlikely that we wouldn't get a compile failure if
> we passed something other than a MemTxAttrs* to this macro,
> given the specificity of the field name, but I guess it
> gives us a less confusing compiler error ?

Yes, it's a quite clear error with the function.  But you're right, we could
probably get away without it.


r~

> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM
> 


