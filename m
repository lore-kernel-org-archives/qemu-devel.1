Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9ADC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED23220679
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ND9nQBnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED23220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3dPn-0006Yo-61
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 05:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3dP6-00062y-VD
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:13:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3dP5-0000HQ-MT
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:13:28 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3dP5-0000GO-GS
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:13:27 -0500
Received: by mail-oi1-x244.google.com with SMTP id b18so16195743oie.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 02:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ihAHHBJTLcUUzMgnsy+QkVHULWLP2nB4QzyKj5oq1ic=;
 b=ND9nQBntlbDrPqWHt9ML1+mIMBvwJ6GgqBxBTWw1cO//V+u1xOg2F4AYDBIWo6S3DD
 msAJMc1svt2ddFIue2gn0+dEwQvyyHnyS58VAeMGoljyhI8FuefwFGGw/1GAqEKc/AtL
 34IqHFEbpJZjvDKVUEOUDtQbJJ6RM0X+5FEMZvg1hFCkahSDFvgGMeDRhd5zuN39R8J2
 9v3HG+0o5KhWr3V8iyGqPoH17P+5WhX3IiVbWK5nU4lq52Uy4LvM9D4nMR5pgMKKHrKk
 W9GAt/Zb/CqeK4KoLnDFnDoAofBtJO7BEbMH7sDkVX7m2Z1sxaA6c+JdtodFnC4QLtjj
 YCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ihAHHBJTLcUUzMgnsy+QkVHULWLP2nB4QzyKj5oq1ic=;
 b=pLfsbeS8jqZ/hIfiTsyjE+LJib9l1jZibh2pXGWd/hLFQDzXbTX7jasWvLTlETL+Wi
 QLUQNkL9cPHxzzwdFGF3HStf03pn04mCyoHZR771jpir6wz92LlqTctE2LPkrGuPFbh+
 +huJ4g4CAfk8sWck9nS5WS6Z1T9gAAYb5OGE15E/wG+/yTTiCp0PWIlJBvzKIvGMfyl2
 5k3eDPpT/a/OlSsgFm5/MPba6iRQk3PWDojQV6yuamBGXffCPp7pnDa5qUZiWJuPpB3j
 DBhXQF+qVOjQB6pTNvI8BdEWsVOh1jItxYKn2+xe9ffWzs/sTwf9xivdfmh4sVDscT2R
 XiDg==
X-Gm-Message-State: APjAAAUkpWMc5yEvO+oQYv9YBYB+Yw8vIVLteDbW8yRyi7ixXpGC+m87
 a+sDIfHh0/sTxf+0xw+QF2lQqhcioRvD9K/CPlHzNA==
X-Google-Smtp-Source: APXvYqwEYNfavYNVSYtaGRReKOVcrvlM8dR4nJw2PIrPBmEII4oY+UOkcdXe9cI2Xc5tWysSW+rl8c3yjxjebmDy2u4=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr9734447oiy.170.1581934406489; 
 Mon, 17 Feb 2020 02:13:26 -0800 (PST)
MIME-Version: 1.0
References: <20200215001248.2642-1-linux@roeck-us.net>
 <20200215001248.2642-4-linux@roeck-us.net>
In-Reply-To: <20200215001248.2642-4-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 10:13:15 +0000
Message-ID: <CAFEAcA8Su5SfM9f9BpwaEK2yq0NPwjbtUSwQ1n=G1a=8W881JA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm: allwinner: Wire up USB ports
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 15 Feb 2020 at 00:12, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Instantiate EHCI and OHCI controllers on Allwinner A10. OHCI ports are
> modeled as companions of the respective EHCI ports.
>
> With this patch applied, USB controllers are discovered and instantiated
> when booting the cubieboard machine with a recent Linux kernel.
>
> ehci-platform 1c14000.usb: EHCI Host Controller
> ehci-platform 1c14000.usb: new USB bus registered, assigned bus number 1
> ehci-platform 1c14000.usb: irq 26, io mem 0x01c14000
> ehci-platform 1c14000.usb: USB 2.0 started, EHCI 1.00
> ehci-platform 1c1c000.usb: EHCI Host Controller
> ehci-platform 1c1c000.usb: new USB bus registered, assigned bus number 2
> ehci-platform 1c1c000.usb: irq 31, io mem 0x01c1c000
> ehci-platform 1c1c000.usb: USB 2.0 started, EHCI 1.00
> ohci-platform 1c14400.usb: Generic Platform OHCI controller
> ohci-platform 1c14400.usb: new USB bus registered, assigned bus number 3
> ohci-platform 1c14400.usb: irq 27, io mem 0x01c14400
> ohci-platform 1c1c400.usb: Generic Platform OHCI controller
> ohci-platform 1c1c400.usb: new USB bus registered, assigned bus number 4
> ohci-platform 1c1c400.usb: irq 32, io mem 0x01c1c400
> usb 2-1: new high-speed USB device number 2 using ehci-platform
> usb-storage 2-1:1.0: USB Mass Storage device detected
> scsi host1: usb-storage 2-1:1.0
> usb 3-1: new full-speed USB device number 2 using ohci-platform
> input: QEMU QEMU USB Mouse as /devices/platform/soc/1c14400.usb/usb3/3-1/3-1:1.0/0003:0627:0001.0001/input/input0
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Instantiate EHCI and OHCI in a single patch
>     Use define instead of ARRAY_SIZE to get the number of USB ports
>     Instantiate OHCI in companion mode
>     Use &error_fatal to handle error conditions
>
>  hw/arm/allwinner-a10.c         | 43 ++++++++++++++++++++++++++++++++++
>  include/hw/arm/allwinner-a10.h |  6 +++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
> index 45cd8d2db5..57275c92f5 100644
> --- a/hw/arm/allwinner-a10.c
> +++ b/hw/arm/allwinner-a10.c
> @@ -24,12 +24,16 @@
>  #include "hw/arm/allwinner-a10.h"
>  #include "hw/misc/unimp.h"
>  #include "sysemu/sysemu.h"
> +#include "hw/boards.h"
> +#include "hw/usb/hcd-ohci.h"
>
>  #define AW_A10_CCM_REG_BASE     0x01c20000
>  #define AW_A10_PIC_REG_BASE     0x01c20400
>  #define AW_A10_PIT_REG_BASE     0x01c20c00
>  #define AW_A10_UART0_REG_BASE   0x01c28000
>  #define AW_A10_EMAC_BASE        0x01c0b000
> +#define AW_A10_EHCI_BASE        0x01c14000
> +#define AW_A10_OHCI_BASE        0x01c14400
>  #define AW_A10_SATA_BASE        0x01c18000

Hi; I tried to apply this patchset, but it doesn't apply to master.
In particular, master doesn't have a #define for AW_A10_CCM_REG_BASE.

Is this patchset supposed to be based on some other patchset
you've already sent that's got lost in my mailbox?

thanks
-- PMM

