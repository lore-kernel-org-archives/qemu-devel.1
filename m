Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DD2C10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 02:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E602067C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 02:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTrJWBNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E602067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAOzK-0005VN-M9
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 21:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jAOyY-0004wO-LD
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 21:14:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jAOyU-0003hH-OE
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 21:14:02 -0500
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:34722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jAOyU-0003er-IJ; Fri, 06 Mar 2020 21:13:58 -0500
Received: by mail-ua1-x943.google.com with SMTP id a18so1440309uao.1;
 Fri, 06 Mar 2020 18:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Gh/mgcAU5VsFxu3c+APfP81OKWSOItoCuorAZV/hez8=;
 b=LTrJWBNvoSC45UL1L4RGfcmzbjRgDRMBD105JlVMZLxvLdfqyv75yqbdAwkaUq3+BV
 SOSD2Fp08OxqFE7WBDC6CGwFe4q6UsRPMoJ5EwLZ34KlFio1lb6G5A4cPSMelTYHLqG6
 Rh9kTpfmU316RkDX3HL4aY4pdstPbCmX6oGoBnS3mjPObaenGraeL6bjJT+KrGA4mo5b
 yu3rv1PX2FlIYzeaIBlgDUCMqDVosMnANvinD9zkMssJ/gygg6rPzD3ELCM1ZH16Mp19
 YLX/o/LYqT07MRrUZk+BO06gJCXM8PiG4tJViaHtdbpkl3LFmX2SHESukiWFBHmVdZfc
 WyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Gh/mgcAU5VsFxu3c+APfP81OKWSOItoCuorAZV/hez8=;
 b=S1UMhRWvJY+/b+esoGo9jIiggQ2elPUd/ss+xtDA2SEEKaGYFYViHXydWxRYGPbNpO
 0qBnVFv/HI3oIxfxKhmffKjOW3LqtvbvSehSgpa25WDnY3Kvm+C/CgncZBqTL13mF1Po
 z/Ke1sP6lvCbBaP4dDoztI4fVetEOHqC/9+KyAAuIyNulrSyBtPrl3hS0hdnY31rDwaL
 x6wpsUwU9hiQDC03mmECa7YGOndblscHjJrsAKsCwMksPzk7bFH1SCB4sDdssXYitm/Y
 VozMHLa+2Pb+MBu/iJ4M0Wd6U12Qx8BbzGyd8lGY7pQM79L8I1ABItbHrFoyoqhwsCvB
 apuA==
X-Gm-Message-State: ANhLgQ2m9X7QIoZe7Rf6d0Q6/k/ONKZUHFjke+b6ahe+VpENAXxaJr25
 jf/RHboWfYswF7/6AVKir2Y9HDgUmu/u/DLKrUU=
X-Google-Smtp-Source: ADFU+vunVyYR4ZJ9b+N90mK469f5aVbKsbJ0+2p7F8S/fEYY69bfnfYHRHeTbh1k1yneIp8dTA9wYEciK54+eTRNOac=
X-Received: by 2002:ab0:630b:: with SMTP id a11mr336207uap.133.1583547237295; 
 Fri, 06 Mar 2020 18:13:57 -0800 (PST)
MIME-Version: 1.0
References: <20200229141011.58989-1-root@stephanos.io>
 <CAKmqyKNqdvmGH9RWZptzFhd_wA6-J+kMVN21HYDL-PJcnoO44w@mail.gmail.com>
 <SLXP216MB0285AA1AA01F1CC2970D121EBDE30@SLXP216MB0285.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SLXP216MB0285AA1AA01F1CC2970D121EBDE30@SLXP216MB0285.KORP216.PROD.OUTLOOK.COM>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Mar 2020 18:13:29 -0800
Message-ID: <CAKmqyKNXr2J_GxT2s=MO5=N7Z7MhA9C1r8=RPehcMgjd7DAbiw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/stm32f405: Add preliminary RCC emulation support
To: Stephanos Ioannidis <root@stephanos.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::943
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
 Alistair Francis <alistair@alistair23.me>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 5, 2020 at 5:06 PM Stephanos Ioannidis <root@stephanos.io> wrot=
e:
>
> > These should at least be numbers (if not macros) instead of binary.
>
> Just wanted to follow the convention that the reference manual uses (it l=
ists the field values in binary).

The one I read was both, in this case I think the binary form is more
complex then just the decimal values.

>
> > Can't you just do (rcc_pllcfgr.pllp + 1) * 2 instead of a switch case?
> > I don't think we need a switch statement here
> > if (rcc_cfgr.hpre) <=3D 8) {
> >   ahb_div =3D 1;
> > } else {
> >   ahb_div =3D (rcc_cfgr.hpre - 7) * 2
> > }
>
> I wanted to be as verbose as possible and leave any optimisation up to th=
e compiler. After all, when reading code, the switch implementation is a di=
rect representation of the value mapping on and is therefore much easier to=
 understand- given that it is not excessively long.

Fair, this one isn't too bad.

>
> > Where does this come from? I can't seem to find it in the RM.
>
> This is an equation representation of the clock tree diagram (refer to th=
e  "Figure 21. Clock tree" from RM0900).
>
> > Shouldn't this be 0x0477 7F33?
>
> No, that is for STM32F42xxx and STM32F43xxx. See "7.3.19 RCC APB2 periphe=
ral clock enabled in low power mode register (RCC_APB2LPENR)" from RM0900.

Ah, I opened the wrong one then.

>
> > Shouldn't this be PLLSAIRDYF?
> > Aren't you missing a PLLSAIRDYIE
>
> No, PLLSAIRDYF and PLLSAIRDYIE are for STM32F42xxx and STM32F43xxx. STM32=
F405 does not have these fields.

Same as above.

Alistair

>
> Stephanos
>
> -----Original Message-----
> From: Alistair Francis <alistair23@gmail.com>
> Sent: Friday, March 6, 2020 4:40 AM
> To: Stephanos Ioannidis <root@stephanos.io>
> Cc: Peter Maydell <peter.maydell@linaro.org>; Alistair Francis <alistair@=
alistair23.me>; open list:All patches CC here <qemu-devel@nongnu.org>; open=
 list:ARM TCG CPUs <qemu-arm@nongnu.org>
> Subject: Re: [PATCH] hw/arm/stm32f405: Add preliminary RCC emulation supp=
ort
>
>  =3D  heOn Sat, Feb 29, 2020 at 6:12 AM Stephanos Ioannidis <root@stephan=
os.io> wrote:
> >
> > The RCC (reset and clock control) is a hardware peripheral reset and
> > clock configuration controller available on the STM32F4xx series
> > devices.
> >
> > This commit adds preliminary support for the RCC peripheral emulation,
> > in order to support proper emulation of the firmware images that use
> > the STM32Cube driver, which configures and validates the RCC registers
> > during system initialisation.
> >
> > In addition, the current STM32F405 SoC implementation does not specify
> > the Cortex-M SysTick clock scaling factor and this causes the QEMU to
> > become unresponsive as soon as the SysTick timer is enabled by the
> > guest. This problem is addressed by configuring the SysTick clock
> > scaling factor from the AHB clock frequency computed using the RCC
> > clock configurations.
> >
> > Signed-off-by: Stephanos Ioannidis <root@stephanos.io>
> > ---
> >  hw/arm/Kconfig                  |   1 +
> >  hw/arm/netduinoplus2.c          |   1 +
> >  hw/arm/stm32f405_soc.c          |  17 +-
> >  hw/misc/Kconfig                 |   3 +
> >  hw/misc/Makefile.objs           |   1 +
> >  hw/misc/stm32f4xx_rcc.c         | 472 ++++++++++++++++++++++++++++++++
> >  hw/misc/trace-events            |   4 +
> >  include/hw/arm/stm32f405_soc.h  |   3 +
> >  include/hw/misc/stm32f4xx_rcc.h | 316 +++++++++++++++++++++
> >  9 files changed, 817 insertions(+), 1 deletion(-)  create mode 100644
> > hw/misc/stm32f4xx_rcc.c  create mode 100644
> > include/hw/misc/stm32f4xx_rcc.h
> >
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig index
> > 3d86691ae0..16442b3c4b 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -314,6 +314,7 @@ config STM32F205_SOC  config STM32F405_SOC
> >      bool
> >      select ARM_V7M
> > +    select STM32F4XX_RCC
> >      select STM32F4XX_SYSCFG
> >      select STM32F4XX_EXTI
> >
> > diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c index
> > e5e247edbe..37d57dafe4 100644
> > --- a/hw/arm/netduinoplus2.c
> > +++ b/hw/arm/netduinoplus2.c
> > @@ -36,6 +36,7 @@ static void netduinoplus2_init(MachineState
> > *machine)
> >
> >      dev =3D qdev_create(NULL, TYPE_STM32F405_SOC);
> >      qdev_prop_set_string(dev, "cpu-type",
> > ARM_CPU_TYPE_NAME("cortex-m4"));
> > +    qdev_prop_set_uint32(dev, "hse-frequency", 25000000);
> >      object_property_set_bool(OBJECT(dev), true, "realized",
> > &error_fatal);
> >
> >      armv7m_load_kernel(ARM_CPU(first_cpu),
> > diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c index
> > 9bcad97853..5abbbc96c0 100644
> > --- a/hw/arm/stm32f405_soc.c
> > +++ b/hw/arm/stm32f405_soc.c
> > @@ -30,6 +30,7 @@
> >  #include "hw/arm/stm32f405_soc.h"
> >  #include "hw/misc/unimp.h"
> >
> > +#define RCC_ADDR                       0x40023800
> >  #define SYSCFG_ADD                     0x40013800
> >  static const uint32_t usart_addr[] =3D { 0x40011000, 0x40004400, 0x400=
04800,
> >                                         0x40004C00, 0x40005000,
> > 0x40011400, @@ -59,6 +60,9 @@ static void stm32f405_soc_initfn(Object *=
obj)
> >      sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m)=
,
> >                            TYPE_ARMV7M);
> >
> > +    sysbus_init_child_obj(obj, "rcc", &s->rcc, sizeof(s->rcc),
> > +                          TYPE_STM32F4XX_RCC);
> > +
> >      sysbus_init_child_obj(obj, "syscfg", &s->syscfg, sizeof(s->syscfg)=
,
> >                            TYPE_STM32F4XX_SYSCFG);
> >
> > @@ -130,6 +134,17 @@ static void stm32f405_soc_realize(DeviceState *dev=
_soc, Error **errp)
> >          return;
> >      }
> >
> > +    /* Reset and clock control */
> > +    dev =3D DEVICE(&s->rcc);
> > +    qdev_prop_set_uint32(dev, "hse-frequency", s->hse_frequency);
> > +    object_property_set_bool(OBJECT(&s->rcc), true, "realized", &err);
> > +    if (err !=3D NULL) {
> > +        error_propagate(errp, err);
> > +        return;
> > +    }
> > +    busdev =3D SYS_BUS_DEVICE(dev);
> > +    sysbus_mmio_map(busdev, 0, RCC_ADDR);
> > +
> >      /* System configuration controller */
> >      dev =3D DEVICE(&s->syscfg);
> >      object_property_set_bool(OBJECT(&s->syscfg), true, "realized",
> > &err); @@ -260,7 +275,6 @@ static void stm32f405_soc_realize(DeviceStat=
e *dev_soc, Error **errp)
> >      create_unimplemented_device("GPIOH",       0x40021C00, 0x400);
> >      create_unimplemented_device("GPIOI",       0x40022000, 0x400);
> >      create_unimplemented_device("CRC",         0x40023000, 0x400);
> > -    create_unimplemented_device("RCC",         0x40023800, 0x400);
> >      create_unimplemented_device("Flash Int",   0x40023C00, 0x400);
> >      create_unimplemented_device("BKPSRAM",     0x40024000, 0x400);
> >      create_unimplemented_device("DMA1",        0x40026000, 0x400);
> > @@ -274,6 +288,7 @@ static void stm32f405_soc_realize(DeviceState
> > *dev_soc, Error **errp)
> >
> >  static Property stm32f405_soc_properties[] =3D {
> >      DEFINE_PROP_STRING("cpu-type", STM32F405State, cpu_type),
> > +    DEFINE_PROP_UINT32("hse-frequency", STM32F405State,
> > + hse_frequency, 0),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig index
> > bdd77d8020..0cb5f2af68 100644
> > --- a/hw/misc/Kconfig
> > +++ b/hw/misc/Kconfig
> > @@ -79,6 +79,9 @@ config IMX
> >      select SSI
> >      select USB_EHCI_SYSBUS
> >
> > +config STM32F4XX_RCC
> > +    bool
> > +
> >  config STM32F2XX_SYSCFG
> >      bool
> >
> > diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs index
> > da993f45b7..58a856c00d 100644
> > --- a/hw/misc/Makefile.objs
> > +++ b/hw/misc/Makefile.objs
> > @@ -58,6 +58,7 @@ common-obj-$(CONFIG_RASPI) +=3D bcm2835_thermal.o
> >  common-obj-$(CONFIG_SLAVIO) +=3D slavio_misc.o
> >  common-obj-$(CONFIG_ZYNQ) +=3D zynq_slcr.o
> >  common-obj-$(CONFIG_ZYNQ) +=3D zynq-xadc.o
> > +common-obj-$(CONFIG_STM32F4XX_RCC) +=3D stm32f4xx_rcc.o
> >  common-obj-$(CONFIG_STM32F2XX_SYSCFG) +=3D stm32f2xx_syscfg.o
> >  common-obj-$(CONFIG_STM32F4XX_SYSCFG) +=3D stm32f4xx_syscfg.o
> >  common-obj-$(CONFIG_STM32F4XX_EXTI) +=3D stm32f4xx_exti.o diff --git
> > a/hw/misc/stm32f4xx_rcc.c b/hw/misc/stm32f4xx_rcc.c new file mode
> > 100644 index 0000000000..297f2430b8
> > --- /dev/null
> > +++ b/hw/misc/stm32f4xx_rcc.c
> > @@ -0,0 +1,472 @@
> > +/*
> > + * STM32F4xx RCC
> > + *
> > + * Copyright (c) 2020 Stephanos Ioannidis <root@stephanos.io>
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> > +obtaining a copy
> > + * of this software and associated documentation files (the
> > +"Software"), to deal
> > + * in the Software without restriction, including without limitation
> > +the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense,
> > +and/or sell
> > + * copies of the Software, and to permit persons to whom the Software
> > +is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be
> > +included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > +EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > +MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> > +SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
> > +OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> > +ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> > +DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/log.h"
> > +#include "trace.h"
> > +#include "hw/irq.h"
> > +#include "hw/qdev-properties.h"
> > +#include "migration/vmstate.h"
> > +#include "hw/misc/stm32f4xx_rcc.h"
> > +#include "hw/timer/armv7m_systick.h"
> > +
> > +#define HSI_FREQ    (16000000)
> > +
> > +static void rcc_update_clock(STM32F4xxRccState *s) {
> > +    uint32_t pll_src, pll_prediv, pll_mult, pll_postdiv, pll_freq;
> > +    uint32_t ahb_div, ahb_freq;
> > +    uint32_t sysclk_freq;
> > +    uint32_t systick_freq;
> > +
> > +    /* Resolve PLL clock source */
> > +    pll_src =3D s->rcc_pllcfgr.pllsrc ? s->hse_frequency : HSI_FREQ;
> > +
> > +    /* Resolve PLL input division factor */
> > +    switch (s->rcc_pllcfgr.pllm) {
> > +    case 0b000010 ... 0b111111:
> > +        pll_prediv =3D s->rcc_pllcfgr.pllm;
> > +        break;
> > +    default:
> > +        qemu_log_mask(
> > +            LOG_GUEST_ERROR,
> > +            "%s: Invalid PLLM\n", __func__);
> > +        return;
> > +    }
> > +
> > +    /* Resolve PLL VCO multiplication factor */
> > +    switch (s->rcc_pllcfgr.plln) {
> > +    case 0b000110010 ... 0b110110000:
>
> These should at least be numbers (if not macros) instead of binary.
>
> > +        pll_mult =3D s->rcc_pllcfgr.plln;
> > +        break;
> > +    default:
> > +        qemu_log_mask(
> > +            LOG_GUEST_ERROR,
> > +            "%s: Invalid PLLN\n", __func__);
> > +        return;
> > +    }
> > +
> > +    /* Resolve PLL output division factor */
> > +    switch (s->rcc_pllcfgr.pllp) {
> > +    case 0b00:
> > +        pll_postdiv =3D 2;
> > +        break;
> > +    case 0b01:
> > +        pll_postdiv =3D 4;
> > +        break;
> > +    case 0b10:
> > +        pll_postdiv =3D 6;
> > +        break;
> > +    case 0b11:
> > +        pll_postdiv =3D 8;
> > +        break;
> > +    }
>
> Can't you just do (rcc_pllcfgr.pllp + 1) * 2 instead of a switch case?
>
> > +
> > +    /* Compute PLL output frequency */
> > +    pll_freq =3D pll_src / pll_prediv * pll_mult / pll_postdiv;
>
> Where does this come from? I can't seem to find it in the RM.
>
> > +
> > +    /* Resolve SYSCLK frequency */
> > +    switch (s->rcc_cfgr.sw) {
> > +    case 0b00: /* High-speed internal oscillator (fixed at 16MHz) */
> > +        sysclk_freq =3D HSI_FREQ;
> > +        break;
> > +    case 0b01: /* High-speed external oscillator */
> > +        sysclk_freq =3D s->hse_frequency;
> > +        break;
> > +    case 0b10: /* PLL */
> > +        sysclk_freq =3D pll_freq;
> > +        break;
> > +    default:
> > +        qemu_log_mask(
> > +            LOG_GUEST_ERROR,
> > +            "%s: Invalid system clock source selected\n", __func__);
> > +        return;
> > +    }
> > +
> > +    /* Resolve AHB prescaler division ratio */
> > +    switch (s->rcc_cfgr.hpre) {
> > +    case 0b0000 ... 0b0111:
> > +        ahb_div =3D 1;
> > +        break;
> > +    case 0b1000:
> > +        ahb_div =3D 2;
> > +        break;
> > +    case 0b1001:
> > +        ahb_div =3D 4;
> > +        break;
> > +    case 0b1010:
> > +        ahb_div =3D 8;
> > +        break;
> > +    case 0b1011:
> > +        ahb_div =3D 16;
> > +        break;
> > +    case 0b1100:
> > +        ahb_div =3D 64;
> > +        break;
> > +    case 0b1101:
> > +        ahb_div =3D 128;
> > +        break;
> > +    case 0b1110:
> > +        ahb_div =3D 256;
> > +        break;
> > +    case 0b1111:
> > +        ahb_div =3D 512;
> > +        break;
> > +    }
>
> I don't think we need a switch statement here
>
> if (rcc_cfgr.hpre) <=3D 8) {
>   ahb_div =3D 1;
> } else {
>   ahb_div =3D (rcc_cfgr.hpre - 7) * 2
> }
>
> > +
> > +    /* Compute AHB frequency */
> > +    ahb_freq =3D sysclk_freq / ahb_div;
> > +
> > +    /* Compute and set Cortex-M SysTick timer clock frequency */
> > +    systick_freq =3D ahb_freq / 8;
> > +    system_clock_scale =3D 1000000000 / systick_freq; }
> > +
> > +static void stm32f4xx_rcc_reset(DeviceState *dev) {
> > +    STM32F4xxRccState *s =3D STM32F4XX_RCC(dev);
> > +
> > +    /* Initialise register values */
> > +    s->rcc_cr.reg =3D 0x00000083;
> > +    s->rcc_pllcfgr.reg =3D 0x24003010;
> > +    s->rcc_cfgr.reg =3D 0x00000000;
> > +    s->rcc_cir.reg =3D 0x00000000;
> > +    s->rcc_ahb1rstr.reg =3D 0x00000000;
> > +    s->rcc_ahb2rstr.reg =3D 0x00000000;
> > +    s->rcc_ahb3rstr.reg =3D 0x00000000;
> > +    s->rcc_apb1rstr.reg =3D 0x00000000;
> > +    s->rcc_apb2rstr.reg =3D 0x00000000;
> > +    s->rcc_ahb1enr.reg =3D 0x00100000;
> > +    s->rcc_ahb2enr.reg =3D 0x00000000;
> > +    s->rcc_ahb3enr.reg =3D 0x00000000;
> > +    s->rcc_apb1enr.reg =3D 0x00000000;
> > +    s->rcc_apb2enr.reg =3D 0x00000000;
> > +    s->rcc_ahb1lpenr.reg =3D 0x7E6791FF;
> > +    s->rcc_ahb2lpenr.reg =3D 0x000000F1;
> > +    s->rcc_ahb3lpenr.reg =3D 0x00000001;
> > +    s->rcc_apb1lpenr.reg =3D 0x36FEC9FF;
> > +    s->rcc_apb2lpenr.reg =3D 0x00075F33;
>
> Shouldn't this be 0x0477 7F33?
>
> > +    s->rcc_bdcr.reg =3D 0x00000000;
> > +    s->rcc_csr.reg =3D 0x0E000000;
> > +    s->rcc_sscgr.reg =3D 0x00000000;
> > +    s->rcc_plli2scfgr.reg =3D 0x20003000;
> > +
> > +    /* Update clock based on the reset state */
> > +    rcc_update_clock(s);
> > +}
> > +
> > +static void rcc_cr_write(STM32F4xxRccState *s, RccCrType val) {
> > +    /* Set internal high-speed clock state */
> > +    s->rcc_cr.hsirdy =3D s->rcc_cr.hsion =3D val.hsion;
> > +    /* Set external high-speed clock state */
> > +    s->rcc_cr.hserdy =3D s->rcc_cr.hseon =3D val.hseon;
> > +    /* Set external clock bypass state */
> > +    s->rcc_cr.hsebyp =3D s->rcc_cr.hserdy && val.hsebyp;
> > +    /* Set PLL state */
> > +    s->rcc_cr.pllrdy =3D s->rcc_cr.pllon =3D val.pllon;
> > +    /* Set I2S PLL state */
> > +    s->rcc_cr.plli2srdy =3D s->rcc_cr.plli2son =3D val.plli2son;
> > +
> > +    /* Update clock */
> > +    rcc_update_clock(s);
> > +}
> > +
> > +static void rcc_pllcfgr_write(STM32F4xxRccState *s, RccPllcfgrType
> > +val) {
> > +    /* Set PLL entry clock source */
> > +    s->rcc_pllcfgr.pllsrc =3D val.pllsrc;
> > +    /* Set main PLL input division factor */
> > +    s->rcc_pllcfgr.pllm =3D val.pllm;
> > +    /* Set main PLL multiplication factor for VCO */
> > +    s->rcc_pllcfgr.plln =3D val.plln;
> > +    /* Set main PLL output division factor */
> > +    s->rcc_pllcfgr.pllp =3D val.pllp;
> > +
> > +    /* Update clock */
> > +    rcc_update_clock(s);
> > +}
> > +
> > +static void rcc_cfgr_write(STM32F4xxRccState *s, RccCfgrType val) {
> > +    /* Set clock switch status */
> > +    s->rcc_cfgr.sw =3D s->rcc_cfgr.sws =3D val.sw;
> > +    /* Set AHB prescaler clock division factor */
> > +    s->rcc_cfgr.hpre =3D val.hpre;
> > +
> > +    /* Update clock */
> > +    rcc_update_clock(s);
> > +}
> > +
> > +static void rcc_csr_write(STM32F4xxRccState *s, RccCsrType val) {
> > +    /* Set internal low-speed oscillator state */
> > +    s->rcc_csr.lsirdy =3D s->rcc_csr.lsion =3D val.lsion;
> > +
> > +    /* Update clock */
> > +    rcc_update_clock(s);
> > +}
> > +
> > +static uint64_t stm32f4xx_rcc_read(void *opaque, hwaddr addr,
> > +                                     unsigned int size) {
> > +    STM32F4xxRccState *s =3D opaque;
> > +
> > +    trace_stm32f4xx_rcc_read(addr);
> > +
> > +    switch (addr) {
> > +    case RCC_CR:
> > +        return s->rcc_cr.reg;
> > +    case RCC_PLLCFGR:
> > +        return s->rcc_pllcfgr.reg;
> > +    case RCC_CFGR:
> > +        return s->rcc_cfgr.reg;
> > +    case RCC_CIR:
> > +        qemu_log_mask(
> > +            LOG_UNIMP,
> > +            "%s: Clock interrupt configuration is not supported in QEM=
U\n",
> > +            __func__);
> > +        return s->rcc_cir.reg;
> > +    case RCC_AHB1RSTR:
> > +        return s->rcc_ahb1rstr.reg;
> > +    case RCC_AHB2RSTR:
> > +        return s->rcc_ahb2rstr.reg;
> > +    case RCC_AHB3RSTR:
> > +        return s->rcc_ahb3rstr.reg;
> > +    case RCC_APB1RSTR:
> > +        return s->rcc_apb1rstr.reg;
> > +    case RCC_APB2RSTR:
> > +        return s->rcc_apb2rstr.reg;
> > +    case RCC_AHB1ENR:
> > +        return s->rcc_ahb1enr.reg;
> > +    case RCC_AHB2ENR:
> > +        return s->rcc_ahb2enr.reg;
> > +    case RCC_AHB3ENR:
> > +        return s->rcc_ahb3enr.reg;
> > +    case RCC_APB1ENR:
> > +        return s->rcc_apb1enr.reg;
> > +    case RCC_APB2ENR:
> > +        return s->rcc_apb2enr.reg;
> > +    case RCC_AHB1LPENR:
> > +        return s->rcc_ahb1lpenr.reg;
> > +    case RCC_AHB2LPENR:
> > +        return s->rcc_ahb2lpenr.reg;
> > +    case RCC_AHB3LPENR:
> > +        return s->rcc_ahb3lpenr.reg;
> > +    case RCC_APB1LPENR:
> > +        return s->rcc_apb1lpenr.reg;
> > +    case RCC_APB2LPENR:
> > +        return s->rcc_apb2lpenr.reg;
> > +    case RCC_BDCR:
> > +        qemu_log_mask(
> > +            LOG_UNIMP,
> > +            "%s: Backup domain control is not supported in QEMU\n",
> > +            __func__);
> > +        return s->rcc_bdcr.reg;
> > +    case RCC_CSR:
> > +        return s->rcc_csr.reg;
> > +    case RCC_SSCGR:
> > +        qemu_log_mask(
> > +            LOG_UNIMP,
> > +            "%s: Spread spectrum clock generation is not supported in =
QEMU\n",
> > +            __func__);
> > +        return s->rcc_sscgr.reg;
> > +    case RCC_PLLI2SCFGR:
> > +        qemu_log_mask(
> > +            LOG_UNIMP,
> > +            "%s: PLLI2S configuration is not supported in QEMU\n",
> > +            __func__);
> > +        return s->rcc_plli2scfgr.reg;
> > +    default:
> > +        qemu_log_mask(
> > +            LOG_GUEST_ERROR,
> > +            "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
> > +        return 0;
> > +    }
> > +}
> > +
> > +static void stm32f4xx_rcc_write(void *opaque, hwaddr addr,
> > +                       uint64_t val64, unsigned int size) {
> > +    STM32F4xxRccState *s =3D opaque;
> > +    uint32_t value =3D val64;
> > +
> > +    trace_stm32f4xx_rcc_write(value, addr);
> > +
> > +    switch (addr) {
> > +    case RCC_CR:
> > +        rcc_cr_write(s, (RccCrType)value);
> > +        return;
> > +    case RCC_PLLCFGR:
> > +        rcc_pllcfgr_write(s, (RccPllcfgrType)value);
> > +        return;
> > +    case RCC_CFGR:
> > +        rcc_cfgr_write(s, (RccCfgrType)value);
> > +        return;
> > +    case RCC_CIR:
> > +        qemu_log_mask(
> > +            LOG_UNIMP,
> > +            "%s: Clock interrupt configuration is not supported in QEM=
U\n",
> > +            __func__);
> > +        return;
> > +    case RCC_AHB1RSTR ... RCC_APB2RSTR:
> > +        qemu_log_mask(
> > +            LOG_UNIMP,
> > +            "%s: Peripheral reset is a no-op in QEMU\n", __func__);
> > +        return;
> > +    case RCC_AHB1ENR:
> > +        /* Store peripheral enable status; otherwise, this is no-op */
> > +        s->rcc_ahb1enr.reg =3D value;
> > +        return;
> > +    case RCC_AHB2ENR:
> > +        s->rcc_ahb2enr.reg =3D value;
> > +        return;
> > +    case RCC_AHB3ENR:
> > +        s->rcc_ahb3enr.reg =3D value;
> > +        return;
> > +    case RCC_APB1ENR:
> > +        s->rcc_apb1enr.reg =3D value;
> > +        return;
> > +    case RCC_APB2ENR:
> > +        s->rcc_apb2enr.reg =3D value;
> > +        return;
> > +    case RCC_AHB1LPENR:
> > +        /* Store peripheral low power status; otherwise, this is no-op=
 */
> > +        s->rcc_ahb1lpenr.reg =3D value;
> > +        return;
> > +    case RCC_AHB2LPENR:
> > +        s->rcc_ahb2lpenr.reg =3D value;
> > +        return;
> > +    case RCC_AHB3LPENR:
> > +        s->rcc_ahb3lpenr.reg =3D value;
> > +        return;
> > +    case RCC_APB1LPENR:
> > +        s->rcc_apb1lpenr.reg =3D value;
> > +        return;
> > +    case RCC_APB2LPENR:
> > +        s->rcc_apb2lpenr.reg =3D value;
> > +        return;
> > +    case RCC_BDCR:
> > +        qemu_log_mask(
> > +            LOG_UNIMP,
> > +            "%s: Backup domain control is not supported in QEMU\n",
> > +            __func__);
> > +        return;
> > +    case RCC_CSR:
> > +        rcc_csr_write(s, (RccCsrType)value);
> > +        return;
> > +    case RCC_SSCGR:
> > +        qemu_log_mask(
> > +            LOG_UNIMP,
> > +            "%s: Spread spectrum clock generation is not supported in =
QEMU\n",
> > +            __func__);
> > +        return;
> > +    case RCC_PLLI2SCFGR:
> > +        qemu_log_mask(
> > +            LOG_UNIMP,
> > +            "%s: PLLI2S configuration is not supported in QEMU\n",
> > +            __func__);
> > +        return;
> > +    default:
> > +        qemu_log_mask(
> > +            LOG_GUEST_ERROR,
> > +            "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps stm32f4xx_rcc_ops =3D {
> > +    .read =3D stm32f4xx_rcc_read,
> > +    .write =3D stm32f4xx_rcc_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN, };
> > +
> > +static void stm32f4xx_rcc_init(Object *obj) {
> > +    STM32F4xxRccState *s =3D STM32F4XX_RCC(obj);
> > +
> > +    memory_region_init_io(&s->mmio, obj, &stm32f4xx_rcc_ops, s,
> > +                          TYPE_STM32F4XX_RCC, 0x400);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio); }
> > +
> > +static const VMStateDescription vmstate_stm32f4xx_rcc =3D {
> > +    .name =3D TYPE_STM32F4XX_RCC,
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT32(rcc_cr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_pllcfgr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_cfgr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_cir.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_ahb1rstr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_ahb2rstr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_ahb3rstr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_apb1rstr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_apb2rstr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_ahb1enr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_ahb2enr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_ahb3enr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_apb1enr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_apb2enr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_ahb1lpenr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_ahb2lpenr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_ahb3lpenr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_apb1lpenr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_apb2lpenr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_bdcr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_csr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_sscgr.reg, STM32F4xxRccState),
> > +        VMSTATE_UINT32(rcc_plli2scfgr.reg, STM32F4xxRccState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static Property stm32f4xx_rcc_properties[] =3D {
> > +    DEFINE_PROP_UINT32("hse-frequency", STM32F4xxRccState, hse_frequen=
cy, 0),
> > +    DEFINE_PROP_END_OF_LIST()
> > +};
> > +
> > +static void stm32f4xx_rcc_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->reset =3D stm32f4xx_rcc_reset;
> > +    dc->vmsd =3D &vmstate_stm32f4xx_rcc;
> > +    device_class_set_props(dc, stm32f4xx_rcc_properties); }
> > +
> > +static const TypeInfo stm32f4xx_rcc_info =3D {
> > +    .name          =3D TYPE_STM32F4XX_RCC,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(STM32F4xxRccState),
> > +    .instance_init =3D stm32f4xx_rcc_init,
> > +    .class_init    =3D stm32f4xx_rcc_class_init,
> > +};
> > +
> > +static void stm32f4xx_rcc_register_types(void)
> > +{
> > +    type_register_static(&stm32f4xx_rcc_info);
> > +}
> > +
> > +type_init(stm32f4xx_rcc_register_types)
> > diff --git a/hw/misc/trace-events b/hw/misc/trace-events index
> > 7f0f5dff3a..0fa47598b5 100644
> > --- a/hw/misc/trace-events
> > +++ b/hw/misc/trace-events
> > @@ -84,6 +84,10 @@ mos6522_set_sr_int(void) "set sr_int"
> >  mos6522_write(uint64_t addr, uint64_t val) "reg=3D0x%"PRIx64 "
> > val=3D0x%"PRIx64  mos6522_read(uint64_t addr, unsigned val) "reg=3D0x%"=
PRIx64 " val=3D0x%x"
> >
> > +# stm32f4xx_rcc
> > +stm32f4xx_rcc_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
> > +stm32f4xx_rcc_write(uint64_t addr, uint64_t data) "reg write: addr: 0x=
%" PRIx64 " val: 0x%" PRIx64 ""
> > +
> >  # stm32f4xx_syscfg
> >  stm32f4xx_syscfg_set_irq(int gpio, int line, int level) "Interupt: GPI=
O: %d, Line: %d; Level: %d"
> >  stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
> > diff --git a/include/hw/arm/stm32f405_soc.h
> > b/include/hw/arm/stm32f405_soc.h index 1fe97f8c3a..037db62a58 100644
> > --- a/include/hw/arm/stm32f405_soc.h
> > +++ b/include/hw/arm/stm32f405_soc.h
> > @@ -25,6 +25,7 @@
> >  #ifndef HW_ARM_STM32F405_SOC_H
> >  #define HW_ARM_STM32F405_SOC_H
> >
> > +#include "hw/misc/stm32f4xx_rcc.h"
> >  #include "hw/misc/stm32f4xx_syscfg.h"
> >  #include "hw/timer/stm32f2xx_timer.h"
> >  #include "hw/char/stm32f2xx_usart.h"
> > @@ -54,9 +55,11 @@ typedef struct STM32F405State {
> >      /*< public >*/
> >
> >      char *cpu_type;
> > +    uint32_t hse_frequency;
> >
> >      ARMv7MState armv7m;
> >
> > +    STM32F4xxRccState rcc;
> >      STM32F4xxSyscfgState syscfg;
> >      STM32F4xxExtiState exti;
> >      STM32F2XXUsartState usart[STM_NUM_USARTS]; diff --git
> > a/include/hw/misc/stm32f4xx_rcc.h b/include/hw/misc/stm32f4xx_rcc.h
> > new file mode 100644 index 0000000000..5c269753c0
> > --- /dev/null
> > +++ b/include/hw/misc/stm32f4xx_rcc.h
> > @@ -0,0 +1,316 @@
> > +/*
> > + * STM32F4xx RCC
> > + *
> > + * Copyright (c) 2020 Stephanos Ioannidis <root@stephanos.io>
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> > +obtaining a copy
> > + * of this software and associated documentation files (the
> > +"Software"), to deal
> > + * in the Software without restriction, including without limitation
> > +the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense,
> > +and/or sell
> > + * copies of the Software, and to permit persons to whom the Software
> > +is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be
> > +included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > +EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > +MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> > +SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
> > +OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> > +ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> > +DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#ifndef HW_STM_RCC_H
> > +#define HW_STM_RCC_H
> > +
> > +#include "hw/sysbus.h"
> > +#include "hw/hw.h"
> > +
> > +#define TYPE_STM32F4XX_RCC "stm32f4xx-rcc"
> > +#define STM32F4XX_RCC(obj) \
> > +    OBJECT_CHECK(STM32F4xxRccState, (obj), TYPE_STM32F4XX_RCC)
> > +
> > +#define RCC_CR         0x00
> > +#define RCC_PLLCFGR    0x04
> > +#define RCC_CFGR       0x08
> > +#define RCC_CIR        0x0C
> > +#define RCC_AHB1RSTR   0x10
> > +#define RCC_AHB2RSTR   0x14
> > +#define RCC_AHB3RSTR   0x18
> > +#define RCC_APB1RSTR   0x20
> > +#define RCC_APB2RSTR   0x24
> > +#define RCC_AHB1ENR    0x30
> > +#define RCC_AHB2ENR    0x34
> > +#define RCC_AHB3ENR    0x38
> > +#define RCC_APB1ENR    0x40
> > +#define RCC_APB2ENR    0x44
> > +#define RCC_AHB1LPENR  0x50
> > +#define RCC_AHB2LPENR  0x54
> > +#define RCC_AHB3LPENR  0x58
> > +#define RCC_APB1LPENR  0x60
> > +#define RCC_APB2LPENR  0x64
> > +#define RCC_BDCR       0x70
> > +#define RCC_CSR        0x74
> > +#define RCC_SSCGR      0x80
> > +#define RCC_PLLI2SCFGR 0x84
> > +
> > +typedef union {
> > +    struct {
> > +        uint32_t hsion : 1;
> > +        uint32_t hsirdy : 1;
> > +        uint32_t reserved0 : 1;
> > +        uint32_t hsitrim : 5;
> > +        uint32_t hsical : 8;
> > +        uint32_t hseon : 1;
> > +        uint32_t hserdy : 1;
> > +        uint32_t hsebyp : 1;
> > +        uint32_t csson : 1;
> > +        uint32_t reserved1 : 4;
> > +        uint32_t pllon : 1;
> > +        uint32_t pllrdy : 1;
> > +        uint32_t plli2son : 1;
> > +        uint32_t plli2srdy : 1;
> > +        uint32_t reserved2 : 4;
> > +    };
> > +    uint32_t reg;
> > +} RccCrType;
> > +
> > +typedef union {
> > +    struct {
> > +        uint32_t pllm : 6;
> > +        uint32_t plln : 9;
> > +        uint32_t reserved0 : 1;
> > +        uint32_t pllp : 2;
> > +        uint32_t reserved1 : 4;
> > +        uint32_t pllsrc : 1;
> > +        uint32_t reserved2 : 1;
> > +        uint32_t pllq : 4;
> re?> +        uint32_t reserved3 : 4;
> > +    };
> > +    uint32_t reg;
> > +} RccPllcfgrType;
> > +
> > +typedef union {
> > +    struct {
> > +        uint32_t sw : 2;
> > +        uint32_t sws : 2;
> > +        uint32_t hpre : 4;
> > +        uint32_t reserved0 : 2;
> > +        uint32_t ppre1 : 3;
> > +        uint32_t ppre2: 3;
> > +        uint32_t rtcpre : 5;
> > +        uint32_t mco1 : 2;
> > +        uint32_t i2sscr : 1;
> > +        uint32_t mco1pre : 3;
> > +        uint32_t mco2pre : 3;
> > +        uint32_t mco2 : 2;
> > +    };
> > +    uint32_t reg;
> > +} RccCfgrType;
> > +
> > +typedef union {
> > +    struct {
> > +        uint32_t lsirdyf : 1;
> > +        uint32_t lserdyf : 1;
> > +        uint32_t hsirdyf : 1;
> > +        uint32_t hserdyf : 1;
> > +        uint32_t pllrdyf : 1;
> > +        uint32_t plli2srdyf : 1;
> > +        uint32_t reserved0 : 1;
>
> Shouldn't this be PLLSAIRDYF?
>
> > +        uint32_t cssf : 1;
> > +        uint32_t lsirdyie : 1;
> > +        uint32_t lserdyie : 1;
> > +        uint32_t hsirdyie : 1;
> > +        uint32_t hserdyie : 1;
> > +        uint32_t pllrdyie : 1;
> > +        uint32_t plli2srdyie : 1;
>
> Aren't you missing a PLLSAIRDYIE
>
> Alistair
>
> > +        uint32_t reserved1 : 2;
> > +        uint32_t lsirdyc : 1;
> > +        uint32_t lserdyc : 1;
> > +        uint32_t hsirdyc : 1;
> > +        uint32_t hserdyc : 1;
> > +        uint32_t pllrdyc : 1;
> > +        uint32_t plli2srdyc : 1;
> > +        uint32_t reserved2 : 1;
> > +        uint32_t cssc : 1;
> > +        uint32_t reserved3 : 8;
> > +    };
> > +    uint32_t reg;
> > +} RccCirType;
> > +
> > +typedef struct {
> > +    /* Fields are not specified */
> > +    uint32_t reg;
> > +} RccAhb1rstrType;
> > +
> > +typedef struct {
> > +    /* Fields are not specified */
> > +    uint32_t reg;
> > +} RccAhb2rstrType;
> > +
> > +typedef struct {
> > +    /* Fields are not specified */
> > +    uint32_t reg;
> > +} RccAhb3rstrType;
> > +
> > +typedef struct {
> > +    /* Fields are not specified */
> > +    uint32_t reg;
> > +} RccApb1rstrType;
> > +
> > +typedef struct {
> > +    /* Fields are not specified */
> > +    uint32_t reg;
> > +} RccApb2rstrType;
> > +
> > +typedef struct {
> > +    /* Fields are not specified */
> > +    uint32_t reg;
> > +} RccAhb1enrType;
> > +
> > +typedef struct {
> > +    /* Fields are not specified */
> > +    uint32_t reg;
> > +} RccAhb2enrType;
> > +
> > +typedef struct {
> > +    /* Fields are not specified */
> > +    uint32_t reg;
> > +} RccAhb3enrType;
> > +
> > +typedef struct {
> > +    /* Fields are not specified */
> > +    uint32_t reg;
> > +} RccApb1enrType;
> > +
> > +typedef struct {
> > +    /* Fields are not specified */
> > +    uint32_t reg;
> > +} RccApb2enrType;
> > +
> > +typedef struct {
> > +    /* Fields are not specified */
> > +    uint32_t reg;
> > +} RccAhb1lpenrType;
> > +
> > +typedef struct {
> > +    /* Fields are not specified */
> > +    uint32_t reg;
> > +} RccAhb2lpenrType;
> > +
> > +typedef struct {
> > +    /* Fields are not specified */
> > +    uint32_t reg;
> > +} RccAhb3lpenrType;
> > +
> > +typedef struct {
> > +    /* Fields are not specified */
> > +    uint32_t reg;
> > +} RccApb1lpenrType;
> > +
> > +typedef struct {
> > +    /* Fields are not specified */
> > +    uint32_t reg;
> > +} RccApb2lpenrType;
> > +
> > +typedef union {
> > +    struct {
> > +        uint32_t lseon : 1;
> > +        uint32_t lserdy : 1;
> > +        uint32_t lsebyp : 1;
> > +        uint32_t reserved0 : 5;
> > +        uint32_t rtcsel : 2;
> > +        uint32_t reserved1 : 5;
> > +        uint32_t rtcen : 1;
> > +        uint32_t bdrst : 1;
> > +        uint32_t reserved2 : 15;
> > +    };
> > +    uint32_t reg;
> > +} RccBdcrType;
> > +
> > +typedef union {
> > +    struct {
> > +        uint32_t lsion : 1;
> > +        uint32_t lsirdy : 1;
> > +        uint32_t reserved0 : 22;
> > +        uint32_t rmvf : 1;
> > +        uint32_t borrstf : 1;
> > +        uint32_t pinrstf : 1;
> > +        uint32_t porrstf : 1;
> > +        uint32_t sftrstf : 1;
> > +        uint32_t iwdgrstf : 1;
> > +        uint32_t wwdgrstf : 1;
> > +        uint32_t lpwrrstf : 1;
> > +    };
> > +    uint32_t reg;
> > +} RccCsrType;
> > +
> > +typedef struct {
> > +    /* Fields are not specified */
> > +    uint32_t reg;
> > +} RccSscgrType;
> > +
> > +typedef struct {
> > +    /* Fields are not specified */
> > +    uint32_t reg;
> > +} RccPlli2scfgrType;
> > +
> > +typedef struct {
> > +    /* <private> */
> > +    SysBusDevice parent_obj;
> > +
> > +    /* <public> */
> > +    MemoryRegion mmio;
> > +    uint32_t hse_frequency;
> > +
> > +    /* Clock control register (RCC_CR) */
> > +    RccCrType rcc_cr;
> > +    /* PLL configuration register (RCC_PLLCFGR) */
> > +    RccPllcfgrType rcc_pllcfgr;
> > +    /* Clock configuration register (RCC_CFGR) */
> > +    RccCfgrType rcc_cfgr;
> > +    /* Clock interrupt register (RCC_CIR) */
> > +    RccCirType rcc_cir;
> > +    /* AHB1 peripheral reset register (RCC_AHB1RSTR) */
> > +    RccAhb1rstrType rcc_ahb1rstr;
> > +    /* AHB2 peripheral reset register (RCC_AHB2RSTR) */
> > +    RccAhb2rstrType rcc_ahb2rstr;
> > +    /* AHB3 peripheral reset register (RCC_AHB3RSTR) */
> > +    RccAhb3rstrType rcc_ahb3rstr;
> > +    /* APB1 peripheral reset register (RCC_APB1RSTR) */
> > +    RccApb1rstrType rcc_apb1rstr;
> > +    /* APB2 peripheral reset register (RCC_APB2RSTR) */
> > +    RccApb2rstrType rcc_apb2rstr;
> > +    /* AHB1 peripheral clock register (RCC_AHB1ENR) */
> > +    RccAhb1enrType rcc_ahb1enr;
> > +    /* AHB2 peripheral clock register (RCC_AHB2ENR) */
> > +    RccAhb2enrType rcc_ahb2enr;
> > +    /* AHB3 peripheral clock register (RCC_AHB3ENR) */
> > +    RccAhb3enrType rcc_ahb3enr;
> > +    /* APB1 peripheral clock register (RCC_APB1ENR) */
> > +    RccApb1enrType rcc_apb1enr;
> > +    /* APB2 peripheral clock register (RCC_APB1ENR) */
> > +    RccApb2enrType rcc_apb2enr;
> > +    /* AHB1 peripheral low power mode register (RCC_AHB1LPENR) */
> > +    RccAhb1lpenrType rcc_ahb1lpenr;
> > +    /* AHB2 peripheral low power mode register (RCC_AHB2LPENR) */
> > +    RccAhb2lpenrType rcc_ahb2lpenr;
> > +    /* AHB3 peripheral low power mode register (RCC_AHB3LPENR) */
> > +    RccAhb3lpenrType rcc_ahb3lpenr;
> > +    /* APB1 peripheral low power mode register (RCC_APB1LPENR) */
> > +    RccApb1lpenrType rcc_apb1lpenr;
> > +    /* APB2 peripheral low power mode register (RCC_APB2LPENR) */
> > +    RccApb2lpenrType rcc_apb2lpenr;
> > +    /* Backup domain control register (RCC_BDCR) */
> > +    RccBdcrType rcc_bdcr;
> > +    /* Clock control and status register (RCC_CSR) */
> > +    RccCsrType rcc_csr;
> > +    /* Spread spectrum clock generation register (RCC_SSCGR) */
> > +    RccSscgrType rcc_sscgr;
> > +    /* PLLI2S configuration register (RCC_PLLI2SCFGR) */
> > +    RccPlli2scfgrType rcc_plli2scfgr; } STM32F4xxRccState;
> > +
> > +#endif
> > --
> > 2.17.1
> >
> >

