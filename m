Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787C2C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB37422258
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YgGBzau+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB37422258
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZcAd-0000xA-UJ
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 10:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZc9x-00007j-1w
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:54:17 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZc9u-0003qQ-6O
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:54:16 -0500
Received: by mail-pg1-x542.google.com with SMTP id x13so11116161pgp.7
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 07:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kkKQH6mRfpBv2XRQzfJX+n4qLPHQiReKCiFv1dcikak=;
 b=YgGBzau+w8m5FnlmcUWNUikbkVxFTUlufLtA1BdrFMn9Te0HGVkuanQPwJQvYD+P9N
 hXTzvC1Yq452/BrssX5iIBdAWDoWKTwi9JqyHk1sOG21vG+qdCQXpznnspWkwUU2NWIX
 1BStYCjcWjhaUFglwYKtLPTjgdxMpqicKv1BWN/TajAq8Ui5BAWN3uiTlOSdpXBxQO//
 oAeRqFno4m0hGOFZodDtvzBuQTPx+RD79oDeRBjSaDG0ymFKvhDnBS+LymzOowTrIbgj
 P8+4ah1ibyfJqt8T5jW9Zv3N/wiuDoSd0ve5i/qSOqqt+HZJyMt0vswh3CGN2sW7UcOJ
 /ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kkKQH6mRfpBv2XRQzfJX+n4qLPHQiReKCiFv1dcikak=;
 b=tn5r4GAJPIrXBEhbx6xWT0VnYHBvu/w2HPbr8qEQbUbiOMBo1tdhbZ7/LIraA7ZtVc
 9JBOCfAH6oiVgSQo4u4yffB/LC2JU6JcqQ/fOPPqZ2S9+oebf5MOBxi1bY4DUIdw2Vg3
 /Vz/sV7dPvqCtUkfA/BC3tm0lfASQcPigTqI+oT5CIIM3oprpyDTDwYApts4omFXcTuw
 43kaGCP1U8TVvyCnXIdTd+OWIlZO8vxt8jdQ2IhvkLVXpBWQ/tLYP2a5H7vfByfESrUu
 aFzP0ZsU6B15eizRrOWJ7wA4fKFfIamAs6rvwXA5alWI2kfCYq3Gs5FsCa+nK5V8DVmt
 vbZQ==
X-Gm-Message-State: AOAM532Q+IbmDObVp/Z2MVPDb6hdHbIg/NhC0PZud6r1j11UDTDC7rdq
 cDJNfbiOUoD1glGjeoA5QgRBOA==
X-Google-Smtp-Source: ABdhPJwjm7Phz3RAg5xQRgc7s6b5/j1EsPLka1UIIcodXNubAs63p62wJsAglP2imqZZGyuHMVmycg==
X-Received: by 2002:a63:2021:: with SMTP id g33mr14083396pgg.5.1604332452280; 
 Mon, 02 Nov 2020 07:54:12 -0800 (PST)
Received: from [192.168.101.174] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id s11sm4148582pfh.128.2020.11.02.07.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 07:54:11 -0800 (PST)
Subject: Re: [PATCH v2] target/s390x: fix execution with icount
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <160430921917.21500.1486722139653938240.stgit@pasha-ThinkPad-X280>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fc34885a-13e0-8299-c757-6c75486aa1f2@linaro.org>
Date: Mon, 2 Nov 2020 07:54:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <160430921917.21500.1486722139653938240.stgit@pasha-ThinkPad-X280>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: thuth@redhat.com, cohuck@redhat.com, rth@twiddle.net, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 1:26 AM, Pavel Dovgalyuk wrote:
> This patch adds some gen_io_start() calls to allow execution
> of s390x targets in icount mode with -smp 1.
> It enables deterministic timers and record/replay features.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

