Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103A0C388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712D120578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVtPLGbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712D120578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcB6c-0004SF-6N
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kcB2x-0007o7-5r
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:33:40 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:39893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kcB2p-0006xf-7W
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:33:38 -0500
Received: by mail-pf1-x42f.google.com with SMTP id q5so5827654pfk.6
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 09:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lEODxc6DnmEbQ721yyp9bL+L/wVv6PF+mIHYKV3oTCI=;
 b=jVtPLGbJXmyW8DOYBVKzws4Jr+S8tTA7ms1/EijTxbaJ7VSVoKKniEwCpJnhsYP6M9
 yRWcbAPDeK/Ygt2XB/y+C31dQI0DC/tpanhkjJjbf53bCEs+kmKuA9qtsV6EcGJJxNKr
 BB37uRGJC1o8gXtJl8AJBZSH82wHNZH7xxw+S7Eemd2tpDp4GzHqxACRkOD/cb5ltpBr
 sSz1qC2lbdDVIj6JKQ0PEy05hbeFEhPiHtddW4FxeQJ4KktAuAEFK6jsmFZRh8R4Jkc/
 Rndnu3l0I0mHuIHdTPdspHyVQhYbewxhOIISOQr4yFO5VlgnrUYRTzR2USaKoP0fnN4u
 911w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lEODxc6DnmEbQ721yyp9bL+L/wVv6PF+mIHYKV3oTCI=;
 b=lSLfX8krOtxadUSfnPADkpNa9W5xoJHLC6MP3OTeaGMVO9d9pa6yqTzE+/P/SVi5Ck
 EhwSwNrQjWW2WaS9iZQlbvAFS/rQkA+gGMSIrntwM4ePxVC6nRa/UjBRbnKvzUTRKYpf
 l99LMaZRgS5LDFDmHfZmz4ZECi7bmQYyr/UtVrm7pyDNPC7dFYrWSwj96tJtnF2gPlXa
 0DPzFnTq+3lTF3pY+ivYdNxS5iPPWzpiw8+2pJP/MK/Div2+2Zo3ad0+W+lJBW+q5YaZ
 Vp/O+lJ1r6/jB0yoCI8IO/I6y6BgVvx09rHTMeUXndwMXbjOiquRndhLP9/dNXvXp10t
 fqxg==
X-Gm-Message-State: AOAM530X/jYxENRgVLuhPPg8a8k1InAK53YCgPPnar4vnRb1aFdCkOpl
 b+K9zEMjjny6aLnqG451kR9y3A==
X-Google-Smtp-Source: ABdhPJyx8d5j8rTOsMZqWqJnsjw9d/7PpCbxlddmNhdl5g5La1zsOL1NsvDwPc0qVKSHGHugvvbx6w==
X-Received: by 2002:a17:90b:93:: with SMTP id
 bb19mr265215pjb.102.1604943208967; 
 Mon, 09 Nov 2020 09:33:28 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id l14sm8324656pfd.113.2020.11.09.09.33.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 09:33:28 -0800 (PST)
Subject: Re: [PATCH-for-6.0 0/2] target/mips: CP0 housekeeping patches for Nov
 2020
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201109090422.2445166-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ffdaefd0-b887-5116-628e-5a303aa2389f@linaro.org>
Date: Mon, 9 Nov 2020 09:33:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201109090422.2445166-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/9/20 1:04 AM, Philippe Mathieu-Daudé wrote:
> Based-on: <20201108234234.2389789-1-f4bug@amsat.org>
> 
> Philippe Mathieu-Daudé (2):
>   target/mips: Replace magic values by CP0PM_MASK or
>     TARGET_PAGE_BITS_MIN
>   target/mips: Do not include CP0 helpers in user-mode emulation

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

