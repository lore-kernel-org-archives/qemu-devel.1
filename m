Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543EDC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1B92068E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcC4iRwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1B92068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZwN8-0002TI-B6
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 07:24:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZwMM-00021q-KK
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZwML-0000sK-AE
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:23:54 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZwML-0000s2-4V
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:23:53 -0500
Received: by mail-oi1-x241.google.com with SMTP id s71so19858654oih.11
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 04:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=8v7LYRBk6gjUlVGl4SiqyVH/O3RbsvHtqY4EYTAL01Y=;
 b=HcC4iRwxrVu+l61cE487p9LKyGYYNpDAwkkZoE3Mf4fnD03aUzTm+lgK5thA6q6ZQC
 0PVVFuBrhHtZ/yMRcXDg/TN84ryyiJn4MZBP3csE/2cG4HdA5921a6zJCPQnDCWuRV0U
 bvbt2kJLLzt7IkAZapFA5GMi0aKY2NCnL2BpHgDQ8HLJ2XEewJAbob/UxCSK0rDSlqs9
 0SsXR3haQ0qd913AHue1nt76Zgm5d0kWeHso49dNfql1hqW/7xEKFTAozWzphJ+LsXq5
 wBBXXWP/S+R4pALm5J/M4Vd9Y4VcA/UKBfNvUIjtK6sa8nSFoXZ70tCQnW6Hyp4MwTKX
 ihbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=8v7LYRBk6gjUlVGl4SiqyVH/O3RbsvHtqY4EYTAL01Y=;
 b=HkU3GxbhQoFDEUdbRZSFGSCIjLmMH7tfGSNwkCNHFV9QX3GhknNOjwRFkzI9eg+ZHM
 PlJ5IoV2Kn7NDrq94Ijqi/FSQuKzGPQiLRa0I8Q+a+xxw1Y/Nr+ALWSruyEfx4fS2WFx
 wF7EC9DTyRmOG6oL0ye+oJc5YjiMQUFd571ZFq+Z3jkGTLy7eQCm42bF4GxFCMWBbErr
 aqS6r2XZlNe+c7XUm7LifLpqLKvjR0XrqZagmXRCLlIdXk1g61zcoyN9dcHGREvyKeze
 fb26UIRfU/hAS5a7Ljbb7AHhzIpMhovvNCPlw6Vhuq3VF9kiMd9IGDM5k0I6jF7Tbd4e
 ytLA==
X-Gm-Message-State: APjAAAUsJJGWj2Ik/UudIT16OK09kAlIP90bSP1jZ6B/g9+cH7bFKP6I
 jcE4TqdQcwrBtq9ReOpahkaDW/VjEScPMWMtq0o=
X-Google-Smtp-Source: APXvYqzdusVp7Z/3K5eMCqt+Oq+IUZqFNFgIonSvwbuXfhK52wstvq3LCJF4JYa7hpq+qGkpY7uwF3R2akvKpQvwS9s=
X-Received: by 2002:aca:d17:: with SMTP id 23mr3911616oin.136.1574857432495;
 Wed, 27 Nov 2019 04:23:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Wed, 27 Nov 2019 04:23:52
 -0800 (PST)
In-Reply-To: <20191120152442.26657-21-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-21-marcandre.lureau@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 27 Nov 2019 13:23:52 +0100
Message-ID: <CAL1e-=iAjm=3EdA_mhRrr1Z=+ctcEqYWmTkLWxd_jzbDoT8NbQ@mail.gmail.com>
Subject: Re: [PATCH v4 20/37] mips: use sysbus_mmio_get_region() instead of
 internal fields
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d5fa300598531186"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

--000000000000d5fa300598531186
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Register the memory region with sysbus_init_mmio() and look it up with
> sysbus_mmio_get_region() to avoid accessing internal device fields.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/serial.c       | 1 +
>  hw/mips/mips_mipssim.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 23f0b02516..02c545ff8c 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -993,6 +993,7 @@ static void serial_io_realize(DeviceState *dev, Error
> **errp)
>      qdev_init_nofail(DEVICE(s));
>
>      memory_region_init_io(&s->io, NULL, &serial_io_ops, s, "serial", 8);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(sio), &s->io);
>      sysbus_init_irq(SYS_BUS_DEVICE(sio), &s->irq);
>  }
>
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index 2c2c7f25b2..84c03dd035 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -227,7 +227,8 @@ mips_mipssim_init(MachineState *machine)
>          qdev_set_legacy_instance_id(dev, 0x3f8, 2);
>          qdev_init_nofail(dev);
>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
> -        sysbus_add_io(SYS_BUS_DEVICE(dev), 0x3f8, &SERIAL_IO(dev)->
> serial.io);
> +        sysbus_add_io(SYS_BUS_DEVICE(dev), 0x3f8,
> +                      sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
>      }
>
>      if (nd_table[0].used)
> --
> 2.24.0
>
>
>

--000000000000d5fa300598531186
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau &lt;<a href=
=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Register the memory region with s=
ysbus_init_mmio() and look it up with<br>
sysbus_mmio_get_region() to avoid accessing internal device fields.<br>
<br>
Suggested-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org"=
>peter.maydell@linaro.org</a>&gt;<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/char/serial.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 +<br>
=C2=A0hw/mips/mips_mipssim.c | 3 ++-<br>
=C2=A02 files changed, 3 insertions(+), 1 deletion(-)<br>
<br></blockquote><div><br></div><div>Reviewed-by: Aleksandar Markovic &lt;<=
a href=3D"mailto:amarkovic@wavecomp.com">amarkovic@wavecomp.com</a>&gt;<br>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/hw/char/serial.c b/hw/char/serial.c<br>
index 23f0b02516..02c545ff8c 100644<br>
--- a/hw/char/serial.c<br>
+++ b/hw/char/serial.c<br>
@@ -993,6 +993,7 @@ static void serial_io_realize(DeviceState *dev, Error *=
*errp)<br>
=C2=A0 =C2=A0 =C2=A0qdev_init_nofail(DEVICE(s));<br>
<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init_io(&amp;s-&gt;io, NULL, &amp;serial_=
io_ops, s, &quot;serial&quot;, 8);<br>
+=C2=A0 =C2=A0 sysbus_init_mmio(SYS_BUS_<wbr>DEVICE(sio), &amp;s-&gt;io);<b=
r>
=C2=A0 =C2=A0 =C2=A0sysbus_init_irq(SYS_BUS_<wbr>DEVICE(sio), &amp;s-&gt;ir=
q);<br>
=C2=A0}<br>
<br>
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c<br>
index 2c2c7f25b2..84c03dd035 100644<br>
--- a/hw/mips/mips_mipssim.c<br>
+++ b/hw/mips/mips_mipssim.c<br>
@@ -227,7 +227,8 @@ mips_mipssim_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_set_legacy_instance_id(<wbr>dev, 0x3=
f8, 2);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_init_nofail(dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_<wbr>DEVICE(de=
v), 0, env-&gt;irq[4]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_add_io(SYS_BUS_DEVICE(<wbr>dev), 0x3f8,=
 &amp;SERIAL_IO(dev)-&gt;<a href=3D"http://serial.io" target=3D"_blank">ser=
ial.io</a>);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_add_io(SYS_BUS_DEVICE(<wbr>dev), 0x3f8,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sysbus_mmio_get_region(SYS_<wbr>BUS_DEVICE(dev), 0));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (nd_table[0].used)<br>
-- <br>
2.24.0<br>
<br>
<br>
</blockquote>

--000000000000d5fa300598531186--

