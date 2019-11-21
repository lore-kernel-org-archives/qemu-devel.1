Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A11C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0672068E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c4R2TJDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0672068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXrn0-0008Kv-O3
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 14:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1iXrmJ-0007rb-U5
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:06:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1iXrmI-0006kP-BL
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:06:07 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39711)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1iXrmI-0006jn-2j
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:06:06 -0500
Received: by mail-pg1-x544.google.com with SMTP id b126so2080570pga.6
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 11:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=5mcwuxyTbI1zTkgh9pi/6qUviZ7Wyie3XS1/favVxb8=;
 b=c4R2TJDHdbQwt3p5ueD3ArBXMicQzzZj9s1+b1BJy/Yq0+na+DCZG2EKF1ncCcgD+e
 9GTyLQTIxeg1fGjOoRzSQNfrWJoMzKEmkO4voZIKkwdMvvsPQa99ShcIERNzcqv4P7AA
 H1u1kXGtdV3FfH+wO9QPyd5gNa4K1aiPmLPbUNUlTZ340WLNwrCy8HCPGJfdF6+9fMZZ
 /L7Tip5N3pfSrWA2ZhfhWmlSv83d191je5rhDFDI7GF4naGXOrN0OWYljxhyMl35Fx2y
 2+OJls+cua83xUH09KUXEHfeiF3ylzgytjxsjeN/a445WvQiRIDt2x7MUDjnv39dAJkb
 wFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=5mcwuxyTbI1zTkgh9pi/6qUviZ7Wyie3XS1/favVxb8=;
 b=BzSKF/Swg3PjBAwhKxqzv9elQoR9zuLqq0q2jqHXa/oGgB6ZfT5oTwPKLRvtmPLpHD
 Xjg6JrC4382YgiQ/11DT2M3mertg2zbr5zT/rReDvnL+Ot5zoyGRJls3Ti1yggXjxXL8
 NVhPk9pwpNkUZ+xuAkGIhHYhJU7Px8T1K1VxJ39GjrVMqi9WKWNTZoZuDm8sI14hghCV
 1TGy/j8eH54uqT18T5UY3OQEp9b8mq9bNvUdi9kcmqP/Xbk/QP+yJIAGZwyZoDr/cCYe
 3Bq1IMzkYxBUVZMjJ2ULQKEg+TmOjyZaLhkiIjtkFU4iP+Dva/QBmo3w3LuJGOEJeI+5
 1XIQ==
X-Gm-Message-State: APjAAAXZFxQuz1N1t2nqzhuv1CR/Hu3nQ6YiwhteDwEv+cimJociNRcV
 kc5Q2DnZxiqTE9ClBAYgvTuhww==
X-Google-Smtp-Source: APXvYqxfidrttdmujpLWjBN1rWQL3/1hBUHGKcKqKWnY5Ha5CXrDgBhcGLtxtUKkQpVu2SOhmEeTvw==
X-Received: by 2002:a63:ff1e:: with SMTP id k30mr11000411pgi.273.1574363164621; 
 Thu, 21 Nov 2019 11:06:04 -0800 (PST)
Received: from localhost ([2620:15c:211:200:12cb:e51e:cbf0:6e3f])
 by smtp.gmail.com with ESMTPSA id s26sm4243744pfh.66.2019.11.21.11.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 11:06:04 -0800 (PST)
Date: Thu, 21 Nov 2019 11:06:04 -0800 (PST)
X-Google-Original-Date: Thu, 21 Nov 2019 11:05:47 PST (-0800)
Subject: Re: [PATCH] RISC-V: virt: This is a "sifive,test1" test finisher
In-Reply-To: <CAKmqyKNTUNMvxxBdE4kZA44a=d9bPWCkrG9ScUp89MkHFteciQ@mail.gmail.com>
CC: david@gibson.dropbear.id.au, Peter Maydell <peter.maydell@linaro.org>,
 palmer@sifive.com, Christoph Hellwig <hch@infradead.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: alistair23@gmail.com
Message-ID: <mhng-4aa5b4bf-df3d-41c9-a597-3396a5626422@palmerdabbelt.mtv.corp.google.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 Nov 2019 10:55:32 PST (-0800), alistair23@gmail.com wrote:
> On Wed, Nov 20, 2019 at 6:40 PM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>>
>> On Sun, 10 Nov 2019 13:10:33 PST (-0800), david@gibson.dropbear.id.au wrote:
>> > On Fri, Nov 08, 2019 at 10:13:16AM -0800, Palmer Dabbelt wrote:
>> >> On Fri, 08 Nov 2019 10:04:47 PST (-0800), Peter Maydell wrote:
>> >> > On Fri, 8 Nov 2019 at 17:15, Alistair Francis <alistair23@gmail.com> wrote:
>> >> > >
>> >> > > On Fri, Nov 8, 2019 at 9:05 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>> >> > > >
>> >> > > > The test finisher implements the reset command, which means it's a
>> >> > > > "sifive,test1" device.  This is a backwards compatible change, so it's
>> >> > > > also a "sifive,test0" device.  I copied the odd idiom for adding a
>> >> > > > two-string compatible field from the ARM virt board.
>> >> > > >
>> >> > > > Fixes: 9a2551ed6f ("riscv: sifive_test: Add reset functionality")
>> >> > > > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>> >> > > > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>> >> > > > ---
>> >> > > >  hw/riscv/virt.c | 5 ++++-
>> >> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
>> >> > > >
>> >> > > > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> >> > > > index 23f340df19..74f2dce81c 100644
>> >> > > > --- a/hw/riscv/virt.c
>> >> > > > +++ b/hw/riscv/virt.c
>> >> > > > @@ -359,7 +359,10 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>> >> > > >      nodename = g_strdup_printf("/test@%lx",
>> >> > > >          (long)memmap[VIRT_TEST].base);
>> >> > > >      qemu_fdt_add_subnode(fdt, nodename);
>> >> > > > -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,test0");
>> >> > > > +    {
>> >> > > > +        const char compat[] = "sifive,test1\0sifive,test0";
>> >> > >
>> >> > > Does this really work? Why not use qemu_fdt_setprop_cells()?
>> >> > >
>> >> > > Alistair
>> >> > >
>> >> > > > +        qemu_fdt_setprop(fdt, nodename, "compatible", compat, sizeof(compat));
>> >> > > > +    }
>> >> >
>> >> > qemu_fdt_setprop_cells() is for "set this property to
>> >> > contain this list of 32-bit integers" (and it does a byteswap
>> >> > of each 32-bit value from host to BE). That's not what
>> >> > you want for a string (or a string list, which is what
>> >> > we have here).
>> >> >
>> >> > Cc'ing David Gibson who's our device tree expert to see if there's
>> >> > a nicer way to write this. Oddly, given that it's used in the
>> >> > ubiquitous 'compatible' prop, the dtc Documentation/manual.txt
>> >> > doesn't say anything about properties being able to be
>> >> > 'string lists', only 'strings', '32 bit numbers', 'lists of
>> >> > 32-bit numbers' and 'byte sequences'. You have to dig through
>> >> > the header file comments to deduce that a string list is
>> >> > represented by a string with embedded NULs separating
>> >> > each list item.
>> >>
>> >> I copied this from hw/arm/virt.c, but messed up.  There they use
>> >>
>> >>        const char compat[] = "arm,armv8-timer\0arm,armv7-timer";
>> >>        qemu_fdt_setprop(vms->fdt, "/timer", "compatible",
>> >>                         compat, sizeof(compat));
>> >
>> > I'm not sure what you're saying is messed up.  AFAICT, this matches
>> > the code you have above, and both should be correct.
>>
>> Sorry, I must have been hallucinating.  For some reason I though I wrote
>> qemu_fdt_setprop_string(... compat).
>>
>> I'd like to take this for 4.2 if possible, but I don't think I have a
>> reviewed-by (I just got my email set up on my Google computer, so it might be
>> messy for a bit).  I'm happy to submit the cleaner valist version after 4.2, as
>> per Peter's suggestion.
>>
>> Alistair: are you OK with this?
>
> Yeah, that works for me.
>
> For 5.0 we can then merge Anup's patch and your series improving the
> multi compat support.

Sounds good.  I think the syscon driver is the right way to go, but I don't
think it's 4.2 material as it's all a bit late.  This one at least fixes the
bug where the DTS and hardware don't match.

> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Alistair
>
>>
>> >> I'll send a v2, but I'd be happy to add some sort of setprop_stringlist
>> >> function.  Maybe we just indicate the length with two '\0's?  IIRC that's
>> >> how other similar-looking data structures are encoded.
>> >>
>> >
>> > --
>> > David Gibson                  | I'll have my music baroque, and my code
>> > david AT gibson.dropbear.id.au        | minimalist, thank you.  NOT _the_ _other_
>> >                               | _way_ _around_!
>> > http://www.ozlabs.org/~dgibson

