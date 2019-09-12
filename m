Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ED8C5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B622084F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D3DKMYG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B622084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8KvO-0007xX-1c
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 04:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1i8KuQ-0007GD-Vj
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1i8KuP-0003dK-Cg
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:56:58 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:35596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1i8KuP-0003cu-3R
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:56:57 -0400
Received: by mail-lf1-x141.google.com with SMTP id w6so18708772lfl.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O4rNsBBKosmEKuM20N1o+kTVCcH97Bng0NbBw9yNr8E=;
 b=D3DKMYG24yUN1RDiYO9JGi5OzLJnsDAX1mduveT541WYCPUsRVLNeQV1gqCXQgLQnA
 hSiysE5eP/ctTfnppUzrQP2sahmP2yiTiw5cgHoArQeUEzOcvqySc7NEkB3mq2JOPbqb
 juhTRCK1xJvKgjLJjOaw9fyowdFgeNSXBHqzOVPQ3FI71LSnFKfrkfliHRc1JpIqWAv3
 Iwkq20k06kaGR2jt1/Jec+6iT2dpYsmvt5MP2pWkVLAmxhvqyE+X931w6bdf2z831BDg
 sDW1oCFvbn/+Q3/cq/Gj6AoYXkHffK4vgwEIVqhmEtZhQTeG31pOB+Je8xQdKsVuPJ7W
 TUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O4rNsBBKosmEKuM20N1o+kTVCcH97Bng0NbBw9yNr8E=;
 b=QMiVqwvjd6l1oVITlf5njtz9aLnQySCHHzQW5S237Ad8j4qnlc302LdHNlB9Y92MSO
 aucCvqiQTCJea8bneEZpPLyEy0gYZk3TkE/HkIR5QjyYl3CUD+Qy56PDZ4lgOEHn4WKj
 oCshV8snWR2XPPP4CY8bG0kLUfQ+IzymsqMEOSFzN/EJewtGdgj15GxN1CJLPmbVimEr
 +wE1RBW7Z+Ys/xsV5r1agCY+2dFIaNQFmoLf6XvEmnOGdDQmqX1RdTTt0mnkoI1KGK2I
 joLPwCeJa01nkxK8V2x6mWYdlcADOT5ScDnG0pqQip6rvCG4BRVHGI7A3Y2+FTT6B6Qy
 38Ng==
X-Gm-Message-State: APjAAAVCfYP4GpZ9h3dcIC1JVX9LEbjIJ4+zOZOLQaKf4O5Kt39dzXcD
 YyQtdeYaGOtXtJLmdOX9cfbNUMLHe99qX8wrDjDgiw==
X-Google-Smtp-Source: APXvYqxylrMcLmkUlXrbh6djdas3oUwzeZqQnSvt9y91CIt5cYSOJplKhnz1LXiShn8fiV4G7ad4/5yw3Umgt3fgxhU=
X-Received: by 2002:a19:48c3:: with SMTP id
 v186mr27114921lfa.141.1568278614888; 
 Thu, 12 Sep 2019 01:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190705160536.12047-1-geert+renesas@glider.be>
In-Reply-To: <20190705160536.12047-1-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Sep 2019 09:56:43 +0100
Message-ID: <CACRpkdZstL3PMtLN3VCDmHq7vSNdO0Q8Wf1sYb5VnwCMs=0uJQ@mail.gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, adelva@google.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Alexander Graf <agraf@suse.de>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 5, 2019 at 5:05 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> GPIO controllers are exported to userspace using /dev/gpiochip*
> character devices.  Access control to these devices is provided by
> standard UNIX file system permissions, on an all-or-nothing basis:
> either a GPIO controller is accessible for a user, or it is not.
> Currently no mechanism exists to control access to individual GPIOs.
>
> Hence add a virtual GPIO driver to aggregate existing GPIOs (up to 32),
> and expose them as a new gpiochip.  This is useful for implementing
> access control, and assigning a set of GPIOs to a specific user.
> Furthermore, it would simplify and harden exporting GPIOs to a virtual
> machine, as the VM can just grab the full virtual GPIO controller, and
> no longer needs to care about which GPIOs to grab and which not,
> reducing the attack surface.
>
> Virtual GPIO controllers are instantiated by writing to the "new_device"
> attribute file in sysfs:
>
>     $ echo "<gpiochipA> <gpioA1> [<gpioA2> ...]"
>            "[, <gpiochipB> <gpioB1> [<gpioB2> ...]] ...]"
>             > /sys/bus/platform/drivers/gpio-virt-agg/new_device
>
> Likewise, virtual GPIO controllers can be destroyed after use:
>
>     $ echo gpio-virt-agg.<N> \
>             > /sys/bus/platform/drivers/gpio-virt-agg/delete_device
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Aggregating GPIOs and exposing them as a new gpiochip was suggested in
> response to my proof-of-concept for GPIO virtualization with QEMU[1][2].
>
> Sample session on r8a7791/koelsch:
>
>   - Disable the leds node in arch/arm/boot/dts/r8a7791-koelsch.dts
>
>   - Create virtual aggregators:
>
>     $ echo "e6052000.gpio 19 20" \
>             > /sys/bus/platform/drivers/gpio-virt-agg/new_device
>
>     gpio-virt-agg gpio-virt-agg.0: GPIO 0 => e6052000.gpio/19
>     gpio-virt-agg gpio-virt-agg.0: GPIO 1 => e6052000.gpio/20
>     gpiochip_find_base: found new base at 778
>     gpio gpiochip8: (gpio-virt-agg.0): added GPIO chardev (254:8)
>     gpiochip_setup_dev: registered GPIOs 778 to 779 on device: gpiochip8 (gpio-virt-agg.0)
>
>     $ echo "e6052000.gpio 21, e6050000.gpio 20 21 22" \
>             > /sys/bus/platform/drivers/gpio-virt-agg/new_device
>
>     gpio-virt-agg gpio-virt-agg.1: GPIO 0 => e6052000.gpio/21
>     gpio-virt-agg gpio-virt-agg.1: GPIO 1 => e6050000.gpio/20
>     gpio-virt-agg gpio-virt-agg.1: GPIO 2 => e6050000.gpio/21
>     gpio-virt-agg gpio-virt-agg.1: GPIO 3 => e6050000.gpio/22
>     gpiochip_find_base: found new base at 774
>     gpio gpiochip9: (gpio-virt-agg.1): added GPIO chardev (254:9)
>     gpiochip_setup_dev: registered GPIOs 774 to 777 on device: gpiochip9 (gpio-virt-agg.1)
>
>   - Adjust permissions on /dev/gpiochip[89] (optional)
>
>   - Control LEDs:
>
>     $ gpioset gpiochip8 0=0 1=1 # LED6 OFF, LED7 ON
>     $ gpioset gpiochip8 0=1 1=0 # LED6 ON, LED7 OFF
>     $ gpioset gpiochip9 0=0     # LED8 OFF
>     $ gpioset gpiochip9 0=1     # LED8 ON
>
>   - Destroy virtual aggregators:
>
>     $ echo gpio-virt-agg.0 \
>             > /sys/bus/platform/drivers/gpio-virt-agg/delete_device
>     $ echo gpio-virt-agg.1 \
>             > /sys/bus/platform/drivers/gpio-virt-agg/delete_device
>
> Thanks for your comments!
>
> References:
>   - [1] "[PATCH QEMU POC] Add a GPIO backend"
>         (https://lore.kernel.org/linux-renesas-soc/20181003152521.23144-1-geert+renesas@glider.be/)
>   - [2] "Getting To Blinky: Virt Edition / Making device pass-through
>          work on embedded ARM"
>         (https://fosdem.org/2019/schedule/event/vai_getting_to_blinky/)

I'm looping in my friends at Google for this discussion.

They need a virtualized gpio_chip for their Android emulator,
and their current approach for other devices has been around
using virtio in most cases and an emulated AC97 for the
audio case as far as I remember.

It would be great to have their input on this so we can create a
virtualization/aggregate that works for all.

Please include adelva@google.com on future postings of this!

Yours,
Linus Walleij

