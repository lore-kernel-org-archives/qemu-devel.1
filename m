Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8268DC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5182072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blXkoP5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5182072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihQJ5-0002V9-CJ
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 22:47:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihQHX-0001SH-8z
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:45:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihQHW-0003jn-7A
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:45:51 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41666)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihQHW-0003ht-0V
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:45:50 -0500
Received: by mail-pg1-x543.google.com with SMTP id x8so475842pgk.8
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 19:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bGfARsdCLz5Bkj4bxAAz0ZLKVs1p1DoNYlG/3BcpDrQ=;
 b=blXkoP5I8XVTLn9OHLlMkkqo+8h9Wd+G48X2meg7HYdfqneVVvsLgXlto7tKLCWxam
 QBoKsS+S12w7avHTOwV5PWm66kx1KK/ka02jJM26+kZvrDoa8WJLvEmZkYlesH/TJvJW
 UsaIG2MRihbh7tt7b0khHpbBPO40Zv/sHhm+rT3JgjH65Z8n71PWy5XGY8woGsvG+is0
 khzX/866sULBnSrrbiUwic36PI0c+L1Q54RSZqDu5kZ151HBjGaM8a85IGwJg0ZcBgCn
 QIAleerw/dy8GM4soIzjikNYOPrd3gQaouQkmGFWHnIdFBa5m+UIJt4OJ7v8JOg0vJg9
 oAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bGfARsdCLz5Bkj4bxAAz0ZLKVs1p1DoNYlG/3BcpDrQ=;
 b=my+kYgMucz0yRe94LhT/jtCSm244VoBbLvpd5xK+EBhe+T0IhVkG+B27ustMCiAJP9
 Hj6ss2NEth+/qHVuylKTe/jgFu1C7pC94kTV3iRZhHAIVrroelp/gWHRN9UWRsvwLXyw
 vwvlRxF0VwIj+3aDZ+iqfrkTZnSzzeMzT+3MCFtiUIe97HKZGVKi+n5vcrgl9bZzAKVL
 C6EhocMObrJBHwhiYVbV39Ng0qGRx48jufm4yhXSsYmAPeG+o89UL5oDqWMJnwdWyJKj
 yXN1t9th49Td/LyPJ2p+/24r1deXUwWJMvNT+de/qbNZtV4X4jiLEjiMg1IJTmAFJXpD
 Hg5w==
X-Gm-Message-State: APjAAAWwjOvgE7rMO3i/OV1gi1n5HZ41Iq5vxnAVgajNUtCx3f8yPjRZ
 1wQAxksjGpULlQYw6/O6Dcmyjw==
X-Google-Smtp-Source: APXvYqyRnnFSqx+UTMvs81vZfubBhd+o+BdbF2S46aqTYgPqURfT3vZeFqmEmLNRXHA8yEoPeEW5Bg==
X-Received: by 2002:a63:e80d:: with SMTP id s13mr475383pgh.134.1576640748924; 
 Tue, 17 Dec 2019 19:45:48 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id a6sm567390pgg.25.2019.12.17.19.45.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 19:45:48 -0800 (PST)
Subject: Re: [PATCH 3/6] hw/net/imx_fec: Rewrite fall through comments
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191217173425.5082-1-philmd@redhat.com>
 <20191217173425.5082-4-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d5f87b5f-b1be-9d7e-b57e-a8d9f4ac0127@linaro.org>
Date: Tue, 17 Dec 2019 17:45:45 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217173425.5082-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 7:34 AM, Philippe Mathieu-Daudé wrote:
> GCC9 is confused by this comment when building with CFLAG
> -Wimplicit-fallthrough=2:
> 
>   hw/net/imx_fec.c: In function ‘imx_eth_write’:
>   hw/net/imx_fec.c:906:12: error: this statement may fall through [-Werror=implicit-fallthrough=]
>     906 |         if (unlikely(single_tx_ring)) {
>         |            ^
>   hw/net/imx_fec.c:912:5: note: here
>     912 |     case ENET_TDAR:     /* FALLTHROUGH */
>         |     ^~~~
>   cc1: all warnings being treated as errors
> 
> Rewrite the comments in the correct place,  using 'fall through'
> which is recognized by GCC and static analyzers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Cc: Peter Chubb <peter.chubb@nicta.com.au>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-arm@nongnu.org
> ---
>  hw/net/imx_fec.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

