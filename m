Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F094C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D24B20DD4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeqHcyFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D24B20DD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEBwQ-0003KG-8d
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEBvX-0001aC-EF; Fri, 04 Sep 2020 09:38:51 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEBvV-0005JW-SP; Fri, 04 Sep 2020 09:38:51 -0400
Received: by mail-wr1-x441.google.com with SMTP id t10so6836790wrv.1;
 Fri, 04 Sep 2020 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=K8ASEsyIKVahzXtRIVw+s3yu7/d3wurALcz47xSL8Vg=;
 b=CeqHcyFgtO+iamN7u6dl7e1Ax6cfjhnRveXR2unTkuS0AtZgPJZbTdrlIweD4BiSPf
 h2Pxo1YumKnbKL9yCds8/EUba0R/Kg0cjrO4greN0g+ho6WUqaCLz5XucBlGD+sB47/M
 CmBJ3nfv2dtGeGoJk8MjKX0DxT6a7GL/s5sUbOmZTAG0lYEx5CEzcDTVEoANCa17qoER
 2ccW9tRoymI38TjmFxc2iqQ9fbdSnC7QMKrUkYsCcIUr9jP/z1P5iCrynpDUFIuEL1nR
 cKpU71oTaynjEPqj/BY/UGYCPIbydEfs8B3yLjokntsCY0Zt0DS/6y6Fjm1ZmPi+HrA8
 jJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K8ASEsyIKVahzXtRIVw+s3yu7/d3wurALcz47xSL8Vg=;
 b=QZRGgiXdG1fT0EtMIbDaWyjKmg8o0vcxG+pTXelgGh+AmcF5R+Gq3gXn+0uhWyVf5o
 jzjksAaJKDa42rbOHfs3HQJPjsLzd2DM2EHIrmMinTKie/wXLDxi+GfDiiZRsU2k12k5
 AQgWXGiU4w/dCSDNsYPXPPJXQLpHXyEgeNmoJdmiSM20w0HwuqEfZLASAreKV8wkr0N7
 Ove127aEFLMu9f6AgqwXNh4SvsPDdFa9OLbSxqjJHyi/tATJB/k+j99J0Um3QCvxTZ11
 d0kTEPuwbORhTtPEhpTW4Y1A4n9HCU9lMwo6nnGH2Xzk2a8hr+iNVIEmjDInp/H5Ai2D
 Z0bw==
X-Gm-Message-State: AOAM530PVNIOTT6Hho/8sh5EpzHBTwEOZs/Hz193pM3T59uNokysEn5C
 n/OG2KSmOWvhSj15+DWITnM=
X-Google-Smtp-Source: ABdhPJxJihUfNLxJ4DiOUQqCJYnsfnTIqt6PqVHNFEVcK/cVjpiCRCAWPpGIYkReFDk1wtPVY26O4Q==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr7400069wrt.13.1599226728304; 
 Fri, 04 Sep 2020 06:38:48 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id t16sm11573137wrm.57.2020.09.04.06.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 06:38:47 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] docs/system/arm/mps2.rst: Make board list
 consistent
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200903202048.15370-1-peter.maydell@linaro.org>
 <20200903202048.15370-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1ccb372a-580f-a9c6-a813-ff7b45c016df@amsat.org>
Date: Fri, 4 Sep 2020 15:38:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903202048.15370-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.107,
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
Cc: Kumar Gala <kumar.gala@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 10:20 PM, Peter Maydell wrote:
> Make the list of MPS2 boards consistent in the phrasing of each
> entry, use the correct casing of "Arm", and move the mps2-an511
> entry so the list is in numeric order.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  docs/system/arm/mps2.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/docs/system/arm/mps2.rst b/docs/system/arm/mps2.rst
> index 7f2e9c8d52e..8c5b5f1fe07 100644
> --- a/docs/system/arm/mps2.rst
> +++ b/docs/system/arm/mps2.rst
> @@ -11,17 +11,17 @@ as seen by the guest depend significantly on the FPGA image.
>  QEMU models the following FPGA images:
>  
>  ``mps2-an385``
> -  Cortex-M3 as documented in ARM Application Note AN385
> +  Cortex-M3 as documented in Arm Application Note AN385
>  ``mps2-an386``
> -  Cortex-M4 as documented in ARM Application Note AN386
> +  Cortex-M4 as documented in Arm Application Note AN386
>  ``mps2-an500``
> -  Cortex-M7 as documented in ARM Application Note AN500
> -``mps2-an511``
> -  Cortex-M3 'DesignStart' as documented in AN511
> +  Cortex-M7 as documented in Arm Application Note AN500
>  ``mps2-an505``
> -  Cortex-M33 as documented in ARM Application Note AN505
> +  Cortex-M33 as documented in Arm Application Note AN505
> +``mps2-an511``
> +  Cortex-M3 'DesignStart' as documented in Arm Application Note AN511
>  ``mps2-an521``
> -  Dual Cortex-M33 as documented in Application Note AN521
> +  Dual Cortex-M33 as documented in Arm Application Note AN521
>  
>  Differences between QEMU and real hardware:
>  
> 

