Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18583C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 19:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D766E2186A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 19:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gi21hO0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D766E2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2hGJ-0002kj-34
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 15:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2hFX-0002Db-Ue
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 15:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2hFW-0001yV-Nl
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 15:35:27 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41386)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2hFW-0001xj-Ft
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 15:35:26 -0400
Received: by mail-pf1-x441.google.com with SMTP id 196so53288pfz.8
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 12:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LgmYJGuKyvRITK3AxYduGqwnzcFbhxsbLaPWl/PUSW4=;
 b=gi21hO0UQEl7J1/BrDbJ2nIZLidrZnWBGhWJz+SGsNC2KsNt0wWCewtsKu+2x/QQKk
 ylzJZ/B68WeKa6GQZRMPAMDSIEFjVJPHuj5aky4e/+/FCLxUeYqo+4BjxGYZ4FMrI/xH
 M0TAETPc0tyjnBd2czsnjRTJ/UtiXA47mh6EIgIqbBcQaheOVV7Iokdc+j55zCA2WGUg
 XAd2RSD4m9aPXal08zCv21Gj4P/p91DnGW2YnOIFEn73ma6elLJQH+5340hYbHKNL4jV
 7O85BtyofJG3eAWelxvYT8mfpvp7FlUHGidyP7JDVZTRRBraapkpfGKKlAMo470TeeQP
 2qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LgmYJGuKyvRITK3AxYduGqwnzcFbhxsbLaPWl/PUSW4=;
 b=eXAI99DWkX/mPPlOtPoKT3doFnp6AwnfiuKQHKGbecYwvGr/LPmgBtXtgUDXFeD35N
 9W0PBIkQLSqMnYxToZJLx6SN1XP/TxhZK5ktCYk4RXfB9gpy1jbuGXLOz/r6vsffIlD+
 B3QRS68tYyR6d+pgvI8Vt2ejlVuPyZPXg1xQvwJOD8822BKYY4Yp8lzSOmCsLZ8r7a5Y
 yC87moCzed3VNW9BzbpKJVCsmuXmbpB966wI/a86LiIHsQIwNYqRktptDTWhSXSZD7dw
 UWqxZsJAnSKsGniS5zdJB73U0WWJXSZCyr21Jmm6LO3Kl6kphSvjRUN7zPoFea1YIxJ3
 mSsA==
X-Gm-Message-State: APjAAAWeCcZxAUJTSLQh4eYhjkncAPuqip7XLI7nUNotot9MLAKMLEIX
 +wXES4LpH6w3kn4tLmR4d42bDA==
X-Google-Smtp-Source: APXvYqztZlEc1p+W++ghXYynFP9iUBFeH7QNmUqG+0K8keyeHSIuQ42cskTB1f5vx0/DhxMDAQ4huQ==
X-Received: by 2002:a17:90a:c70e:: with SMTP id
 o14mr374918pjt.56.1566934525055; 
 Tue, 27 Aug 2019 12:35:25 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id p8sm92295pfq.129.2019.08.27.12.35.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Aug 2019 12:35:24 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-22-richard.henderson@linaro.org>
 <CAFEAcA8saD6zkOA7-6nF5jQBMgKPLv0L3WXV2m0Y4WtHwVqWgw@mail.gmail.com>
 <CAFEAcA-PG1Jd2F-DLp7yKQest3aWqb3pv4FjUB9movDf4VgWgA@mail.gmail.com>
 <CAFEAcA82Y7xNbGB4BioUJ4G7kx5MT5TorF3HoRmKTqaE1eC2Qg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <82cd77dc-02b8-879f-8f33-37cc3fa9a19f@linaro.org>
Date: Tue, 27 Aug 2019 12:35:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA82Y7xNbGB4BioUJ4G7kx5MT5TorF3HoRmKTqaE1eC2Qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2 21/68] target/arm: Convert
 Synchronization primitives
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

On 8/27/19 4:10 AM, Peter Maydell wrote:
> On Tue, 27 Aug 2019 at 11:46, Peter Maydell <peter.maydell@linaro.org> wrote:
>> ...OK, not this specific function, as I just noticed it's the _a32
>> one, but trans_STREXB(), trans_STREXH(), etc are wrong.
> 
> I did a quick grep through for places checking the 6K condition,
> and I think these are the only ones that need changing:
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index b4d53f3d37f..58e50f2d808 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8874,7 +8874,7 @@ static bool trans_STREXD_t32(DisasContext *s,
> arg_STREX *a)
> 
>  static bool trans_STREXB(DisasContext *s, arg_STREX *a)
>  {
> -    if (!ENABLE_ARCH_6K) {
> +    if (!ENABLE_ARCH_6K && !arm_dc_feature(s, ARM_FEATURE_M)) {

Looking again, I think the correct test is

    if (s->thumb ? !ENABLE_ARCH_7 : !ENABLE_ARCH_6K)

for all of these.


r~

