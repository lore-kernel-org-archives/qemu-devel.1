Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4E7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 23:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83BC9221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 23:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZoNpORpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BC9221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ovH-0003OW-KT
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 19:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3opL-0006EK-SC
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 18:57:35 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3opK-0007kG-3d
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 18:57:35 -0400
Received: by mail-pg1-x544.google.com with SMTP id p3so27754288pgh.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 15:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2EudLFvAWPx6Wgl/bLKmED9QDLUN+/0FThciq5PThqc=;
 b=ZoNpORpLpkAcUE9uEmMnKr1/1jEM7abjzuCXQbFksZxWRxPJBHa45nkWwaZtIQnRti
 uqVRuDwXFVY/7wr1fJ1VzGcAD4jXk4M9FJEaMOmaaFwagc6ibOFrwPj0yCxrlWoEPsLb
 IsVnAHKyxrGqUpmzhEofp68ixruhEI1kZI1fSVDdXWI78v+TQuSmwibQHbE0m7B2WUL0
 Vpw+C7lc3gcE75pkWsN6O5ORi7R2UpJer2EArHNJLgxZ30q2aucTvx65w17FsWJpjrkf
 B4EYtr16PKiRpk2fOuKkHAStG/oZNlWEeZUsBGM1T+l1ptqQ/dD8wCFCR7SJ3ocj58G2
 EcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2EudLFvAWPx6Wgl/bLKmED9QDLUN+/0FThciq5PThqc=;
 b=Ko1x5fjQ8SLQ+rOrFdW19AkzEFAI6bgqa2G/PNimkNNX+KdUJvHRE5Ny4MtwMeZ0xk
 h0qezabVvE0akLq6QzxEF7NzJhjSQ/JfivXAlbp1w9k1iFly+gHREr1cpK6TFFNXuZXB
 E1wp9Qcc7+g7zbyPp+q6NHMBoHrsK/QxYRiaw3Sdn70ZWroWQF+mhvEJ2+7YHFSP/nzG
 VPWUbh/xD8tAmXYU2pquDx9Yyu0yB25I82p/K/PGF65W1mK4hLLw+NsfJ2p4ZFz1dPt9
 K5fwqbtFF9oAuU0hoYxR6yr2qT0lnjlhfR/zGYTEbsmIoLjUzUiXSaL+4CHX/VYNmJbZ
 maqw==
X-Gm-Message-State: AOAM532JnG0JxjHGbz2A1PwDNOJC8emuYfAK7CkKNaeLi79JrKs7t5ZQ
 ytIZwLH3aZxOeXLLs7UQPbcf1g==
X-Google-Smtp-Source: ABdhPJwuYRiWgTzqC4GmQc7M/O36y8T+hRt0/33gHpgmBljOUea2ByUZtdEzG57F6kVoxrYJhrWA0Q==
X-Received: by 2002:a62:206:: with SMTP id 6mr10179796pfc.228.1596754652427;
 Thu, 06 Aug 2020 15:57:32 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id g15sm9935128pfh.70.2020.08.06.15.57.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 15:57:31 -0700 (PDT)
Subject: Re: [RFC v3 16/71] target/riscv: add fp16 nan-box check generator
 function
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200806104709.13235-1-frank.chang@sifive.com>
 <20200806104709.13235-17-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5f9df8b5-5537-d06c-584b-633cf89696b1@linaro.org>
Date: Thu, 6 Aug 2020 15:57:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806104709.13235-17-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> From: Frank Chang <frank.chang@sifive.com>
> 
> If a 16-bit input is not properly nanboxed, then the input is replaced
> with the default qnan.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/translate.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

The code is perfectly fine, but the patch has to be merged with the first user
of gen_check_nanbox_h.  Otherwise a bisection that stops at this patch will
Werror for the unused function.


r~

