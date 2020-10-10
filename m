Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7ECC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 15:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7249D223AB
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 15:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1qLZlLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7249D223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRHCq-0000tB-IE
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 11:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRHBA-0008C1-2P; Sat, 10 Oct 2020 11:53:04 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRHB5-0001rL-Kt; Sat, 10 Oct 2020 11:53:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id h5so3403318wrv.7;
 Sat, 10 Oct 2020 08:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/QHDCV4CWgR0KOs1XcYCTat3K8XrMJmcbkD0TAxTnDY=;
 b=c1qLZlLxT9hjTX4mDSBonTbec1o+lAyJG0zd3pyrptnouLbMVXEgJyp/si14+tpQgU
 2zroSP7o64bV7n0VPqTf4qaIm8H7ImcGhFxbODpvD8rcsPk8EsgkI4I9eE1u2yAV2F/J
 6lQrMRNNe4q0DnJcBTwrutkiikN5q9AG3Lm84sRCv0fgcod/2Ot6wh9+iZWqF8ANymC5
 W8wVAHKdGkOYYyv2AUMmx8IwhfbJ+uNz+TFLaZcMS4OcbkSy8XOZIH2tnbtTOSzse3Jf
 /5j97zwVnM0zo4rPCaTtiOGk0wJoAoTdLTakT7z/JWx9fC0AG6gmCnmMsITb17ScDGvX
 KWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/QHDCV4CWgR0KOs1XcYCTat3K8XrMJmcbkD0TAxTnDY=;
 b=N3X/1et9Q6IpAFpwci8EVBl30X0yVgITpGRMwlJ4icsOJC76t+x307moW0Il3WWlcm
 WKv6wMzoCyL7Am8nZuT5fmM1DfCjdf4H4Ic8AKif5g4lFjs+PT5Z1B/Qx5AwAFNhtys4
 ZmA/JM/2u6JMWbXSoHp8ejerrzLdTESS3t2JNj5+rZzLSlW3amZM4QBYuNxJqzq+rxgX
 6u3zPLUQGyno8kxoOTGmuZmdta+oEGa0+bYDmk8mUQQ28EgP9fd0ldcEeETrojxsS6iF
 WEwo3t8R58BuqACgUpUxiehnIBiHPEjcg4vEha1aWqntrg+alBZsRYuzr/l6B3ORjOOg
 YHIw==
X-Gm-Message-State: AOAM530DsEJaqzovOFBJzP0Ml4ZufXMvz2Wx5OAtdSYGfNVPjIyV4w1P
 /2v5PCzmkQVc51lrZl6RfwY=
X-Google-Smtp-Source: ABdhPJxRBG2KhJIFKvqsfQjjpI/Rc7sD3dVrJ4hrVnTOM2t4Ni6saIzyKsdTMXiacrxnUF+VH65ufw==
X-Received: by 2002:adf:e94b:: with SMTP id m11mr20026163wrn.35.1602345177946; 
 Sat, 10 Oct 2020 08:52:57 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id c1sm17196460wru.49.2020.10.10.08.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2020 08:52:57 -0700 (PDT)
Subject: Re: [PATCH v3 11/15] hw/misc/bcm2835_cprman: implement clock mux
 behaviour
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20201010135759.437903-1-luc@lmichel.fr>
 <20201010135759.437903-12-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6982aced-ca14-73bf-48ff-7f739f2c389a@amsat.org>
Date: Sat, 10 Oct 2020 17:52:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201010135759.437903-12-luc@lmichel.fr>
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
> A clock mux can be configured to select one of its 10 sources through
> the CM_CTL register. It also embeds yet another clock divider, composed
> of an integer part and a fractional part. The number of bits of each
> part is mux dependent.
> 
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>   hw/misc/bcm2835_cprman.c | 53 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> index b22170f3bc..919a55aa23 100644
> --- a/hw/misc/bcm2835_cprman.c
> +++ b/hw/misc/bcm2835_cprman.c
> @@ -229,19 +229,70 @@ static const TypeInfo cprman_pll_channel_info = {
>   };
>   
>   
>   /* clock mux */
>   
> +static bool clock_mux_is_enabled(CprmanClockMuxState *mux)
> +{
> +    return FIELD_EX32(*mux->reg_ctl, CM_CLOCKx_CTL, ENABLE);
> +}
> +
>   static void clock_mux_update(CprmanClockMuxState *mux)
>   {
> -    clock_update(mux->out, 0);
> +    uint64_t freq;
> +    uint32_t div, src = FIELD_EX32(*mux->reg_ctl, CM_CLOCKx_CTL, SRC);
> +    bool enabled = clock_mux_is_enabled(mux);
> +
> +    *mux->reg_ctl = FIELD_DP32(*mux->reg_ctl, CM_CLOCKx_CTL, BUSY, enabled);
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
> +     *
> +     *         31          12 11          0
> +     *        ------------------------------
> +     * CM_DIV |      |  int  |  frac  |    |
> +     *        ------------------------------
> +     *                <-----> <------>
> +     *                int_bits frac_bits
> +     */
> +    div = extract32(*mux->reg_div,
> +                    R_CM_CLOCKx_DIV_FRAC_LENGTH - mux->frac_bits,
> +                    mux->int_bits + mux->frac_bits);
> +
> +    if (!div) {
> +        clock_update(mux->out, 0);
> +        return;
> +    }
> +
> +    freq = muldiv64(freq, 1 << mux->frac_bits, div);
> +
> +    clock_update_hz(mux->out, freq);
>   }

Much nicer now, thanks :)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>   
>   static void clock_mux_src_update(void *opaque)
>   {
>       CprmanClockMuxState **backref = opaque;
>       CprmanClockMuxState *s = *backref;
> +    CprmanClockMuxSource src = backref - s->backref;
> +
> +    if (FIELD_EX32(*s->reg_ctl, CM_CLOCKx_CTL, SRC) != src) {
> +        return;
> +    }
>   
>       clock_mux_update(s);
>   }
>   
>   static void clock_mux_init(Object *obj)
> 

