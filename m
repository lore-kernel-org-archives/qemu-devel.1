Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2F8FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295B521835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxoYp470"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295B521835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8Qs-0003go-03
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL7Zp-0000I3-Ff
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL7Zo-0007Hq-6u
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:20:33 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38861)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iL7Zo-0007Hd-20
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:20:32 -0400
Received: by mail-oi1-x242.google.com with SMTP id k10so180279oij.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=iqo5Zqlpayd6YjxQ6ZC6U0axC1xiHVVt/ytQk8CZqoU=;
 b=FxoYp4701kd/Tx4mEdNgThP6veWBjD1NUwXrFLwPlGpHZqLxezuETbuI/AwWTCMvt3
 k/tj4DwU4dMcSACeS8lXexuzK30ikswhDp4VPl45ULpT/qOiVSJG8QunQ+BKtG4IcRWN
 TsMnieYGLWpS++u2VDkGODm53r/1SodLSPcEUB82SrUq/ObI2pmMtp4qJOnzoXVd9NID
 OprVaRQ0Pcll8lBOZrLlHvLQ8NVTFfcmgJBOraw7FTqLgqlyxg+o7My8jztwMvq3o+PY
 IHelmaWKXFA6Ny+aERAEmoUR1fZSFRTNs263B4MhY418IuPmJ1uVxOP7A0PwDWrHNOx3
 aAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=iqo5Zqlpayd6YjxQ6ZC6U0axC1xiHVVt/ytQk8CZqoU=;
 b=r46emLKVglMSmKpuJrg2NM9HcvKw1YbeDTo/ESQJCqk7csujNRN8CysU3djjacr5w+
 pmmzXeXtIiXx35rgLs9v6ufJe0tCwoQ4lqE8ejOAG/MxeVJHuhGy++vYMGPj2UnfelWr
 iAPgjwsHYKXxczLUusUKJ/pDq7+k7g5OIGQvSyk+gaiwJC5qg1RLTakKqu77tRXUPXOm
 DrzfAwVRZNMgWaUoJAmI+hHpgPnRgj9DBbwfieGwyLzEseMqSISm76v5mFeY24ZlrASc
 xT56mUuLldx+7/grGoIfIhFvZTDA2yrnj7WVj83ljypx6+Wj4nqUJMD/gZcvoTHYscmq
 lxFg==
X-Gm-Message-State: APjAAAXYcIYD4WC4bOJbMkGWOD46uI7n/QY7OeDdeLWV6kf2ikA2QLe4
 OdU+pkAqJXVuKZ1Rf6yiUDzqct5Arw/dOOde9ik=
X-Google-Smtp-Source: APXvYqxNu/gR9TK/dcdH4fLfXS8yFZKhTLSUj9bWdFFVazUJOuFTi6v56ofGqB7Yzl3bM1hSKJ/G3uKh5wre3qx8rWc=
X-Received: by 2002:a05:6808:341:: with SMTP id
 j1mr3611992oie.106.1571325631407; 
 Thu, 17 Oct 2019 08:20:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 17 Oct 2019 08:20:30
 -0700 (PDT)
In-Reply-To: <20191015162705.28087-23-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-23-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 17 Oct 2019 17:20:30 +0200
Message-ID: <CAL1e-=hW5uO6DyNZvAqeoA=4QwHt5QhgYD4GiWdKujzqrMURdA@mail.gmail.com>
Subject: Re: [PATCH 22/32] hw/i386/pc: Move gsi_state creation code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000162b0205951cc290"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000162b0205951cc290
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> The block code related to IRQ start few lines later. Move


block code -> code block
start -> starts

the comment and the pc_gsi_create() call

where we start


call -> invocation


> to use the IRQs.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/i386/pc_q35.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 52261962b8..6d096eff28 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -209,9 +209,6 @@ static void pc_q35_init(MachineState *machine)
>                         rom_memory, &ram_memory);
>      }
>
> -    /* irq lines */
> -    gsi_state =3D pc_gsi_create(&pcms->gsi, pcmc->pci_enabled);
> -
>      /* create pci host bus */
>      q35_host =3D Q35_HOST_DEVICE(qdev_create(NULL, TYPE_Q35_HOST_DEVICE)=
);
>
> @@ -245,6 +242,9 @@ static void pc_q35_init(MachineState *machine)
>      object_property_set_link(OBJECT(machine), OBJECT(lpc),
>                               PC_MACHINE_ACPI_DEVICE_PROP, &error_abort);
>
> +    /* irq lines */
> +    gsi_state =3D pc_gsi_create(&pcms->gsi, pcmc->pci_enabled);
> +
>      ich9_lpc =3D ICH9_LPC_DEVICE(lpc);
>      lpc_dev =3D DEVICE(lpc);
>      for (i =3D 0; i < GSI_NUM_PINS; i++) {
> --
> 2.21.0
>
>
>

--000000000000162b0205951cc290
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">The block code related to IRQ start few lines later=
. Move</blockquote><div><br></div><div>block code -&gt; code block</div><di=
v>start -&gt; starts</div><div><br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
the comment and the pc_gsi_create() call=C2=A0</blockquote><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">where we start</blockquote><div><br></div><div>call -&gt; in=
vocation</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
to use the IRQs.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/i386/pc_q35.c | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c<br>
index 52261962b8..6d096eff28 100644<br>
--- a/hw/i386/pc_q35.c<br>
+++ b/hw/i386/pc_q35.c<br>
@@ -209,9 +209,6 @@ static void pc_q35_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 rom_memory, &amp;ram_memory);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /* irq lines */<br>
-=C2=A0 =C2=A0 gsi_state =3D pc_gsi_create(&amp;pcms-&gt;gsi, pcmc-&gt;pci_=
enabled);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0/* create pci host bus */<br>
=C2=A0 =C2=A0 =C2=A0q35_host =3D Q35_HOST_DEVICE(qdev_create(<wbr>NULL, TYP=
E_Q35_HOST_DEVICE));<br>
<br>
@@ -245,6 +242,9 @@ static void pc_q35_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_link(<wbr>OBJECT(machine), OBJECT(l=
pc),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PC_MACHINE_ACPI_DEVICE_PROP, &amp;error_abo=
rt);<br>
<br>
+=C2=A0 =C2=A0 /* irq lines */<br>
+=C2=A0 =C2=A0 gsi_state =3D pc_gsi_create(&amp;pcms-&gt;gsi, pcmc-&gt;pci_=
enabled);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0ich9_lpc =3D ICH9_LPC_DEVICE(lpc);<br>
=C2=A0 =C2=A0 =C2=A0lpc_dev =3D DEVICE(lpc);<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; GSI_NUM_PINS; i++) {<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000162b0205951cc290--

