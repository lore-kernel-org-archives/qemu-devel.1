Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911F4C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF0A20663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rSNWDg+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF0A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCNi5-0005CY-Fd
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 09:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCNh9-0004Df-Bi
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCNh8-0001mG-5z
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:16:15 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCNh7-0001ji-Uq
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:16:14 -0400
Received: by mail-oi1-x242.google.com with SMTP id d62so5371538oia.11
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 06:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0dnyT0V5hNHVjGHyHBwPkekbDHXrX1zyrjIt9zRZphk=;
 b=rSNWDg+G7SdGpW6ZqxT1YM45aQ3PDQWCdjgNr8IaweyMfeebuL80CHwJrSa+0oeraE
 lksIUgw81oTMbMduPAvYW1DStpO1/YHsiE0+2MbfoFI1Y+QxzPi+yYrUgqKHRGOzOLba
 GmZYK48553W+Vz5iz9AYwfuJCKQOkj5+beg8DdRG76VQ2R6FGsEWqZHj6f7LeTJeXbKS
 AxGBmKpxY7rufSCH9Y2kgnMjaFR2smIi0H8b4z9jO3w+jyCLUfGKVae8k8S+tjfygQwp
 fF0HXWM0DC+z7GXUwfdCowfwypdbQEY3RHg6lOFZWvBeoaIjOU2sXWwO4H+if0rmQ2R+
 5wXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0dnyT0V5hNHVjGHyHBwPkekbDHXrX1zyrjIt9zRZphk=;
 b=fGGmiyZu06rHa6WNopNAdWUk+fexnAQUpCkyt9JwC0qonIySznUyFtcFDa2k4JmTtw
 LEFOls1fTVlIhkVF0rWJZVzN/e8d1of8B3IennGX1vozlCRFoO4wfEJWppgRRfzz2c2P
 AXoBYoRYJ6NM3mGbtlFoBrbyjYRuKwbdb4Y1f5/yfmYZnXRTEpNvA41Ntsqo9iUSH1yT
 oiSmA+isbnRQGwVGUnvzHI8J9xbeZMdlufH0lMHqGGsFkDKrRfeIs2aPIAb623I8Lpwh
 Qo9OgRCC7BlWJLF7ffo9n5GC7r54I3uIs+zmLW70AiPKuzM/JuKQ+2O+ov90bBM95oo6
 l5gg==
X-Gm-Message-State: ANhLgQ0N7xmFssRyMbSvDZKVdKl3Hfl0p9J53V56zjNdLdHiB0jE5US4
 VGHZGr6nqikWNB7lB26ir1z1T2wkecpwwbyGovqOiw==
X-Google-Smtp-Source: ADFU+vtbQ/EjBVAKohabCdL6NRPN6gqkAFR14axUaFremYk0wugSg3uNJLWQItRj21t8eyXPYVfTZ3/E1PoJLbjTbro=
X-Received: by 2002:aca:5b07:: with SMTP id p7mr2447363oib.146.1584018972888; 
 Thu, 12 Mar 2020 06:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200310210434.31544-1-linux@roeck-us.net>
 <20200310210434.31544-2-linux@roeck-us.net>
In-Reply-To: <20200310210434.31544-2-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 13:16:01 +0000
Message-ID: <CAFEAcA_B5zjyV0xknaffcGbqELjTUUDEg7OG_wh+21r-Ya29Lg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] hw/usb: Add basic i.MX USB Phy support
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020 at 21:04, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Add basic USB PHY support as implemented in i.MX23, i.MX28, i.MX6,
> and i.MX7 SoCs.
>
> The only support really needed - at least to boot Linux - is support
> for soft reset, which needs to reset various registers to their initial
> value. Otherwise, just record register values.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: New patch, replacing dummy STMP register support with basic USB PHY
>     emulation.
>
>  hw/arm/Kconfig               |   1 +
>  hw/usb/Kconfig               |   5 +
>  hw/usb/Makefile.objs         |   2 +
>  hw/usb/imx-usb-phy.c         | 225 +++++++++++++++++++++++++++++++++++
>  include/hw/usb/imx-usb-phy.h |  53 +++++++++
>  5 files changed, 286 insertions(+)
>  create mode 100644 hw/usb/imx-usb-phy.c
>  create mode 100644 include/hw/usb/imx-usb-phy.h


> +        /*
> +         * All REG_NAME_SET register access are in fact targeting the
> +         * the REG_NAME register.
> +         */

All these comments have a duplicate word: "the the".

You should add the new files to MAINTAINERS:

diff --git a/MAINTAINERS b/MAINTAINERS
index 857f969aa1f..4e42187aafb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -748,6 +748,8 @@ F: hw/arm/sabrelite.c
 F: hw/arm/fsl-imx6.c
 F: hw/misc/imx6_*.c
 F: hw/ssi/imx_spi.c
+F: hw/usb/imx-usb-phy.c
+F: include/hw/usb/imx-usb-phy.h
 F: include/hw/arm/fsl-imx6.h
 F: include/hw/misc/imx6_*.h
 F: include/hw/ssi/imx_spi.h

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

