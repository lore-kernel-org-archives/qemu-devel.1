Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736C6CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 12:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE372075A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 12:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9j9NFdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE372075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMthf-0005Qo-Ed
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 08:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMtgM-0004S4-EL
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMtgK-0004UQ-Cy
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:54:38 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34435)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMtgK-0004TA-2G
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:54:36 -0400
Received: by mail-oi1-x244.google.com with SMTP id 83so14078051oii.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sn/GDBXUuAdmTWjZEO1yUcczL0rcJnI01GKFkqvT3kA=;
 b=F9j9NFdMTfga1WfjjIQ9l7UY0KIs6kkjd4w8ksZfzCibRHTGmFxgO1Php3h4YGUjio
 JGgEkccAtPDyMcUIAu5Zombu5jc7RqNbZ/InvZLVXTGZg2hzpjpZoKDx3ljXls7RvzRX
 BDrsr/2owmui3P5dX/o0sX3PbHTxWj0g4fg97G/hiVcHxq+UWArgLFE+Xis+g4M8GwCg
 Okm+WKG9aoIwe+GW2Mi9X886pnXPb9SrO4AwXDbAg9SNqaNGr6e6IyeDswHrB6ADXLAB
 UQu2ORJpX5G5V0HNA2VF+GWqFuwKSoFdgzelFIcSF0jjs9hKq9F45HY/8kKZzHPK4g4e
 ct3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sn/GDBXUuAdmTWjZEO1yUcczL0rcJnI01GKFkqvT3kA=;
 b=Lpt7Eyliv89MHBz3T7s7ZpOq+MOjy+vh2p53B1eRxfd3oD/HLe0bSPsicW/sm/EPWn
 MOyIFRxPfWV9Szr4iVvItgpHGWF7fk3TJ/peWb8onANjH4JVSCyGvUYSMnlrrmkb+Y4G
 0XZrQ7iYOJRWDK3ByfJc1aEGqj56aYt/HNqA3q+Cc14uedgl1/xaJefIsSYeN721CyTA
 8Gq6JpRZ/FBmJhgCiPxi8drdTpNr6vUkquIhuzTUYa3aTKcEpUcv1KwUEE7Txkk9YF9b
 G5fVelc9MZ8KvvX060EZG2U9kb0YMF9iTjgrFe5+rUtSsxuJuD3DffbcpOMB24YITe9N
 fRww==
X-Gm-Message-State: APjAAAVjtyujAOS4oHLJcOXb8S1fetWTEcA6nbRh2A97PIxeev8GmP+G
 Xv8GRj7kCkDymiyi0/WM0VIphmuGiMV4s1Y9iN0QUw==
X-Google-Smtp-Source: APXvYqwLl/JJfu9S403bPQ8mQg0rLuy6dzKPTUvt7MVxn8O95fLTvDxXtiD2LT2IxzZwlgr+oNBlUqlTg4IaCMH/7UY=
X-Received: by 2002:aca:3b41:: with SMTP id i62mr2645558oia.48.1571748874272; 
 Tue, 22 Oct 2019 05:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191005154748.21718-1-f4bug@amsat.org>
 <6ac9df42-a928-0d45-4aa5-3155a1a3ceaa@redhat.com>
In-Reply-To: <6ac9df42-a928-0d45-4aa5-3155a1a3ceaa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 13:54:23 +0100
Message-ID: <CAFEAcA9xSLbZ_gzA2r+dVVbFyA06iJJ9EUR=z53BRrORKRO40Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] hw/arm/exynos4210: Add acceptance tests to the
 SMDKC210 board
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXNzZQ==?= <contact@fredericb.info>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Evgeny Voevodin <e.voevodin@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Dmitry Solodkiy <d.solodkiy@samsung.com>, Cleber Rosa <crosa@redhat.com>,
 Maksim Kozlov <m.kozlov@samsung.com>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 15:48, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Peter,
>
> On 10/5/19 5:47 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Philippe Mathieu-Daud=C3=A9 (5):
> >    tests/boot_linux_console: Add initrd test for the Exynos4210
> >    hw/sd/sdhci: Add a comment to distinct the i.MX eSDHC functions
> >    hw/sd/sdhci: Add dummy Samsung SDHCI controller
> >    hw/arm/exynos4210: Use the Samsung s3c SDHCI controller
> >    tests/boot_linux_console: Add sdcard test for the Exynos4210
>
> Can you take patches 2-4 from this series? (C part, not Python).
> All these patches have been reviewed.

Sure, I've done that. I assume we'll get the test in via
some other path.

thanks
-- PMM

