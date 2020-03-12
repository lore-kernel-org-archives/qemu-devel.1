Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33218C2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:20:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F371C20663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7nFNDqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F371C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCNlU-0000Vw-27
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 09:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCNki-0008Li-Cy
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCNkh-0007A0-C5
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:19:56 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCNkh-00078h-5q
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:19:55 -0400
Received: by mail-ot1-x344.google.com with SMTP id a49so3372673otc.11
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/cNo1o70PZrIiyrIkcN27XUdEr6GJ9T+R0TNlmRIjyY=;
 b=R7nFNDqvsIJkVAvdwd3B7KLt3rsQNN9iioCIfDokZHPoNYbE3nLOZpZwi/0m5BZiC+
 7Vdm/o164PkWl0k0NzBsd/p5nfGo837fSZH65QCYryddtP3PpKd7864vyldgLYXT394C
 XvgeheVZxLPcwpVyY8h+K5bLC8CbZrrDaU4M45WdzhybeUZ8HlLb6VSoFyOvojIFuelI
 FaiM3mlLpivXusTuqsTkbVc9eYiqz7O3XZJTSK3bQAGIzmikm1tos2jtt6Pmy41s4AFY
 fj3kljpVRo8Oy+HWWH2UCj65/HEYcWugrsn7TEv2wYF2QXx46vZLhfd6QervqezVWTQM
 FCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/cNo1o70PZrIiyrIkcN27XUdEr6GJ9T+R0TNlmRIjyY=;
 b=cRvWop+dZO+agtf8SF9NJBcurWBJaoKnhS9LSeEEj5QIEH/LsUrpfvRwUESMpNwoAm
 F1OFNFTI2p6YJPSrYDVxyXwv7hf8XBOHxMgtzm1YxsIHCj8Q3VH+bjrl+HXTH38brAxQ
 S8WsA3eoIW4SoiQeSAk0k16d6pbQ/fbTYz/V4IJw5OL/s69vwFDfj2nyijKfLN0OX559
 AQKxl178SHC/O3D2BMXyC3tT05I0aRK7B/s6qyOEal4JPizyMwiFBTUXE9UTf17RFNXZ
 D6n3Nz9F58xvXPyltVBJogI7MHwLjZAjIaawPdYqw3wR4SOZFhx9Ux4rUeTLzgCMZYsx
 8u4A==
X-Gm-Message-State: ANhLgQ3TS3lX8ro4gW813yGhdlBUjZBio6P/KUii37f8KDDaUAOtJjOB
 dvOCeyIw7azGb6zWNJQEizIJgInke0q4OQsbUem9NWWM+YPc9A==
X-Google-Smtp-Source: ADFU+vs0Zhruc1yZKWGzBzCvd+2BrnKFCJGbPH8W2AC2YCupAoDD4B0ewjxanAGYxUvbR2uEiOwIWRFKzkTejTXNaPQ=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr6335114otl.135.1584019193088; 
 Thu, 12 Mar 2020 06:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200310210434.31544-1-linux@roeck-us.net>
 <20200310210434.31544-3-linux@roeck-us.net>
In-Reply-To: <20200310210434.31544-3-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 13:19:41 +0000
Message-ID: <CAFEAcA811Zo6JjCait2G467oQo-nL0RTYVdqE-ofmDSxWPcuCQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hw/arm/fsl-imx6ul: Wire up USB controllers
To: Guenter Roeck <linux@roeck-us.net>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020 at 21:04, Guenter Roeck <linux@roeck-us.net> wrote:
>
> IMX6UL USB controllers are quite similar to IMX7 USB controllers.
> Wire them up the same way.
>
> The only real difference is that wiring up phy devices is necessary
> to avoid phy reset timeouts in the Linux kernel.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Use USB PHY emulation
>
>  hw/arm/fsl-imx6ul.c         | 33 +++++++++++++++++++++++++++++++++
>  include/hw/arm/fsl-imx6ul.h |  9 +++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> @@ -456,6 +467,28 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
>                                              FSL_IMX6UL_ENETn_TIMER_IRQ[i]));
>      }
>
> +    /* USB */
> +    for (i = 0; i < FSL_IMX6UL_NUM_USBS; i++) {
> +        static const int FSL_IMX6UL_USBn_IRQ[] = {
> +            FSL_IMX6UL_USB2_IRQ,
> +            FSL_IMX6UL_USB1_IRQ,
> +        };

Do we really want to wire up USB1 to USB2_IRQ and USB2 to USB1_IRQ ?
If so, a comment explaining that it is deliberate would be useful.

Side note: not used here, but in the header file we define:
    FSL_IMX6UL_USB1_IRQ     = 42,
    FSL_IMX6UL_USB2_IRQ     = 43,
    FSL_IMX6UL_USB_PHY1_IRQ = 44,
    FSL_IMX6UL_USB_PHY2_IRQ = 44,

Is that last one correct, or a cut-n-paste error that should be "45" ?

thanks
-- PMM

