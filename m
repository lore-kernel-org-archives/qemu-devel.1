Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96470C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D5672067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZUQiKxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5672067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRVu-00022O-Jq
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCRH9-00050T-LZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCRH8-0005m3-EQ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:05:39 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33690)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCRH8-0005j6-8f
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:05:38 -0400
Received: by mail-oi1-x244.google.com with SMTP id r7so6241002oij.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xxylgvPZt6pkmnnFax2EPHHdp0hc8wVzhGL5wzMXqGY=;
 b=hZUQiKxD2gS4ydpHQe0PsuGgSYjvbEUL9z5cax7ZJz3CmMOsIUewoZCJB+lFJvk7qJ
 wEO5S/jbW9EgiUUOkofa8jLuJ2B3CN/MW6+agUW9IG2m2nxKD+jijKFnQCtNCA7Nvu9n
 dpwjxuHohl6hcpF31SZITg90RSCOb/Bs0grXDTdAIVBbI7QIMbccTU23fNxBCVMwbajl
 1LX0AC6C23F5t/iw1Cd90t0Jm0Dmxon25XMikfJcqTgx5ROFzgbuFB619fQsbZNlBRJy
 lmuav3OLkbTPSpTShGGtl/T0SGmdvOpNqsXfI9dOm/nX39ICj71UKKRapAZqM15HIabg
 aWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xxylgvPZt6pkmnnFax2EPHHdp0hc8wVzhGL5wzMXqGY=;
 b=fPZaxKM7aXpDiCUa5zeCt7pOk1Aqj1tcxIZppUNp6wVf8AsIkXqKf72Y6eBJtXuA4V
 q6JfkKf3hfwuxr5NcihoL+wMAIUQJMCK5bwEDOKlVZq7R1weM72Qo8EHVQRhxZIRvjep
 rN5hopwVD375xucfw5YCfYCJ1pb6/DCkxt+NKbWfKwO/P9Metv7OOZ5xLfRiwb7zZrF1
 TgqK2l8yEwcBpIWm8OEuOKt+4imhS+5PgEPBe9gHsCIl5ld9upNtfBlu26OHHIS5gy2F
 kQFgRgnXaLy33cljxWhECUm25olEuzkTGdphe4Gzp1FY0wISdBZAdiEzYOUsaKh0n/Kb
 jZ8A==
X-Gm-Message-State: ANhLgQ1KtqHFdbFsYf/53X49zU1hE/AFz54cPnrK8m6DsPw2YrcxoX55
 +zGst5dLvloGixoDMHOCjOgd3447YgaIa/wZrKjgVA==
X-Google-Smtp-Source: ADFU+vvZgG2S0wQEA/BSyvbNInKSWeyV8Ro4u7D4U2qPegfWXOEgP/rJb9VCtM7gefNYVoK4mZoo3XHJ7yFFTa5Kafs=
X-Received: by 2002:aca:47c8:: with SMTP id u191mr3523548oia.170.1584032737245; 
 Thu, 12 Mar 2020 10:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200310210434.31544-1-linux@roeck-us.net>
 <20200310210434.31544-3-linux@roeck-us.net>
 <CAFEAcA811Zo6JjCait2G467oQo-nL0RTYVdqE-ofmDSxWPcuCQ@mail.gmail.com>
 <20200312165511.GA16719@roeck-us.net>
In-Reply-To: <20200312165511.GA16719@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 17:05:25 +0000
Message-ID: <CAFEAcA8QKwrVyBz-iGe0+1Kr7efJZC7nwwrTTV0FSUnmcEW=xA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hw/arm/fsl-imx6ul: Wire up USB controllers
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Mar 2020 at 16:55, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Mar 12, 2020 at 01:19:41PM +0000, Peter Maydell wrote:
> > On Tue, 10 Mar 2020 at 21:04, Guenter Roeck <linux@roeck-us.net> wrote:
> > > diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> > > @@ -456,6 +467,28 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
> > >                                              FSL_IMX6UL_ENETn_TIMER_IRQ[i]));
> > >      }
> > >
> > > +    /* USB */
> > > +    for (i = 0; i < FSL_IMX6UL_NUM_USBS; i++) {
> > > +        static const int FSL_IMX6UL_USBn_IRQ[] = {
> > > +            FSL_IMX6UL_USB2_IRQ,
> > > +            FSL_IMX6UL_USB1_IRQ,
> > > +        };
> >
> > Do we really want to wire up USB1 to USB2_IRQ and USB2 to USB1_IRQ ?
> > If so, a comment explaining that it is deliberate would be useful.
> >
> Yes. I think the definitions may be incorrect (or the Linux dts files are
> incorrect, but that seems unlikely). I tried the other way but then I get
> unhandled interrupt errors when trying to access a USB flash drive.

I guess we should check the datasheet and see if we just
have our #define names the wrong way around...

> > Side note: not used here, but in the header file we define:
> >     FSL_IMX6UL_USB1_IRQ     = 42,
> >     FSL_IMX6UL_USB2_IRQ     = 43,
> >     FSL_IMX6UL_USB_PHY1_IRQ = 44,
> >     FSL_IMX6UL_USB_PHY2_IRQ = 44,
> >
> > Is that last one correct, or a cut-n-paste error that should be "45" ?
> >
> From Linux devicetree files:
>
>         usbphy1: usbphy@20c9000 {
>                 compatible = "fsl,imx6ul-usbphy", "fsl,imx23-usbphy";
>                 reg = <0x020c9000 0x1000>;
>                 interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
>         usbphy2: usbphy@20ca000 {
>                 compatible = "fsl,imx6ul-usbphy", "fsl,imx23-usbphy";
>                 reg = <0x020ca000 0x1000>;
>                 interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
>         usbotg1: usb@2184000 {
>                 compatible = "fsl,imx6ul-usb", "fsl,imx27-usb";
>                 reg = <0x02184000 0x200>;
>                 interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>         usbotg2: usb@2184200 {
>                 compatible = "fsl,imx6ul-usb", "fsl,imx27-usb";
>                 reg = <0x02184200 0x200>;
>                 interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
>
> Should I maybe fix the definitions in a separate patch ?

Yes please.

thanks
-- PMM

