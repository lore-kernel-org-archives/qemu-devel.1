Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F94AC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 11:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56CF320449
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 11:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ezZQpMQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CF320449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpWyU-0002aU-Jj
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 07:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56561)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpWyI-000268-GF
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpWyH-0002MC-4E
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:59:14 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpWyG-0002Lo-TO
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:59:13 -0400
Received: by mail-ot1-x341.google.com with SMTP id j11so15636664otp.10
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 04:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CqKQ7cXKJ1z7FTKs4TehgVkv9/3MjuQ1pzUNh98uYSc=;
 b=ezZQpMQxrTtc+6pnxh/RFQAAvu4DbBbNg8hEap23CfdzNJ7R2rD6mcnxlqaPrVnqmW
 hC66ZF8cDIAmYKYsRaGVHnIyIeipTuWWro6FOGh1OhEqnB2DrFMs4c5wnL4yz0Pt2LaG
 sBcVpIXgLQr3Fn7AyeCywsYYcCjDePEIjBwX0bHRVu0lqKLNhUMln8OfP1h/BoDAXOvN
 N7LQQ/j6cLottztJuYwbhiNGkb2KVg4J/wWw9A7jBBm1qeNT449wL7Fgg1GV1ftSDmEM
 eiTFYdyAC6w9zgDJS9nYH1uO5xBiTtwnt3fxwFnwAqywoq0TlbbYej8SZchD7c+eLsUc
 kudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CqKQ7cXKJ1z7FTKs4TehgVkv9/3MjuQ1pzUNh98uYSc=;
 b=rQXsAX7x+aNGH83Zti0sjolAoK3vr/4dHXAbrqzwM7U4AzLKRMmVoFeiQQD2VEZgPN
 OHsHI/EEL/QuLJdpGdtecF2jfCnZaFfyQNQYKB+YlxXRVGdMySvvrolR1xxUTb7MEMRT
 oy4XVvK4ymrUexFEsquIenh3cCrIjdjaBWZxGywd7Qd0rQkZtz7kQIHplFhRJH1QhIhw
 X5j6dArLzpATDqy6zjaPIEc2aHrVpjRc3shUlh0FEmJLnApDEVzHKi9MfoW2ZjPROPVa
 EBbWnZAng+JY8P33AuQ81hj9bENBVy3h/9KVeIN/4GUoTUe6JptjOrk1YGzM1V76M0NN
 Mi7Q==
X-Gm-Message-State: APjAAAU+05G5I7SrfVTDQdYw5RVqvEuW4SNoikXUJhavL9F2QAm4IDox
 pEL1MTjMVzq5ZfSTCd7fgOsaobEw/E3IOHezLKKEpw==
X-Google-Smtp-Source: APXvYqzjvJLaZJo0LQc+f8ttzUY66WbnnehRMD2sc5keOAQrnM55DOyZBk43fcC5Dpr8ILC71b9thZ8Nmqi2/HUtkp0=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr44391642otr.232.1563796752009; 
 Mon, 22 Jul 2019 04:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190516144733.32399-1-peter.maydell@linaro.org>
 <20190516144733.32399-4-peter.maydell@linaro.org>
 <20190719164729.GA22520@lakrids.cambridge.arm.com>
In-Reply-To: <20190719164729.GA22520@lakrids.cambridge.arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2019 12:59:01 +0100
Message-ID: <CAFEAcA_i_0=xAp86RJVSpurAdWfT5KDfgoh6Y51-mwBJa=_QTQ@mail.gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 3/4] hw/arm/boot: Avoid placing the
 initrd on top of the kernel
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jul 2019 at 17:47, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Peter,
>
> I've just been testing on QEMU v4.1.0-rc1, and found a case where the
> DTB overlapped the end of the kernel, and I think there's a bug in this
> patch -- explanation below.
>
> On Thu, May 16, 2019 at 03:47:32PM +0100, Peter Maydell wrote:
> > We currently put the initrd at the smaller of:
> >  * 128MB into RAM
> >  * halfway into the RAM
> > (with the dtb following it).
> >
> > However for large kernels this might mean that the kernel
> > overlaps the initrd. For some kinds of kernel (self-decompressing
> > 32-bit kernels, and ELF images with a BSS section at the end)
> > we don't know the exact size, but even there we have a
> > minimum size. Put the initrd at least further into RAM than
> > that. For image formats that can give us an exact kernel size, this
> > will mean that we definitely avoid overlaying kernel and initrd.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  hw/arm/boot.c | 34 ++++++++++++++++++++--------------
> >  1 file changed, 20 insertions(+), 14 deletions(-)
> >
> > diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> > index 935be3b92a5..e441393fdf5 100644
> > --- a/hw/arm/boot.c
> > +++ b/hw/arm/boot.c
> > @@ -999,20 +999,6 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
> >      if (info->nb_cpus == 0)
> >          info->nb_cpus = 1;
> >
> > -    /*
> > -     * We want to put the initrd far enough into RAM that when the
> > -     * kernel is uncompressed it will not clobber the initrd. However
> > -     * on boards without much RAM we must ensure that we still leave
> > -     * enough room for a decent sized initrd, and on boards with large
> > -     * amounts of RAM we must avoid the initrd being so far up in RAM
> > -     * that it is outside lowmem and inaccessible to the kernel.
> > -     * So for boards with less  than 256MB of RAM we put the initrd
> > -     * halfway into RAM, and for boards with 256MB of RAM or more we put
> > -     * the initrd at 128MB.
> > -     */
> > -    info->initrd_start = info->loader_start +
> > -        MIN(info->ram_size / 2, 128 * 1024 * 1024);
> > -
> >      /* Assume that raw images are linux kernels, and ELF images are not.  */
> >      kernel_size = arm_load_elf(info, &elf_entry, &elf_low_addr,
> >                                 &elf_high_addr, elf_machine, as);
> > @@ -1064,6 +1050,26 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
> >      }
> >
> >      info->entry = entry;
>
> Note: this is the start of the kernel image...

It's the entry point, which isn't quite the same thing as
the start of the image (if we just loaded an ELF file then
'entry' is whatever the ELF file said the entrypoint is, which
could be a long way into the image).

> > +
> > +    /*
> > +     * We want to put the initrd far enough into RAM that when the
> > +     * kernel is uncompressed it will not clobber the initrd. However
> > +     * on boards without much RAM we must ensure that we still leave
> > +     * enough room for a decent sized initrd, and on boards with large
> > +     * amounts of RAM we must avoid the initrd being so far up in RAM
> > +     * that it is outside lowmem and inaccessible to the kernel.
> > +     * So for boards with less  than 256MB of RAM we put the initrd
> > +     * halfway into RAM, and for boards with 256MB of RAM or more we put
> > +     * the initrd at 128MB.
> > +     * We also refuse to put the initrd somewhere that will definitely
> > +     * overlay the kernel we just loaded, though for kernel formats which
> > +     * don't tell us their exact size (eg self-decompressing 32-bit kernels)
> > +     * we might still make a bad choice here.
> > +     */
> > +    info->initrd_start = info->loader_start +
> > +        MAX(MIN(info->ram_size / 2, 128 * 1024 * 1024), kernel_size);
>
> ... but here we add kernel_size to the start of the loader, which is
> below the kernel. Should that be info->entry?

loader_start here really means "base of RAM". I think what
we want here is something like

  info->initrd_start = info->loader_start + MIN(info->ram_size / 2,
128 * 1024 * 1024);
  info->initrd_start = MAX(info->initrd_start, kernel_end);

where kernel_end is just past whatever the highest addr of the kernel
is, which is not something that's totally trivial to calculate
with the variables we have to hand at this point.

thanks
-- PMM

