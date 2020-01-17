Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D09C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8137F20730
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HkeJRwQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8137F20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isPUQ-0006sB-Fj
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 06:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isPTj-0006Go-6Z
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isPTh-0003Vb-Rl
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:07:50 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45234)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isPTh-0003Ur-LA
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:07:49 -0500
Received: by mail-ot1-x341.google.com with SMTP id 59so22189072otp.12
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 03:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zH/wNJ76wLw/+0fquGdJeT6sWMpTUa+KgeuMJcheKcE=;
 b=HkeJRwQ/uade9ZX3c12JDT4Sm0+bs+Eg0Y9f6vkedd7QIm7J2SP6RYZYwYr7pDfSx+
 ExjMpLbfE7/owQDNxPfl3j9Crhp31N/cL3JwUidh03Cub8kAhsEfxgjXTZ9/csdnhO18
 idLfStA7WuWQGmyvsJnWo4Z6kDcl1ZMeph8o7tbCdQdobTMuKL72qXH/iPX8HbjMJooM
 cjx0Af++DicAdgCAiF8UR46AJE/W8tO8GB8CmqXb3BoQvNsjnncYUc4LbkNNairLw+Ug
 OV8lR8BtGKDCgyTXVYdLi1nKNLuTak2LNCY79/mgVGzPrjbr2+x+eyaa+orN2lRll6Vt
 GhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zH/wNJ76wLw/+0fquGdJeT6sWMpTUa+KgeuMJcheKcE=;
 b=ZqK9njNhBFRCh+yiMishWIN4IPExzXdhZMZRLN5OzruiqYSuptRYlUjL4+WpMzwiMo
 9nZ93eBKow4fTClziXwMk8ceaLkg7gj1saZp4Ou7BWWd7PJTDJ+BgSDuyPrOEgqAJg2p
 yfkBMjfLkpbl2ctxXH8JHK0IAk+hfhKEs9AifdC+BIbJuxDWKzDnSNb/6seo6Fey2N+0
 VVv//qPkFZYFOVvKeDnAl4os/fJDyzYXaWVe4e9fPnjzrv2BFWi9B0qYKZnqr8Q4wSQw
 3uZIj4Dk6M8GNlJfjtxOIWcpMM9In+ZED0xae/CY1NynfC1pQiXuFNV+25eh4jVqI2C+
 Vp+Q==
X-Gm-Message-State: APjAAAUJBprWRBhjKojEcQMF0/O/hvYWoqrt4oudtuVQH7dpviOECCI/
 cwuMbV+IhauiX7tAo4MOzXsULi/VhTXFnU1u+PKG8g==
X-Google-Smtp-Source: APXvYqyIS4OSsRCbPE32f4QRkHBNjfoKQP19C3bh3vorITpbrYY44Jlo0curIl5fJGQwDae2DQxEtII358CGHyGjv6k=
X-Received: by 2002:a05:6830:1586:: with SMTP id
 i6mr5402453otr.221.1579259268244; 
 Fri, 17 Jan 2020 03:07:48 -0800 (PST)
MIME-Version: 1.0
References: <20200117063822.57918-1-zhukeqian1@huawei.com>
In-Reply-To: <20200117063822.57918-1-zhukeqian1@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 11:07:37 +0000
Message-ID: <CAFEAcA_Cji9poXhv1=cje3r2uwz+X_iYo8TmTxP_wP1CRV-b9g@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm: Adjust some coding styles about memory hotplug
To: Keqian Zhu <zhukeqian1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, wanghaibin.wang@huawei.com,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jan 2020 at 06:41, Keqian Zhu <zhukeqian1@huawei.com> wrote:
>
> From: zhukeqian <zhukeqian1@huawei.com>
>
> There is extra indent in ACPI GED plug cb. And we can use
> existing helper function to trigger hotplug handler plug.
>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>
> v1->v2:
>  - Add Igor's R-b
>
> Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/acpi/generic_event_device.c | 2 +-
>  hw/arm/virt.c                  | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 9cee90cc70..55eb29d80a 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -175,7 +175,7 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
>      AcpiGedState *s = ACPI_GED(hotplug_dev);
>
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -            acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
> +        acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
>      } else {
>          error_setg(errp, "virt: device plug request for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 39ab5f47e0..656b0081c2 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1934,7 +1934,6 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>  static void virt_memory_plug(HotplugHandler *hotplug_dev,
>                               DeviceState *dev, Error **errp)
>  {
> -    HotplugHandlerClass *hhc;
>      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>      Error *local_err = NULL;
>
> @@ -1943,8 +1942,9 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>          goto out;
>      }
>
> -    hhc = HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
> -    hhc->plug(HOTPLUG_HANDLER(vms->acpi_dev), dev, &error_abort);
> +    hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
> +                         dev, &error_abort);
> +
>  out:
>      error_propagate(errp, local_err);
>  }

These two changes are unrelated (one is just a whitespace
fixup, and it's in an entirely different file to the other
one, which is making an actual code change). I think they
should not be in the same patch.

thanks
-- PMM

