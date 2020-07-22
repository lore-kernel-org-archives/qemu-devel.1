Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74847C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 19:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342ED2065D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 19:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B1w6crUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342ED2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyKDc-0006dJ-HM
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 15:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyKD0-000676-QO
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 15:15:18 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:56231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyKCy-0004Gj-4g
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 15:15:18 -0400
Received: by mail-pj1-x1032.google.com with SMTP id k1so2006852pjt.5
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 12:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eqhuUVI1s7w3MF+FCKmU/idPUjAhMzCrUsSRtkzXNKI=;
 b=B1w6crUDbw/OVsoSpHejxkks6Y0jWvMvLQUW2q/0U0aUXnqlEfqrctmBapq8syZcjf
 UaRSYqmOOR2Dy1JeB2HKTSz8hCux9uPtpkXDP3yYdtpaVV+COUYk/oILOy7jqx3W7rIP
 ZWQUr1Px7HnSx6hwbQ5++Wb8zYwyKSo6H9iJtAnhrLT4wkcTCbngFNiK25Ja62v1kw75
 pPZEihFJwh1RKn58oJhokGP0ysZGyM6ae1sLgA4+JAkLtVOxk2MmD088lCUwHLlf+Tbu
 DoxtpVDotoFMhBD7poxqm45TdMfciyzgK/X9Mr6D7TyD1NiwRmLcR5l/f6uNUFnhCYU9
 8Z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eqhuUVI1s7w3MF+FCKmU/idPUjAhMzCrUsSRtkzXNKI=;
 b=IHIVbhoTmwAoal4CEQLmqNH1UK9YcJa3wyuxqOlpVz1YAHzdyoVpP4klQChQ6gP66E
 oV+i1sz/Gqba7DAO48EnjLIVdR1ClSoqUoZFCf71c0xfrsesCgFoFOWr1vBGFe+MrEkd
 YNC76mRgYxleMyUA923F0MIsWEO8vyYP34plqLSJUBJdkdtQjWsOPBTj/zVx0XyAfrxi
 rgu8fi6dXDiaOcuO7jQ8D/bVeq1JR58xGAVu6ojAc+3FMIwcjB73x4lEbcAx9DIqwgKi
 5/4p2CyJtmIVWnJ8tqmmPX9kWJVW+FmJcjkrlv2/WfcRyXFQwKwWj6OCFkbnUA1An/nW
 URhg==
X-Gm-Message-State: AOAM530eKTrQj4Z81Igs7hFHOXYD+FOdNlZx83id5onB0NZrG19m4n//
 xYrr/wkpkMVgGcshkZdOka69ew==
X-Google-Smtp-Source: ABdhPJycIUPU5EF7YLgPyfMhgycoTyN3dwt6EJvPG7gYlb3cYDnnRo962EIQWdWrWUUZnBL+lcCQsg==
X-Received: by 2002:a17:90a:de8d:: with SMTP id
 n13mr754269pjv.95.1595445314386; 
 Wed, 22 Jul 2020 12:15:14 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 u66sm343370pfb.191.2020.07.22.12.15.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 12:15:13 -0700 (PDT)
Subject: Re: [RFC v2 19/76] target/riscv: rvv-0.9: add narrower_nanbox_fpr
 helper
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-20-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <87cba14d-0ff5-97b8-b1ed-34872906495a@linaro.org>
Date: Wed, 22 Jul 2020 12:15:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-20-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
 Alistair Francis <Alistair.Francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:15 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> For floating-point operations, the scalar can be taken from a scalar
> f register. If FLEN > SEW, the value in the f registers is checked for
> a valid NaN-boxed value, in which case the least-significant SEW bits
> of the f register are used, else the canonical NaN value is used.
> 
> Add helper to generate the correspond NaN-boxed value or the SEW-bit
> canonical NaN for floating-point operations.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/helper.h        |  2 ++
>  target/riscv/vector_helper.c | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)

The helper can be done inline in two tcg ops.

Though, really, we need to coordinate with Liu Zhiwei's other patch set that
also deals with nan-boxing.


r~

