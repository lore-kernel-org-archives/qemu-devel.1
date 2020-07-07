Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4594FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 156AA20708
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cI7W9wxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156AA20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqi4-0006eg-CB
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsqYZ-0005b9-6x
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:34:55 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsqYX-0003qd-Kt
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:34:54 -0400
Received: by mail-pg1-x543.google.com with SMTP id z5so20250282pgb.6
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KZFIAAerN2VSuI0pTmlqsB1JGnEdtAyyyxGNN/wYB0Q=;
 b=cI7W9wxWBxmQZ6HqNm4dtixFn9vCjGZZXfO23ePYmNBYcoR6L4NQs9Hyib5MkBB08h
 0zwKBXP7s0vRutAWY05ESCCqjpUpqaR27ehx0jJE5L0lslRs6qH9IaGwpqqp+XcMEg/l
 cfoHTQ7YRXHSawWrHwv44ZtYvAz/TqiCYXlySG9DEX7uSh1ahZDU5tuKhQx54yMAd3DW
 o9QkjRyY/86z6dZyoXMxdy/PJX7zGUQqqxNQdt6UN2X3TRhPEcZqjr4awGKQQQnxdMzE
 DngtH6IlZ2KHuxDhL2l1FdXQpDw39EyWevTHsy7TG7mSzIz+ouQ0vSruHc2Ib7czTWzP
 a+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KZFIAAerN2VSuI0pTmlqsB1JGnEdtAyyyxGNN/wYB0Q=;
 b=BkgvbWPsw17G2xxZz2FK8TdJB828XSTIeJfRrZH46j8PMITl3xP1QtF8IJjAt0/Nig
 D09jF1P97lO86pUM6nlCM5u4HXYfbWK5cHUNEwLaxk/h6HhhVTT5iZlMdT1US51NzMie
 jDJdNRr8G0I+yxn6kmnNPfTU712znnNavyvt0L1XLuJP1E88V/rTET5+l3iziAG8SJXO
 7GVV/VMC7wN6MffsDrNyFGdwnHgUwGt1BKvjiX3ahNY4bpc5MH6rp0eBwNL+S6GZ5U3O
 fqpSuLpw0tAcpBiv1WybHO0VnjyY3CJ5cwzOA0FQUDuFu30YhEGqWsV+L9hBi1ahvl8s
 Uwlw==
X-Gm-Message-State: AOAM533VsMuTsACkCQz31MP8JZ9AGkpHn3dhDfAiZjM6+s/uAkRb2NrI
 Nzmn46ykrC0PxmfDyOY436ENOQ==
X-Google-Smtp-Source: ABdhPJyHAZc2wUlT+MHyxJPbYqkqt6WXe9idQhh84JtkD+h7tv69IqEhPldU02H6gqFzB8dN25TkhA==
X-Received: by 2002:a63:182:: with SMTP id 124mr42728284pgb.288.1594139692196; 
 Tue, 07 Jul 2020 09:34:52 -0700 (PDT)
Received: from [192.168.149.206] (097-090-106-114.biz.spectrum.com.
 [97.90.106.114])
 by smtp.gmail.com with ESMTPSA id h1sm1398271pgn.41.2020.07.07.09.34.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 09:34:51 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] target/avr/cpu: Fix $PC displayed address
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200707070021.10031-1-f4bug@amsat.org>
 <20200707070021.10031-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0acbaa4b-5ed9-24d0-e738-57422888bcfa@linaro.org>
Date: Tue, 7 Jul 2020 09:34:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707070021.10031-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>, Michael Rolnik <mrolnik@gmail.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 12:00 AM, Philippe Mathieu-Daudé wrote:
> $PC is 16-bit wide. Other registers display addresses on a byte
> granularity.
> To have a coherent ouput, display $PC using byte granularity too.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/avr/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


