Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BB1C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 00:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9402146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 00:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFL/UHHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9402146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCZAQ-00015Q-B1
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 20:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iCZ9Q-0008Vd-88
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 20:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iCZ9O-0004lP-OT
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 20:57:56 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:44799)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iCZ9O-0004kl-Jj; Mon, 23 Sep 2019 20:57:54 -0400
Received: by mail-yb1-xb44.google.com with SMTP id f1so82138ybq.11;
 Mon, 23 Sep 2019 17:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VIZeAomfu3Do3BOQPSHJ7yIbnXXg4+3vqgDyioWKyZU=;
 b=oFL/UHHpDMTH3J6ih4Baeotq3iUiG05YHX1TQS+tuwWvMJ2jNK/E/N8Pkwzdv2uvWh
 pdceYf2sfb1BBQcJke/jdU4QWVk55J+7BztjId2Ds8Ssx0kCxJDTAiowaAqHMDGaFHoG
 oPdAHCSFlITm71SgqixHLD4MNL5ZDNM7FAQ+nr4DwOROtu2YbNmzS7yJz9j1WHzFk0QH
 rKEvgMciBJRpQIjzxsNPsum/YQ9Mhhurg7JIvWJ42L/eCy2yvzrSdpczGK9UXDe/tsSH
 ghVoYokjy3wTcJkrrLXOoVPUqHlYS4DT8uQrYOQG4wHkkccWSlJshP++D2wwnB7DPC8z
 Ei4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VIZeAomfu3Do3BOQPSHJ7yIbnXXg4+3vqgDyioWKyZU=;
 b=DctszgYfAOZ0LiGcTaxVvw3hfJzdAWEfvbGNX2wv6mJd+vtiN2YK1cMpxCSnebEEPm
 58EfRGP0iTjsZvpiHb+rNlKuqYfyr9lxuHmm99t7Zc0HB9PFvNgOlZzfMKmoWAsP310Z
 Em53+J/P6uHsqXX4SP0QfVvjx6+DAaKocoDXE0G+/izukVDtfKD94JfyZOGXo9sSLirT
 89JYTao5njHpV3RBgp4dZHrFZsOw9OjQ2LuhIV8GlrNrpriSB2wksePoHnNMIR6VOCHj
 lSiigGZN2/oIIOZL0kwpk8+iLExYd/Ygg/wsYIHuU6gew7BXrHh66qMNaNR2Rptj9CXr
 kIiw==
X-Gm-Message-State: APjAAAWr6FXqY03TtvaP/KGoUVw+AAVd1c4Ntxr244bATuXj5lUJ2Yyz
 eIDrSSWUe0YtxFCWgM+xpOVYIoG68CX0yCPGcxI=
X-Google-Smtp-Source: APXvYqxzNwJyY20dPMP5gMzhB3V2SWRuPCoJ9EHRO0sN5xBlvOmEoZnBVDYAQBrB1Q56/BCbxJFDEiNEi+6zJZciBRs=
X-Received: by 2002:a25:a345:: with SMTP id d63mr249133ybi.65.1569286673368;
 Mon, 23 Sep 2019 17:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568931866.git.alistair.francis@wdc.com>
 <d3357e0b87cce025418f6383ce971246ded547bd.1568931866.git.alistair.francis@wdc.com>
 <CAEUhbmV7Ao6L25HM+8AJLP8unn=HhvdRc1Kt+tUQgRB4S4zsBQ@mail.gmail.com>
 <CAKmqyKO=PahfKej1Ch6=x3zcxN8R26Gkd9dsjScMSHPxitp=rA@mail.gmail.com>
 <CAEUhbmVO=POsb+Jpy12w=WD-vLM9Km0YrryaGYc1PLYdSzka5A@mail.gmail.com>
 <CAKmqyKMf+KFQGZCZ9oGLAeGeQkSdrinXDSkpWEGRVjgjDfPAtg@mail.gmail.com>
In-Reply-To: <CAKmqyKMf+KFQGZCZ9oGLAeGeQkSdrinXDSkpWEGRVjgjDfPAtg@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 24 Sep 2019 08:57:43 +0800
Message-ID: <CAEUhbmX9=XskYKs=7rmrSCeVj1qbpyK8YTuD-ZZUdSUg9U-aLA@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] riscv/sifive_u: Add the start-in-flash property
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Chih-Min Chao <chihmin.chao@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 24, 2019 at 1:51 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Sat, Sep 21, 2019 at 7:19 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > On Sat, Sep 21, 2019 at 6:12 AM Alistair Francis <alistair23@gmail.com> wrote:
> > >
> > > On Thu, Sep 19, 2019 at 10:15 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > >
> > > > On Fri, Sep 20, 2019 at 6:32 AM Alistair Francis
> > > > <alistair.francis@wdc.com> wrote:
> > > > >
> > > > > Add a property that when set to true QEMU will jump from the ROM code to
> > > > > the start of flash memory instead of DRAM which is the default
> > > > > behaviour.
> > > > >
> > > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > ---
> > > > >  hw/riscv/sifive_u.c         | 27 +++++++++++++++++++++++++++
> > > > >  include/hw/riscv/sifive_u.h |  2 ++
> > > > >  2 files changed, 29 insertions(+)
> > > > >
> > > > > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > > > > index c3949fb316..b7cd3631cd 100644
> > > > > --- a/hw/riscv/sifive_u.c
> > > > > +++ b/hw/riscv/sifive_u.c
> > > > > @@ -373,6 +373,10 @@ static void riscv_sifive_u_init(MachineState *machine)
> > > > >                                         /* dtb: */
> > > > >      };
> > > > >
> > > > > +    if (s->start_in_flash) {
> > > > > +        reset_vec[6] = memmap[SIFIVE_U_FLASH0].base; /* start: .dword FLASH0_BASE */
> > > > > +    }
> > > > > +
> > > > >      /* copy in the reset vector in little_endian byte order */
> > > > >      for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> > > > >          reset_vec[i] = cpu_to_le32(reset_vec[i]);
> > > > > @@ -544,8 +548,31 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
> > > > >          memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
> > > > >  }
> > > > >
> > > > > +static bool virt_get_start_in_flash(Object *obj, Error **errp)
> > > > > +{
> > > > > +    SiFiveUState *s = RISCV_U_MACHINE(obj);
> > > > > +
> > > > > +    return s->start_in_flash;
> > > > > +}
> > > > > +
> > > > > +static void virt_set_start_in_flash(Object *obj, bool value, Error **errp)
> > > > > +{
> > > > > +    SiFiveUState *s = RISCV_U_MACHINE(obj);
> > > > > +
> > > > > +    s->start_in_flash = value;
> > > > > +}
> > > > > +
> > > > >  static void riscv_sifive_u_machine_instance_init(Object *obj)
> > > > >  {
> > > > > +    SiFiveUState *s = RISCV_U_MACHINE(obj);
> > > > > +
> > > > > +    s->start_in_flash = false;
> > > > > +    object_property_add_bool(obj, "start-in-flash", virt_get_start_in_flash,
> > > > > +                             virt_set_start_in_flash, NULL);
> > > > > +    object_property_set_description(obj, "start-in-flash",
> > > > > +                                    "Set on to tell QEMU's ROM to jump to " \
> > > > > +                                    "flash. Otherwise QEMU will jump to DRAM",
> > > > > +                                    NULL);
> > > > >
> > > > >  }
> > > > >
> > > > > diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> > > > > index a921079fbe..2656b43c58 100644
> > > > > --- a/include/hw/riscv/sifive_u.h
> > > > > +++ b/include/hw/riscv/sifive_u.h
> > > > > @@ -57,6 +57,8 @@ typedef struct SiFiveUState {
> > > > >
> > > > >      void *fdt;
> > > > >      int fdt_size;
> > > > > +
> > > > > +    bool start_in_flash;
> > > > >  } SiFiveUState;
> > > > >
> > > > >  enum {
> > > >
> > > > This patch chose a different way from the one used in patch "[v1,6/6]
> > > > riscv/virt: Jump to pflash if specified":
> > > >
> > > > - this patch uses reset_vec[6] while patch [6/6] defines a variable start_addr
> > > > - this patch adds a "start-in-flash" property to the machine, while
> > > > patch [6/6] tests against drive IF_PFLASH
> > >
> > > Yes, we do it differently for the sifive_u board as the sifive_u board
> > > doesn't use pflash so there is no way to know if the user has loaded
> > > anything into the SPI memory.
> > >
> >
> > OK.
> >
> > > >
> > > > We should be consistent and I would prefer to use the patch [6/6] way.
> > > > On Unleashed an SPI flash is mounted so we cannot add a PFlash to
> > > > sifive_u machine like what was done on virt machine, so we should test
> > > > IF_MTD instead. Thoughts?
> > >
> > > How would we test that?
> > >
> > > Right now I am loading the binary in SPI with the -device loader
> > > option. The machine can't really know what is/isn't loaded there.
> > >
> > > It's not ideal, but I don't see a nicer way.
> >
> > I think we need write a SiFive SPI model to support this in a clean
> > way. Ideally we should simulate the hardware boot workflow as
> > documented in the FU540 manual chapter 6 "Boot Process".
>
> I really didn't want to do this. For me it's low priority and there
> are enough other things to work on rather then adding SiFive device
> models. Maybe someone who works at SiFive would be able to do this?
>
> My hope with this series is that we could unblock firmware developers
> (oreboot and coreboot) while the SPI model is written.
>

OK, so let's set the expectation that this is a temporary flash
solution and will be changed in the future when the SiFive SPI model
is ready.

Regards,
Bin

