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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EEAC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEEE92071E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcgkqkJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEE92071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZwTV-0005RV-Un
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 07:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZwRF-0004O9-JF
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZwRE-000610-9h
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:28:57 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZwRE-00060e-1y
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:28:56 -0500
Received: by mail-ot1-x343.google.com with SMTP id c19so18931766otr.11
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 04:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=vaa9bfJGQyeUNU4uvVkA9ieAU9FUB0cecVok8R/wDAA=;
 b=OcgkqkJgRoeug1bK75cjZSSASXSCP7/1BNAEGzTP+Vy8jzqoeryLvdfRdTU+BxdWw6
 qtg9MWuqE5ZJN5vkQUo8KrzG1PkaQWq+zgU2cnTcV3j98T9r64JgCC28v59BGZpE2ehA
 dHsyUIpUdvGLVb67vWLZOyyrwGYi6Rp6ilOyW04xlLTZW2nXx9VRXDl/Hf8D/kGn5UFY
 yZEAGcUFJiNHg/DFYPJ442Qw1fAVqBZrd2PhSxHkOVEDLBYKXu08SRJ/JEg7qZPQ+0oi
 FuWWVxHH1lsXHnlojhHleavHGxhXag0bxCwj+BYf4AmGze2pLiiWOtwlkxyzKORdTLm9
 MxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=vaa9bfJGQyeUNU4uvVkA9ieAU9FUB0cecVok8R/wDAA=;
 b=BVYrf8iK2MBu2s9xCvwsq/I/6QQRBwvQwYtfFuJ+xo6C4HfDmoiHV9JPe3HuMlFq1/
 N1U7o9XsUUdy3PJ13e4QVGhxV2BkwHHcSu3WLG+ug8z2AUernmzpiVU80g9cvhj6vdX6
 gONpoC5hyoaWuSD2/FBekmunjPF3MhfPZiuNi1kfn29Xy5O/z2UyoFi1ZOn/mrA2wyHW
 5u93qeKbCyYZhNywRt9dnWVgKMzNEyWyxP33BAowKc50VOi2Q1/dn5vWrmRgcXb3rWZ5
 n1EHYGF6Y0xVJbM0O/5WkBn+uyL9CZnBXu6DSbwDO3SWcqjOD7Dovzfy3jW2adeSW9vE
 B3+g==
X-Gm-Message-State: APjAAAVEN899SYtui3ICZcwjvU89wicZ97PqXNIWr90aB4uvJU62mVf8
 VqH1XiUhkH0M2CI+Q4/k1zv/gJ53arxtHDcB540=
X-Google-Smtp-Source: APXvYqzSe01s9cRzAHUQwisot8WPsJs3GR/1f1aTq/x+B+cEkK0YqGQntTcabUIuCfIw4vuY2ZmUBKfV7jn1NevSyAk=
X-Received: by 2002:a05:6830:81:: with SMTP id a1mr3298104oto.64.1574857734765; 
 Wed, 27 Nov 2019 04:28:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Wed, 27 Nov 2019 04:28:54
 -0800 (PST)
In-Reply-To: <20191120152442.26657-20-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-20-marcandre.lureau@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 27 Nov 2019 13:28:54 +0100
Message-ID: <CAL1e-=j1eWx47fiVWKSTQ-bwn95Bw0tnDpiA8cke7WDMnjL_dw@mail.gmail.com>
Subject: Re: [PATCH v4 19/37] mips: use sysbus_add_io()
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000da3ed0059853236b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000da3ed0059853236b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/mips/mips_mipssim.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
>
I agree with the change, and with overall series in general, but please add
at least a sentence in the commit message here, explaining what is achieved
by the change.

With that sentence, certainly:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index 3cd0e6eb33..2c2c7f25b2 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -227,8 +227,7 @@ mips_mipssim_init(MachineState *machine)
>          qdev_set_legacy_instance_id(dev, 0x3f8, 2);
>          qdev_init_nofail(dev);
>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
> -        memory_region_add_subregion(get_system_io(), 0x3f8,
> -                                    &SERIAL_IO(dev)->serial.io);
> +        sysbus_add_io(SYS_BUS_DEVICE(dev), 0x3f8, &SERIAL_IO(dev)->
> serial.io);
>      }
>
>      if (nd_table[0].used)
> --
> 2.24.0
>
>
>

--000000000000da3ed0059853236b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau &lt;<a href=
=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Signed-off-by: Marc-Andr=C3=A9 Lu=
reau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@re=
dhat.com</a>&gt;<br>
---<br>
=C2=A0hw/mips/mips_mipssim.c | 3 +--<br>
=C2=A01 file changed, 1 insertion(+), 2 deletions(-)<br>
<br></blockquote><div><br></div><div>I agree with the change, and with over=
all series in general, but please add at least a sentence in the commit mes=
sage here, explaining what is achieved by the change.</div><div><br></div><=
div>With that sentence, certainly:</div><div><br></div><div>Reviewed-by: Al=
eksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com">amarkovic@w=
avecomp.com</a>&gt;<br></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c<br>
index 3cd0e6eb33..2c2c7f25b2 100644<br>
--- a/hw/mips/mips_mipssim.c<br>
+++ b/hw/mips/mips_mipssim.c<br>
@@ -227,8 +227,7 @@ mips_mipssim_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_set_legacy_instance_id(<wbr>dev, 0x3=
f8, 2);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_init_nofail(dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_<wbr>DEVICE(de=
v), 0, env-&gt;irq[4]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(<wbr>get_system_io=
(), 0x3f8,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;SERIAL_IO(dev)-&g=
t;<a href=3D"http://serial.io" target=3D"_blank">serial.io</a>);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_add_io(SYS_BUS_DEVICE(<wbr>dev), 0x3f8,=
 &amp;SERIAL_IO(dev)-&gt;<a href=3D"http://serial.io" target=3D"_blank">ser=
ial.io</a>);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (nd_table[0].used)<br>
-- <br>
2.24.0<br>
<br>
<br>
</blockquote>

--000000000000da3ed0059853236b--

