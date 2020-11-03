Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA6CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:15:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E1F21556
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J80ah+ZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E1F21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2ie-0006ot-7s
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:15:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka2hk-00064F-34
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:14:56 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41637)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka2hi-0004F1-Fs
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:14:55 -0500
Received: by mail-pl1-x642.google.com with SMTP id w11so9099614pll.8
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 12:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IM/mJ8oXmYjI6aL6FoMs9njfpz/pGeOj+YfkomKFktU=;
 b=J80ah+ZUbl6t7kmXJhzjEe673ZckBcNmSFhrZmD8zfjjdDLQYuDJPWaVW427fHhuRA
 iaNjjl+UF+Rm+xCDJlQ3ZZQVxM4DakJ8yMJXytMJtklZG1OeI6oWpAucNcF75pMBlv90
 NGtxc8JFfaccxHxcNU/zQj0eBn5r3EkPnlWGnkSKbMQum35imgLy29ovZarCZ1YG/FY9
 TVBvpdSfpyJYvZht6CkNDFzuCtXU/th+jiP1Lg+ZzSvsdrvWQZX81Y7CgKIAP/zhQbNE
 FeYgUUA7Abw4Dl6hBve1Y/rQ3G06Caeh4VpPdQP9g9d08zSd/wZ+n43oxo+beMJlSkOo
 BKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IM/mJ8oXmYjI6aL6FoMs9njfpz/pGeOj+YfkomKFktU=;
 b=MGOmheuyNDO2CCmdT/bpiAjYI7GgZmHKs7moSCeunx8bgTgC7M2T0ipPgjIs8ZeZ1a
 44DhrzPNCu55ZoMJ6FlTqhSToSvbnYXTqYzS9gzMiQB/nD9FActQWNt01MQVwiWTNS4d
 B8SmIE8T366gXBdZ/3k17t7roPQ2AHrXAjYaNMhBSdRKFXDEhIzmJ395DcXCngUC95iJ
 owNd9gymVpu8ZJ3J8L6pr6+hF2gqGIQZHJjtkP7ckSKVJArEcSIeZa+Vp7FLCrgr0IsO
 Z8wXkgvtqJ2VIv3K2TlS4tJ3U3Zoe6tzBmEz4Er5PhPSsXq/L5Q3EF7AjhRl55mzB97+
 5Zzg==
X-Gm-Message-State: AOAM53219R8HKv40eVVXk67rSoE89X0GzckISTy5IpEgqnkat/gPJ4EN
 u5hr2tCh25xfUiSB5U2XLqPctyn8sSrwbQ==
X-Google-Smtp-Source: ABdhPJwoiUMfagnuy/f2/3hG9FI4+UcaoAPi6re4GRI1SND6+8UQsf7zKcrX2wQiPTq4//J6IuMVVQ==
X-Received: by 2002:a17:902:423:b029:d5:f967:86fe with SMTP id
 32-20020a1709020423b02900d5f96786femr26459148ple.55.1604434492352; 
 Tue, 03 Nov 2020 12:14:52 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id e2sm16524333pgd.27.2020.11.03.12.14.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 12:14:51 -0800 (PST)
Subject: Re: [PATCH 13/14] target/arm: add ARMv8.4-SEL2 extension
To: remi.denis.courmont@huawei.com, qemu-arm@nongnu.org
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-13-remi.denis.courmont@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <88fad1a2-00a6-0a4d-1012-91ecfb45f4e4@linaro.org>
Date: Tue, 3 Nov 2020 12:14:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102105802.39332-13-remi.denis.courmont@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 2:58 AM, remi.denis.courmont@huawei.com wrote:
> From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> This adds handling for the SCR_EL3.EEL2 bit.
> 
> A translation block flag is added in A32 mode to route exceptions
> correctly from AArch32 S-EL1 to (AArch64) S-EL2.
> 
> Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  target/arm/cpu.c       |  2 +-
>  target/arm/cpu.h       | 11 ++++++++---
>  target/arm/helper.c    | 19 +++++++++++++++++--
>  target/arm/translate.c |  6 ++++--
>  target/arm/translate.h |  1 +
>  5 files changed, 31 insertions(+), 8 deletions(-)

Annoying that a new hflags bit is required, but I don't see a good way around that.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

