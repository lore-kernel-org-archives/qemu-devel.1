Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7381AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411B1205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxG6ZFMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411B1205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1CmP-0007Hw-Lk
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1Ci5-0004Rc-L7
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1Ci3-000129-9G
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:46:44 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1Ci2-000112-Pl
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:46:43 -0400
Received: by mail-ot1-x342.google.com with SMTP id b1so9342706otp.6
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 09:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IuAe64Q/l5LN9VgHYx6UYknOlef/jaOgSWIEXk7OMOw=;
 b=sxG6ZFMMvFdBG6r6mbLV3zB+R1zkav6tnpbXBHZ8ddQEpQWIYxTtAUuyqctMQKsb/l
 HmiW6S65m9cD8UcJioXut1CXUHPnGIvFeC2Vd8K93X0sayABtuIRAYiYeGfukUWkMIaa
 JUpX+8ioRhLX3AT9rRDNSNH/JTZvYsIc7NZ1knKNxqLMv6OGnKreQ4DyiugfJqklxx5S
 y6OfBImb3wt4kW1wfRa6PRZygZ2+Htrb5abTaOJpgPN7tNS21pVE6cgzj0TRiLxNViki
 17tYMc6ZayAX7Yf4oRa933XkSj/o0WG6e8mb6GFn4sAB1e92YDBY7DG/hIPWNJI0lQrH
 A0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IuAe64Q/l5LN9VgHYx6UYknOlef/jaOgSWIEXk7OMOw=;
 b=pm//H+yX/0fWvyQK7OzmUqF1FIGvFOh93CELXlb2aHFYmW/TzXxNwlGTmbssfxWrXH
 bP03LaZFKU8GtCAiGD3fJojGF1f7/Pe+qJRkHim2AQIF94nPISsKpgeApy7DwWziKN5U
 fwehMDzkUX/OSUBu91qT/TjXKlTUIJ43F3Bz3vj8JY8IezlfEnscXjHN2nnX7CxoeaG4
 VXRUWZBtRxOdiW50ajeSExorBPwOj86xDBp+gy+xVlYLPNenph0EgPzmcsMd12Kd4pKT
 rkLVjWQ1jLhLcpU6iSB//pvlkE6SjjKGB3xUar4Ln4UlsKEcM/aSZVrhPt+xtElWeXWJ
 sFIQ==
X-Gm-Message-State: APjAAAXcm8A9KafJkIJhnUbp21v0G7x4j9hF+nmBctaFbpJligAEjOFc
 ZT362mCuIdXs3EnVfvDQZjyBpwMpL3f2rdKIzUm95A==
X-Google-Smtp-Source: APXvYqx39aBJPYAlhs6pgegVl1REI1f3cv7THxXlZ+7bin2YLwtni+RjQJ18YzykUxF4Ef8Z6vIJHr9+rivwBOfXqcc=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr5165513oti.91.1566578801327; 
 Fri, 23 Aug 2019 09:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-25-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 17:46:28 +0100
Message-ID: <CAFEAcA9gADKuxy41y4THYozTvOEjqpg+wXFjfH2m6HNr0gSC6g@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 24/68] target/arm: Convert Packing,
 unpacking, saturation, and reversal
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 22:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 541 ++++++++++++++++++-----------------------
>  target/arm/a32.decode  |  32 +++
>  target/arm/t32.decode  |  37 ++-
>  3 files changed, 300 insertions(+), 310 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

