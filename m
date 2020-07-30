Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88245C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F812074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNHhEVQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F812074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k18G9-0004yp-KD
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 09:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k18FH-0003xC-Od
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:05:15 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:37524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k18FF-0002tT-TX
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:05:15 -0400
Received: by mail-pl1-x635.google.com with SMTP id p1so14055223pls.4
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 06:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/ku7Pr4bJavqfcpbIcoy19qbFbYvqMUtxpmV0SoogNk=;
 b=dNHhEVQw6QABS7SyhaCv27nIqJnOESYUoNTnlt702+sJyafNp/MxDAzwl4T1kFxOix
 i0xWFvLqh5d6CCBZ0NPpRrnsKtFCSU/W8H5VDtGm7FE1DZkE6fkyQ6W11eD+JMKI648G
 eg5h/tLaCL+WWOhjlzpmMPPuS1oA7X2EZBTuMMtTNWH8kRFA3c/93DldI+jYl9QuJncT
 3S8w2ecskgFGfuL+Zml9kxIa02agwm6Ot+PgHWyKSE5NzU/4B0zdz3OJy23sxrO1inHk
 MMQLr73LbLrAFdSGMQsrd2jro+SPZ+yHMpN4/SU9lS8UHMTmLeDE2oyfmDh7ee2J0KZO
 p/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/ku7Pr4bJavqfcpbIcoy19qbFbYvqMUtxpmV0SoogNk=;
 b=jBPu8ducKWx2X3fVGpLR1uRNIy1xjhIP+BQ1uHNar9gF9Bw89OwX8iruRHbWx5wzs8
 p1LwKFPts/J9c3z5MrlklqybkFDjt9i8E79fl8aby0dzAbnA3mLxNc2FDVfNj1l6wKjQ
 GPqLLRFG6L8V8l1P0x5pTEP18B7njeU4lVHtvoLZKwK2caVF9Oi9mATncjS8vOJfjujk
 bPVbJmVXEhnisSzYDDGqpi25MBEdvL61sMKtcPE/g69F0acXAqidTa0S/6xSoBuPmjwm
 dVVymTvLkwOcFDj1RlRGaUqkJ2T82sbTAuGmuSETB5WYSFHvj4qECBpa1NSMbeA7R+3q
 QiOw==
X-Gm-Message-State: AOAM531a1qs9M4MN+D4Zs9bonEJc+ykBWGF/FPcOe0tpPrkH6JYBhVEW
 1lCvvvjfJG2vxavOzh6smouepw==
X-Google-Smtp-Source: ABdhPJyEkJBvZaeDg+s7LjeXU0AH5zbEGmB0UFuh6aZQsoJZGR3tp3QTHkgf49TKJvNTZLMYiRxGlg==
X-Received: by 2002:aa7:9e8d:: with SMTP id p13mr3195208pfq.32.1596114312338; 
 Thu, 30 Jul 2020 06:05:12 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id n12sm6593979pfj.99.2020.07.30.06.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 06:05:11 -0700 (PDT)
Subject: Re: [RFC v2 32/76] target/riscv: rvv-0.9: mask population count
 instruction
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-33-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6f82dcc9-945c-b840-76ea-12adb94d28f9@linaro.org>
Date: Thu, 30 Jul 2020 06:05:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-33-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:15 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/helper.h                   | 2 +-
>  target/riscv/insn32.decode              | 2 +-
>  target/riscv/insn_trans/trans_rvv.inc.c | 7 ++++---
>  target/riscv/vector_helper.c            | 6 +++---
>  4 files changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

