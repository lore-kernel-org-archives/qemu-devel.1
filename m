Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F8DC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB83E206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWOl3ry0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB83E206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiNC2-0003Ao-Vb
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 14:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55705)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hiMB0-0005Lc-EC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hiMAy-0007CG-2W
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:02:41 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:36858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hiMAu-00078M-8W; Tue, 02 Jul 2019 13:02:37 -0400
Received: by mail-lj1-x241.google.com with SMTP id i21so17686204ljj.3;
 Tue, 02 Jul 2019 10:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ChUoRWkAHhLCWIaFfkiBx21L+xEyJqsk3crF5O7Mkt8=;
 b=HWOl3ry04Z6ZM4hZGO7Ii6hzxnug2I5reYGZVDtipbdvDCOab8GNX0yFD1UpOzB0Sj
 OoFs64KSc+BQwvV9FCkG4u5pV5uYbOX9K/Z2GeoVXysMKfuKYd/DIDo33Qvsf2gK+r/3
 EMDebkikYwUcbUKe/6Wdv348INp+RHmn3Q+ecvhuyBOICfiWJtKwQs+F11Bqw88oouGK
 y6yUuMyz1LlnjfiZY89tiBWGRAKce0uvTBuZ4xiYl0ALF1vHnsvfE6XuFuIYAypePNE9
 mb5sZ6Dwm6baqkADsLjCppD9cFWp8lsfT5t3gjA9r2iIV62m/W55UyaOrka1BmJFs9re
 JyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ChUoRWkAHhLCWIaFfkiBx21L+xEyJqsk3crF5O7Mkt8=;
 b=H7CA9KdPYx2TB2vlPrVU4HR/0PlcKN0dh+zIVgRkkqQ6aNuC+iGhN8UxKsEAB7r//8
 MHKXamIDutWh0rIIDavXJ6JDiPFEHn+uCWAms+5sL43qI6EGS78L7CdTxsoNnVHFrbyq
 FeBbCvzoVxEzP280Mn1zlD3Cfh4DqdAZ/o5mujoo2pJtGD/emW22sYHdk2vxdQHhV0+s
 nidcYi7xW7gQd1RPNH72SjiguM3LPyHjKuwNJdwZ/AzNBePwXfissTDL+f1ANySUfENl
 OqaIcxXc3WDSG1qOxfpiNPT6ZDL3BEyUMmJPI9Ja6LXiAYwBwoKmtpYx404RXNe4QDHq
 9nbA==
X-Gm-Message-State: APjAAAUguVWXicfXUVokAmFGDbtU3O0/bBMuWjLOQvvkMdNvjuh1BMUS
 yZSxqP9qPmR6ZOrIYjfBzq9ViX2VdWxygjvn5U4=
X-Google-Smtp-Source: APXvYqzKFhU1uaYHVpcHIoDqvw/nReoNXRuoMvqpsusv//XOk8kAmkm+DzIsQXzMzrR9jsqVX+/NdgaTBzAIwkcblvM=
X-Received: by 2002:a2e:86cc:: with SMTP id n12mr17693300ljj.146.1562086952968; 
 Tue, 02 Jul 2019 10:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190701123108.12493-1-philmd@redhat.com>
 <20190701123108.12493-6-philmd@redhat.com>
 <CAKmqyKMWb5LE=gtdDpbEUcceGD9T3V9gNAXfo16sOuQh2hCVgg@mail.gmail.com>
 <4c4ea506-edd8-521d-b75f-31362a75f392@redhat.com>
In-Reply-To: <4c4ea506-edd8-521d-b75f-31362a75f392@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 2 Jul 2019 09:59:29 -0700
Message-ID: <CAKmqyKPMwRAae7N_CQU_u64paOFfmxKfvOnUnBTgq7tvpvCnpw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 5/6] hw/dma/xilinx_axi: Use
 object_initialize_child for correct ref. counting
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
 Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 2, 2019 at 10:00 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 7/2/19 6:18 PM, Alistair Francis wrote:
> > On Mon, Jul 1, 2019 at 5:32 AM Philippe Mathieu-Daud=C3=A9 <philmd@redh=
at.com> wrote:
> >>
> >> As explained in commit aff39be0ed97:
> >>
> >>   Both functions, object_initialize() and object_property_add_child()
> >>   increase the reference counter of the new object, so one of the
> >>   references has to be dropped afterwards to get the reference
> >>   counting right. Otherwise the child object will not be properly
> >>   cleaned up when the parent gets destroyed.
> >>   Thus let's use now object_initialize_child() instead to get the
> >>   reference counting here right.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >
> > Alistair
> >
> >> ---
> >>  hw/dma/xilinx_axidma.c | 16 ++++++++--------
> >>  1 file changed, 8 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> >> index 921be178d9..91f5ec587f 100644
> >> --- a/hw/dma/xilinx_axidma.c
> >> +++ b/hw/dma/xilinx_axidma.c
> >> @@ -563,14 +563,14 @@ static void xilinx_axidma_init(Object *obj)
> >>      XilinxAXIDMA *s =3D XILINX_AXI_DMA(obj);
> >>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> >>
> >> -    object_initialize(&s->rx_data_dev, sizeof(s->rx_data_dev),
> >> -                      TYPE_XILINX_AXI_DMA_DATA_STREAM);
> >> -    object_initialize(&s->rx_control_dev, sizeof(s->rx_control_dev),
> >> -                      TYPE_XILINX_AXI_DMA_CONTROL_STREAM);
> >> -    object_property_add_child(OBJECT(s), "axistream-connected-target"=
,
> >> -                              (Object *)&s->rx_data_dev, &error_abort=
);
> >> -    object_property_add_child(OBJECT(s), "axistream-control-connected=
-target",
> >> -                              (Object *)&s->rx_control_dev, &error_ab=
ort);
> >> +    object_initialize_child(OBJECT(s), "axistream-connected-target",
> >> +                            &s->rx_data_dev, sizeof(s->rx_data_dev),
> >> +                            TYPE_XILINX_AXI_ENET_DATA_STREAM, &error_=
abort,
> >> +                            NULL);
> >> +    object_initialize_child(OBJECT(s), "axistream-control-connected-t=
arget",
> >> +                            &s->rx_control_dev, sizeof(s->rx_control_=
dev),
> >> +                            TYPE_XILINX_AXI_ENET_CONTROL_STREAM, &err=
or_abort,
> >> +                            NULL);
> >>
> >>      sysbus_init_irq(sbd, &s->streams[0].irq);
> >>      sysbus_init_irq(sbd, &s->streams[1].irq);
> >> --
> >> 2.20.1
>
> As GCC suggested, this patch requires this snippet squashed:
>
> -- >8 --
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> @@ -565,11 +565,11 @@ static void xilinx_axidma_init(Object *obj)
>
>      object_initialize_child(OBJECT(s), "axistream-connected-target",
>                              &s->rx_data_dev, sizeof(s->rx_data_dev),
> -                            TYPE_XILINX_AXI_ENET_DATA_STREAM, &error_abo=
rt,
> +                            TYPE_XILINX_AXI_DMA_DATA_STREAM, &error_abor=
t,
>                              NULL);
>      object_initialize_child(OBJECT(s),
> "axistream-control-connected-target",
>                              &s->rx_control_dev, sizeof(s->rx_control_dev=
),
> -                            TYPE_XILINX_AXI_ENET_CONTROL_STREAM,
> &error_abort,
> +                            TYPE_XILINX_AXI_DMA_CONTROL_STREAM,
> &error_abort,
>                              NULL);
>
>      sysbus_init_irq(sbd, &s->streams[0].irq);
> ---

Ah I missed that

>
> Since it was commented in reply to the cover, I assume your R-b stands
> with the snippet applied.

Yeah it does.

Alistair

>
> Thanks for reviewing,
>
> Phil.

