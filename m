Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DD0C2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F2521927
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q6HjpqOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F2521927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP6ih-0001ch-KN
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 11:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jP6i0-0001CN-Jm
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jP6hy-0007Mn-Ns
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:45:44 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46865)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jP6hy-0007MN-GJ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:45:42 -0400
Received: by mail-ot1-x344.google.com with SMTP id w12so3384957otm.13
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 08:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FHUymdv8GaiEH1J1AepKkhGwX2tfXevb/xyrCZRKrro=;
 b=Q6HjpqOLe9r/VEf6/mAiNaIx54QcVfazi4GwH5j/OZ/xnJfjrkW0DqIit6KG4EXHq7
 QAvzGkLeEhRLG8qNlSA9f4YKt2rIMEj+5daXX+7GxsINQfdwmYs6iehrXcg2vrtqTbms
 yRK4zdmG9/5SRp7x/Ef0xFfmt7DTKYrsFU8xlfR9LaEOW0VI96vLrunZtLl7C2EFbJq7
 k/ShDLfsx746QCx170hN6PjCv7Yms9KdNsNnDFSrd+EWJbtD6JyAIBick3bbnkdD3eFP
 wZe0ukuFI5TXEHhqkH5NAdiyyB1yu1mhiqSU8N+oGb4CXzIkFPcCzRUD1sxjiImSR65N
 a/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FHUymdv8GaiEH1J1AepKkhGwX2tfXevb/xyrCZRKrro=;
 b=PM1puUq9UGCFF9jMeh31EwrxSMuLnLitOkRbuGJy4x/7zD3v2FxLVcmXnumACY4HhN
 g5xVciDSi74ATzeJJNEjV1h8gO3TMPOSBxMWIeoWXElXDtmsMt5WxnBFkU4Gchtx6rt5
 +yuRq+YAGI9lmYF6eKvbjy2+c37tVUxbhVNQz6h8vcXev3ff8zE34b1454tfheNk8xHy
 YeLv1dds62kSGzgtDnAr5Le3F93VNNEdVaTkLVBMOh4FI5V6BR5BXxMXlTuXXwgQW57+
 jO3z6Ie8Igx5+H9M2YmpBX+bHZmShwIetr3HyQtEq2MAt5AN/bQeGbvDn0zKFxgtxv3Q
 dVkg==
X-Gm-Message-State: AGi0PuaScH6A+VIai9c8AmULJsYJnGFEVtkpqOhfT8vVgpupcgaNwjtQ
 WnqM81eZKjBNVA0F5voQmLGPK5tyyVOVTdSVtSShvQ==
X-Google-Smtp-Source: APiQypJPGTyeCtLQhH/BQr1wJlnaziqSJEm+iIca0hQnNGB0AkYzcaDIy4J+XYiucNeGVivIzLn+ivLKJgmhMyD7eso=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr5725461otc.221.1587051941022; 
 Thu, 16 Apr 2020 08:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200329001705.15966-1-pauldzim@gmail.com>
 <20200329001705.15966-5-pauldzim@gmail.com>
In-Reply-To: <20200329001705.15966-5-pauldzim@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 16:45:29 +0100
Message-ID: <CAFEAcA9bL=uZ3-F4bYbHW+V9REnS1OnSusGKB2UoHS0bjSbvzA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] dwc-hsotg USB host controller emulation
To: Paul Zimmerman <pauldzim@gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 29 Mar 2020 at 00:18, Paul Zimmerman <pauldzim@gmail.com> wrote:
>
> Add the dwc-hsotg (dwc2) USB host controller emulation code.
> Based on hw/usb/hcd-ehci.c and hw/usb/hcd-ohci.c.
>
> Note that to use this with the dwc-otg driver in the Raspbian
> kernel, you must pass the option "dwc_otg.fiq_fsm_enable=0" on
> the kernel command line.
>
> Emulation of slave mode and of descriptor-DMA mode has not been
> implemented yet. These modes are seldom used.
>
> I have used some on-line sources of information while developing
> this emulation, including:
>
> http://www.capital-micro.com/PDF/CME-M7_Family_User_Guide_EN.pdf
> has a pretty complete description of the controller starting on
> page 370.
>
> https://sourceforge.net/p/wive-ng/wive-ng-mt/ci/master/tree/docs/DataSheets/RT3050_5x_V2.0_081408_0902.pdf
> has a description of the controller registers starting on page
> 130.

Ooh, these reference URLs are very helpful. Could you put
them in a comment at the top of the C file as well as in the
commit message, please?

> Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
> ---
>  hw/usb/hcd-dwc2.c   | 1301 +++++++++++++++++++++++++++++++++++++++++++
>  hw/usb/trace-events |   47 ++
>  2 files changed, 1348 insertions(+)
>  create mode 100644 hw/usb/hcd-dwc2.c
>
> diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
> new file mode 100644
> index 0000000000..fd85543f4d
> --- /dev/null
> +++ b/hw/usb/hcd-dwc2.c
> @@ -0,0 +1,1301 @@
> +/*
> + * dwc-hsotg (dwc2) USB host controller emulation
> + *
> + * Based on hw/usb/hcd-ehci.c and hw/usb/hcd-ohci.c
> + *
> + * Copyright (c) 2020 Paul Zimmerman <pauldzim@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/usb/dwc2-regs.h"
> +#include "hw/usb/hcd-dwc2.h"
> +#include "trace.h"
> +#include "qemu/error-report.h"
> +#include "qemu/main-loop.h"
> +
> +#define USB_HZ_FS       12000000
> +#define USB_HZ_HS       96000000
> +
> +/* nifty macros from Arnon's EHCI version  */
> +#define get_field(data, field) \
> +    (((data) & field##_MASK) >> field##_SHIFT)
> +
> +#define set_field(data, newval, field) do { \
> +    uint32_t val = *data; \
> +    val &= ~field##_MASK; \
> +    val |= ((newval) << field##_SHIFT) & field##_MASK; \
> +    *data = val; \
> +} while (0)
> +
> +#define get_bit(data, bitmask) \
> +    (!!((data) & bitmask))

Could you use the standard field definition, extract, and deposit
macros from include/hw/registerfields.h, please?

> +static void dwc2_sysbus_realize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *d = SYS_BUS_DEVICE(dev);
> +    DWC2State *s = DWC2_USB(dev);
> +
> +    s->glbregbase = 0;
> +    s->fszregbase = 0x0100;
> +    s->hreg0base = 0x0400;
> +    s->hreg1base = 0x0500;
> +    s->pcgregbase = 0x0e00;
> +    s->hreg2base = 0x1000;
> +    s->portnr = NB_PORTS;
> +    s->as = &address_space_memory;

Ideally this should be a device property. (hw/dma/pl080.c
has an example of how to declare a TYPE_MEMORY_REGION
property and then create an AddressSpace from it in
the realize method. hw/arm/versatilepb.c and hw/arm/mps2-tz.c
show the other end, using object_property_set_link() to pass
the appropriate MemoryRegion to the device before realizing it.)

> +
> +    dwc2_realize(s, dev, errp);

Why have you divided the realize function up into
dwc2_sysbus_realize() and dwc2_realize() and
dwc2_init()? The usual expectation would be that
there is (if you need it) an instance_init called
dwc2_init() and a realize called dwc2_realize(),
so using these names for functions that are just
called from the realize method is a bit confusing.
    object_property_set_link(OBJECT(dev), OBJECT(sysmem), "downstream",
                             &error_fatal);

> +    dwc2_init(s, dev);
> +    sysbus_init_irq(d, &s->irq);
> +    sysbus_init_mmio(d, &s->mem);
> +}
> +
> +static void dwc2_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = dwc2_sysbus_realize;
> +    dc->reset = dwc2_sysbus_reset;
> +    set_bit(DEVICE_CATEGORY_USB, dc->categories);

Could you provide a VMStateDescription for dc->vmsd, please?

> +}
> +
> +static const TypeInfo dwc2_usb_type_info = {
> +    .name          = TYPE_DWC2_USB,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(DWC2State),
> +    .class_init    = dwc2_class_init,
> +};
> +
> +static void dwc2_usb_register_types(void)
> +{
> +    type_register_static(&dwc2_usb_type_info);
> +}

thanks
-- PMM

