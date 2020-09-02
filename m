Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E7BC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 20:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2544207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 20:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZRoKwIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2544207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDZdl-0007Ti-QS
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 16:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDZcf-0006sg-BC
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 16:44:50 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:36199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDZcc-0002ud-CK
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 16:44:48 -0400
Received: by mail-pj1-x1044.google.com with SMTP id q1so367735pjd.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NHU1jhW3iOUwoJm8860OfOqXAOOUWBUJeZMk47ei+ec=;
 b=LZRoKwINrDbSV3fMBrju7jOzXerVyjW3O3sqMGvCejh6tzIYxmUJmZ2Mc2GVLB261D
 HgluOkwcuoIUugeiBMJv/CuOIWPN/XDFw0g0ujTnYU36TsTFUdFMru/TX2jli0WALZGX
 W3AA7pGxxoHhtU66FvgoYCZAwgb0mAvTRYhpxviUqCzgdpMghN0K5JlT/BGf8C9e+GgL
 L/Vz0kgV8u3KFS3Z0/hgf8HpqI5HHupSloQK/2q8/5SsGNssIS8QcD6ou7JrBHuO2vH0
 mxl0WLqIw30IAnhkjq34+8H++yvwJSjL62KtggM7PqXmDuQfaX4OU/SSJ1zXjUdSBDvW
 bPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NHU1jhW3iOUwoJm8860OfOqXAOOUWBUJeZMk47ei+ec=;
 b=ZISKCXQCRFjuVLKMU0yFtuDSM4c1LU4DWong1l/5o5bfF7fCZ5n0vYGH9NIG2O6LKI
 ArqswynlBHVjOVOUECj27K+emTRs5yWT4nZfJr0xoJVYE8tbP33gHEiZBao/MURBeokk
 f8EvsSiW20ZiOSr51pfnFl2Fm+57SjI9QtdafDA7hC7lgjmvEjHDrv/Y5KjwGUFBMG6r
 8pjE2G5vM/bbUedQPo7rwgN6bKxYMvriY5Pd01cyYgw6xCZg0orek3HSBHIoBbFkXhHO
 OW62JTf/hhGOPIZXP4YsW8Dn0P0CMp+l9bsGiV0bh2Bj9r/xiaD2ClvYQqm0bYokHHgZ
 jRQg==
X-Gm-Message-State: AOAM532g7o4iP/FapNbhx9d3DPbscoYn+mqQUBqCgOD+WT39XlMOog6X
 ISGGjMz90Q5UKF6hmw7QZzRtbRwm0gYtgg==
X-Google-Smtp-Source: ABdhPJyDaawGyeGBMlEC7DT15vktoxW1rClm9mixvrNhxmNUdZMamn2gAo7ZAvugDJZFwktR3551aQ==
X-Received: by 2002:a17:90a:8a0d:: with SMTP id
 w13mr3692745pjn.218.1599079484841; 
 Wed, 02 Sep 2020 13:44:44 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a5sm423354pfb.26.2020.09.02.13.44.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 13:44:44 -0700 (PDT)
Subject: Re: [PATCH v3 6/8] hw/hppa: Add power button emulation
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200902193456.29844-1-deller@gmx.de>
 <20200902193456.29844-7-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <53a9177a-7ad2-df44-0110-497318368353@linaro.org>
Date: Wed, 2 Sep 2020 13:44:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902193456.29844-7-deller@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.324,
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

On 9/2/20 12:34 PM, Helge Deller wrote:
> Emulate a power button switch, tell SeaBIOS the address via fw_cfg and
> bind the power button to the qemu UI.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  hw/hppa/machine.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

