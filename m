Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F315C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 13:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC9C2085B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 13:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UufHc8Ro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC9C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOLOG-0005Vl-Sd
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 09:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sundeep.lkml@gmail.com>) id 1jOLNY-0004yp-Cl
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 09:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sundeep.lkml@gmail.com>) id 1jOLNX-0000m8-4n
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 09:13:28 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:39719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sundeep.lkml@gmail.com>)
 id 1jOLNX-0000lv-0e; Tue, 14 Apr 2020 09:13:27 -0400
Received: by mail-io1-xd42.google.com with SMTP id m4so13125008ioq.6;
 Tue, 14 Apr 2020 06:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ECr5QE9/ZG1LP8toqj5wZJNArL3k/t9YUAbsoEu9oI4=;
 b=UufHc8RoT4aVuiwKw0fRk65MSomBZ0Ex2tiNVCBUZ/f9PTowuqh1E4VPJLapjhNVcA
 yk/nkTbFCIdnxCcT+8NKUEAOByEB/UknRdLfXjjdB9cVOTsLfXhbEGXjB56cRp8/lm7O
 lWeqOYfckpEMG9P6VeiF/by/bAQ0ww5FL87OcTseFxmM60i1tdlOJ+PBNrABYswydSGC
 in09vkK+oj9bzQjTa/oUNpm8y2Xm2e+rf6ypzxk41i551luhoJ7rTXr9qJc7n9LDvCar
 zCa8yJwL/cn8/7S2+yuP7ju9vG9JDFbNuVc1nztdrAXGEkzinS7KefXuIiFFTtQdfZy/
 /S0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ECr5QE9/ZG1LP8toqj5wZJNArL3k/t9YUAbsoEu9oI4=;
 b=knKse2hv5jC3HVNie7bspWyKsay2U0UxhFBc/l2d9mscINYhlOOS+9BBAqlXmesMZM
 kmywThIs7pme/g5vrIcIS7YdlZ68uVs2mYphkCEOMvzLJTw0nBAO/ryHhvZ/sCH0502x
 E/+FMqF6vHbVN6AuEYGP9H+LeNwz3e1EC7r7rFtBibF7KTSrnqc21QrFOmpfeQ0RcThe
 vmzC78jIVbTXn2BTnqi0ZzlF2vtA8AZ44ekIilh4NVnLPydNLvI6yZDe+djnHaQORTZR
 9mNsVkxetOTcIVO2LoRhevy2jEUtH4vID+EMC3HlvzikqjJfIIRX8Y0fKybhNJeOCsGV
 kFRg==
X-Gm-Message-State: AGi0Pua/HUEBbZ4z5JaSVl0b7i6ikN5zr8ONreRdALiZFWiANExm0+Xy
 WngDa3YAK6GWtmpjBERsn1AbYAFbr5aIwiDzfbI=
X-Google-Smtp-Source: APiQypKHrWEDKelV3P79sS0H6HO76GAlPRsYwBR4LQrPd3E6QYiB1dzRlJ3fykSKlGGuKxAL3qJNfD+1Q6RJFRysu98=
X-Received: by 2002:a5d:9c09:: with SMTP id 9mr7448545ioe.26.1586870006115;
 Tue, 14 Apr 2020 06:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <1586529926-11441-1-git-send-email-sundeep.lkml@gmail.com>
 <1586529926-11441-3-git-send-email-sundeep.lkml@gmail.com>
 <09d13b7c-7a48-4405-fbcd-558e71871ddf@amsat.org>
In-Reply-To: <09d13b7c-7a48-4405-fbcd-558e71871ddf@amsat.org>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Tue, 14 Apr 2020 18:43:15 +0530
Message-ID: <CALHRZuqJMk3BeMhKfjCjuEBqQmSFn=oLgXe=Hn0FPXgq1TbTJw@mail.gmail.com>
Subject: Re: [Qemu devel PATCH v4 2/3] msf2: Add EMAC block to SmartFusion2 SoC
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Sun, Apr 12, 2020 at 11:28 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> On 4/10/20 4:45 PM, sundeep.lkml@gmail.com wrote:
> > From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> >
> > With SmartFusion2 Ethernet MAC model in
> > place this patch adds the same to SoC.
> >
> > Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> > ---
> >  hw/arm/msf2-soc.c         | 21 ++++++++++++++++++++-
> >  include/hw/arm/msf2-soc.h |  3 +++
> >  2 files changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
> > index 588d643..2f2db6d 100644
> > --- a/hw/arm/msf2-soc.c
> > +++ b/hw/arm/msf2-soc.c
> > @@ -35,6 +35,7 @@
>
> Maybe you also want:
>
> - * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
> + * Copyright (c) 2017-2020 Subbaraya Sundeep <sundeep.lkml@gmail.com>
>
Ok.
> >
> >  #define MSF2_TIMER_BASE       0x40004000
> >  #define MSF2_SYSREG_BASE      0x40038000
> > +#define MSF2_EMAC_BASE        0x40041000
> >
> >  #define ENVM_BASE_ADDRESS     0x60000000
> >
> > @@ -55,6 +56,7 @@ static const uint32_t uart_addr[MSF2_NUM_UARTS] =3D {=
 0x40000000 , 0x40010000 };
> >  static const int spi_irq[MSF2_NUM_SPIS] =3D { 2, 3 };
> >  static const int uart_irq[MSF2_NUM_UARTS] =3D { 10, 11 };
> >  static const int timer_irq[MSF2_NUM_TIMERS] =3D { 14, 15 };
> > +static const int emac_irq[MSF2_NUM_EMACS] =3D { 12 };
>
> Correct.
>
> >
> >  static void do_sys_reset(void *opaque, int n, int level)
> >  {
> > @@ -81,6 +83,13 @@ static void m2sxxx_soc_initfn(Object *obj)
> >          sysbus_init_child_obj(obj, "spi[*]", &s->spi[i], sizeof(s->spi=
[i]),
> >                            TYPE_MSS_SPI);
> >      }
> > +
> > +    sysbus_init_child_obj(obj, "eth", &s->emac, sizeof(s->emac),
>
> "eth" -> "tsemac" (or "emac")?
>
Will change to emac.
> > +                          TYPE_MSS_EMAC);
> > +    if (nd_table[0].used) {
> > +        qemu_check_nic_model(&nd_table[0], TYPE_MSS_EMAC);
> > +        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
> > +    }
> >  }
> >
> >  static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
> > @@ -192,6 +201,17 @@ static void m2sxxx_soc_realize(DeviceState *dev_so=
c, Error **errp)
> >          g_free(bus_name);
> >      }
> >
> > +    dev =3D DEVICE(&s->emac);
>
> Can you pass the DMA memory via a link property please?
>
>        object_property_set_link(OBJECT(&s->emac),
>                                 OBJECT(get_system_memory()),
>                                 "ahb-bus", &error_abort);
>
Okay.
> > +    object_property_set_bool(OBJECT(&s->emac), true, "realized", &err)=
;
> > +    if (err !=3D NULL) {
> > +        error_propagate(errp, err);
> > +        return;
> > +    }
> > +    busdev =3D SYS_BUS_DEVICE(dev);
> > +    sysbus_mmio_map(busdev, 0, MSF2_EMAC_BASE);
> > +    sysbus_connect_irq(busdev, 0,
> > +                           qdev_get_gpio_in(armv7m, emac_irq[0]));
>
> Indentation is off.
>
Will fix
> > +
> >      /* Below devices are not modelled yet. */
> >      create_unimplemented_device("i2c_0", 0x40002000, 0x1000);
> >      create_unimplemented_device("dma", 0x40003000, 0x1000);
> > @@ -202,7 +222,6 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc=
, Error **errp)
> >      create_unimplemented_device("can", 0x40015000, 0x1000);
> >      create_unimplemented_device("rtc", 0x40017000, 0x1000);
> >      create_unimplemented_device("apb_config", 0x40020000, 0x10000);
> > -    create_unimplemented_device("emac", 0x40041000, 0x1000);
> >      create_unimplemented_device("usb", 0x40043000, 0x1000);
> >  }
> >
> > diff --git a/include/hw/arm/msf2-soc.h b/include/hw/arm/msf2-soc.h
> > index 3cfe5c7..296ed03 100644
> > --- a/include/hw/arm/msf2-soc.h
> > +++ b/include/hw/arm/msf2-soc.h
> > @@ -29,12 +29,14 @@
> >  #include "hw/timer/mss-timer.h"
> >  #include "hw/misc/msf2-sysreg.h"
> >  #include "hw/ssi/mss-spi.h"
> > +#include "hw/net/msf2-emac.h"
> >
> >  #define TYPE_MSF2_SOC     "msf2-soc"
> >  #define MSF2_SOC(obj)     OBJECT_CHECK(MSF2State, (obj), TYPE_MSF2_SOC=
)
> >
> >  #define MSF2_NUM_SPIS         2
> >  #define MSF2_NUM_UARTS        2
> > +#define MSF2_NUM_EMACS        1
> >
> >  /*
> >   * System timer consists of two programmable 32-bit
> > @@ -62,6 +64,7 @@ typedef struct MSF2State {
> >      MSF2SysregState sysreg;
> >      MSSTimerState timer;
> >      MSSSpiState spi[MSF2_NUM_SPIS];
> > +    MSF2EmacState emac;
>
> You used 'emac_irq[MSF2_NUM_EMACS]', either use emac[MSF2_NUM_EMACS]
> here or drop MSF2_NUM_EMACS?
>
Will drop MSF2_NUM_EMACS.

> >  } MSF2State;
> >
> >  #endif
> >
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thank you,
Sundeep

