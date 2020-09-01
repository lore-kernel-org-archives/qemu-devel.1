Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE34BC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF952067C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dh/cs4U0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF952067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD9NW-0004xY-Az
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 12:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kD9Mx-0004U7-SJ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:42:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32951
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kD9Mv-0001eL-DW
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598978568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ENSWa8m+oZtit3Et3GaGi2ZXoyZ7hqMeu2oFSZm/mZ4=;
 b=Dh/cs4U0zetuj1YjWsXrkIydEO5JZOWB8fhjQR+UwfhoBvDb84gGF+j0Ol00Wwpv6xGG2H
 bIO+QGHfpC7ay/R6dmBUM7EgGX4PYtR1gHq3mZMzkTIFnafX9yaoSwUsXZQMFqUfiEGCAS
 B+ZGdeqSH7TW8yJm2QxbC//8bdY70ZU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-K4vcFQznNYW-OfSgLGhxkw-1; Tue, 01 Sep 2020 12:42:46 -0400
X-MC-Unique: K4vcFQznNYW-OfSgLGhxkw-1
Received: by mail-wr1-f71.google.com with SMTP id b8so810711wrr.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 09:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ENSWa8m+oZtit3Et3GaGi2ZXoyZ7hqMeu2oFSZm/mZ4=;
 b=P4nrqsCFxjjJuwbUcX5b+QQfcB4WDrfdhGaasPclOTRv0CJtw7BmUudIC14KFP+PxH
 Je3cPcmOlLZ6e+Rs73zMuppQaMwbDoIdARuDkFdreGp30uiSrP9Rju5HQzMj24wQ+d91
 CFlCh6n9+0RjU7MiPXHCXSFDSUfSVoW/Vx+KC6WguD4wmmb9zCVUxt/U0Cwaz2tSn5qr
 WJ/+EcxcCnTPaHLR7nOGXdy3sKz82dOX8B00G9CfFhFcNXKoc52HarLtfGVnPZBPPr2J
 6c13AqCwVqMon2iW5UQuqZ3eq/Sk6YSsa5gn86+stN2+1imYay/ZlZltlWZkXfZQEKPV
 +tHg==
X-Gm-Message-State: AOAM5332PaUNE7K3Ujx/aQ5wHR74pf0NOQ975ZrvTDDT62+BGz1dzzxy
 Fi4o95s34WU+B+Gxy0muW5bCBAgOgfcGw8Noo78q2gPyjZo0Yfl7GztBQIeHc04R2DwveB7RiXO
 sWjewVq66z6mXKhU=
X-Received: by 2002:adf:81c6:: with SMTP id 64mr2720677wra.176.1598978565163; 
 Tue, 01 Sep 2020 09:42:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6r5o4XMlIx3XM28Ln8DHhE9t5HV+hq1oV+wWKJSTs+q11UsjyJP3CsxZD6E33ZX4KWGKNWQ==
X-Received: by 2002:adf:81c6:: with SMTP id 64mr2720653wra.176.1598978564938; 
 Tue, 01 Sep 2020 09:42:44 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id 32sm3591535wrh.18.2020.09.01.09.42.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 09:42:44 -0700 (PDT)
Subject: Re: [PATCH v4 4/7] usb: hcd-xhci-sysbus: Attach xhci to sysbus device
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?=27Marc-Andr=c3=a9_Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Francisco Iglesias <francisco.iglesias@xilinx.com>
References: <1598642380-27817-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1598642380-27817-5-git-send-email-sai.pavan.boddu@xilinx.com>
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
Message-ID: <8893421c-d4ac-0b1a-15d8-5f0af11d1111@redhat.com>
Date: Tue, 1 Sep 2020 18:42:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598642380-27817-5-git-send-email-sai.pavan.boddu@xilinx.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Use XHCI as sysbus device, add memory region property to get the
> address space instance for dma read/write.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/usb/Kconfig           |  5 +++
>  hw/usb/Makefile.objs     |  1 +
>  hw/usb/hcd-xhci-sysbus.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/usb/hcd-xhci-sysbus.h | 32 ++++++++++++++++

Please consider using scripts/git.orderfile to ease review
(less scrolling required by reviewer).

>  hw/usb/hcd-xhci.h        |  1 +
>  5 files changed, 138 insertions(+)
...

> diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
> new file mode 100644
> index 0000000..d5b4656
> --- /dev/null
> +++ b/hw/usb/hcd-xhci-sysbus.c
> @@ -0,0 +1,99 @@
> +/*
> + * USB xHCI controller for system-bus interface
> + * Based on hcd-echi-sysbus.c
> +
> + * SPDX-FileCopyrightText: 2020 Xilinx
> + * SPDX-FileContributor: Author: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "qemu/osdep.h"
> +#include "hw/qdev-properties.h"
> +#include "migration/vmstate.h"
> +#include "trace.h"
> +#include "qapi/error.h"
> +#include "hcd-xhci-sysbus.h"
> +#include "hw/irq.h"
> +
> +static void xhci_sysbus_intr_raise(XHCIState *xhci, int n, bool level)
> +{
> +    XHCISysbusState *s = container_of(xhci, XHCISysbusState, xhci);
> +
> +    qemu_set_irq(s->irq[n], level);
> +}
> +
> +void xhci_sysbus_reset(DeviceState *dev)
> +{
> +    XHCISysbusState *s = XHCI_SYSBUS(dev);
> +
> +    device_legacy_reset(DEVICE(&s->xhci));

Documentation comment:

"This function is deprecated and will be removed when it becomes unused.
 Please use device_cold_reset() now."

> +}
> +


