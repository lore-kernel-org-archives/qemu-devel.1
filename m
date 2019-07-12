Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20ADC742BD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D751206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zqj82EOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D751206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlwHA-0007WH-PG
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 10:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37741)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hlwH1-00077e-3b
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hlwH0-0001Dm-7z
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:11:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hlwGz-0001B2-V2
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:11:42 -0400
Received: by mail-wm1-x342.google.com with SMTP id g67so5002784wme.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 07:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gVJNQGFPci9HyRrvHKlpViAJlnldLr7VHGtvnbAYDGE=;
 b=Zqj82EOwzqQO2i20gJ1sx7Wz3jiiWwrexUPc7yv/X6pNkqOhAfcQZRkCJXYSblUhku
 87F2xxRiaB5NH5q/O8++clWwUHq8fYGKSG0nOODhf+kVe8WGHmHah3eiDCr3LgXQlzB6
 UjIXfEKemjl3DkQ883ZW4yB/d+Ku+iHf6rN/NDVNYcuSmKG0gH9NTsWPM/4Gq/1zvsTH
 K6581geOtvSqSHlZrZQ0kFV8LnY3TvULQSZ18hrV8lR2cxEVQa5Opt65wjcZvIJM3hGR
 sZClVQv32qOcYtf909osoAFynQ5ZckMQRsby+YWHxN5THv8xkrwSm6q+uy0Ggm+ULtHj
 VJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gVJNQGFPci9HyRrvHKlpViAJlnldLr7VHGtvnbAYDGE=;
 b=QJNwoKM1beapZVHQab+k1raXBPUNQozvwNeZF4zqZjRyTC0c+k+q4URBWkiZ86JbUg
 QsHy6kNU0c7aS2CkChq21quaJ17mzU4BgYXgQFfMnOOUekzha7e+6GwDR7QzPUN/dJYz
 Mo3upnnS6FOfqht9ElyzoYDltwaOsgb3f3swqfHBLU5rnEmdaSgBk49c0JQ4A/IR/8HR
 rpCtYPUb6tE45+8zIZtongbGtCg7RjJtXp3dT+DQNQ2Dfy+dPcZ67Xo1on6NJQUPFzzr
 ThkpSgfJ5k1Atw9NhmUr0xxdE1ijCgmZvO0/6kFa7gYgyDvOvhGsnBv1hv87cvuWOKTj
 bvJA==
X-Gm-Message-State: APjAAAUhkiKIwRMoov089Se3z/M9FbXUsIh0pavGVvCSEqmSA59iTrEx
 LkIo1NtkPchiMwtIY9HLkoNg+g==
X-Google-Smtp-Source: APXvYqyGJcrLvuw4b6wvKZsO6Idp6qAa9zo2MSfvxgIpZ58vIbV/ZMkkBEYSaLh937sS0qa5x62fpQ==
X-Received: by 2002:a05:600c:da:: with SMTP id
 u26mr9730127wmm.108.1562940699868; 
 Fri, 12 Jul 2019 07:11:39 -0700 (PDT)
Received: from [192.168.42.31] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id i18sm9545838wrp.91.2019.07.12.07.11.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 07:11:39 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-4-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0579d0d3-d067-7f4c-0a67-e3013232c85d@linaro.org>
Date: Fri, 12 Jul 2019 16:11:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711223300.6061-4-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [RISU PATCH v3 03/18] risugen_x86_asm: add module
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/19 12:32 AM, Jan Bobek wrote:
> The module risugen_x86_asm.pm exports named register constants and
> asm_insn_* family of functions, which greatly simplify emission of x86
> instructions.
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  risugen_x86_asm.pm | 918 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 918 insertions(+)
>  create mode 100644 risugen_x86_asm.pm

Clever use of token lists to make sure all state is processed as expected.  Kudos!

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

