Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A75C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB5A21848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QCsr5M7k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB5A21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i18Zz-00004r-5r
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 08:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i18WX-0006KD-Nb
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i18WW-0001dH-Kn
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:18:33 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45163)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i18WU-0001bU-Mm
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:18:32 -0400
Received: by mail-ot1-x342.google.com with SMTP id m24so8520309otp.12
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 05:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jZVslk/s2CGtJfOBeOGpr+pgecW/7dXqzCewqbgW2Ho=;
 b=QCsr5M7k1qk/RIaO6no/cTiC16+cTYm/8FzRCmBltOcUATBfuC1KBoK+LWN5d2DRAv
 kNoYgNl95870voVS+5cCC8oA7Odf4rdKvVS7YuTD3h+KtpWh2rHxS9eue4E6Tb9+Knf3
 7l+H8TK5f54uK8x3XRHqSzxUH248pJ7IPsDujp+9qpqjHord9YDbI8b+RaxtpqiRbJtE
 /KiXmXTDYzpHz8rePOoS7wIcNVfnlT/iUXATp5QmycLGuXnGm1R05VdiW441QXYTq0DW
 jBUtNY2nGr0IEdSmerrgeMyFPyxHvbdnqmHf0LNQ+IjF/RPolSq/j6Iu3pxXMYam/NvB
 I2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jZVslk/s2CGtJfOBeOGpr+pgecW/7dXqzCewqbgW2Ho=;
 b=XSZzm1+E+qDGv5uQXZlokaDsjGxO4zKJvBULtmelToSANh7YMVsDdiW5S+ojNmwR4a
 5lAa7MDySJ3s8PNGuv2PjWN35yp8qIoNAm4yFYCDPontmWArfKEZf8l8MXibOxScn5hu
 NQAeF05FwLVNTs2EvheGrYaxmY2dxpPXcMIIgsGrZkLR2lkveptDbZmJ3jklKLL/lBoO
 YWNzmQ5Y3YGz/DweidtYOfP0cqiVBix6CUR8+iDzPl4TPZfBrYMaJ8TGExjRGs7u/+FI
 e74NtvZHVJ+r5DOu+veGsXHmlWQognCVHJ4i9BL+BF/o52XntUzXxrRC/CZHJeT+Kwyo
 8AfQ==
X-Gm-Message-State: APjAAAVtYQJUVX7Y/ZEOElQLz1ll3TW0kwYizgHTZXfVeX/LZBMekq32
 D6m49A6LydB29vOcH3O/nHKlQNCDxNHRR/XqQFtwRg==
X-Google-Smtp-Source: APXvYqyd+aif0ke/gfACt6RxFMNgc7urFzkkTF8CDD5r+IseyMukUkBsrUTpYkWX+ry5rBnVJcxIcBIwFug75L57KNY=
X-Received: by 2002:a05:6830:1015:: with SMTP id
 a21mr4047900otp.232.1566562708591; 
 Fri, 23 Aug 2019 05:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-6-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 13:18:17 +0100
Message-ID: <CAFEAcA8y+peVsV8gDcAxwoPoi=GuGjrVWBbZ2AsUwKHXAN-0RQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 05/68] target/arm: Convert Data
 Processing (immediate)
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
> Convert the modified immediate form of the data processing insns.
> For A32, we can finally remove any code that was intertwined with
> the register and register-shifted-register forms.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 449 +++++++++++------------------------------
>  target/arm/a32.decode  |  29 +++
>  target/arm/t32.decode  |  42 ++++
>  3 files changed, 186 insertions(+), 334 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

