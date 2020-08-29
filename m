Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BED0C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 18:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F5920774
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 18:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDtk+PIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F5920774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC5jG-0007Vk-4B
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 14:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC5ii-00072E-9A
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 14:36:56 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:33775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC5ig-0004x8-OO
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 14:36:55 -0400
Received: by mail-pl1-x629.google.com with SMTP id h2so1166757plr.0
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 11:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Rf28wSybrAI0hplIS6QnqC/KFGhUM93cnTBNSrUtaig=;
 b=wDtk+PIOBvwPgfEHB7FeQjuT5NeIc9rQcg5OO8Etzrq55EU3G/2xNzwjSjTpsbpaqZ
 a3JxZgbgFxti4+41tJptlWgRtaRc/FEj8UhoiHKL5Mj1k/ljZFzuiT5G9UU9td/zb9gp
 6DFZnRrlwcUYHgZI02Q8pQ+yTN9EFhfDae04NqjKuUceY/AMQg9H4zBes/9xRHLU7GrW
 cDO678BZtPeAQ3QYZDKO6d+v9cIOSUHJrgyLWUOPhJ8VIMraIsNOi+yhdmkzqXi/IdU7
 6qCZWu1PYQF82JkA8DRh3SQqXRWWyyhRiRLZyMJbkjTy1WVXCO8Z7O/JhPs8/J4Ne8Eq
 7v1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Rf28wSybrAI0hplIS6QnqC/KFGhUM93cnTBNSrUtaig=;
 b=RAyPML5jbc3BNEmBHraoNpDMGJfPT9gJ5Zr+kUFpzFMyDnaPBBQWt4Gkq8qH7ex3nJ
 zxW9b8SdOOKzwfr8Pbov35PStT9LszPOCNVjrhiQPpl4jaCuAu8lB40Tx8o5fnEL2YcQ
 JlNIIi3WsDpLDAL76/QxGoyLJxAYcg5io8bEttjfF/Q7SCPylMZH7KQSuchCo/WwcQkB
 zdzKVnycRHJxPbmND1LC60n9kvX4Ez1kkq2Wyc0Xm4k5EYx+ZqITYBVxwGeX4r3mypHa
 x52D+yIkXe4hMwDaSf2iWK3G0ZgA4YcpoC5kFEo42uE8zovGyXifqObPCj7q3Uq5rN0U
 3x2g==
X-Gm-Message-State: AOAM530kCS7UeSnUt6y0F2RRgSPM3VsEY+9Id6aqmdsNPXMY0TgRoI3n
 9fpv400zBFgl8cpB/oxji07o5Q==
X-Google-Smtp-Source: ABdhPJz02AJKofqdDliL4uN3XpV9n5k1Vet0PnDbXL0RG7y3RPtiQ2nCbeVwseVi5UMqEsJKP6nh+g==
X-Received: by 2002:a17:90a:88:: with SMTP id a8mr3931144pja.196.1598726213320; 
 Sat, 29 Aug 2020 11:36:53 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y126sm3300806pfy.138.2020.08.29.11.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 11:36:52 -0700 (PDT)
Subject: Re: [RFC v4 21/70] target/riscv: rvv-1.0: fault-only-first unit
 stride load
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-22-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <911cd1de-e22c-3637-fc01-dae6e6f0c21f@linaro.org>
Date: Sat, 29 Aug 2020 11:36:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-22-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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

On 8/17/20 1:49 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/helper.h                   | 27 +++---------
>  target/riscv/insn32.decode              | 14 +++----
>  target/riscv/insn_trans/trans_rvv.inc.c | 31 ++++----------
>  target/riscv/vector_helper.c            | 56 +++++++++----------------
>  4 files changed, 38 insertions(+), 90 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

