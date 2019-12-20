Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78743C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41684206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URm1iCJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41684206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiPo8-0007dU-S7
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 16:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iiPgX-0000Mx-PK
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:19:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iiPgW-000692-BJ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:19:45 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:36143)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iiPgW-000633-0p; Fri, 20 Dec 2019 16:19:44 -0500
Received: by mail-io1-xd44.google.com with SMTP id r13so723292ioa.3;
 Fri, 20 Dec 2019 13:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wvK5100t3Ru3PwlfUk2/v4Xei+KIXGvop7OqFB75Hek=;
 b=URm1iCJyy1LNBjRcjhwN9rXbzIegcj60MtDPxNz3Nl5fYc0icXOzRNkGfxGkPbU7+H
 KXgj98ZdmP/JZ1ureuzK+XTKoZ/qu7/8/VTw9BMOTrfUmZjQTFsUHUxrZHFFWQxar7JT
 IUID/vyyduOqaVLorokkuRje+uubkegQvz4B9cKhXvPVmzXS97+XSRFy1WH82Zmya2hy
 3koqiapc/vqoFC18cxwxEH+YhStyvOxWfb3pLivsp2iVRaowtmLcaArTbdo0g8k1gGvM
 uoQRYb3wYJFsVyBnnKZzusWfbKPLhQsEdGXtcTep9ctTjYI/VpSPwbtXFFmOlfQVFSwF
 D1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wvK5100t3Ru3PwlfUk2/v4Xei+KIXGvop7OqFB75Hek=;
 b=h/dawX8OZGW8w64zwhx+ykrh3d5bKmJv80e7+YnUxmaIPUob9cNcfOq0Jg9+qFoKg6
 FAjXDc8lSgFDPK8JHe0CWHgqJb4n5O9wlgOZirrNDSot2a9SggFiEDWORdd9lSC0DBaY
 C6UrJBukwOTso9efN4UVKH1H7Wg5xOKVSzgjnHHha2yUhIfpKQgcON7IMYoUZrZ7wH3A
 Ew3l9MYJIEEywxIYOsqsoJoeXm+eq771ImwH2362cGvmDkUXj9DkbyzQiYjqbF7ktCGj
 JsLDIjF9bkEjK+WeZX+2ET3ZhcG2DPyEMHAA4ijIXS0wLekCongu6gfJZW3tL+jVVKHQ
 88bA==
X-Gm-Message-State: APjAAAWPhx7BHU6BNtC1831R7OXh0hwQO+eEfCnWWTNB6XyclwHT1dDH
 v9H4RtGv64zvWNF6HgcE1JoCOPwSza+9pS7oxlI=
X-Google-Smtp-Source: APXvYqzi54ej9Aw+JJeM+h/Mfc57Z57Hfdgo/4amgnk8MvJI+JVnT+d7eMmYiTrTnzlXBV7DGfjmLBstTPK9hNnZRDg=
X-Received: by 2002:a02:856a:: with SMTP id g97mr13625535jai.97.1576876783067; 
 Fri, 20 Dec 2019 13:19:43 -0800 (PST)
MIME-Version: 1.0
References: <20191219185127.24388-1-f4bug@amsat.org>
 <20191219185127.24388-2-f4bug@amsat.org>
In-Reply-To: <20191219185127.24388-2-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 20 Dec 2019 22:19:31 +0100
Message-ID: <CAPan3WpBhM22Jfu-RMwYXyQnDqYMY21hGuWHQsZWhesZGa91+A@mail.gmail.com>
Subject: Re: [PATCH 01/13] hw/timer/allwinner: Use the AW_A10_PIT_TIMER_NR
 definition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000008268b1059a293c14"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008268b1059a293c14
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 7:51 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> We have a definition for this magic value '6', use it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/timer/allwinner-a10-pit.h | 2 +-
>  hw/timer/allwinner-a10-pit.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/timer/allwinner-a10-pit.h
> b/include/hw/timer/allwinner-a10-pit.h
> index 871c95b512..6aceda81ee 100644
> --- a/include/hw/timer/allwinner-a10-pit.h
> +++ b/include/hw/timer/allwinner-a10-pit.h
> @@ -32,7 +32,7 @@
>
>  #define AW_A10_PIT_TIMER_BASE      0x10
>  #define AW_A10_PIT_TIMER_BASE_END  \
> -    (AW_A10_PIT_TIMER_BASE * 6 + AW_A10_PIT_TIMER_COUNT)
> +    (AW_A10_PIT_TIMER_BASE * AW_A10_PIT_TIMER_NR + AW_A10_PIT_TIMER_COUN=
T)
>
>  #define AW_A10_PIT_DEFAULT_CLOCK   0x4
>
> diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
> index aae880f5b3..117e5c7bf8 100644
> --- a/hw/timer/allwinner-a10-pit.c
> +++ b/hw/timer/allwinner-a10-pit.c
> @@ -225,7 +225,7 @@ static void a10_pit_reset(DeviceState *dev)
>      s->irq_status =3D 0;
>      a10_pit_update_irq(s);
>
> -    for (i =3D 0; i < 6; i++) {
> +    for (i =3D 0; i < AW_A10_PIT_TIMER_NR; i++) {
>          s->control[i] =3D AW_A10_PIT_DEFAULT_CLOCK;
>          s->interval[i] =3D 0;
>          s->count[i] =3D 0;
> --
> 2.21.0
>
> Change looks fine to me:
  Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Works fine with -M orangepi-pc and -M cubieboard:
  Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>



--=20
Niek Linnenbank

--0000000000008268b1059a293c14
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 19, 2019 at 7:51 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">We have a definition for this magic value &#39;6&#39;, use it.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0include/hw/timer/allwinner-a10-pit.h | 2 +-<br>
=C2=A0hw/timer/allwinner-a10-pit.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<=
br>
=C2=A02 files changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allwin=
ner-a10-pit.h<br>
index 871c95b512..6aceda81ee 100644<br>
--- a/include/hw/timer/allwinner-a10-pit.h<br>
+++ b/include/hw/timer/allwinner-a10-pit.h<br>
@@ -32,7 +32,7 @@<br>
<br>
=C2=A0#define AW_A10_PIT_TIMER_BASE=C2=A0 =C2=A0 =C2=A0 0x10<br>
=C2=A0#define AW_A10_PIT_TIMER_BASE_END=C2=A0 \<br>
-=C2=A0 =C2=A0 (AW_A10_PIT_TIMER_BASE * 6 + AW_A10_PIT_TIMER_COUNT)<br>
+=C2=A0 =C2=A0 (AW_A10_PIT_TIMER_BASE * AW_A10_PIT_TIMER_NR + AW_A10_PIT_TI=
MER_COUNT)<br>
<br>
=C2=A0#define AW_A10_PIT_DEFAULT_CLOCK=C2=A0 =C2=A00x4<br>
<br>
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c<br=
>
index aae880f5b3..117e5c7bf8 100644<br>
--- a/hw/timer/allwinner-a10-pit.c<br>
+++ b/hw/timer/allwinner-a10-pit.c<br>
@@ -225,7 +225,7 @@ static void a10_pit_reset(DeviceState *dev)<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;irq_status =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0a10_pit_update_irq(s);<br>
<br>
-=C2=A0 =C2=A0 for (i =3D 0; i &lt; 6; i++) {<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; AW_A10_PIT_TIMER_NR; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;control[i] =3D AW_A10_PIT_DEFAULT_C=
LOCK;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;interval[i] =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;count[i] =3D 0;<br>
-- <br>
2.21.0<br>
<br></blockquote><div>Change looks fine to me:</div><div>=C2=A0 Reviewed-by=
: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">nieklinne=
nbank@gmail.com</a>&gt;<br></div><div><br></div><div>Works fine with -M ora=
ngepi-pc and -M cubieboard:</div><div>=C2=A0 Tested-by: Niek Linnenbank &lt=
;<a href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&g=
t;<br></div><div>=C2=A0</div></div><br clear=3D"all"><br>-- <br><div dir=3D=
"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><b=
r></div></div></div></div>

--0000000000008268b1059a293c14--

