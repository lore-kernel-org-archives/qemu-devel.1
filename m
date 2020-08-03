Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512FBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 13:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C15B206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 13:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCfDOSff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C15B206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2aFW-0007fm-63
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 09:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2aEb-00078b-Fw; Mon, 03 Aug 2020 09:10:33 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2aEZ-0002CA-TG; Mon, 03 Aug 2020 09:10:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id 184so15399337wmb.0;
 Mon, 03 Aug 2020 06:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eCLkG5qkWXpvBdaB3idlwHIh2QxIGVXjsXJOi0ojj8o=;
 b=FCfDOSffhAr7u5tudHx1ScjC5vgEWd9iTHW1yGYIw2TK9TT2jiXGupTf9HwN4dhwEH
 yAHzwx6tarYxz7Uc5YNJmzTqvScudeSf95898h+48AsLlVPkgBq/mah/G7oGJ3FYCRhg
 QArXjUKBNfpbC9iNtRjPod9HdgY3Yy79J4GijzBy3oUlHFWhRuKLa7FcpAtzHF4qmJc5
 gTrYRZoAaV0Ldz8l2yG8q6QC+bLOjB/IKfFaDrryWCoLZeJi2w9/08sLA12igUsSFRoJ
 fuzTXFpJCOp8A3JkayiBKNIXigHc/vzcyX4UD6W2P+DLlbBsckJuPwE7dsdRQAsgChv9
 v/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eCLkG5qkWXpvBdaB3idlwHIh2QxIGVXjsXJOi0ojj8o=;
 b=e6bwun+fRQEX2fV1HEvw3B+fSlDpxCkLxpOPE/BHV+5v5vrZlB0zdfBVfXUg8IopOr
 P1vXkZy31ZTAxNKPwgDXq7DM9XfEf1Uvx+QNDAAPGJOZ7cKi1DTxFAUw+uHr4bcV9Xj1
 RgmPO4e2ukFMRZX3aw/o/NDpBHRIpWcdfeDDybu+8/m9wc2YuM1TWASDG14wrSLUMMj2
 FCpCm8JEvyQzWB1nhdZnEvFxvMM4lFt+He9wW4/VqkA3Jaz2Vj77LDI80QNmhTfn/5mG
 YfzerHGNpFxB6M7cB+15MLoUiY7CBEf1DrRiObFpeAeX5HsoApQ9rTpF8mMrHdG2Exa9
 wmTA==
X-Gm-Message-State: AOAM531RDUtHMQiK94NmxhnGGMsW+QwkrrnezDCP39w9XxtSwWXZAQiD
 DawO5qh6jNBrKkgRNYTb9TWwKiu7
X-Google-Smtp-Source: ABdhPJzTnLGBVL24AsvvWW44EaU1VKt4n51iOt5lKLR7CSPQZ6yvip7afE2atkAbZg9cd8EFMZNogg==
X-Received: by 2002:a7b:c219:: with SMTP id x25mr53014wmi.101.1596460229670;
 Mon, 03 Aug 2020 06:10:29 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id g7sm25066321wrv.82.2020.08.03.06.10.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 06:10:29 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Delete unused VFP_DREG macros
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200803124848.18295-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <956d6416-8c78-05e2-9566-26288d9a7b76@amsat.org>
Date: Mon, 3 Aug 2020 15:10:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200803124848.18295-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/3/20 2:48 PM, Peter Maydell wrote:
> As part of the Neon decodetree conversion we removed all
> the uses of the VFP_DREG macros, but forgot to remove the
> macro definitions. Do so now.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index c39a929b938..27bf6cd8b51 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -2471,21 +2471,6 @@ static int disas_dsp_insn(DisasContext *s, uint32_t insn)
>      return 1;
>  }
>  
> -#define VFP_REG_SHR(x, n) (((n) > 0) ? (x) >> (n) : (x) << -(n))
> -#define VFP_DREG(reg, insn, bigbit, smallbit) do { \
> -    if (dc_isar_feature(aa32_simd_r32, s)) { \
> -        reg = (((insn) >> (bigbit)) & 0x0f) \
> -              | (((insn) >> ((smallbit) - 4)) & 0x10); \
> -    } else { \
> -        if (insn & (1 << (smallbit))) \
> -            return 1; \
> -        reg = ((insn) >> (bigbit)) & 0x0f; \
> -    }} while (0)
> -
> -#define VFP_DREG_D(reg, insn) VFP_DREG(reg, insn, 12, 22)
> -#define VFP_DREG_N(reg, insn) VFP_DREG(reg, insn, 16,  7)
> -#define VFP_DREG_M(reg, insn) VFP_DREG(reg, insn,  0,  5)
> -
>  static inline bool use_goto_tb(DisasContext *s, target_ulong dest)
>  {
>  #ifndef CONFIG_USER_ONLY
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


