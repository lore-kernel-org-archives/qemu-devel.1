Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523B0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15DC120829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E41eFrjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DC120829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k18qt-0005gi-Dz
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 09:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k18qD-00059i-8X
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:43:25 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:35269)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k18qA-00009g-Rp
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:43:24 -0400
Received: by mail-pl1-x634.google.com with SMTP id r4so3523382pls.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 06:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TDd10USEdK7bw4u2wiZeBaLU7fHfTOUlVMyxLIByVP0=;
 b=E41eFrjl0WG/tT1KhFK1RMFUN7kaxq+Tki9bn74UflAo+LkDgJ3ESWH6Ys1h1ptt4Z
 Uf53ilI80C8KZrBIdJqkxfpxLebFrFFL8qMRnjtUGosEZfB/yu/7+s7C1rrZZ3Mzzj6o
 q/fU8r6Gpk3P+PrEfc3qGxh5b+Wx44Wo6hBT00uns31l52hfX8SIdBTXTOzN1lTGHOKh
 WJagVqafiI6dymkz7h2xJFAY5M0MEjdi8xHAZQzv5s2gYPyZIpQZQN6dy+100DpuI5k7
 51EbZM0WYonBfjuvRvrC7vQmEU/lFYM/QRbiXKHEz2BdHQZSuI6z7+QGUA9e1Yr3Z0v0
 vrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TDd10USEdK7bw4u2wiZeBaLU7fHfTOUlVMyxLIByVP0=;
 b=c/5Nx5iid4dqqoR27N61jSQoU4TBd6jFK7G/cjzNcYDu1pIjE0OovDxbKeiVIqJ3Ie
 yJZkSwk0V+IbNmNZc2+PrBZJEnxnCOXpTFfW9k9Z6AwS4/maEV4Pn+FdK4xCqk2As/ZZ
 UDqFmiNhjjGsSYAalq74rw2NOdV92N8cnpupVdHYgWJOWnL6Sy+k0MTqDIfsRw56pNnl
 i5kUNpYhJ92UE4JD/NZZFF8A5YMdxEPNQh8brsLkobTOcjp4f3fB/H+qb8CWrH0R4jP2
 0CCOmXrubDkqPCtQ/0h5pWzyEfl377gEr7q99v0wCS9/7Xs0w5RYeItMzLCe5oHx7Ckz
 /+5w==
X-Gm-Message-State: AOAM530Ah+P9k15a/DILDxbFvthypM4niI7d65SdOhgxRMU3BTUDv6rB
 K7nkQArVJyjAjimlxUzv+cqa7A==
X-Google-Smtp-Source: ABdhPJxS+aUXa8+1ZTNeFfe2s/zqve/u912v8MURAXNC266hy/M61y6yvCkZkbZK72+CDjDYMKSFdA==
X-Received: by 2002:a63:1f04:: with SMTP id f4mr34028857pgf.34.1596116601089; 
 Thu, 30 Jul 2020 06:43:21 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j16sm6295836pgb.33.2020.07.30.06.43.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 06:43:20 -0700 (PDT)
Subject: Re: [RFC v2 37/76] target/riscv: rvv-0.9: allow load element with
 sign-extended
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-38-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bcc93273-4e1f-9604-46f2-0b682a3c9184@linaro.org>
Date: Thu, 30 Jul 2020 06:43:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-38-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> For some vector instructions (e.g. vmv.s.x), the element is loaded with
> sign-extended.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvv.inc.c | 26 ++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

