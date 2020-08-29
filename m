Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FDDC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 20:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC4BF20774
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 20:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTZi9l69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4BF20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC7Ab-0001Qt-Uc
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 16:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC79n-0000tR-DM
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 16:08:59 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:33620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC79l-0006QQ-QT
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 16:08:59 -0400
Received: by mail-pf1-x436.google.com with SMTP id u20so2431077pfn.0
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 13:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Tg0E6f9OQNvh/BnXlBfIae17jTkbuulpyDuGvV5AUYg=;
 b=kTZi9l69Xwe+fYpHhfOpuWJXph+Plg8H5v5VdMAhTkQ/BPQXDUKvh4kukLwaUAiKJo
 xy9vjjU4e583LPbc3gHEsZEHU35qHYVbnmJxqdFh4gH5y1csd5CXRlJuoyny8njhjHXX
 ZnXwDDDKTwPcp8afjzvthVVau6pC5kSkG43+cAQMQqKASoHstALvsHHnCkuE0W5tUR5X
 xakU+l1zIkURvpu7BpmG8JbVXCR7EoFhEt2kbw9t7/f90rE+rohnVa2dfm7Rk+eDrrJN
 mM3slQYETLNx7cCGMACDJUzkQxk4WLqBNjXnthFitBikMM9q2tJC6GBrdWDbSGPlYEKe
 iJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tg0E6f9OQNvh/BnXlBfIae17jTkbuulpyDuGvV5AUYg=;
 b=mzGTXuWxK3xmxzYei9Dm0jkFsw62JuBBnohhgb8M4NemKyp+QgNxFu9IEw0o+4BHiP
 QPdd/cn/H5T/5EOw9pUyqtdhGW4dshMgm32UTN8d7hmJwl3eEmQWEeHQxccGvmc37IgP
 iHWSEhEzR4nVp6jTkK5e2fA5IxieYN99VDvjXVlwOrJ13Dot0mNz1DkT9Sap/DMgFXcw
 MhygLGsLZXUeso67zLSd7RF/KVcGKDEC0xrnz/iV5u4CHi0lcgn9wzdGF2tWefA7Au/h
 Gxbd6+3c88xsghqlXQVUvByOJl5A+WWY+qObtF+kQkWQNqc9sLpIZ7zgjD+dO/sfq2bb
 oCkA==
X-Gm-Message-State: AOAM531Dkr6qme2EJgwG50ij/IE+/WmrHMquR0jtU0QuSvBklmGjup+O
 TXRUN4dQ/2oIBGL9TUhKK4bgsgckb6poXA==
X-Google-Smtp-Source: ABdhPJy1Sr1sBlNe/izVfDzWt66cjqzb2JnABNEjUzs5JkDj/ML2+kpB70rfv41s0eHwcCR5iTvh+A==
X-Received: by 2002:a62:4dc4:: with SMTP id a187mr3897386pfb.265.1598731734403; 
 Sat, 29 Aug 2020 13:08:54 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v18sm3308820pfu.15.2020.08.29.13.08.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 13:08:53 -0700 (PDT)
Subject: Re: [RFC v4 38/70] target/riscv: rvv-1.0: whole register move
 instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-39-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d568af82-6856-2875-bdea-589e000548f5@linaro.org>
Date: Sat, 29 Aug 2020 13:08:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-39-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
> Add the following instructions:
> 
> * vmv1r.v
> * vmv2r.v
> * vmv4r.v
> * vmv8r.v
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn32.decode              |  4 ++++
>  target/riscv/insn_trans/trans_rvv.inc.c | 25 +++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


