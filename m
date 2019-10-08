Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786B8C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41FF920815
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9q5icIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FF920815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHnOU-0000rs-DY
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 07:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHnNG-0000Bv-9L
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHnNC-0005Fi-RK
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:09:49 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51611)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHnN9-0005DX-8f
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:09:44 -0400
Received: by mail-wm1-x344.google.com with SMTP id 7so2696607wme.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 04:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=XTTEpwKgnYJsVWpxqunLUNtwUgh+TKBN1LV8Gtnu5Y8=;
 b=H9q5icIhlYTQi7JMZpQX9RbBmys/vKF8e5cT6+DjSzEngj+lZfqa2LO0RqPPXK5yAo
 xvM4OCaoQGR5LVxtO/+O9LP4ryKKKWConz2cgMKLazoFdUWRqKwvMVsjYDejSuOEsrO9
 Fbn0AbpmF1GX63XyVoAlVOpJkp5iW/o539pdp05Nmjg/J2aVZVCG+JPp4YIBXMgEL4dt
 PPEKPbB0VO2gXXJnmxyYbhjFqUs1U+jDVHjMjmkRNh2CEujZCs7f/LlDN56/8r585osY
 920YiV9YwolGlY5Cbj1SlVisp2QkcU14SclrBQ50hV5TZZcgCMqrSOZumQ6Nzpn060jm
 Sogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=XTTEpwKgnYJsVWpxqunLUNtwUgh+TKBN1LV8Gtnu5Y8=;
 b=SFBl7tvAWesT2fxI8tiInH0WNxvaaapgIiMAt3qAu5Yf7zoDRYV+1FxCr2cYQ72tg4
 vZcxWS59OBgWp1w4tWmHe47gl0QDplUir1OXycnv/jdioblqJvPEPNpBTfn/45WgDM4S
 NlUdWNk4J8yybWW16BSFt2zry24HEeHx7f+JlVdz+/Y9sBz1//SUM32xTfjau7OqFTCt
 8Lm0S1C+fqX6XfK9KLiXUQSap6KNk/xwxLtGwwizMJHCw9mAcCyh5jtKCCsn39EJ/fDq
 OLwoy0B7iMKMzzts6NoLR8JTvMGLNyqj+fwFAdJ6GC05yoP31LiIB6wi5719IiIxB24a
 mTqw==
X-Gm-Message-State: APjAAAXqdIW+DSAAbfPkGD7rIHZxZnRg9Pvr3E2eSrGlKbijTF0svMcg
 iOiDCAh6vtvP4ZJa8Y1L7fP0wg==
X-Google-Smtp-Source: APXvYqxcUWyP5wNF/wZ2B1dTta/jfiS+e0K/PUnGOX7RAR+SakGf6j5FcfbnPm+4FQxE8gGOp+dRMg==
X-Received: by 2002:a1c:2e4c:: with SMTP id u73mr3269508wmu.94.1570532981016; 
 Tue, 08 Oct 2019 04:09:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n15sm4505321wrw.47.2019.10.08.04.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 04:09:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BDB771FF87;
 Tue,  8 Oct 2019 12:09:39 +0100 (BST)
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-6-f4bug@amsat.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH 05/19] hw/arm/bcm2835: Add various unimplemented
 peripherals
In-reply-to: <20190926173428.10713-6-f4bug@amsat.org>
Date: Tue, 08 Oct 2019 12:09:39 +0100
Message-ID: <87zhibijd8.fsf@linaro.org>
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
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?utf-8?Q?Zolt=C3=A1n?= Baldaszti <bztemail@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Dau?= =?utf-8?Q?d=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Base addresses and sizes taken from the "BCM2835 ARM Peripherals"
> datasheet from February 06 2012:
> https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.p=
df
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/arm/bcm2835_peripherals.c         | 31 ++++++++++++++++++++++++++++
>  include/hw/arm/bcm2835_peripherals.h | 15 ++++++++++++++
>  include/hw/arm/raspi_platform.h      |  8 +++++++
>  3 files changed, 54 insertions(+)
>
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 1bd2ff41d5..fdcf616c56 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -22,6 +22,20 @@
>  /* Capabilities for SD controller: no DMA, high-speed, default clocks et=
c. */
>  #define BCM2835_SDHC_CAPAREG 0x52134b4
>
> +static void create_unimp(BCM2835PeripheralState *ps,
> +                         UnimplementedDeviceState *uds,
> +                         const char *name, hwaddr ofs, hwaddr size)
> +{
> +    sysbus_init_child_obj(OBJECT(ps), name, uds,
> +                          sizeof(UnimplementedDeviceState),
> +                          TYPE_UNIMPLEMENTED_DEVICE);
> +    qdev_prop_set_string(DEVICE(uds), "name", name);
> +    qdev_prop_set_uint64(DEVICE(uds), "size", size);
> +    object_property_set_bool(OBJECT(uds), true, "realized", &error_fatal=
);
> +    memory_region_add_subregion_overlap(&ps->peri_mr, ofs,
> +                    sysbus_mmio_get_region(SYS_BUS_DEVICE(uds), 0), -100=
0);
> +}
> +
>  static void bcm2835_peripherals_init(Object *obj)
>  {
>      BCM2835PeripheralState *s =3D BCM2835_PERIPHERALS(obj);
> @@ -323,6 +337,23 @@ static void bcm2835_peripherals_realize(DeviceState =
*dev, Error **errp)
>          error_propagate(errp, err);
>          return;
>      }
> +
> +    create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET=
, 0x40);
> +    create_unimp(s, &s->systmr, "bcm2835-systimer", ST_OFFSET, 0x20);
> +    create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
> +    create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
> +    create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
> +    create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
> +    create_unimp(s, &s->spi[0], "bcm2835-spi0", SPI0_OFFSET, 0x20);
> +    create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
> +    create_unimp(s, &s->i2c[0], "bcm2835-i2c0", BSC0_OFFSET, 0x20);
> +    create_unimp(s, &s->i2c[1], "bcm2835-i2c1", BSC1_OFFSET, 0x20);
> +    create_unimp(s, &s->i2c[2], "bcm2835-i2c2", BSC2_OFFSET, 0x20);
> +    create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
> +    create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
> +    create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
> +    create_unimp(s, &s->dwc2, "dwc-usb2", USB_OTG_OFFSET, 0x1000);
> +    create_unimp(s, &s->sdramc, "bcm2835-sdramc", SDRAMC_OFFSET, 0x100);
>  }
>
>  static void bcm2835_peripherals_class_init(ObjectClass *oc, void *data)
> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm283=
5_peripherals.h
> index 6b17f6a382..62a4c7b559 100644
> --- a/include/hw/arm/bcm2835_peripherals.h
> +++ b/include/hw/arm/bcm2835_peripherals.h
> @@ -23,6 +23,7 @@
>  #include "hw/sd/sdhci.h"
>  #include "hw/sd/bcm2835_sdhost.h"
>  #include "hw/gpio/bcm2835_gpio.h"
> +#include "hw/misc/unimp.h"
>
>  #define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
>  #define BCM2835_PERIPHERALS(obj) \
> @@ -37,6 +38,10 @@ typedef struct BCM2835PeripheralState {
>      MemoryRegion ram_alias[4];
>      qemu_irq irq, fiq;
>
> +    UnimplementedDeviceState systmr;
> +    UnimplementedDeviceState armtmr;
> +    UnimplementedDeviceState cprman;
> +    UnimplementedDeviceState a2w;
>      PL011State uart0;
>      BCM2835AuxState aux;
>      BCM2835FBState fb;
> @@ -48,6 +53,16 @@ typedef struct BCM2835PeripheralState {
>      SDHCIState sdhci;
>      BCM2835SDHostState sdhost;
>      BCM2835GpioState gpio;
> +    UnimplementedDeviceState i2s;
> +    UnimplementedDeviceState spi[1];
> +    UnimplementedDeviceState i2c[3];
> +    UnimplementedDeviceState otp;
> +    UnimplementedDeviceState dbus;
> +    UnimplementedDeviceState ave0;
> +    UnimplementedDeviceState bscsl;
> +    UnimplementedDeviceState smi;
> +    UnimplementedDeviceState dwc2;
> +    UnimplementedDeviceState sdramc;
>  } BCM2835PeripheralState;
>
>  #endif /* BCM2835_PERIPHERALS_H */
> diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platf=
orm.h
> index 66969fac5d..cdcbca943f 100644
> --- a/include/hw/arm/raspi_platform.h
> +++ b/include/hw/arm/raspi_platform.h
> @@ -38,6 +38,8 @@
>                                                        * Doorbells & Mail=
boxes */
>  #define CPRMAN_OFFSET           0x100000 /* Power Management, Watchdog */
>  #define CM_OFFSET               0x101000 /* Clock Management */
> +#define A2W_OFFSET              0x102000 /* Reset controller */
> +#define AVS_OFFSET              0x103000 /* Audio Video Standard */
>  #define RNG_OFFSET              0x104000
>  #define GPIO_OFFSET             0x200000
>  #define UART0_OFFSET            0x201000
> @@ -45,11 +47,17 @@
>  #define I2S_OFFSET              0x203000
>  #define SPI0_OFFSET             0x204000
>  #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
> +#define OTP_OFFSET              0x20f000
> +#define BSC_SL_OFFSET           0x214000 /* SPI slave */
>  #define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2 */
>  #define EMMC1_OFFSET            0x300000
>  #define SMI_OFFSET              0x600000
>  #define BSC1_OFFSET             0x804000 /* BSC1 I2C/TWI */
> +#define BSC2_OFFSET             0x805000 /* BSC2 I2C/TWI */
> +#define DBUS_OFFSET             0x900000
> +#define AVE0_OFFSET             0x910000
>  #define USB_OTG_OFFSET          0x980000 /* DTC_OTG USB controller */
> +#define SDRAMC_OFFSET           0xe00000
>  #define DMA15_OFFSET            0xE05000 /* DMA controller, channel 15 */
>
>  /* GPU interrupts */


--
Alex Benn=C3=A9e

