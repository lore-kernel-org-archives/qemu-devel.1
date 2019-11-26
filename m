Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9D7C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A84E20722
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7jC/PyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A84E20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZZrR-0003Qa-Dg
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 07:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iZZql-00030j-5f
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iZZqi-0007d2-Bh
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:21:47 -0500
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:39146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aaron.zakhrov@gmail.com>)
 id 1iZZqg-0007aH-BC
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:21:42 -0500
Received: by mail-il1-x141.google.com with SMTP id a7so17413182ild.6
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 04:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L7idlf4WG4KbKdOgy3A/FLmv2haa9/g9ZRNEuXJW5Yg=;
 b=u7jC/PyIEK8qOn8dMybpDjinChstnl6TIOSD/+cBbTUZnXXwbiktgb1O6+eJetwBhh
 ssTW5slIDXVdV294PuQYfFuCDTmsbL+EQkJ4zEn6/Wbk61IAQIjuKn7zb25RueRd7TSM
 Cj0a2bOMvmkqtfqMSpvfM9rY1bkzEz1gh7PoWHEP3sIQg5Pno8Kv31nQFmXBLf2g8BU8
 n4WAn+jgjEQvEZJViJiAadh8+DX1iERpbj1HVDe5lKAsghsjvaxh/YuNuKrrSkzJCd8V
 BDsxYHhIWe1+FBIx0kFJQPz1/zP7xD0xfItwYvi8khd9usImPwGqyDeFFBU2TTomyIym
 TzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L7idlf4WG4KbKdOgy3A/FLmv2haa9/g9ZRNEuXJW5Yg=;
 b=LHvqBmpjX72Eh9cnm6cs/bd1AMnXHhZCCD0K89Khq2J8vY/o8TNZuvNUYV917rmpQx
 WxLSVNMpZqac9OZWmFgbhVMJzZeZVi2zKAI/OVa/1rkVOJ5jk+nPEJcNx077p+J5vnBu
 HmaKmYMuh22E1A5tXWI4M+WWHYAPI9b6257Tps/dc0ly+E5W+O+I551TRAg6l2b7gK97
 +I4csvIG87pxzGBuHovBHiuRgOqIfDVlOYKbDeKx1GvUlep18l/6rkvV+kLIjBOKZFxu
 JdMXw3YbGAy+yX62ZBDtMpoxcY/TZs1GkLdRCGV76d08BzatJw2uh5NP3V7viqshUp7c
 96dg==
X-Gm-Message-State: APjAAAUqaLCSlgpb+9lXj4gxH+NeJ3E4NJsxVqW4xr56x1SonQgn3VIG
 PU6Hxhrn3MZ4vrwyYFD72q26SSOKZE7iS7A9OnM=
X-Google-Smtp-Source: APXvYqzVR6iGo1TwW1tuLDzrebAmZoEgkQC/f+joB3/zE78JOjNz8rORIcK6Lh0Vg3eusjpkLImlBTOixuUu5avHL8o=
X-Received: by 2002:a92:3b0c:: with SMTP id i12mr35948444ila.190.1574770901320; 
 Tue, 26 Nov 2019 04:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20191126045621.11344-1-aaron.zakhrov@gmail.com>
 <alpine.BSF.2.21.99999.352.1911261233350.87139@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.99999.352.1911261233350.87139@zero.eik.bme.hu>
From: Aaron Zakhrov <aaron.zakhrov@gmail.com>
Date: Tue, 26 Nov 2019 17:51:27 +0530
Message-ID: <CAApBzg_Kdmn21ZXN_d=+CNo+TH6xN3YSF0x=SmFPtaeB=FcRfg@mail.gmail.com>
Subject: Re: [RFC 0/8] ATI R300 emulated graphics card
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: multipart/alternative; boundary="0000000000002d0b9105983eecb8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002d0b9105983eecb8
Content-Type: text/plain; charset="UTF-8"

Yeah sorry about the double patches. That was because of a botched rebase.
It applied my commits twice.
I am working on cleaning up the header files and other fixes.

 > Are you aware of my project page for ATI VGA emulation here:
Yes I am. Your code got me through the initial setup.



On Tue, Nov 26, 2019 at 5:33 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:

> Hello,
>
> On Tue, 26 Nov 2019, aaron.zakhrov@gmail.com wrote:
> > From: Aaron Dominick <aaron.zakhrov@gmail.com>
> >
> > Hello,
> > I thought of working on an emulated R300 GPU for QEMU video acceleration
> on vintage operating systems (Windows 9x-XP)
>
> Good idea, :-) I very welcome any contribution to this.
>
> > The following patch series contains the initial QEMU device and some
> register read/write operations.
>
> At first look you have pathces twice in the series (so each patch appears
> twice, I haven't checked if they are identical or different) and also the
> first (and 5th) patch adds a lot of probably unused files which makes
> review difficult. Could you please fix these and resend with only adding
> the headers really needed and each patch only once so we know what are the
> actual changes that are relevant?
>
> Also is it possible to keep everything in ati-vga only adding another
> device model there rather than fully duplicating it as r300* ? Although
> for development it's probably OK to keep it separate but unless there are
> enough differences having a single file at the end may be better. (Also
> changes are clearer that way but if you have a patch only copying ati-vga
> files first then separate patches that changes it can be reviewed that way
> too.)
>
> In short I think this series needs some cleanup first for us to be able to
> revies it better.
>
> > Testing it on an OpenSUSE Linux guest and the kernel correctly detects
> the card and loads the radeon DRM driver.
>
> So I think this gets a bit further than my ati-vga rv100 which does not
> work with DRM yet. I've thought about targeting RV100 first then moving on
> to later radeons as those probably have more features and differences from
> R128 which is the starting point for ati-vga but if you need R300 for some
> reason specifically targeting that is OK too.
>
> > It gets as far as the CRTC probing before crashing with an error that
> there is not enough bandwidth.
>
> Getting DRM to load is one thing but likely you'll need to implement
> microengine/command processor (also referred to as PM4 or programming mode
> 4 sometimes) to get it fully working as that's how DRM and Windows ATI
> drivers likely send commands to the card. I've looked at it but couldn't
> find documentation on how the microengine works. We get a microcode
> uploaded by no idea how to run that. If we can't figure out how the
> microengine works anther approach could be what xenia.jp XBox 360
> emulator
> does and directly parse the packets not using the microcode. It could be
> possible to copy code from Xenia for that but we need to convert C++ to C.
> The difficult part is probably figuring out how to run it in a different
> thread so the device emulation does not block the machine and it works in
> parallel like real hardware does.
>
> > I know next to nothing about hardware emulation and would like to know
> if what I have got so far is on the right track.
>
> Are you aware of my project page for ATI VGA emulation here:
>
> https://osdn.net/projects/qmiga/wiki/SubprojectAti
>
> where I have collected some knowledge that I could gather so far? I have
> some experience in implementing devices in QEMU but know next to nothing
> about GPUs so hopefully you know more about those which is more needed for
> ati-vga. The QEMU knowledge can be picked up by looking at existing
> devices and asking here or on IRC (if you prefer that, I don't use it but
> I know some do).
>
> Regards,
> BALATON Zoltan
>

--0000000000002d0b9105983eecb8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Yeah sorry about the double patches.=
 That was because of a botched rebase. It applied my commits twice.</div><d=
iv>I am working on cleaning up the header files and other fixes.=C2=A0</div=
><div><br></div><div>=C2=A0&gt; Are you aware of my project page for ATI VG=
A emulation here:<br></div><div>Yes I am. Your code got me through the init=
ial setup.</div><div><br></div><div><br></div></div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 26, 2019 at=
 5:33 PM BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu">balaton@e=
ik.bme.hu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hello,<br>
<br>
On Tue, 26 Nov 2019, <a href=3D"mailto:aaron.zakhrov@gmail.com" target=3D"_=
blank">aaron.zakhrov@gmail.com</a> wrote:<br>
&gt; From: Aaron Dominick &lt;<a href=3D"mailto:aaron.zakhrov@gmail.com" ta=
rget=3D"_blank">aaron.zakhrov@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Hello,<br>
&gt; I thought of working on an emulated R300 GPU for QEMU video accelerati=
on on vintage operating systems (Windows 9x-XP)<br>
<br>
Good idea, :-) I very welcome any contribution to this.<br>
<br>
&gt; The following patch series contains the initial QEMU device and some r=
egister read/write operations.<br>
<br>
At first look you have pathces twice in the series (so each patch appears <=
br>
twice, I haven&#39;t checked if they are identical or different) and also t=
he <br>
first (and 5th) patch adds a lot of probably unused files which makes <br>
review difficult. Could you please fix these and resend with only adding <b=
r>
the headers really needed and each patch only once so we know what are the =
<br>
actual changes that are relevant?<br>
<br>
Also is it possible to keep everything in ati-vga only adding another <br>
device model there rather than fully duplicating it as r300* ? Although <br=
>
for development it&#39;s probably OK to keep it separate but unless there a=
re <br>
enough differences having a single file at the end may be better. (Also <br=
>
changes are clearer that way but if you have a patch only copying ati-vga <=
br>
files first then separate patches that changes it can be reviewed that way =
<br>
too.)<br>
<br>
In short I think this series needs some cleanup first for us to be able to =
<br>
revies it better.<br>
<br>
&gt; Testing it on an OpenSUSE Linux guest and the kernel correctly detects=
 the card and loads the radeon DRM driver.<br>
<br>
So I think this gets a bit further than my ati-vga rv100 which does not <br=
>
work with DRM yet. I&#39;ve thought about targeting RV100 first then moving=
 on <br>
to later radeons as those probably have more features and differences from =
<br>
R128 which is the starting point for ati-vga but if you need R300 for some =
<br>
reason specifically targeting that is OK too.<br>
<br>
&gt; It gets as far as the CRTC probing before crashing with an error that =
there is not enough bandwidth.<br>
<br>
Getting DRM to load is one thing but likely you&#39;ll need to implement <b=
r>
microengine/command processor (also referred to as PM4 or programming mode =
<br>
4 sometimes) to get it fully working as that&#39;s how DRM and Windows ATI =
<br>
drivers likely send commands to the card. I&#39;ve looked at it but couldn&=
#39;t <br>
find documentation on how the microengine works. We get a microcode <br>
uploaded by no idea how to run that. If we can&#39;t figure out how the <br=
>
microengine works anther approach could be what <a href=3D"http://xenia.jp"=
 rel=3D"noreferrer" target=3D"_blank">xenia.jp</a> XBox 360 emulator <br>
does and directly parse the packets not using the microcode. It could be <b=
r>
possible to copy code from Xenia for that but we need to convert C++ to C. =
<br>
The difficult part is probably figuring out how to run it in a different <b=
r>
thread so the device emulation does not block the machine and it works in <=
br>
parallel like real hardware does.<br>
<br>
&gt; I know next to nothing about hardware emulation and would like to know=
 if what I have got so far is on the right track.<br>
<br>
Are you aware of my project page for ATI VGA emulation here:<br>
<br>
<a href=3D"https://osdn.net/projects/qmiga/wiki/SubprojectAti" rel=3D"noref=
errer" target=3D"_blank">https://osdn.net/projects/qmiga/wiki/SubprojectAti=
</a><br>
<br>
where I have collected some knowledge that I could gather so far? I have <b=
r>
some experience in implementing devices in QEMU but know next to nothing <b=
r>
about GPUs so hopefully you know more about those which is more needed for =
<br>
ati-vga. The QEMU knowledge can be picked up by looking at existing <br>
devices and asking here or on IRC (if you prefer that, I don&#39;t use it b=
ut <br>
I know some do).<br>
<br>
Regards,<br>
BALATON Zoltan<br>
</blockquote></div>

--0000000000002d0b9105983eecb8--

