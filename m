Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAD4C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD5020663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLYL6BLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD5020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv430-0007LJ-0j
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv41q-0005bN-OH
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:22:18 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv41p-0006XC-3x
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:22:18 -0400
Received: by mail-pg1-x543.google.com with SMTP id d4so6461305pgk.4
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 12:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gYRKHZZJ65fxofSwdcKBSsdm5k/y1sTx4JPCuYlJkKk=;
 b=PLYL6BLA/OD4WBQ1erPdBsBTfLai+2moYhfh6HH8ZkgUyMxO/+BZ9U763uNAoF1w22
 +D/bnTh9byU2MfAiCP3EbYLqVQ1HQR32jYIUyoBkbuGO9m0gwnJ+ErfSWESNKXAxToi1
 abFVequDXfu7YRfm7vtlTBote4JVz/uo/Dj/1Daw3cLk0X0vhlXWI84IQbmSkzwLIKwW
 6WbpoSPvyKQcGkO5zaDuTobiAorT6IvOJnmKi4DnEM0bEJJE55r9ucrIPa1KlZxnggZO
 yWliKWaP2F3fOiHdTnRZhOMReEjAo28oExvPl73BTk1JTgke1n6f44+jh0LQoNgYs16n
 o7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gYRKHZZJ65fxofSwdcKBSsdm5k/y1sTx4JPCuYlJkKk=;
 b=kV2bvVmxB9ynpKcuYCkScIkEmLlEyCoR5Wvje3HYVl1ayPstUOuxO5kcRKM31lNTM3
 dzvpV5N/txT6v97IjRvMErCjF3a8AVr9K1COZ1vmAz3AEgJADw/MCxgea4g14N0tBkZx
 AS5cPO5yPY0qu3IPC17Dhdrm7HOobfhjy4IoT/I7ZFTkTcii8zI7uWt3WcDE0ScR5RVT
 cUiPPSCAse94NicSp6KQ4E0xdNLzY+txrJRYv/RVOeIqqpz3dA2MThT5dKvsWPEHBiN2
 tOOGQ2u4/BBKDcl8jQQUPlpw0P+OhBuk0EMT3ghBbcSo+7Ka0X8gQikDM1Vz0f9Rwezx
 tOQg==
X-Gm-Message-State: AOAM533nO54UzoAshOII+zAZ+mQYEcGrI+MQ0Q7mSbtgcx4FMI0DGpXQ
 nkyJ+djStrBq0u8JM57j8Q2a8A==
X-Google-Smtp-Source: ABdhPJyGC/J9MUujmnRu6cN1zFcmrE1VhyyGSsZPVWw8Zc5kr8BeaGIOoIT5NY6I+qHaMT115WwoLw==
X-Received: by 2002:a63:d944:: with SMTP id e4mr552326pgj.376.1594668135879;
 Mon, 13 Jul 2020 12:22:15 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u20sm16157478pfk.91.2020.07.13.12.22.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 12:22:14 -0700 (PDT)
Subject: Re: [RFC PATCH 4/8] fpu/softfloat: add pack and unpack interfaces for
 bfloat16
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org
References: <20200712234521.3972-1-zhiwei_liu@c-sky.com>
 <20200712234521.3972-5-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <809406c9-5b12-06eb-6634-c47800684880@linaro.org>
Date: Mon, 13 Jul 2020 12:22:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200712234521.3972-5-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: wenmeng_zhang@c-sky.com, alex.bennee@linaro.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/20 4:45 PM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  fpu/softfloat.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Similarly, all of the static inlines are unused and clang will warn.  Needs
merging with subsequent.

Otherwise the actual code looks good.


r~

