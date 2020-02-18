Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7CAC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1DF2067D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMf5vBQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1DF2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j45pc-0004aD-Tb
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 11:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j45ox-00047K-Lx
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:34:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j45ow-0007NC-2s
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:34:03 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j45ov-0007LG-Sj
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:34:02 -0500
Received: by mail-oi1-x244.google.com with SMTP id a22so20670808oid.13
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 08:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jPYY65vpODA41L8bWpqitQorowgtHqqXzCYUBslSPRU=;
 b=BMf5vBQFGY1qP2VUcDVziBDerf2dMg66L7wYFroiixRjOSQmgGc72ouT6V1iBYgJfm
 4SmgWncaoJo7gEkwTTyR4XFGn0ScDQm1jZ+XgJWCdJicS40YghexO0fI1pH63hUYDObR
 x509FIrXwzlBVJ+EGoZfqkXWBx3pEfYyoBcOVekQ2kxCgtgQWPlZtqf2IP+ZYEe9Spas
 3SgmHiYZHVrh6MVK34OhAdQ9LN2Am5WQrw8aUJ4XNjQAXjYgCJBAL2DG9fnkVl0TUIKT
 dySyuItNaDnFsbtq+4CY9DYrdQ/vs8NENNxTkvwOYcQVCBCWGC5/5HJ5v76iAF/m/Vz/
 mO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jPYY65vpODA41L8bWpqitQorowgtHqqXzCYUBslSPRU=;
 b=Sc5Ll7aAf1Kg4uOKpnl1L/jcax70jkLQq3t/PaeyPG71ImPEANlCXqiIYqVf5Sf2WB
 Mo28reXdJ53ocqPelFKAw0J7I2JpJZX/HeTA6/6yyQJKb5CK/UgPPrPWzfaCo18SE2A1
 tvJhKb9H0p0ph8LT2Tue2Dzr0aTPm+0TI8HkWa7XajyFjpqaUnfVwqRecGhfMGqz59kt
 SD5vjGU7PWM7KJ8cHXK7RnMYDGN4ggHwR/2iSfO3VTYjYxNWv7dbxCRsb1zzn9W/5xIl
 2KrdSV8nF+Zv4k7gWxC4/ThJ1nUBTd08Uzyhv6TQLPzk3YveefttKav5I30+ZlnEft/J
 AmEg==
X-Gm-Message-State: APjAAAUpUbvCAAlNCXNQzsJg9sdesv+oSiNMTDNvwP2hxUUWZSvdw8wz
 DCN06PQuDXrMQVqOv3qNiFGQd/UlkejDNJYrhyHEZA==
X-Google-Smtp-Source: APXvYqyVMagx5Z7wa4dQgaBPB406gBgnaOLSnMZxyUHETIF22MnSzm96FlHdz+64YsIV+9I5U4gwTfnqCXXCknJap5U=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr1837332oiy.170.1582043640816; 
 Tue, 18 Feb 2020 08:34:00 -0800 (PST)
MIME-Version: 1.0
References: <20200217203734.18703-1-linux@roeck-us.net>
In-Reply-To: <20200217203734.18703-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2020 16:33:49 +0000
Message-ID: <CAFEAcA9v+9ohanZFGTgT1SLgNCnqZccnhcbsxm0MuNYQ_WSgjQ@mail.gmail.com>
Subject: Re: [PATCH] sh4: Remove bad memory alias 'sh_pci.isa'
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 at 20:38, Guenter Roeck <linux@roeck-us.net> wrote:
>
> The memory alias sh_pci.isa is located at address 0x0000 with
> a length of 0x40000. This results in the following memory tree.
>
> FlatView #1
>  AS "memory", root: system
>  AS "cpu-memory-0", root: system
>  AS "sh_pci_host", root: bus master container
>  Root memory region: system
>   0000000000000000-000000000000ffff (prio 0, i/o): io
>   0000000000010000-0000000000ffffff (prio 0, i/o): r2d.flash @0000000000010000
>
> The alias overlaps with flash memory. As result, flash memory can
> not be accessed. Removing the alias fixes the problem. With this patch,
> the memory tree is as follows, and flash is detected as expected.
>
> FlatView #1
>  AS "memory", root: system
>  AS "cpu-memory-0", root: system
>  AS "sh_pci_host", root: bus master container
>  Root memory region: system
>   0000000000000000-0000000000ffffff (prio 0, i/o): r2d.flash
>
> After this patch has been applied, access to PCI, ATA, and USB is still
> working, and no negative impact has ben observed.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/sh4/sh_pci.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
> index 71afd23b67..4ced54f1a5 100644
> --- a/hw/sh4/sh_pci.c
> +++ b/hw/sh4/sh_pci.c
> @@ -143,8 +143,6 @@ static void sh_pci_device_realize(DeviceState *dev, Error **errp)
>                            "sh_pci", 0x224);
>      memory_region_init_alias(&s->memconfig_a7, OBJECT(s), "sh_pci.2",
>                               &s->memconfig_p4, 0, 0x224);
> -    memory_region_init_alias(&s->isa, OBJECT(s), "sh_pci.isa",
> -                             get_system_io(), 0, 0x40000);
>      sysbus_init_mmio(sbd, &s->memconfig_p4);
>      sysbus_init_mmio(sbd, &s->memconfig_a7);
>      s->iobr = 0xfe240000;
> --

This change doesn't look correct. This removes the init of the alias MR,
but we continue to use it in other parts of the code -- we will
add it to the system memory at 0xfe240000 and we will remap it
at different addresses when the guest writes to the 0x1c8 "IO space
base" register.

This alias is for the ISA I/O region bridge; the code initially
maps it at a non-zero address:
    s->iobr = 0xfe240000;
    memory_region_add_subregion(get_system_memory(), s->iobr, &s->isa);
so it's not entirely clear how it ends up at 0. You could try
sticking a printf into sh_pci_reg_write() to see if we end
up taking that code path to modify the address for it, which
is the most plausible reason for it to be at 0, I think.

I think the problem here is that our implementation of the
IO space base register is simply completely wrong.

Conveniently, the SSH7751R "user's manual: hardware" seems to
still be downloadable from Renesas at
https://www.renesas.com/br/en/document/hw-manual?hwLayerShowFlg=true&prdLayerId=1057&layerName=SH7751R&coronrService=document-prd-search&hwDocUrl=%2Fpt-br%2Fdoc%2Fproducts%2Fmpumcu%2F001%2Fr01uh0457ej0401_sh7751.pdf&hashKey=a503c1946f0bcc913aaf89f48dd15b53
-- hopefully that URL
works for others and not just me.

Section 22.3.7 and in particular figure 22.3 are clear
about how this is supposed to work: there is a window
at 0xfe240000 in the system register space for PCI I/O
space. When the CPU makes an access into that area,
the PCI controller calculates the PCI address to use
by combining bits 0..17 of the system address with the
bits 31..18 value that the guest has put into the PCIIOBR.
That is, writing to the PCIIOBR changes which section of
the IO address space is visible in the 0xfe240000 window.
Instead what QEMU's implementation does is move the
window to whatever value the guest writes to the PCIIOBR
register -- so if the guest writes 0 we put the window at
0 in system address space.

I think the correct fix would be to have the handling of
PCIIOBR call memory_region_set_alias_offset() (thus updating
where this alias window points within the system IO space),
rather than doing the del/add subregion calls.

thanks
-- PMM

