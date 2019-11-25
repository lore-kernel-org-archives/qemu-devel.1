Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B51C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 10:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5032071E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 10:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+Xp/hYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5032071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZBMn-0004mI-96
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 05:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZBLf-0004JB-8T
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:12:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZBLd-0002Bv-H4
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:12:03 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZBLd-0002Bb-AO
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:12:01 -0500
Received: by mail-ot1-x341.google.com with SMTP id r24so12040090otk.12
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 02:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=kFLxIXAZZRqTnDHKG4CAmTTRKFhMRyNK61BosGaQDcc=;
 b=K+Xp/hYTPHYY2RsulMlWxmY8yV9IoIU62Blh5DsK6UCE5/DHqZJ5H72cZg0oKc8HIf
 j3tXZmSicg0PR+GGWhOtMhnQ58sUjFnHiumV/dTx0CZhy+WM5louc4d6B/3m9+edMEAc
 K0tRXPemvDaWWD6NnLYFCGA+yGiARSYn0zl95qMqBkn91L+TnHSaiyQZZCXk6E9+Qf1i
 rKS48xWbH4Dat3tDc4eZ9fEYUKqLTaquts3plPf0h20+NgK4Q6Z20f+DSAYU7iaoKkx0
 6sEuxBGrk96cilF9L3kg1BsIpG+oTYCRUF8dzfEefJS3dUcZTvdIxWJcLvOjiX2K1MRm
 ZOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=kFLxIXAZZRqTnDHKG4CAmTTRKFhMRyNK61BosGaQDcc=;
 b=BHs7GA9jKq2IYzDj1/o8zBZ7pl3qE20uW/1nouCFKE9aWPe5fH31gmWPtSVGipcbyh
 BRlpKo8w+R/ccAHMUb0O+UPx+czW3Lx8AEd2PdIvdf3L0md5HZ2lr4VBWOy2BNRuvbHA
 mb37xkDihUEeA7yqJKQ2zEA8GlT4fGkvSltgTHLfUbbAG957rfSzMB56agmZoGh+2OmL
 1Sr6FN5czX1ipUB0I+5KdVWn1IOVLq/LHyek4k2W4AzZ3poiIQsXbr7nTVkEhQoe5cE1
 Nk1K6IY0MnqJ8GFkEUaQoOqSrB7Seh6dnPX94snfsAPWOwsmJOhpvKnfOWwiva/m3YYe
 zoDw==
X-Gm-Message-State: APjAAAUGnOrf8P6PACkpS7UBzgRK9g4uV4BMVj5M56QEXEO5GZU3jWV+
 EXkvMFhoi4GWTmo4kqaO3g/GZhLN/nJlqXtHN0U=
X-Google-Smtp-Source: APXvYqwK/ObaUOq9x/HJ7+jEzG/NJEmY51qqCENZAG5r5RrIoShrDvcVRbklMNMlMz8jicop37U12Eu442GRf4bqQ1c=
X-Received: by 2002:a9d:1b3:: with SMTP id e48mr20484083ote.341.1574676720462; 
 Mon, 25 Nov 2019 02:12:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Mon, 25 Nov 2019 02:12:00
 -0800 (PST)
In-Reply-To: <20191120152442.26657-18-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-18-marcandre.lureau@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 25 Nov 2019 11:12:00 +0100
Message-ID: <CAL1e-=iqhBRcscTEDHczoqTGbCZnu386AX-WHnVdq-0uYA25ug@mail.gmail.com>
Subject: Re: [PATCH v4 17/37] mips: inline serial_init()
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008f307a059828fe8d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008f307a059828fe8d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> The function is specific to mipssim, let's inline it.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/serial.c         | 16 ----------------
>  hw/mips/mips_mipssim.c   | 15 ++++++++++++---
>  include/hw/char/serial.h |  2 --
>  3 files changed, 12 insertions(+), 21 deletions(-)
>
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 164146ede8..23f0b02516 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -1023,22 +1023,6 @@ static const TypeInfo serial_io_info =3D {
>      .class_init =3D serial_io_class_init,
>  };
>
> -SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
> -                         Chardev *chr, MemoryRegion *system_io)
> -{
> -    SerialIO *sio =3D SERIAL_IO(qdev_create(NULL, TYPE_SERIAL_IO));
> -
> -    qdev_prop_set_uint32(DEVICE(sio), "baudbase", baudbase);
> -    qdev_prop_set_chr(DEVICE(sio), "chardev", chr);
> -    qdev_set_legacy_instance_id(DEVICE(sio), base, 2);
> -    qdev_init_nofail(DEVICE(sio));
> -
> -    sysbus_connect_irq(SYS_BUS_DEVICE(sio), 0, irq);
> -    memory_region_add_subregion(system_io, base, &sio->serial.io);
> -
> -    return sio;
> -}
> -
>  static Property serial_properties[] =3D {
>      DEFINE_PROP_CHR("chardev", SerialState, chr),
>      DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index 282bbecb24..bfafa4d7e9 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -40,6 +40,7 @@
>  #include "hw/loader.h"
>  #include "elf.h"
>  #include "hw/sysbus.h"
> +#include "hw/qdev-properties.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/qtest.h"
> @@ -219,9 +220,17 @@ mips_mipssim_init(MachineState *machine)
>       * A single 16450 sits at offset 0x3f8. It is attached to
>       * MIPS CPU INT2, which is interrupt 4.
>       */
> -    if (serial_hd(0))
> -        serial_init(0x3f8, env->irq[4], 115200, serial_hd(0),
> -                    get_system_io());
> +    if (serial_hd(0)) {
> +        DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
> +
> +        qdev_prop_set_uint32(DEVICE(dev), "baudbase", 115200);
> +        qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> +        qdev_set_legacy_instance_id(dev, 0x3f8, 2);
> +        qdev_init_nofail(dev);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
> +        memory_region_add_subregion(get_system_io(), 0x3f8,
> +                                    &SERIAL_IO(dev)->serial.io);
> +    }



Please explain why the code in the deleted function and the new function
are not identical. Why is the new code better?

Thanks, Aleksandar


>
>      if (nd_table[0].used)
>          /* MIPSnet uses the MIPS CPU INT0, which is interrupt 2. */
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index d356ba838c..535fa23a2b 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -108,8 +108,6 @@ void serial_set_frequency(SerialState *s, uint32_t
> frequency);
>  #define TYPE_SERIAL_IO "serial-io"
>  #define SERIAL_IO(s) OBJECT_CHECK(SerialIO, (s), TYPE_SERIAL_IO)
>
> -SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
> -                      Chardev *chr, MemoryRegion *system_io);
>  SerialMM *serial_mm_init(MemoryRegion *address_space,
>                           hwaddr base, int regshift,
>                           qemu_irq irq, int baudbase,
> --
> 2.24.0
>
>
>

--0000000000008f307a059828fe8d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau &lt;<a href=
=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">The function is specific to mipss=
im, let&#39;s inline it.<br>
<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/char/serial.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 16 --------------=
--<br>
=C2=A0hw/mips/mips_mipssim.c=C2=A0 =C2=A0| 15 ++++++++++++---<br>
=C2=A0include/hw/char/serial.h |=C2=A0 2 --<br>
=C2=A03 files changed, 12 insertions(+), 21 deletions(-)<br>
<br>
diff --git a/hw/char/serial.c b/hw/char/serial.c<br>
index 164146ede8..23f0b02516 100644<br>
--- a/hw/char/serial.c<br>
+++ b/hw/char/serial.c<br>
@@ -1023,22 +1023,6 @@ static const TypeInfo serial_io_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.class_init =3D serial_io_class_init,<br>
=C2=A0};<br>
<br>
-SerialIO *serial_init(int base, qemu_irq irq, int baudbase,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Chardev *chr, MemoryRegion *system_io)<br>
-{<br>
-=C2=A0 =C2=A0 SerialIO *sio =3D SERIAL_IO(qdev_create(NULL, TYPE_SERIAL_IO=
));<br>
-<br>
-=C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(<wbr>sio), &quot;baudbase&quot;,=
 baudbase);<br>
-=C2=A0 =C2=A0 qdev_prop_set_chr(DEVICE(sio), &quot;chardev&quot;, chr);<br=
>
-=C2=A0 =C2=A0 qdev_set_legacy_instance_id(<wbr>DEVICE(sio), base, 2);<br>
-=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(sio));<br>
-<br>
-=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_<wbr>DEVICE(sio), 0, irq);<br>
-=C2=A0 =C2=A0 memory_region_add_subregion(<wbr>system_io, base, &amp;sio-&=
gt;<a href=3D"http://serial.io" target=3D"_blank">serial.io</a>);<br>
-<br>
-=C2=A0 =C2=A0 return sio;<br>
-}<br>
-<br>
=C2=A0static Property serial_properties[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_CHR(&quot;chardev&quot;, SerialState, chr),=
<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UINT32(&quot;baudbase&quot;, SerialState, b=
audbase, 115200),<br>
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c<br>
index 282bbecb24..bfafa4d7e9 100644<br>
--- a/hw/mips/mips_mipssim.c<br>
+++ b/hw/mips/mips_mipssim.c<br>
@@ -40,6 +40,7 @@<br>
=C2=A0#include &quot;hw/loader.h&quot;<br>
=C2=A0#include &quot;elf.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
=C2=A0#include &quot;exec/address-spaces.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;sysemu/qtest.h&quot;<br>
@@ -219,9 +220,17 @@ mips_mipssim_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 * A single 16450 sits at offset 0x3f8. It is attached =
to<br>
=C2=A0 =C2=A0 =C2=A0 * MIPS CPU INT2, which is interrupt 4.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 if (serial_hd(0))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_init(0x3f8, env-&gt;irq[4], 115200, ser=
ial_hd(0),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_=
system_io());<br>
+=C2=A0 =C2=A0 if (serial_hd(0)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DeviceState *dev =3D qdev_create(NULL, TYPE_SE=
RIAL_IO);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(<wbr>dev), &quot;b=
audbase&quot;, 115200);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_chr(dev, &quot;chardev&quot;, se=
rial_hd(0));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_set_legacy_instance_id(<wbr>dev, 0x3f8, 2=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_init_nofail(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_<wbr>DEVICE(dev), 0=
, env-&gt;irq[4]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(<wbr>get_system_io=
(), 0x3f8,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;SERIAL_IO(dev)-&g=
t;<a href=3D"http://serial.io" target=3D"_blank">serial.io</a>);<br>
+=C2=A0 =C2=A0 }</blockquote><div><br></div><div><br></div><div>Please expl=
ain why the code in the deleted function and the new function are not ident=
ical. Why is the new code better?</div><div><br></div><div>Thanks, Aleksand=
ar</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0if (nd_table[0].used)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* MIPSnet uses the MIPS CPU INT0, which =
is interrupt 2. */<br>
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h<br>
index d356ba838c..535fa23a2b 100644<br>
--- a/include/hw/char/serial.h<br>
+++ b/include/hw/char/serial.h<br>
@@ -108,8 +108,6 @@ void serial_set_frequency(<wbr>SerialState *s, uint32_t=
 frequency);<br>
=C2=A0#define TYPE_SERIAL_IO &quot;serial-io&quot;<br>
=C2=A0#define SERIAL_IO(s) OBJECT_CHECK(SerialIO, (s), TYPE_SERIAL_IO)<br>
<br>
-SerialIO *serial_init(int base, qemu_irq irq, int baudbase,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Chardev *chr, MemoryRegion *system_io);<br>
=C2=A0SerialMM *serial_mm_init(MemoryRegion *address_space,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 hwaddr base, int regshift,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 qemu_irq irq, int baudbase,<br>
-- <br>
2.24.0<br>
<br>
<br>
</blockquote>

--0000000000008f307a059828fe8d--

