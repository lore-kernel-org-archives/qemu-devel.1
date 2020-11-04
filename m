Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECA3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7ADA206B7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2ap90iR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7ADA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLly-00068a-Ja
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kaLfn-0000qU-NL
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:30:11 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kaLfl-0000KO-3q
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:30:11 -0500
Received: by mail-pf1-x442.google.com with SMTP id b3so17734218pfo.2
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 08:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=z8+8lJBcaaxeDudhji8oxO1dQe3v2xf8xPUwrZzPgYw=;
 b=j2ap90iRMEVz6JgqBpQZ5vkG/oE8U096n16q6VZcOhM/S4tWAQFUbhxxn0VNa0zCVw
 80p/KFgWOI/VtbE9XUH7MOuveeFDcSHHA5WfVCvcv0sx/yXtmbQnsB6xC9qpA7z6ViJ5
 CFv9SYklqPbR9/UIXwGEcbGgcNLxEx2u2ztLeFyWScWnqK5OZluvxOjGFuBoQUyKSDV3
 HE1TaEuIlNDeysCTZIZ9wURlnSruSA5ihlbwZFhZM2MgXr1KfsVXloAH7HHc7mdxDTqv
 iUa+ZrUa4YMbEq/oq8aW68YMRHSkkwJ7QCrzIYl+KJ+sq+a5ZlVojTz4R+zZsWJwGugW
 2h5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z8+8lJBcaaxeDudhji8oxO1dQe3v2xf8xPUwrZzPgYw=;
 b=lwE+imJetP6vbQ5bQIv1lJlXyg74rrptYUF9D1llpq6hOSSVn2sOG7jeKbT+Rx2JAv
 xrHUJbfj24aP91xebXu0+T7LvxLOdI6yxE4y1Jn+5MQEYnsVzCPrdVIrlAzWiDHxNla6
 OZn4YaJtGNm/2uE0elBq+5OD5fxs2Db0ybHocqFbTfbGkOHf7e4GokcpA/Im92X86Zon
 LFpfGgY6cxKGvjeIXmUIL6e1Up6IDTGX+KYJjEyUihc1YNFek34puQeNszwi7PaX76j+
 227tVy24mb4sBbGVxBEpjK4ArCkufCFmyzA5YFq5cCijnLlHe2fQoaK/owS9KryPVXAc
 spJg==
X-Gm-Message-State: AOAM5305m/O5+TpxAquh58UEajIlNpz1S2sbf65jnnVaixNHB0MjKt2T
 RvhGtDeTTJuu2u8jvQvXwQcaPw==
X-Google-Smtp-Source: ABdhPJz9X20rwrAnRDp+vCxGSfiomoTfRf9eP/hvGyY0t+EQBy3pTTGvJZNj5FbZeQ9jysWcjxVPxA==
X-Received: by 2002:a62:fb09:0:b029:18a:df0f:cf2a with SMTP id
 x9-20020a62fb090000b029018adf0fcf2amr15971682pfm.57.1604507407404; 
 Wed, 04 Nov 2020 08:30:07 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id l3sm2689325pju.28.2020.11.04.08.30.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 08:30:06 -0800 (PST)
Subject: Re: [PATCH v4 4/5] target/riscv: Remove the hyp load and store
 functions
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1604464950.git.alistair.francis@wdc.com>
 <189ac3e53ef2854824d18aad7074c6649f17de2c.1604464950.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d4f57237-518e-4bf8-f31e-988251f1689d@linaro.org>
Date: Wed, 4 Nov 2020 08:30:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <189ac3e53ef2854824d18aad7074c6649f17de2c.1604464950.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 8:43 PM, Alistair Francis wrote:
> +#ifndef CONFIG_USER_ONLY
> +static void check_access(DisasContext *ctx) {

Newline before {.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

