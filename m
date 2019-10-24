Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F128CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37CC520659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJCZ3r2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CC520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhBh-0005Cr-OS
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <atar4qemu@gmail.com>) id 1iNgBM-0007lX-2y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <atar4qemu@gmail.com>) id 1iNgBK-0006G5-BB
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:41:51 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:44906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <atar4qemu@gmail.com>)
 id 1iNgBK-0006G1-6U; Thu, 24 Oct 2019 12:41:50 -0400
Received: by mail-il1-x143.google.com with SMTP id f13so22993137ils.11;
 Thu, 24 Oct 2019 09:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hiXL+/soybWGri/7EPs9zL/lpCAg9l5tF8Rc0DYMON4=;
 b=eJCZ3r2AzuVDtK5IoUajpkUvWoHciQCIB/3rDD/hxj8mXqNKryjbbiZSK8rnYOZ5Lm
 oK7CVUUDFW9IGb3ROLoeNalhDQ7AwuY8A7HkxxaTglp2Rf9SrhjMS4whtrEGIVPuxbN1
 Oct1n2jyVW+FzjO9bR6bry2UpbauMck0la/Kcw2AB5CC9j1qHpsdBEyi2up9TqxibqUE
 /XFVGQ+nW85wJRZQQOOuijSzedU/gdb9tn4u1iJRXJz2jTE0aj8nsVPAD8OfvTzWBb3T
 V6nSMnCazkMZ74EFo98cugOTrOAO0/xMlA2cyo1X2IJmD5uV+bKuQZ4Mgc6CZe4q6n3u
 mXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hiXL+/soybWGri/7EPs9zL/lpCAg9l5tF8Rc0DYMON4=;
 b=PS33VAgNQT8KDdSz8F92n/8gfk0freIjYzxlG7JTFe0ACWv2G4SSfc+oZVXy/yrf9Y
 h2Uh0tuyFB42mnnnwqbj1eRoMc4AGwiAeZo/CFQhY1zyHWIDcUKEIf4F9XaL+8V31uax
 9fB7JQ+UqgS+48lonxyS8Q4PNkzlZ1SYjd7Ag8aD8YvyqvW4KZ3z8spG9QmjPD1vkXbd
 6Vlw+yJqZtj2tq5ByW4mgH22ofy90984aVNKVZBggyV9wjAVGcPbmlzZkS30btdPRCM9
 dXQLxyzkwaq//DHU+WSDqi6qWkiBbQOPwNTuqG//KDww88Zms2cPnXv2A5LMeTSgkz27
 tV5Q==
X-Gm-Message-State: APjAAAUKLJmBKfJsBEUvpTI+gox8nD3yyzwRUXOtpS3vc1mh4Hk5x7ba
 76FS14dYuL+juu6eHuHCiKTThRDixBlSsrgJog4=
X-Google-Smtp-Source: APXvYqxqRHZiQkjVU1sR2xZTP6b6UR8Msgn9UOXGLe1U43COY4fq7PVnsUY2yJ5J4jrd/OeGvBahJzf0p9z/tPVXFbA=
X-Received: by 2002:a92:1907:: with SMTP id 7mr32472402ilz.72.1571935309302;
 Thu, 24 Oct 2019 09:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191003230404.19384-1-philmd@redhat.com>
 <20191003230404.19384-7-philmd@redhat.com>
 <b1131c3d-d421-6130-b113-faa5e19c42a8@redhat.com>
In-Reply-To: <b1131c3d-d421-6130-b113-faa5e19c42a8@redhat.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Thu, 24 Oct 2019 18:41:37 +0200
Message-ID: <CACXAS8AF=SBvXnvUtLKo2Q+=79fMWctwJhevYez2paOGJxY=4Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] hw: Move sun4v hypervisor RTC from hw/timer/ to
 hw/rtc/ subdirectory
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::143
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ARM" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-trivial@nongnu.org,
 "open list:PReP" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 4:10 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Artyom,
>
> Do you mind Acking this patch?

Sorry for the late reply:

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

>
> On 10/4/19 1:03 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Move RTC devices under the hw/rtc/ subdirectory.
> >
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >   MAINTAINERS                   |  4 ++--
> >   hw/rtc/Kconfig                |  3 +++
> >   hw/rtc/Makefile.objs          |  1 +
> >   hw/{timer =3D> rtc}/sun4v-rtc.c |  2 +-
> >   hw/rtc/trace-events           |  4 ++++
> >   hw/sparc64/niagara.c          |  2 +-
> >   hw/timer/Kconfig              |  3 ---
> >   hw/timer/Makefile.objs        |  1 -
> >   hw/timer/trace-events         |  4 ----
> >   include/hw/rtc/sun4v-rtc.h    | 19 +++++++++++++++++++
> >   include/hw/timer/sun4v-rtc.h  |  1 -
> >   11 files changed, 31 insertions(+), 13 deletions(-)
> >   rename hw/{timer =3D> rtc}/sun4v-rtc.c (98%)
> >   create mode 100644 include/hw/rtc/sun4v-rtc.h
> >   delete mode 100644 include/hw/timer/sun4v-rtc.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0dfaa05d17..31e4fbf579 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1165,8 +1165,8 @@ Sun4v
> >   M: Artyom Tarasenko <atar4qemu@gmail.com>
> >   S: Maintained
> >   F: hw/sparc64/niagara.c
> > -F: hw/timer/sun4v-rtc.c
> > -F: include/hw/timer/sun4v-rtc.h
> > +F: hw/rtc/sun4v-rtc.c
> > +F: include/hw/rtc/sun4v-rtc.h
> >
> >   Leon3
> >   M: Fabien Chouteau <chouteau@adacore.com>
> > diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> > index 434b20b2b1..cc7fead764 100644
> > --- a/hw/rtc/Kconfig
> > +++ b/hw/rtc/Kconfig
> > @@ -10,3 +10,6 @@ config PL031
> >
> >   config MC146818RTC
> >       bool
> > +
> > +config SUN4V_RTC
> > +    bool
> > diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> > index 89e8e48c64..4621b37bc2 100644
> > --- a/hw/rtc/Makefile.objs
> > +++ b/hw/rtc/Makefile.objs
> > @@ -5,3 +5,4 @@ common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
> >   endif
> >   common-obj-$(CONFIG_PL031) +=3D pl031.o
> >   obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
> > +common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
> > diff --git a/hw/timer/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
> > similarity index 98%
> > rename from hw/timer/sun4v-rtc.c
> > rename to hw/rtc/sun4v-rtc.c
> > index 54272a822f..ada01b5774 100644
> > --- a/hw/timer/sun4v-rtc.c
> > +++ b/hw/rtc/sun4v-rtc.c
> > @@ -13,7 +13,7 @@
> >   #include "hw/sysbus.h"
> >   #include "qemu/module.h"
> >   #include "qemu/timer.h"
> > -#include "hw/timer/sun4v-rtc.h"
> > +#include "hw/rtc/sun4v-rtc.h"
> >   #include "trace.h"
> >
> >
> > diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
> > index 54c94ac557..ac9e0e0fba 100644
> > --- a/hw/rtc/trace-events
> > +++ b/hw/rtc/trace-events
> > @@ -1,5 +1,9 @@
> >   # See docs/devel/tracing.txt for syntax documentation.
> >
> > +# sun4v-rtc.c
> > +sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 =
" value 0x%" PRIx64
> > +sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx6=
4 " value 0x%" PRIx64
> > +
> >   # pl031.c
> >   pl031_irq_state(int level) "irq state %d"
> >   pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
> > diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> > index 167143bffe..dfa0817eae 100644
> > --- a/hw/sparc64/niagara.c
> > +++ b/hw/sparc64/niagara.c
> > @@ -30,7 +30,7 @@
> >   #include "hw/misc/unimp.h"
> >   #include "hw/loader.h"
> >   #include "hw/sparc/sparc64.h"
> > -#include "hw/timer/sun4v-rtc.h"
> > +#include "hw/rtc/sun4v-rtc.h"
> >   #include "exec/address-spaces.h"
> >   #include "sysemu/block-backend.h"
> >   #include "qemu/error-report.h"
> > diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> > index a6b668b255..b04c928136 100644
> > --- a/hw/timer/Kconfig
> > +++ b/hw/timer/Kconfig
> > @@ -35,9 +35,6 @@ config ALLWINNER_A10_PIT
> >   config STM32F2XX_TIMER
> >       bool
> >
> > -config SUN4V_RTC
> > -    bool
> > -
> >   config CMSDK_APB_TIMER
> >       bool
> >       select PTIMER
> > diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> > index 2fb12162a6..034bd30255 100644
> > --- a/hw/timer/Makefile.objs
> > +++ b/hw/timer/Makefile.objs
> > @@ -35,7 +35,6 @@ common-obj-$(CONFIG_ALLWINNER_A10_PIT) +=3D allwinner=
-a10-pit.o
> >   common-obj-$(CONFIG_STM32F2XX_TIMER) +=3D stm32f2xx_timer.o
> >   common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o aspeed_rtc.o
> >
> > -common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
> >   common-obj-$(CONFIG_CMSDK_APB_TIMER) +=3D cmsdk-apb-timer.o
> >   common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) +=3D cmsdk-apb-dualtimer.o
> >   common-obj-$(CONFIG_MSF2) +=3D mss-timer.o
> > diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> > index 6936fe8573..ce34b967db 100644
> > --- a/hw/timer/trace-events
> > +++ b/hw/timer/trace-events
> > @@ -70,10 +70,6 @@ cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer=
: reset"
> >   aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " =
value 0x%08" PRIx64
> >   aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 "=
 value 0x%08" PRIx64
> >
> > -# sun4v-rtc.c
> > -sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 =
" value 0x%" PRIx64
> > -sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx6=
4 " value 0x%" PRIx64
> > -
> >   # xlnx-zynqmp-rtc.c
> >   xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int m=
in, int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
> >
> > diff --git a/include/hw/rtc/sun4v-rtc.h b/include/hw/rtc/sun4v-rtc.h
> > new file mode 100644
> > index 0000000000..fd868f6ed2
> > --- /dev/null
> > +++ b/include/hw/rtc/sun4v-rtc.h
> > @@ -0,0 +1,19 @@
> > +/*
> > + * QEMU sun4v Real Time Clock device
> > + *
> > + * The sun4v_rtc device (sun4v tod clock)
> > + *
> > + * Copyright (c) 2016 Artyom Tarasenko
> > + *
> > + * This code is licensed under the GNU GPL v3 or (at your option) any =
later
> > + * version.
> > + */
> > +
> > +#ifndef HW_RTC_SUN4V
> > +#define HW_RTC_SUN4V
> > +
> > +#include "exec/hwaddr.h"
> > +
> > +void sun4v_rtc_init(hwaddr addr);
> > +
> > +#endif
> > diff --git a/include/hw/timer/sun4v-rtc.h b/include/hw/timer/sun4v-rtc.=
h
> > deleted file mode 100644
> > index 407278f918..0000000000
> > --- a/include/hw/timer/sun4v-rtc.h
> > +++ /dev/null
> > @@ -1 +0,0 @@
> > -void sun4v_rtc_init(hwaddr addr);
> >



--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

