Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D61C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D16206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DRzJQiVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D16206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifPIA-0006ug-DP
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1ifOi5-0004mh-LI
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 08:40:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1ifOi1-0005SY-RD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 08:40:53 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:34253)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1ifOi0-0005Oe-0t
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 08:40:48 -0500
Received: by mail-lj1-x241.google.com with SMTP id m6so2354744ljc.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 05:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7PbHPLSXQGj0yJrSH192TMtAaxNo5rw41NetJ/dcUfw=;
 b=DRzJQiVQg/nQ/ASUfL3q6cDwUxWJ56eQnZWGgR+JOoveYSxcv7+j9kjbi9XlxA1AEO
 A02/XOPXYlK843ecHoWeaRH53jfl/cx5u3XSjbfE6QXM6s9uUsm05zfWWRKxADesDQaV
 PnpOe4EYjBF5MZNs5FNBPAYxERQpmPL1TeloXm3jpv3+AB/lT3PvU4ZBj/VaARR4vYaR
 uJAZHSCgQIgMRkQV60ebT26TmXAs0cOXjT+DYySEPkfd4IKU4kJpTPp6/Mka/ayB4hXZ
 fNwhN8IIW0TkBhIE6JdShsrKJP3KtegCAZBZzOcTXVPJ7RuZIJLfrFV04K8VZIFI/qoI
 sOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7PbHPLSXQGj0yJrSH192TMtAaxNo5rw41NetJ/dcUfw=;
 b=kgld7fHlHVjIETepc+qKFMMczJdFqQpdXXiAl+QhikgPK3ozW+hPmNSmph2t3UNjzT
 kbpa9kBtYpyIKi7VBrv9kx0DLvDyzOeAjfjY8K89IOqXZZy0T4DLY9RdmGv99IOw8Ari
 ZMCsSeAeshaDiGhBswiK/Hq/Re7yTpHSogNwGvNqD1ccMzGbfkhfAvHJC4f1nhee8uDN
 swN9at1ZUtRLAfv7PEVKI55LA2/OTZxqhAKtRa7Jjur7M3wU7tVqaB2so8zIl6fOaGIU
 d2/PJAs9bPHhwIX/NVjDqVKJb4zX4i7fUvHSQsEsQ2+j2l/z/Nq68T0szYMzib44OAqm
 FKyg==
X-Gm-Message-State: APjAAAWANIyYDLD5cDmZiilgUMcgShEbJAUMGnRPa6Y4/j1CaV7aRUcI
 sEC+ZewXUh6S9R3XFBQ78LkYtQkquv+vJYXfbt8v7A==
X-Google-Smtp-Source: APXvYqz4WIPVD6RaEfzhjt2nRL8Q3ReinXWMfS2taUKWfU1ppqbKjrPvuAhDEVOow4IVqRo34vof7KNX/xH9rfQS/Dc=
X-Received: by 2002:a2e:9ec4:: with SMTP id h4mr6024597ljk.77.1576158044254;
 Thu, 12 Dec 2019 05:40:44 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-4-geert+renesas@glider.be>
In-Reply-To: <20191127084253.16356-4-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Dec 2019 14:40:29 +0100
Message-ID: <CACRpkdZs0_VvfpE34bgrMtBVeamCsq6BaqfyJc1tyvWCornSUw@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] gpiolib: Add support for GPIO line table lookup
To: Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Phil Reid <preid@electromag.com.au>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 27, 2019 at 9:43 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Currently GPIOs can only be referred to by GPIO controller and offset in
> GPIO lookup tables.
>
> Add support for looking them up by line name.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

OK I see what you want to do...

> +               if (p->chip_hwnum == (u16)-1) {

If you want to use this then use:

if (p->chip_hwnum == U16_MAX)

from <linux/limits.h>

> +                       desc = gpio_name_to_desc(p->chip_label);
> +                       if (desc) {
> +                               *flags = p->flags;
> +                               return desc;
> +                       }
> +
> +                       dev_warn(dev, "cannot find GPIO line %s, deferring\n",
> +                                p->chip_label);
> +                       return ERR_PTR(-EPROBE_DEFER);
> +               }
> +
>                 chip = find_chip_by_name(p->chip_label);
>
>                 if (!chip) {
> diff --git a/include/linux/gpio/machine.h b/include/linux/gpio/machine.h
> index 1ebe5be05d5f81fa..84c1c097e55eefaf 100644
> --- a/include/linux/gpio/machine.h
> +++ b/include/linux/gpio/machine.h
> @@ -31,7 +31,7 @@ enum gpio_lookup_flags {
>   */
>  struct gpiod_lookup {
>         const char *chip_label;
> -       u16 chip_hwnum;
> +       u16 chip_hwnum;                 /* if -1, chip_label is named line */

/* if U16_MAX then chip_label is the named line we are looking for */

But the member name "chip_label" is completely abused with this
setup, it should then be renamed as part of the patch set to something
like chip_label_or_line_name so it is clear what it is or
just name it "const char *key".

But I'm not entirely convinced about reusing the existing
struct gpio_lookup for this.

What about constructing a new lookup struct specifically for this?
I understand it is more work, but will that not be more
maintainable and readable?

Yours,
Linus Walleij

