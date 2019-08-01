Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87A4C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415B220838
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3ynEE4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415B220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htD3K-0007O9-Cg
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 11:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37283)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htCvZ-00028x-Ty
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htCvY-0005g3-IZ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:23:37 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htCvY-0005fI-B6
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:23:36 -0400
Received: by mail-pg1-x542.google.com with SMTP id i18so34393499pgl.11
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=F8JZE4R18CgumGRf8d45OPL32zZTEyP9TDYrYxuWyRc=;
 b=g3ynEE4e4uUu6CAnsHniy0UTqa1t4/zPAjK0rGKSB8hteQbSrL9AkSd1nioUVf8AyN
 2d/J925FsMHPWNySFzxUFFk+JwVRZpyfAUtn5hYs9IUZ0tioTIp6UEM3P6qeYahopTUI
 PSZv4BCe5F+a7uP1yAGY6nmYXLl/WzUy6lXkThiDfxYs5lXRE0oA1V8QrOhm/ORyr2jv
 +yI7soK9mNizqRE1kb2qvRYp65kVL1Uz/9PzxC0CP2T10j945+InSslnFy/T4PDXI6Xs
 SKLtU75FGZ4aSq9HNQ1p5knEcZp6tDOhFwP1cH4deCaaN0RtuW6zY6LPh3GK1pXZ9Z3c
 j2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F8JZE4R18CgumGRf8d45OPL32zZTEyP9TDYrYxuWyRc=;
 b=Q4OTdaKHEg898dqMG0cyOcsDaAzy8jUr9HqLGP+0FSg/KzOAIZyoEwA0Xgyfabz3t2
 rUlLlk9mDsFD3FYy1lmUcW1n3c6YsFHkzRpH2QsKl4LadLBRK4JnjDcIGFT37c+vzarw
 3bdS7TvXc8Lh7BtFAuwzgmZKfPw1rENE2wndEMdrK6CEYiCZryK5AZ1E8iJ9oDsVqXPY
 3lPLuEKE6SQhGyeUk6xPTf6/Tzy66z5QOxpBvCxSfD/bEBVRGOM45DIC8mxlurkUoaf5
 jD86pqusGE3koIbitK6Y7bgdtVtPw7h/VyE1rNhskCQ9Vjvl/tKRxu//IilImdKhBdk3
 HSEg==
X-Gm-Message-State: APjAAAVR9L7Bcm77fvdQU6cu4rfz81jAAfv/TWeNGVf9B/XpMpDFnZTU
 CJDGERo8RaEvIhzBmIAmG+yMWw==
X-Google-Smtp-Source: APXvYqw3uFmWy7ox3cIKucI0BnydIhkJ24uO4RY9dLdJ/FpoSmfRD3dyuSncXX/LaCratacRRWIw0A==
X-Received: by 2002:aa7:9f8b:: with SMTP id z11mr55398747pfr.121.1564673014751; 
 Thu, 01 Aug 2019 08:23:34 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 4sm83835479pfc.92.2019.08.01.08.23.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 08:23:33 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e00fc51b-98b1-8b89-660e-b754f26fecaf@linaro.org>
Date: Thu, 1 Aug 2019 08:23:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v4 09/54] cpu: introduce
 cpu_in_exclusive_context()
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, aaron@os.amperecomputing.com,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, bobby.prani@gmail.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> [AJB: moved inside start/end_exclusive fns + cleanup]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v4
>   - -> cpu_in_exclusive_context
>   - moved inside start/end exclusive
>   - fixed up cpu_exec_step_atomic
> ---
>  accel/tcg/cpu-exec.c |  5 +----
>  cpus-common.c        |  4 ++++
>  include/qom/cpu.h    | 13 +++++++++++++
>  3 files changed, 18 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


