Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7882C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC6920661
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPapeTgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC6920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZoF-0003dz-Qw
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZnP-0002o0-OW
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:58:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZnJ-000683-KK
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:57:58 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1ZnE-00064f-Lm
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:57:53 -0500
Received: by mail-ot1-x341.google.com with SMTP id b18so11041363otp.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dS4V1ioc4cE+TiPXsCl6QMyY7qNQDAKLHZvdg6nxPoA=;
 b=bPapeTgXEHZZG7XwvGW/52yMapoF/lnwM1o6x+Hd8wXeJjoM2dnSUxN7qjUie2J6Z0
 ipb9wC13SpCeNoMkRgH5mecnHSUjj7/GRv1gRy7SvVH1E+cJcGzQI1ngGHd9p4JdS2ny
 RMK5/KIXRCYfQh1ZECLyMzoGxRkASvCclzg1/obhOpVZpg4TwcP+U2vhdopOjz2vNUuV
 K21EHVcruMrHuY6ExgoHZuQI6yeV/LjweSeqG/bWvXYhcSxfU/wvzp9U0IEG7fYIP8gt
 dq5tY2MkiwiADevwbZS2T3EE6QbIPx4PnPAnr3XcAIgLP5WU6pTWFkVOSBGcix4HffMV
 WOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dS4V1ioc4cE+TiPXsCl6QMyY7qNQDAKLHZvdg6nxPoA=;
 b=QNyb79jfJCCCbMNVyeDKre0hK2MytjQuoOpXpCnH0/CUNy++D+CB6oI8cbVNpdUzzo
 qCc1J8NroYtHJy5KLWlK7uAEF8GS/lB6beM5WOqku4Mvp577sCFXemMhNgJr0HO0Svqt
 TbuIQarFiJGq7X69d1nll2WIOaF4RKTMQFwU9gXo97oUx1KApWbRGeQ7d8iDTsCRykY0
 ZXm1xdHFI1Twb5jebTfZph+qRQb5l2W4Ajcahx/5gIbYTyiD8RsDEWU7/BwfWWuXRLfa
 AqnT0yBq2Tz5Pve+QKoUFF6mx1C60oHsALDjZ8YwrFqmDwFbsaZ4iXXUypHx2xJ0bT7n
 N9Wg==
X-Gm-Message-State: APjAAAV5/45exLfNAGGroJDfPvJMNC0fNOXttoUVFWSMjndPpHfCGNvR
 Rca+mX0mRkr/tFtInUHL7it5zm5s3jv1bhj5QZUcKQ==
X-Google-Smtp-Source: APXvYqy6ZTQ3eeBgoBU0CoP1gbElTWnucT1IgvpQa89sQXcYq5spYJV6lbqnLJ8w6NUzWRK9COboxuLmiyTHuDrr1nU=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr5772377otq.97.1581443870716; 
 Tue, 11 Feb 2020 09:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20200207095409.11227-1-rka@sysgo.com>
In-Reply-To: <20200207095409.11227-1-rka@sysgo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2020 17:57:39 +0000
Message-ID: <CAFEAcA_vgg8mVw+-vfjWcouyOOnM_qZPdsPFmSgatV4Lq5Panw@mail.gmail.com>
Subject: Re: [PATCH] i.MX: Fix inverted register bits in wdt code.
To: Roman Kapl <rka@sysgo.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 09:55, Roman Kapl <rka@sysgo.com> wrote:
>
> Documentation says for WDA '0: Assert WDOG output.' and for SRS
> '0: Assert system reset signal.'.
>
> Signed-off-by: Roman Kapl <rka@sysgo.com>
> ---
>  hw/misc/imx2_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to target-arm.next, thanks.

(It looks like we're missing a lot of the watchdog
functionality in our model, ie the actual watchdog
timer parts, enable bits, etc etc...)

-- PMM

