Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCA4C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:43:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7BE222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xe15s8Yi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7BE222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2hoE-0004ao-4w
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 15:43:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2hnV-0003VC-1t
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2hnT-0004P6-PB
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:42:48 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38318)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2hnT-0004Nq-HE
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:42:47 -0500
Received: by mail-pf1-x442.google.com with SMTP id x185so5423225pfc.5
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 12:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nhkMNBW0bxRzxSpI2XDdakWc/nTIcuwk54Ob4SmsKfY=;
 b=xe15s8YivFux/VPWDSVB3Wu7Cit3rO1+jtky8q/G6AKXeCgvKjzW33hMx/irfaO1x3
 yUpUYCOvfh5Je66hX2cjqFdu7uYUDADpHT+uTEKJye0oQTODYh3KV509tCl3MCXE467V
 ZMtD2w9ZM0fnWTdzVOqirRJQI/inalPkpWFSi7kJPArqhsHEgwHyK6zTcZ31cEoyjVkD
 V4N0M/dvVP593IEJ1GwteXXm9s2RkCXRgu85dgcotdt7USiv1lBvqPgKsdUBWkzIBQOn
 3A2gR5MPkEbTT0bOF2hUzuuoP0vt/cuOfHLhPoFWuhUV0wScApfavLPXubza9OAu0Wt3
 mRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nhkMNBW0bxRzxSpI2XDdakWc/nTIcuwk54Ob4SmsKfY=;
 b=h3mpCeH4d1qWSRkALSWAJw7K9aC/4NuV8QTfINCIcp7dBwT+wgEpxQl79Bf/5Hqs8C
 PBcPVXyK+TixReLbSfnG3d/J2spKioMKMi9Q6KyUKLKT4cgd+4iUGXt/lI8/6mtWzkfr
 g7kGlFYWXgpTAxiDWBHMJwbpufvjZzaxmSMSPo1ayrwZzrC/LJgO/ZbW/Yl5A3w6H3mX
 fOnvfHkAfgVPr62ZDSp+m+nTUw6R3nLfdBw1F0q5BYxlEFq4PSouNzmrh3tihCJQ5bOW
 FaJhAJvS5PyGrOKyZwbsXTMxQh2kWYd5K/J8pkcyHOul3e6MW1ed0MnOBVRkT/p2EjGk
 AcLw==
X-Gm-Message-State: APjAAAVBy7K2TUUiQ4ZtCIrjm2tXhWuclCFQX2Bj6m50wH4tIbfpfDNL
 ge5Ga4EKDgEMN8wBju7yx8Ug2w==
X-Google-Smtp-Source: APXvYqx/AZYx5BZYioEBDOyj9pmjrylpmWVVjHRtVqmNrItQsvF2u8Qm9BsSCLoHaZySeHw16Yfk0g==
X-Received: by 2002:a63:cd03:: with SMTP id i3mr5548150pgg.257.1581712966289; 
 Fri, 14 Feb 2020 12:42:46 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z16sm7818157pff.125.2020.02.14.12.42.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 12:42:45 -0800 (PST)
Subject: Re: [PATCH v2 21/21] target/arm: Correctly implement ACTLR2, HACTLR2
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200214175116.9164-1-peter.maydell@linaro.org>
 <20200214175116.9164-22-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <14cff2f3-a832-1018-4f1f-23ae889500f1@linaro.org>
Date: Fri, 14 Feb 2020 12:42:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214175116.9164-22-peter.maydell@linaro.org>
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 9:51 AM, Peter Maydell wrote:
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index c46bb5a5c09..9f618e120aa 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2718,6 +2718,7 @@ static void arm_max_initfn(Object *obj)
>  
>              t = cpu->isar.id_mmfr4;
>              t = FIELD_DP32(t, ID_MMFR4, HPDS, 1); /* AA32HPD */
> +            t = FIELD_DP32(t, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
>              cpu->isar.id_mmfr4 = t;
>          }
>  #endif
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 8430d432943..32cf8ee98b0 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -703,6 +703,10 @@ static void aarch64_max_initfn(Object *obj)
>          u = FIELD_DP32(u, ID_MMFR3, PAN, 2); /* ATS1E1 */
>          cpu->isar.id_mmfr3 = u;
>  
> +        u = cpu->isar.id_mmfr4;
> +        u = FIELD_DP32(u, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 implemented */
> +        cpu->isar.id_mmfr4 = u;

This highlights a missing set of HPDS for cpu64 max.

Saying "implemented" is somewhat redundant.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

