Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28951C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB5C23719
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpfONm+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB5C23719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMHoo-0008Br-DA
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 17:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMHnh-0007dy-TM; Sat, 26 Sep 2020 17:32:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMHnf-0007oc-3e; Sat, 26 Sep 2020 17:32:13 -0400
Received: by mail-wr1-x443.google.com with SMTP id k10so4522492wru.6;
 Sat, 26 Sep 2020 14:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XsWdcWGbKQk1ZKeHqJ96I23uLNHb9FSNddBp6W4c2WI=;
 b=FpfONm+cZiPKSyMtm41w6m34dg/i4HN9c2PmCi3a5qZpGSlfieauwf92+WrPa/RXOS
 JQiqWKoIQ6q+6Vxtu4CXgg0MpXXhDG23H6Aog10VVTGsDufBk+ccHwP9EAyUR/0pi7Po
 w0rHhflshyEdh7uIjf5/KCbtKPBA7nHSIzNWRBhqpiBf0YfiTH1fHf+WPhJnE/w3WlI2
 W4LeCq3jvl7+XgoysNfMPnSw/EmZXA0Y+K+ERuCpOmdlKB5lIfqWkj7NwdlZtfjCjgif
 5Xj1kZgWreOrg0mab+9NDxD/ZjCsB7oF3PCzfAiu1DEZt8pDRwvuOt525j4q9cQfKzFq
 2KjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XsWdcWGbKQk1ZKeHqJ96I23uLNHb9FSNddBp6W4c2WI=;
 b=LFQu89WVT1UjvEom65RHn/7PaRSvFm1kxgMt0M2C1yc6llCnXs/mB0y3Ayhz9p5uq6
 1X/wAW50zNl97oEBgLm5EPoBjI8mi7LX34r53xdkrMmtcUe3ZyXmgPv77qZhUM7N+APY
 /YxLWFUBmDy9uX4mnaJtNJOoQxKLe1ie/ouFSdwla79JlVPzvYE7IIC1TvuAawbAohjS
 jHDbXLZFJMGsMZbjxXocI87Vctg8ZEYrdWH1IAzpRY1UsvRqC0ecg9o7WFZyS9BdaDi4
 VWvK633zrDEH86CI6j2bJWqeRxmg7VNDFDvAELaRT43eBYjGeevNfFISyz2n6atV1Z6k
 Tapg==
X-Gm-Message-State: AOAM532ltrW0ul4ZwyhSsa1suJMx2PNlVM5WLKqEJX56Mt4nN92G1viF
 8KsK5aQ6KyJxNkiolJ7ssS4=
X-Google-Smtp-Source: ABdhPJzxzFQgdFnuJm+aJQTMrRLZP0M0RBeWzDm4obYz5dd+IVWIRlP8rBB2TQMxHbOuq65rUq5/rA==
X-Received: by 2002:a5d:4f12:: with SMTP id c18mr10425146wru.33.1601155928939; 
 Sat, 26 Sep 2020 14:32:08 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id e1sm7961247wrp.49.2020.09.26.14.32.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 14:32:08 -0700 (PDT)
Subject: Re: [PATCH 07/14] hw/misc/bcm2835_cprman: add a PLL channel skeleton
 implementation
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-8-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a2387712-6cd2-fb0e-15b5-8763d080ad1b@amsat.org>
Date: Sat, 26 Sep 2020 23:32:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925101731.2159827-8-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.213,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 12:17 PM, Luc Michel wrote:
> PLLs are composed of multiple channels. Each channel outputs one clock
> signal. They are modeled as one device taking the PLL generated clock as
> input, and outputting a new clock.
> 
> A channel shares the cm register with its parent PLL, and has its own

CM.

> a2w_ctrl register. A write to the cm register will trigger an update of

A2W_ctrl? CM.

> the PLL and all its channels, while a write to an a2w_ctrl channel
> register will update the required channel only.
> 
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>  include/hw/misc/bcm2835_cprman.h           |  44 ++++++
>  include/hw/misc/bcm2835_cprman_internals.h | 146 +++++++++++++++++++
>  hw/misc/bcm2835_cprman.c                   | 155 +++++++++++++++++++--
>  3 files changed, 337 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/misc/bcm2835_cprman.h b/include/hw/misc/bcm2835_cprman.h
> index f186ab0104..aaf15fb20c 100644
> --- a/include/hw/misc/bcm2835_cprman.h
> +++ b/include/hw/misc/bcm2835_cprman.h
> @@ -29,10 +29,35 @@ typedef enum CprmanPLL {
>      CPRMAN_PLLB,
>  
>      CPRMAN_NUM_PLL
>  } CprmanPLL;
>  
> +typedef enum CprmanPLLChannel {
> +    CPRMAN_PLLA_CHANNEL_DSI0 = 0,
> +    CPRMAN_PLLA_CHANNEL_CORE,
> +    CPRMAN_PLLA_CHANNEL_PER,
> +    CPRMAN_PLLA_CHANNEL_CCP2,
> +
> +    CPRMAN_PLLC_CHANNEL_CORE2,
> +    CPRMAN_PLLC_CHANNEL_CORE1,
> +    CPRMAN_PLLC_CHANNEL_PER,
> +    CPRMAN_PLLC_CHANNEL_CORE0,
> +
> +    CPRMAN_PLLD_CHANNEL_DSI0,
> +    CPRMAN_PLLD_CHANNEL_CORE,
> +    CPRMAN_PLLD_CHANNEL_PER,
> +    CPRMAN_PLLD_CHANNEL_DSI1,
> +
> +    CPRMAN_PLLH_CHANNEL_AUX,
> +    CPRMAN_PLLH_CHANNEL_RCAL,
> +    CPRMAN_PLLH_CHANNEL_PIX,
> +
> +    CPRMAN_PLLB_CHANNEL_ARM,
> +
> +    CPRMAN_NUM_PLL_CHANNEL,
> +} CprmanPLLChannel;
> +
>  typedef struct CprmanPLLState {
>      /*< private >*/
>      DeviceState parent_obj;
>  
>      /*< public >*/
> @@ -46,18 +71,37 @@ typedef struct CprmanPLLState {
>  
>      Clock *xosc_in;
>      Clock *out;
>  } CprmanPLLState;
>  
> +typedef struct CprmanPLLChannelState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    CprmanPLLChannel id;
> +    CprmanPLL parent;
> +
> +    uint32_t *reg_cm;
> +    uint32_t hold_mask;
> +    uint32_t load_mask;
> +    uint32_t *reg_a2w_ctrl;
> +    int fixed_divider;
> +
> +    Clock *pll_in;
> +    Clock *out;
> +} CprmanPLLChannelState;
> +
>  struct BCM2835CprmanState {
>      /*< private >*/
>      SysBusDevice parent_obj;
>  
>      /*< public >*/
>      MemoryRegion iomem;
>  
>      CprmanPLLState plls[CPRMAN_NUM_PLL];
> +    CprmanPLLChannelState channels[CPRMAN_NUM_PLL_CHANNEL];
>  
>      uint32_t regs[CPRMAN_NUM_REGS];
>      uint32_t xosc_freq;
>  
>      Clock *xosc;
> diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
> index 22a2500ab0..8a5b9aae67 100644
> --- a/include/hw/misc/bcm2835_cprman_internals.h
> +++ b/include/hw/misc/bcm2835_cprman_internals.h
> @@ -11,13 +11,16 @@
>  
>  #include "hw/registerfields.h"
>  #include "hw/misc/bcm2835_cprman.h"
>  
>  #define TYPE_CPRMAN_PLL "bcm2835-cprman-pll"
> +#define TYPE_CPRMAN_PLL_CHANNEL "bcm2835-cprman-pll-channel"
>  
>  DECLARE_INSTANCE_CHECKER(CprmanPLLState, CPRMAN_PLL,
>                           TYPE_CPRMAN_PLL)
> +DECLARE_INSTANCE_CHECKER(CprmanPLLChannelState, CPRMAN_PLL_CHANNEL,
> +                         TYPE_CPRMAN_PLL_CHANNEL)
>  
>  /* Register map */
>  
>  /* PLLs */
>  REG32(CM_PLLA, 0x104)
> @@ -98,10 +101,35 @@ REG32(A2W_PLLA_FRAC, 0x1200)
>  REG32(A2W_PLLC_FRAC, 0x1220)
>  REG32(A2W_PLLD_FRAC, 0x1240)
>  REG32(A2W_PLLH_FRAC, 0x1260)
>  REG32(A2W_PLLB_FRAC, 0x12e0)
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
>  /* misc registers */
>  REG32(CM_LOCK, 0x114)
>      FIELD(CM_LOCK, FLOCKH, 12, 1)
>      FIELD(CM_LOCK, FLOCKD, 11, 1)
>      FIELD(CM_LOCK, FLOCKC, 10, 1)
> @@ -171,6 +199,124 @@ static inline void set_pll_init_info(BCM2835CprmanState *s,
>      pll->reg_a2w_ana = &s->regs[PLL_INIT_INFO[id].a2w_ana_offset];
>      pll->prediv_mask = PLL_INIT_INFO[id].prediv_mask;
>      pll->reg_a2w_frac = &s->regs[PLL_INIT_INFO[id].a2w_frac_offset];
>  }
>  
> +
> +/* PLL channel init info */
> +typedef struct PLLChannelInitInfo {
> +    const char *name;
> +    CprmanPLL parent;
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
> +                                             CprmanPLLChannelState *channel,
> +                                             CprmanPLLChannel id)
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
>  #endif
> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> index ba82522eb1..2c70a3f317 100644
> --- a/hw/misc/bcm2835_cprman.c
> +++ b/hw/misc/bcm2835_cprman.c
> @@ -130,10 +130,73 @@ static const TypeInfo cprman_pll_info = {
>      .class_init = pll_class_init,
>      .instance_init = pll_init,
>  };
>  
>  
> +/* PLL channel */
> +
> +static void pll_channel_update(CprmanPLLChannelState *channel)
> +{
> +    clock_update(channel->out, 0);
> +}
> +
> +/* Update a PLL and all its channels */
> +static void pll_update_all_channels(BCM2835CprmanState *s,
> +                                    CprmanPLLState *pll)
> +{
> +    size_t i;
> +
> +    pll_update(pll);
> +
> +    for (i = 0; i < CPRMAN_NUM_PLL_CHANNEL; i++) {
> +        CprmanPLLChannelState *channel = &s->channels[i];
> +        if (channel->parent == pll->id) {
> +            pll_channel_update(channel);
> +        }
> +    }
> +}
> +
> +static void pll_channel_pll_in_update(void *opaque)
> +{
> +    pll_channel_update(CPRMAN_PLL_CHANNEL(opaque));
> +}
> +
> +static void pll_channel_init(Object *obj)
> +{
> +    CprmanPLLChannelState *s = CPRMAN_PLL_CHANNEL(obj);
> +
> +    s->pll_in = qdev_init_clock_in(DEVICE(s), "pll-in",
> +                                   pll_channel_pll_in_update, s);
> +    s->out = qdev_init_clock_out(DEVICE(s), "out");
> +}
> +
> +static const VMStateDescription pll_channel_vmstate = {
> +    .name = TYPE_CPRMAN_PLL_CHANNEL,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_CLOCK(pll_in, CprmanPLLChannelState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void pll_channel_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->vmsd = &pll_channel_vmstate;
> +}
> +
> +static const TypeInfo cprman_pll_channel_info = {
> +    .name = TYPE_CPRMAN_PLL_CHANNEL,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(CprmanPLLChannelState),
> +    .class_init = pll_channel_class_init,
> +    .instance_init = pll_channel_init,
> +};
> +
> +
>  /* CPRMAN "top level" model */
>  
>  static uint32_t get_cm_lock(const BCM2835CprmanState *s)
>  {
>      static const int CM_LOCK_MAPPING[] = {
> @@ -172,12 +235,36 @@ static uint64_t cprman_read(void *opaque, hwaddr offset,
>  
>      trace_bcm2835_cprman_read(offset, r);
>      return r;
>  }
>  
> -#define CASE_PLL_REGS(pll_)       \
> -    case R_CM_ ## pll_:           \
> +static inline void update_pll_and_channels_from_cm(BCM2835CprmanState *s,
> +                                                   size_t idx)
> +{
> +    size_t i;
> +
> +    for (i = 0; i < CPRMAN_NUM_PLL; i++) {
> +        if (PLL_INIT_INFO[i].cm_offset == idx) {
> +            pll_update_all_channels(s, &s->plls[i]);
> +            return;
> +        }
> +    }
> +}
> +
> +static inline void update_channel_from_a2w(BCM2835CprmanState *s, size_t idx)
> +{
> +    size_t i;
> +
> +    for (i = 0; i < CPRMAN_NUM_PLL_CHANNEL; i++) {
> +        if (PLL_CHANNEL_INIT_INFO[i].a2w_ctrl_offset == idx) {
> +            pll_channel_update(&s->channels[i]);
> +            return;
> +        }
> +    }
> +}
> +
> +#define CASE_PLL_A2W_REGS(pll_) \
>      case R_A2W_ ## pll_ ## _CTRL: \
>      case R_A2W_ ## pll_ ## _ANA0: \
>      case R_A2W_ ## pll_ ## _ANA1: \
>      case R_A2W_ ## pll_ ## _ANA2: \
>      case R_A2W_ ## pll_ ## _ANA3: \
> @@ -198,33 +285,61 @@ static void cprman_write(void *opaque, hwaddr offset,
>  
>      trace_bcm2835_cprman_write(offset, value);
>      s->regs[idx] = value;
>  
>      switch (idx) {
> -    CASE_PLL_REGS(PLLA) :
> +    case R_CM_PLLA ... R_CM_PLLH:
> +    case R_CM_PLLB:
> +        /*
> +         * A given CM_PLLx register is shared by both the PLL and the channels
> +         * of this PLL.
> +         */
> +        update_pll_and_channels_from_cm(s, idx);
> +        break;
> +
> +    CASE_PLL_A2W_REGS(PLLA) :
>          pll_update(&s->plls[CPRMAN_PLLA]);
>          break;
>  
> -    CASE_PLL_REGS(PLLC) :
> +    CASE_PLL_A2W_REGS(PLLC) :
>          pll_update(&s->plls[CPRMAN_PLLC]);
>          break;
>  
> -    CASE_PLL_REGS(PLLD) :
> +    CASE_PLL_A2W_REGS(PLLD) :
>          pll_update(&s->plls[CPRMAN_PLLD]);
>          break;
>  
> -    CASE_PLL_REGS(PLLH) :
> +    CASE_PLL_A2W_REGS(PLLH) :
>          pll_update(&s->plls[CPRMAN_PLLH]);
>          break;
>  
> -    CASE_PLL_REGS(PLLB) :
> +    CASE_PLL_A2W_REGS(PLLB) :
>          pll_update(&s->plls[CPRMAN_PLLB]);
>          break;
> +
> +    case R_A2W_PLLA_DSI0:
> +    case R_A2W_PLLA_CORE:
> +    case R_A2W_PLLA_PER:
> +    case R_A2W_PLLA_CCP2:
> +    case R_A2W_PLLC_CORE2:
> +    case R_A2W_PLLC_CORE1:
> +    case R_A2W_PLLC_PER:
> +    case R_A2W_PLLC_CORE0:
> +    case R_A2W_PLLD_DSI0:
> +    case R_A2W_PLLD_CORE:
> +    case R_A2W_PLLD_PER:
> +    case R_A2W_PLLD_DSI1:
> +    case R_A2W_PLLH_AUX:
> +    case R_A2W_PLLH_RCAL:
> +    case R_A2W_PLLH_PIX:
> +    case R_A2W_PLLB_ARM:
> +        update_channel_from_a2w(s, idx);
> +        break;
>      }
>  }
>  
> -#undef CASE_PLL_REGS
> +#undef CASE_PLL_A2W_REGS
>  
>  static const MemoryRegionOps cprman_ops = {
>      .read = cprman_read,
>      .write = cprman_write,
>      .endianness = DEVICE_LITTLE_ENDIAN,
> @@ -244,10 +359,14 @@ static void cprman_reset(DeviceState *dev)
>  
>      for (i = 0; i < CPRMAN_NUM_PLL; i++) {
>          device_cold_reset(DEVICE(&s->plls[i]));
>      }
>  
> +    for (i = 0; i < CPRMAN_NUM_PLL_CHANNEL; i++) {
> +        device_cold_reset(DEVICE(&s->channels[i]));
> +    }
> +
>      clock_update_hz(s->xosc, s->xosc_freq);
>  }
>  
>  static Clock *init_internal_clock(BCM2835CprmanState *s,
>                                    const char *name)
> @@ -274,10 +393,17 @@ static void cprman_init(Object *obj)
>          object_initialize_child(obj, PLL_INIT_INFO[i].name,
>                                  &s->plls[i], TYPE_CPRMAN_PLL);
>          set_pll_init_info(s, &s->plls[i], i);
>      }
>  
> +    for (i = 0; i < CPRMAN_NUM_PLL_CHANNEL; i++) {
> +        object_initialize_child(obj, PLL_CHANNEL_INIT_INFO[i].name,
> +                                &s->channels[i],
> +                                TYPE_CPRMAN_PLL_CHANNEL);
> +        set_pll_channel_init_info(s, &s->channels[i], i);
> +    }
> +
>      s->xosc = init_internal_clock(s, "xosc");
>  
>      memory_region_init_io(&s->iomem, obj, &cprman_ops,
>                            s, "bcm2835-cprman", 0x2000);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
> @@ -295,10 +421,22 @@ static void cprman_realize(DeviceState *dev, Error **errp)
>  
>          if (!qdev_realize(DEVICE(pll), NULL, errp)) {
>              return;
>          }
>      }
> +
> +    for (i = 0; i < CPRMAN_NUM_PLL_CHANNEL; i++) {
> +        CprmanPLLChannelState *channel = &s->channels[i];
> +        CprmanPLL parent = PLL_CHANNEL_INIT_INFO[i].parent;
> +        Clock *parent_clk = s->plls[parent].out;
> +
> +        clock_set_source(channel->pll_in, parent_clk);
> +
> +        if (!qdev_realize(DEVICE(channel), NULL, errp)) {
> +            return;
> +        }
> +    }
>  }
>  
>  static const VMStateDescription cprman_vmstate = {
>      .name = TYPE_BCM2835_CPRMAN,
>      .version_id = 1,
> @@ -334,8 +472,9 @@ static const TypeInfo cprman_info = {
>  
>  static void cprman_register_types(void)
>  {
>      type_register_static(&cprman_info);
>      type_register_static(&cprman_pll_info);
> +    type_register_static(&cprman_pll_channel_info);
>  }
>  
>  type_init(cprman_register_types);
> 

Chapeau!

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

