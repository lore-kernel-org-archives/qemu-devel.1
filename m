Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC89C10DCE
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 03:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D90C2073C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 03:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V85oZWt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D90C2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCxR5-0003hF-Dy
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 23:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jCxQS-0003CL-HX
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 23:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jCxQQ-0004Dd-Vm
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 23:25:24 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jCxQQ-0004C1-Qt
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 23:25:22 -0400
Received: by mail-oi1-x242.google.com with SMTP id k8so10270858oik.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 20:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2hgqfvjWcscvMudurRHVi9NDCMxP0UHGLbltL17rbmQ=;
 b=V85oZWt4tNKc8hK3P2QOVXhdbf5L5wBq+TEH97YbFfQWwywRpMZwXnqcW0cU/pgBvx
 k2n82KgXJ2PnXOkTFjpVzu/M++q1MryWSJLfvTyjEz8Fjb5ZqiqqwbsXkI7oA2pc0tC8
 e+Fl6jXFEkGv0giVSgfgQVynYhOpnGUzXQgmjz3MS2kpQ0BXKPaHMTnlWvVpSqBC0B9C
 EkEvb8qtd0xGwlsgD9uiOZNcIo0/bcLOgVIyUz4IjRHmcGPeyrv5IRB0WcirUOJVxGjf
 +sDNC1Q2wI9Ip5Lp7kVU7pzblgaIM62IOeVETMWVZHgXNA0B5t7DesrT1MlBptfRrBZN
 jdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2hgqfvjWcscvMudurRHVi9NDCMxP0UHGLbltL17rbmQ=;
 b=je1fnzhW63OM8iLHWemOrXPVonUv0WfHS5l+OYnOOEsVg9Qn2NDSVp1lkzdKMwu5HM
 FETSQMvG9u4r9Q6P97YuOvfgSX2t4hr2UZXPSy2SDgaYjLSPWGKzLu97sqyNBplSFfH5
 chTDj6HdecdPX2sfv2Gq7LXoVxrZ/WqjLFg5xhARNdokdiPRXAZJ40oqz2Ni5I/UjEV8
 TblsW6Bzf07+/otA0hZfOjqn+u6kpdU1dW5hvku4ZsS/5of4klVhDGHbzEmSZlPGUqXm
 YdxXktmaRV9bR1kchWTTEQPA6ckCD7LCEHhzJumMQ/VshKpyUc6s/q+GXXLjuBLTFQ97
 cjBg==
X-Gm-Message-State: ANhLgQ0ZwQTi2QJ3k9aplI+IlPV5wEc4RXbN++MmavSUzJTvpPP/a8Z1
 XJQfT9m9BjEmJXSQFQ3FKJvZPLJ89li+BHlVkj4=
X-Google-Smtp-Source: ADFU+vuxwni/Dj5U8tS0G7ZS23rU24EnYqo7VLaWH8jJDTF5WtfAa9Sva7sarRsBUjKY/hrBMpE1YoKazy80praAfO4=
X-Received: by 2002:aca:a882:: with SMTP id r124mr9744858oie.53.1584156321887; 
 Fri, 13 Mar 2020 20:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200228032613.1049955-1-jiaxun.yang@flygoat.com>
 <20200303004137.1099502-1-jiaxun.yang@flygoat.com>
 <6b4a7564-eac6-7bd3-b1c0-e9c7ac4e0c80@redhat.com>
In-Reply-To: <6b4a7564-eac6-7bd3-b1c0-e9c7ac4e0c80@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 14 Mar 2020 04:25:11 +0100
Message-ID: <CAL1e-=gEtCtAnsnkO4_E8rqje=n1bHXY_+BXC5P2h5Ld0umNtQ@mail.gmail.com>
Subject: Re: [PATCH v1] mips/mips_malta: Allow more than 2G RAM
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Paul Burton <pburton@wavecomp.com>, Yunqiang Su <ysu@wavecomp.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paul Burton <paul.burton@mips.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 5, 2020 at 11:18 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Please post new patches as v2, and do not post them as reply to v1.
>
> On 3/3/20 1:41 AM, Jiaxun Yang wrote:
> > When malta is coupled with MIPS64 cpu which have 64bit
> > address space, it is possible to have more than 2G RAM.
> >
> > So we removed ram_size check and overwrite memory
> > layout for these targets.
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Suggested-by: Yunqiang Su <ysu@wavecomp.com>
> > --
> > v1: Do not overwrite cmdline when we don't have highmem.
> > ---
> >   hw/mips/mips_malta.c | 29 +++++++++++++++++++++++------
> >   1 file changed, 23 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> > index 6e7ba9235d..4267958f35 100644
> > --- a/hw/mips/mips_malta.c
> > +++ b/hw/mips/mips_malta.c
> > @@ -98,7 +98,8 @@ typedef struct {
> >   } MaltaState;
> >
> >   static struct _loaderparams {
> > -    int ram_size, ram_low_size;
> > +    unsigned int ram_low_size;
> > +    ram_addr_t ram_size;
> >       const char *kernel_filename;
> >       const char *kernel_cmdline;
> >       const char *initrd_filename;
> > @@ -1023,6 +1024,7 @@ static int64_t load_kernel(void)
> >   {
> >       int64_t kernel_entry, kernel_high, initrd_size;
> >       long kernel_size;
> > +    char mem_cmdline[128];
> >       ram_addr_t initrd_offset;
> >       int big_endian;
> >       uint32_t *prom_buf;
> > @@ -1099,20 +1101,33 @@ static int64_t load_kernel(void)
> >       prom_buf =3D g_malloc(prom_size);
> >
> >       prom_set(prom_buf, prom_index++, "%s", loaderparams.kernel_filena=
me);
> > +
> > +    memset(&mem_cmdline[0], 0, sizeof(mem_cmdline));
> > +    if (loaderparams.ram_size > 0x10000000) {
>
> Please use 256 * MiB.
>
> > +        /*
> > +         * Always use cmdline to overwrite mem layout
> > +         * as kernel may reject large emesize.
> > +         */
> > +        sprintf(&mem_cmdline[0],
> > +                "mem=3D0x10000000@0x00000000 mem=3D0x%" PRIx64 "@0x900=
00000",
> > +                loaderparams.ram_size - 0x10000000);
>
> Ditto.
>
> Also please use g_strdup_printf("mem=3D0x%" PRIx64 "@...")/g_free.
>
> > +    }
> > +
> >       if (initrd_size > 0) {
> >           prom_set(prom_buf, prom_index++,
> > -                 "rd_start=3D0x%" PRIx64 " rd_size=3D%" PRId64 " %s",
> > -                 xlate_to_kseg0(NULL, initrd_offset),
> > +                 "%s rd_start=3D0x%" PRIx64 " rd_size=3D%" PRId64 " %s=
",
> > +                 &mem_cmdline[0], xlate_to_kseg0(NULL, initrd_offset),
> >                    initrd_size, loaderparams.kernel_cmdline);
> >       } else {
> > -        prom_set(prom_buf, prom_index++, "%s", loaderparams.kernel_cmd=
line);
> > +        prom_set(prom_buf, prom_index++, "%s %s", &mem_cmdline[0],
> > +                 loaderparams.kernel_cmdline);
> >       }
> >
> >       prom_set(prom_buf, prom_index++, "memsize");
> >       prom_set(prom_buf, prom_index++, "%u", loaderparams.ram_low_size)=
;
> >
> >       prom_set(prom_buf, prom_index++, "ememsize");
> > -    prom_set(prom_buf, prom_index++, "%u", loaderparams.ram_size);
> > +    prom_set(prom_buf, prom_index++, "%lu", loaderparams.ram_size);
> >
> >       prom_set(prom_buf, prom_index++, "modetty0");
> >       prom_set(prom_buf, prom_index++, "38400n8r");
> > @@ -1253,12 +1268,14 @@ void mips_malta_init(MachineState *machine)
> >       /* create CPU */
> >       mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
> >
> > -    /* allocate RAM */
> > +#ifdef TARGET_MIPS32
> > +    /* MIPS32 won't accept more than 2GiB RAM due to limited address s=
pace */
>
> Cc'ing Paul Burton due to commit 94c2b6aff43.
>
> >       if (ram_size > 2 * GiB) {
> >           error_report("Too much memory for this machine: %" PRId64 "MB=
,"
> >                        " maximum 2048MB", ram_size / MiB);
>
> This is annoying, because the CoreLV/CoreFPGA core cards only have 4
> DIMM slots for PC-100 SDRAM, and the Memory Controller of the GT=E2=80=93=
64120A
> north bridge accept at most 256 MiB per SCS for address decoding, so we
> have a maximum of 1 GiB on 32-bit boards.
>
> In 64-bit emulation we use the a 20Kc core, provided by the Core20K core
> card which doesn't use the GT=E2=80=9364120A but the Bonito64. So the mod=
el is
> incorrect... The Bonito64 indeed allow more memory.
>
> Maybe it is time to consider that for 64-bit targets, since we are not
> modelling a Malta core board, we can name it the official 'virt' machine.=
..
>

Philippe, I almost agree 100% with you wrt last three paragraphs.
(in any case, I know much less than you about details of GT-64120A
and Bonito64, but I trust you).

The only area I have a slightly different opinion is that I believe we
should never declare Malta as a virtual board, and try to be within the
boundaries of physical capabilities of real boards, even if in software
(QEMU) we could "enhance" some features.

If we want MIPS virtual board, than we should devise a full blown
virtual board, similar to what was already done for MIPS Android
emulator. I really don't want some real/virtual frankenstein in QEMU
upstream just because it is convenient for let's say a particular
test setup.

Aleksandar

> >           exit(1);
> >       }
> > +#endif
> >
> >       /* register RAM at high address where it is undisturbed by IO */
> >       memory_region_add_subregion(system_memory, 0x80000000, machine->r=
am);
> >
>
>

