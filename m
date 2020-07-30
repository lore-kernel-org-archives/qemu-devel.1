Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469BDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151CE206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zI79pJky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151CE206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k18eO-0007Qo-AO
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 09:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k18cn-000674-8m
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:29:33 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:50342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k18cl-0006et-10
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:29:32 -0400
Received: by mail-pj1-x1034.google.com with SMTP id e4so972022pjd.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=le664zblahR5fuUIfa3M+DjSp8cBWGcGv1nGdRoW6x0=;
 b=zI79pJkyof8VS/FSM1hv3l4JCTLgNKxqMG/O64jiCtfLDnC++fbeXZOVRlMh2k8MDP
 UvokmYM32T7snYEmeARsrZHKmMRvOpxM5YX8MDonND5UUPljhwWK4ortCRkS6ICKsUHA
 2ZY/O2HdmmkdIvsOEzMlhUyHTrXc3u9WRPV3aJrvp/XfLHsPAMiC5hdUuPzSEuwE3Dj8
 k+TGArBPHUxvuLhAGuJY1nFJp5aEuoXXvItvunqg2TsJbX4w3dhvE+7AmAIrqM0wTfPP
 EF8Goh4iIP4XyNbCiwXwsoAWDnDKOxmyeYl3m+SFS1ogucQQVZj3tZegnzspxgn01XVB
 62Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=le664zblahR5fuUIfa3M+DjSp8cBWGcGv1nGdRoW6x0=;
 b=qxGbHxiRUUtTljxzj5iKnCblmgfMyi97H4yhzqWc5h86LbRHj+QL6ALjlcm6/UR4IZ
 1AlyYMOcVCHezhvPUHBn1i6Etupw65sYfDz7pVWgWnINUx30ZxZGCN2agfN7b0jB+7d/
 1NO4ye/OFzlBGBfMx0oFlb49bjT3KF16JBPflibPz3wNMCT/f6LP9Bj9k+RqdUftCDnw
 9QOC6taVXrDH4v/++6RKvYUS6K884imLH0vAbNMRrMmYlLcSnhnuBeot6gqI430xG896
 ff7dIb8ivwH6KF1vbyhCva0s4XwGiTu6i+hNIFQUP1cwpXe4rZejBIpGWELzCjWGG7xb
 iKYw==
X-Gm-Message-State: AOAM532BDeP0Q12+5yS1FZ+BsWZtD4a2vy0pnfNvxvVPCwTiPwX6NUkC
 dZJvpeFlgcRFrd9SZ3RJMjZWBg==
X-Google-Smtp-Source: ABdhPJwKFfkpKd8JJYtyUTtev1XCN5CKgv79Cx+Zk+cEndbTuySOgVsTwcaDB4hltMLAStsdxc3SvQ==
X-Received: by 2002:a17:90a:db03:: with SMTP id
 g3mr14105573pjv.99.1596115769416; 
 Thu, 30 Jul 2020 06:29:29 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k98sm5536076pjb.42.2020.07.30.06.29.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 06:29:28 -0700 (PDT)
Subject: Re: [RFC v2 35/76] target/riscv: rvv-0.9: iota instruction
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-36-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c3743a6c-8334-1e4e-03ef-6a0008deb7dd@linaro.org>
Date: Thu, 30 Jul 2020 06:29:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-36-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 7/22/20 2:15 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn32.decode   | 2 +-
>  target/riscv/vector_helper.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

