Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB0FC32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 22:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C3E2468D
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 22:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO8pQ0L4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C3E2468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iswao-0006kZ-Sf
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 17:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iswa9-0006K6-QG
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 17:28:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iswa7-0004jq-UF
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 17:28:41 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:45816)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iswa7-0004jY-Ng; Sat, 18 Jan 2020 17:28:39 -0500
Received: by mail-io1-xd42.google.com with SMTP id i11so29768521ioi.12;
 Sat, 18 Jan 2020 14:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=walFZZcTozveskYiOXwPzNEmRLzkjzl/4sHRkc1mPeg=;
 b=DO8pQ0L41BJDxjeIzzLEec8abCk2v3AIZ97+eFAVH6MXoRpvxTpy43PAFFSHJUNTFP
 dGQd3O5djvSXVQLuOjGsirXhepGQH8NQP7OrU2HyZflJY3sG2KR1tPwDfsWIaWPG0rDE
 SFly7RMmL29V+CypzrmxtG0PPjCKol/da/YFWvJN1NJRPmuZjKvynmS/04XDS4nuqJXL
 zI3tfCSLcWlYzXEzKFmCugh1YaRmKBIf97IhYr36Qse/r2grC1gLF5VFQAtoQ8TuX1ud
 mo25bcob9VWzuNOROYcUQL8NnNfeHIwQ7VZPhav6B6yDSNV/3eb/eVf5P8PZIDgOZlSa
 EQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=walFZZcTozveskYiOXwPzNEmRLzkjzl/4sHRkc1mPeg=;
 b=uR9AZv9FeMC0qqkGOnVgJ0oYIlLMgf3CGzSrWNCotuGBO3obgBB7kIXVIvDCxFnyoG
 Zy2TKCWrJys+oyhx0/s68mtqUDPjGlwl5mCJcmkTckdabciRqTaa2rEicu4t7Z/60VKy
 VrD84dOa0aLOcZ/g5BOjO34XNjHjfonqtAzTTfxIfxc5sfAq59Mzvhz3Qg7Eb9ix21kd
 RCLUpbmHFyIXnTJ30aZWmtW72pedHX4zJP7FcQ2RcjKKeBX6EoyzOuQ6RZbFFIhjAT0r
 Gsry3Z750VyvEmVDi7s2fzGMVZ1lqW2igZDdudwZEF5ugT8tbGR+KcJJJ/mTHJz29D9y
 DKVQ==
X-Gm-Message-State: APjAAAVk7UScrHB0iSSJ8L9nOi8Aq6fb7dTwLksKYqLKF+IitypXexgt
 ZS+tdC/KlqosHtW+DLgeIBONHTlnLSZZ+tKQY44=
X-Google-Smtp-Source: APXvYqyKvpeP+CXwTj6S1ykg2HTeM+G+C2hHtEIUhAAXOZ8PKuUCDf73tjvWQPaSZdJDBp5I0UWIwvbYC5qlAqxBp9o=
X-Received: by 2002:a02:bb02:: with SMTP id y2mr37488577jan.99.1579386518755; 
 Sat, 18 Jan 2020 14:28:38 -0800 (PST)
MIME-Version: 1.0
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-11-nieklinnenbank@gmail.com>
 <9c878f16-b18c-cc1a-9e82-40dbdd31b823@redhat.com>
 <CAPan3WpNxGRfixQp5CwCwTU_boCq4h-BdJgD=KJEhRrGt7S7wg@mail.gmail.com>
 <316c94b7-fea2-f44e-6d31-10fb41b09be3@redhat.com>
In-Reply-To: <316c94b7-fea2-f44e-6d31-10fb41b09be3@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sat, 18 Jan 2020 23:28:27 +0100
Message-ID: <CAPan3WpwidKz+SEN6B=soCERFjzwJTZxQTz2soHdikda6zzNAQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/17] hw/arm/allwinner-h3: add Boot ROM support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000069def1059c7194a3"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000069def1059c7194a3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2020 at 10:09 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
wrote:

> On 1/15/20 12:10 AM, Niek Linnenbank wrote:
> > On Tue, Jan 14, 2020 at 12:28 AM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> >
> >     On 1/8/20 9:00 PM, Niek Linnenbank wrote:
> >      > A real Allwinner H3 SoC contains a Boot ROM which is the
> >      > first code that runs right after the SoC is powered on.
> >      > The Boot ROM is responsible for loading user code (e.g. a
> bootloader)
> >      > from any of the supported external devices and writing the
> downloaded
> >      > code to internal SRAM. After loading the SoC begins executing th=
e
> >     code
> >      > written to SRAM. This commits adds emulation of the Boot ROM
> firmware
> >      > setup functionality by loading user code from SD card.
> >      >
> >      > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com
> >     <mailto:nieklinnenbank@gmail.com>>
> >      > ---
> >      >   include/hw/arm/allwinner-h3.h | 23 +++++++++++++++++++++++
> >      >   hw/arm/allwinner-h3.c         | 28 +++++++++++++++++++++++++++=
+
> >      >   hw/arm/orangepi.c             |  3 +++
> >      >   3 files changed, 54 insertions(+)
> >      >
> >      > diff --git a/include/hw/arm/allwinner-h3.h
> >     b/include/hw/arm/allwinner-h3.h
> >      > index 5d74cca28e..4b66227ac4 100644
> >      > --- a/include/hw/arm/allwinner-h3.h
> >      > +++ b/include/hw/arm/allwinner-h3.h
> >      > @@ -50,6 +50,7 @@
> >      >   #include "hw/sd/allwinner-sdhost.h"
> >      >   #include "hw/net/allwinner-sun8i-emac.h"
> >      >   #include "target/arm/cpu.h"
> >      > +#include "sysemu/block-backend.h"
> >      >
> >      >   /**
> >      >    * Allwinner H3 device list
> >      > @@ -130,4 +131,26 @@ typedef struct AwH3State {
> >      >       MemoryRegion sram_c;
> >      >   } AwH3State;
> >      >
> >      > +/**
> >      > + * Emulate Boot ROM firmware setup functionality.
> >      > + *
> >      > + * A real Allwinner H3 SoC contains a Boot ROM
> >      > + * which is the first code that runs right after
> >      > + * the SoC is powered on. The Boot ROM is responsible
> >      > + * for loading user code (e.g. a bootloader) from any
> >      > + * of the supported external devices and writing the
> >      > + * downloaded code to internal SRAM. After loading the SoC
> >      > + * begins executing the code written to SRAM.
> >      > + *
> >      > + * This function emulates the Boot ROM by copying 32 KiB
> >      > + * of data from the given block device and writes it to
> >      > + * the start of the first internal SRAM memory.
> >      > + *
> >      > + * @s: Allwinner H3 state object pointer
> >      > + * @blk: Block backend device object pointer
> >      > + * @errp: Error object pointer for raising errors
> >      > + */
> >      > +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk=
,
> >      > +                                Error **errp);
> >      > +
> >      >   #endif /* HW_ARM_ALLWINNER_H3_H */
> >      > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> >      > index e692432b4e..e7b768ad5b 100644
> >      > --- a/hw/arm/allwinner-h3.c
> >      > +++ b/hw/arm/allwinner-h3.c
> >      > @@ -27,6 +27,7 @@
> >      >   #include "hw/char/serial.h"
> >      >   #include "hw/misc/unimp.h"
> >      >   #include "hw/usb/hcd-ehci.h"
> >      > +#include "hw/loader.h"
> >      >   #include "sysemu/sysemu.h"
> >      >   #include "hw/arm/allwinner-h3.h"
> >      >
> >      > @@ -168,6 +169,33 @@ enum {
> >      >       AW_H3_GIC_NUM_SPI       =3D 128
> >      >   };
> >      >
> >      > +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk=
,
> >     Error **errp)
> >      > +{
> >      > +    uint8_t *buffer;
> >      > +    int64_t rom_size =3D 32 * KiB;
> >
> >     Why restrict to 32K? The A1 SRAM is 64K.
> >
> >
> > The reason is that the actual Boot ROM on the H3 also uses 32K:
> > https://linux-sunxi.org/BROM
> >
> > See the 'U-Boot SPL Limitations' table at the end of the page.
> >
> > You can see the comment in the table there regarding the 32 KiB:
> >    "Sizes larger than 32 KiB are rejected by the BROM. Exactly 32 KiB i=
s
> > fine, as verified by writing a special pattern at the end of the SPL an=
d
> > checking it in the SRAM."
> > Probably it would not harm to increase it to the full size of the SRAM,
> > but I tried to model
> > the behavior as close to the real hardware as possible.
>
> OK, then please document this difference in the commit description -
> such "While the A1 SRAM is 64K, we limit to 32K because ..." - and add a
> reference to https://linux-sunxi.org/BROM#U-Boot_SPL_limitations
>
> Agreed, I'll add this to the commit message.

--=20
Niek Linnenbank

--00000000000069def1059c7194a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jan 18, 2020 at 10:09 AM Phil=
ippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On 1/15/20 12:10 AM, Niek Linnenbank wrote:<br>
&gt; On Tue, Jan 14, 2020 at 12:28 AM Philippe Mathieu-Daud=C3=A9 <br>
&gt; &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redh=
at.com</a> &lt;mailto:<a href=3D"mailto:philmd@redhat.com" target=3D"_blank=
">philmd@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 1/8/20 9:00 PM, Niek Linnenbank wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; A real Allwinner H3 SoC contains a Boot ROM w=
hich is the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; first code that runs right after the SoC is p=
owered on.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; The Boot ROM is responsible for loading user =
code (e.g. a bootloader)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; from any of the supported external devices an=
d writing the downloaded<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; code to internal SRAM. After loading the SoC =
begins executing the<br>
&gt;=C2=A0 =C2=A0 =C2=A0code<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; written to SRAM. This commits adds emulation =
of the Boot ROM firmware<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; setup functionality by loading user code from=
 SD card.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D=
"mailto:nieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.co=
m</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:nieklinnenbank@gmail.c=
om" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h | 2=
3 +++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 28 ++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A03 files changed, 54 insertions(+)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/include/hw/arm/allwinner-h3.h<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0b/include/hw/arm/allwinner-h3.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 5d74cca28e..4b66227ac4 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/include/hw/arm/allwinner-h3.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -50,6 +50,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;hw/sd/allwinner-sd=
host.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;hw/net/allwinner-s=
un8i-emac.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;target/arm/cpu.h&q=
uot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;sysemu/block-backend.h&quot;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0/**<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 * Allwinner H3 device list<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -130,4 +131,26 @@ typedef struct AwH3State=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_c=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0} AwH3State;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/**<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Emulate Boot ROM firmware setup functiona=
lity.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * A real Allwinner H3 SoC contains a Boot R=
OM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * which is the first code that runs right a=
fter<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * the SoC is powered on. The Boot ROM is re=
sponsible<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * for loading user code (e.g. a bootloader)=
 from any<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * of the supported external devices and wri=
ting the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * downloaded code to internal SRAM. After l=
oading the SoC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * begins executing the code written to SRAM=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * This function emulates the Boot ROM by co=
pying 32 KiB<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * of data from the given block device and w=
rites it to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * the start of the first internal SRAM memo=
ry.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * @s: Allwinner H3 state object pointer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * @blk: Block backend device object pointer=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * @errp: Error object pointer for raising e=
rrors<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +void allwinner_h3_bootrom_setup(AwH3State *s=
, BlockBackend *blk,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error=
 **errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#endif /* HW_ARM_ALLWINNER_H3_H *=
/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/a=
llwinner-h3.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index e692432b4e..e7b768ad5b 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/arm/allwinner-h3.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -27,6 +27,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;hw/char/serial.h&q=
uot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;hw/misc/unimp.h&qu=
ot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;hw/usb/hcd-ehci.h&=
quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/loader.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;sysemu/sysemu.h&qu=
ot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;hw/arm/allwinner-h=
3.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -168,6 +169,33 @@ enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_GIC_NUM_SPI=
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 128<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +void allwinner_h3_bootrom_setup(AwH3State *s=
, BlockBackend *blk,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint8_t *buffer;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int64_t rom_size =3D 32 * KiB;=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Why restrict to 32K? The A1 SRAM is 64K.<br>
&gt; <br>
&gt; <br>
&gt; The reason is that the actual Boot ROM on the H3 also uses 32K:<br>
&gt; <a href=3D"https://linux-sunxi.org/BROM" rel=3D"noreferrer" target=3D"=
_blank">https://linux-sunxi.org/BROM</a><br>
&gt; <br>
&gt; See the &#39;U-Boot SPL Limitations&#39; table at the end of the page.=
<br>
&gt; <br>
&gt; You can see the comment in the table there regarding the 32 KiB:<br>
&gt;=C2=A0 =C2=A0 &quot;Sizes larger than 32 KiB are rejected by the BROM. =
Exactly 32 KiB is <br>
&gt; fine, as verified by writing a special pattern at the end of the SPL a=
nd <br>
&gt; checking it in the SRAM.&quot;<br>
&gt; Probably it would not harm to increase it to the full size of the SRAM=
, <br>
&gt; but I tried to model<br>
&gt; the behavior as close to the real hardware as possible.<br>
<br>
OK, then please document this difference in the commit description - <br>
such &quot;While the A1 SRAM is 64K, we limit to 32K because ...&quot; - an=
d add a <br>
reference to <a href=3D"https://linux-sunxi.org/BROM#U-Boot_SPL_limitations=
" rel=3D"noreferrer" target=3D"_blank">https://linux-sunxi.org/BROM#U-Boot_=
SPL_limitations</a><br>
<br>
</blockquote></div>Agreed, I&#39;ll add this to the commit message.<br clea=
r=3D"all"><div><br>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div d=
ir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></div></div></div>

--00000000000069def1059c7194a3--

