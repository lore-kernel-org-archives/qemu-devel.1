Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F27C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6AE820672
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pS+ueSF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AE820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXriy-0006Zw-Vr
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 14:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iXrhv-00064b-T6
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:01:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iXrhu-0003fG-0U
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:01:35 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:46846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iXrhm-0003Ze-75; Thu, 21 Nov 2019 14:01:27 -0500
Received: by mail-lj1-x244.google.com with SMTP id e9so4414252ljp.13;
 Thu, 21 Nov 2019 11:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P5ggWWnP4ZFY7xC6ClkCPevYr9B7Pa4A+rwznV/RBZY=;
 b=pS+ueSF4xua2j57IfcfmNuZ6F0bIfwFhbfOJN0ufsYw7egobIhVYk0AnNov15xWLaL
 OiUCw6fx2moni0rkCxEgbPEV8DMRzegsoQ+CbFcn2DKgYkQN3yHZdZUW7yzmwXOsIj34
 S46eZ6hUF14GNZY8vZXTSEADedtRC/QeRyeHibSkJyrDtKkF7TpU+DjWmT14oLRn/ztm
 1QWT4ohMnbpLFpVULuTrMOWbqAQiuNMpgBXkJSvIbOec9VAayVQGsGwycZx2TSnMZR/3
 PWtx7N1xQaCzZHg04QTKCHuUIx+bvACYkw8wLHw55WMi2aoWfII7mJXAp2vGAMe0wf6c
 UTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P5ggWWnP4ZFY7xC6ClkCPevYr9B7Pa4A+rwznV/RBZY=;
 b=lCvUtG9iJ/3sJiaBdVsZ6gwa5wdeNvOXvAxNnBNyfVAuLBJ/3sGgtqtfwamCS58E74
 EZ/5uxVDagDs3QXHL3R5oAlscNiwK4F4oDe1a+bz9xKvi7gleYOkmUQT5jWJqAJ8Fdhu
 Ykbnll5xNb5Dn8b1yWGUrWhbbwoSYqCj/NZjQB8jftwzLwzLV346M4zE5DVV/KJh9ier
 gFuDZEXH1213KoqjIZ0SeaFuQpOBBJXv6H+w5XLkHXLo6K2s/9DhSjYcj1pGhVyrzP9Z
 Cf7wKko9pAWKmzIzdOf0QydaRazsDcPk4k9CRGWPIXoOCZVQxkc+a/uBXq32HdAvlR5K
 wsKg==
X-Gm-Message-State: APjAAAURlV/4mNwu19JtMltJqsCQESNGV0mjQjuse/AjJTKXyaTYQQiz
 uLrewSBGG9+WHAh08U1s7SGGnxFue9r+oanDxDs=
X-Google-Smtp-Source: APXvYqzeedgafYjyvdhyL0J44fXpqfMN1F7UvTSYxKxHpWAnh7KYNw88yFOKdghjvsfkAZquXWCiduq8EgilTSV0ngY=
X-Received: by 2002:a2e:8188:: with SMTP id e8mr8989346ljg.152.1574362882594; 
 Thu, 21 Nov 2019 11:01:22 -0800 (PST)
MIME-Version: 1.0
References: <20191110211033.GU2461@umbus.Home>
 <mhng-7d7315b7-0ef7-4f14-b152-9d478f15c739@palmerdabbelt.mtv.corp.google.com>
In-Reply-To: <mhng-7d7315b7-0ef7-4f14-b152-9d478f15c739@palmerdabbelt.mtv.corp.google.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 21 Nov 2019 10:55:32 -0800
Message-ID: <CAKmqyKNTUNMvxxBdE4kZA44a=d9bPWCkrG9ScUp89MkHFteciQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: virt: This is a "sifive,test1" test finisher
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Christoph Hellwig <hch@infradead.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 6:40 PM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Sun, 10 Nov 2019 13:10:33 PST (-0800), david@gibson.dropbear.id.au wrote:
> > On Fri, Nov 08, 2019 at 10:13:16AM -0800, Palmer Dabbelt wrote:
> >> On Fri, 08 Nov 2019 10:04:47 PST (-0800), Peter Maydell wrote:
> >> > On Fri, 8 Nov 2019 at 17:15, Alistair Francis <alistair23@gmail.com> wrote:
> >> > >
> >> > > On Fri, Nov 8, 2019 at 9:05 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >> > > >
> >> > > > The test finisher implements the reset command, which means it's a
> >> > > > "sifive,test1" device.  This is a backwards compatible change, so it's
> >> > > > also a "sifive,test0" device.  I copied the odd idiom for adding a
> >> > > > two-string compatible field from the ARM virt board.
> >> > > >
> >> > > > Fixes: 9a2551ed6f ("riscv: sifive_test: Add reset functionality")
> >> > > > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> >> > > > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> >> > > > ---
> >> > > >  hw/riscv/virt.c | 5 ++++-
> >> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> >> > > >
> >> > > > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> >> > > > index 23f340df19..74f2dce81c 100644
> >> > > > --- a/hw/riscv/virt.c
> >> > > > +++ b/hw/riscv/virt.c
> >> > > > @@ -359,7 +359,10 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
> >> > > >      nodename = g_strdup_printf("/test@%lx",
> >> > > >          (long)memmap[VIRT_TEST].base);
> >> > > >      qemu_fdt_add_subnode(fdt, nodename);
> >> > > > -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,test0");
> >> > > > +    {
> >> > > > +        const char compat[] = "sifive,test1\0sifive,test0";
> >> > >
> >> > > Does this really work? Why not use qemu_fdt_setprop_cells()?
> >> > >
> >> > > Alistair
> >> > >
> >> > > > +        qemu_fdt_setprop(fdt, nodename, "compatible", compat, sizeof(compat));
> >> > > > +    }
> >> >
> >> > qemu_fdt_setprop_cells() is for "set this property to
> >> > contain this list of 32-bit integers" (and it does a byteswap
> >> > of each 32-bit value from host to BE). That's not what
> >> > you want for a string (or a string list, which is what
> >> > we have here).
> >> >
> >> > Cc'ing David Gibson who's our device tree expert to see if there's
> >> > a nicer way to write this. Oddly, given that it's used in the
> >> > ubiquitous 'compatible' prop, the dtc Documentation/manual.txt
> >> > doesn't say anything about properties being able to be
> >> > 'string lists', only 'strings', '32 bit numbers', 'lists of
> >> > 32-bit numbers' and 'byte sequences'. You have to dig through
> >> > the header file comments to deduce that a string list is
> >> > represented by a string with embedded NULs separating
> >> > each list item.
> >>
> >> I copied this from hw/arm/virt.c, but messed up.  There they use
> >>
> >>        const char compat[] = "arm,armv8-timer\0arm,armv7-timer";
> >>        qemu_fdt_setprop(vms->fdt, "/timer", "compatible",
> >>                         compat, sizeof(compat));
> >
> > I'm not sure what you're saying is messed up.  AFAICT, this matches
> > the code you have above, and both should be correct.
>
> Sorry, I must have been hallucinating.  For some reason I though I wrote
> qemu_fdt_setprop_string(... compat).
>
> I'd like to take this for 4.2 if possible, but I don't think I have a
> reviewed-by (I just got my email set up on my Google computer, so it might be
> messy for a bit).  I'm happy to submit the cleaner valist version after 4.2, as
> per Peter's suggestion.
>
> Alistair: are you OK with this?

Yeah, that works for me.

For 5.0 we can then merge Anup's patch and your series improving the
multi compat support.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> >> I'll send a v2, but I'd be happy to add some sort of setprop_stringlist
> >> function.  Maybe we just indicate the length with two '\0's?  IIRC that's
> >> how other similar-looking data structures are encoded.
> >>
> >
> > --
> > David Gibson                  | I'll have my music baroque, and my code
> > david AT gibson.dropbear.id.au        | minimalist, thank you.  NOT _the_ _other_
> >                               | _way_ _around_!
> > http://www.ozlabs.org/~dgibson

