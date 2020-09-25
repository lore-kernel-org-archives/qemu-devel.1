Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A881C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB832076B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUnsQT7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB832076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnSU-0002yi-37
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLnGU-0004cZ-9t; Fri, 25 Sep 2020 08:55:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLnGR-0001wV-Pt; Fri, 25 Sep 2020 08:55:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id x14so3455240wrl.12;
 Fri, 25 Sep 2020 05:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=E66i6/ZzpAgvqmQvZR6jcwUy6QGSNRPMsP3NXLcqhtg=;
 b=JUnsQT7s+uys+cl4zufD7hdUunBqmV6W0JQ0UT+28XeykSmpxuIqbbIbOjfHkt4paa
 fRsDgH4voP1YatOEOEFeMyPFFKMlR1ubgbpSIQ2dZt9uCVFjxUFRdxgyOR8CQvDi+KuI
 +RHtQy2FJh6NRuCdX076ulJU+V9ehhfrRUdJcLhCrEHrY+B045xjU4ca6O0Zl44xfSCn
 4P9BMxmE6Hcq0pct7IUPQPL72he3Xn7zABmywW/Pe04gSiuvdnIScSkaVyuwGy9Qm6r/
 jEZGpKmNeuQiBB7ZgOLEdeIuxozMc/MJmYmloOgK3pqDHLApjDeRHIVYDSQllfNp4q75
 ENUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E66i6/ZzpAgvqmQvZR6jcwUy6QGSNRPMsP3NXLcqhtg=;
 b=eha8NYSZwUonAOLFwjD0ETqkLNdQU295trfyBlf2qQx4JKxHpLrkubxqf8QNWS5EK8
 wY9482iZ/bGpMJEzJpW4PuMB3xwEcUL3xHxbyAr6QO/7x/b/EyQM8U2WTN2ldgPW4igm
 zd4GAodVb7XvTlyFVmnG0h3wzF+xH049Wp+E+/1owd+7F2NjB4hJ+v3Kwg30Fzh/BGWu
 6NIkZqwBnwKLK530o6o3RjU4BEAIiRhH/Vzd80lOdVn6DEqDRiFy+WiWnQ9lLMLjGA+R
 7XGVdE8cZPYqUXk9JhDFKjENEhx++68jqpj0zqSW6JsvbVX1ZZOeVfm3EHYvkwQZnS9e
 VqIQ==
X-Gm-Message-State: AOAM533ZmJMtYlwvcW2MQFwYMnsO0VE9Akz6CqMcZoj09B7WMMmxkJqM
 RkPB9KAZ9VeIEMfeGnFG8Gg=
X-Google-Smtp-Source: ABdhPJyvTDqsVBaIFBY5W/s+86+8hjpdyqZsECsGHavxD1mZhQW8wLqZ3364h+WfcY2EeMYkU4Iq3g==
X-Received: by 2002:adf:ef03:: with SMTP id e3mr4192604wro.146.1601038549255; 
 Fri, 25 Sep 2020 05:55:49 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id u126sm3605884wmu.9.2020.09.25.05.55.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 05:55:48 -0700 (PDT)
Subject: Re: [PATCH 00/14] raspi: add the bcm2835 cprman clock manager
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20200925101731.2159827-1-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <81da166c-a5de-e91e-15a8-5fdd08984423@amsat.org>
Date: Fri, 25 Sep 2020 14:55:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925101731.2159827-1-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.238,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Paul/Niek/Havard.

On 9/25/20 12:17 PM, Luc Michel wrote:
> Hi,
> 
> This series add the BCM2835 cprman clock manager peripheral to the
> Raspberry Pi machine.
> 
> Patches 1-3 are preliminary changes, patches 4-12 are the actual
> implementation.
> 
> The two last patches add a clock input to the PL011 and
> connect it to the cprman and are RFC.
> 
> This series has been tested with Linux 5.4.61 (the current raspios
> version). It fixes the kernel Oops at boot time due to invalid UART
> clock value, and other warnings/errors here and there because of bad
> clocks or lack of cprman.
> 
> Here is the clock tree as seen by Linux when booted in QEMU:
> (/sys/kernel/debug/clk/clk_summary with some columns removed)
> 
>                         enable  prepare              
>    clock                 count    count          rate
> -----------------------------------------------------
>  otg                         0        0     480000000
>  osc                         5        5      19200000
>     gp2                      1        1         32768
>     tsens                    0        0       1920000
>     otp                      0        0       4800000
>     timer                    0        0       1000002
>     pllh                     4        4     864000000
>        pllh_pix_prediv       1        1       3375000
>           pllh_pix           0        0        337500
>        pllh_aux              1        1     216000000
>           vec                0        0     108000000
>        pllh_rcal_prediv      1        1       3375000
>           pllh_rcal          0        0        337500
>     plld                     3        3    2000000024
>        plld_dsi1             0        0       7812501
>        plld_dsi0             0        0       7812501
>        plld_per              3        3     500000006
>           gp1                1        1      25000000
>           uart               1        2      47999625
>        plld_core             2        2     500000006
>           sdram              0        0     166666668
>     pllc                     3        3    2400000000
>        pllc_per              1        1    1200000000
>           emmc               0        0     200000000
>        pllc_core2            0        0       9375000
>        pllc_core1            0        0       9375000
>        pllc_core0            2        2    1200000000
>           vpu                1        1     700000000
>              aux_spi2        0        0     700000000
>              aux_spi1        0        0     700000000
>              aux_uart        0        0     700000000
>              peri_image      0        0     700000000
>     plla                     2        2    2250000000
>        plla_ccp2             0        0       8789063
>        plla_dsi0             0        0       8789063
>        plla_core             1        1     750000000
>           h264               0        0     250000000
>           isp                0        0     250000000
>  dsi1p                       0        0             0
>  dsi0p                       0        0             0
>  dsi1e                       0        0             0
>  dsi0e                       0        0             0
>  cam1                        0        0             0
>  cam0                        0        0             0
>  dpi                         0        0             0
>  tec                         0        0             0
>  smi                         0        0             0
>  slim                        0        0             0
>  gp0                         0        0             0
>  dft                         0        0             0
>  aveo                        0        0             0
>  pcm                         0        0             0
>  pwm                         0        0             0
>  hsm                         0        0             0
> 
> It shows small differences with real hardware due other missing
> peripherals for which the driver turn the clock off (like tsens).
> 
> Luc Michel (14):
>   hw/core/clock: provide the VMSTATE_ARRAY_CLOCK macro
>   hw/core/clock: trace clock values in Hz instead of ns
>   hw/arm/raspi: fix cprman base address
>   hw/arm/raspi: add a skeleton implementation of the cprman
>   hw/misc/bcm2835_cprman: add a PLL skeleton implementation
>   hw/misc/bcm2835_cprman: implement PLLs behaviour
>   hw/misc/bcm2835_cprman: add a PLL channel skeleton implementation
>   hw/misc/bcm2835_cprman: implement PLL channels behaviour
>   hw/misc/bcm2835_cprman: add a clock mux skeleton implementation
>   hw/misc/bcm2835_cprman: implement clock mux behaviour
>   hw/misc/bcm2835_cprman: add the DSI0HSCK multiplexer
>   hw/misc/bcm2835_cprman: add sane reset values to the registers
>   hw/char/pl011: add a clock input
>   hw/arm/bcm2835_peripherals: connect the UART clock
> 

>  14 files changed, 2118 insertions(+), 12 deletions(-)
ouch... o_O huge device...

Tested on top of my raspi branch with raspi[0123]:
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

