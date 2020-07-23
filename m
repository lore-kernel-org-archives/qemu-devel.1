Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D6DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEFCB22B43
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DHcHCcdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFCB22B43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jydsE-0004LX-16
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 12:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jydrc-0003rf-67
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 12:14:32 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:41794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jydra-00007Q-AQ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 12:14:31 -0400
Received: by mail-pf1-x42f.google.com with SMTP id w126so3068979pfw.8
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 09:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1NwmDuXeyIXDqLos9VOzL1VsMvF3ILIyzVzhT0SpN5E=;
 b=DHcHCcdxaWDmtEM4ZYXBGvrbhlqr5n4A+G2IRM+vs/TVjpUeaaJ2hY5upovLEURQtP
 MRKJOIL79ITXJI3oB+7p6IAWpcGLwq1aYA0HEyvhHTASj/Mi5TdpC5XVn/dEkI6Ftc6f
 bDzVoZdAA0iIn+tVf+VRLQyhKGKsQnBpgiN2LyhrEBRbcUXC+w1323IHSXUFKzZ92AZ+
 MmmiXebwhS6YMIUyibcDP+WmbBaDxlRpEB41Ggqll7RAzXWRwRqEdot7ydiz6nwOg0CW
 PlJT1fgcENMkWlPumo1Dkft2BCjgYENGP5mFb1LEKibzWmogqW0ZOweJgAh3CAeW07Ww
 Qfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1NwmDuXeyIXDqLos9VOzL1VsMvF3ILIyzVzhT0SpN5E=;
 b=KPCNFZGyioe/YFPmA4/xkYkdWlDM5s19cz2uoKpep1Xjkrm306zlUgiMUhsjTvImbW
 bTwX+ExpRkSIHf87bJXXtsz8t9tJAhp4V/Jzsg6r3q+QtEoC0Z0657rVX1Vg1837CWTb
 d5AtBUFL6qEzVl8bFFK/pc4MS+vunuxg1+6KT64WUhdwzwjVZIeKKSpLp9naHxk5WzsA
 6xCXbHxFNmXAnKhufaxoMHBN6P00B4QQiXq9LDWYjGtt6yrvIXEngFN382QNoooUB3hM
 ueNdAyjqMe/09dPFjq1GbgvuAyTcKDf+iZ3EnOlUlqZaDof+uYI7z9tVtBJPRaqf3HtF
 MGmw==
X-Gm-Message-State: AOAM532Gb9iQjP1SLZ+JglfAgbYn3MisSX7+4ZgndxHj3ud7inKVIdou
 7My58JABM2AXJGx9qiflhxILAg==
X-Google-Smtp-Source: ABdhPJz37Zk1CleY2DwwwHpjAtdfywq5u5O60TbYk9u2rkbvQmWfgNdIiZ7/nQPiinudORH/yquUlA==
X-Received: by 2002:a62:8f4b:: with SMTP id n72mr4555785pfd.284.1595520868654; 
 Thu, 23 Jul 2020 09:14:28 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 r6sm3461360pgn.65.2020.07.23.09.14.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 09:14:27 -0700 (PDT)
Subject: Re: [RFC v2 19/76] target/riscv: rvv-0.9: add narrower_nanbox_fpr
 helper
To: Frank Chang <frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-20-frank.chang@sifive.com>
 <87cba14d-0ff5-97b8-b1ed-34872906495a@linaro.org>
 <CAE_xrPgbj9aMJ3k6-WW72_Ng=hz=GNkVu5y1zu57efNiqkEd3g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f52af7ab-c3fa-5a30-bf79-643e7a88a610@linaro.org>
Date: Thu, 23 Jul 2020 09:14:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE_xrPgbj9aMJ3k6-WW72_Ng=hz=GNkVu5y1zu57efNiqkEd3g@mail.gmail.com>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 12:13 AM, Frank Chang wrote:
> On Thu, Jul 23, 2020 at 3:15 AM Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     On 7/22/20 2:15 AM, frank.chang@sifive.com <mailto:frank.chang@sifive.com>
>     wrote:
>     > From: Frank Chang <frank.chang@sifive.com <mailto:frank.chang@sifive.com>>
>     >
>     > For floating-point operations, the scalar can be taken from a scalar
>     > f register. If FLEN > SEW, the value in the f registers is checked for
>     > a valid NaN-boxed value, in which case the least-significant SEW bits
>     > of the f register are used, else the canonical NaN value is used.
>     >
>     > Add helper to generate the correspond NaN-boxed value or the SEW-bit
>     > canonical NaN for floating-point operations.
>     >
>     > Signed-off-by: Frank Chang <frank.chang@sifive.com
>     <mailto:frank.chang@sifive.com>>
>     > ---
>     >  target/riscv/helper.h        |  2 ++
>     >  target/riscv/vector_helper.c | 32 ++++++++++++++++++++++++++++++++
>     >  2 files changed, 34 insertions(+)
> 
>     The helper can be done inline in two tcg ops.
> 
>     Though, really, we need to coordinate with Liu Zhiwei's other patch set that
>     also deals with nan-boxing.
> 
> 
> So, it's better to leverage the codes
> at: https://patchew.org/QEMU/20200626205917.4545-1-zhiwei_liu@c-sky.com/
> but has to extend for the case of SEW=16? 

Yes, or what becomes of that patch set upon revision.


r~

