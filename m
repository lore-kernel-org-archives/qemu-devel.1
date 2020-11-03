Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E21CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5669420870
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFeuN4/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5669420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZqRz-00018q-AX
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 02:09:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZqR2-0000cs-NM
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 02:08:52 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZqR1-0003kk-55
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 02:08:52 -0500
Received: by mail-wr1-x444.google.com with SMTP id x7so17280344wrl.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 23:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PM+3PiPhqlWYWDGDimkZL+oioDyPZUnVWAZuCAMu1eE=;
 b=FFeuN4/m8ms2/HvYVPsUL4FHgMAKchYOCafvmJVnq4OioaH7hlzLsngJ8ltudxYTY5
 teqh6xD13zC5EfPD/qMapd/GDTw5ODNnfrxUlVVzRJ7zD6IGXRb+2VbYxm29FMmof+At
 rEcq+SWdszu/42fqhabIKUDk7Md/wvBizNo/fhAnCgue5nMDrx0YN1kC1VGnT+GABEXm
 5z47Go/AUrKtw7AB4D2MEuSPCCyOtJAkzUrbm8aFH75vmmPE02/gu89Qw+Wh8b47+T+T
 XOygcXAkAp3IENXdM2RUjYITwdailzluVdUzF7vKUyz8KFhALKCpYvCbzrgz9hgTcOdO
 e/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PM+3PiPhqlWYWDGDimkZL+oioDyPZUnVWAZuCAMu1eE=;
 b=oiR/P2NPZZvbH5ht/Q6RbPJ6tjNrSY1Bwh+O3U8PVXGcOyTJA4dfVinkOyuL6T+P/Y
 tJ1pWnSKf+hpagu7BAqx4R/eGK3Z0kWOI7WhLNKFngr6ZxDkDA03geHJ3UOsOoebs+Sd
 FCDTxr7Eib1Y2TR4gqLgZihcOIq3MS4zip2uvHKUT78swttTLTVvjFKtVwT1vQZb0R2P
 5wXqYc1e/Hg7wuz+oTXzOcD223qtlXxqGNFhwYxp1F5SdbHT7Q7s5wWLziCTANwdfKcr
 doy1BxbrwUDl66AS9bhSZ3BNs0s0tGEiYrazzkDhYlzWZBCoNs5ibc6FXI0TtkiXaeB3
 Tpzw==
X-Gm-Message-State: AOAM530DhKy9wBo/Whtdo9dZsSvjoHYG0sHAiNmZCge450bt4UnZsamk
 KQa18LS5CuCpRMT39vmesqU=
X-Google-Smtp-Source: ABdhPJx0oiF6YVad5d/xNvH5cVjg7mtKfAqL0b7MZOPrLZk3QHtNl+G8JnPCnPoCeLbPfuOz8H+2Tg==
X-Received: by 2002:adf:c101:: with SMTP id r1mr23332813wre.87.1604387329523; 
 Mon, 02 Nov 2020 23:08:49 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id m4sm25358792wrr.47.2020.11.02.23.08.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 23:08:48 -0800 (PST)
Subject: Re: [PATCH for-5.2] tcg: Remove assert from set_jmp_reset_offset
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201103033947.94157-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <28efd7ed-d380-354f-e134-f92e0b32eb78@amsat.org>
Date: Tue, 3 Nov 2020 08:08:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103033947.94157-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Sai Pavan Boddu <saipava@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 4:39 AM, Richard Henderson wrote:
> The range check done here is done later, more appropriately,
> at the end of tcg_gen_code.

Maybe mention commit 6e6c4efed99 ("tcg: Restart after TB code generation
overflow")? (no need to repost).

>  There, a failing range check
> results in a returned error code, which causes the TB to be
> restarted at half the size.
> 
> Reported-by: Sai Pavan Boddu <saipava@xilinx.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Sai, would you try this against your failing testcase?
> 
> 
> r~
> 
> ---
>  tcg/tcg.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index f49f1a7f35..43c6cf8f52 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -335,10 +335,11 @@ static bool tcg_resolve_relocs(TCGContext *s)
>  
>  static void set_jmp_reset_offset(TCGContext *s, int which)
>  {
> -    size_t off = tcg_current_code_size(s);
> -    s->tb_jmp_reset_offset[which] = off;
> -    /* Make sure that we didn't overflow the stored offset.  */
> -    assert(s->tb_jmp_reset_offset[which] == off);
> +    /*
> +     * We will check for overflow at the end of the opcode loop in
> +     * tcg_gen_code, where we bound tcg_current_code_size to UINT16_MAX.
> +     */
> +    s->tb_jmp_reset_offset[which] = tcg_current_code_size(s);
>  }
>  
>  #include "tcg-target.c.inc"
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


