Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB75C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C590206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BY09/5/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C590206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsHz-0006df-NU
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDs5F-00073Y-Ht
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:27:33 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDs5D-0002FU-15
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:27:33 -0400
Received: by mail-pg1-x541.google.com with SMTP id e33so2568145pgm.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 09:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=lGt5WOoKaqmjrp/JJYW9gqO+hdcusqmlblBLiycqA9w=;
 b=BY09/5/EfOH2wqOzTo6adnbimslBEQ41P8mGuPllBYl8QO/HcwQkqNyaLLmF/GiYDr
 HY7syDuNbZsnLdBH8SudqsHxsiyFxOTogb+Crpi4IEtxZ5oCzevHsOrRa7ZIUWmcl68g
 gFUsp1RNifxYE9KtxzqBiirBIBZOaEfT+NRbBxfGCEthwG2xAhG14KxMxGTjRPIRPQ8V
 6CxiF1P6srxWJ/jEK025EtlIpYnywQwVShhsv1YsNT1FgsmSF/utROvQcC9nSHtzs/DK
 ltmcxjmwqlWZtZIhsibUYDVzRXtjH+aPX9ws21BPK1KCd+Ju0t8mxRJNQcpI8+VDfnwG
 iJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lGt5WOoKaqmjrp/JJYW9gqO+hdcusqmlblBLiycqA9w=;
 b=DeQDUKn0tyvF3I0ml1y98p6fv17z5Fs+tBEW7Z8ewsLqucjcFnh3uPmGZPrbq71aHr
 KDdcdn3b0OkjXu5K3ua8W1OtF/DRjCUuXt6QSFBoe6h4F9g5lolvD71BNBLKWmTtW658
 sEmrzEzkvsQlrA4lNW89RkUoHr2WP/QHIT9w0RnM8qFPONqbnDDdCWHmcTzXudjvokWs
 MhTM4lwKL5ID/2ZdnoZiEIDt2pnOD/eW5gDKwbWT+2SuecJMaUKQxOvU6xw6/0b9o+Fl
 kUEQVehseFOq/awoxFVHvv4PN/we16KX5MGBE9nQsetjlv37kk64hhNj+oGz6G1tXriv
 wKdQ==
X-Gm-Message-State: AOAM531ZDF6trd8vVEQlwrbJOSXYD+lUHfeiX9ji799jRvzHjafmj8Zd
 HpP9yL6XKPKDu1UiKz8ZV6MAcO452nv9Dg==
X-Google-Smtp-Source: ABdhPJxJgnxgO4jHXpw7DUxSWWnPNDxH3MOl8d8YaMGfB05lyK0R7XXI/Vnf8i0hPlK7qwthdmpMCA==
X-Received: by 2002:a62:e404:: with SMTP id r4mr4431189pfh.213.1599150449467; 
 Thu, 03 Sep 2020 09:27:29 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id e18sm3233290pgr.53.2020.09.03.09.27.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 09:27:28 -0700 (PDT)
Subject: Re: [PATCH 2/3] target/arm: Convert Neon VCVT fp size field to MO_*
 in decode
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200903133209.5141-1-peter.maydell@linaro.org>
 <20200903133209.5141-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4302c192-fe8d-679a-aa7b-08c604bbbc13@linaro.org>
Date: Thu, 3 Sep 2020 09:27:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903133209.5141-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.403,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 6:32 AM, Peter Maydell wrote:
> Convert the insns using the 2reg_vcvt and 2reg_vcvt_f16 formats
> to pass the size through to the trans function as a MO_* value
> rather than the '0==f32, 1==f16' used in the fp 3-same encodings.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       | 3 +--
>  target/arm/translate-neon.c.inc | 4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

