Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5860BC3F2D4
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 04:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23450246A2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 04:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRiBT1fx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23450246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7trD-0006ib-AE
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 23:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7tqS-00069w-B7
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 23:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7tqR-00057u-6c
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 23:35:20 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:33314)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7tqQ-00057h-VG
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 23:35:19 -0500
Received: by mail-pl1-x643.google.com with SMTP id ay11so2038924plb.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 20:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=16CLdfziuvOU4J+AYKa9B9SDmXWgzCOeTUI+rj1zr78=;
 b=pRiBT1fxXiwps7umG26Np2yCAY1PhK1veg2xNHRUkGozhVtAxxu9NguNizmj/UagFT
 K7mqHT7/L/rtt9wE0RbWTrvJxrlFzsO5AXJS4vJ5tpA2jQeZOLCt6pp1HCerSrcfLY+h
 WE2It0b7A8nGUfqfkFwTjMqwm9sP/esT0xaivaq4qVMJFKQFSNUw6pYoK3VSOWuKAE+j
 jsMUYT5UxUI1rlvjNA8NFu53KToBDYSBCVKvUtPhrq/WDEmDPWBW7Q+zNgNWT2FXdDvz
 wWD3bqbnBMnqCUkO4LS/07xKDi7TxY2wkox9OEW+hFZvyUxDC3GrYN/vlp/JWWTcPL99
 aA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=16CLdfziuvOU4J+AYKa9B9SDmXWgzCOeTUI+rj1zr78=;
 b=rlKi+Jj8/yNQ4GfvVXjE6t52VPy0i/bgsCc4GFYyU8ZXbJ/p/cAKmYAoUCtXa+FqKg
 rPdulsD1OI2GT05CQW8iOevxyBdg++RaaFh9L0hMIRNFoINiIAD9yxrZsYR2pIbnqHS3
 cxEJQ6RGgTBMSVzqADQxZFZevvSc6AO/Isptyd8+YncRQxfabokwOKM0EBfBu8+HCsgE
 PTmzzS7QMzVesyoSLqBrm614jfdWRsNuPVajnT0eu8i7vLCbWi0ICvPxuO5JwwValhSo
 JuDVJ87fH9YefC3+fYP4necmwWzaoRoaXM6cLXIZPBaoIEEZmsoTrOY1EnqWAggDvxZ8
 5Lxw==
X-Gm-Message-State: APjAAAVA3iB1XoGx36ECYP3Fu1v++08qrvoyjyXtsssgkcIG2yOVm7JZ
 /tMAdyLv12iP4iCaZfJXsxDYCQ==
X-Google-Smtp-Source: APXvYqwRt3ePrUzLy3zbD0LDv2ecP7mnN0eUh6mK4BWJkJ80I4zf3mvQhCi85FnrWePOo1xwo3R9Fw==
X-Received: by 2002:a17:902:c154:: with SMTP id
 20mr7191694plj.112.1582950917398; 
 Fri, 28 Feb 2020 20:35:17 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 e9sm4106911pjt.16.2020.02.28.20.35.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 20:35:16 -0800 (PST)
Subject: Re: [PATCH v3 01/21] linux-user: introduce parameters to generate
 syscall_nr.h
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200225121553.2191597-1-laurent@vivier.eu>
 <20200225121553.2191597-2-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <698bce08-0898-029c-4e37-e28fa5bca9d2@linaro.org>
Date: Fri, 28 Feb 2020 20:35:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225121553.2191597-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 4:15 AM, Laurent Vivier wrote:
> This will be used when we'll import syscall.tbl from the kernel
> 
> Add a script to remove all the dependencies to syscall_nr.h
> that point to source directory and not to the build directory.
> The list of arch will be update while the generated files are added.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  Makefile.target |  3 ++-
>  configure       | 14 ++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

