Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855EDCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463112086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDdSbRBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463112086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMbIp-0004ey-Df
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMbGC-0002Lw-EO
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMbGB-0008L3-5T
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:14:24 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMbGA-0008Kb-Mx
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:14:23 -0400
Received: by mail-pf1-x444.google.com with SMTP id 205so8821340pfw.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NzCeMUspjaV8z1Jvc6HJ+8Su3NYeHe4yKC/Lo+xgLLU=;
 b=IDdSbRBpYob1oa2wdeQpKvcViRPSVCKxXkJUK4rZCzALKJr75xfPw7aofR3mmXqn1s
 9Xw8q1c8tje/4eZSPNSI+UXPnQPLhOsj8E65YhgFpl6aT0jhaapgXGCe33vopzBFq/Q/
 0wlSHJSP1SqlLzsxfybD5D++FA/71a7p43s58htX1AN2bUewIo94ugs/xxxR5IpGC1st
 JNtOBdH1KwgGjTAQx7kXZ/iyCvmdar4w06QUySwmH3gF4U7L2KYTvErxvOu1N7tKyuSl
 WZeSqd3DjuGKC69AQxmvmQOkfm2oeeC7btBggURffss1yEs79FLjLDn4RI8uCo1zyf/6
 elZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NzCeMUspjaV8z1Jvc6HJ+8Su3NYeHe4yKC/Lo+xgLLU=;
 b=Jlp2ryRSaQKbs3zpJE11k++JzbBW2eWJF3aSHBJJKE9HGR6aUjwTB8iHGazT+TD80m
 hsmom1NYjlOXl42i3uAtkE4h0LjK4OnDMokCJGYEpinZl5fhoXNoqfmhwXPPtuBbGuho
 KWUL13lRqZVrpp1XIQTbyEtSLuJNRtc96ttKfsLQ6mBfcUmo7HQFMOIhHG3UPZFnMM77
 CycLtjQWpfTxWdn4MNYK1mq3V1E1qFZmr4Tt3UEmPAvwr3qE/tjtVweigvuc/PfOE7Ft
 h6C4sIiQWYOwRFzsmRnSqoocFRl6hXK0erSfMfLsCgNCQwdl6yPuty+zrn9VtRYTopef
 jhZQ==
X-Gm-Message-State: APjAAAV2ywTVLUm80i38paE3GZz7w0etc2lDIQJZDePeWCsCTx1fQ1S8
 /hV7KCUj+JVPp6rotINMxIBLpQ==
X-Google-Smtp-Source: APXvYqySrRgx2F0rtJgF2KS4zJ6QwleSx43Y0W0xctjp6SXCrr5ZUz7BXTKryAJAg+4R6Mk0FtM8Gg==
X-Received: by 2002:a17:90a:c48:: with SMTP id
 u8mr30845101pje.16.1571678061062; 
 Mon, 21 Oct 2019 10:14:21 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z12sm18058953pfj.41.2019.10.21.10.14.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 10:14:20 -0700 (PDT)
Subject: Re: [PATCH 11/21] hw/alpha: Let the machine be the owner of the
 system memory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-12-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ed804be1-8516-3dbc-d738-20c2b03e5309@linaro.org>
Date: Mon, 21 Oct 2019 10:14:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020225650.3671-12-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/19 3:56 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/alpha/dp264.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index ddc249261c..5696b1e79b 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -78,7 +78,7 @@ static void clipper_init(MachineState *machine)
>       * Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
>       * but the address space hole reserved at this point is 8TB.
>       */
> -    memory_region_allocate_system_memory(&ram_region, NULL, "ram",
> +    memory_region_allocate_system_memory(&ram_region, machine, "ram",
>                                           ram_size);
>      memory_region_add_subregion(get_system_memory(), 0, &ram_region);
>  
> 

I take it this squishes into the squish of patches 7+9?


r~

