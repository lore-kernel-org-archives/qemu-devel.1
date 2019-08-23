Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6417BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333952173B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5b1Ka99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333952173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1DJk-0001aw-Cn
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 13:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1DIm-0000oq-Vm
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1DIm-0003QV-0G
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:24:40 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1DIl-0003QI-Pl
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:24:39 -0400
Received: by mail-pl1-x641.google.com with SMTP id t14so5910915plr.11
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 10:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fzamstLzFBKjPZ/kxBEFyS0Fy3UuxOPDhES2K0udpxI=;
 b=Q5b1Ka99T/WCLwgQvejVXOlyQYVKF465/VQYq23A6LcSxyFmAvC7GaGLqTMbxFUy1C
 +1VW84lLnCRsLer8PQXIHPmnBLfFKzz5mEkvqd/wrqyGvXU2Pjzm3hxsrbxPaMPDUl2o
 mLYtC1FNTik5oZ8LrU6WXDJz2yToxDy3CdB/2QllmUdvbF45+Y0hEJAeUd5uDoUiEKFY
 37LF8VmXsNYjeagf9U38etyRQFy+gAIq1LkxW/HyQSoy879RyXspD0swHcu0o/Y4y6rY
 mVgBlrpvAMaACliz3TJSERiFz68xfbEZItyN6TrH9NsD04ZpCGUcKJ7MKtdlBdG7AhTW
 5+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fzamstLzFBKjPZ/kxBEFyS0Fy3UuxOPDhES2K0udpxI=;
 b=s4mbjYEY6KU59xkDXUfMZb/PLnog41LK1tCfhVDSPucmASc5RDjMTDJJe4MWsEE3Y+
 Fkp/To21FwQfGCHp6p2pkri8QLvagkv7USim05XIzq22F8tDO1rL2Rvv2NgWqE1hmmvt
 JTvrna0DVWqW9AwEO5xT0BvyyVGwlXLCKMEc1Dk7oo2b8FItyEkRFd4cfE/29SJ2DVAi
 qbVVfi16xPOw+c/lFSrUNkDiJ+/LccNcos4f5I0ce8/6kYyigm0EIGQiih1UEfMTR60n
 5HHlSyE2NuKhqxBP5Hhk0D2PmH+BOQAkYTqU07IjCKS9+07/dJAMhOaEDs2FRBFO3r5O
 J3lA==
X-Gm-Message-State: APjAAAVU2T/nNRF+9mjK+Mf7BeSfPZD0KcvlHFPKiIz4tpGVeQRxEMwi
 roLMNT27iR0iFfyzJSLxf6tghA==
X-Google-Smtp-Source: APXvYqyIDwSYb3eStEuPtrM0Rex2T0j+l+TQYto2KJBc+Yh6UUHyEr7wOu6OBinQYhxxiFV2ypWPwg==
X-Received: by 2002:a17:902:bb94:: with SMTP id
 m20mr5937248pls.336.1566581078461; 
 Fri, 23 Aug 2019 10:24:38 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s3sm4819284pgq.17.2019.08.23.10.24.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 10:24:37 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190823143249.8096-1-philmd@redhat.com>
 <20190823143249.8096-4-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5a686b01-c7e1-6839-40a7-be2c9d818a6d@linaro.org>
Date: Fri, 23 Aug 2019 10:24:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823143249.8096-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v2 3/6] hw/arm: Use sysbus_init_child_obj
 for correct reference counting
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 7:32 AM, Philippe Mathieu-Daudé wrote:
> diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
> index f69358a5ba..2781d8bd41 100644
> --- a/hw/arm/exynos4_boards.c
> +++ b/hw/arm/exynos4_boards.c
> @@ -131,8 +131,8 @@ exynos4_boards_init_common(MachineState *machine,
>      exynos4_boards_init_ram(s, get_system_memory(),
>                              exynos4_board_ram_size[board_type]);
>  
> -    object_initialize(&s->soc, sizeof(s->soc), TYPE_EXYNOS4210_SOC);
> -    qdev_set_parent_bus(DEVICE(&s->soc), sysbus_get_default());
> +    sysbus_init_child_obj(OBJECT(machine), "soc",
> +                          &s->soc, sizeof(s->soc), TYPE_EXYNOS4210_SOC);
>      object_property_set_bool(OBJECT(&s->soc), true, "realized",
>                               &error_fatal);

Thomas' comments re the commit message notwithstanding,
the patch itself is correct.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


