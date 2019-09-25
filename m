Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F26BC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2151A21D79
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zWHDKJeV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2151A21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCdu-0006yZ-TZ
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 15:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCR1-000291-PS
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCR0-0003wR-OG
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:54:43 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDCR0-0003wG-JH
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:54:42 -0400
Received: by mail-pl1-x642.google.com with SMTP id y10so2948298plp.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ubnhu78GQ+rR/9zYKXC9mYAg7Kto6JyfkCEsqK9skic=;
 b=zWHDKJeVNWMYJU9am0VgAa5rYhdwtrhPHWKmqKEbthylVytl+097HSq0shyWxcQ+iX
 SlizkryrJtJ5jMn8bBEM3ybeNC2v7eyDX8mOLNQy5fcNsIrds36dsm5GqCPON+X8Fnj3
 RotJ+62BlCe49glrsQysvG+Og4M4ZaMwR0AMw659JyVhK/oedpNRcBOy/5KV/Gjm59zb
 1k2Ujx1j0uwP+GwLlysChPgiVXWG/JST0xoYCLbh6fQKblIIJqFRl51fh3Hk1wz018Lm
 gU8y27ob0tPghRNDlHaXLypdw9UDbfuNt9Rrz8HkvpndBzhWdQGsdAmEhUAFbKrgMqss
 myGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ubnhu78GQ+rR/9zYKXC9mYAg7Kto6JyfkCEsqK9skic=;
 b=UaVU7hZEI8o6fCe/5ah+NWak4atg8xfIS4bvB4Q76I8+E8YgSsRqz4U3/xOY3z4y2M
 iv8R23gzdZKq0GHyjYtkdJUN2jDrhWdJLIQBpvXUxSq1G1c261hTCYqEFrzrKNNBNj4w
 CZbU2NcYelEuwqyRarU/djdyb8kEcZFQgb6I877G6N6DQF4bQn0EDGQupfivh8me+LKI
 tTJmMn9nDe0uuAjUXYGE8+LdOwRUxDK1OpsZMZiPCtnZnlBGPaflLxlxg3Z+BINBrqCk
 kJLFHR2nm0qI9CvVAaPHdnca4xmruK8/LtBp52qIwTLUg3eVbcPvywKvJwDwMFWFblTq
 HzNA==
X-Gm-Message-State: APjAAAVSceOp2FCvRvcrgiIKfYEkM0VjyxcXUb7n9dGq6vxd3EL9wVrl
 eyVlSBOMU1xO7Aq1upYD9x2S8g==
X-Google-Smtp-Source: APXvYqy5TTSj804Bin1s5ePu7uxNekVXmnsbgT8IfqKCknODviIQWidBFQu7Mz1e72oGiEnuEAx1WQ==
X-Received: by 2002:a17:902:7885:: with SMTP id
 q5mr9947594pll.299.1569437681292; 
 Wed, 25 Sep 2019 11:54:41 -0700 (PDT)
Received: from [172.20.32.216] ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id h9sm266231pgh.51.2019.09.25.11.54.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Sep 2019 11:54:40 -0700 (PDT)
Subject: Re: [PATCH v3 18/33] tests/tcg: re-enable linux-test for ppc64abi32
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-19-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5a8827d4-71d6-9702-a1ee-012ad9a49aec@linaro.org>
Date: Wed, 25 Sep 2019 11:54:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: jsnow@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 2:00 PM, Alex Bennée wrote:
> Now we have fixed the signal delivary bug we can remove this horrible
> hack from the system.
> 
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - drop un-needed cflags
> ---
>  tests/tcg/multiarch/Makefile.target | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

