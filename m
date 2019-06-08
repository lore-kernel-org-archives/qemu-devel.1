Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD234C28CC5
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD57214C6
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="li+2JogW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD57214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60050 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZh4B-0000OF-Uz
	for qemu-devel@archiver.kernel.org; Sat, 08 Jun 2019 15:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37417)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh0u-0006Gx-T4
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh0t-0006sk-VO
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:28:28 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZh0s-0006r1-1C
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:28:27 -0400
Received: by mail-ot1-x343.google.com with SMTP id i8so4897304oth.10
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2019 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sEWy4COw99n712ZJ7B/Et7osu3nKhiB/4wnnmeFoF0U=;
 b=li+2JogW5zqYiub4oPSZy1MiJ1TrmV6tBNrUzltsPE8lqag33NyGH9NTkMxWkwMy7D
 EiTCQUPuoC+dvWg/MbfqSlUl9T7x5/ZDLx15Of9sJ8TWtyJ3CQkBotAOKbY8HbTR5cqO
 fruut5SOnQC12JENjvluAqYTW7Crp9rM5OEtZZvYhtySLxqddPz+Y/QAn4ts9lPiBOSI
 MXsMXFqJlfy1LE0yyVKZ9LH5BVZHqoP9P+vA1/IySWnxyAwEBuU2BSbZ8HjqFDdlIvRM
 sJcGoClYGTpEfi+o9oBjqmNksWidYO0GLxKiIdJbuBRQmOej3nV+H29VcQ59SWFWzmj6
 Dd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sEWy4COw99n712ZJ7B/Et7osu3nKhiB/4wnnmeFoF0U=;
 b=gMZV7pouI8LSJ0Hww+AkGuP2iuPWYdBXMbgXCHC6PHhwQqvhrzQ7j29NEk87XfqQ2a
 xv5EznRpMETiyCB2SPSLdYXtE3u+yfvmgSjHq0bb6jEAa9gjaNYVfAjY8JZSU3TMbYJH
 cGWimBJtMnioHFjwOpBfAVl/0ERB+uwcxQRPTr61XZVvy4vPZsakveQGcy8suaQr2yWB
 9/8Rh7kcZ7Emz134i4KZzcjdh+Av/jS3syAdUjRXGuCMFr89l2met6x7zlAf/W3MDFsm
 HrLVs9QKo70/m85wBwmqhnZDaJoL2RUBnqWkW+HJ9CXr4j96I0BMxIJ524t2P8ODEihL
 WK2w==
X-Gm-Message-State: APjAAAWLQUtqm8JZGqUkIVOtNv6nYCQ9HIMIp1DJGD7qAOigS/M8OGWY
 oCnEzE7r3V2tD7qr6YqpEWVdQ2LmozptHA==
X-Google-Smtp-Source: APXvYqwYWLXC0gaiB41BJJYuoI+81+V+nXB9OknDaYu2Qu8wl5cP60wB4sbBxTQXB6vvPo+iNz0Y8A==
X-Received: by 2002:a05:6830:1597:: with SMTP id
 i23mr18685914otr.281.1560022104175; 
 Sat, 08 Jun 2019 12:28:24 -0700 (PDT)
Received: from [10.219.49.199] ([187.217.230.84])
 by smtp.gmail.com with ESMTPSA id v198sm720230oif.0.2019.06.08.12.28.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Jun 2019 12:28:23 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-25-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <49572456-073c-392b-ad26-9d87a79056bc@linaro.org>
Date: Sat, 8 Jun 2019 13:29:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-25-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 24/42] target/arm: Convert VADD to
 decodetree
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 12:45 PM, Peter Maydell wrote:
> Convert the VADD instruction to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 10 ++++++++++
>  target/arm/translate.c         |  6 +-----
>  target/arm/vfp.decode          |  5 +++++
>  3 files changed, 16 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



