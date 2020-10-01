Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4F8C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:01:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7EBA20848
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIce9xcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EBA20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2tW-0005W6-BF
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO2PW-0002HP-M5
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:30:30 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO2PU-0004vl-KT
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:30:30 -0400
Received: by mail-ot1-x342.google.com with SMTP id h17so6262048otr.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2zTn6UmRDFxIs8ngnHnsvmIE7cYSTi6nE7o8QaMVh/4=;
 b=gIce9xcGe73X1XlmKYURkfoFvoZRnStNNJWyumKgE6G4bW3pCOdtLbr4JBILIEhNs/
 sywA8Hk6FJKbNJeHy4qEfUMnIf/6krJHv+BqekgEZquLrAr0iSqT+Ag6N/dlMPOqsqCQ
 4PKqG6IGTzRbJGi8UYbs/JqxCJZYBSATYWf1WHFxj8tGDxBRZQBq7OQIEdr70Zbqqxas
 UkrHek1J0nT8K6gUumjQTYyaUqCIZbbGJz3u7zDR/mBt257qwJU3JtBsu4CBbj92iKUm
 PFgr/2WDpC6PFBYGQWM+rV+IGQDCYxu6ln8SIHo1J/OMIJF2Tfps15nD04w4BcQqOLq9
 osSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2zTn6UmRDFxIs8ngnHnsvmIE7cYSTi6nE7o8QaMVh/4=;
 b=gOVkWgv+NN6ylF3GX43VE6cMsji3pU5k2JP3cuYRKQWye+SXvnwYqjEfP5ldQWtsQI
 ox5XE+OuifKsaPYHPT6gEzGtH1pZDzIE24CKkppAE/7hF2SMUkOiNkENP7+p3XOxPlFP
 YVEcyCiSSWhvFcXK6gCksZbyq0iYEQokWJMLEzYioY3WVwIbU/TgcIh11d8ox+E7KnSA
 u2iL7vQmjILOKeG+Qzn+LH2ySUog4w4lgXtooMt0Fy6JTuoRfCFkvdbRRowCqrR2Ryq/
 WUiXxVXXOMjSKgi+yZbzV0pOo+GTgEO5R6qB46o1VzuiRJ+DXLhla/5E2jVZSy4gEaN9
 woGw==
X-Gm-Message-State: AOAM533mwOzjgHFuR8A8bdeSPJ8/hzUnwpDAGk4hN9aFY1ndBHCmCuze
 HxuU9JMFo1F2bWfOCNyoZ0hsxA==
X-Google-Smtp-Source: ABdhPJwA7IsNAMHtf8Ilb++VnjC5zb040uvQ3EaOqsxb03NjE5mdqfYClFCr9x+r4M8ZqPJ3cDWmDw==
X-Received: by 2002:a05:6830:124d:: with SMTP id
 s13mr5560103otp.12.1601573425829; 
 Thu, 01 Oct 2020 10:30:25 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id u2sm1467840oot.39.2020.10.01.10.30.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 10:30:25 -0700 (PDT)
Subject: Re: [PATCH 4/5] target/riscv: Add V extention state description
To: Yifei Jiang <jiangyifei@huawei.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200929020337.1559-1-jiangyifei@huawei.com>
 <20200929020337.1559-5-jiangyifei@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <adfc3dc2-606f-5670-4b3b-c0719826a60e@linaro.org>
Date: Thu, 1 Oct 2020 12:30:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929020337.1559-5-jiangyifei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.26,
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
Cc: zhang.zhanghailiang@huawei.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, victor.zhangxiaofeng@huawei.com,
 Alistair.Francis@wdc.com, yinyipeng1@huawei.com, palmer@dabbelt.com,
 wu.wubin@huawei.com, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 9:03 PM, Yifei Jiang wrote:
> In the case of supporting V extention, add V extention description
> to vmstate_riscv_cpu.
> 
> Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
> Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
> ---
>  target/riscv/machine.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Though of course this is racing with the v1.0 patch set, which changes the set
of vector csrs.


r~

