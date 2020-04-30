Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C2CC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:38:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962322070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r7KcguY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962322070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUE5B-0004vU-MB
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUDr7-0004kc-OM
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUDpG-0003ce-QS
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:24:17 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUDpG-0003cN-CZ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:22:22 -0400
Received: by mail-pf1-x443.google.com with SMTP id y25so209686pfn.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=Ygfm9oxNwSOADn+CgHwQbeVcclNfDyIrqVXEZYdB6ec=;
 b=r7KcguY8Yo3/HWB88rGM/t0SicTRGTB3u2w4m09OP3Q1fPhD4o95Kopm7P4oZQcf9n
 bLnnZ/wlH+NI5zBO2yFUIXXgWgConfvLqMxnfnIKfcjur0YSKIMiQmDUti/bF8ikotmW
 Ukrp0x5+6DJ59g9+5KihAerFokw4eS6AVrbUCzfFcwDqdItT7/NiwiTfqbSVDc5TeId5
 LZX157GpWp63k8HUb/rMGrnxmNG2qgdBr3SlPL8fDlFDSZXo01hxUP6Gwll3BIvjKNgf
 kGA1izpuRX6tK0HBx+uWtzrb1Qo3OTwdLCtsx2c169NhQ6SN8YQU2kXfuWL9iFZVScCE
 GazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ygfm9oxNwSOADn+CgHwQbeVcclNfDyIrqVXEZYdB6ec=;
 b=XF47PE4IWEabf4B4yuqXj8mmMhvicKwveaoutZUt55JPuVMIBsQZEZtPeheO9hGANl
 t9SK6s4XcQYwq6OV0G5i/qXWxk6z1uhFe5WJJegA6XZ1HuUlVeu8JztVZwuVv7JfJ8L7
 LglHKOIgonlmChnQv0/J6gg1VAZfAHVVH5vJnqSj2OKFurJMXtiy8XxFp94seHwDdY0l
 aqD8BaCabl8CQpchwBgBBXy7sbUJLfBtqWzajCSFmn/dNcW5ZPgawskskUtbuciW96v6
 pIDfvp4aqi3TlL/E9wsQpFMqTWLeq68hpC6Kq/o+cWqeZ9fQ9OPoIwJKUa93ObuoCsoS
 8HMA==
X-Gm-Message-State: AGi0PuZCH7Dz9DaW2KIpEcpcX0EpEYkzTGxL/GA4tfp0ad0CbFyXLErk
 dHneG7LCPkhyeS2Jo4QA6yTTehu3Vh8=
X-Google-Smtp-Source: APiQypJXn5FWBPi/Kwq/ByYmK8IQcRhsVbePknBeH/YiiEdN8hINdsUiWV/5zJIBxFgec1a55Ix4kA==
X-Received: by 2002:a63:8843:: with SMTP id l64mr167363pgd.443.1588270940530; 
 Thu, 30 Apr 2020 11:22:20 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id s145sm379716pgs.57.2020.04.30.11.22.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 11:22:19 -0700 (PDT)
Subject: Re: [PATCH 02/36] target/arm: Don't allow Thumb Neon insns without
 FEATURE_NEON
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a6f92d8c-fd91-420b-2db9-1202b4dd5edb@linaro.org>
Date: Thu, 30 Apr 2020 11:22:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::443
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 11:09 AM, Peter Maydell wrote:
> We were accidentally permitting decode of Thumb Neon insns even if
> the CPU didn't have the FEATURE_NEON bit set, because the feature
> check was being done before the call to disas_neon_data_insn() and
> disas_neon_ls_insn() in the Arm decoder but was omitted from the
> Thumb decoder.  Push the feature bit check down into the called
> functions so it is done for both Arm and Thumb encodings.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

