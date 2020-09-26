Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2B7C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E1021D7F
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am7DrqXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E1021D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMHj8-0006Si-1q
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 17:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMHhw-0005t8-Eg; Sat, 26 Sep 2020 17:26:16 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMHhu-0007Bu-Gv; Sat, 26 Sep 2020 17:26:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id m6so7681873wrn.0;
 Sat, 26 Sep 2020 14:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VyGBqm4CHFJAxG81xmM1b6SMNKSAXm/U5XvX5WLTRNo=;
 b=am7DrqXDZuWnkxGjV05k06n60aurT+MMeSNn1a+1p0ispURywaG2yFG9EykKvmIb1N
 UYepu/mvdT7RX7+joxtwuHBqcFfjXJRX5mHiUtCTFRDmiwkVHWOKg88ELPMwz3roOAZk
 cRfFOElW79JL23Eg76YRU7m4y5Do+NRHMXw7Zfhow/aCfMeld8FDX8rukERD+KkzSTwm
 8ZVJ5Bvg+sqXg3mxMgEfaGP9wD7r6ue2qYknlpVRXprtcplvqPiZnrJ1NvLxa0eMfHkW
 smAT8yfl7ap9LPMFzkWPC9iXWRc/IevB3liPCf0JClOGUjS42EDB7PKYs5T1shKQLYQd
 163A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VyGBqm4CHFJAxG81xmM1b6SMNKSAXm/U5XvX5WLTRNo=;
 b=sGIlxLzA5l2aVldQj3eb2k6XEZwAKA+3hllUUsNANyHW9hECoe2B5h3BExUCcqXWJo
 /ZL9NOWKN5ApB+yCIgjf6B3RECe0UWH8ceapF4l7xnnsxRNCgS8nfaK2hSBe2N11DxC+
 wsG9s+UNnk23Fy5/JtJvo+FxBh9zk7aic5bTNBmuhGlNKA1EpjAJa69Dj/B4UW1lrhWt
 hqO6TCk4t6Y7IUDXrj+WS+IyxEoF+9yQgSbj+FN9bLzeJEdzZc9NLYGUbi/tQs8Fprq6
 YFMj5yAmfaRUb2IFCcZYqHehzu2ahD6anRkvq3ZN8QybBupHpTFLfuH8W72nnR0eH0ib
 Zosw==
X-Gm-Message-State: AOAM532SbzijFeKjCSQP3YIFwMJnIiJ277tPfMolHemiJ7vo+jYvs31q
 g07Mwqc09TXRRu1iidcuFFE=
X-Google-Smtp-Source: ABdhPJwhdojgYIeV0AiPYkEKzUgw+/IU5yb4usfYB1Qisj0d4QL6Qn9KupCNEMSF6a0uVGgoOW4gIg==
X-Received: by 2002:adf:e690:: with SMTP id r16mr10863848wrm.15.1601155572285; 
 Sat, 26 Sep 2020 14:26:12 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id g14sm7720332wrv.25.2020.09.26.14.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 14:26:11 -0700 (PDT)
Subject: Re: [PATCH 06/14] hw/misc/bcm2835_cprman: implement PLLs behaviour
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-7-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <96c1dfff-13ff-cc15-e759-2e8ee794eb22@amsat.org>
Date: Sat, 26 Sep 2020 23:26:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925101731.2159827-7-luc@lmichel.fr>
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
> The cprman PLLs generate a clock based on a prescaler, a multiplier and
> a divider. The prescaler doubles the parent (xosc) frequency, then the
> multiplier/divider are applied. The multiplier has an integer and a
> fractionnal part.

Typo "fractional".

> 
> This commit also implements the cprman CM_LOCK register. This register
> reports which PLL is currently locked. We consider a PLL has being
> locked as soon as it is enabled (on real hardware, there is a delay
> after turning a PLL on, for it to stabilise).

Typo "stabilize".

> 
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>  include/hw/misc/bcm2835_cprman_internals.h |  8 +++
>  hw/misc/bcm2835_cprman.c                   | 64 +++++++++++++++++++++-
>  2 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
> index 5cfa849492..22a2500ab0 100644
> --- a/include/hw/misc/bcm2835_cprman_internals.h
> +++ b/include/hw/misc/bcm2835_cprman_internals.h
> @@ -98,10 +98,18 @@ REG32(A2W_PLLA_FRAC, 0x1200)
>  REG32(A2W_PLLC_FRAC, 0x1220)
>  REG32(A2W_PLLD_FRAC, 0x1240)
>  REG32(A2W_PLLH_FRAC, 0x1260)
>  REG32(A2W_PLLB_FRAC, 0x12e0)
>  
> +/* misc registers */
> +REG32(CM_LOCK, 0x114)
> +    FIELD(CM_LOCK, FLOCKH, 12, 1)
> +    FIELD(CM_LOCK, FLOCKD, 11, 1)
> +    FIELD(CM_LOCK, FLOCKC, 10, 1)
> +    FIELD(CM_LOCK, FLOCKB, 9, 1)
> +    FIELD(CM_LOCK, FLOCKA, 8, 1)
> +
>  /*
>   * This field is common to all registers. Each register write value must match
>   * the CPRMAN_PASSWORD magic value in its 8 MSB.
>   */
>  FIELD(CPRMAN, PASSWORD, 24, 8)
> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> index ad71d30a86..ba82522eb1 100644
> --- a/hw/misc/bcm2835_cprman.c
> +++ b/hw/misc/bcm2835_cprman.c
> @@ -48,13 +48,51 @@
>  #include "hw/misc/bcm2835_cprman_internals.h"
>  #include "trace.h"
>  
>  /* PLL */
>  
> +static bool pll_is_locked(const CprmanPLLState *pll)
> +{
> +    return !FIELD_EX32(*pll->reg_a2w_ctrl, A2W_PLLx_CTRL, PWRDN)
> +        && !FIELD_EX32(*pll->reg_cm, CM_PLLx, ANARST);
> +}
> +
>  static void pll_update(CprmanPLLState *pll)
>  {
> -    clock_update(pll->out, 0);
> +    uint64_t freq, ndiv, fdiv, pdiv;
> +
> +    if (!pll_is_locked(pll)) {
> +        clock_update(pll->out, 0);
> +        return;
> +    }
> +
> +    pdiv = FIELD_EX32(*pll->reg_a2w_ctrl, A2W_PLLx_CTRL, PDIV);
> +
> +    if (!pdiv) {
> +        clock_update(pll->out, 0);
> +        return;
> +    }
> +
> +    ndiv = FIELD_EX32(*pll->reg_a2w_ctrl, A2W_PLLx_CTRL, NDIV);
> +    fdiv = FIELD_EX32(*pll->reg_a2w_frac, A2W_PLLx_FRAC, FRAC);
> +
> +    if (pll->reg_a2w_ana[1] & pll->prediv_mask) {
> +        /* The prescaler doubles the parent frequency */
> +        ndiv *= 2;
> +        fdiv *= 2;
> +    }
> +
> +    /*
> +     * We have a multiplier with an integer part (ndiv) and a fractional part
> +     * (fdiv), and a divider (pdiv).
> +     */
> +    freq = clock_get_hz(pll->xosc_in) *
> +        ((ndiv << R_A2W_PLLx_FRAC_FRAC_LENGTH) + fdiv);
> +    freq /= pdiv;
> +    freq >>= R_A2W_PLLx_FRAC_FRAC_LENGTH;

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +
> +    clock_update_hz(pll->out, freq);
>  }
>  
>  static void pll_xosc_update(void *opaque)
>  {
>      pll_update(CPRMAN_PLL(opaque));
> @@ -94,18 +132,42 @@ static const TypeInfo cprman_pll_info = {
>  };
>  
>  
>  /* CPRMAN "top level" model */
>  
> +static uint32_t get_cm_lock(const BCM2835CprmanState *s)
> +{
> +    static const int CM_LOCK_MAPPING[] = {

Maybe CM_LOCK_MAPPING[CPRMAN_NUM_PLL].

> +        [CPRMAN_PLLA] = R_CM_LOCK_FLOCKA_SHIFT,
> +        [CPRMAN_PLLC] = R_CM_LOCK_FLOCKC_SHIFT,
> +        [CPRMAN_PLLD] = R_CM_LOCK_FLOCKD_SHIFT,
> +        [CPRMAN_PLLH] = R_CM_LOCK_FLOCKH_SHIFT,
> +        [CPRMAN_PLLB] = R_CM_LOCK_FLOCKB_SHIFT,
> +    };
> +
> +    uint32_t r = 0;
> +    size_t i;
> +
> +    for (i = 0; i < CPRMAN_NUM_PLL; i++) {
> +        r |= pll_is_locked(&s->plls[i]) << CM_LOCK_MAPPING[i];
> +    }
> +
> +    return r;
> +}
> +
>  static uint64_t cprman_read(void *opaque, hwaddr offset,
>                                      unsigned size)
>  {
>      BCM2835CprmanState *s = CPRMAN(opaque);
>      uint64_t r = 0;
>      size_t idx = offset / sizeof(uint32_t);
>  
>      switch (idx) {
> +    case R_CM_LOCK:
> +        r = get_cm_lock(s);
> +        break;
> +
>      default:
>          r = s->regs[idx];
>      }
>  
>      trace_bcm2835_cprman_read(offset, r);
> 

