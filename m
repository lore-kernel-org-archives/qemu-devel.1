Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE40C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01AC2371F
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXWsHjNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01AC2371F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMHxI-0003bY-RB
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 17:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMHwE-0002le-Lv; Sat, 26 Sep 2020 17:41:02 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMHwC-0000WB-VP; Sat, 26 Sep 2020 17:41:02 -0400
Received: by mail-wr1-x441.google.com with SMTP id k15so7607191wrn.10;
 Sat, 26 Sep 2020 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1r1+cC64jEswfH/bsoCgaLm5j+9/iEDGCJPabwCdJdU=;
 b=PXWsHjNpUnKGm/ZM4S6LNn0bzDMOKBj6WANvg3wynqPgLlpkUCLhar10FDbg7VN6BR
 Ghn+KMySDX6sh7AQqIvaVRPK3OvccjqjhCxxnK8nJPjlpHhGe0PmNs1k12vELPqWJmTu
 Spxz7F0yGZU10yfKksEWJwoPMKHBElb7OVMXDY5qNBiy0aOprgEPCVwbBlfnQvxgBNZj
 JB018t0NDRKMrGMxiP76QH+vpSk1zjaBN2FvV25wrclhe2+cY9SQh/028qV/onVZy5qo
 o+od307mh1lPiLpeQKcYtIMfRS2vUTpUJYs2vD3H1CwNA3uAS4jxizQP2x7opn9DH1vT
 wBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1r1+cC64jEswfH/bsoCgaLm5j+9/iEDGCJPabwCdJdU=;
 b=nly8gBFUctfDqxehjixLna7ExdXivKAieysgVDoRAgZ0c5LBwJK0E0CGrnE5M8GwEF
 FmI5XzYkoqQ3uH9+3mD6XthM4p2FsLsXGkQ/gMieqvuLr3fhW7Cwfj/0v2T/9y6jtbF8
 BdAk5E/qa5C0vozWW/JAif7yJva8wzuVIHmbB6bM2U8zPf3zXZ4AYJQTCWIjHB4UMknW
 UfsbcdFqzNF5EZCkDmqgPBHCk+5Kl9/spTaTtoubjxMdGnKBh5qOoaw2LTe0/jHRP4O8
 1WWi5Uc58DJezHMiRArhMbYXvqK3lt18LRQLoC4YXwJ2kSHrJSem4CsecHM3571gXyRw
 e22A==
X-Gm-Message-State: AOAM532ZKid4H0oOnFHmmzrUSLrFDt5o2+mqVC8dBov1sZBoT0t3aWIo
 H8FqHmu9PX5z9tKD+PECxKE=
X-Google-Smtp-Source: ABdhPJw3TAgCJ8iHRIijs33gmyKPGEufklcnr/vk42eb/w7UaseMR4peWw5AZg2aTaV4V7UoY0Chdw==
X-Received: by 2002:adf:fc4e:: with SMTP id e14mr11162246wrs.329.1601156459136; 
 Sat, 26 Sep 2020 14:40:59 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id l10sm7675863wru.59.2020.09.26.14.40.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 14:40:58 -0700 (PDT)
Subject: Re: [PATCH 10/14] hw/misc/bcm2835_cprman: implement clock mux
 behaviour
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-11-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <76aae8af-dff0-b76f-cf04-0e3231eaf2bb@amsat.org>
Date: Sat, 26 Sep 2020 23:40:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925101731.2159827-11-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
> A clock mux can be configured to select one of its 10 sources through
> the cm_ctl register. It also embeds yet another clock divider, composed
> of an integer part and a fractionnal part. The number of bits of each

Typo "fractional".

> part is mux dependant.

Typo "dependent"?

> 
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>  hw/misc/bcm2835_cprman.c | 43 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> index 8df2db0fd9..75bc11939b 100644
> --- a/hw/misc/bcm2835_cprman.c
> +++ b/hw/misc/bcm2835_cprman.c
> @@ -229,19 +229,60 @@ static const TypeInfo cprman_pll_channel_info = {
>  };
>  
>  
>  /* clock mux */
>  
> +static bool clock_mux_is_enabled(CprmanClockMuxState *mux)
> +{
> +    return FIELD_EX32(*mux->reg_cm, CM_CLOCKx_CTL, ENABLE);
> +}
> +
>  static void clock_mux_update(CprmanClockMuxState *mux)
>  {
> -    clock_update(mux->out, 0);
> +    uint64_t freq, div;
> +    uint32_t src = FIELD_EX32(*mux->reg_cm, CM_CLOCKx_CTL, SRC);
> +    bool enabled = clock_mux_is_enabled(mux);
> +
> +    *mux->reg_cm = FIELD_DP32(*mux->reg_cm, CM_CLOCKx_CTL, BUSY, enabled);
> +
> +    if (!enabled) {
> +        clock_update(mux->out, 0);
> +        return;
> +    }
> +
> +    freq = clock_get_hz(mux->srcs[src]);
> +
> +    if (mux->int_bits == 0 && mux->frac_bits == 0) {
> +        clock_update_hz(mux->out, freq);
> +        return;
> +    }
> +
> +    /*
> +     * The divider has an integer and a fractional part. The size of each part
> +     * varies with the muxes (int_bits and frac_bits). Both parts are
> +     * concatenated, with the integer part always starting at bit 12.
> +     */
> +    div = mux->reg_cm[1] >> (R_CM_CLOCKx_DIV_FRAC_LENGTH - mux->frac_bits);
> +    div &= (1 << (mux->int_bits + mux->frac_bits)) - 1;
> +
> +    freq = (freq << mux->frac_bits) / div;
> +
> +    clock_update_hz(mux->out, freq);
>  }
>  
>  static void clock_mux_src_update(void *opaque)
>  {
>      CprmanClockMuxState **backref = opaque;
>      CprmanClockMuxState *s = *backref;
> +    CprmanClockMuxSource src = backref - s->backref;
> +    uint32_t current_src;
> +
> +    current_src = FIELD_EX32(*s->reg_cm, CM_CLOCKx_CTL, SRC);
> +
> +    if (current_src != src) {
> +        return;
> +    }
>  
>      clock_mux_update(s);
>  }
>  
>  static void clock_mux_init(Object *obj)
> 

