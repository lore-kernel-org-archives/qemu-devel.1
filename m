Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67497C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E304E221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K74eGAMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E304E221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWxI-0003QG-Rz
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLWvm-00020J-ID
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:29:26 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43029)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLWvk-0006jF-5P
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:29:26 -0400
Received: by mail-pf1-x441.google.com with SMTP id f18so346665pfa.10
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=UcCJmxxFEEgGDImcmNd8r+OcI9xOi1TmHq/v5lZLZU8=;
 b=K74eGAMp9zJqGlhnvjG5+QeLddVSH5tWE3/1bWo4zdAdjXnYilsDwfrtCrGXjV53BG
 Bjo43k8ktiNfQOlA8Ty+qylydUOiRsNOEVUT5dG5EFdvzQrN5yt3vHWSwMnUguxi7E6T
 s/FYkMj5P911A1fjLvRP63fe7Ql5n/8Pc/eY75/HNazdDMj68UoWPCyROhlAIEAscvVc
 arf3iajLfBS/8NUzc18d+v0k90vIfmEjk4+64mitd6uJDi9jYZ1SEmr+CGdOMeDOs/Rk
 f08ApzzuT7SSAHtTtZQ/e3oNx5E+rocUtj9zmJk7gQoJS2Zm+ioJmS2SZArhnCJuXdXU
 x0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UcCJmxxFEEgGDImcmNd8r+OcI9xOi1TmHq/v5lZLZU8=;
 b=rLrF6Dhc1CG0oEOc0ryR2c3v9nIjvc19SFJP+bfJltrbH6Y62OMkTK6SklgA2uC+/L
 ouvGNpdt/oX3jWRDFGN327ccP0tlG2EaLqf0i+mD29JWjbSROgAvrP50r8GlWS2Xt/C9
 oMz73oUV/Q6DBX8qyOofLuOEWatzR/1Kh2vFuAOWl9WXO7+9KCrrAiNsAWSajGkILOp8
 agSnb54Q68rz2gfc+VReZLyhNR53Ti3QW/zu/gldmdCjYFFnYfNM5rAXeYY8AigAa9HJ
 C1Rk0h5otYHV3DB+vume4KpNvcTUcwvfWe3dV64A1W9zNo6OlFw9H2VUzLpf1On260f9
 jZKA==
X-Gm-Message-State: AOAM530wDXB1yK+arI1FVpR5QJDaD15kqgCcfL1qE/HWzBGC6fqBZVOZ
 M/0kZgLEPDQaE9k484S7yK3MBy2Qg+VPmA==
X-Google-Smtp-Source: ABdhPJyFg6V7eYKwaoWSNyaCydGsdBSjvo3RSO4AwD9C3x4T7YG+yw+cDrLZkEpKx7NYQkX17Mz9mw==
X-Received: by 2002:a63:5966:: with SMTP id j38mr489294pgm.187.1600975762604; 
 Thu, 24 Sep 2020 12:29:22 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id i2sm261853pfq.89.2020.09.24.12.29.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 12:29:21 -0700 (PDT)
Subject: Re: [PATCH 3/4] qemu/bswap: Replace bswapXXs() by compiler
 __builtin_bswap()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200923100220.674903-1-philmd@redhat.com>
 <20200923100220.674903-4-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7365d69b-3437-18df-cd6d-70032708e7ab@linaro.org>
Date: Thu, 24 Sep 2020 12:29:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923100220.674903-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.214,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 3:02 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/qemu/bswap.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

