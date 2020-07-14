Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F33BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 02:40:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A25721789
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 02:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVfl+Mkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A25721789
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvArw-0007io-Dr
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 22:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jvAr1-00079G-CH
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 22:39:35 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:33325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jvAqw-0003Zc-A7
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 22:39:34 -0400
Received: by mail-vs1-xe43.google.com with SMTP id o184so31504vsc.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 19:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AHcLMLU0I7VCkHSQgHmqEPXmUwRsuWc9aTFdINvEPI0=;
 b=WVfl+MkvOuOc2oHfip9IPBw3n3REx1qmitJvDLf0lQFyP0LhfAfQCqmtfkFXfKF+Hf
 0CA9UML3yjXtbLCHZd5aEQt9fFwOawyb5t0pdXCVFJoGxBemldMtnKe5HIOnJ051SJyb
 JydKpcYdHIq4Fh3VDwhECg/sz2TbnmQl6mmstZ2AMvNzgSrVrOT7YpCtES8oJJR3u0xL
 /bI+LMqFv3+Xcj9HhfzdyecmvkqG6AIpK/Cg9TeXLNLFj3OQADAZXfe4RlhIB1wCF2j9
 M1BOg0jFSRl0TTH0pYnXp6C8AgU+YUgBqTUVD9dxgVYZ/Nag2b/NGBWs8ScZSxLPub2w
 5dKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AHcLMLU0I7VCkHSQgHmqEPXmUwRsuWc9aTFdINvEPI0=;
 b=PRSB6tnFB8fJfKx1kXhTR5O98AfE1wjTMf0ytwQJXRBWvjOugH2nwCnAd9zC2WUvV0
 MR9V47Zq+Xj/U/3xTkp++xVLIHgbV56WstovyVxLSKk2AQZSvUzRgUhmUeGUFuGBA3Tk
 b7C3zelmI2sJLQa44US22b2sqfl05AHsvG5RgQUmky7qL6caZw85st/yDUvjjGuThXYU
 0fwGwvx0+UywJHNRAzM87RwjmfCdFXYVKiE/HZw2LsCqrNJZ2kTLdZkU1wh/ZALMmCCG
 ubJkZdAUEFWq4nSInbRgsFD/Zn2B4M3ev+1qQwI3fDMLzonsCqeH6iO313PxXJ/H1R+r
 HVBw==
X-Gm-Message-State: AOAM530RGEAX3DSf/WAB6eErLbISjwvG2zLyNl4c89toJu9mQb0L5C4U
 HQwPp0Y8CCJYpV5eNSPXT/MOaADO9JZydg9AKZNaLw==
X-Google-Smtp-Source: ABdhPJy2e+HyMWrP2SMvpSLrxuDDomd1Kf1L8uYalX3echlqdpo58W5e3ez4tdtjJZ9sytiarm2d0epS5frNPSLAVyQ=
X-Received: by 2002:a67:7f8e:: with SMTP id a136mr1722204vsd.232.1594694368846; 
 Mon, 13 Jul 2020 19:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-10-hskinnemoen@google.com>
 <189922e4-b53f-da64-5663-23b599294248@amsat.org>
 <CAFQmdRbY8DHYOOHPREHg63hgLVTVvyMbuMrdauctaBTzaB1=AA@mail.gmail.com>
 <739105bb-5915-bf11-10cc-485ce5e94e73@amsat.org>
In-Reply-To: <739105bb-5915-bf11-10cc-485ce5e94e73@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Mon, 13 Jul 2020 19:39:16 -0700
Message-ID: <CAFQmdRbFB-U4rzNP-wzskQFUa3ZYFvCMyf=wxwnPOHVFej8npA@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] hw/ssi: NPCM7xx Flash Interface Unit device model
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e43;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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

On Mon, Jul 13, 2020 at 10:39 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> On 7/12/20 7:42 AM, Havard Skinnemoen wrote:
> > On Thu, Jul 9, 2020 at 10:00 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
> >> On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
> >>> This implements a device model for the NPCM7xx SPI flash controller.
> >>>
> >>> Direct reads and writes, and user-mode transactions have been tested =
in
> >>> various modes. Protection features are not implemented yet.
> >>>
> >>> All the FIU instances are available in the SoC's address space,
> >>> regardless of whether or not they're connected to actual flash chips.
> >>>
> >>> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> >>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> >>> ---
> >>>  include/hw/arm/npcm7xx.h     |   2 +
> >>>  include/hw/ssi/npcm7xx_fiu.h | 100 +++++++
> >>>  hw/arm/npcm7xx.c             |  53 ++++
> >>>  hw/ssi/npcm7xx_fiu.c         | 510 +++++++++++++++++++++++++++++++++=
++
> >>>  hw/arm/Kconfig               |   1 +
> >>>  hw/ssi/Makefile.objs         |   1 +
> >>>  hw/ssi/trace-events          |   9 +
> >>>  7 files changed, 676 insertions(+)
> >>>  create mode 100644 include/hw/ssi/npcm7xx_fiu.h
> >>>  create mode 100644 hw/ssi/npcm7xx_fiu.c
> [...]
>
> >>> diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
> >>> index 4d227bb74b..c9ff3dab25 100644
> >>> --- a/hw/arm/npcm7xx.c
> >>> +++ b/hw/arm/npcm7xx.c
> >>> @@ -98,6 +98,37 @@ static const hwaddr npcm7xx_uart_addr[] =3D {
> >>>      0xf0004000,
> >>>  };
> >>>
> >>> +static const hwaddr npcm7xx_fiu0_flash_addr[] =3D {
> >>
> >> So per
> >> https://github.com/Nuvoton-Israel/bootblock/blob/master/SWC_HAL/Chips/=
npcm750/npcm750.h
> >> this is SPI0 on AHB18,
> >>
> >>> +    0x80000000,
> >>> +    0x88000000,
> >>
> >> CS0 & CS1,
> >>
> >> also listed:
> >>
> >> 0x90000000, // CS2
> >> 0x98000000, // CS3
> >
> > Confirmed with Nuvoton off-list that these do not exist. SPI0 only
> > supports two chip-selects for direct access.
>
> I suppose Novoton confirmed for the particular npcm750, but you aim
> to model the npcm7xx family. I doubt 2 similar IP blocks are that
> different ;) Anyway with a comment this is good.

OK. I'm mostly concerned about modeling the chips I know about for
now. If a chip with four AXI endpoints and four chipselects on SPI0
appears, it will be a fairly small change to move these arrays into
the SoC class struct, but I'd rather not do that without evidence that
such a chip exist.

The IP blocks may be identical for all I know, but they are not wired
up identically, and that's really what matters here in the SoC-level
model.

> >
> > I'll add comments.
> >
> >>> +};
> >>> +
> >>> +static const hwaddr npcm7xx_fiu3_flash_addr[] =3D {
> >>
> >> Ditto SPI3 on AHB3, and CS0 to CS3.
> >>
> >>> +    0xa0000000,
> >>> +    0xa8000000,
> >>> +    0xb0000000,
> >>> +    0xb8000000,
> >>> +};
> >>> +
> >>> +static const struct {
> >>> +    const char *name;
> >>> +    hwaddr regs_addr;
> >>> +    int cs_count;
> >>> +    const hwaddr *flash_addr;
> >>> +} npcm7xx_fiu[] =3D {
> >>> +    {
> >>> +        .name =3D "fiu0",
> >>> +        .regs_addr =3D 0xfb000000,
> >>> +        .cs_count =3D ARRAY_SIZE(npcm7xx_fiu0_flash_addr),
> >>
> >> Hmm without the datasheet, can't tell, but I'd expect 4 CS
> >> regardless.
> >
> > FIU0/SPI0 only has 2 chip selects.
> >
> >>> +        .flash_addr =3D npcm7xx_fiu0_flash_addr,
> >>> +    }, {
> >>> +        .name =3D "fiu3",
> >>> +        .regs_addr =3D 0xc0000000,
> >>> +        .cs_count =3D ARRAY_SIZE(npcm7xx_fiu3_flash_addr),
> >>> +        .flash_addr =3D npcm7xx_fiu3_flash_addr,
> >>> +    },
> >>> +};
> [...]
>
> >>> +
> >>> +    /* Flash chip model expects one transfer per dummy bit, not byte=
 */
> >>> +    dummy_cycles =3D
> >>> +        (FIU_DRD_CFG_DBW(drd_cfg) * 8) >> FIU_DRD_CFG_ACCTYPE(drd_cf=
g);
> >>> +    for (i =3D 0; i < dummy_cycles; i++) {
> >>> +        ssi_transfer(fiu->spi, 0);
> >>
> >> Note to self, might worth a ssi_shift_dummy(count) generic method.
> >
> > I'm not a huge fan of this interface to be honest. It requires the
> > flash controller to have intimate knowledge of the flash chip, and if
> > it doesn't predict the dummy phase correctly, or the guest programs
> > the wrong number of dummy cycles, the end result is very different
> > from what you'll see on a real system. I'd love to see something like
> > a number-of-bits parameter to ssi_transfer instead.
>
> Do you mean like these?
>
> - ssi_transfer_bit(bool value);
> - ssi_shift_dummy_bits(size_t bits);
>
> Some interfaces allow bit shifting. SPI doesn't simply because
> nobody had the use :)

I mean I don't like how the semantics of ssi_transfer changes
implicitly in the middle of the transfer. One call shifts a whole
byte, the next 8 shift individual bits, then it's back to bytes again.
If a mistake is made, the flash controller might end up thinking it's
shifting 16 bits, but if the flash device only expects 8 dummy bits,
it will see 8 bits + 8 bytes for a total of 9 bytes of dummies. This
differs a lot from what would happen on a real device.

For example, I wrote up a test for the aspeed flash controller against
a Winbond flash chip in Dual I/O mode. The data ended up getting
shifted by 15 bytes because of, I think, bugs in the dummy logic on
both sides. I took a lot of head scratching to figure out what's going
on.

Here's where aspeed_smc figures it needs to send 2 dummy bytes (aka 16
dummy bits) for a DIO read:

https://elixir.bootlin.com/qemu/latest/source/hw/ssi/aspeed_smc.c#L803

And here's where the Winbond model decides to expect one dummy _bit_:

https://elixir.bootlin.com/qemu/latest/source/hw/block/m25p80.c#L862

The difference is 15 ssi_transfers, which is what I see in the test.

IMO they're both wrong -- they should both expect one dummy byte, or
four dummy cycles in x2 mode. But the real problem, also IMO, is that
they can't even agree on whether one ssi_transfer means one bit or one
byte.

While ssi_shift_dummy_bits is strictly nicer than open-coded loops of
ssi_transfer, it doesn't fix the underlying problem that the dummy
cycles need to be treated specially by both the flash controller model
and the device model, and if they're not 100% synchronized (which is
particularly interesting when you have flash chips with configurable
dummy cycles), the result is like nothing you'd ever see on a real
system.

> >
> >>> +    }
> >>> +
> >>> +    for (i =3D 0; i < size; i++) {
> >>> +        value |=3D ssi_transfer(fiu->spi, 0) << (8 * i);
> >>> +    }
> >>> +
> [...]
>
> >>> +static const MemoryRegionOps npcm7xx_fiu_flash_ops =3D {
> >>> +    .read =3D npcm7xx_fiu_flash_read,
> >>> +    .write =3D npcm7xx_fiu_flash_write,
> >>> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> >>> +    .valid =3D {
> >>> +        .min_access_size =3D 1,
> >>> +        .max_access_size =3D 8,
> >>
> >> Are you sure? Maybe, I can' tell.
> >
> > Real hardware supports 16 bytes, but there's no way to do more than 8
> > in emulation, I think?
>
> That would mean you can plug this device on a 128-bit wide bus,
> and you can transfer 128-bit in a single CPU operation.

Hmm, I see what you mean. It can do 16-byte bursts. I'm not sure if
that looks more like a single 16-byte access or four 4-byte accesses
on the SPI bus. I was assuming it's the former, but I could be wrong.

Havard

