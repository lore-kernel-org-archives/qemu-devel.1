Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D78C73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 15:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C974720844
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 15:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sITepeWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C974720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkri2-0007tD-9G
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 11:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38054)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bgolaszewski@baylibre.com>) id 1hkraO-0005H5-3A
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 10:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bgolaszewski@baylibre.com>) id 1hkraM-0002jh-Fn
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 10:59:16 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bgolaszewski@baylibre.com>)
 id 1hkraL-0002dX-W6
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 10:59:14 -0400
Received: by mail-oi1-x243.google.com with SMTP id s184so15568317oie.9
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 07:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pzCb+Di/c9ZWTKEmAt46a9ynFYRh/T3Fr01SSbk8A/w=;
 b=sITepeWjRPevQm0BsKHCBzgNsIV/6+j349u/RLUlrHVpKZ6WQTBiV8xqZRUtlr6oM7
 uX9+KEbwvwEZ4gfs+BaSmuvm5AegKonbf2TPNwG4OgxDjnSRrTI3moW3A77EH+/PGL0i
 gcIDPN4fJj6Mue6fk+LogZRrzPxkonUexTrfQagtsleWGr/+OaYifVvKs7hmAdoFAb4n
 tKdfDvzN+yaH6ZPkOqZPg0GrlAvdcn9p+u0GRHaLrmnNzq1sn1xx2uWlZI9JIMUhPukO
 JM0Fl7fpD52byEmmX3wBVeqyd2ukPVlF0FcRrMFElUlMc2oClC5wPSJ+YK2vmyEAxzP5
 Xtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pzCb+Di/c9ZWTKEmAt46a9ynFYRh/T3Fr01SSbk8A/w=;
 b=o0qQ2tU8p15xPZAxAjeZVEAbhqy46vrOtvI4LQSSlAGeV40ewer78yr7nnZLmcVqUS
 uO3hmZB6ncz6r+X0oQHpS77fWjGlhmlrQGnJnedoq9M3sf3oD1xEHi9xkbeFmD1uAO/2
 kdkHjOFjzEDjVuVWPtgreXW5zaCoOl8H1WC6YTnfDUnbb6TQiZD+yFF7nV/LaH6gSmfj
 p2bRzK+Lc65U34IVng8ZLm9aL/VoBvEXOS0xrCQ3vPRqT1Mi0KU3JcYmztHTKQAM9gDw
 ykubw2fzM26+eTKdZKBC6Qnjs0rDysR3o9HtpXgAIoEG0jP2EicwkFot0hKG++XO9PSs
 U8KQ==
X-Gm-Message-State: APjAAAWaqCA27Vn2Wv2v6cc0WmRJpwqI/wpvpWOgzkqGAI3ZiCnl+Bz/
 DN+Fomy+yUduWMWQPr7cW+hva8KuqXxA2Qz8LLYVNw==
X-Google-Smtp-Source: APXvYqzvy5+qSnT0FsNiIa1hh9LJ5dmCzod4D0X30hjj68Evdb6Y1I3rj58R5mzNDeY7yv1uOu8i5mT7qmTvogCGwww=
X-Received: by 2002:aca:b58b:: with SMTP id e133mr234611oif.147.1562684339714; 
 Tue, 09 Jul 2019 07:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190705160536.12047-1-geert+renesas@glider.be>
 <CAMpxmJXOrDLdw6ZPBHxzsDRYiLmhRNCb-s_Z=Gu=Ecg1XA5ONQ@mail.gmail.com>
 <CAMuHMdWdb0dcS8Nvk-Poz2dT7nuHjFhqpsRPZZnSKsc3VffcRA@mail.gmail.com>
In-Reply-To: <CAMuHMdWdb0dcS8Nvk-Poz2dT7nuHjFhqpsRPZZnSKsc3VffcRA@mail.gmail.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 9 Jul 2019 16:58:48 +0200
Message-ID: <CAMpxmJUF1s1zyXVtoUGfbV7Yk+heua4rNjY=DrX=jr-v8UfNxA@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH RFC] gpio: Add Virtual Aggregator GPIO
 Driver
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
 Geert Uytterhoeven <geert+renesas@glider.be>,
 LKML <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>, Alexander Graf <agraf@suse.de>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 linux-gpio <linux-gpio@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pon., 8 lip 2019 o 12:24 Geert Uytterhoeven <geert@linux-m68k.org> napisa=
=C5=82(a):
>
> Hi Bartosz,
>
> On Mon, Jul 8, 2019 at 11:45 AM Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
> > pt., 5 lip 2019 o 18:05 Geert Uytterhoeven <geert+renesas@glider.be> na=
pisa=C5=82(a):
> > > GPIO controllers are exported to userspace using /dev/gpiochip*
> > > character devices.  Access control to these devices is provided by
> > > standard UNIX file system permissions, on an all-or-nothing basis:
> > > either a GPIO controller is accessible for a user, or it is not.
> > > Currently no mechanism exists to control access to individual GPIOs.
> > >
> > > Hence add a virtual GPIO driver to aggregate existing GPIOs (up to 32=
),
> > > and expose them as a new gpiochip.  This is useful for implementing
> > > access control, and assigning a set of GPIOs to a specific user.
> > > Furthermore, it would simplify and harden exporting GPIOs to a virtua=
l
> > > machine, as the VM can just grab the full virtual GPIO controller, an=
d
> > > no longer needs to care about which GPIOs to grab and which not,
> > > reducing the attack surface.
> > >
> > > Virtual GPIO controllers are instantiated by writing to the "new_devi=
ce"
> > > attribute file in sysfs:
> > >
> > >     $ echo "<gpiochipA> <gpioA1> [<gpioA2> ...]"
> > >            "[, <gpiochipB> <gpioB1> [<gpioB2> ...]] ...]"
> > >             > /sys/bus/platform/drivers/gpio-virt-agg/new_device
> > >
> > > Likewise, virtual GPIO controllers can be destroyed after use:
> > >
> > >     $ echo gpio-virt-agg.<N> \
> > >             > /sys/bus/platform/drivers/gpio-virt-agg/delete_device
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > I like the general idea and the interface looks mostly fine. Since
> > this is new ABI I think it needs to be documented as well.
>
> Sure.
>
> > I'm having trouble building this module:
> >
> >   CALL    scripts/atomic/check-atomics.sh
> >   CALL    scripts/checksyscalls.sh
> >   CHK     include/generated/compile.h
> >   Kernel: arch/arm/boot/Image is ready
> >   Building modules, stage 2.
> >   MODPOST 235 modules
> > ERROR: "gpiod_request" [drivers/gpio/gpio-virt-agg.ko] undefined!
> > ERROR: "gpiochip_get_desc" [drivers/gpio/gpio-virt-agg.ko] undefined!
> > ERROR: "gpiod_free" [drivers/gpio/gpio-virt-agg.ko] undefined!
> > scripts/Makefile.modpost:91: recipe for target '__modpost' failed
> > make[1]: *** [__modpost] Error 1
> > Makefile:1287: recipe for target 'modules' failed
> > make: *** [modules] Error 2
> > make: *** Waiting for unfinished jobs....
> >
> > I'm not sure what the problem is.
>
> Oops. As this is an RFC, I didn't bother trying to build this driver as
> a module, only builtin.  Apparently the 3 symbols above are not yet
> exported using EXPORT_SYMBOL_GPL().
>

Am I doing it right? I'm trying to create a device and am only getting this=
:

# echo gpiochip2 23 > new_device
[  707.507039] gpio-virt-agg gpio-virt-agg.0: Cannot find gpiochip gpiochip=
2

gpiochip2 *does* exist in the system.

> > > --- /dev/null
> > > +++ b/drivers/gpio/gpio-virt-agg.c
> > > @@ -0,0 +1,390 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +//
> > > +// GPIO Virtual Aggregator
> > > +//
> > > +// Copyright (C) 2019 Glider bvba
> > > +
> > > +#include <linux/gpio/driver.h>
> > > +#include <linux/idr.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +#include "gpiolib.h"
> > > +
> > > +#define DRV_NAME       "gpio-virt-agg"
> > > +#define MAX_GPIOS      32
> >
> > Do we really need this limit? I see it simplifies the code, but maybe
> > we can allocate the relevant arrays dynamically and not limit users?
>
> Sure. That limit can be lifted.
>
> > > +static int gpio_virt_agg_set_config(struct gpio_chip *chip,
> > > +                                   unsigned int offset, unsigned lon=
g config)
> > > +{
> > > +       struct gpio_virt_agg_priv *priv =3D gpiochip_get_data(chip);
> > > +
> > > +       chip =3D priv->desc[offset]->gdev->chip;
> > > +       if (chip->set_config)
> > > +               return chip->set_config(chip, offset, config);
> > > +
> > > +       // FIXME gpiod_set_transitory() expects success if not implem=
ented
>
> BTW, do you have a comment about this FIXME?
>

Ha! Interesting. I'll give it a thought and respond elsewhere as it's
a different subject.

> > > +       return -ENOTSUPP;
> > > +}
>
> > > +static int gpio_virt_agg_probe(struct platform_device *pdev)
> > > +{
> > > +       struct device *dev =3D &pdev->dev;
> > > +       const char *param =3D dev_get_platdata(dev);
> > > +       struct gpio_virt_agg_priv *priv;
> > > +       const char *label =3D NULL;
> > > +       struct gpio_chip *chip;
> > > +       struct gpio_desc *desc;
> > > +       unsigned int offset;
> > > +       int error, i;
> >
> > This 'i' here is reported as possibly not initialized:
> >
> > drivers/gpio/gpio-virt-agg.c: In function =E2=80=98gpio_virt_agg_probe=
=E2=80=99:
> > drivers/gpio/gpio-virt-agg.c:230:13: warning: =E2=80=98i=E2=80=99 may b=
e used
> > uninitialized in this function [-Wmaybe-uninitialized]
> >   int error, i;
> >              ^
>
> Oops, should be preinitialized to zero. WIll fix.
>
> > > +static int gpio_virt_agg_remove(struct platform_device *pdev)
> > > +{
> > > +       struct gpio_virt_agg_priv *priv =3D platform_get_drvdata(pdev=
);
> > > +       unsigned int i;
> > > +
> > > +       gpiochip_remove(&priv->chip);
> > > +
> > > +       for (i =3D 0; i < priv->chip.ngpio; i++)
> > > +               gpiod_free(priv->desc[i]);
>
> Perhaps I should use gpiod_put() instead, which is exported to modules?
>
> > > +
> > > +       return 0;
> > > +}
> >
> > You shouldn't need this function at all. It's up to users to free descr=
iptors.
>
> This frees the upstream descriptors, not the descriptors used by users
> of the virtual gpiochip. Shouldn't they be freed, as they are no longer
> in use?
>
> Note that .probe() doesn't use devm_gpiochip_add_data(), as the upstream
> descriptors need to be freed after the call to gpiochip_remove().
>
> Thanks!

I see. I'll try to review it more thoroughly once I get to play with
it. So far I'm stuck on creating the virtual chip.

Bart

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

