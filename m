Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1F5C35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A362067D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6mlvJ4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A362067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5AoF-0004yI-5v
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5AmX-0003PH-UG
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:04:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5AmX-0003yq-0o
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:04:01 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5AmW-0003yd-S0
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:04:00 -0500
Received: by mail-ot1-x343.google.com with SMTP id z9so2436837oth.5
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 08:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cbNrZE4MQtjj7M5CHdQeU/3MnI3hR8oaeJyT8p8EYug=;
 b=f6mlvJ4unfKci45F2Lp84TQD26TnEyjwyOCfDiOA5H6eoX8p+T2LzHpDickPn0McDG
 bXAdHLkscZFFfcUUv2bB5UZ+DtpL59YNiEVCEcP6bOOmjyE0b9IvPAk6mqUVDY1NgXg6
 3FHHN6jtL1303jEucKjixoygDRHoONtqsaFfs/SNWRpUc8oYIUmJ3oetD4QoopZvbdUV
 rXv5rCfMToBDJ5F2Amu9sIKrLLAXo8Icigqc0wB3lNaPBMBvyAPVwb4QuVWIECyK1B6H
 u4ga7mKE0F4cEYqXkdGWb41NWG++dlfPI0itcQHvmhrwKpaK4iRUQxiPGQum9p1/REg3
 CAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cbNrZE4MQtjj7M5CHdQeU/3MnI3hR8oaeJyT8p8EYug=;
 b=VMzyhPnv0FZ14reLjXwKuHRAu1TxtwS2JoZ47sSN2Fa7Lj9TsC6LGadROO+9BGtviy
 B8PqJ9xmqgEl25PcXLxOCyqs99jJAxl9qFR6+uZUYf8mNShePG7Pr3S2KBJCpwIiWBtC
 nqYSHkX6aDM7GeP9VghklqVf8WOzlyH444ULZHykCPIdcYtGSDHZdkb+enqdKSO4qrnJ
 tvYiHC65N9fBuKQSqFQzsIDXwAUVARcpUNKQJtV9RXwoaiqVyq7NzXI/UGWreJLtX+ax
 e8UYQ6NFgm4zP5F9aWFoJT6MEBfYE7l6tKqUphp2TzILiIVtIbz4W33rayeN3VCqDj3r
 Ih7Q==
X-Gm-Message-State: APjAAAWxqaTlzWVAtdUmsB3eoyxBkAG7wcF33esHL6sK+EnXj3b7XR1p
 ab/mDjWsjzyKNXKR+XsA6FTQQUPTvudIppirTJiRpA==
X-Google-Smtp-Source: APXvYqwwU1wxJ2d2C4NJmlvUBf/yiSJuJXNjiY1NdAhq/V45YPTrc5zgn4J0KoRF1Q0zKeLAqkpl1JvLIq7+N2PZWbM=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr26918262otq.97.1582301040162; 
 Fri, 21 Feb 2020 08:04:00 -0800 (PST)
MIME-Version: 1.0
References: <20200214181547.21408-1-richard.henderson@linaro.org>
 <20200214181547.21408-8-richard.henderson@linaro.org>
In-Reply-To: <20200214181547.21408-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 16:03:49 +0000
Message-ID: <CAFEAcA_FcWbZdK8GHWZenc59dFjwkBQFadtaCdJb3oL9NyeWUg@mail.gmail.com>
Subject: Re: [PATCH 07/19] target/arm: Add isar_feature_aa32_{fpsp_v2, fpsp_v3,
 fpdp_v3}
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 18:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We will shortly use these to test for VFPv2 and VFPv3
> in different situations.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

