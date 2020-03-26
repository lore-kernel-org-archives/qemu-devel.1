Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B22C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485DD20719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="smIwbKab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485DD20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHZdI-0001uN-FE
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHZbg-0000up-Nl
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHZbf-000507-I4
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:00:04 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHZbf-0004y8-CV
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:00:03 -0400
Received: by mail-ot1-x343.google.com with SMTP id f52so7488580otf.8
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+PYrOq7TUYA818Inl+HyxYA4YQ2VIlEfwc1rhNW2TP0=;
 b=smIwbKabexgcfT+BxFbZXnDPrdZKeZORoCH8xKIVfPkeOZM5mDjyzczMUbW7kxOG5t
 rtIyvGlkWqU1k5lxHgzAJuz8FPqjzJXbARVvzUC2m5kN0z1tHeNnvitY/pUrimy5+sVw
 AoAwogHFa1HupJx8ocdXBZy8Y35ki1Ofnhjhb0nZDS+h/+kss3R9puNIJvfIvNe42idV
 /srEpjqQ+DXpIe6n3ArD+1i6WZH73xA6wS0LI5lfZI179A9oxe4aVBLTtJSJgT8sqDhp
 CnBfeHPH4IQ9cazczqQZzDAQLBVAjsHTlwVgs1kwspyq562RAOtiTy359aJ0ss/llPdn
 Pmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+PYrOq7TUYA818Inl+HyxYA4YQ2VIlEfwc1rhNW2TP0=;
 b=ZN0Jw4hQEZpfGFqK3xtzCzFduS6ajP0kNChn2KvckPpvPx1Pq1HhXjiAuDmviAW9OI
 lshwKri4tTHXchxDX72sGPvurVfHZmLZS0HyhBKZc65uou+6lTMzqJ9X9MDJZ61n+tie
 MvgCIcYFbwxmPu9ZY6LH8G4sTuOG7kS7T8IDqIPJNIgm+cSRDS6rGPxXW7rSNB+LsfR0
 gZuDKKGNxwdy5h6XFORIDom1oyIHsr7+pzwAAQ95gVYV3fIgb/phdbSBsQxBKKMXGJQ9
 OB29i9EmVBBTWRh9KG2hzBS1nDg6oS3Nm/etl0oh23S4RS5AnNjqQXf3JcQp+aySe/Os
 WAgw==
X-Gm-Message-State: ANhLgQ35kCuuXdBwDum2wQLRDYHihxchbIvjY4qSpKUDuxiHAZzvUP/G
 hXs1h0mU8a8b6aMKAVYg9dEY3Ia8YwWdM7aC9o1XTA==
X-Google-Smtp-Source: ADFU+vuSNaiUnlFnwW2eGvcwsMaFUtL9TpIM0ryJhFN8nHrGAmvRZAP2rDEXroDMnHpKKiEV/v+CP0mW1CGn6QIwyzg=
X-Received: by 2002:a05:6830:18f4:: with SMTP id
 d20mr5271984otf.91.1585256401760; 
 Thu, 26 Mar 2020 14:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200322205439.15231-1-nieklinnenbank@gmail.com>
In-Reply-To: <20200322205439.15231-1-nieklinnenbank@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 20:59:49 +0000
Message-ID: <CAFEAcA9gPLjy4bee0SggsmMiYHFgw5Uhd6kLLgxXvGrZaQjspw@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/arm/orangepi: check for potential NULL pointer
 when calling blk_is_available
To: Niek Linnenbank <nieklinnenbank@gmail.com>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 22 Mar 2020 at 20:54, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>
> The Orange Pi PC initialization function needs to verify that the SD card
> block backend is usable before calling the Boot ROM setup routine. When
> calling blk_is_available() the input parameter should not be NULL.
> This commit ensures that blk_is_available is only called with non-NULL input.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>  hw/arm/orangepi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)



Applied to target-arm.next, thanks.

-- PMM

