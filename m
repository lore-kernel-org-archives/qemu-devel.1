Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93280C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB8D206D8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uOwUIQIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB8D206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0p4j-0000XC-Mm
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 12:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k0p4A-0008Un-Dp
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:36:30 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k0p47-0005fE-RG
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:36:30 -0400
Received: by mail-pf1-x444.google.com with SMTP id l2so6871002pff.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 09:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CETG/Mg4aOP5rC0UTTlz0iuGxeBBWpoxGioEZ4P1rHA=;
 b=uOwUIQIP8k4lvX0LScXKAU/eLnmkT01QEi5A7wcv7c+Ryb1h4c2Pyg+kw4oLPPr9kS
 1I1Ij9mz+EBOZqgZo6fPs3vZj3cvBr8gVWpBEt1olacAFXCKng54C3FnwluR+jFso5Kt
 u2dl6FbCp0ywC6wPBdafXziN6VDgqDQl3j2qhjgbGGS7pLWPUNtlEf1g/JvOErPFzcaX
 FvHA6KSVOfWeZXvZgq+d2rchxVpNgk3tIyXaXrHxRhn5vTV3dBvcrzqcAZHumDHZ0R1m
 PiOIk5elz6thwD8T+o/JtCoC/Hxg9GKyVVaVWALSpigDsh9s59h6puyOx6Uakrnr0Bx1
 OZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CETG/Mg4aOP5rC0UTTlz0iuGxeBBWpoxGioEZ4P1rHA=;
 b=Nzw7qFqEcqQ/BK6R9DKI+d+YOuufv42LTqrk0k2YsjufFwzPJFSxeBAzAi50QyVXcN
 BDkjVxgCHDoZb82IwzHMxgj4m2pzawTpqJL3Aqh8XuGxYcy/txa5PFLJrknF/q5FDlCm
 MmesQiZ803t/dvGhHJRLlSYsPgcokBOCgszcM+LjF2rVyipQMs9OBqXajpLFIA75Hn6C
 L9bUdMmHKVCa3/eBuIVEMFzLtkTKCMC//LBJxIyp6dLmYJjxGdNvIozB6/+65FXfXsBb
 jtAR3OEQej8VCu01kJkh9fFpozsTyjX0LGKchPLyirGPuvGJMQ1MrBAUyhTIjXVt+nDQ
 +2Uw==
X-Gm-Message-State: AOAM533Qz62qiGjme1AxudRqaIMSnZo7x75Q04WSeHb3oMlKyDlOuBd0
 cw9bLsOqfWv2It1oJGuW2IZCpw==
X-Google-Smtp-Source: ABdhPJxDhh+sLW7i5xoruCG+3z8OcOWVevI/1FxtSONZyWPrx1JkTBQHPXaCUpNtnWyjX7QPzBuPkg==
X-Received: by 2002:a62:758f:: with SMTP id
 q137mr11546915pfc.170.1596040586284; 
 Wed, 29 Jul 2020 09:36:26 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x66sm2939143pgb.12.2020.07.29.09.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 09:36:25 -0700 (PDT)
Subject: Re: [PATCH 1/4] hw/hppa: Sync hppa_hardware.h file with SeaBIOS
 sources
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200727214608.32710-1-deller@gmx.de>
 <20200727214608.32710-2-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <992950ab-eead-4e40-e7d7-bcd5aa31f8ea@linaro.org>
Date: Wed, 29 Jul 2020 09:36:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727214608.32710-2-deller@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/27/20 2:46 PM, Helge Deller wrote:
> The hppa_hardware.h file is shared with SeaBIOS. Sync it.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  hw/hppa/hppa_hardware.h | 6 ++++++
>  hw/hppa/lasi.c          | 2 --
>  2 files changed, 6 insertions(+), 2 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

