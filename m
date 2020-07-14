Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBA3C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C8B22464
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlcZfQt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C8B22464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvKQI-0006LG-Pt
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 08:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvKOy-0004IP-Ux; Tue, 14 Jul 2020 08:51:16 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvKOx-0002lK-5H; Tue, 14 Jul 2020 08:51:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id j4so21385329wrp.10;
 Tue, 14 Jul 2020 05:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DPfgLaHyWMOKNDsYqcI84DHhj8g+HLYXFdDwtMOO4js=;
 b=nlcZfQt90gS3a2tmc7XIbqtFDkqVyE2c9CL22VB83UtKwgvhnQBHTeJFiGUHrB9xP4
 xuKkaboY1MHWyoIT1+iUbjU7VF43xrTD2wIUDCSvkxPKBL6a23xCYjVadkiVJ93CbQRl
 9TMAqiaHp56oF2eBpAUOi5OJWID2HA6t9lmPjnQsLtdnPtFT427elr1oAzToe70cPK0O
 3Bzf/ru9Wn3Uegb6jobIXmSv8WfQR8wZF94A4Jv88oGUwGxemqrfT6kH6/BivRbFDcZ4
 LLcIPBSwX66561Dvh8gclSFR97y2c+xXvLHBCWkzeXX92M0s+4qxU/3YhWfClMSvD849
 Jf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DPfgLaHyWMOKNDsYqcI84DHhj8g+HLYXFdDwtMOO4js=;
 b=lMUL5GNs1/U9WbqBuoQdoBtMifTwfGdzc8oS/BjVhPKBQk1TgVZpLuSYXla+ckINMR
 UUQfrBt12l/K9bt3WWGJmZeS5HRSI8bX5mdbNGuFWXxlj6QoEbDKsSwO6lxUJlVuM8IP
 SAgfu/EbZII10Sl7AUUc/nBFxLaA8n3ZzKdj8BoO0mCWc6SdDI1FDWBs2MRycNiE4AyD
 YAot3QoWlt6+L2hl9UCQXXmZb1go2n+rFh2lhd8QJSKozEtsq2Bkgm+UKyHZLAl0oovv
 MwuSvvkNP4rZleSQbspLTxkk3sG3UE1YSGDl8briYPhZtgjbgNNBsaUVOKWVSGWFCipi
 HasQ==
X-Gm-Message-State: AOAM530eEvjXbJjVfBacQ4nLvS0rFuzhJr+drh99+2AgO1v9YyUpamhD
 lKYj2iH8aM5zge4/xiHpTiwgHGgzeRc=
X-Google-Smtp-Source: ABdhPJx2Mv3jYJYjI9Ya7x16DdqutiB2Gzjr4obYvlJDa3slc8jmhmeR3KDDbDCcRZoZZ227VAitEg==
X-Received: by 2002:a5d:6603:: with SMTP id n3mr5372081wru.142.1594731072909; 
 Tue, 14 Jul 2020 05:51:12 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id q188sm4578922wma.46.2020.07.14.05.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 05:51:12 -0700 (PDT)
Subject: Re: [PATCH for-5.1 1/4] docs/system: Briefly document canon-a1100
 board
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200713175746.5936-1-peter.maydell@linaro.org>
 <20200713175746.5936-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5425cea6-8211-d780-dcc8-33e327fda82d@amsat.org>
Date: Tue, 14 Jul 2020 14:51:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200713175746.5936-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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

On 7/13/20 7:57 PM, Peter Maydell wrote:
> Add skeletal documentation of the canon-a1100 board.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/system/arm/digic.rst  | 11 +++++++++++
>  docs/system/target-arm.rst |  1 +
>  MAINTAINERS                |  1 +
>  3 files changed, 13 insertions(+)
>  create mode 100644 docs/system/arm/digic.rst
> 
> diff --git a/docs/system/arm/digic.rst b/docs/system/arm/digic.rst
> new file mode 100644
> index 00000000000..2b3520ff5e1
> --- /dev/null
> +++ b/docs/system/arm/digic.rst
> @@ -0,0 +1,11 @@
> +Canon A1100 (``canon-a1100``)
> +=============================
> +
> +This machine is a model of the Canon PowerShot A1100 camera, which
> +uses the DIGIC SoC. This model is based on reverse engineering efforts
> +by the contributors to the `CHDK <http://chdk.wikia.com/>`_ and
> +`Magic Lantern <http://www.magiclantern.fm/>`_ projects.
> +
> +The emulation is incomplete. In particular it can't be used
> +to run the original camera firmware, but it can successfully run
> +an experimental version of the `barebox bootloader <http://www.barebox.org/>`_.
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index 1bd477a2936..8fa51a22817 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -82,6 +82,7 @@ undocumented; you can get a complete list by running
>     arm/versatile
>     arm/vexpress
>     arm/aspeed
> +   arm/digic
>     arm/musicpal
>     arm/nseries
>     arm/orangepi
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe8139f3675..0f578040b99 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -634,6 +634,7 @@ F: include/hw/arm/digic.h
>  F: hw/*/digic*
>  F: include/hw/*/digic*
>  F: tests/acceptance/machine_arm_canona1100.py
> +F: docs/system/arm/digic.rst
>  
>  Goldfish RTC
>  M: Anup Patel <anup.patel@wdc.com>
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


