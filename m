Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3F9C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 16:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07C5223AE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 16:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs2Br57V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07C5223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRHON-00079H-Nv
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 12:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRHMs-0006BC-SM; Sat, 10 Oct 2020 12:05:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRHMm-0003Pz-60; Sat, 10 Oct 2020 12:05:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id h7so13541043wre.4;
 Sat, 10 Oct 2020 09:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2nPSaaA7Q+BjY2bKgyV9Pi4kxitgPgXj7hKiSMzaH1w=;
 b=bs2Br57VE46RSP0TFTr+fsE8CfwzYKiZ2sppjyEmqTLSMZ9wsxADDGLb+cxszJHebM
 JEyJHVT9URKnhyGid/yFnALpExG5FVWm+5qJojRlPxBFXSiBENuDDz605Z24jJQVoNSf
 GJmzezij0lEhfu2Ht6Qj+9Fk5jfid5+DvmvEeBxrvNNpiwhg/dDMOaT1rG3uRwTB6ZYD
 S4u+aetXsb9yMUQnGySGQlZhzhPkCAfCDgeKHcsQoP8JJvJGcIP0S2Jd70PEfypCN39V
 51oGD7I8eDFxcfkdAjefkEU+9X0dORdeM9+EasRV++7uJ3Td5SYcLdmex3V8GFq05s2x
 RsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2nPSaaA7Q+BjY2bKgyV9Pi4kxitgPgXj7hKiSMzaH1w=;
 b=oi5ouJqWMTueINjUz4tqnJEARrBLcOK3ZNxVKs2JWVgM2RLLn7WTsK3qQ8Qy/SPSTC
 Ww++7rbS/RpL5v0UxMtjKycaI0lQt0dTd6D6xzHP7fSnxD69ZJBuPUZCeKAJ+Xgm9KCw
 k4/9TQpk/YsILJcw0zWnPu4rKrN2K6ccGvmMMRgsFlbq84DMVsVVCUNnymqfjJ3AC/DH
 qiQZCUCYa7SY01Q0A+RushzyJAXXTGQJtExnXYdGKBNYVmiThTd67thu9mnKxzhtfIry
 SGddZqx2MVTBKBpZMuX5L0RFJjYYObDovvBneU+awfKqd0oYZuxzjEZVJh5lQenR2LMS
 FP8g==
X-Gm-Message-State: AOAM531dY2OSUieZEV7RsGBvvALfpxg4+ewyD1faRMtdL4UnaeFl+Rbo
 DX/g/NQKvDI8oMGvO8Ss4yo=
X-Google-Smtp-Source: ABdhPJzW9pBVSX3HVkLwHz9Uf1goZnZH04oLGe6G9a+DsaHBom61HoeOk2P+xBBzSfkwUFllFxP39w==
X-Received: by 2002:adf:a70b:: with SMTP id c11mr14827502wrd.257.1602345902172; 
 Sat, 10 Oct 2020 09:05:02 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id n2sm16200807wma.29.2020.10.10.09.05.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2020 09:05:01 -0700 (PDT)
Subject: Re: [PATCH v3 08/15] hw/misc/bcm2835_cprman: add a PLL channel
 skeleton implementation
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20201010135759.437903-1-luc@lmichel.fr>
 <20201010135759.437903-9-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e6e2341a-6ccc-b1cc-6e25-b3d57e1cae6d@amsat.org>
Date: Sat, 10 Oct 2020 18:05:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201010135759.437903-9-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
> PLLs are composed of multiple channels. Each channel outputs one clock
> signal. They are modeled as one device taking the PLL generated clock as
> input, and outputting a new clock.
> 
> A channel shares the CM register with its parent PLL, and has its own
> A2W_CTRL register. A write to the CM register will trigger an update of
> the PLL and all its channels, while a write to an A2W_CTRL channel
> register will update the required channel only.
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>   include/hw/misc/bcm2835_cprman.h           |  44 ++++++
>   include/hw/misc/bcm2835_cprman_internals.h | 146 +++++++++++++++++++
>   hw/misc/bcm2835_cprman.c                   | 155 +++++++++++++++++++--
>   3 files changed, 337 insertions(+), 8 deletions(-)
[...]

> diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
> index 7aa46c6e18..7409ddb024 100644
> --- a/include/hw/misc/bcm2835_cprman_internals.h
> +++ b/include/hw/misc/bcm2835_cprman_internals.h
> @@ -11,13 +11,16 @@
>   
>   #include "hw/registerfields.h"
>   #include "hw/misc/bcm2835_cprman.h"
>   
>   #define TYPE_CPRMAN_PLL "bcm2835-cprman-pll"
> +#define TYPE_CPRMAN_PLL_CHANNEL "bcm2835-cprman-pll-channel"
>   
>   DECLARE_INSTANCE_CHECKER(CprmanPllState, CPRMAN_PLL,
>                            TYPE_CPRMAN_PLL)
> +DECLARE_INSTANCE_CHECKER(CprmanPllChannelState, CPRMAN_PLL_CHANNEL,
> +                         TYPE_CPRMAN_PLL_CHANNEL)
>   
>   /* Register map */
>   
>   /* PLLs */
>   REG32(CM_PLLA, 0x104)
> @@ -98,10 +101,35 @@ REG32(A2W_PLLA_FRAC, 0x1200)
>   REG32(A2W_PLLC_FRAC, 0x1220)
>   REG32(A2W_PLLD_FRAC, 0x1240)
>   REG32(A2W_PLLH_FRAC, 0x1260)
>   REG32(A2W_PLLB_FRAC, 0x12e0)
>   
> +/* PLL channels */
> +REG32(A2W_PLLA_DSI0, 0x1300)
> +    FIELD(A2W_PLLx_CHANNELy, DIV, 0, 8)
> +    FIELD(A2W_PLLx_CHANNELy, DISABLE, 8, 1)
> +REG32(A2W_PLLA_CORE, 0x1400)
> +REG32(A2W_PLLA_PER, 0x1500)
> +REG32(A2W_PLLA_CCP2, 0x1600)
> +
> +REG32(A2W_PLLC_CORE2, 0x1320)
> +REG32(A2W_PLLC_CORE1, 0x1420)
> +REG32(A2W_PLLC_PER, 0x1520)
> +REG32(A2W_PLLC_CORE0, 0x1620)
> +
> +REG32(A2W_PLLD_DSI0, 0x1340)
> +REG32(A2W_PLLD_CORE, 0x1440)
> +REG32(A2W_PLLD_PER, 0x1540)
> +REG32(A2W_PLLD_DSI1, 0x1640)
> +
> +REG32(A2W_PLLH_AUX, 0x1360)
> +REG32(A2W_PLLH_RCAL, 0x1460)
> +REG32(A2W_PLLH_PIX, 0x1560)
> +REG32(A2W_PLLH_STS, 0x1660)
> +
> +REG32(A2W_PLLB_ARM, 0x13e0)
> +
>   /* misc registers */
>   REG32(CM_LOCK, 0x114)
>       FIELD(CM_LOCK, FLOCKH, 12, 1)
>       FIELD(CM_LOCK, FLOCKD, 11, 1)
>       FIELD(CM_LOCK, FLOCKC, 10, 1)
> @@ -171,6 +199,124 @@ static inline void set_pll_init_info(BCM2835CprmanState *s,
>       pll->reg_a2w_ana = &s->regs[PLL_INIT_INFO[id].a2w_ana_offset];
>       pll->prediv_mask = PLL_INIT_INFO[id].prediv_mask;
>       pll->reg_a2w_frac = &s->regs[PLL_INIT_INFO[id].a2w_frac_offset];
>   }
>   
> +
> +/* PLL channel init info */
> +typedef struct PLLChannelInitInfo {
> +    const char *name;
> +    CprmanPll parent;
> +    size_t cm_offset;
> +    uint32_t cm_hold_mask;
> +    uint32_t cm_load_mask;
> +    size_t a2w_ctrl_offset;
> +    unsigned int fixed_divider;
> +} PLLChannelInitInfo;
> +
> +#define FILL_PLL_CHANNEL_INIT_INFO_common(pll_, channel_)            \
> +    .parent = CPRMAN_ ## pll_,                                       \
> +    .cm_offset = R_CM_ ## pll_,                                      \
> +    .cm_load_mask = R_CM_ ## pll_ ## _ ## LOAD ## channel_ ## _MASK, \
> +    .a2w_ctrl_offset = R_A2W_ ## pll_ ## _ ## channel_
> +
> +#define FILL_PLL_CHANNEL_INIT_INFO(pll_, channel_)                   \
> +    FILL_PLL_CHANNEL_INIT_INFO_common(pll_, channel_),               \
> +    .cm_hold_mask = R_CM_ ## pll_ ## _ ## HOLD ## channel_ ## _MASK, \
> +    .fixed_divider = 1
> +
> +#define FILL_PLL_CHANNEL_INIT_INFO_nohold(pll_, channel_) \
> +    FILL_PLL_CHANNEL_INIT_INFO_common(pll_, channel_),    \
> +    .cm_hold_mask = 0
> +
> +static PLLChannelInitInfo PLL_CHANNEL_INIT_INFO[] = {

Hmm I missed this static definition in an header.
As it is local and only include once, I'd prefer match the
rest of the source tree style and name it .c.inc:

-- >8 --
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index 7e415a017c9..9d4c0ee6c73 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -48,7 +48,7 @@
  #include "migration/vmstate.h"
  #include "hw/qdev-properties.h"
  #include "hw/misc/bcm2835_cprman.h"
-#include "hw/misc/bcm2835_cprman_internals.h"
+#include "bcm2835_cprman_internals.c.inc"
  #include "trace.h"

  /* PLL */
diff --git a/include/hw/misc/bcm2835_cprman_internals.h 
b/hw/misc/bcm2835_cprman_internals.c.inc
similarity index 100%
rename from include/hw/misc/bcm2835_cprman_internals.h
rename to hw/misc/bcm2835_cprman_internals.c.inc
---
> +    [CPRMAN_PLLA_CHANNEL_DSI0] = {
> +        .name = "plla-dsi0",
> +        FILL_PLL_CHANNEL_INIT_INFO(PLLA, DSI0),
> +    },
> +    [CPRMAN_PLLA_CHANNEL_CORE] = {
> +        .name = "plla-core",
> +        FILL_PLL_CHANNEL_INIT_INFO(PLLA, CORE),
> +    },
> +    [CPRMAN_PLLA_CHANNEL_PER] = {
> +        .name = "plla-per",
> +        FILL_PLL_CHANNEL_INIT_INFO(PLLA, PER),
> +    },
> +    [CPRMAN_PLLA_CHANNEL_CCP2] = {
> +        .name = "plla-ccp2",
> +        FILL_PLL_CHANNEL_INIT_INFO(PLLA, CCP2),
> +    },
> +
> +    [CPRMAN_PLLC_CHANNEL_CORE2] = {
> +        .name = "pllc-core2",
> +        FILL_PLL_CHANNEL_INIT_INFO(PLLC, CORE2),
> +    },
> +    [CPRMAN_PLLC_CHANNEL_CORE1] = {
> +        .name = "pllc-core1",
> +        FILL_PLL_CHANNEL_INIT_INFO(PLLC, CORE1),
> +    },
> +    [CPRMAN_PLLC_CHANNEL_PER] = {
> +        .name = "pllc-per",
> +        FILL_PLL_CHANNEL_INIT_INFO(PLLC, PER),
> +    },
> +    [CPRMAN_PLLC_CHANNEL_CORE0] = {
> +        .name = "pllc-core0",
> +        FILL_PLL_CHANNEL_INIT_INFO(PLLC, CORE0),
> +    },
> +
> +    [CPRMAN_PLLD_CHANNEL_DSI0] = {
> +        .name = "plld-dsi0",
> +        FILL_PLL_CHANNEL_INIT_INFO(PLLD, DSI0),
> +    },
> +    [CPRMAN_PLLD_CHANNEL_CORE] = {
> +        .name = "plld-core",
> +        FILL_PLL_CHANNEL_INIT_INFO(PLLD, CORE),
> +    },
> +    [CPRMAN_PLLD_CHANNEL_PER] = {
> +        .name = "plld-per",
> +        FILL_PLL_CHANNEL_INIT_INFO(PLLD, PER),
> +    },
> +    [CPRMAN_PLLD_CHANNEL_DSI1] = {
> +        .name = "plld-dsi1",
> +        FILL_PLL_CHANNEL_INIT_INFO(PLLD, DSI1),
> +    },
> +
> +    [CPRMAN_PLLH_CHANNEL_AUX] = {
> +        .name = "pllh-aux",
> +        .fixed_divider = 1,
> +        FILL_PLL_CHANNEL_INIT_INFO_nohold(PLLH, AUX),
> +    },
> +    [CPRMAN_PLLH_CHANNEL_RCAL] = {
> +        .name = "pllh-rcal",
> +        .fixed_divider = 10,
> +        FILL_PLL_CHANNEL_INIT_INFO_nohold(PLLH, RCAL),
> +    },
> +    [CPRMAN_PLLH_CHANNEL_PIX] = {
> +        .name = "pllh-pix",
> +        .fixed_divider = 10,
> +        FILL_PLL_CHANNEL_INIT_INFO_nohold(PLLH, PIX),
> +    },
> +
> +    [CPRMAN_PLLB_CHANNEL_ARM] = {
> +        .name = "pllb-arm",
> +        FILL_PLL_CHANNEL_INIT_INFO(PLLB, ARM),
> +    },
> +};
> +
> +#undef FILL_PLL_CHANNEL_INIT_INFO_nohold
> +#undef FILL_PLL_CHANNEL_INIT_INFO
> +#undef FILL_PLL_CHANNEL_INIT_INFO_common
> +
> +static inline void set_pll_channel_init_info(BCM2835CprmanState *s,
> +                                             CprmanPllChannelState *channel,
> +                                             CprmanPllChannel id)
> +{
> +    channel->id = id;
> +    channel->parent = PLL_CHANNEL_INIT_INFO[id].parent;
> +    channel->reg_cm = &s->regs[PLL_CHANNEL_INIT_INFO[id].cm_offset];
> +    channel->hold_mask = PLL_CHANNEL_INIT_INFO[id].cm_hold_mask;
> +    channel->load_mask = PLL_CHANNEL_INIT_INFO[id].cm_load_mask;
> +    channel->reg_a2w_ctrl = &s->regs[PLL_CHANNEL_INIT_INFO[id].a2w_ctrl_offset];
> +    channel->fixed_divider = PLL_CHANNEL_INIT_INFO[id].fixed_divider;
> +}
> +
>   #endif
[...]

