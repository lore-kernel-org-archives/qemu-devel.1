Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A87C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9D9218DE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sjq4qw9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9D9218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIEaY-0003WR-5b
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iI1tO-0001hy-9h
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 22:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iI1Kg-0001rp-BS
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 22:04:08 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:39122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iI1Kg-0001pz-4X
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 22:04:06 -0400
Received: by mail-yb1-xb42.google.com with SMTP id v37so216578ybi.6
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 19:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5lsty+u3GGo0ciZD01kvqbZylMlzwcQX3SLZQAqU/0o=;
 b=sjq4qw9ZAEUHeEFBLKIuPjRqLC9DO88kN56zEQ9HD3K49xhCgZpMuTY/KoKeyKpaiD
 jYcZMAxeSACuwlae+YQK/KDcwir2J322xPe1LLdn8qlhd0sj0fWfNEpsUJ+c4q2CHVpX
 PLzPMmCH4xB1otrIbbJS1QDzcrT01YaNHVXQ87qJ2A3zseGQ+mG6RxrnfTKc10COhVnq
 +Y2D2+3EkjHKYwQlJMlDVWmXXPJHHt1xRjVy/5Ge7lzwClTVtGJeeA7zreesty7f4zGL
 e17hMBgjF5s428rgg50xROtCCstJLoK+0wMHv6q9RTyM5xwQhqdYlvgBH3tDFrOP+qt4
 caNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5lsty+u3GGo0ciZD01kvqbZylMlzwcQX3SLZQAqU/0o=;
 b=OMluDz4RRpv47LVoJDD4Q9rdJ1USUZ5KmU69EIsndeo4G87zmV8Azez/Wdc2kxUkAg
 5byrh4mCADZJVd9tU5NGw7vrPdpzfpiYabQQ9svilI2M2TqlVuFceGCzq6O0ry+aADNq
 faxWPIRJyOQNhIwD3xktKF6vod5ROuwUpCfBn+uEU/hSh6BoCF1DMAje0QHzaRaoz3+z
 DCXOS8zODXwJ6/PsbGlPbEwH+BzTu6jdf+504xveIi1RZ5h7Sm/sjpoAfQIupfeS+TBJ
 8gZtte0PcWftPACBFSz5WPXZWKol6FIbRIrecRkkvbIRfQi0NJpGyJ2a0hi6UHm22SOg
 vIsw==
X-Gm-Message-State: APjAAAX2rENQsRu4VxJGXOU49hycLXogy+cr2SaU2sBYRrw/q61ZU8pm
 M32DvhqWEOBqEYdH5TXOmUBfX13Sc9g=
X-Google-Smtp-Source: APXvYqzg4U56qhO7iDRpYeEgobfad7tp7kPxOlbD0BKrg3ehqSiF8HMJyARv7bmqrln/EaojwwVf5A==
X-Received: by 2002:a25:1802:: with SMTP id 2mr445666yby.369.1570586645109;
 Tue, 08 Oct 2019 19:04:05 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id v63sm210325ywd.100.2019.10.08.19.03.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 19:04:04 -0700 (PDT)
Subject: Re: [PATCH v2 17/21] hw/timer/imx_epit.c: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191008171740.9679-1-peter.maydell@linaro.org>
 <20191008171740.9679-18-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b872442e-f728-44c2-3138-83d970f65e22@linaro.org>
Date: Tue, 8 Oct 2019 22:03:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008171740.9679-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
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
> Switch the imx_epit.c code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/imx_epit.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

