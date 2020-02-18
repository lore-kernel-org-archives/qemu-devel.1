Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423EDC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D56222B48
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kzP+omZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D56222B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j45UW-000859-9c
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 11:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j45Tw-0007Ia-7f
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j45Tv-0002FN-AC
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:12:20 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41357)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j45Tv-0002Ep-5b
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:12:19 -0500
Received: by mail-oi1-x243.google.com with SMTP id i1so20596523oie.8
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 08:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=diqUIbnas6JmCw7SoalRilqZps533oNRD6uGhMaUQlw=;
 b=kzP+omZvhGZ852gQPXMJ3qVbxVkXOroRU6D1nPDX6uOvL2V5HKmghUuSi3Hz0WlkHI
 VPMgVCW46p5e/uO6xfu8OmRxxRvWPiOQvsrWuJqE9A04X57j8Up55Mq69H/CNKfnIC1p
 Lr+3/IKKxMZrXpjjoythhVDRAX4cuTNM9AmicHgd+hWXPrd6eNGRc9PswOwf3WVHZk9T
 CcNCClXUKaaRO6sSRjvzdULmuIV7xLS5WRUqCKcMzQJF/G5aoF6d7SiIj/SHvmOtdJ5/
 Mkx6GaDS8AeqI8gM4Vbh85G7BhlUK34E7vqrVAj8Ve4aPAqrO/Mye30q4bPZhKnNicqh
 ftgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=diqUIbnas6JmCw7SoalRilqZps533oNRD6uGhMaUQlw=;
 b=DnP1VPPnyXYf1rlQie+d/yCx+fSoz91ZYj+zSIBRnymGr3TOcwUIvA3x6Ybsag4dpW
 nJnQuViwE2/ai6tYif+5gdoeQPu0BBf4fnov37/Sh5CzVkG3CfQOWPzy2Pu0qVFyH3jj
 VOCJ6cE3jeVw4028auEI0Bz3YmEegP2xEpKA7T10aTdYwEezPPf6AtrAreH4ptFbeWfF
 yeFEO1laxjC0FCGicNeovJ9rVJmYqIGGLY7QgPsx8B9dvZy1Ab5ha/o30pfZ1GqabDwk
 zKP2UscWil0zeLNYC6270guo/lmB7Rog9ioBX6c4tiU5wwlXZr4d8fN/ZHq/QkRdorUV
 X8+w==
X-Gm-Message-State: APjAAAWx+b3TxrAz6Q6bTj1KWpkFl3nAEzU7bSRcSvuVaPTY5jnQM7JI
 UTYFk6NiZhXW5Iz9f9/XNkfb4LB4+xHG4fts5Nn0pA==
X-Google-Smtp-Source: APXvYqyiq0YOOxPD4CJPdDzFnLJQHG4xBqem6y0naHysMsFa7Ec3pDPntx6qYQNDfs4pHsey/21y2av9qaZIMB4Zkuw=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr1728254oif.163.1582042338286; 
 Tue, 18 Feb 2020 08:12:18 -0800 (PST)
MIME-Version: 1.0
References: <20200217210824.18513-1-linux@roeck-us.net>
In-Reply-To: <20200217210824.18513-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2020 16:12:07 +0000
Message-ID: <CAFEAcA_Wu62uLmopZ4Kw6usJOdihaT+mT5XyudxsZ9cqRDmWBw@mail.gmail.com>
Subject: Re: [PATCH] mainstone: Make providing flash images non-mandatory
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Mon, 17 Feb 2020 at 21:08, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Up to now, the mainstone machine only boots if two flash images are
> provided. This is not really necessary; the machine can boot from initrd
> or from SD without it. At the same time, having to provide dummy flash
> images is a nuisance and does not add any real value. Make it optional.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/arm/mainstone.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)




Applied to target-arm.next, thanks.

-- PMM

