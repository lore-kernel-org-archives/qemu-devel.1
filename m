Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EF4C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0459A2133D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n392FVQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0459A2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbXOx-0001oV-MA
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 17:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50619)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hbXJk-0006K2-UG
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hbXJh-0001rg-TL
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:31:31 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42524)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hbXJh-0001rN-Mq
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:31:29 -0400
Received: by mail-pf1-x441.google.com with SMTP id q10so51387pff.9
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 14:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ca3pu0Ed3//IeabkA1dLGA2V9ofR5NB2wPhnVn1euhU=;
 b=n392FVQD4R6g8PuCixFWef83AoPpHz8+UeroTdUf8+baihqgvXSoV8MVk50UeSVhCT
 ckqQ57hoJI0kUJImpTi1wUf4UTG1JUlFTAagPBxz6HIRy7BtsYLtma8ld0oTBf8ySRL2
 reg8jIs2VWH/kMePrAFWeaTWwJNYhBJ/Qd9cpQcdUN8/G67sQMDlXVbOn3dIZeIeceCd
 aVmw1SSwyqNSJptY2VhuzGoeRMWKysMPer1min9UIEd/eLEarlOjycmTIh14g1wKnmbJ
 c1tDTDUYprnITx6fA5Lf+XPleFV3S2eGCbJBpfDAnMVGY5ZOjaJnjywGgCcEvWDZoEcd
 goNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ca3pu0Ed3//IeabkA1dLGA2V9ofR5NB2wPhnVn1euhU=;
 b=EFNeaPntdhJnHURa5GAiiC+Ei3elgEKcrp1rptgQDyx5ATpBmcN+BUYTsdAvU4Rrg3
 uXqY9hJ6ZDrwAdzuV7tb8IHl88i/Lrh6O1FEnGEC+o6UYfEphvgCHzE5n3K7t/+k0J2A
 m/x1FIuSAuxJIKwQG+GrUaIJpGZPP0VXoeUwGsUhBRtk0jzOC7+FIGZsMhTKeJ1lGO9G
 R+jNmLUivhMcL7ZxH9hPSxBBUUONHvaozcHAPLeku03hz8y98XsDZ3jokYiNxgaCIn9S
 J0VVqf3CfpxLPbMMnegJDnVkEozdjnYDQsCHTOJldZr3ddoP8OHG234VKoTjZOUHC4OE
 JU+w==
X-Gm-Message-State: APjAAAWd7Bkus0/tcVFYf3pkCGyBaTmzsVUbKOnpwO67NxgxckgvPi9r
 DNB9FEWV8g5wiI67FLhIfr1fnKDpxps=
X-Google-Smtp-Source: APXvYqwWls+gYw7SKHkSbk9+ilKWppKiRuXYMbVFBO3LoWLKQRJ0nHkZhtco+LPED/53LdVqlYAwwg==
X-Received: by 2002:a62:1c91:: with SMTP id c139mr87924136pfc.25.1560461488264; 
 Thu, 13 Jun 2019 14:31:28 -0700 (PDT)
Received: from [10.10.150.239] ([149.199.65.200])
 by smtp.gmail.com with ESMTPSA id n66sm612410pfn.52.2019.06.13.14.31.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 14:31:27 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190613163917.28589-1-peter.maydell@linaro.org>
 <20190613163917.28589-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <dad9bbe4-a445-3718-dfae-8e121126a5ce@linaro.org>
Date: Thu, 13 Jun 2019 14:31:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613163917.28589-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 09/12] target/arm: Stop using cpu_F0s in
 Neon VCVT fixed-point ops
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

On 6/13/19 9:39 AM, Peter Maydell wrote:
> Stop using cpu_F0s in the Neon VCVT fixed-point operations.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 62 +++++++++++++++++++-----------------------
>  1 file changed, 28 insertions(+), 34 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


