Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EA5C56202
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 05:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D0620720
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 05:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TRa/SZrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D0620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYNKg-00016X-8Y
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 01:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYNJb-0000YV-Gu
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 01:51:07 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYNJW-0002Y5-Uw
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 01:51:07 -0400
Received: by mail-pf1-x444.google.com with SMTP id 13so4324842pfy.4
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 22:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=O7acSnAlvapnus1R91XjuiTGjEbPamfaAD1/OSk1Q9I=;
 b=TRa/SZrP90DcoxkI/qxIFj1hoTGe6lC5M4rKmDPI6+cD+haiqGt9F/zftL/RUl0aTz
 gCjdkaWsVzK8bNrBPN2BlcPH06wHuWYn1vbMqYBIzfa3ENdn901qJ6SAej1DnBBsYoQQ
 dGYcfpoH7evMyQaRkIeAKzvGPk+ufmcsWoFvlCP3+3JA+Pcx8Erp0je9Kq5CiP8VcH0m
 V0KSRaYegdzW0e5VIyHXVcgo/IG9c9ulQCCtxikuShfnfIeTN1BoFIAKPAsuSWuDvYc3
 at7lPdZ3VW2TLMmNyj+sMJpv4qu60SAcgvkaiw2k9vjvq7m1Ogf7Mpk889v4QjMrSElz
 Fp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O7acSnAlvapnus1R91XjuiTGjEbPamfaAD1/OSk1Q9I=;
 b=s6LW3adGkmGvgUD2YL+lDYj4Jvn0gz/8SsYJRPvlKZwQSeTdJbTQz8ZRkxD7vD9Rp1
 6pviPLIqTBi9BAgzAxuSjACJhpbQrEI5uVTWoIsIHrIo53l6rBENhKNzYfRLSMBbVe9x
 ThmougbWanXSvPAaH52gMQGR8iqlg7TSdUi+bQrJfXTsVCMxaw1ZguQnn6kDBj9w9R5W
 Drc3Z1Fjcchy7JaWFhaviNthA17dfRcMBEUNQ3AAvdOFIWgPqd0N/BpM5GPE59Z0+VQv
 sLZtV3DKV/KmKxYIqMqI9kWAUl8d9KCmYf4R9F6G8Bfw11JXcsHJf/lWJO5HRp1LhncA
 mZ1w==
X-Gm-Message-State: AOAM530nR4DoPSNSkSHMPtBTZsxZVGhqy81Rynj5XLPTM1vmy8I6oy+F
 JBK5D1jumyh+Qgk0iVShvZRH0A==
X-Google-Smtp-Source: ABdhPJymNL8adJGANOnn96YyLpPChvi5Bn1qdNhgZvT3GjqqChJcMqbAMxmiZ7iDyQ8x6GHSIoYs1Q==
X-Received: by 2002:a65:52cb:: with SMTP id z11mr782893pgp.368.1604037061261; 
 Thu, 29 Oct 2020 22:51:01 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 11sm4353133pgd.24.2020.10.29.22.51.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 22:51:00 -0700 (PDT)
Subject: Re: [PATCH v2 3/8] accel/tcg/user-exec: silence the compiler warnings
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20201030004046.2191790-1-kuhn.chenqun@huawei.com>
 <20201030004046.2191790-4-kuhn.chenqun@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <84c34163-d177-be21-ef7d-85f5428e3c0e@linaro.org>
Date: Thu, 29 Oct 2020 22:50:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030004046.2191790-4-kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.261,
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
Cc: Thomas Huth <thuth@redhat.com>, zhang.zhanghailiang@huawei.com,
 Riku Voipio <riku.voipio@iki.fi>, ganqixin@huawei.com,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/20 5:40 PM, Chen Qun wrote:
> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
> ../accel/tcg/user-exec.c: In function ‘handle_cpu_signal’:
> ../accel/tcg/user-exec.c:169:13: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   169 |             cpu_exit_tb_from_sighandler(cpu, old_set);
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../accel/tcg/user-exec.c:172:9: note: here
>   172 |         default:
> 
> Mark the cpu_exit_tb_from_sighandler() function with QEMU_NORETURN to fix it.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> v1->v2: Add QEMU_NORETURN to cpu_exit_tb_from_sighandler() function
> to avoid the compiler warnings(Base on Thomas's and Richard's comments).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

