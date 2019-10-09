Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1AFC4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A01D206C2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qjdDw6zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A01D206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iI161-0007qN-Cw
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 21:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iI14I-00072I-PS
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iI14E-0007AU-Dh
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:47:08 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:47062)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iI14E-0007AE-87
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:47:06 -0400
Received: by mail-yw1-xc43.google.com with SMTP id l64so107423ywe.13
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 18:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zRt4S9oyc3QFCLV2pBB/cMLoUlJm+z+QANmW6K5tY7s=;
 b=qjdDw6zq9Hru4FPq4Dk7V111yGeuT8N59QivX+bXSTu4SSGpE0stcU1Zo1WobBNIbn
 AQRQQlZsO1fgA8YkR+G23pn841lVgPsp+lgYpoAM2dOGAJRnVia+TMogvniE9QKl68Xh
 jAn1LS72zmdCLy6LOnHKswBOMdHiNBHOO0NYrJqzBNe9yL5o2uGa+2R3FXv4DBKDh9Op
 v4kyZm3eihaQlT3U5Tc3xbh9wZe5jpSbkw8CvWQIreYvq7u+h0NF2jNq60lioEu27Ddr
 QUpSVGUpelMvCSgjChtAjEciaJW07b4hDKW8PTFEtR88Y4QtQ5gYU+yLLx5j89f+xEc5
 wQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zRt4S9oyc3QFCLV2pBB/cMLoUlJm+z+QANmW6K5tY7s=;
 b=oiaswBkD+THjB130jZW3Hxb7OOsmruSF78ZbPjJBF5KmxN5n6lT1JYwHHzRhTChQrz
 SnY9etRTiKRx+DWXJZ0CYK+pC8ADWuNO7lwXfmBimpg7Yx0qtDmKtVE4rsXM/WRg023c
 mnyJxmYlRTKUcg7i2NaS0NJHDgsABCfF9uLaR2rHW/ro6CLlBPbQdOQKCa3IZ80yXfb2
 aoa2r87dGTUYOLo9IcwUofFaCw1XqBx4tzXlcaQezGKcmQxq/+IlQDQ+eafmDiYK4rAV
 Ey8kVn7hXBpIx/xuPePcx2bFTDl8A4tsNJHSVWmwhRk3C/4aY32jGKBBhSRSk2C2E+yM
 3awg==
X-Gm-Message-State: APjAAAWkPKtrFvJWuiEQNcfXP/KAx9z+4bazGFyOA8wGwpl1fAOyk877
 957ShX5ytWEJPYhrDT7DPLRA1A==
X-Google-Smtp-Source: APXvYqwtMk9wzZt2nIo6CTjaSDYeeYOfzpjPceaQtxHryNrDr8GIjKuyV0U59uUy6ridpNbTYu40lg==
X-Received: by 2002:a81:4bd2:: with SMTP id y201mr1025374ywa.7.1570585625423; 
 Tue, 08 Oct 2019 18:47:05 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id w8sm206718ywc.20.2019.10.08.18.46.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 18:47:04 -0700 (PDT)
Subject: Re: [PATCH v2 03/21] tests/ptimer-test: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191008171740.9679-1-peter.maydell@linaro.org>
 <20191008171740.9679-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <91135320-6b16-ad9a-e2d8-5ad7186b054a@linaro.org>
Date: Tue, 8 Oct 2019 21:46:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008171740.9679-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 1:17 PM, Peter Maydell wrote:
> Convert the ptimer test cases to the transaction-based ptimer API,
> by changing to ptimer_init(), dropping the now-unused QEMUBH
> variables, and surrounding each set of changes to the ptimer
> state in ptimer_transaction_begin/commit calls.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

