Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968A4C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:45:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E682081E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mTgQPW2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E682081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is9DC-00069F-Ea
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 12:45:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leif.lindholm@linaro.org>) id 1is9BH-0004Sj-Ss
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leif.lindholm@linaro.org>) id 1is9BG-0006FE-MH
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:43:43 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <leif.lindholm@linaro.org>)
 id 1is9BG-0006CC-Ae
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:43:42 -0500
Received: by mail-wm1-x341.google.com with SMTP id w5so7660128wmi.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 09:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2qsPxMUJ4K94ldEbJIVkf7JQnMntDmQYKtoJKrcyxwQ=;
 b=mTgQPW2pw5RD2cPGWqVXXtTFi9OFIZMPglHLnd9Gk9ZZ611IXLlombiCb2uOyr0ik8
 FFFWPCCQCSTPqoAJXluAuE6KCo1K7TisyyUH+yl/64AE1aG+dD/bbQBxrsCVKvb/WUrA
 URi26Z/tFBqxVLGuWqV9WOCJaXCzTE9xIbIek6OLajiT4uIcnVJ2uqB3o8T3IDbWX35V
 JXrJP+aNO+2uDyvnJJBvXSD7PkHFNObI2U2FGsUERkWRAvatOkFzQ7XKsD+2sdwOcNj0
 Syjz+c9F66XFqo7vgyCa0a/BoEQvyP1E3LZsw3E993Tk/I2WIwB2+YoE4Li/NNeYwnoh
 1VNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2qsPxMUJ4K94ldEbJIVkf7JQnMntDmQYKtoJKrcyxwQ=;
 b=DItoUVdVi4/oxTUH+1XPFlrakHMdExxBIBRGvsR7RURvAR3WrHVniXiHHMbUc76bJb
 OErMPKM/SVutEIv3PnuiHI3tr2CIUmnwPZU1mjDyM/h6NI1Fym8yEBP8BY4G3Q2NtUAf
 VIfhVMzrK0ulWd7Oh8fo7BBX6w7IKQVImGRPBrwAugoSCDiAyPZHlqdk3wLGuOHqCZ4f
 zsJl70lXKk09iEwJyA67oxG0MjYNswkGmHOFN2YdopMhUFXSeKrw6D9l6zvLpJRxCTqv
 ioghbgf/M++hTb7G6hTPh/62drLEQxLFxGkcfvbqgrTt7d1B3XQgddE67FbUjVfy2NIG
 ZSrw==
X-Gm-Message-State: APjAAAUc6cMeGOgTNAy3rP1hvjkgvcbWQ/CkJN8WTChu9o26O9olOFS4
 9MoB/v1F1hDoty4AquWa7kgtEg==
X-Google-Smtp-Source: APXvYqwFdXO3U1gxUYFgHcM5wEgDqf9sMgemh+9tRrjPVitnkysDvyf56KCjKEP7nJVALLXNA0Q/Gw==
X-Received: by 2002:a1c:3803:: with SMTP id f3mr203204wma.134.1579196619045;
 Thu, 16 Jan 2020 09:43:39 -0800 (PST)
Received: from bivouac.eciton.net (bivouac.eciton.net.
 [2a00:1098:0:86:1000:23:0:2])
 by smtp.gmail.com with ESMTPSA id v14sm29993062wrm.28.2020.01.16.09.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 09:43:38 -0800 (PST)
Date: Thu, 16 Jan 2020 17:43:36 +0000
From: Leif Lindholm <leif.lindholm@linaro.org>
To: Leif Lindholm <leif@nuviainc.com>
Subject: Re: [PATCH] MAINTAINERS: update Leif Lindholm's address
Message-ID: <20200116174336.GD20629@bivouac.eciton.net>
References: <20200116174226.4780-1-leif@nuviainc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116174226.4780-1-leif@nuviainc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 16, 2020 at 17:42:26 +0000, Leif Lindholm wrote:
> Update address to reflect new employer.
> 
> Signed-off-by: Leif Lindholm <leif@nuviainc.com>

Reviewed-by: Leif Lindholm <leif.lindholm@linaro.org>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 483edfbc0b..3c8653f26f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -735,7 +735,7 @@ F: include/hw/ssi/imx_spi.h
>  SBSA-REF
>  M: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
>  M: Peter Maydell <peter.maydell@linaro.org>
> -R: Leif Lindholm <leif.lindholm@linaro.org>
> +R: Leif Lindholm <leif@nuviainc.com>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/sbsa-ref.c
> -- 
> 2.20.1
> 

