Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ABAC43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 02:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A2E206E6
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 02:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BtspaEU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A2E206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jI0o8-0006cK-3I
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 22:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jI0nN-00060b-U9
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 22:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jI0nM-0006dy-Tz
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 22:01:57 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jI0nL-0006bS-QZ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 22:01:55 -0400
Received: by mail-pf1-x444.google.com with SMTP id z65so5415375pfz.8
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 19:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XhkrqERYM66hQXMFb4eWY0qYYAZ1ohsS01hNjUa42vA=;
 b=BtspaEU9oSw2HDKXofrU3YI4rNqAXLrRv2nKI8MYCWsun0cTg48yrpfbiAh30JHOur
 xLLAZ6hPikaDUktSzGOlOo3EeqaY+eQTEI69scq7tlYX10iB2RejjA1y9vIkKvWlvaCY
 4zxCpU1zU6KzLgqrYz30MsO2H71yibeIBuHIRjMHM9q0p+BmrCjxdQAmVKSqChGHLtMj
 fjLcxXT/kCROizUwuqyFPNADYo4qbg1C9T7nteYUHFOYS6FfYZ58XSFTF9+kpvcbGbyx
 8sNhhxBdxjOqFLAdae0VEioPsIiSNCkaDZMhpp295TuI2nMxHrbdU7oUL4Qxq8I1CpZV
 en9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XhkrqERYM66hQXMFb4eWY0qYYAZ1ohsS01hNjUa42vA=;
 b=q9efhwihGx9CwB1JdwgKd/f0+Tij4jNaCA96xYnT0zsxf27uXDUV5/askdKGOW/krl
 m8nfKtgMgFe0y9gtgd28ME5phxrLhQK2D/UovS9QPJrigRA+tGvzq2p9d1D5U2npk7Dh
 ZkFTMwJhN+cWh0+qx2+Sy5YXnTH62vL7nCCOLMLRKIfwKE7RoSZNVSfMEB5LcF11zPYv
 NO65O5jiMgMeJej/HtqQSX4lnnKSQhcwOhCqJqVMU8W2C49WRzBMO0SxFZZfYfExjStG
 z3v0v0vgVgwZ+7xu0icqLySZCLipsZCypfycs/RHA/P8dOyjB6xPqne3wEFaGgK4vMUE
 HTDQ==
X-Gm-Message-State: ANhLgQ2Ow6PhkrZ2JawhsaZjeOxwqk22sRLVgsb1LopjAIa1BKt9QZ5Z
 1miy2dZaeL//5pRsCw3s7aWBsg==
X-Google-Smtp-Source: ADFU+vuv3Gnl8kYQ67/6cGkpBrDoW9k1snyqCx04MtyJYv/nEkjwk658bQqOPIlO8BLoNFZ1mG/mWg==
X-Received: by 2002:a63:6f0c:: with SMTP id k12mr2292861pgc.142.1585360912858; 
 Fri, 27 Mar 2020 19:01:52 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id q12sm5140131pfs.48.2020.03.27.19.01.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 19:01:51 -0700 (PDT)
Subject: Re: [PATCH v6 39/61] target/riscv: vector floating-point compare
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-40-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8d8cc289-db4e-875d-fd60-71d5471b0d38@linaro.org>
Date: Fri, 27 Mar 2020 19:01:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317150653.9008-40-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 8:06 AM, LIU Zhiwei wrote:
> +static uint8_t vmfne16(uint16_t a, uint16_t b, float_status *s)
> +{
> +    int compare = float16_compare_quiet(a, b, s);
> +    return compare != float_relation_equal &&
> +           compare != float_relation_unordered;
> +}
> +
> +static uint8_t vmfne32(uint32_t a, uint32_t b, float_status *s)
> +{
> +    int compare = float32_compare_quiet(a, b, s);
> +    return compare != float_relation_equal &&
> +           compare != float_relation_unordered;
> +}
> +
> +static uint8_t vmfne64(uint64_t a, uint64_t b, float_status *s)
> +{
> +    int compare = float64_compare_quiet(a, b, s);
> +    return compare != float_relation_equal &&
> +           compare != float_relation_unordered;
> +}

This is incorrect -- the result should be true for unordered.  The text for
0.7.1 does not specify, but this is the normal interpretation of NE.  The text
for 0.8 explicitly says that the result is 1 for NaN.


r~

