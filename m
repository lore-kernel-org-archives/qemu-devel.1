Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E54C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:59:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9B7206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsDTBJkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9B7206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvNK-0007la-D9
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1kIvGq-0001dC-6o; Thu, 17 Sep 2020 10:52:25 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:45578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1kIvGj-0007ww-RT; Thu, 17 Sep 2020 10:52:23 -0400
Received: by mail-lj1-x243.google.com with SMTP id c2so2270941ljj.12;
 Thu, 17 Sep 2020 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=Qija0jniBOLs5N6qr7SKNOjdKkyl4mPPcNefiWT4QYE=;
 b=qsDTBJkLNNCfon4VjloRdn8NUtflELX6D2rK+s/bvkr0wlqeR3ySqwm7Oqi475Bj0v
 HzoHgV4TprymlErNRQK+X0WOu2NqRZNyID8Hky1Bc/qBiS27QHozRP9XccIyml6MatF0
 YHYYUMkgaKZmEsutrz5L7J6h2nfswB1V0LoO4u7qvMN6FNXXOHTAnnLRL6HhnQUd2tCs
 eIQfDr5c8fZu6K8OUH9pY4U7lHyxnqrPP0R1+I0WeZFfSvCA30/1ail+UZZoWVzKQKDc
 4P5HRxsSKSQxJtlPFe/N033PDct5dekZb8qWhRrZfauNZjyUhXZnq1E72igJu/24A2ys
 YqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Qija0jniBOLs5N6qr7SKNOjdKkyl4mPPcNefiWT4QYE=;
 b=VMLwMpF9LzeR6aRsIJaFxkRr7jIP7F/FdxDNCI5vLdhmNenc9QgczScKsgn6D/mBu4
 6NwFL+1HXytsSMpuAwoOGDHmwMrwz1i2f99bGw7tiViYY2v2VWRscZRwoIPkWAOQFDa1
 SqJKu37LYR6ytIv1Rvj1VT2zn0dMEGp+79faHUJHzaUhrdyD7yjn1/unjH6j445PVh7+
 DL/SXtQEwO8eiuERJw09oRQMGeJ8ujvGc2kwOf7VxSHz4/3/FElNq8pqbU7L6EBav5+Q
 0MzL2HozN2ypsljk+0XNqGt/nHnQ98nz5QKn3ld0y0MXEPCCiE1wLvaeJ7hMYm6zgw2R
 bm+g==
X-Gm-Message-State: AOAM532ShOoPaSuGDQdv9sxapZEUT74Y4qZKkOMuTYTwG34lSCVxTQWI
 rJnG1Ob+o0CXa3gixoLlnC0ITZEuf60=
X-Google-Smtp-Source: ABdhPJwRlu6HRSBsRnR2GtOYe1OIbbb10cB/FKG7IhA4EdoV8h0uVu7tX8/y7O67wzWOcA1AzaQT7w==
X-Received: by 2002:a2e:8e71:: with SMTP id t17mr9765887ljk.413.1600354335125; 
 Thu, 17 Sep 2020 07:52:15 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 b7sm5543039lfq.36.2020.09.17.07.52.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Sep 2020 07:52:14 -0700 (PDT)
Date: Thu, 17 Sep 2020 16:52:12 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 8/9] arm/aspeed: Replace mx25l25635e chip model
Message-ID: <20200917145211.nwoc5ijytqjfb7c7@fralle-msi>
References: <20200902093107.608000-1-clg@kaod.org>
 <20200902093107.608000-9-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902093107.608000-9-clg@kaod.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_WELCOMELIST=-0.01,
 USER_IN_WHITELIST=-100 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On [2020 Sep 02] Wed 11:31:06, Cédric Le Goater wrote:
> A mx25l25635f chip model is generally found on these machines. It's
> newer and uses 4B opcodes which is better to exercise the support in
> the Linux kernel.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  hw/arm/aspeed.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 8bfb1c79ddc5..df65d949b7e6 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -609,7 +609,7 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data)
>      amc->soc_name  = "ast2400-a1";
>      amc->hw_strap1 = PALMETTO_BMC_HW_STRAP1;
>      amc->fmc_model = "n25q256a";
> -    amc->spi_model = "mx25l25635e";
> +    amc->spi_model = "mx25l25635f";
>      amc->num_cs    = 1;
>      amc->i2c_init  = palmetto_bmc_i2c_init;
>      mc->default_ram_size       = 256 * MiB;
> @@ -643,7 +643,7 @@ static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
>      amc->soc_name  = "ast2500-a1";
>      amc->hw_strap1 = AST2500_EVB_HW_STRAP1;
>      amc->fmc_model = "w25q256";
> -    amc->spi_model = "mx25l25635e";
> +    amc->spi_model = "mx25l25635f";
>      amc->num_cs    = 1;
>      amc->i2c_init  = ast2500_evb_i2c_init;
>      mc->default_ram_size       = 512 * MiB;
> @@ -710,7 +710,7 @@ static void aspeed_machine_witherspoon_class_init(ObjectClass *oc, void *data)
>      mc->desc       = "OpenPOWER Witherspoon BMC (ARM1176)";
>      amc->soc_name  = "ast2500-a1";
>      amc->hw_strap1 = WITHERSPOON_BMC_HW_STRAP1;
> -    amc->fmc_model = "mx25l25635e";
> +    amc->fmc_model = "mx25l25635f";
>      amc->spi_model = "mx66l1g45g";
>      amc->num_cs    = 2;
>      amc->i2c_init  = witherspoon_bmc_i2c_init;
> -- 
> 2.25.4
> 

