Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D78ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 859CC20820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4jJb2tT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859CC20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7R6-0005br-Bo
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL6sl-00049h-RE
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL6sk-0007Fa-KU
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:36:03 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iL6sk-0007Ew-Es
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:36:02 -0400
Received: by mail-oi1-x241.google.com with SMTP id i16so2348952oie.4
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=uoqXoNs2LoAPyrbyhO0NvR/1ERyd3K1Kj3cNdM/97VE=;
 b=S4jJb2tTjU1v0Phn8M2EinnGzwqHSvgXonbZAfrcmHKzccKBbcH3yJ2obqyYvLSQDf
 Vwr0/6fwNHsz4cD0VBGZsrOzQJURDmtu32j/xUbSLWGti+LScimHfQDwNoIKr1zk+nRA
 /rENa0Nvog76k28mXnV/rRXsfMJ2EpwIQt6ETsvAjYcYm6BtH+DTQae1DmbcUxHId0Q2
 kg5XvgThOdYm2RGO7E4asizKNRdvWzhUPxb0rn9IGIgUQrN1vV8BXhU4CqDLnr4DajWO
 +tsHNxq+j4Tb+fL6ZpuZtkqMtrj2kSQ7YjVMEw1HSZeNKo6rXJ2fkk3UfNeI5kqcJ4V/
 +Vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=uoqXoNs2LoAPyrbyhO0NvR/1ERyd3K1Kj3cNdM/97VE=;
 b=NCexPdDGxXn1PDep5mjh3f8qbrL97pmWY7QMZsJ78B4a7letiRrobcNOZ8fhByLqEr
 mBkZmKa0YbgB5flgw++m0ssfVY+zx6T9Wgn0WdA2FjK3SGs9WY87hKBeFUWuVunkUguW
 4+CYNecs6nF3jHF4qqX7DaOgvnpXPTr0pb9DORvNj82UIGbAnOPexVkWmYtVne/003WX
 mnlTJWEXUVhpknGxEJ0QfMsCf28pBDEqk7A+hMp0Vp65rwrG7ZjY1VUwvTAbCtmeD19w
 RdJaIfLFRZNNCoBaAVB8peLkKC24FS3KVyoKrfLEtmvvJDuQ0NTyj7hviE/89hyYDzFs
 jzNg==
X-Gm-Message-State: APjAAAVRv3NKGR2kphgWjOzZloOIvZHooIok72XoRKagpN0/voVuxcTO
 K2CZ0r45Onsc6qASnPSmBfAOvOitlXZK7FNNkUU=
X-Google-Smtp-Source: APXvYqyxc0yZOuJXvIGCMLrVsxo/ln5gqaCZCg/wBkXk/+HjIK69V2xpYVAOGOqcyHe0/x0BJ5BKi6eRlE94PQIoo4s=
X-Received: by 2002:aca:4e56:: with SMTP id c83mr3526497oib.53.1571322958328; 
 Thu, 17 Oct 2019 07:35:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 17 Oct 2019 07:35:57
 -0700 (PDT)
In-Reply-To: <20191015162705.28087-8-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-8-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 17 Oct 2019 16:35:57 +0200
Message-ID: <CAL1e-=iYAY006fj-vWELCVaqNkYr19oM3rCQf8CfTScZg0+0uA@mail.gmail.com>
Subject: Re: [PATCH 07/32] MAINTAINERS: Keep PIIX4 South Bridge separate from
 PC Chipsets
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c23a7205951c2233"
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
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

--000000000000c23a7205951c2233
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> The PIIX4 Southbridge is not used by the PC machine,
> but by the Malta board (MIPS). Add a new section to
> keep it covered.
>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)


Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe4dc51b08..c9f625fc2e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1230,7 +1230,6 @@ F: hw/pci-host/q35.c
>  F: hw/pci-host/pam.c
>  F: include/hw/pci-host/q35.h
>  F: include/hw/pci-host/pam.h
> -F: hw/isa/piix4.c
>  F: hw/isa/lpc_ich9.c
>  F: hw/i2c/smbus_ich9.c
>  F: hw/acpi/piix4.c
> @@ -1716,6 +1715,12 @@ F: hw/display/edid*
>  F: include/hw/display/edid.h
>  F: qemu-edid.c
>
> +PIIX4 South Bridge (i82371AB)
> +M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> +M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> +S: Maintained
> +F: hw/isa/piix4.c
> +
>  Firmware configuration (fw_cfg)
>  M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>  R: Laszlo Ersek <lersek@redhat.com>
> --
> 2.21.0
>
>
>

--000000000000c23a7205951c2233
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">From: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"ma=
ilto:f4bug@amsat.org">f4bug@amsat.org</a>&gt;<br>
<br>
The PIIX4 Southbridge is not used by the PC machine,<br>
but by the Malta board (MIPS). Add a new section to<br>
keep it covered.<br>
<br>
Suggested-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@=
redhat.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS | 7 ++++++-<br>
=C2=A01 file changed, 6 insertions(+), 1 deletion(-)</blockquote><div><div =
id=3D"cvcmsg_16dbfeb33c93ed97" class=3D"yh  " style=3D"border-top-left-radi=
us:0px;border-top-right-radius:0px;margin-bottom:11px;overflow:visible"><di=
v class=3D"Vh" id=3D"cvcfullmsg_16dbfeb33c93ed97"><div id=3D"cvcmsgbod_16db=
feb33c93ed97" class=3D"aj"><div class=3D"Ni"><div class=3D"ni pi " dir=3D"l=
tr"><p dir=3D"ltr"><br></p><p dir=3D"ltr">Reviewed-by: Aleksandar Markovic =
&lt;<a href=3D"mailto:amarkovic@wavecomp.com" target=3D"_blank">amarkovic@w=
avecomp.com</a>&gt;</p><div style=3D"clear:both"></div></div><div style=3D"=
clear:both"></div><div><div class=3D"M j T b hc Aj S" tabindex=3D"0"><div c=
lass=3D"V j hf"></div></div></div><div style=3D"clear:both"></div></div></d=
iv></div></div><div id=3D"cvcmsg_16dbfecd588da1f7" class=3D"yh" style=3D"ma=
rgin-bottom:11px"><div class=3D"Vh" id=3D"cvcfullmsg_16dbfecd588da1f7"><div=
 class=3D"M j Zi Mi  " tabindex=3D"0"><div id=3D"cvcreply_16dbfecd588da1f7"=
 class=3D"M j T b hc xh S  " tabindex=3D"0"><div class=3D"V j td"></div></d=
iv></div></div></div></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index fe4dc51b08..c9f625fc2e 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -1230,7 +1230,6 @@ F: hw/pci-host/q35.c<br>
=C2=A0F: hw/pci-host/pam.c<br>
=C2=A0F: include/hw/pci-host/q35.h<br>
=C2=A0F: include/hw/pci-host/pam.h<br>
-F: hw/isa/piix4.c<br>
=C2=A0F: hw/isa/lpc_ich9.c<br>
=C2=A0F: hw/i2c/smbus_ich9.c<br>
=C2=A0F: hw/acpi/piix4.c<br>
@@ -1716,6 +1715,12 @@ F: hw/display/edid*<br>
=C2=A0F: include/hw/display/edid.h<br>
=C2=A0F: qemu-edid.c<br>
<br>
+PIIX4 South Bridge (i82371AB)<br>
+M: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reactos.org">hpous=
sin@reactos.org</a>&gt;<br>
+M: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bu=
g@amsat.org</a>&gt;<br>
+S: Maintained<br>
+F: hw/isa/piix4.c<br>
+<br>
=C2=A0Firmware configuration (fw_cfg)<br>
=C2=A0M: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.co=
m">philmd@redhat.com</a>&gt;<br>
=C2=A0R: Laszlo Ersek &lt;<a href=3D"mailto:lersek@redhat.com">lersek@redha=
t.com</a>&gt;<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000c23a7205951c2233--

