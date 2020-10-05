Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76392C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D772068D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdazxZEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D772068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPUJv-0002MN-1e
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 13:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kPUIR-0001Xe-PL
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 13:29:11 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kPUIO-0005yE-KK
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 13:29:11 -0400
Received: by mail-oi1-x241.google.com with SMTP id m7so9491365oie.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 10:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4mHg2Ci1alEGDr2iGLZE41VlsFr6DH7vrOJ70TBFWb4=;
 b=KdazxZEQ+UGG6NMWvJgUTiP/NnMDOkJOGUJzm4mnlOcVLSStcUz48Xr5AUoHVnxSKw
 j+zPa6Ph73ZrI6GHsDV6d/jEfkXt/ICluzhjUghw9ajSQw25BUcTEprIhMlafOYWXrki
 NvUiHT6mW+ufk7yRaCRHYngYwgfHDuPpjOzbmc4bt6ytef3vzrrXDVV/cvVrtIRdupdV
 Cjz19LSVA1M4pIBt9OvjI0U9gJCTwqOv2EcnL+OrwaNH8rGI3U++uLYn8DUDTekFoHZt
 9ykaV2uxlbIuQ2n0DRWkKIlDQh9mg3GVOPDqPIqi7KjL/9PLtPRBVqvEyv3+XrqHQWZZ
 TLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4mHg2Ci1alEGDr2iGLZE41VlsFr6DH7vrOJ70TBFWb4=;
 b=bOg34FTEEol4VtazhyQ+hLFIkJ4KsSHj3EHGKRJ1Hpvs02B6NiPp7jPUaTFEaS7CaM
 OGXEyHB0xvxf0Xxz4VbTeqCt4dFo2MTOlsEIucTmkE0gSuSmqBZCTyxT8srMYEUYjPw/
 dAb+CvCxSdqvRAaFJpS49ge3qPVNNaNIzHfEvEj/sQnBaM123a32icrB5iCTjMBIvyQD
 AVSiREmOuDcUKhm1R18HMU5JBskePsaK6p+Zo71CUr0usJMhfiG4sSxsgFvChZUes8iG
 CpP46uImbvGFA4HrC2UAVdDPrwwFy1pdYnml6HsKIiBaNlFXyinnAwXGU2U+QXGcw79b
 C1NA==
X-Gm-Message-State: AOAM5322LLxFWxpve+S+loRcFYhpZLZ1KaP3qbsx2qBbCo4bW/WruLPH
 CWMQmjZkKUlarKL4Ak9eFBIaQ+rubOiXP7Tk
X-Google-Smtp-Source: ABdhPJzm/R8Rnc2pEpMtirDaXVhAX0PGJyZtFSMDSYu6uvmmhZ0t/oiAlTjk7My1X9zBmfXXT9+LfA==
X-Received: by 2002:aca:f5cf:: with SMTP id t198mr284239oih.22.1601918947166; 
 Mon, 05 Oct 2020 10:29:07 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id j21sm102268otq.18.2020.10.05.10.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 10:29:06 -0700 (PDT)
Subject: Re: [PATCH] tests/tcg/linux-test: Adjust getsockname for musl
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20201005165850.88425-1-richard.henderson@linaro.org>
Message-ID: <0dc7d3b3-b341-12ea-9d68-6bd2bcc80a5c@linaro.org>
Date: Mon, 5 Oct 2020 12:29:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201005165850.88425-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 11:58 AM, Richard Henderson wrote:
> Unlike glibc, musl does not use transparent unions to hide
> the different structures that overlap struct sockaddr.
> 
> Add an explicit cast to work around this.


Bah.  I meant to point out that this affects our microblaze docker cross-compile.


r~

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/tcg/multiarch/linux-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
> index 8a7c15cd31..96bbad5823 100644
> --- a/tests/tcg/multiarch/linux-test.c
> +++ b/tests/tcg/multiarch/linux-test.c
> @@ -296,7 +296,7 @@ static void test_socket(void)
>      server_fd = server_socket();
>      /* find out what port we got */
>      socklen = sizeof(server_addr);
> -    ret = getsockname(server_fd, &server_addr, &socklen);
> +    ret = getsockname(server_fd, (struct sockaddr *)&server_addr, &socklen);
>      chk_error(ret);
>      server_port = ntohs(server_addr.sin_port);
>  
> 


