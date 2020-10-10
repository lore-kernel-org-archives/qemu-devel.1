Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3D6C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 16:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CD7223BD
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 16:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bORYwRCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CD7223BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRHaq-00032k-77
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 12:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRHa3-0002VW-Dc; Sat, 10 Oct 2020 12:18:47 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRHa1-0004za-Iv; Sat, 10 Oct 2020 12:18:47 -0400
Received: by mail-wm1-x343.google.com with SMTP id e23so5745989wme.2;
 Sat, 10 Oct 2020 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+hvGFuDvUtedq7zWw96MNl1ebw89wkfO3uQKU7C/lSI=;
 b=bORYwRCupTfWuRdHzWk/cgQpRDPKYXTUqQQALQ3f4r+XJwM9/yUCAH6secNiNKVaZJ
 X1NM5juSSw6i/lrY7OjgGObIcDwmKYC8FKIwpcgRfso6mZw++DVzDsSNtmsSRIg7ZeJX
 SpZaIXo28khI32qq4jDFuQ0iqNbPDPZlBVTuz+sbxRpt4YUnL17f7mP9VZ+fF0VTdr6T
 1AaJbLa+HUcmNaqhav0z69xNRwnrCc9fWuV1RCaehLgcBAEJ2QFaD7zJrihqkuxmkUP7
 9aCiwRWs7Uy6jpBtNtW4TqUmSTHpNw4gfqmTsJ0wGa+wTCdAvbbXmtaEmMgSMIovrcyd
 DXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+hvGFuDvUtedq7zWw96MNl1ebw89wkfO3uQKU7C/lSI=;
 b=mrSM5R7TIKXw5v3FUrwbueXYnctr5dfin2aT1Fg0fzTCfWZK+e9jaIx1SXjqwOuVJ6
 u5N01CwkuvQiG/DtSojR8BxLIhX/j1GGtXauMgB2Ngx571Ag8xrEcslf1ZP3JDZCRLpy
 BijxiEuEAcqztNhuc641/e4z5yU6FmGpfGNSRm7dvgRtVpw8c3P2No+ubZhcxjl/YvSo
 j3t3mKaExQaAa0Naa+aO5xKQPQSxEbTq96/xbzkS5RPxreOKB+rzTGdISpotPcqk4RSz
 hxnrqhrJ8NlZqJQwABOsVlkdMzn2874pnEMOWyigeADq4SgTKgnjZ7BUi/ZpUe+STlmj
 Pmnw==
X-Gm-Message-State: AOAM530AAIS3VD6vUWStSbR19KuBykAscVASr+qs2Cjqcr/I2+DyoqmN
 VCYeoQWeD6/TzkXZ7fUppxk=
X-Google-Smtp-Source: ABdhPJxlBeld7v7vEGwr02TRdac+p4jk8+3eZQzimfxpvm+3XBW3xl2HJaJU05+4b8u9aoNMEOYB/g==
X-Received: by 2002:a1c:ded7:: with SMTP id v206mr3173802wmg.183.1602346723628; 
 Sat, 10 Oct 2020 09:18:43 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u2sm17599134wre.7.2020.10.10.09.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2020 09:18:42 -0700 (PDT)
Subject: Re: [PATCH v3 13/15] hw/misc/bcm2835_cprman: add sane reset values to
 the registers
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20201010135759.437903-1-luc@lmichel.fr>
 <20201010135759.437903-14-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <48280560-3642-5367-a46e-53548e77c748@amsat.org>
Date: Sat, 10 Oct 2020 18:18:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201010135759.437903-14-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.207,
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

On 10/10/20 3:57 PM, Luc Michel wrote:
> Those reset values have been extracted from a Raspberry Pi 3 model B
> v1.2, using the 2020-08-20 version of raspios. The dump was done using
> the debugfs interface of the CPRMAN driver in Linux (under
> '/sys/kernel/debug/clk'). Each exposed clock tree stage (PLLs, channels
> and muxes) can be observed by reading the 'regdump' file (e.g.
> 'plla/regdump').
> 
> Those values are set by the Raspberry Pi firmware at boot time (Linux
> expects them to be set when it boots up).
> 
> Some stages are not exposed by the Linux driver (e.g. the PLL B). For
> those, the reset values are unknown and left to 0 which implies a
> disabled output.
> 
> Once booted in QEMU, the final clock tree is very similar to the one
> visible on real hardware. The differences come from some unimplemented
> devices for which the driver simply disable the corresponding clock.
> 
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>   include/hw/misc/bcm2835_cprman_internals.h | 269 +++++++++++++++++++++
>   hw/misc/bcm2835_cprman.c                   |  31 +++
>   2 files changed, 300 insertions(+)
> 
> diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
> index a6e799075f..339759b307 100644
> --- a/include/hw/misc/bcm2835_cprman_internals.h
> +++ b/include/hw/misc/bcm2835_cprman_internals.h
> @@ -745,6 +745,275 @@ static inline void set_clock_mux_init_info(BCM2835CprmanState *s,
>       mux->reg_div = &s->regs[CLOCK_MUX_INIT_INFO[id].cm_offset + 1];
>       mux->int_bits = CLOCK_MUX_INIT_INFO[id].int_bits;
>       mux->frac_bits = CLOCK_MUX_INIT_INFO[id].frac_bits;
>   }
>   
> +
> +/*
> + * Object reset info
> + * Those values have been dumped from a Raspberry Pi 3 Model B v1.2 using the
> + * clk debugfs interface in Linux.
> + */
> +typedef struct PLLResetInfo {
> +    uint32_t cm;
> +    uint32_t a2w_ctrl;
> +    uint32_t a2w_ana[4];
> +    uint32_t a2w_frac;
> +} PLLResetInfo;
> +
> +static const PLLResetInfo PLL_RESET_INFO[] = {
> +    [CPRMAN_PLLA] = {
> +        .cm = 0x0000008a,
> +        .a2w_ctrl = 0x0002103a,
> +        .a2w_frac = 0x00098000,
> +        .a2w_ana = { 0x00000000, 0x00144000, 0x00000000, 0x00000100 }
> +    },
> +
> +    [CPRMAN_PLLC] = {
> +        .cm = 0x00000228,
> +        .a2w_ctrl = 0x0002103e,
> +        .a2w_frac = 0x00080000,
> +        .a2w_ana = { 0x00000000, 0x00144000, 0x00000000, 0x00000100 }
> +    },
> +
> +    [CPRMAN_PLLD] = {
> +        .cm = 0x0000020a,
> +        .a2w_ctrl = 0x00021034,
> +        .a2w_frac = 0x00015556,
> +        .a2w_ana = { 0x00000000, 0x00144000, 0x00000000, 0x00000100 }
> +    },
> +
> +    [CPRMAN_PLLH] = {
> +        .cm = 0x00000000,
> +        .a2w_ctrl = 0x0002102d,
> +        .a2w_frac = 0x00000000,
> +        .a2w_ana = { 0x00900000, 0x0000000c, 0x00000000, 0x00000000 }
> +    },
> +
> +    [CPRMAN_PLLB] = {
> +        /* unknown */
> +        .cm = 0x00000000,
> +        .a2w_ctrl = 0x00000000,
> +        .a2w_frac = 0x00000000,
> +        .a2w_ana = { 0x00000000, 0x00000000, 0x00000000, 0x00000000 }
> +    }
> +};
> +
> +typedef struct PLLChannelResetInfo {
> +    /*
> +     * Even though a PLL channel has a CM register, it shares it with its
> +     * parent PLL. The parent already takes care of the reset value.
> +     */
> +    uint32_t a2w_ctrl;
> +} PLLChannelResetInfo;
> +
> +static const PLLChannelResetInfo PLL_CHANNEL_RESET_INFO[] = {
> +    [CPRMAN_PLLA_CHANNEL_DSI0] = { .a2w_ctrl = 0x00000100 },
> +    [CPRMAN_PLLA_CHANNEL_CORE] = { .a2w_ctrl = 0x00000003 },
> +    [CPRMAN_PLLA_CHANNEL_PER] = { .a2w_ctrl = 0x00000000 }, /* unknown */
> +    [CPRMAN_PLLA_CHANNEL_CCP2] = { .a2w_ctrl = 0x00000100 },
> +
> +    [CPRMAN_PLLC_CHANNEL_CORE2] = { .a2w_ctrl = 0x00000100 },
> +    [CPRMAN_PLLC_CHANNEL_CORE1] = { .a2w_ctrl = 0x00000100 },
> +    [CPRMAN_PLLC_CHANNEL_PER] = { .a2w_ctrl = 0x00000002 },
> +    [CPRMAN_PLLC_CHANNEL_CORE0] = { .a2w_ctrl = 0x00000002 },
> +
> +    [CPRMAN_PLLD_CHANNEL_DSI0] = { .a2w_ctrl = 0x00000100 },
> +    [CPRMAN_PLLD_CHANNEL_CORE] = { .a2w_ctrl = 0x00000004 },
> +    [CPRMAN_PLLD_CHANNEL_PER] = { .a2w_ctrl = 0x00000004 },
> +    [CPRMAN_PLLD_CHANNEL_DSI1] = { .a2w_ctrl = 0x00000100 },
> +
> +    [CPRMAN_PLLH_CHANNEL_AUX] = { .a2w_ctrl = 0x00000004 },
> +    [CPRMAN_PLLH_CHANNEL_RCAL] = { .a2w_ctrl = 0x00000000 },
> +    [CPRMAN_PLLH_CHANNEL_PIX] = { .a2w_ctrl = 0x00000000 },
> +
> +    [CPRMAN_PLLB_CHANNEL_ARM] = { .a2w_ctrl = 0x00000000 }, /* unknown */
> +};
> +
> +typedef struct ClockMuxResetInfo {
> +    uint32_t cm_ctl;
> +    uint32_t cm_div;
> +} ClockMuxResetInfo;
> +
> +static const ClockMuxResetInfo CLOCK_MUX_RESET_INFO[] = {
> +    [CPRMAN_CLOCK_GNRIC] = {
> +        .cm_ctl = 0, /* unknown */
> +        .cm_div = 0
> +    },
> +
[...]
> +};
> +
>   #endif
> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> index 7a7401963d..7e415a017c 100644
> --- a/hw/misc/bcm2835_cprman.c
> +++ b/hw/misc/bcm2835_cprman.c
> @@ -51,10 +51,21 @@
>   #include "hw/misc/bcm2835_cprman_internals.h"
>   #include "trace.h"
>   
>   /* PLL */
>   
> +static void pll_reset(DeviceState *dev)
> +{
> +    CprmanPllState *s = CPRMAN_PLL(dev);
> +    const PLLResetInfo *info = &PLL_RESET_INFO[s->id];

Hmm so we overwrite various values from PLL_INIT_INFO.
> +
> +    *s->reg_cm = info->cm;
> +    *s->reg_a2w_ctrl = info->a2w_ctrl;
> +    memcpy(s->reg_a2w_ana, info->a2w_ana, sizeof(info->a2w_ana));
> +    *s->reg_a2w_frac = info->a2w_frac;

set_pll_init_info() can be simplified as:

     pll->id = id;
     pll->prediv_mask = PLL_INIT_INFO[id].prediv_mask;

Or directly in cprman_init():

     &s->plls[i]->id = i;
     &s->plls[i]->prediv_mask = PLL_INIT_INFO[i].prediv_mask;

And the rest directly implemented in pll_reset().

Maybe not, but having pll_reset() added in patch #8/15
"bcm2835_cprman: add a PLL channel skeleton implementation"
would make this patch review easier ;)

> +}
> +
>   static bool pll_is_locked(const CprmanPllState *pll)
>   {
>       return !FIELD_EX32(*pll->reg_a2w_ctrl, A2W_PLLx_CTRL, PWRDN)
>           && !FIELD_EX32(*pll->reg_cm, CM_PLLx, ANARST);
>   }
> @@ -121,10 +132,11 @@ static const VMStateDescription pll_vmstate = {
>   
>   static void pll_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
> +    dc->reset = pll_reset;
>       dc->vmsd = &pll_vmstate;
>   }
[...]
Similarly, implement clock_mux_reset() in patch #10/15
"bcm2835_cprman: add a clock mux skeleton implementation".

Regards,

Phil.

