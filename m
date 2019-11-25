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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E127C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:47:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1508C2068F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enVEjOSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1508C2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZFdt-0000cF-Sc
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 09:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZFcT-00009o-It
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZFcQ-0001Nm-Bx
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:45:41 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:38878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZFcQ-0001Nc-64
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:45:38 -0500
Received: by mail-oi1-x22a.google.com with SMTP id a14so13298709oid.5
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 06:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=artqHuiH4PqGUk36wHCRDIwkCmyejoDw6Ie1Ey1mQto=;
 b=enVEjOSvXWy2rRF/KZPYMSP/DkP8W1oQIk0hnktI4SSMv0pLN7TGfW4ovNv1VOW8YR
 vG6Dxz6lq09EIwuYGoaelcfcoiIssgufSfJluBETYzhfPPVJ8lk/uRq7ER3gVCglQpKJ
 og0bvroQqrdeZ6GxmtGznKeT/HsodVS6wMrYsO+v7+rveiE2uziqsTkMELp5XiUiXz97
 O2J+yjWxexR+I3vrglHFMg0Ni0r616ojwZt6HmFaWjHffp6Q4umU+lCIrTSOntdIlW8N
 Cm7/XmrElY9meYe8WXy8OfLftRX6P86u+GYD/5vE2PZ0LEUfrN7nXKIPCc8Y1cnIJmVa
 gMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=artqHuiH4PqGUk36wHCRDIwkCmyejoDw6Ie1Ey1mQto=;
 b=MIF1nvjKXwfHubx6FoiXQRAZb99ZiD0/LhUrvbFZWfAjGcDiYe5xnHbpqPg3nrWGFQ
 VeCxGnVcnBh8Fr9zZdo96bJCOCGYSF0lT0Cx90dkksqLnnHjEXJWHwfl8mGrljqaB/m1
 3v4Eopc6v76Y5zJe8T+um02cUm0MhU+TgR5eVYawc/6/CZQq+wdlsatSfhNs8q29T88s
 Z2T2+XCHC0YJiWhoo8nby7YvWjjnWJrhq1VBUNQlGIJlAbORqlXKyOHV2elsfpYYMMHj
 mNgXbTQqybFjPAHEUP38XAEMncT/BnDT1X1PxLgooki+NtcehKV9AOyWmrDuihgBPFSj
 5yIA==
X-Gm-Message-State: APjAAAUVBY4utcdWB2ttFqwg/M9IR5KQnredx+OZIsKHfuI+xwlvkNLY
 7MNXcVXpN6WLDPPVaKbF5sniF4N8k8nuVezA7Ybqkg==
X-Google-Smtp-Source: APXvYqy8UsdQlaUDfoBEQkW/J2B1M39kkMSy8vpC8J9HGwSV3oObRMQz9XTV146szQrSlDq/itQfsEcDfUxOcw9kCH4=
X-Received: by 2002:aca:670b:: with SMTP id z11mr22146172oix.79.1574693136324; 
 Mon, 25 Nov 2019 06:45:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Mon, 25 Nov 2019 06:45:35
 -0800 (PST)
In-Reply-To: <20191125104103.28962-1-philmd@redhat.com>
References: <20191125104103.28962-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 25 Nov 2019 15:45:35 +0100
Message-ID: <CAL1e-=hktyuAzESyZMz3P4a9aq17dsrrzWpyXYfFYn=cWP3e4A@mail.gmail.com>
Subject: Re: [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000055d8e05982cd176"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: Thomas Huth <thuth@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000055d8e05982cd176
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, November 25, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> The r4k machine was introduced in 2005 (6af0bf9c7) and its last
> logical change was in 2005 (9542611a6). After we can count 164
> maintenance commits (QEMU API changes) with the exception of
> 1 fix in 2015 (memory leak, commit 3ad9fd5a).
>
>
Please don't start any deprecation process. This requires certain
consultation within my company. Rest assured that everyone's opinion will
be taken into account while doing consiltation.

Aleksandar

This machine was introduced as a proof of concept to run a MIPS
> CPU. 2 years later, the Malta machine was add (commit 5856de80)
> modeling a real platform.
>
> Note also this machine has no specification except 5 lines in
> the header of this file:
>
>  * emulates a simple machine with ISA-like bus.
>  * ISA IO space mapped to the 0x14000000 (PHYS) and
>  * ISA memory at the 0x10000000 (PHYS, 16Mb in size).
>  * All peripherial devices are attached to this "bus" with
>  * the standard PC ISA addresses.
>
> It is time to deprecate this obsolete machine. Users are
> recommended to use the Malta board, which hardware is well
> documented.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  qemu-deprecated.texi | 5 +++++
>  hw/mips/mips_r4k.c   | 1 +
>  MAINTAINERS          | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 4b4b7425ac..05265b43c8 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -266,6 +266,11 @@ The 'scsi-disk' device is deprecated. Users should
> use 'scsi-hd' or
>
>  @section System emulator machines
>
> +@subsection mips r4k platform (since 4.2)
> +
> +This machine type is very old and unmaintained. Users should use the
> 'malta'
> +machine type instead.
> +
>  @subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)
>
>  These machine types are very old and likely can not be used for live
> migration
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index 70024235ae..0b79ad26cb 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -294,6 +294,7 @@ void mips_r4k_init(MachineState *machine)
>
>  static void mips_machine_init(MachineClass *mc)
>  {
> +    mc->deprecation_reason =3D "use malta machine type instead";
>      mc->desc =3D "mips r4k platform";
>      mc->init =3D mips_r4k_init;
>      mc->block_default_type =3D IF_IDE;
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e5e3e52d6..3b3a88e264 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -972,7 +972,7 @@ F: hw/net/mipsnet.c
>  R4000
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> -S: Maintained
> +S: Obsolete
>  F: hw/mips/mips_r4k.c
>
>  Fulong 2E
> --
> 2.21.0
>
>
>

--000000000000055d8e05982cd176
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, November 25, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">The r4k machine was introduced in 2005 (6af0bf9c7) =
and its last<br>
logical change was in 2005 (9542611a6). After we can count 164<br>
maintenance commits (QEMU API changes) with the exception of<br>
1 fix in 2015 (memory leak, commit 3ad9fd5a).<br>
<br></blockquote><div><br></div><div>Please don&#39;t start any deprecation=
 process. This requires certain consultation within my company. Rest assure=
d that everyone&#39;s opinion will be taken into account while doing consil=
tation.</div><div><br></div><div>Aleksandar</div><div><br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">
This machine was introduced as a proof of concept to run a MIPS<br>
CPU. 2 years later, the Malta machine was add (commit 5856de80)<br>
modeling a real platform.<br>
<br>
Note also this machine has no specification except 5 lines in<br>
the header of this file:<br>
<br>
=C2=A0* emulates a simple machine with ISA-like bus.<br>
=C2=A0* ISA IO space mapped to the 0x14000000 (PHYS) and<br>
=C2=A0* ISA memory at the 0x10000000 (PHYS, 16Mb in size).<br>
=C2=A0* All peripherial devices are attached to this &quot;bus&quot; with<b=
r>
=C2=A0* the standard PC ISA addresses.<br>
<br>
It is time to deprecate this obsolete machine. Users are<br>
recommended to use the Malta board, which hardware is well<br>
documented.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0qemu-deprecated.texi | 5 +++++<br>
=C2=A0hw/mips/mips_r4k.c=C2=A0 =C2=A0| 1 +<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A03 files changed, 7 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi<br>
index 4b4b7425ac..05265b43c8 100644<br>
--- a/qemu-deprecated.texi<br>
+++ b/qemu-deprecated.texi<br>
@@ -266,6 +266,11 @@ The &#39;scsi-disk&#39; device is deprecated. Users sh=
ould use &#39;scsi-hd&#39; or<br>
<br>
=C2=A0@section System emulator machines<br>
<br>
+@subsection mips r4k platform (since 4.2)<br>
+<br>
+This machine type is very old and unmaintained. Users should use the &#39;=
malta&#39;<br>
+machine type instead.<br>
+<br>
=C2=A0@subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)<br>
<br>
=C2=A0These machine types are very old and likely can not be used for live =
migration<br>
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c<br>
index 70024235ae..0b79ad26cb 100644<br>
--- a/hw/mips/mips_r4k.c<br>
+++ b/hw/mips/mips_r4k.c<br>
@@ -294,6 +294,7 @@ void mips_r4k_init(MachineState *machine)<br>
<br>
=C2=A0static void mips_machine_init(MachineClass *mc)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 mc-&gt;deprecation_reason =3D &quot;use malta machine type i=
nstead&quot;;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;desc =3D &quot;mips r4k platform&quot;;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;init =3D mips_r4k_init;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;block_default_type =3D IF_IDE;<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 5e5e3e52d6..3b3a88e264 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -972,7 +972,7 @@ F: hw/net/mipsnet.c<br>
=C2=A0R4000<br>
=C2=A0M: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net">aurelie=
n@aurel32.net</a>&gt;<br>
=C2=A0R: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@rt-rk.co=
m">aleksandar.rikalo@rt-rk.com</a>&gt;<br>
-S: Maintained<br>
+S: Obsolete<br>
=C2=A0F: hw/mips/mips_r4k.c<br>
<br>
=C2=A0Fulong 2E<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000055d8e05982cd176--

