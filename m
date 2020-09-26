Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EC4C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:37:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0DB23719
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/y1edv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0DB23719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMHtC-00026o-Hn
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 17:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMHsI-0001Yr-Un; Sat, 26 Sep 2020 17:36:58 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMHsG-0008QX-Tv; Sat, 26 Sep 2020 17:36:58 -0400
Received: by mail-wm1-x342.google.com with SMTP id l15so1824556wmh.1;
 Sat, 26 Sep 2020 14:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5Ib8tEqF0YgR6sluhpMMwq7o7jWEzeCO66+531ykuAU=;
 b=j/y1edv29zXmX3GCuagccLj+f9vkjI3KsshGawx9kDuQSi4ua4sLCVTUulorWcYPTC
 ORqd1BSOCdqbbuRm4dFGSPXg/dVxJopB6q1YrNUPX4WsQ5YMXFPRGdkr3BlOMUfb3FQh
 I8g9SxVNAKaMU8+LtyMj3Qj3ui5s2slLHm2Ns3S5gzRA1gz4JoeZ8/SXd4uAYqPBRQ0n
 bv54pD+o3ub9e5/1lMa0zKZx1CodfMDkKmNXHPvmuIIX1jWX9PZ8mwThbVW2wJJnANlP
 8l39aXNc1M45YLC0egroiUKNjONC9gNrzIc9G6NFr9I26YA6VUG6azSuRp9q6F6DkCdd
 J1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Ib8tEqF0YgR6sluhpMMwq7o7jWEzeCO66+531ykuAU=;
 b=Sapp+4ooysq68Btccwo2q5oJf6wlONn0oZs02HePlxjR+sefLd0zrf/vPUP2sqe/Cp
 62lG/K6txv7UM9bJsPDoY/ZUXnmIHl8hyi4hvRJPsldcohvtIIzt9sUS/TfYQ5Y1TN+c
 B4EVuI/o7UMMLh3ZxJECZ/uAdyQoQmf5cUyJflyrQWItdtBEOaCsIw5ypSwH9GDCfjJ/
 cm8jlQYpU9iQEjg0sQss23f3EblfqA91pBWWEjCKR0+WjpKV48M2UupV5sONdItt3iTE
 MhX1YuNHBdQ9g9/68cVLlk+ZrRKVf4QGOCkkNIDk+F0BDe0n4anWRK/CXt4Us/Qu6y4o
 3DSQ==
X-Gm-Message-State: AOAM530c7mW1Y910qdZ93e52H9mRCkjlycNKWsgI1DLl/F4nxdrwK8OQ
 Ylrpx7qPe8obezYa/GBNO0A=
X-Google-Smtp-Source: ABdhPJytXM7ASnsooP4uP38iYjN+9nauxTFFpMd6GDedj5D91b0KYB+ujnPmUW8sVGZrSa+g7I7klw==
X-Received: by 2002:a05:600c:2cc1:: with SMTP id
 l1mr4028741wmc.78.1601156214164; 
 Sat, 26 Sep 2020 14:36:54 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id k15sm8060897wrv.90.2020.09.26.14.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 14:36:53 -0700 (PDT)
Subject: Re: [PATCH 08/14] hw/misc/bcm2835_cprman: implement PLL channels
 behaviour
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-9-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <973df115-4f26-66ba-051a-142d2901293d@amsat.org>
Date: Sat, 26 Sep 2020 23:36:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925101731.2159827-9-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrei Warkentin <andrey.warkentin@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Pete Batard <pete@akeo.ie>, Samer El-Haj-Mahmoud <samer@elhajmahmoud.com>,
 Ard Biesheuvel <ardb@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 12:17 PM, Luc Michel wrote:
> A PLL channel is able to further divide the generated PLL frequency. The

You can move the 'The' to the next line =)

> divider is given in the ctrl_a2w register. Some channels have a

s/a/an/

> additional fixed divider which is always applied to the signal.
> 
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>  hw/misc/bcm2835_cprman.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> index 2c70a3f317..e644aeb2b5 100644
> --- a/hw/misc/bcm2835_cprman.c
> +++ b/hw/misc/bcm2835_cprman.c
> @@ -132,13 +132,44 @@ static const TypeInfo cprman_pll_info = {
>  };
>  
>  
>  /* PLL channel */
>  
> +static bool pll_channel_is_enabled(CprmanPLLChannelState *channel)
> +{
> +    /*
> +     * XXX I'm not sure of the purpose of the LOAD field. The Linux driver does
> +     * not set it when enabling the channel, but does clear it when disabling
> +     * it.

Cc'ed firmware developers who might have a clue.

> +     */
> +    return !FIELD_EX32(*channel->reg_a2w_ctrl, A2W_PLLx_CHANNELy, DISABLE)
> +        && !(*channel->reg_cm & channel->hold_mask);
> +}
> +
>  static void pll_channel_update(CprmanPLLChannelState *channel)
>  {
> -    clock_update(channel->out, 0);
> +    uint64_t freq, div;
> +
> +    if (!pll_channel_is_enabled(channel)) {
> +        clock_update(channel->out, 0);
> +        return;
> +    }
> +
> +    div = FIELD_EX32(*channel->reg_a2w_ctrl, A2W_PLLx_CHANNELy, DIV);
> +
> +    if (!div) {
> +        /*
> +         * It seems that when the divider value is 0, it is considered as
> +         * being maximum by the hardware (see the Linux driver).
> +         */
> +        div = R_A2W_PLLx_CHANNELy_DIV_MASK;
> +    }
> +
> +    /* Some channels have an additional fixed divider */
> +    freq = clock_get_hz(channel->pll_in) / (div * channel->fixed_divider);
> +
> +    clock_update_hz(channel->out, freq);
>  }
>  
>  /* Update a PLL and all its channels */
>  static void pll_update_all_channels(BCM2835CprmanState *s,
>                                      CprmanPLLState *pll)
> 

