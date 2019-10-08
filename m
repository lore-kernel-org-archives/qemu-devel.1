Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76889C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40FBE206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t71QOpnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FBE206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHrN8-0003mb-2L
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 11:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHrKM-0001jH-QA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHrKK-0004bO-HI
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:23:06 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHrKH-0004Z8-0l
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:23:02 -0400
Received: by mail-wm1-x344.google.com with SMTP id m18so3574633wmc.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Ev7ZIva5izovwJvRFXzQDP6nMGi/bwMmQ/wsqQwtv9Q=;
 b=t71QOpncc3InF256WFv/YXCFcOKmOskc+pXDh2sYSiUmBEUYJMzqI15ukynzvlrUNT
 UjFf0tDb0sMusIH2AsJNYmJI7P38Wl8PWyatypLht4eSfjFWtTy/6pVhiDueCcJWYW3t
 RsRC+Ts45SHS1Lm+utitFGG2Ofv311oCkxrwmRBi+dIk7dvj+MMxZJYJzbL/jkYt8pdr
 MLEQmR/RijDSCWvjyaA/HdYSfqGxlhqVDu65W0zar5neDZvePQ+x3CAVQeTWz36kGkdL
 LykWZXhvoRXbvPv0t/oO5mDc7yWZ1vy+JhMBzVZ3vstMaYfhf1sEZqlRmSHqczVbBzJi
 3jsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Ev7ZIva5izovwJvRFXzQDP6nMGi/bwMmQ/wsqQwtv9Q=;
 b=ZXpSscqKjNh6Om/sdtvpcxYGcO1SbfO6i+uB2qNaCjjfFMckrNO1Oygk5Kuy2Xj9nP
 VyDagH6Y8EeYdDEW4Fy1bgL8jgpzpSKe3p21QGuV+xmHAGB1ZItczW8UifduAQEL8IiW
 NJA7ah3Gw2LdX1kplok4gMx/WNlDEYpvkppta478QoNaPEtVmZNQAUTguWlDFtTbRlu8
 bErSOnlUQWls4PNV5OFF1nt6lfzzxnx3uZDHbqPfIfZv7Tns832BbpxWut6CIOXhYMZO
 cRQaLz9TGvMzQr3o/WR5pWS6kviT6keteCfLXi7Ku+s9hqG82ILQNpUsnwM6jVkz4R0a
 dz+g==
X-Gm-Message-State: APjAAAWMiOJNQbInpAF8LJm/hGGIKS+aF6EJhd32w072U+nnwZAdScTa
 zI8P6IO3Ya/Ix9cA9+k/84QtLQ==
X-Google-Smtp-Source: APXvYqzX98m1otly3IpbZaWSOUuFGzFrGfZZTOVrX4+nw841XwT+Ki9+mJ1JSdB20rRMi36Omrq7Ew==
X-Received: by 2002:a1c:f417:: with SMTP id z23mr4384417wma.77.1570548179651; 
 Tue, 08 Oct 2019 08:22:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a14sm3004727wmm.44.2019.10.08.08.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 08:22:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2375F1FF87;
 Tue,  8 Oct 2019 16:22:58 +0100 (BST)
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-12-f4bug@amsat.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 11/19] hw/arm/bcm2835_peripherals: Use the SYS_timer
In-reply-to: <20190926173428.10713-12-f4bug@amsat.org>
Date: Tue, 08 Oct 2019 16:22:58 +0100
Message-ID: <87sgo3i7n1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Zolt=C3=A1n?= Baldaszti <bztemail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Connect the recently added SYS_timer.
> Now U-Boot does not hang anymore polling a free running counter
> stuck at 0.
> This timer is also used by the Linux kernel thermal subsystem.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/bcm2835_peripherals.c         | 21 ++++++++++++++++++++-
>  include/hw/arm/bcm2835_peripherals.h |  3 ++-
>  2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 70bf927a02..965f4c1f3d 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -58,6 +58,10 @@ static void bcm2835_peripherals_init(Object *obj)
>      /* Interrupt Controller */
>      sysbus_init_child_obj(obj, "ic", &s->ic, sizeof(s->ic), TYPE_BCM2835=
_IC);
>
> +    /* SYS Timer */
> +    sysbus_init_child_obj(obj, "systimer", &s->systmr, sizeof(s->systmr),
> +                          TYPE_BCM2835_SYSTIMER);
> +
>      /* UART0 */
>      sysbus_init_child_obj(obj, "uart0", &s->uart0, sizeof(s->uart0),
>                            TYPE_PL011);
> @@ -171,6 +175,22 @@ static void bcm2835_peripherals_realize(DeviceState =
*dev, Error **errp)
>                  sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ic), 0));
>      sysbus_pass_irq(SYS_BUS_DEVICE(s), SYS_BUS_DEVICE(&s->ic));
>
> +    /* Sys Timer */
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }

This looks like an extra check because err is checked above and hasn't
been messed with since.

> +    object_property_set_bool(OBJECT(&s->systmr), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    memory_region_add_subregion(&s->peri_mr, ST_OFFSET,
> +                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systmr), 0));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->systmr), 0,
> +        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_ARM_IRQ,
> +                               INTERRUPT_ARM_TIMER));
> +
>      /* UART0 */
>      qdev_prop_set_chr(DEVICE(&s->uart0), "chardev", serial_hd(0));
>      object_property_set_bool(OBJECT(&s->uart0), true, "realized", &err);
> @@ -352,7 +372,6 @@ static void bcm2835_peripherals_realize(DeviceState *=
dev, Error **errp)
>      }
>
>      create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET=
, 0x40);
> -    create_unimp(s, &s->systmr, "bcm2835-systimer", ST_OFFSET, 0x20);
>      create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
>      create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
>      create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm283=
5_peripherals.h
> index be7ad9b499..5b9fc89453 100644
> --- a/include/hw/arm/bcm2835_peripherals.h
> +++ b/include/hw/arm/bcm2835_peripherals.h
> @@ -24,6 +24,7 @@
>  #include "hw/sd/sdhci.h"
>  #include "hw/sd/bcm2835_sdhost.h"
>  #include "hw/gpio/bcm2835_gpio.h"
> +#include "hw/timer/bcm2835_systmr.h"
>  #include "hw/misc/unimp.h"
>
>  #define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
> @@ -39,7 +40,7 @@ typedef struct BCM2835PeripheralState {
>      MemoryRegion ram_alias[4];
>      qemu_irq irq, fiq;
>
> -    UnimplementedDeviceState systmr;
> +    BCM2835SysTimerState systmr;
>      UnimplementedDeviceState armtmr;
>      UnimplementedDeviceState cprman;
>      UnimplementedDeviceState a2w;


--
Alex Benn=C3=A9e

