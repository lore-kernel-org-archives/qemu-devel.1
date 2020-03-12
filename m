Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8ECC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 325E12067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxj8Px8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325E12067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRTo-0006Ou-6C
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jCR7C-0001VD-7I
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jCR79-0003EP-2m
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:55:22 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jCR76-0003B8-HV; Thu, 12 Mar 2020 12:55:16 -0400
Received: by mail-pf1-x444.google.com with SMTP id w65so3541526pfb.6;
 Thu, 12 Mar 2020 09:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=GXGrQMuSPuWRxxUAmh9Tg77oMP4Uo6B+0hy9wrgNx8o=;
 b=Qxj8Px8ldKKrd8gIZdiXJTZR3wr+I1t7cPG0CJiNHfZn71OLzGjtQMWc3ZuXjQroGw
 32X1uTWgvUBZPux2FEAeVpvnOAiNFzCOTV9GcPv7TTL8qv9szsGvBvHSKqTM/F0/76VY
 v3vxTaU7iS7yY/2t41i0BcUC58x2E3DmetoFQXrdC3i3PBZ3KsJmwUGxETq0fIJJ25Yh
 UO1yGi+jnnRvBH494b97XRdCfyPYhnE8J3zVEN/joinGIeg07YTQWXPsTZqxZhKSFIZv
 PUkdgudeNLWXiBLojaot5sS3NV72DoQ4eqbgyQq5oOW4zxNuMRh+wldy6pNAvXgkxhM/
 qlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=GXGrQMuSPuWRxxUAmh9Tg77oMP4Uo6B+0hy9wrgNx8o=;
 b=uScsFmqoyiT16rk6oCUuiBAYy1gT8FCN6/AbeuPms0w+U0f5AoNG52dScgr0DMWPAk
 h1tNaPKgkVVsms+WlcZ3NgZaJYSym+68uYpmVNE/K7z5N1fIvBm8mEDTbWHOpfnU5q2J
 dXP/+RPAh90lskPC4GqoIOVD5uW6HgIRa0GC9vMnXpRHp/OBlvn394Ge6++vyVJ2bN9h
 jwXVVe4BFs839ZpUbl9eibEc7OhqwZML1HQBke93ZbaJl43HCwUWAQ7OQ5OfxaujmSOe
 pGDrFmF84pmM1zT7om63f2MTjXfaWUsefLGjQDhFi/7CyvP3DoJfjghSFqdwj5uVLSFj
 JY3g==
X-Gm-Message-State: ANhLgQ1hsomiy/J02IA7PzBOH9uAAACxjDRgj4q7VGriHDrpICETMlop
 ajsMwM6qkrJ3/ojnJz5YqIc=
X-Google-Smtp-Source: ADFU+vvQ9KIXBI3OyZhmK+afPl8u6/1uhELsLmb6yLS2HuWUVSwcegRCYjtP9UXye800LbkRLKTmIQ==
X-Received: by 2002:a63:df15:: with SMTP id u21mr8008518pgg.95.1584032114160; 
 Thu, 12 Mar 2020 09:55:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id e20sm2677449pfi.171.2020.03.12.09.55.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 12 Mar 2020 09:55:13 -0700 (PDT)
Date: Thu, 12 Mar 2020 09:55:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 2/3] hw/arm/fsl-imx6ul: Wire up USB controllers
Message-ID: <20200312165511.GA16719@roeck-us.net>
References: <20200310210434.31544-1-linux@roeck-us.net>
 <20200310210434.31544-3-linux@roeck-us.net>
 <CAFEAcA811Zo6JjCait2G467oQo-nL0RTYVdqE-ofmDSxWPcuCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA811Zo6JjCait2G467oQo-nL0RTYVdqE-ofmDSxWPcuCQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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

On Thu, Mar 12, 2020 at 01:19:41PM +0000, Peter Maydell wrote:
> On Tue, 10 Mar 2020 at 21:04, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > IMX6UL USB controllers are quite similar to IMX7 USB controllers.
> > Wire them up the same way.
> >
> > The only real difference is that wiring up phy devices is necessary
> > to avoid phy reset timeouts in the Linux kernel.
> >
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v2: Use USB PHY emulation
> >
> >  hw/arm/fsl-imx6ul.c         | 33 +++++++++++++++++++++++++++++++++
> >  include/hw/arm/fsl-imx6ul.h |  9 +++++++++
> >  2 files changed, 42 insertions(+)
> >
> > diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> > @@ -456,6 +467,28 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
> >                                              FSL_IMX6UL_ENETn_TIMER_IRQ[i]));
> >      }
> >
> > +    /* USB */
> > +    for (i = 0; i < FSL_IMX6UL_NUM_USBS; i++) {
> > +        static const int FSL_IMX6UL_USBn_IRQ[] = {
> > +            FSL_IMX6UL_USB2_IRQ,
> > +            FSL_IMX6UL_USB1_IRQ,
> > +        };
> 
> Do we really want to wire up USB1 to USB2_IRQ and USB2 to USB1_IRQ ?
> If so, a comment explaining that it is deliberate would be useful.
> 
Yes. I think the definitions may be incorrect (or the Linux dts files are
incorrect, but that seems unlikely). I tried the other way but then I get
unhandled interrupt errors when trying to access a USB flash drive.

> Side note: not used here, but in the header file we define:
>     FSL_IMX6UL_USB1_IRQ     = 42,
>     FSL_IMX6UL_USB2_IRQ     = 43,
>     FSL_IMX6UL_USB_PHY1_IRQ = 44,
>     FSL_IMX6UL_USB_PHY2_IRQ = 44,
> 
> Is that last one correct, or a cut-n-paste error that should be "45" ?
> 
From Linux devicetree files:

	usbphy1: usbphy@20c9000 {
        	compatible = "fsl,imx6ul-usbphy", "fsl,imx23-usbphy";
                reg = <0x020c9000 0x1000>;
                interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
	usbphy2: usbphy@20ca000 {
                compatible = "fsl,imx6ul-usbphy", "fsl,imx23-usbphy";
                reg = <0x020ca000 0x1000>;
                interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
	usbotg1: usb@2184000 {
                compatible = "fsl,imx6ul-usb", "fsl,imx27-usb";
                reg = <0x02184000 0x200>;
                interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
	usbotg2: usb@2184200 {
                compatible = "fsl,imx6ul-usb", "fsl,imx27-usb";
                reg = <0x02184200 0x200>;
                interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;

Should I maybe fix the definitions in a separate patch ?

Thanks,
Guenter

