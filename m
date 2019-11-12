Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859BEC17440
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53DE0222C9
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PrMaHm+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DE0222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXAX-00078o-IF
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 09:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUX9f-0006h8-Do
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUX9e-0007Gf-4m
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:28:27 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUX9d-0007GJ-Vb
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:28:26 -0500
Received: by mail-ot1-x344.google.com with SMTP id f10so14453951oto.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 06:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fe8N1BZM0xkNsSiZJ7HGJnw6WEKLsWZrtY7oNiAed7k=;
 b=PrMaHm+yqb5b/cqHAQ2yBAT3dUK9hs2r6FwUyu1E3dBTFpAZrMEMqfp45J6+zuYUD1
 dNOBp2he8ZVL7GgdOlCCzskhFbAGr4H7+TLix/36C3xFmZpgzKaadVr1uKUyHALp9pBM
 M1QY1K3OveAmNeLsUj3GaznrSX0MICodRhmat5FlMomum2q9WsNha9doch49PFDNpE8E
 o6skhI2xP5VqML4lg+t8rYpWkXJ4Bi8yvPnZxOYekg3nmK3+ztSYUo0xeEwfKCr1k26x
 Mme0nFiaiKSpke39TCBIdqzI97jhaCPZ4/8wiBc5oZBvMPwOTDsCydkamcwe+dQv72Bb
 xtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fe8N1BZM0xkNsSiZJ7HGJnw6WEKLsWZrtY7oNiAed7k=;
 b=XFNb+BfDsNUGrM2LKt3IYyBc4Lm5A1aqEFoj7DcwCi5ajoJTN7dtr92LPe9VNmJKkz
 pFrklmjvdPgNIz9Tjtnlryc2vAXpP8Ueab/9u94PqslVPa+HOwMFJrtf/94OJXOOIFU2
 mIJ+foHESp2gQ+7Ojc/mgG1ZhjrhBPlWvjaaRlukG9yrJw1icZFjPNjPHSlldWlG5O8+
 ZE9yYg0tKEadqTpE8/LWut3TrrGf9PSDvkgK6VFk3IsCjx8eOKpOw5JmJgitJcwiN0x7
 hML+DX1vkJOo2I+g2WOtruA60IDiA1Amr/bTE9jyh/iMqJRW+HrSW92AHvLj8dQNckag
 9Z5Q==
X-Gm-Message-State: APjAAAXzaqJGY2m8tXbYo/PMjQEBTVe9gTqtxOnvKpsRq66wXeXYTMM5
 vaCQ8O3aF6PJimgITBy6WabHa+L3Yct88p4VfOqvnQ==
X-Google-Smtp-Source: APXvYqx94FbKcgKnFoVbG3yFel451D28FSkAqC2Jsdpbo1N1Pk5sH7kFmsAY6s9erumpj55MtyYWpkkkdxa8ypYcOsI=
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr15808900otn.135.1573568904859; 
 Tue, 12 Nov 2019 06:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20191112142556.6335-1-laurent@vivier.eu>
In-Reply-To: <20191112142556.6335-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Nov 2019 14:28:13 +0000
Message-ID: <CAFEAcA95SbwnkDOy+Y6MVBYm1HAP+XoJNqNaXFGqOEsO5wB7CA@mail.gmail.com>
Subject: Re: [PATCH] linux-user: remove host stime() syscall
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: "Daniel P . Berrange" <dan@berrange.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>, Cole Robinson <crobinso@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 Nov 2019 at 14:26, Laurent Vivier <laurent@vivier.eu> wrote:
>
> stime() has been withdrawn from glibc
> (12cbde1dae6f "Use clock_settime to implement stime; withdraw stime.")
>
> Implement the target stime() syscall using host
> clock_settime(CLOCK_REALTIME, ...) as it is done internally in glibc.
>
> Tested qemu-ppc/x86_64 with:
>
>         #include <time.h>
>         #include <stdio.h>
>
>         int main(void)
>         {
>                 time_t t;
>                 int ret;
>
>                 /* date -u -d"2019-11-12T15:11:00" "+%s" */
>                 t = 1573571460;
>                 ret = stime(&t);
>                 printf("ret %d\n", ret);
>                 return 0;
>         }
>
>         # date; ./stime; date
>         Tue Nov 12 14:18:32 UTC 2019
>         ret 0
>         Tue Nov 12 15:11:00 UTC 2019
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1852115
> Reported-by: Cole Robinson <crobinso@redhat.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

