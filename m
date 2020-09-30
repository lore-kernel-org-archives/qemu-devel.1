Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3FBC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 961F520789
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMj0DDsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961F520789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZfu-0000t2-Fi
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNZe5-0008Q8-6h
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:47:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNZe3-00009c-El
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:47:36 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601462852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4fZsuNISzwNY/mPJmil+Cj7GKV2Pr2PQSQbMiFFLq+8=;
 b=JMj0DDsqJ0Za9SseHrjJ2KTE1jxBr9VA4+yyu1ElJpgr4CJ9N5mfe7p1iPogroR9rGpyVa
 X7/iJxQlWXk7KjuXQmmqzlnGosswEE3bcAd8BdYfofubQyWS4Oyprrkgxj1n3Pz+AnQAgb
 rgDG76VjpdSkyaGTDvfZvdQadP1+jvk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-nl5wWMq2MxuVZaxjR_w6Yg-1; Wed, 30 Sep 2020 06:47:31 -0400
X-MC-Unique: nl5wWMq2MxuVZaxjR_w6Yg-1
Received: by mail-wr1-f70.google.com with SMTP id o6so467244wrp.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 03:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bWvN3FA3f4hDob/bobaLcT6CJkbAuluYXFtzV3u1w/0=;
 b=SLfxb+PjQ9DajjH8En5N3y8/eV34frCqE+eLl3Nl53uK3RHA5nuK96HimlVfAOS/qU
 aHYUkTXUT42lBZSdOCfRyoJT6Jlw/lNYcJgHMnEMxZTBZBuc2GOp4DRqFtbAucCgUHQ+
 Rz90e6Yy2urBEvIvOyz2v8ZNpjU/694gpS9g6PKtZMAwEMRFR8Vx8Z3y481OGpWyHdiG
 5D9yV2KyYd/Eng/ZrYoUtcrwKQ5QKBNv05SALa4Q13bMi835b28MEOtL4gt37yq8HYK3
 eVhcIBDsZx3YFbV5Tzxt9eZNvmBFyjoZ6yxp0xbxDf74L/sENnSbmYL6DU70DQvVGfNa
 5B+A==
X-Gm-Message-State: AOAM531U0abFWUTqQH8EJiVwMzc0478vQCia2DQdMkqcemn3XTAJG8E+
 MXSS1Hx4rK4i4WYelNkoLeW3+u5LFrFTXJG2x5y04zd12FnaymIM92G4Z3FvNmsrfltXHu1KWpN
 V/kt1NOk1iFgBK6E=
X-Received: by 2002:adf:f190:: with SMTP id h16mr2456511wro.202.1601462849895; 
 Wed, 30 Sep 2020 03:47:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymC10CZN+N9Fj4VfFOsN9mCx927omLWDg7E2XVe7/EFyrKugaqHKY5Eoi8wY8F6ixQ0Dd26g==
X-Received: by 2002:adf:f190:: with SMTP id h16mr2456492wro.202.1601462849642; 
 Wed, 30 Sep 2020 03:47:29 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id c4sm2195105wrp.85.2020.09.30.03.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 03:47:28 -0700 (PDT)
Date: Wed, 30 Sep 2020 06:47:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/arm: Restrict APEI tables generation to the 'virt'
 machine
Message-ID: <20200930064717-mutt-send-email-mst@kernel.org>
References: <20200929125609.1088330-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929125609.1088330-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Dongjiu Geng <gengdongjiu@huawei.com>, Xiang Zheng <zhengxiang9@huawei.com>,
 qemu-arm@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 02:56:09PM +0200, Philippe Mathieu-Daudé wrote:
> As only the Virt machine uses the RAS Virtualization feature (see
> commit 2afa8c8519: "hw/arm/virt: Introduce a RAS machine option"),
> restrict the APEI tables generation code to the virt machine.
> 
> Fixes: aa16508f1d ("ACPI: Build related register address fields via hardware error fw_cfg blob")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Xiang Zheng <zhengxiang9@huawei.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Dongjiu Geng <gengdongjiu@huawei.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 1 -
>  hw/arm/Kconfig                  | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 9a94ebd0be..08a32123b4 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -43,4 +43,3 @@ CONFIG_FSL_IMX7=y
>  CONFIG_FSL_IMX6UL=y
>  CONFIG_SEMIHOSTING=y
>  CONFIG_ALLWINNER_H3=y
> -CONFIG_ACPI_APEI=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index f303c6bead..7d040827af 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -26,6 +26,7 @@ config ARM_VIRT
>      select ACPI_MEMORY_HOTPLUG
>      select ACPI_HW_REDUCED
>      select ACPI_NVDIMM
> +    select ACPI_APEI
>  
>  config CHEETAH
>      bool
> -- 
> 2.26.2


