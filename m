Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399F6ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04374206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PGn6pZxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04374206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHTHJ-0002Rn-1W
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 09:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHTCu-0005op-DZ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHTCs-0008Jb-Fd
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:37:48 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:44600)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHTCs-0008JI-B0
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:37:46 -0400
Received: by mail-yw1-xc42.google.com with SMTP id m13so5098130ywa.11
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 06:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kjGEkegORlysiCvDcBVThRl7o0UalPLlBqkuzJN6oyA=;
 b=PGn6pZxFk6UjITHYaKjIXHAs/qgRpHa3gsAO/G6gYN1NwxcbVjYpBZi5IBeOiW6k51
 M5RSAKriSKPdO/25dU8ZxtcmhF64WBzfK7lkhV/YzcAxLmmko2u52OvEFw152+aLB2sQ
 5nskhDUOQBm7623qy8jGDz49y2SgF0LoAkacGfhT06Z2t3EE8HoOIbOKiExw8sF+PLbG
 EFc2TxQcRF4EBSXtqxNuLdq4UL8UJQCFfe5DlzusmCatdcvkOkhd4N/hZ/h0a5VeXc1h
 z9fW68+5NmkFUS88/gpySYgufVuPlhuubEvoBziQMfFu8LLGSXlRUSOnmmzD9Svs30Vu
 vJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kjGEkegORlysiCvDcBVThRl7o0UalPLlBqkuzJN6oyA=;
 b=i3ob3jF4Ju/pZ8qd1EvqwwuKP9Yh6VT4UM/XZCJU/OxFWeH/H5gNLhP34hzLfYxtl4
 G6UYkTrH06jizoiDPtC9c7vcr1V1PSRFFuaeNMYdViYtuW+WsVaRcRXQrZLOBn1eqWBX
 9gRg7d0z/M5KsuSvJxHEa/rwcq8zKuEm6iiTbQXI3MSG6pw6i+MZIJHbRWAGL/0jtWyw
 1auUjo65cs7mCZE8x4NQhIFWPoLQbG18nEBEZDwCT0rP1Q1C7jk3RM4Qt46rB9VBAi1k
 ZER/PjKJLBae8E4WdA+/evMtSP08KHGcO75vQJwDCkPDDo2OhFEEuW8c/1GYtDRB6xUt
 xM6w==
X-Gm-Message-State: APjAAAXyfQVQXbhi62x09BN1ItjWXDgWAzUvNfjiXcB04u2UGP09DSiN
 /fiR8qvtLZXH97mXz3v50hZqPw==
X-Google-Smtp-Source: APXvYqzRbDoV11Xq8RUZa3izNtIYsb4feRG+vTQXBCk3z66HjjTgB8cwBMW6Dhq6nu19nHcJIoCGvg==
X-Received: by 2002:a81:a903:: with SMTP id g3mr11917115ywh.188.1570455465740; 
 Mon, 07 Oct 2019 06:37:45 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id v204sm3779080ywb.23.2019.10.07.06.37.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Oct 2019 06:37:45 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2 02/15] target/arm/arm-semi: Always set
 some kind of errno for failed calls
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190916141544.17540-1-peter.maydell@linaro.org>
 <20190916141544.17540-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ea400570-4446-5d2d-9e19-82229b9e69e1@linaro.org>
Date: Mon, 7 Oct 2019 09:37:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916141544.17540-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 7:15 AM, Peter Maydell wrote:
> If we fail a semihosting call we should always set the
> semihosting errno to something; we were failing to do
> this for some of the "check inputs for sanity" cases.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/arm-semi.c | 45 ++++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


