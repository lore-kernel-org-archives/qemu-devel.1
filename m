Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C142CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 20:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A672086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 20:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maEtkUPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A672086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMeM3-0007Jt-9O
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 16:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iMeLH-0006mN-OD
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 16:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iMeLF-0001M9-TI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 16:31:51 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:35093)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iMeLF-0001LH-J9; Mon, 21 Oct 2019 16:31:49 -0400
Received: by mail-lf1-x143.google.com with SMTP id y6so4917905lfj.2;
 Mon, 21 Oct 2019 13:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Hc3gwhMsHUJaQQu2Ghww+wGxfmhqKAIChjWJ6Zwo3u8=;
 b=maEtkUPjzHV1xR7NVkMfXDyhsmY3hgXP8fUwWWfiYlA/ktOc8u4uelEEQAWPi/PjmI
 9ouiGRqcMYNw3asE/e++DaNz+JKP90ZWOGbJeviB3Vp7As4b+9dfj/8Kyrby8j4q9JNh
 hpRVnj09ha+BxPtAEOiKpSxJNuGNnr5OskPCg7CBevoJVp5hoc6q3qxG4EEj+vj9T55J
 dBgAeD5puNU8HNnlMAxVupvtp3NdYXpzuZLWQRwm1v1LVaZwmjbofH6OnKRfp3cK1FQW
 ISyRGSRoIXMCJWnLwg0OgTD8QdOEbBvamJLlNZkqfeLCoAhmTHsb50lXXVzC4Agz0dPa
 r5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Hc3gwhMsHUJaQQu2Ghww+wGxfmhqKAIChjWJ6Zwo3u8=;
 b=hjt7ETslpTQK8aKM5qizYwxyFSh8xhjfaqGrxWxb+r4ZiHH0eKp7EYsdsdF+yC8nBA
 wabTR6y9EXeL+Q8gsbFkFOUSj+6+ZeuBd1FNzvdsULE4PTsbwCyvG1+HyBPmfOV4iEfr
 F88HOIAz6IO3Rw7V52THynnifZaiKigVlc149exEPNl5Y9GLw5hzwfJHg33oFYLJ7Mfz
 Cq7NLNxFPJdw0yOnqC0A7Okhbi5fc7DVirnWz19bu2kWshQQJCZTUKZxZxF+MmUf3PeB
 Vpojoh4NHk5m9Q2HkPxRWix2mXZEdZejxVqE9EqxuB1qW1H/px6nExCdHnVsPMsEvgOD
 0aMQ==
X-Gm-Message-State: APjAAAVqzmxxhbPvsrssQcc+bhEySTeKszYbo27Eq4AZp2q9GUtFqfbt
 uPB7KesT0ad2Q8UjxyzVynK0kjAwb99iPOACAlQ=
X-Google-Smtp-Source: APXvYqweYwEdj3rXBWGYYBHeIWf1oJdjT4CRtcnTlo10jROhcOVnGdpbH6LvB4db+i3YmocLnD5c9GYgCAMUUdBIKTk=
X-Received: by 2002:ac2:447b:: with SMTP id y27mr5572985lfl.135.1571689907428; 
 Mon, 21 Oct 2019 13:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191019234715.25750-1-f4bug@amsat.org>
 <20191019234715.25750-2-f4bug@amsat.org>
In-Reply-To: <20191019234715.25750-2-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2019 13:26:22 -0700
Message-ID: <CAKmqyKNkWifhCyt4T9Q3kJMrzjv8efK1ZO0Q_yzsKELiA_QfVg@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] hw/misc/bcm2835_thermal: Add a dummy BCM2835
 thermal sensor
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 19, 2019 at 4:47 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> We will soon implement the SYS_timer. This timer is used by Linux
> in the thermal subsystem, so once available, the subsystem will be
> enabled and poll the temperature sensors. We need to provide the
> minimum required to keep Linux booting.
>
> Add a dummy thermal sensor returning ~25=C2=B0C based on:
> https://github.com/raspberrypi/linux/blob/rpi-5.3.y/drivers/thermal/broad=
com/bcm2835_thermal.c
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v2:
> - Explicit g_assert_not_reached() with comment (Alex)
> - Add vmstate and reset handler (Peter)
>
> checkpatch warning:
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> This is OK because the regex are:
>
>   F: hw/*/bcm283*
>   F: include/hw/*/bcm283*
> ---
>  hw/misc/Makefile.objs             |   1 +
>  hw/misc/bcm2835_thermal.c         | 135 ++++++++++++++++++++++++++++++
>  include/hw/misc/bcm2835_thermal.h |  27 ++++++
>  3 files changed, 163 insertions(+)
>  create mode 100644 hw/misc/bcm2835_thermal.c
>  create mode 100644 include/hw/misc/bcm2835_thermal.h
>
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index a150680966..c89f3816a5 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -53,6 +53,7 @@ common-obj-$(CONFIG_OMAP) +=3D omap_tap.o
>  common-obj-$(CONFIG_RASPI) +=3D bcm2835_mbox.o
>  common-obj-$(CONFIG_RASPI) +=3D bcm2835_property.o
>  common-obj-$(CONFIG_RASPI) +=3D bcm2835_rng.o
> +common-obj-$(CONFIG_RASPI) +=3D bcm2835_thermal.o
>  common-obj-$(CONFIG_SLAVIO) +=3D slavio_misc.o
>  common-obj-$(CONFIG_ZYNQ) +=3D zynq_slcr.o
>  common-obj-$(CONFIG_ZYNQ) +=3D zynq-xadc.o
> diff --git a/hw/misc/bcm2835_thermal.c b/hw/misc/bcm2835_thermal.c
> new file mode 100644
> index 0000000000..c6f3b1ad60
> --- /dev/null
> +++ b/hw/misc/bcm2835_thermal.c
> @@ -0,0 +1,135 @@
> +/*
> + * BCM2835 dummy thermal sensor
> + *
> + * Copyright (C) 2019 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "hw/misc/bcm2835_thermal.h"
> +#include "hw/registerfields.h"
> +#include "migration/vmstate.h"
> +
> +REG32(CTL, 0)
> +FIELD(CTL, POWER_DOWN, 0, 1)
> +FIELD(CTL, RESET, 1, 1)
> +FIELD(CTL, BANDGAP_CTRL, 2, 3)
> +FIELD(CTL, INTERRUPT_ENABLE, 5, 1)
> +FIELD(CTL, DIRECT, 6, 1)
> +FIELD(CTL, INTERRUPT_CLEAR, 7, 1)
> +FIELD(CTL, HOLD, 8, 10)
> +FIELD(CTL, RESET_DELAY, 18, 8)
> +FIELD(CTL, REGULATOR_ENABLE, 26, 1)
> +
> +REG32(STAT, 4)
> +FIELD(STAT, DATA, 0, 10)
> +FIELD(STAT, VALID, 10, 1)
> +FIELD(STAT, INTERRUPT, 11, 1)
> +
> +#define THERMAL_OFFSET_C 412
> +#define THERMAL_COEFF  (-0.538f)
> +
> +static uint16_t bcm2835_thermal_temp2adc(int temp_C)
> +{
> +    return (temp_C - THERMAL_OFFSET_C) / THERMAL_COEFF;
> +}
> +
> +static uint64_t bcm2835_thermal_read(void *opaque, hwaddr addr, unsigned=
 size)
> +{
> +    Bcm2835ThermalState *s =3D BCM2835_THERMAL(opaque);
> +    uint32_t val =3D 0;
> +
> +    switch (addr) {
> +    case A_CTL:
> +        val =3D s->ctl;
> +        break;
> +    case A_STAT:
> +        /* Temperature is constantly 25=C2=B0C. */
> +        val =3D FIELD_DP32(bcm2835_thermal_temp2adc(25), STAT, VALID, tr=
ue);
> +        break;
> +    default:
> +        /* MemoryRegionOps are aligned, so this can not happen. */
> +        g_assert_not_reached();
> +    }
> +    return val;
> +}
> +
> +static void bcm2835_thermal_write(void *opaque, hwaddr addr,
> +                                  uint64_t value, unsigned size)
> +{
> +    Bcm2835ThermalState *s =3D BCM2835_THERMAL(opaque);
> +
> +    switch (addr) {
> +    case A_CTL:
> +        s->ctl =3D value;
> +        break;
> +    case A_STAT:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: write 0x%" PRIx64
> +                                       " to 0x%" HWADDR_PRIx "\n",
> +                       __func__, value, addr);
> +        break;
> +    default:
> +        /* MemoryRegionOps are aligned, so this can not happen. */
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static const MemoryRegionOps bcm2835_thermal_ops =3D {
> +    .read =3D bcm2835_thermal_read,
> +    .write =3D bcm2835_thermal_write,
> +    .impl.max_access_size =3D 4,
> +    .valid.min_access_size =3D 4,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void bcm2835_thermal_reset(DeviceState *dev)
> +{
> +    Bcm2835ThermalState *s =3D BCM2835_THERMAL(dev);
> +
> +    s->ctl =3D 0;
> +}
> +
> +static void bcm2835_thermal_realize(DeviceState *dev, Error **errp)
> +{
> +    Bcm2835ThermalState *s =3D BCM2835_THERMAL(dev);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &bcm2835_thermal_ops,
> +                          s, TYPE_BCM2835_THERMAL, 8);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
> +}
> +
> +static const VMStateDescription bcm2835_thermal_vmstate =3D {
> +    .name =3D "bcm2835_thermal",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(ctl, Bcm2835ThermalState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void bcm2835_thermal_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D bcm2835_thermal_realize;
> +    dc->reset =3D bcm2835_thermal_reset;
> +    dc->vmsd =3D &bcm2835_thermal_vmstate;
> +}
> +
> +static const TypeInfo bcm2835_thermal_info =3D {
> +    .name =3D TYPE_BCM2835_THERMAL,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(Bcm2835ThermalState),
> +    .class_init =3D bcm2835_thermal_class_init,
> +};
> +
> +static void bcm2835_thermal_register_types(void)
> +{
> +    type_register_static(&bcm2835_thermal_info);
> +}
> +
> +type_init(bcm2835_thermal_register_types)
> diff --git a/include/hw/misc/bcm2835_thermal.h b/include/hw/misc/bcm2835_=
thermal.h
> new file mode 100644
> index 0000000000..c3651b27ec
> --- /dev/null
> +++ b/include/hw/misc/bcm2835_thermal.h
> @@ -0,0 +1,27 @@
> +/*
> + * BCM2835 dummy thermal sensor
> + *
> + * Copyright (C) 2019 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_MISC_BCM2835_THERMAL_H
> +#define HW_MISC_BCM2835_THERMAL_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_BCM2835_THERMAL "bcm2835-thermal"
> +
> +#define BCM2835_THERMAL(obj) \
> +    OBJECT_CHECK(Bcm2835ThermalState, (obj), TYPE_BCM2835_THERMAL)
> +
> +typedef struct {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +    MemoryRegion iomem;
> +    uint32_t ctl;
> +} Bcm2835ThermalState;
> +
> +#endif
> --
> 2.21.0
>
>

