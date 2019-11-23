Return-Path: <SRS0=9vyd=ZP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CBDC43215
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 14:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53D020679
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 14:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zzg57ilD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53D020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYWGF-0004I6-T9
	for qemu-devel@archiver.kernel.org; Sat, 23 Nov 2019 09:19:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYWFM-0003ry-U7
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 09:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYWFL-00070L-En
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 09:18:48 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iYWFL-000705-9T
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 09:18:47 -0500
Received: by mail-ot1-x342.google.com with SMTP id r24so8702623otk.12
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2019 06:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=DRiPA5+vIbfjIyPJMuxbgIkGVdWT5j/+ogyPSQzDiJo=;
 b=Zzg57ilDGXf/ANa5ytUoJeGXSkS6k2Vro7X4yRs7+MDs81C7kn69efBpS43rzlMoKo
 OFryRrW63YxIdM+6dgol5ugjRQB/4X1lCTBnr8q0vFSVnj3gHnYmItJBmtqJ+JU8Ehou
 YyPuGnNn34GiH42IDiC841RVB2F3ecHWKNrxNv8vMzGZXXWobnITLMWgQ+5PVOrnsFzE
 Yj2A1exk1zmqyRXzFdV7SMmHTAQxTIyoRBsDqBJApc+box+4xoV+QGKX1QGuKaRGF2Lq
 7ttWaY4nIB9Z9OQyMJK5dPymEV2bZ0U/UC5acqp8hdJr9pyGI8wnv/b+jXHi3OdoOgLy
 YODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=DRiPA5+vIbfjIyPJMuxbgIkGVdWT5j/+ogyPSQzDiJo=;
 b=LWPkadnz3IWpHYR1AgIfC8SBRnkJA41/gzTGD70WYYNni/cntYsOPnW3PooHeNftOa
 gPTa6BagpjVlbJJHkskQpxvo3bUo44oXDzelIejG9xqZESbIDenVHC/n9nvSmoxXP310
 O4tFea1pAo6Zch5bNB1vND8f4K1OBT0DbyI9kRlm60KBCDAShWHiIfPuPzsXOh3fraYG
 e2oWgxlnF7M81NAbRCoDgfZWV6O0fsFa4hjkx+3XZf6er80Ly1EMkddRMsbWaW4PAbjx
 YOaCL2R+VnfU+zjJtfmrzRyUtaByXpAfHPPy41msJM8Q7DGxAyrlycWtczks9Z5P69tx
 d58w==
X-Gm-Message-State: APjAAAUY3jbmuCmEGi3tK5shn+Ts5rIDWQ1a/cNt/cKdtoX5ZO9U2VMD
 ouYfvRnlgfI4kpvDYnKgqPnKrBBXljBNdv7WSGM=
X-Google-Smtp-Source: APXvYqxjTSl+ngUm+FUT8VmLRjnSPAooAgQkHJdVG0Nkh6Vjw71POsI62zPjlpTZj02jQn3CVDW/FTMz6N+uLyyTurE=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr15358201otc.295.1574518726382; 
 Sat, 23 Nov 2019 06:18:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sat, 23 Nov 2019 06:18:45
 -0800 (PST)
In-Reply-To: <621e70d1-8a32-4578-29c2-6bcc903f8791@redhat.com>
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-6-git-send-email-aleksandar.markovic@rt-rk.com>
 <0fc4bf6b-3725-e2dd-79aa-bc5b74377b39@redhat.com>
 <CAL1e-=h1GAF-U2NO4BAU1FQ-qF7dwPE1MwgYModi6d1z=yADiQ@mail.gmail.com>
 <621e70d1-8a32-4578-29c2-6bcc903f8791@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 23 Nov 2019 15:18:45 +0100
Message-ID: <CAL1e-=jG+6TG6gqX95g=9JwgXJ9BqaufYpwRVdPkVGFuaKed1A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Add two files to Malta section
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000060dcb20598043547"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000060dcb20598043547
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, November 23, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 11/22/19 9:37 PM, Aleksandar Markovic wrote:
>
>> On Fri, Nov 22, 2019 at 9:28 PM Philippe Mathieu-Daud=C3=A9
>> <philmd@redhat.com> wrote:
>>
>>>
>>> On 11/13/19 2:47 PM, Aleksandar Markovic wrote:
>>>
>>>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>>
>>>> Add two files that were recently introduced in a refactoring,
>>>> that Malta emulation relies on. They are added by this patch
>>>> to Malta section, but they are not added to the general MIPS
>>>> section, since they are really not MIPS-specific, and there
>>>> may be some non-MIPS hardware using them in future.
>>>>
>>>> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>> ---
>>>>    MAINTAINERS | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index ba9ca98..f8a1646 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -959,8 +959,10 @@ M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>
>>>>    R: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>>>>    R: Aurelien Jarno <aurelien@aurel32.net>
>>>>    S: Maintained
>>>> +F: hw/isa/piix4.c
>>>>
>>>
>>> Maybe:
>>>
>>>      F: hw/*/piix4.c
>>>
>>> Or also add:
>>>
>>>      F: hw/acpi/piix4.c
>>>
>>>
>> Philippe, are you sure? hw/acpi/piix4.c is used in PC, not in Malta, no?
>>
>
> It is instantiated via:
>
>   mips_malta_init -> piix4_create -> piix4_pm_init
>
> The ACPI block is part of the PIIX4 chipset and should be mapped
> unconditionally.
>
>
Philippe, OK, sorry I failed to notice this detail. It just looked odd to
me that ACPI and MIPS could be connected, but stranger things happen. I am
going to add

F: hw/acpi/piix4.c

in the next version of this series. Should any change happen in the future,
I leave it to you to update the file list, of course.

Have a great sunny weekend!

Aleksandar



>
> The Malta indeed uses a PIIX4, which is a PIIX3 extended.
>
> The PC uses a Frankenstein PIIX3 with ACPI from PIIX4... I suppose becaus=
e
> it started with a PIIX3, then we wanted power saving features but it was
> too late to switch to the PIIX4, so we abused of the fact than these bloc=
ks
> are exposed internally as PCI devices, so we can overload a PIIX3.
>
> See https://www.mail-archive.com/qemu-devel@nongnu.org/msg601512.html
>
>
> FYI I have a patch ready removing the 'if smbus' check in piix4_create().
>
>    F: hw/mips/mips_malta.c
>>>>    F: hw/mips/gt64xxx_pci.c
>>>> +F: include/hw/southbridge/piix.h
>>>>    F: tests/acceptance/linux_ssh_mips_malta.py
>>>>
>>>>    Mipssim
>>>>
>>>>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>
>>>
>>>
>

--00000000000060dcb20598043547
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, November 23, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a =
href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">On 11/22/19 9:37 PM, Aleksandar Markovic wrote:<b=
r>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Fri, Nov 22, 2019 at 9:28 PM Philippe Mathieu-Daud=C3=A9<br>
&lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.co=
m</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
On 11/13/19 2:47 PM, Aleksandar Markovic wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com" tar=
get=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
<br>
Add two files that were recently introduced in a refactoring,<br>
that Malta emulation relies on. They are added by this patch<br>
to Malta section, but they are not added to the general MIPS<br>
section, since they are really not MIPS-specific, and there<br>
may be some non-MIPS hardware using them in future.<br>
<br>
Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp=
.com" target=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
---<br>
=C2=A0 =C2=A0MAINTAINERS | 2 ++<br>
=C2=A0 =C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index ba9ca98..f8a1646 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -959,8 +959,10 @@ M: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:p=
hilmd@redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0R: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reacto=
s.org" target=3D"_blank">hpoussin@reactos.org</a>&gt;<br>
=C2=A0 =C2=A0R: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net" =
target=3D"_blank">aurelien@aurel32.net</a>&gt;<br>
=C2=A0 =C2=A0S: Maintained<br>
+F: hw/isa/piix4.c<br>
</blockquote>
<br>
Maybe:<br>
<br>
=C2=A0 =C2=A0 =C2=A0F: hw/*/piix4.c<br>
<br>
Or also add:<br>
<br>
=C2=A0 =C2=A0 =C2=A0F: hw/acpi/piix4.c<br>
<br>
</blockquote>
<br>
Philippe, are you sure? hw/acpi/piix4.c is used in PC, not in Malta, no?<br=
>
</blockquote>
<br>
It is instantiated via:<br>
<br>
=C2=A0 mips_malta_init -&gt; piix4_create -&gt; piix4_pm_init<br>
<br>
The ACPI block is part of the PIIX4 chipset and should be mapped unconditio=
nally.<br>
<br></blockquote><div><br></div><div>Philippe, OK, sorry I failed to notice=
 this detail. It just looked odd to me that ACPI and MIPS could be connecte=
d, but stranger things happen. I am going to add</div><div><br></div><div>F=
: hw/acpi/piix4.c<br></div><div><br></div><div>in the next version of this =
series. Should any change happen in the future, I leave it to you to update=
 the file list, of course.</div><div><br></div><div>Have a great sunny week=
end!</div><div><br></div><div>Aleksandar</div><div><br></div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">
<br>
The Malta indeed uses a PIIX4, which is a PIIX3 extended.<br>
<br>
The PC uses a Frankenstein PIIX3 with ACPI from PIIX4... I suppose because =
it started with a PIIX3, then we wanted power saving features but it was to=
o late to switch to the PIIX4, so we abused of the fact than these blocks a=
re exposed internally as PCI devices, so we can overload a PIIX3.<br>
<br>
See <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg601512=
.html" target=3D"_blank">https://www.mail-archive.com/q<wbr>emu-devel@nongn=
u.org/msg601512<wbr>.html</a><br>
<br>
<br>
FYI I have a patch ready removing the &#39;if smbus&#39; check in piix4_cre=
ate().<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
=C2=A0 =C2=A0F: hw/mips/mips_malta.c<br>
=C2=A0 =C2=A0F: hw/mips/gt64xxx_pci.c<br>
+F: include/hw/southbridge/piix.h<br>
=C2=A0 =C2=A0F: tests/acceptance/linux_ssh_mip<wbr>s_malta.py<br>
<br>
=C2=A0 =C2=A0Mipssim<br>
<br>
</blockquote>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
<br>
<br>
</blockquote></blockquote>
<br>
</blockquote>

--00000000000060dcb20598043547--

