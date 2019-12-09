Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369C8C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 20:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F6C20637
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 20:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh9v7OlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F6C20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iePJM-0003pk-1b
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 15:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iePIc-0003GS-Ln
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 15:06:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iePIb-0004oC-BU
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 15:06:30 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45435)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iePIb-0004mG-0O
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 15:06:29 -0500
Received: by mail-ot1-x341.google.com with SMTP id 59so13337363otp.12
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 12:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=d+ByZVq63wZPr81TLmyAK6FA6VkaHrbltx0gGUIWQSY=;
 b=Vh9v7OlGL2uvfBJzOs2ykN9aI1oy7JrlVUUtG0i3gEst3wE4y1ImkWQXAHsF3Vhp77
 h9+Oe/7Pwalw3yKY5sj1ZUIUY7VFpFVKT5zn5vRfpoH8L+9N9TU0+l7OvwRDDbazFDeY
 KlLdD1dxWCOPFohOCahaxDPSBuROCaIjFgX1ATwDq98AgCOykN/P28vZubtHIGqNa5+7
 VI52LERcMek3yWVVY3LyI7r63AutTgPuWJrg/rkFtt265PgZLjfVktWuF7L9lhXNbecv
 gsFus25obrjgFeTaEELOb7+FRgQR4MoYSNmpLSDMU0PloNzL+1c6vIu/32BzxzcWFN7J
 mFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=d+ByZVq63wZPr81TLmyAK6FA6VkaHrbltx0gGUIWQSY=;
 b=pIV0kqN8M0HtJrGCffXEsHPE2VM1p6tZcFf0OxuS4V4NsM66Q8XORsuxNSfe15Z+Jn
 62wpw1mF4YXA6WYNzGhTZqkmih35i1/Xp+XX4dFq1fqQshyLbjcp/THfYTnyEam++HRY
 0rLtSs1y4IH79I8YVQ9j0iUA0v0Lld9y/M30O/2nvZ40g+841Ftw7sUHqVvPVjOzgueN
 En3ANr/R1vveRA+lBoEmj3vXYXD9Ojh/v70roT1T4Sdg4AR8fimE0/4MLDCmkNbzElM8
 dlAA6lpQvg9+Eur4XVsVJF4embufUORTebtSyNT61yT6lNbiR0ihNjtsCByleCwPP51z
 LwjQ==
X-Gm-Message-State: APjAAAVI9CsW3FqK/A+J7foH0cBT7gxawFU8s5bUbcinp11p+mtpIHcp
 Cjpie3Z0L34Ul7HUmvjxhV4QYhnJK14sek4xPGg=
X-Google-Smtp-Source: APXvYqzuhZo1QDNQD2R6pM2hgfkHw9hYYbyG3REOu5boY66PLXMFlKrQXey6wtV2DdxtKMYy5lVH9Z2y4Jk8GFL6H6s=
X-Received: by 2002:a9d:58c9:: with SMTP id s9mr21789707oth.121.1575921988058; 
 Mon, 09 Dec 2019 12:06:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Mon, 9 Dec 2019 12:06:27 -0800 (PST)
In-Reply-To: <20191208183922.13757-17-mrolnik@gmail.com>
References: <20191208183922.13757-1-mrolnik@gmail.com>
 <20191208183922.13757-17-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 9 Dec 2019 21:06:27 +0100
Message-ID: <CAL1e-=j5rgOt-ouWAumVEu0uYcakV7cT7Sppz2J7LhxrL6-Arw@mail.gmail.com>
Subject: Re: [PATCH v38 16/22] target/avr: Add section about AVR into QEMU
 documentation
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000004ae5a705994aee8b"
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004ae5a705994aee8b
Content-Type: text/plain; charset="UTF-8"

On Sunday, December 8, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>  qemu-doc.texi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
>

Very good!!

You can add these nice 5-6 examples that you mentioned in yor cover letter.

Just a heads up, if we change mcu/device model during further review, this
doc section will have to be changed too, of course.

Yours,
Aleksandar


> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 3ddf5c0a68..cea1008800 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -1757,6 +1757,7 @@ differences are mentioned in the following sections.
>  * Microblaze System emulator::
>  * SH4 System emulator::
>  * Xtensa System emulator::
> +* AVR System emulator::
>  @end menu
>
>  @node PowerPC System emulator
> @@ -2532,6 +2533,15 @@ so should only be used with trusted guest OS.
>
>  @c man end
>
> +@node AVR System emulator
> +@section AVR System emulator
> +@cindex system emulation (AVR)
> +
> +Use the executable @file{qemu-system-avr} to emulates a AVR 8 bit based
> machine having one for the following cores: avr1, avr2, avr25, avr3, avr31,
> avr35, avr4, avr5, avr51, avr6, avrtiny, xmega2, xmega3, xmega4, xmega5,
> xmega6 and xmega7.
> +
> +As for now it does not support any real MCUs. However, it does support a
> "sample" board for educational and testing purposes. This "sample" board
> hosts USART & 16 bit timer devices.
> +
> +
>  @node QEMU User space emulator
>  @chapter QEMU User space emulator
>
> --
> 2.17.2 (Apple Git-113)
>
>

--0000000000004ae5a705994aee8b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, December 8, 2019, Michael Rolnik &lt;<a href=3D"mailto:m=
rolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail=
.com">mrolnik@gmail.com</a>&gt;<br>
---<br>
=C2=A0qemu-doc.texi | 10 ++++++++++<br>
=C2=A01 file changed, 10 insertions(+)<br>
<br></blockquote><div><br></div><div><br></div><div>Very good!!</div><div><=
br></div><div>You can add these nice 5-6 examples that you mentioned in yor=
 cover letter.</div><div><br></div><div>Just a heads up, if we change mcu/d=
evice model during further review, this doc section will have to be changed=
 too, of course.</div><div><br></div><div>Yours,</div><div>Aleksandar</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/qemu-doc.texi b/qemu-doc.texi<br>
index 3ddf5c0a68..cea1008800 100644<br>
--- a/qemu-doc.texi<br>
+++ b/qemu-doc.texi<br>
@@ -1757,6 +1757,7 @@ differences are mentioned in the following sections.<=
br>
=C2=A0* Microblaze System emulator::<br>
=C2=A0* SH4 System emulator::<br>
=C2=A0* Xtensa System emulator::<br>
+* AVR System emulator::<br>
=C2=A0@end menu<br>
<br>
=C2=A0@node PowerPC System emulator<br>
@@ -2532,6 +2533,15 @@ so should only be used with trusted guest OS.<br>
<br>
=C2=A0@c man end<br>
<br>
+@node AVR System emulator<br>
+@section AVR System emulator<br>
+@cindex system emulation (AVR)<br>
+<br>
+Use the executable @file{qemu-system-avr} to emulates a AVR 8 bit based ma=
chine having one for the following cores: avr1, avr2, avr25, avr3, avr31, a=
vr35, avr4, avr5, avr51, avr6, avrtiny, xmega2, xmega3, xmega4, xmega5, xme=
ga6 and xmega7.<br>
+<br>
+As for now it does not support any real MCUs. However, it does support a &=
quot;sample&quot; board for educational and testing purposes. This &quot;sa=
mple&quot; board hosts USART &amp; 16 bit timer devices.<br>
+<br>
+<br>
=C2=A0@node QEMU User space emulator<br>
=C2=A0@chapter QEMU User space emulator<br>
=C2=A0<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>

--0000000000004ae5a705994aee8b--

