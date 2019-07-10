Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F03C73C6D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 06:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D2120651
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 06:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QqJkLn2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D2120651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl6Zx-0006nT-2N
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 02:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53331)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hl6ZD-0006EH-FF
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 02:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hl6ZB-0004bb-HG
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 02:59:03 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35418)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hl6Z7-0004Wb-W3
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 02:58:59 -0400
Received: by mail-oi1-x243.google.com with SMTP id a127so816534oii.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 23:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XFC/MHhgEfE1Nr1X5gKwGHcvslnu2HFr4KUXcEkFuLU=;
 b=QqJkLn2penLobTO8LA6zYjoP4hvpb/K40qkWaKw+EfybH9ukfJ/tDJ1t9fC6IYlELi
 pk4uBFy7a7UWU433quQrvwkXrckU6QGaO/YRh5NOO0Vh6e7Lm9ENePq+yJYMZ32CfxpT
 WvdUXe2bPJN3GHA5kx20uD125/yucMjDr6GBiDyUfs3HcOPZdKdEkETph5YwPeXfhAt3
 yP894fa7ByRpdi9J0SD+xNHqNCiS/SYaPSIiZpbBjLCtpoECjfmJt0GgKyUjI0i0uP1P
 nsm9v86iVOIBrdimJa9p6o50cvZb+SLuGDfccpx9gHl2l1ckKRL78OnUQn/rY4iERcKK
 t0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XFC/MHhgEfE1Nr1X5gKwGHcvslnu2HFr4KUXcEkFuLU=;
 b=sycoMeeTD25E92JRZFWmyUWI79PCsHRCgomVA3uDrVyEQxNLzlrSYa/p86TCW7moO/
 xHQiP/36+mFELZHipxd/ZWRtTnywXY0x7YIcUIpfAqBJj5XhUG7wrsI/Eh0+KYYyS7wZ
 N98PT9GFxDk9SEZOlEIKpjNPjUXB3czAqUBdbeBK+a5/dqdwH6xVTlnNitgTY7bGR1h3
 2IkNa3U3+9HS1K5oJOZDtOC9Oh2bEhk7t0iJugsAIsRM+T2Q44ecckAuCQMxrunrVd/3
 uJf+9jkYCvyu/tos5BpoM51gxmANfh8T7VuoWTdpk+WB2Agi0QnUv/5poNZ+HlCki3AO
 t6qA==
X-Gm-Message-State: APjAAAUkPJuxdFDI21DzbtnTwn0P8es525Kt2dDN7RpFlFLxz/06knb1
 gho+aJvkk6a6nZg9Xt8wqY2Z+g==
X-Google-Smtp-Source: APXvYqyiWlvXOn9WgM02ds8lR8EvTJyN55e/d9sXN8XZrp+GAUg5yX9LVJptk09Z85aIfligIKaO4g==
X-Received: by 2002:aca:5246:: with SMTP id g67mr2224940oib.116.1562741934515; 
 Tue, 09 Jul 2019 23:58:54 -0700 (PDT)
Received: from [192.168.43.94] ([172.56.7.82])
 by smtp.gmail.com with ESMTPSA id v22sm571659oth.19.2019.07.09.23.58.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 23:58:53 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190705160421.19015-1-alex.bennee@linaro.org>
 <20190705160421.19015-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d2af01c5-bb85-e6a5-cb02-f73e741e5324@linaro.org>
Date: Wed, 10 Jul 2019 08:58:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190705160421.19015-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v1 2/5] tests/tcg: fix up
 test-i386-fprem.ref generation
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Jan Bobek <jan.bobek@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/19 6:04 PM, Alex Bennée wrote:
> We never shipped the reference data in the source tree because it was
> quite big (64M). As a result the only option is to generate it
> locally. Although we have a rule to generate the reference file we
> missed the dependency and location changes, probably because it is
> only run for SLOW test runs.
> 
> The test still fails with mostly incorrect flags and different than
> expected NaNs. I'll leave that for the x86 experts to look at.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Jan Bobek <jan.bobek@gmail.com>
> ---
>  tests/tcg/i386/Makefile.target | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

There's nothing here to guess that test-i386-fprem is in any way natively
runnable.  Otherwise you might just end up testing against the installed qemu.

On the other hand, at the moment this simply won't run at all, since the input
file is missing.  So I suppose this is good enough for SLOW.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

