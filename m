Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8C2C742B0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 09:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0C120838
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 09:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="X22GS1wk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0C120838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlrqc-00017u-Qi
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 05:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43228)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bgolaszewski@baylibre.com>) id 1hlrqR-0000VY-46
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 05:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bgolaszewski@baylibre.com>) id 1hlrqP-0002JB-TI
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 05:27:59 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bgolaszewski@baylibre.com>)
 id 1hlrqP-0002DJ-H8
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 05:27:57 -0400
Received: by mail-ot1-x342.google.com with SMTP id s20so8818274otp.4
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 02:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jYy0XP6ethrem4b19nt43P11ZiYCCwivtW53JRcikeE=;
 b=X22GS1wk91UjPm6+zhjoIjTp6TANbMdrUt6PVMNOW9CW/5FPKoxIlUCGugAB+NRfRQ
 monlxmvfGjdkXHE0ZXj5TSesu/oigagcXG+j6OYS3f9S8e/jIh/2BrFN70n632G8bJlr
 ArRi2NabuE5PXCf2lJC1fyNzO3ZGV7RMpfSmQmT5SJv8S0yYl8b5duVEmdRMT9zOjLV6
 MMlp4NQ2biV1cCjV+lAXpJShoHW000qTR2iSqk+SzD7uaPhNExUrMOch2dzqjkDkaiI0
 Wi1yENBcScRkf2Hq1RIw7hwJWljm7CgJxis3HKB0cvCOtLD888T6G++Uniy7ZJtM3XzJ
 hhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jYy0XP6ethrem4b19nt43P11ZiYCCwivtW53JRcikeE=;
 b=SvZJLeqbz+Vj9FMRiyZDfYzJUB6bG6bPgsW8HhHvk6PRmvHK5bxUXqQYEjmAq+Gp8s
 /zIAg1AWFzWlxEhKe8jlrZL82x1nUeGHEQQvozKmrEk1KUv9q5yqUlLaHGSThHvRV/7Q
 uoR2fdAOIKi3aLfdjCsJlfFD6UrPyVtun9jgzUP5whpNXN09/nRfpTbxVfx7F+gLh3pn
 quChmCaUXUv1fqrhBMfjv8MqZ6Sl7h5zJBQZiaEOj08B3fp8fF4OJ6vJ3URRMkzMsF7t
 D9vol9BZ+q+Zdu6z/rowNbUY9FeqPCCYri9ej2d6v3FWVmn93Y55QzQDm6YPGaDOduqN
 /J2Q==
X-Gm-Message-State: APjAAAVxllCcu+Llg4NaYz+Ihlpcuw+p9pqKIvGY4MGbs18u7JFgwyBE
 7eFF+QLRViASqpnYC+HhSjbj5QRCznUeghvPONBZHg==
X-Google-Smtp-Source: APXvYqxmQFQAuZwu//RzFgfnJxLEi/izHgwx7Kkeq/oXPVKBHwaEP5wdAyHZxZ54Z6rZrZsRLEQzcJL5gRduQ6uOogU=
X-Received: by 2002:a9d:7352:: with SMTP id l18mr2470502otk.292.1562923674988; 
 Fri, 12 Jul 2019 02:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190705160536.12047-1-geert+renesas@glider.be>
 <CAMpxmJXOrDLdw6ZPBHxzsDRYiLmhRNCb-s_Z=Gu=Ecg1XA5ONQ@mail.gmail.com>
 <CAMuHMdWdb0dcS8Nvk-Poz2dT7nuHjFhqpsRPZZnSKsc3VffcRA@mail.gmail.com>
 <CAMpxmJUF1s1zyXVtoUGfbV7Yk+heua4rNjY=DrX=jr-v8UfNxA@mail.gmail.com>
 <CAMuHMdUkF32+wOLkfd2BL4h-=0nZjPDMtVOpOcyDYzBbhWXteQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUkF32+wOLkfd2BL4h-=0nZjPDMtVOpOcyDYzBbhWXteQ@mail.gmail.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Fri, 12 Jul 2019 11:27:43 +0200
Message-ID: <CAMpxmJXCYeGjCu_PhCPffZQZ+ST9YCp27-PTHfL2SJ0Bh8SJFQ@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

wt., 9 lip 2019 o 17:59 Geert Uytterhoeven <geert@linux-m68k.org> napisa=C5=
=82(a):
>
> Hi Bartosz,
>
> On Tue, Jul 9, 2019 at 4:59 PM Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
> > pon., 8 lip 2019 o 12:24 Geert Uytterhoeven <geert@linux-m68k.org> napi=
sa=C5=82(a):
> > > On Mon, Jul 8, 2019 at 11:45 AM Bartosz Golaszewski
> > > <bgolaszewski@baylibre.com> wrote:
> > > > pt., 5 lip 2019 o 18:05 Geert Uytterhoeven <geert+renesas@glider.be=
> napisa=C5=82(a):
> > > > > GPIO controllers are exported to userspace using /dev/gpiochip*
> > > > > character devices.  Access control to these devices is provided b=
y
> > > > > standard UNIX file system permissions, on an all-or-nothing basis=
:
> > > > > either a GPIO controller is accessible for a user, or it is not.
> > > > > Currently no mechanism exists to control access to individual GPI=
Os.
> > > > >
> > > > > Hence add a virtual GPIO driver to aggregate existing GPIOs (up t=
o 32),
> > > > > and expose them as a new gpiochip.  This is useful for implementi=
ng
> > > > > access control, and assigning a set of GPIOs to a specific user.
> > > > > Furthermore, it would simplify and harden exporting GPIOs to a vi=
rtual
> > > > > machine, as the VM can just grab the full virtual GPIO controller=
, and
> > > > > no longer needs to care about which GPIOs to grab and which not,
> > > > > reducing the attack surface.
> > > > >
> > > > > Virtual GPIO controllers are instantiated by writing to the "new_=
device"
> > > > > attribute file in sysfs:
> > > > >
> > > > >     $ echo "<gpiochipA> <gpioA1> [<gpioA2> ...]"
> > > > >            "[, <gpiochipB> <gpioB1> [<gpioB2> ...]] ...]"
> > > > >             > /sys/bus/platform/drivers/gpio-virt-agg/new_device
> > > > >
> > > > > Likewise, virtual GPIO controllers can be destroyed after use:
> > > > >
> > > > >     $ echo gpio-virt-agg.<N> \
> > > > >             > /sys/bus/platform/drivers/gpio-virt-agg/delete_devi=
ce
>
> > Am I doing it right? I'm trying to create a device and am only getting =
this:
> >
> > # echo gpiochip2 23 > new_device
> > [  707.507039] gpio-virt-agg gpio-virt-agg.0: Cannot find gpiochip gpio=
chip2
> >
> > gpiochip2 *does* exist in the system.
>
> Please try the name of the platform device instead.
> I.e. for my koelsch (R-Car M2-W), it needs "e6052000.gpio" instead
> of "gpiochip2".
>
> Probably the driver should match on both.
>
> > I see. I'll try to review it more thoroughly once I get to play with
> > it. So far I'm stuck on creating the virtual chip.
>
> Thanks, good luck!
>

This is not a show-stopper but one thing that's bothering me in this
is that lines used by the aggregator are considered 'used' in regard
to the original chip. I'm wondering how much effort would it take to
have them be 'muxed' into two (real and virtual) chips at once.

Other than that - seems to works pretty nice other than the matching
by chip name and by line names.

Bart

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

