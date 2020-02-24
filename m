Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61375C3567B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 08:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D15020661
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 08:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDRVE28u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D15020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j69Kp-0007Sh-CZ
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 03:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j69Iw-0005E2-NG
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j69Iv-0003UG-Et
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:41:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54555
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j69Iv-0003Tt-Bo
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582533688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OwmCxfaSC8BnNrb2l2gUmkelLJJswti0t2MykcFmdug=;
 b=WDRVE28umE3aiMESD9xetED1joyF9iz0zNLx6UAOPEcWJSq5tU3nkqDWZ1Ua+Gfaef43uX
 YJcSm5Yv4EGiwt7KTXLfX0wW7ma+cS5FNBWOE0owFXA3ypO8gROeoHNXYvKM3X9vV/ES4L
 IwVCSFYvP74Qfg414mCPA6pJGau/z0s=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-mgAzNq2NOJGB6ak4tQ5RJg-1; Mon, 24 Feb 2020 03:41:25 -0500
X-MC-Unique: mgAzNq2NOJGB6ak4tQ5RJg-1
Received: by mail-ed1-f72.google.com with SMTP id y23so6156103edt.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 00:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QBXkf4oEF9/VUOQA1C13p3RtrE2RbrIhkBgJqdINYaQ=;
 b=DqpULJk2ksDH/Kq/kFGM5DGAn/A/bAILGCtIAd9Uf1Jjn+HVtBisD0qCimiNpm+xSZ
 dRef/NaWH23MXdxUzCstRWK5BV9aQr50Z6xGCWw0P+HyWiwngf79PY64JGTq7ebUwKyP
 K3q4Hho5l3Se0chEsoIRKteKr8Ux0nyYcofBMDGvu4U1+ybIc3CwTjjsbiWswSdSDTNN
 zUw6hxXF+89xtqAixIyYOsgUuTMGRTI9yZ+NXULQ98iha/apWyQ2xwBQ0Y00mXY68adf
 jr9zAE0RKiymMc8eV8NUNIoe9DcSlvYEHpJcL5nOWNwD2+wu0jIKwb7qc4drmerbZLXu
 Yqsw==
X-Gm-Message-State: APjAAAW8vLbPSWEw0MxYYFpescIb7TdKaGpVl4uyK7nTY1X87Lguy7F4
 TyQzHzbT26EDiYCcVDZqjCWWJqzlDZBKb1nOZ2Zw3E6C1Eyj3bVP7fvOcRlRFEQEjcfIRwOA2uI
 Yofdk7EuQLECWEDY=
X-Received: by 2002:a05:6402:12d2:: with SMTP id
 k18mr45569438edx.253.1582533683865; 
 Mon, 24 Feb 2020 00:41:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxOGh+dfdlmcIFGuW4DQoq6GXbQjzq9z9udpk8NPvZ4XRdmnTWFOvKOhns6rCMNnRnzkDOruA==
X-Received: by 2002:a05:6402:12d2:: with SMTP id
 k18mr45569404edx.253.1582533683487; 
 Mon, 24 Feb 2020 00:41:23 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id g4sm907219edl.6.2020.02.24.00.41.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 00:41:22 -0800 (PST)
Subject: Re: [PATCH] hw/arm: Use TYPE_PL011 to create serial port
To: Gavin Shan <gshan@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20200224041633.97345-1-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ea5d13ba-e736-2c73-f2c0-6e42e512afa2@redhat.com>
Date: Mon, 24 Feb 2020 09:41:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224041633.97345-1-gshan@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, radoslaw.biernacki@linaro.org,
 alistair@alistair23.me, shan.gavin@gmail.com, edgar.iglesias@gmail.com,
 leif@nuviainc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 5:16 AM, Gavin Shan wrote:
> This uses TYPE_PL011 when creating the serial port, to make the code
> a bit more atomatic.

Do you mean aUtomatic? I'm not sure this automate the code, but using=20
the TYPE definition is definitively cleaner.

With description fixed:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/arm/sbsa-ref.c    | 3 ++-
>   hw/arm/virt.c        | 3 ++-
>   hw/arm/xlnx-versal.c | 3 ++-
>   3 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 9b5bcb5634..df0a165047 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -39,6 +39,7 @@
>   #include "hw/pci-host/gpex.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/usb.h"
> +#include "hw/char/pl011.h"
>   #include "net/net.h"
>  =20
>   #define RAMLIMIT_GB 8192
> @@ -409,7 +410,7 @@ static void create_uart(const SBSAMachineState *sms, =
int uart,
>   {
>       hwaddr base =3D sbsa_ref_memmap[uart].base;
>       int irq =3D sbsa_ref_irqmap[uart];
> -    DeviceState *dev =3D qdev_create(NULL, "pl011");
> +    DeviceState *dev =3D qdev_create(NULL, TYPE_PL011);
>       SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
>  =20
>       qdev_prop_set_chr(dev, "chardev", chr);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index f788fe27d6..d0da513737 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -71,6 +71,7 @@
>   #include "hw/mem/pc-dimm.h"
>   #include "hw/mem/nvdimm.h"
>   #include "hw/acpi/generic_event_device.h"
> +#include "hw/char/pl011.h"
>  =20
>   #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>       static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> @@ -724,7 +725,7 @@ static void create_uart(const VirtMachineState *vms, =
int uart,
>       int irq =3D vms->irqmap[uart];
>       const char compat[] =3D "arm,pl011\0arm,primecell";
>       const char clocknames[] =3D "uartclk\0apb_pclk";
> -    DeviceState *dev =3D qdev_create(NULL, "pl011");
> +    DeviceState *dev =3D qdev_create(NULL, TYPE_PL011);
>       SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
>  =20
>       qdev_prop_set_chr(dev, "chardev", chr);
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 1cf3daaf4f..403fc7b881 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -22,6 +22,7 @@
>   #include "hw/misc/unimp.h"
>   #include "hw/intc/arm_gicv3_common.h"
>   #include "hw/arm/xlnx-versal.h"
> +#include "hw/char/pl011.h"
>  =20
>   #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>   #define GEM_REVISION        0x40070106
> @@ -144,7 +145,7 @@ static void versal_create_uarts(Versal *s, qemu_irq *=
pic)
>           DeviceState *dev;
>           MemoryRegion *mr;
>  =20
> -        dev =3D qdev_create(NULL, "pl011");
> +        dev =3D qdev_create(NULL, TYPE_PL011);
>           s->lpd.iou.uart[i] =3D SYS_BUS_DEVICE(dev);
>           qdev_prop_set_chr(dev, "chardev", serial_hd(i));
>           object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_=
fatal);
>=20


