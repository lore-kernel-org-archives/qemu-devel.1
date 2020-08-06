Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327B7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D1A22C9F
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7YcvgAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D1A22C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3kly-0001SP-5E
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 14:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3kl5-0000La-Hl
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 14:36:56 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:35234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3kl3-0001tm-SM
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 14:36:55 -0400
Received: by mail-pj1-x102e.google.com with SMTP id t6so7140609pjr.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 11:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uAGJ3s7/oS/JbfOCj342ZAHHFm29YEngjZLzAjg7ivg=;
 b=E7YcvgAhOjjOuFk+axecYpDNHlIfUWxxk54fRnkGseZnHr6U57ygx8BLYpiBTgvif/
 i0HsfkWHz8ROoQRgrTDcfaOFpdZ//iubf+roqFuRnfmWoH4TCtSLFnOXxUCZnSlRqMLZ
 zZqUTDre41XziUbHnqtnbVvpUJfylIIWPdZqMfaF5cHepsV8fHEbSUJy3WqY9w6Vf7r7
 x2xQ7uSNxkuzRr6hWfXazDtmjku2X3P3F58niHntM0jgvr48wjY3GLqeIlRKsHrJIyZ3
 guGiqy2pmUMJWaCkrVJwjRsTtOdvav6iHaaUxez2PPrfvSFOfLaLovi8mqJ0EN8Q5wRa
 BFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uAGJ3s7/oS/JbfOCj342ZAHHFm29YEngjZLzAjg7ivg=;
 b=H/pCPYXEjFU79bKZKPriYImBFErph8rH7ptgjYGmQTUJaEr6sAsm3d8AMwvgaEUpgv
 0HFZYWxHVHL76Z301kxf9y4GZhQ+YbQVJPveE5/IUrN5eweoEy61/UekNiOdA2y3NZ+P
 XEX+PYxIsTFlN8oaZmdIL6QYfDZ61VuqmyZ3/kJjELiIYIFrRgqENXJLXgsOwx6itikf
 x6dKZBIdLBog1npYBGCvUDHpAORzmCBOs8nzOBe9HzWfRjfU8M6eHe5AIPpxOie74ZCB
 MW3ytyzkBlGbfJ6epiRbyFCfa58VRW+yxpRprUUdUg7CmFQ+kJ7Q9zJ5hNo9dsHWHnen
 4A0g==
X-Gm-Message-State: AOAM533GRxQahFLVlmGSwJvkMZ6X5+eHbaxbn9UlIkPL/2gdJRwdXyy0
 hkOu0L48vEROaUJEqKhjh2WTaw==
X-Google-Smtp-Source: ABdhPJxGVPABQA6j+C0zZ6hF1h7YK6z1uQeynva8vUGSVVALCSTIMt6ev1w0X1flp9VeE41ZFH4HeA==
X-Received: by 2002:a17:90a:9f44:: with SMTP id
 q4mr10077049pjv.66.1596739012125; 
 Thu, 06 Aug 2020 11:36:52 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q83sm10126848pfc.31.2020.08.06.11.36.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 11:36:51 -0700 (PDT)
Subject: Re: [RFC v3 12/71] target/riscv: rvv-1.0: add fractional LMUL
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200806104709.13235-1-frank.chang@sifive.com>
 <20200806104709.13235-13-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ab205cfa-80cc-411c-a87e-8c6de7c282e7@linaro.org>
Date: Thu, 6 Aug 2020 11:36:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806104709.13235-13-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 3:46 AM, frank.chang@sifive.com wrote:
> +    float flmul;

int8_t?  It seems weird that the translator wouldn't also use...

> +/*
> + * Encode LMUL to lmul as following:
> + *     LMUL    vlmul    lmul
> + *      1       000       0
> + *      2       001       1
> + *      4       010       2
> + *      8       011       3
> + *      -       100       -
> + *     1/8      101      -3
> + *     1/4      110      -2
> + *     1/2      111      -1
> + */
> +static inline int32_t vext_lmul(uint32_t desc)
>  {
> -    return FIELD_EX32(simd_data(desc), VDATA, LMUL);
> +    uint32_t lmul = FIELD_EX32(simd_data(desc), VDATA, LMUL);
> +    return (int8_t)(lmul << 5) >> 5;
>  }

... this encoding?

Oh, and sextract32(lmul, 0, 3) instead of those shifts.


r~

