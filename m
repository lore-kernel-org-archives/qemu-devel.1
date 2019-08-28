Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4086DC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 21:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006F32077B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 21:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hdf2Jq3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006F32077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i35Fl-0007HW-3r
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 17:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i35Ex-0006fc-4N
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i35Eu-0002Vi-U7
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:12:26 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i35Er-0002SU-Px
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:12:22 -0400
Received: by mail-pg1-x543.google.com with SMTP id u17so370775pgi.6
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 14:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mxFK9Jg6tc1xBJM545UmyeNtwpYh5rHWr5WX30nzQsM=;
 b=Hdf2Jq3w3beOUQn4NLrl3lmXAlm9mNh2U6rpeVIwtibJMb7A2VzXkTkJLuOZ11QaCR
 kQEELY3hJVnLEk2/JXXTlpbysEQ5h1dpHS1OzyIai2MXw+Z6E3L+R71cQkOMFpWS6jJ/
 UAnuZn0xRzfy1ejqh/OxDP9zeo51PPOBkCRjChqJPFoeQBSXtJZJaaLugIf7OyFgeS+R
 kmhgzoQCgFEqh//zhABNUzCEkNCtPhUMDYierhcMmMzUJyCnzXsOpiHxexwgimY008Hn
 vMab3bIsp1sGS7+4qMOZW7mKOveXOshgw3pK+PFfvMxIIIxSNmqTT9rBfduG3fVn7K2U
 sRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mxFK9Jg6tc1xBJM545UmyeNtwpYh5rHWr5WX30nzQsM=;
 b=gvaKeke4uohPo8mDS18vt/3Jv42nmj6La1gOR+2km9zG+EccbLYMQH3LJYk58aKX6W
 1K+t0ejSiqnyEAztfplpNPHA9RKif1XRc/VHg62NqEZx8xkmUp/ZNBWUTzED3xmVgYgi
 l/WP30SblF0+Wu0IJz/QPa6frxiPpwGehuGUVCaJphGt+ntU4myHwSajnwcbG/CJWTq5
 QXC73p/phzHZoBJd2TLP+OBVZZWdr9PCNVcaDXsbLNHYERLv2Sztcz/aB5gBV9f6y/bM
 LxYKF+7DYIVMd2N/Ge5JNM7tHF1qWefUxdMniRw+Hod9BGcplJOzuA9A4TzuRFIl6cQc
 xBPA==
X-Gm-Message-State: APjAAAV3AyvSnjEftPNOJ0W/x0Rz7CqDbn7WJJq6yPGl7vwQpKEb9jfL
 2zwq218Vfz0HDP4GNzQ8AJHC1g==
X-Google-Smtp-Source: APXvYqwkq2YMStdsa8bM5S4tRjBO67CZbeKpTydKac1gTOa3Ta9IBo4g0tUQf9qXnJb2NBGnxbloLw==
X-Received: by 2002:a17:90a:d793:: with SMTP id
 z19mr6194069pju.36.1567026740557; 
 Wed, 28 Aug 2019 14:12:20 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v145sm324772pfc.31.2019.08.28.14.12.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Aug 2019 14:12:19 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190828165307.18321-1-alex.bennee@linaro.org>
 <20190828165307.18321-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a46f7e41-ce51-e467-859c-eacbc64b4568@linaro.org>
Date: Wed, 28 Aug 2019 14:12:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828165307.18321-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v1 4/9] target/arm: remove run time
 semihosting checks
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/28/19 9:53 AM, Alex Bennée wrote:
> Now we do all our checking and use a common EXCP_SEMIHOST for
> semihosting operations we can make helper code a lot simpler.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - fix re-base conflicts
>   - hoist EXCP_SEMIHOST check
>   - comment cleanups
> v5
>   - move CONFIG_TCG ifdefs
> ---
>  target/arm/helper.c | 96 +++++++++++----------------------------------
>  1 file changed, 22 insertions(+), 74 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

