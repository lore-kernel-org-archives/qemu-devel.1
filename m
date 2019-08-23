Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB10BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A75206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKtfDzql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A75206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Bul-0005a1-Sw
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1Bss-0003wn-Gy
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1Bsr-0001sF-Bx
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:53:50 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1Bsr-0001r0-6b
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:53:49 -0400
Received: by mail-oi1-x244.google.com with SMTP id k22so7336235oiw.11
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 08:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wGT5CIRpmIvinPclMWr9KZrZpY0xjN+/dF52/I6pKtU=;
 b=XKtfDzql4eKufSOH5voJkiDYIpr4mf2n84DX/5SMq338k6xl7L9hhuTSUNnw27A/R7
 HlnyXK5IomPRNHWnIrvIIzEHuO+LYiw52+WJ7fHgnopB7aH6gzlzghxph27Imkgey6uT
 ct0T4MEUDWg9fokgzyCxnxeEiRBm/dGTfogl0ONYtv32wEjhIRwe2pBjf8CA9Ff+RknH
 CzqCvZH8geAnD4G/rsrFka+j6Jr3PkSHw4nSKiQA8YVv8VX1Ynk/J9qXEYw9/SQN2Si0
 G57PaIpcnX+DhJA9T/xDsyvV/e7lIltCWvy5a0S7QL03mg5rxHCUfosdxvN0pxAVK0Cx
 Px2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wGT5CIRpmIvinPclMWr9KZrZpY0xjN+/dF52/I6pKtU=;
 b=FaouRfC0kBPTi3vUB794WzkiZDAURHZWgdkPmbnJ2uHpcYCucB4jxJLyCkVhDdxFTa
 +54CT4/IYd9XC7jKqL+PamPul6NiSSnCxtcIIKCJ0RYgLt/GaVKYqvdr2ZdYzRXOixkM
 vz83xEYb6N3BTQ1kHC4Lk3Z8i5b3C8Nt+rBE9yfKwjpikoEriZTKhX+8PiMGkkZHO3jV
 8Ai0/qbOynNYdFyY1Yk44RVlTfWttQgVGQp7e9sy+G2Cv2HxjmGukI4vi+DR+/N4L3dg
 R0XTge4HnkDeDJ1jQSLFT129hAjwG81KL7Q4vHxYWu0/8Ebm9BTdkyoDPpYUaNstKx4I
 uHCA==
X-Gm-Message-State: APjAAAXtPhNt73uV9A/3ldvypWgpnwjfYqHLKcvJYGw7kajd9+aHa1F9
 ce8ezN6hcFo1VBfDe2FKhhDMDjpSXJrARXILsnvpWQ==
X-Google-Smtp-Source: APXvYqy/GPrt2Vpu52prvKKa1F843LZ5N8ny8zSW5FOypnGHlA0O3sGUd5NBNokCqR5EDWD77OjNu+qEkncEoxYurVE=
X-Received: by 2002:a54:4718:: with SMTP id k24mr3582109oik.146.1566575628134; 
 Fri, 23 Aug 2019 08:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-24-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 16:53:37 +0100
Message-ID: <CAFEAcA-p630ZSwBkdZ5ZGi+12ktjo1cJeA78EV1U9r6VSvm-jA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v2 23/68] target/arm: Convert Parallel
 addition and subtraction
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
>  target/arm/translate.c | 229 ++++++++++++++++++++---------------------
>  target/arm/a32.decode  |  44 ++++++++
>  target/arm/t32.decode  |  44 ++++++++
>  3 files changed, 200 insertions(+), 117 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

