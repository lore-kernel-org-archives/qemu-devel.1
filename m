Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A67C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 07:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C73720661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 07:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Azo+2HMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C73720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyWXa-00050i-Ac
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 02:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyWWl-00041S-5I
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyWWh-0004E3-2O
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:52:15 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50541)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyWWg-0004DG-RU
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:52:11 -0500
Received: by mail-wm1-x341.google.com with SMTP id a5so14620924wmb.0
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 23:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dz52+Fv5giw9fw8Y8/XV7CoJHELKzT+Y87eerY2+uUE=;
 b=Azo+2HMRNao5ZCF2koUFVk07E+bnv/Eg9FLMWrlr0iDya7bDjYutP91vTeJ/tL6MXU
 wJaQdQulf+BBDwVkCE5sEyoApU2eDGuD4nYpYj4x4Zceuie8d3ylaEX0W+RMCCWD/25m
 tXeP+vUMfBYDrJZTZSDlPrj6Wk/mKLZ7t3QkHvSmOjD822wEhCfFgZPihLl9iOsdpVhE
 joKYOBM9QxHKl0Oq4/3bWX8O+pp4+z+nwb4yfJ85SqlfEnYI5XlZJpibGt6z3Mc3fCjj
 kiNzRnUlJNsBEczFIfBUCm1J/ftNcJzP9vUHGNwbhSXFF6jk8VZH2RvU6vVupOWscIxZ
 bOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dz52+Fv5giw9fw8Y8/XV7CoJHELKzT+Y87eerY2+uUE=;
 b=nfBNDSd8cjQQa0nxolEh/bC0v7XsV1s3x0kkuOtLsrWS+sN2TjiYpp4/SrqdcRHTpn
 NAbs6YCMfsp9yYszGlv/MzGbe9VaHo1u21O8IovrJWkbRIHycyUnb0kiKsXrKOx8nO2+
 mYHWbOQmYe2XO6BExBFwIeZkzDWEqejcmYtrBkzUzn/JCbd0WiTrYbB3PzS5M7aXG2NG
 UXTu8qZ/iamY0nOeKRWJhhkmYHyXh/kLzjHHSgj1WXr1e3o5GWouDaHe0wFNoqyZCqSU
 svJu45P6EhCDx3YN2Dq911GeRloWdCyZoQBSdnwKLx9bXE/MJT4OwUP3I1kSTfPkRH0V
 s3+Q==
X-Gm-Message-State: APjAAAWuNa6SxL8aUMao68Bgo58wwAJGnONwI9MeIia0AZacfYIPE/bw
 6DsvK6KUHbUb+r5aCSzUahsPuA==
X-Google-Smtp-Source: APXvYqze3P9VuioKYm9ngwikL12d3Y6r8NQEolvGKIivxKuPdApMv1R3pLwlIugwx2wfhEJLh5agOQ==
X-Received: by 2002:a05:600c:2383:: with SMTP id
 m3mr28228752wma.32.1580716329135; 
 Sun, 02 Feb 2020 23:52:09 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id l17sm23513784wro.77.2020.02.02.23.52.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2020 23:52:08 -0800 (PST)
Subject: Re: [PATCH] target/mips: Fix ll/sc after
 7dd547e5ab6b31e7a0cfc182d3ad131dd55a948f
To: James Clarke <jrtc27@jrtc27.com>, qemu-devel@nongnu.org
References: <20200202153409.28534-1-jrtc27@jrtc27.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <75960e9f-3d28-4db6-ba9a-098b576c6d9d@linaro.org>
Date: Mon, 3 Feb 2020 07:52:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200202153409.28534-1-jrtc27@jrtc27.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/2/20 3:34 PM, James Clarke wrote:
> From: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
> 
> After 7dd547e5ab6b31e7a0cfc182d3ad131dd55a948f the env->llval value is
> loaded as an unsigned value (instead of sign-extended as before).
> Therefore, the CMPXCHG in gen_st_cond() in translate.c fails if the sign
> bit is set in the loaded value.
> Fix this by sign-extending the llval value for the 32-bit case.
> 
> I discovered this issue because FreeBSD MIPS64 was looping forever in an
> atomic helper function when trying to start /sbin/init.
> 
> Signed-off-by: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
> Fixes: 7dd547e5ab6b ("target/mips: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX")
> Buglink: https://bugs.launchpad.net/qemu/+bug/1861605
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Clarke <jrtc27@jrtc27.com>
> ---
>  target/mips/op_helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

My fault.  Sorry about that.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

