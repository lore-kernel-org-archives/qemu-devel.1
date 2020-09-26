Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1A3C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B29E21531
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utk8yCMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B29E21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMHav-0003z8-56
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 17:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMHZw-0003M2-TL; Sat, 26 Sep 2020 17:18:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34470)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMHZu-0006Nz-HX; Sat, 26 Sep 2020 17:18:00 -0400
Received: by mail-wr1-x441.google.com with SMTP id t10so7669238wrv.1;
 Sat, 26 Sep 2020 14:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LDCgahYT6qhYEnEZ+Hh/Kwyp3fo8hXXlAIhHnpEtn5M=;
 b=utk8yCMXNAUxEgib1rs03y4rdha3idIj8QqDY8KHonE9m66cF+2biah8Jg51sQBYd0
 uoe+Dl8hTMwLJcVlvA0+zMkQ+lgl5ZhzUrjbYT9kgbQXJWqW9JL7f8XSOW8cGrF/X9vh
 qvKgGcZX1oIPEfR4+fdaXg9nKcgUmPc7u16ZaClFhILemq10aAJVEIvSwZQpugg5JVQ2
 tT5VVZFejlqkjlBxDFm9iSxllKDlo1/po48yeOzE22xm4XcrDhZbf5KQB9+y1SftX8+L
 UUDZYB4gwYVXvSFZPxfCVIpLtJe+vVoc8qKElzCPfESlF+9txw7d5Q+IVZ3ZlHptuDzd
 EEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LDCgahYT6qhYEnEZ+Hh/Kwyp3fo8hXXlAIhHnpEtn5M=;
 b=k4cxg3jnr1gvrQcGOOKeik5emc1kSfnFbzJbFZnZkSkHQ19vEsyErr2ugoQ7WKVMNE
 oPI4Yyac89WPkRSPy72yj21tVlYXC+alUIs/gThxR9Ap1IKMsC1tgXXTK2aJZ2PRv0WM
 p7YDinO0tPUYdlguaxGyb4rAVLGl8IacIaOvLAv2s7p8u89o2J5lq7hGbWkoHdwMHzKm
 Wmt6lljZQMeL0+xrzl51iKuT5vtkEkexsQTXLQktlqRlFvj6wEUhDP6SYMg/j1yplJYg
 z/e2VUougNQuw4CZyGjQ0aaIB0YG24fQf2Ejuw1biFvOb5G+308naOtw3UhP1CPmdWsn
 l2Bw==
X-Gm-Message-State: AOAM530X/53fpFLKtPze9ivz+lxO1blb4M23bsdfUqb5OkL5k5raqyQT
 o5X/ZpLcJXnjDEMmeXC1lnY=
X-Google-Smtp-Source: ABdhPJwnUa9ydf/2v/Hy4wHoD2SGtwCHH/65zpTzD4KYoSPzc8RHSo/GD+NFqGhcKQ/yQfbu92RJrg==
X-Received: by 2002:adf:8b48:: with SMTP id v8mr10991302wra.21.1601155076481; 
 Sat, 26 Sep 2020 14:17:56 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id k6sm3568099wmf.30.2020.09.26.14.17.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 14:17:55 -0700 (PDT)
Subject: Re: [PATCH 05/14] hw/misc/bcm2835_cprman: add a PLL skeleton
 implementation
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-6-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <086f93ad-dfa3-fa0c-4d96-7b3f71ce3708@amsat.org>
Date: Sat, 26 Sep 2020 23:17:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925101731.2159827-6-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8
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
> There is 5 PLLs in the cprman, namely PLL A, C, D, H and B. All of them
> take the xosc clock as input and produce a new clock.

Typo "There are"?

> 
> This commit adds a skeleton implementation for the PLLs as sub-devices
> of the cprman. The PLLs are instantiated and connected internally to the
> main oscillator.

"CPRMAN".

> 
> Each PLL has 6 registers : cm, a2w_ctrl, a2w_ana[0,1,2,3], a2w_frac. A
> write to any of them triggers a call to the (not yet implemented)
> pll_update function.

[new line]

> If the main oscillator changes frequency, an update
> is also triggered.
> 
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>  include/hw/misc/bcm2835_cprman.h           |  29 +++++
>  include/hw/misc/bcm2835_cprman_internals.h | 144 +++++++++++++++++++++
>  hw/misc/bcm2835_cprman.c                   | 108 ++++++++++++++++
>  3 files changed, 281 insertions(+)
> 
> diff --git a/include/hw/misc/bcm2835_cprman.h b/include/hw/misc/bcm2835_cprman.h
> index de9bd01b23..f186ab0104 100644
> --- a/include/hw/misc/bcm2835_cprman.h
> +++ b/include/hw/misc/bcm2835_cprman.h
> @@ -19,17 +19,46 @@ typedef struct BCM2835CprmanState BCM2835CprmanState;
>  DECLARE_INSTANCE_CHECKER(BCM2835CprmanState, CPRMAN,
>                           TYPE_BCM2835_CPRMAN)
>  
>  #define CPRMAN_NUM_REGS (0x2000 / sizeof(uint32_t))
>  
> +typedef enum CprmanPLL {
> +    CPRMAN_PLLA = 0,
> +    CPRMAN_PLLC,
> +    CPRMAN_PLLD,
> +    CPRMAN_PLLH,
> +    CPRMAN_PLLB,
> +
> +    CPRMAN_NUM_PLL
> +} CprmanPLL;

CamelCase "CprmanPll"?

> +
> +typedef struct CprmanPLLState {

"CprmanPllState"?

> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    CprmanPLL id;
> +
> +    uint32_t *reg_cm;
> +    uint32_t *reg_a2w_ctrl;
> +    uint32_t *reg_a2w_ana;
> +    uint32_t prediv_mask; /* prediv bit in ana[1] */
> +    uint32_t *reg_a2w_frac;
> +
> +    Clock *xosc_in;
> +    Clock *out;
> +} CprmanPLLState;
> +
>  struct BCM2835CprmanState {
>      /*< private >*/
>      SysBusDevice parent_obj;
>  
>      /*< public >*/
>      MemoryRegion iomem;
>  
> +    CprmanPLLState plls[CPRMAN_NUM_PLL];
> +
>      uint32_t regs[CPRMAN_NUM_REGS];
>      uint32_t xosc_freq;
>  
>      Clock *xosc;
>  };
> diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
> index 6a10b60930..5cfa849492 100644
> --- a/include/hw/misc/bcm2835_cprman_internals.h
> +++ b/include/hw/misc/bcm2835_cprman_internals.h
> @@ -10,15 +10,159 @@
>  #define HW_MISC_CPRMAN_INTERNALS_H
>  
>  #include "hw/registerfields.h"
>  #include "hw/misc/bcm2835_cprman.h"
>  
> +#define TYPE_CPRMAN_PLL "bcm2835-cprman-pll"
> +
> +DECLARE_INSTANCE_CHECKER(CprmanPLLState, CPRMAN_PLL,
> +                         TYPE_CPRMAN_PLL)
> +
>  /* Register map */
>  
> +/* PLLs */
> +REG32(CM_PLLA, 0x104)
> +    FIELD(CM_PLLA, LOADDSI0, 0, 1)
> +    FIELD(CM_PLLA, HOLDDSI0, 1, 1)
> +    FIELD(CM_PLLA, LOADCCP2, 2, 1)
> +    FIELD(CM_PLLA, HOLDCCP2, 3, 1)
> +    FIELD(CM_PLLA, LOADCORE, 4, 1)
> +    FIELD(CM_PLLA, HOLDCORE, 5, 1)
> +    FIELD(CM_PLLA, LOADPER, 6, 1)
> +    FIELD(CM_PLLA, HOLDPER, 7, 1)
> +    FIELD(CM_PLLx, ANARST, 8, 1)
> +REG32(CM_PLLC, 0x108)
> +    FIELD(CM_PLLC, LOADCORE0, 0, 1)
> +    FIELD(CM_PLLC, HOLDCORE0, 1, 1)
> +    FIELD(CM_PLLC, LOADCORE1, 2, 1)
> +    FIELD(CM_PLLC, HOLDCORE1, 3, 1)
> +    FIELD(CM_PLLC, LOADCORE2, 4, 1)
> +    FIELD(CM_PLLC, HOLDCORE2, 5, 1)
> +    FIELD(CM_PLLC, LOADPER, 6, 1)
> +    FIELD(CM_PLLC, HOLDPER, 7, 1)
> +REG32(CM_PLLD, 0x10c)
> +    FIELD(CM_PLLD, LOADDSI0, 0, 1)
> +    FIELD(CM_PLLD, HOLDDSI0, 1, 1)
> +    FIELD(CM_PLLD, LOADDSI1, 2, 1)
> +    FIELD(CM_PLLD, HOLDDSI1, 3, 1)
> +    FIELD(CM_PLLD, LOADCORE, 4, 1)
> +    FIELD(CM_PLLD, HOLDCORE, 5, 1)
> +    FIELD(CM_PLLD, LOADPER, 6, 1)
> +    FIELD(CM_PLLD, HOLDPER, 7, 1)
> +REG32(CM_PLLH, 0x110)
> +    FIELD(CM_PLLH, LOADPIX, 0, 1)
> +    FIELD(CM_PLLH, LOADAUX, 1, 1)
> +    FIELD(CM_PLLH, LOADRCAL, 2, 1)
> +REG32(CM_PLLB, 0x170)
> +    FIELD(CM_PLLB, LOADARM, 0, 1)
> +    FIELD(CM_PLLB, HOLDARM, 1, 1)
> +
> +REG32(A2W_PLLA_CTRL, 0x1100)
> +    FIELD(A2W_PLLx_CTRL, NDIV, 0, 10)
> +    FIELD(A2W_PLLx_CTRL, PDIV, 12, 3)
> +    FIELD(A2W_PLLx_CTRL, PWRDN, 16, 1)
> +    FIELD(A2W_PLLx_CTRL, PRST_DISABLE, 17, 1)
> +REG32(A2W_PLLC_CTRL, 0x1120)
> +REG32(A2W_PLLD_CTRL, 0x1140)
> +REG32(A2W_PLLH_CTRL, 0x1160)
> +REG32(A2W_PLLB_CTRL, 0x11e0)
> +
> +REG32(A2W_PLLA_ANA0, 0x1010)
> +REG32(A2W_PLLA_ANA1, 0x1014)
> +    FIELD(A2W_PLLx_ANA1, FB_PREDIV, 14, 1)
> +REG32(A2W_PLLA_ANA2, 0x1018)
> +REG32(A2W_PLLA_ANA3, 0x101c)
> +
> +REG32(A2W_PLLC_ANA0, 0x1030)
> +REG32(A2W_PLLC_ANA1, 0x1034)
> +REG32(A2W_PLLC_ANA2, 0x1038)
> +REG32(A2W_PLLC_ANA3, 0x103c)
> +
> +REG32(A2W_PLLD_ANA0, 0x1050)
> +REG32(A2W_PLLD_ANA1, 0x1054)
> +REG32(A2W_PLLD_ANA2, 0x1058)
> +REG32(A2W_PLLD_ANA3, 0x105c)
> +
> +REG32(A2W_PLLH_ANA0, 0x1070)
> +REG32(A2W_PLLH_ANA1, 0x1074)
> +    FIELD(A2W_PLLH_ANA1, FB_PREDIV, 11, 1)
> +REG32(A2W_PLLH_ANA2, 0x1078)
> +REG32(A2W_PLLH_ANA3, 0x107c)
> +
> +REG32(A2W_PLLB_ANA0, 0x10f0)
> +REG32(A2W_PLLB_ANA1, 0x10f4)
> +REG32(A2W_PLLB_ANA2, 0x10f8)
> +REG32(A2W_PLLB_ANA3, 0x10fc)
> +
> +REG32(A2W_PLLA_FRAC, 0x1200)
> +    FIELD(A2W_PLLx_FRAC, FRAC, 0, 20)
> +REG32(A2W_PLLC_FRAC, 0x1220)
> +REG32(A2W_PLLD_FRAC, 0x1240)
> +REG32(A2W_PLLH_FRAC, 0x1260)
> +REG32(A2W_PLLB_FRAC, 0x12e0)
> +
>  /*
>   * This field is common to all registers. Each register write value must match
>   * the CPRMAN_PASSWORD magic value in its 8 MSB.
>   */
>  FIELD(CPRMAN, PASSWORD, 24, 8)
>  #define CPRMAN_PASSWORD 0x5a
>  
> +/* PLL init info */
> +typedef struct PLLInitInfo {
> +    const char *name;
> +    size_t cm_offset;
> +    size_t a2w_ctrl_offset;
> +    size_t a2w_ana_offset;
> +    uint32_t prediv_mask; /* Prediv bit in ana[1] */
> +    size_t a2w_frac_offset;
> +} PLLInitInfo;
> +
> +#define FILL_PLL_INIT_INFO(pll_)                \
> +    .cm_offset = R_CM_ ## pll_,                 \
> +    .a2w_ctrl_offset = R_A2W_ ## pll_ ## _CTRL, \
> +    .a2w_ana_offset = R_A2W_ ## pll_ ## _ANA0,  \
> +    .a2w_frac_offset = R_A2W_ ## pll_ ## _FRAC
> +
> +static const PLLInitInfo PLL_INIT_INFO[] = {
> +    [CPRMAN_PLLA] = {
> +        .name = "plla",
> +        .prediv_mask = R_A2W_PLLx_ANA1_FB_PREDIV_MASK,
> +        FILL_PLL_INIT_INFO(PLLA),
> +    },
> +    [CPRMAN_PLLC] = {
> +        .name = "pllc",
> +        .prediv_mask = R_A2W_PLLx_ANA1_FB_PREDIV_MASK,
> +        FILL_PLL_INIT_INFO(PLLC),
> +    },
> +    [CPRMAN_PLLD] = {
> +        .name = "plld",
> +        .prediv_mask = R_A2W_PLLx_ANA1_FB_PREDIV_MASK,
> +        FILL_PLL_INIT_INFO(PLLD),
> +    },
> +    [CPRMAN_PLLH] = {
> +        .name = "pllh",
> +        .prediv_mask = R_A2W_PLLH_ANA1_FB_PREDIV_MASK,
> +        FILL_PLL_INIT_INFO(PLLH),
> +    },
> +    [CPRMAN_PLLB] = {
> +        .name = "pllb",
> +        .prediv_mask = R_A2W_PLLx_ANA1_FB_PREDIV_MASK,
> +        FILL_PLL_INIT_INFO(PLLB),
> +    },
> +};
> +
> +#undef FILL_PLL_CHANNEL_INIT_INFO
> +
> +static inline void set_pll_init_info(BCM2835CprmanState *s,
> +                                     CprmanPLLState *pll,
> +                                     CprmanPLL id)
> +{
> +    pll->id = id;
> +    pll->reg_cm = &s->regs[PLL_INIT_INFO[id].cm_offset];
> +    pll->reg_a2w_ctrl = &s->regs[PLL_INIT_INFO[id].a2w_ctrl_offset];
> +    pll->reg_a2w_ana = &s->regs[PLL_INIT_INFO[id].a2w_ana_offset];
> +    pll->prediv_mask = PLL_INIT_INFO[id].prediv_mask;
> +    pll->reg_a2w_frac = &s->regs[PLL_INIT_INFO[id].a2w_frac_offset];
> +}
> +
>  #endif
> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> index d2ea0c9236..ad71d30a86 100644
> --- a/hw/misc/bcm2835_cprman.c
> +++ b/hw/misc/bcm2835_cprman.c
> @@ -46,10 +46,56 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/misc/bcm2835_cprman.h"
>  #include "hw/misc/bcm2835_cprman_internals.h"
>  #include "trace.h"
>  
> +/* PLL */
> +
> +static void pll_update(CprmanPLLState *pll)
> +{
> +    clock_update(pll->out, 0);
> +}
> +
> +static void pll_xosc_update(void *opaque)
> +{
> +    pll_update(CPRMAN_PLL(opaque));
> +}
> +
> +static void pll_init(Object *obj)
> +{
> +    CprmanPLLState *s = CPRMAN_PLL(obj);
> +
> +    s->xosc_in = qdev_init_clock_in(DEVICE(s), "xosc-in", pll_xosc_update, s);
> +    s->out = qdev_init_clock_out(DEVICE(s), "out");
> +}
> +
> +static const VMStateDescription pll_vmstate = {
> +    .name = TYPE_CPRMAN_PLL,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_CLOCK(xosc_in, CprmanPLLState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void pll_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->vmsd = &pll_vmstate;
> +}
> +
> +static const TypeInfo cprman_pll_info = {
> +    .name = TYPE_CPRMAN_PLL,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(CprmanPLLState),
> +    .class_init = pll_class_init,
> +    .instance_init = pll_init,
> +};
> +
> +
>  /* CPRMAN "top level" model */
>  
>  static uint64_t cprman_read(void *opaque, hwaddr offset,
>                                      unsigned size)
>  {
> @@ -64,10 +110,19 @@ static uint64_t cprman_read(void *opaque, hwaddr offset,
>  
>      trace_bcm2835_cprman_read(offset, r);
>      return r;
>  }
>  
> +#define CASE_PLL_REGS(pll_)       \
> +    case R_CM_ ## pll_:           \
> +    case R_A2W_ ## pll_ ## _CTRL: \
> +    case R_A2W_ ## pll_ ## _ANA0: \
> +    case R_A2W_ ## pll_ ## _ANA1: \
> +    case R_A2W_ ## pll_ ## _ANA2: \
> +    case R_A2W_ ## pll_ ## _ANA3: \
> +    case R_A2W_ ## pll_ ## _FRAC
> +
>  static void cprman_write(void *opaque, hwaddr offset,
>                           uint64_t value, unsigned size)
>  {
>      BCM2835CprmanState *s = CPRMAN(opaque);
>      size_t idx = offset / sizeof(uint32_t);
> @@ -80,12 +135,35 @@ static void cprman_write(void *opaque, hwaddr offset,
>      value &= ~R_CPRMAN_PASSWORD_MASK;
>  
>      trace_bcm2835_cprman_write(offset, value);
>      s->regs[idx] = value;
>  
> +    switch (idx) {
> +    CASE_PLL_REGS(PLLA) :
> +        pll_update(&s->plls[CPRMAN_PLLA]);
> +        break;
> +
> +    CASE_PLL_REGS(PLLC) :
> +        pll_update(&s->plls[CPRMAN_PLLC]);
> +        break;
> +
> +    CASE_PLL_REGS(PLLD) :
> +        pll_update(&s->plls[CPRMAN_PLLD]);
> +        break;
> +
> +    CASE_PLL_REGS(PLLH) :
> +        pll_update(&s->plls[CPRMAN_PLLH]);
> +        break;
> +
> +    CASE_PLL_REGS(PLLB) :
> +        pll_update(&s->plls[CPRMAN_PLLB]);
> +        break;
> +    }
>  }
>  
> +#undef CASE_PLL_REGS
> +
>  static const MemoryRegionOps cprman_ops = {
>      .read = cprman_read,
>      .write = cprman_write,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>      .valid      = {
> @@ -96,13 +174,18 @@ static const MemoryRegionOps cprman_ops = {
>  };
>  
>  static void cprman_reset(DeviceState *dev)
>  {
>      BCM2835CprmanState *s = CPRMAN(dev);
> +    size_t i;
>  
>      memset(s->regs, 0, sizeof(s->regs));
>  
> +    for (i = 0; i < CPRMAN_NUM_PLL; i++) {
> +        device_cold_reset(DEVICE(&s->plls[i]));

Assuming cprman_reset() is cprman_cold_reset().

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    }
> +
>      clock_update_hz(s->xosc, s->xosc_freq);
>  }
>  
>  static Clock *init_internal_clock(BCM2835CprmanState *s,
>                                    const char *name)
> @@ -121,18 +204,41 @@ static Clock *init_internal_clock(BCM2835CprmanState *s,
>  }
>  
>  static void cprman_init(Object *obj)
>  {
>      BCM2835CprmanState *s = CPRMAN(obj);
> +    size_t i;
> +
> +    for (i = 0; i < CPRMAN_NUM_PLL; i++) {
> +        object_initialize_child(obj, PLL_INIT_INFO[i].name,
> +                                &s->plls[i], TYPE_CPRMAN_PLL);
> +        set_pll_init_info(s, &s->plls[i], i);
> +    }
>  
>      s->xosc = init_internal_clock(s, "xosc");
>  
>      memory_region_init_io(&s->iomem, obj, &cprman_ops,
>                            s, "bcm2835-cprman", 0x2000);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
>  }
>  
> +static void cprman_realize(DeviceState *dev, Error **errp)
> +{
> +    BCM2835CprmanState *s = CPRMAN(dev);
> +    size_t i;
> +
> +    for (i = 0; i < CPRMAN_NUM_PLL; i++) {
> +        CprmanPLLState *pll = &s->plls[i];
> +
> +        clock_set_source(pll->xosc_in, s->xosc);
> +
> +        if (!qdev_realize(DEVICE(pll), NULL, errp)) {
> +            return;
> +        }
> +    }
> +}
> +
>  static const VMStateDescription cprman_vmstate = {
>      .name = TYPE_BCM2835_CPRMAN,
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (VMStateField[]) {
> @@ -148,10 +254,11 @@ static Property cprman_properties[] = {
>  
>  static void cprman_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> +    dc->realize = cprman_realize;
>      dc->reset = cprman_reset;
>      dc->vmsd = &cprman_vmstate;
>      device_class_set_props(dc, cprman_properties);
>  }
>  
> @@ -164,8 +271,9 @@ static const TypeInfo cprman_info = {
>  };
>  
>  static void cprman_register_types(void)
>  {
>      type_register_static(&cprman_info);
> +    type_register_static(&cprman_pll_info);
>  }
>  
>  type_init(cprman_register_types);
> 

