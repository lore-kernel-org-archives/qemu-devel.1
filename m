Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5202AC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22EB7246A3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hPwgdEYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EB7246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7jjX-0008Qj-BP
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7jWr-0000Wz-62
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 12:34:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7jWp-0001OY-SI
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 12:34:24 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7jWp-0001NM-Kn
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 12:34:23 -0500
Received: by mail-ot1-x342.google.com with SMTP id j5so2416374otn.10
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 09:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sBIUHdFk3EbrkRCJts37Rg10Bb3EBo8aVHGIuB60uZ8=;
 b=hPwgdEYusz22FKDuFz7kNfZipngEzkEYDkSf+K5Q1Hw+r+m4dxrMgaEyiTqmvwKyYN
 8X/1R+uxjXlIS96+r/dKGCq9Cfh8T6mWb7XeR1rnY7/Wg9tuCPTFrWQe0f/Y9+oFbqkS
 mi3zo4DrVRc3VRCQ4xeAV5D2sVmThPzYf4FAi5qXwiQlYdrYlpcepGXGa81lttEmkgQ6
 DRpi6G3vlSajW11l2qL+MQmhAqnoPwPXFOKoWK2x+EQ8mXNq5H5XaehyRw7te0rfF3CC
 El8eFQCH4RvvZPAqMbULoG8L90ODQIOQKFJYargHj6gbgmd9IqO7a63lLIsHkgoJbs/0
 857A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sBIUHdFk3EbrkRCJts37Rg10Bb3EBo8aVHGIuB60uZ8=;
 b=YLzkXmy77IvScgs8g1gqjKaIND5c+I1usFd7urxihKtQTkZiy6k449f3RGBf8A3uGw
 z5AHKBUhAaRwKT/QAksvzCTBQg+Xzmq0sTMGf7hhAkMeABbLZbK7zXqIXcn/8WMow6UI
 QoxEZpIOgYoLBRdBcIT01zv0bIr2bkbmLPMq5yvKurSVAow8QajMRltgYaTGm88pxsV1
 G+HTqvPu095LjBrVUrPPFZBjXZFlWPNHla4ohFw9YoJSzAWcBj6R/ZEqzvFG3tlaH9FX
 DexJgAKh7MvbhoaNHlIETXoh8gtc6iJxKVjoKNy1XuL2cnU7CmFner/THh3O02iQVPCe
 BYSw==
X-Gm-Message-State: APjAAAVBQUk8g2wyVhsiO8Zo4IVTwPhiQDvjKjOVfcgb/qQrMxWS+iTl
 uNO1G7PmVjo2b9aWE7RLQQq63cZjAImIZZwLxRhKkg==
X-Google-Smtp-Source: APXvYqyMrbiSi4XbMNUsKLYoIOroyWKde9pBfsoub920VlPm40sp2JbA6tkG4/Q7wtpm80ldGKq3eH+cIKeDYCyq9+E=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr4295899otd.91.1582911262143; 
 Fri, 28 Feb 2020 09:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20200225180831.26078-1-richard.henderson@linaro.org>
 <20200225180831.26078-2-richard.henderson@linaro.org>
 <CAFEAcA8ipK0nZioEgbNq5B1L-tqA+rzn-C2yyfet4_4yNVnYqA@mail.gmail.com>
 <e4a70637-f4b7-eaa7-237a-57053c5a63cc@linaro.org>
In-Reply-To: <e4a70637-f4b7-eaa7-237a-57053c5a63cc@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Feb 2020 17:34:11 +0000
Message-ID: <CAFEAcA-8a4eQXf+LRS3KLURyyEPpPm9uh6q6r6D-1-sh3t8Pdw@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] target/arm: Improve masking of HCR RES0 bits
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

On Fri, 28 Feb 2020 at 16:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/28/20 8:22 AM, Peter Maydell wrote:
> >> +    if (ri->state == ARM_CP_STATE_AA32) {
> >> +        /*
> >> +         * Writes from aarch32 mode have more RES0 bits.
> >> +         * This includes TDZ, RW, E2H, and more.
> >> +         */
> >> +        valid_mask &= ~0xff80ff8c90000000ull;
> >> +    }
> >
> > Isn't bit HCR2 bit 16 (aka bit 32+16==48 here) also RES0 from AArch32 ?
>
> Yes, and it's set in the above.

One of us is miscounting, and I don't *think* it's me...

bits 63..0:  ff80ff8c90000000
bits 63..32: ff80ff8c
bits 64..48: ff80

bit 48 looks like it's 0 to me.

> > I'm not really a fan of the hex-number here either, given we
> > have HCR_* constants.
>
> While plenty of those bits have names, many don't.  Shall I simply name all of
> the ones that have names, and that differ from the aa64 masking?

You could refine the valid mask as the & of the bits which we
do want to exist in aarch32, rather than &~ of the reserved bits:

 valid_mask &= TTLBIS | TOCU | TICAB | ...

?

thanks
-- PMM

