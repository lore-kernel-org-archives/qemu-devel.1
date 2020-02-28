Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1696FC3F2D6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:01:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA40D2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5aguyXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA40D2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7i4g-00008D-WC
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:01:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7i3d-0007rc-8L
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:00:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7i3c-0007OH-23
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:00:09 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7i3b-0007Ni-SG
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:00:08 -0500
Received: by mail-ot1-x342.google.com with SMTP id w6so3043661otk.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DYcyqLtloNMOKf4+aHy4rctiix2R1RH4TFRh6wVuz3Q=;
 b=Q5aguyXqHdC9oVBe/rIC74Tcv3Om/Pt3YRjy2ZAOCuc/CtZfbO4ZcQdqLG0qk8LdPv
 0qAulqUVkOwAA64jx4q7yh6mfm0WrKy7dn+55AobGNIExSp3zRpgi+kKE7rxV0IcWABG
 x5fCG32TB2agOzOYrhtHXTTgLHiiQDq72sgMUW6xt/Z8Ps1BxazJPrGHSzBkb9YtWVkc
 bN+QSh4b4jaGtx9Zp1wzNoh9BJAs12t59Kq5ixYVYuoA45jk60VgkXUqlr0oX0MFcUHK
 uUXA1Ir0SfwP7/J98nQcrIUxTH7meTJFVFIEVCP/b4WkPp5Bu58QI/vJnCBzQ/uKXNB4
 x22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DYcyqLtloNMOKf4+aHy4rctiix2R1RH4TFRh6wVuz3Q=;
 b=P1bMtRvckKdH6V4rrNoK1CVs2OCK4AlicUMaQPggSAeyKU63kR4DcAGY6L666a663Z
 9kDJw3quB4FlJjEXWphLxJkiV7wYR594CTGZGPbUfXpmbZ4PnvJJ1NEjFUdf9Fy8cC93
 1n5soxCEpe6awW1gR9WK8EnFBUSJvjZ3AXURoiFxOxE0OUGzLt8vYi+ORTf43zYTmm/S
 hjAhTa7MYcJPpOgQf2xj9C8NiCEgQPnEwQezWAJcG5K2zLOPUcrXFew7pU7bN7LrI5LG
 I1OtXZuxM12N2iBAJdp3rX4YnCl8aBhP+X1IHfKGbuRjhEEy91NEweycon9NSpmTVzfe
 TrGg==
X-Gm-Message-State: APjAAAVYRuROXav+uktpcWFl/knLLK7jWg3IM4r/XdYqc/TzM2to5QVo
 MUMq1zGL2G5RtraT64h4sxri62SjX/RtExF5YA8NjQ==
X-Google-Smtp-Source: APXvYqzmbcjB5oGZsTNsILhkFXg5LjvuGGbgz6uinmEILT34ilVOnir6KaZM0wo2OXCpDIuY8Ob1RD4SDmPfIZmwWUs=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr3879886oto.135.1582905606816; 
 Fri, 28 Feb 2020 08:00:06 -0800 (PST)
MIME-Version: 1.0
References: <20200215122354.13706-1-linux@roeck-us.net>
 <CAFEAcA-u=j3MYu-Ck0UbMzXXEoB41dx6UbGw15QBEnqBBX988g@mail.gmail.com>
In-Reply-To: <CAFEAcA-u=j3MYu-Ck0UbMzXXEoB41dx6UbGw15QBEnqBBX988g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Feb 2020 15:59:55 +0000
Message-ID: <CAFEAcA-_V-7VDZvVg4WE99A4b1UimQ0RrLG910qmsxCgRVvq5A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] hw/arm/xilinx_zynq: Fix USB port instantiation
To: Guenter Roeck <linux@roeck-us.net>
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 at 15:05, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sat, 15 Feb 2020 at 12:23, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > USB ports on Xilinx Zync must be instantiated as TYPE_CHIPIDEA to work.
> > Linux expects and checks various chipidea registers, which do not exist
> > with the basic ehci emulation. This patch series fixes the problem.
> >
> > The first patch in the series fixes the actual problem.
> >
> > The second patch removes the now obsolete explicit Xilinx
> > support from the EHCI code.
> >
> > v2: Introduced summary
> >
> > ----------------------------------------------------------------
> > Guenter Roeck (2):
> >       hw/arm/xilinx_zynq: Fix USB port instantiation
> >       hw/usb/hcd-ehci-sysbus: Remove obsolete xlnx,ps7-usb class
>
> Xilinx folks -- could you provide a reviewed-by or acked-by
> for this series, please?

No? Oh, well, applied to target-arm.next anyway.

thanks
-- PMM

