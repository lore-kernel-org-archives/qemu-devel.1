Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39486C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E216320767
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObfuH/c3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E216320767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD9JW-0001iD-3I
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 12:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kD9Ic-0000pR-BI
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23906)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kD9Ia-0000uu-4e
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598978299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gdN4tw4siiKoKNCqyz8/rsOg+Ee2rgJ7NWhJpf4NjSI=;
 b=ObfuH/c3yPEjDRDoyaFf1zn+sWC0R27dL/IlYQl+k5OzTjrP8qazhNzWYn+8MuJ3B+slpv
 wiO9d8jjd2ftUkvf52QZow8A0tv9aBKVy2E5KhSvXWlsINKX4Neb4QloIsxKBgq/H450BH
 m9J5437krVLgoc2eFeVy1Kz8gNzMUvc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-chHONNEeMpS6pAzbkIZ_eA-1; Tue, 01 Sep 2020 12:38:16 -0400
X-MC-Unique: chHONNEeMpS6pAzbkIZ_eA-1
Received: by mail-wr1-f72.google.com with SMTP id 3so805736wrm.4
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 09:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=gdN4tw4siiKoKNCqyz8/rsOg+Ee2rgJ7NWhJpf4NjSI=;
 b=QzYHOFa3+mHZEnyNFjzMg2/FNZXTK3F2mTnkJfnCvWVQHQxTwiEePx7OC0/nVWS0As
 QzOmg3oKOG9s3Q9uEXcbPv8nI3auSXA2QpJgRjSUX04Vxgd2eIllj6mxaBYiiunnPQ8d
 Ygq1GDYjgIicTWsexI/my48WWVlckH9xVoMJ1ceRsMTc0e2phMRBxlR22EIrHllhpiBK
 zhVUxpEmIUa9Q9ymOYcExn1eVq9WpcnlkGw401/y7DUK8rOS8SzWizNC0P/PG+Ncdtid
 5Hz98mqPIMeT0nptxdzXHO4WfOMX8SmBOZJzkgfp1Au6898xfBh7sWcIm7ySju5QM0MC
 monQ==
X-Gm-Message-State: AOAM532c4mdvkYl9AokkBt3s6FPzXWymgUP5sJn/HcSh1WOK2DS3LzfN
 MauRZNb3kS/q/i4hcv5LsGzNb5ORfAyz8ogG3YjHSzh4fet03iLNtmqypP/d8TvzYhamV3bcpHj
 e9+6CFdNZ7kqnhos=
X-Received: by 2002:adf:edd0:: with SMTP id v16mr2989183wro.271.1598978295680; 
 Tue, 01 Sep 2020 09:38:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEJCbDylpYLLmWIvV0zEoCYY8WxgmziMH4F6VUbHNHqgeDPHtd1MZ89G1n3TYU0cj4N+j0tA==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr2989152wro.271.1598978295415; 
 Tue, 01 Sep 2020 09:38:15 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id a11sm3358824wrq.0.2020.09.01.09.38.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 09:38:14 -0700 (PDT)
Subject: Re: [PATCH v4 2/7] usb/hcd-xhci: Move qemu-xhci device to
 hcd-xhci-pci.c
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?=27Marc-Andr=c3=a9_Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Francisco Iglesias <francisco.iglesias@xilinx.com>
References: <1598642380-27817-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1598642380-27817-3-git-send-email-sai.pavan.boddu@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <922d52c0-e250-404d-48ca-5af614b012e4@redhat.com>
Date: Tue, 1 Sep 2020 18:38:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598642380-27817-3-git-send-email-sai.pavan.boddu@xilinx.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 qemu-devel@nongnu.org, Paul Zimmerman <pauldzim@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Ying Fang <fangying1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/28/20 9:19 PM, Sai Pavan Boddu wrote:
> Move pci specific devices to new file. This set the environment to move all
> pci specific hooks in hcd-xhci.c to hcd-xhci-pci.c.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/usb/Kconfig        |  6 +++++
>  hw/usb/Makefile.objs  |  1 +
>  hw/usb/hcd-xhci-pci.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/usb/hcd-xhci.c     | 41 ++------------------------------
>  hw/usb/hcd-xhci.h     |  3 +++
>  5 files changed, 78 insertions(+), 39 deletions(-)
>  create mode 100644 hw/usb/hcd-xhci-pci.c
> 
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index d4d8c37..d9965c1 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -36,6 +36,12 @@ config USB_XHCI
>      depends on PCI
>      select USB
>  
> +config USB_XHCI_PCI
> +    bool
> +    default y if PCI_DEVICES
> +    depends on PCI
> +    select USB_XHCI
> +
>  config USB_XHCI_NEC
>      bool
>      default y if PCI_DEVICES
> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> index e342ff5..029b040 100644
> --- a/hw/usb/Makefile.objs
> +++ b/hw/usb/Makefile.objs
> @@ -11,6 +11,7 @@ common-obj-$(CONFIG_USB_EHCI_PCI) += hcd-ehci-pci.o
>  common-obj-$(CONFIG_USB_EHCI_SYSBUS) += hcd-ehci-sysbus.o
>  common-obj-$(CONFIG_USB_XHCI) += hcd-xhci.o
>  common-obj-$(CONFIG_USB_XHCI_NEC) += hcd-xhci-nec.o
> +common-obj-$(CONFIG_USB_XHCI_PCI) += hcd-xhci-pci.o
>  common-obj-$(CONFIG_USB_MUSB) += hcd-musb.o
>  common-obj-$(CONFIG_USB_DWC2) += hcd-dwc2.o
>  
> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> new file mode 100644
> index 0000000..1562757
> --- /dev/null
> +++ b/hw/usb/hcd-xhci-pci.c
> @@ -0,0 +1,66 @@
> +/*
> + * USB xHCI controller with PCI bus emulation
> + *
> + * SPDX-FileCopyrightText: 2011 Securiforest
> + * SPDX-FileContributor: Hector Martin <hector@marcansoft.com>
> + * SPDX-sourceInfo: Based on usb-ohci.c, emulates Renesas NEC USB 3.0
> + * SPDX-FileCopyrightText: 2020 Xilinx
> + * SPDX-FileContributor: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> + * SPDX-sourceInfo: Moved the pci specific content for hcd-xhci.c to
> + *                  hcd-xhci-pci.c
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#include "qemu/osdep.h"
> +#include "hw/pci/pci.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/pci/msi.h"
> +#include "hw/pci/msix.h"
> +#include "hcd-xhci.h"
> +#include "trace.h"
> +#include "qapi/error.h"
> +
> +static void qemu_xhci_class_init(ObjectClass *klass, void *data)
> +{
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +
> +    k->vendor_id    = PCI_VENDOR_ID_REDHAT;
> +    k->device_id    = PCI_DEVICE_ID_REDHAT_XHCI;
> +    k->revision     = 0x01;
> +}
> +
> +static void qemu_xhci_instance_init(Object *obj)
> +{
> +    XHCIState *xhci = XHCI(obj);
> +
> +    xhci->msi      = ON_OFF_AUTO_OFF;
> +    xhci->msix     = ON_OFF_AUTO_AUTO;
> +    xhci->numintrs = MAXINTRS;
> +    xhci->numslots = MAXSLOTS;
> +    xhci_set_flag(xhci, XHCI_FLAG_SS_FIRST);
> +}
> +
> +static const TypeInfo qemu_xhci_info = {
> +    .name          = TYPE_QEMU_XHCI,
> +    .parent        = TYPE_XHCI,
> +    .class_init    = qemu_xhci_class_init,
> +    .instance_init = qemu_xhci_instance_init,
> +};
> +
> +static void xhci_register_types(void)
> +{
> +    type_register_static(&qemu_xhci_info);
> +}
> +
> +type_init(xhci_register_types)
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 2590f7a..b15c53b 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -23,7 +23,6 @@
>  #include "qemu/timer.h"
>  #include "qemu/module.h"
>  #include "qemu/queue.h"
> -#include "hw/usb.h"
>  #include "migration/vmstate.h"
>  #include "hw/pci/pci.h"
>  #include "hw/qdev-properties.h"
> @@ -429,12 +428,12 @@ static const char *ep_state_name(uint32_t state)
>                         ARRAY_SIZE(ep_state_names));
>  }
>  
> -static bool xhci_get_flag(XHCIState *xhci, enum xhci_flags bit)
> +bool xhci_get_flag(XHCIState *xhci, enum xhci_flags bit)
>  {
>      return xhci->flags & (1 << bit);
>  }
>  
> -static void xhci_set_flag(XHCIState *xhci, enum xhci_flags bit)
> +void xhci_set_flag(XHCIState *xhci, enum xhci_flags bit)
>  {
>      xhci->flags |= (1 << bit);
>  }
> @@ -3692,13 +3691,6 @@ static Property xhci_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> -static void xhci_instance_init(Object *obj)
> -{
> -    /* QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
> -     * line, therefore, no need to wait to realize like other devices */
> -    PCI_DEVICE(obj)->cap_present |= QEMU_PCI_CAP_EXPRESS;

What happened to this flag?

> -}
> -
>  static void xhci_class_init(ObjectClass *klass, void *data)
>  {
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> @@ -3718,7 +3710,6 @@ static const TypeInfo xhci_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(XHCIState),
>      .class_init    = xhci_class_init,
> -    .instance_init = xhci_instance_init,
>      .abstract      = true,
>      .interfaces = (InterfaceInfo[]) {
>          { INTERFACE_PCIE_DEVICE },
> @@ -3727,37 +3718,9 @@ static const TypeInfo xhci_info = {
>      },
>  };
>  
> -static void qemu_xhci_class_init(ObjectClass *klass, void *data)
> -{
> -    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> -
> -    k->vendor_id    = PCI_VENDOR_ID_REDHAT;
> -    k->device_id    = PCI_DEVICE_ID_REDHAT_XHCI;
> -    k->revision     = 0x01;
> -}
> -
> -static void qemu_xhci_instance_init(Object *obj)
> -{
> -    XHCIState *xhci = XHCI(obj);
> -
> -    xhci->msi      = ON_OFF_AUTO_OFF;
> -    xhci->msix     = ON_OFF_AUTO_AUTO;
> -    xhci->numintrs = MAXINTRS;
> -    xhci->numslots = MAXSLOTS;
> -    xhci_set_flag(xhci, XHCI_FLAG_SS_FIRST);
> -}
> -
> -static const TypeInfo qemu_xhci_info = {
> -    .name          = TYPE_QEMU_XHCI,
> -    .parent        = TYPE_XHCI,
> -    .class_init    = qemu_xhci_class_init,
> -    .instance_init = qemu_xhci_instance_init,
> -};
> -
>  static void xhci_register_types(void)
>  {
>      type_register_static(&xhci_info);
> -    type_register_static(&qemu_xhci_info);
>  }
>  
>  type_init(xhci_register_types)
> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> index edbd926..dd5fcd4 100644
> --- a/hw/usb/hcd-xhci.h
> +++ b/hw/usb/hcd-xhci.h
> @@ -23,6 +23,7 @@
>  #define HW_USB_HCD_XHCI_H
>  
>  #include "sysemu/dma.h"
> +#include "hw/usb.h"
>  
>  #define TYPE_XHCI "base-xhci"
>  #define TYPE_NEC_XHCI "nec-usb-xhci"
> @@ -232,4 +233,6 @@ struct XHCIState {
>      bool nec_quirks;
>  };
>  
> +bool xhci_get_flag(XHCIState *xhci, enum xhci_flags bit);
> +void xhci_set_flag(XHCIState *xhci, enum xhci_flags bit);
>  #endif
> 


