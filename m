Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F61FC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C137A206ED
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8+KDmP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C137A206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iq0P3-0001Qh-TD
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 14:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iq0OP-0000Zt-Bd
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:56:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iq0OO-0006Vk-8g
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:56:25 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:42785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iq0OO-0006Rt-25
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:56:24 -0500
Received: by mail-ot1-x32d.google.com with SMTP id 66so3105966otd.9
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 11:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a+E//MlcJw7X7i6kiN0VA1+qmTJPw7LyaSR1hwCzQQw=;
 b=h8+KDmP1F6EUZiQYF8wJtE3+MUF3gQLn5coMPlxbqk4//u42htUtrG4GSXQqdrzdUd
 lbUjLvCLXZB0roX42sY3a8mPDngRYO+rTZXtnlCH0eoUa8iYfxoG9wn28rdm0O1s+GSa
 uqROzVDVBImOAVPMUDj9RqhwiFjy0BnO9ZP91n8LpZX0xJXYNEaBsu2yv0lDrmzNYPAp
 hq+8AfPt9G6FWs1oSiOxS8X5acU9B01iC+lIDCBwCeLcPtTSyV7+xzx/4xCwKkOYU7ZN
 tclvXUMC4hNyEvUNm3st3PwSGPU1KOsDbXjX4+Lsg28DytK0dEm7N9Gl0vLyyAvJFoh5
 yGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a+E//MlcJw7X7i6kiN0VA1+qmTJPw7LyaSR1hwCzQQw=;
 b=PR3tZlkJiSryygY6kFhnL5HMMBt6T/G4Yo4IEItbrTfmeRmpqsRUTBHG7mHfdV+OE7
 /1IAAG9GECmDP4REjKTJg4d/he3sxoGBRTF0TmOYRjh7fv4iVTDCpjHPvNqXvVh2oLXX
 a+Z7NRMKGR6YdICQFBhaMTbvnJc/Fb+Iy+EMPqWbEnPNOoxeu4bvtKDq3uCXXlygW6iT
 lhFkd+SiI8e+LTolGVfSUe/C4r0K2p2DJP8cHraARH8+8skdlhE8rBT2zefN7e29shvW
 KX25QXyuVAu2NikV0bg3DhggMWmbfcREkdgvYsW2Pe4UVbLECx57GVUIOmuFQ1HTttVF
 vjQw==
X-Gm-Message-State: APjAAAWwk0jORNhfUR6tERbVPK2Sz5XegApsgZ5qh0lhRKWOV3D8z9N/
 emUzc2Q/OymcVdG1woRzFLvIGX3dHaEGT87JfGk=
X-Google-Smtp-Source: APXvYqyIFyVIMf+RuS0fsMqMcwRa/NBpPdpscwIg1yGEFG5YBP5QVBasBq4XJVz07iRY0Fvd9EUIk/8QN0V1u3P+fXA=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr3814333otk.64.1578686183433;
 Fri, 10 Jan 2020 11:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20190319144013.26584-1-pbonzini@redhat.com>
 <alpine.BSF.2.21.9999.1903192350550.11467@zero.eik.bme.hu>
 <87imwe847x.fsf_-_@dusky.pond.sub.org>
 <CAAdtpL5Z1OXqZ_zzA0RLq9soydNtTFt2oCOEfui1rq19bLKUgA@mail.gmail.com>
 <d9d5ac96-c0f5-dd83-d305-10e20c745dd1@redhat.com>
 <9b92b3c4-c5d5-9a51-7b96-50dcf113ee5a@redhat.com>
 <20200106064526.zh6rt4wbibfjrscu@sirius.home.kraxel.org>
 <CAL1e-=iD+o7-MOuOAjtp0oEWA6ep9nXQuT0jeR7aOnuN1M6fqw@mail.gmail.com>
In-Reply-To: <CAL1e-=iD+o7-MOuOAjtp0oEWA6ep9nXQuT0jeR7aOnuN1M6fqw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 10 Jan 2020 20:56:00 +0100
Message-ID: <CAL1e-=iB7hXKbMZiPthxrA_3OVEL7GXhp-NQ4E3w9g04FEPCaQ@mail.gmail.com>
Subject: Re: [Qemu-devel] What should a virtual board emulate?
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002ceac2059bce857c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002ceac2059bce857c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

8:42 PM Pet, 10.01.2020. Aleksandar Markovic <aleksandar.m.mail@gmail.com>
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> 7:45 AM Pon, 06.01.2020. Gerd Hoffmann <kraxel@redhat.com> =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> >   Hi,
> >
> > > 78c37d88f1b8b0b3ebcc632c458f0c3779fe2951 is the first bad commit
> > > commit 78c37d88f1b8b0b3ebcc632c458f0c3779fe2951
> > > Author: Paolo Bonzini <pbonzini@redhat.com>
> > > Date:   Tue Mar 19 15:37:19 2019 +0100
> > >
> > >     mips-fulong2e: obey -vga none
> > >
> > >     Do not create an ATI VGA if "-vga none" was passed on the command
line.
> >
> > > 1/ the Radeon chip is soldered on the motherboard,
> > >
> > > 2/ the default BIOS expects the Radeon chip to be
> > >    unconditionally present,
> > >
> > > I insist this patch is incorrect for the particular case of the
Fuloong2e
> > > board. I plan to revert it when I post the test.
> >
> > Yep.  IMHO devices which you can't unplug on the physical board should
> > be present even with "qemu -nodefaults".
> >
>
> I have to agree with Philippe's approach. That is not to say that
Zoltan's efforts are not appreciated.

I meant to say also Paolo's. But, I didn't mean to fingerpoint. It is quite
normal that from time to time, a well-intended change may actually produce
unexpected breaking. All is well, no bad feelings at all.

Yours,
Aleksandar

Just that the patch in question that broke Foolong scenario didn't fit
quite well, however some other its reincarnation may have better destiny.
>
> Sincerely,
> Aleksandar
>
> > cheers,
> >   Gerd
> >
> >

--0000000000002ceac2059bce857c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">8:42 PM Pet, 10.01.2020. Aleksandar Markovic &lt;<a href=3D"=
mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; =D1=
=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; 7:45 AM Pon, 06.01.2020. Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@re=
dhat.com">kraxel@redhat.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt; &gt;<br>
&gt; &gt; =C2=A0 Hi,<br>
&gt; &gt;<br>
&gt; &gt; &gt; 78c37d88f1b8b0b3ebcc632c458f0c3779fe2951 is the first bad co=
mmit<br>
&gt; &gt; &gt; commit 78c37d88f1b8b0b3ebcc632c458f0c3779fe2951<br>
&gt; &gt; &gt; Author: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.=
com">pbonzini@redhat.com</a>&gt;<br>
&gt; &gt; &gt; Date:=C2=A0 =C2=A0Tue Mar 19 15:37:19 2019 +0100<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0mips-fulong2e: obey -vga none<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0Do not create an ATI VGA if &quot;-vga no=
ne&quot; was passed on the command line.<br>
&gt; &gt;<br>
&gt; &gt; &gt; 1/ the Radeon chip is soldered on the motherboard,<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; 2/ the default BIOS expects the Radeon chip to be<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 unconditionally present,<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; I insist this patch is incorrect for the particular case of =
the Fuloong2e<br>
&gt; &gt; &gt; board. I plan to revert it when I post the test.<br>
&gt; &gt;<br>
&gt; &gt; Yep.=C2=A0 IMHO devices which you can&#39;t unplug on the physica=
l board should<br>
&gt; &gt; be present even with &quot;qemu -nodefaults&quot;.<br>
&gt; &gt;<br>
&gt;<br>
&gt; I have to agree with Philippe&#39;s approach. That is not to say that =
Zoltan&#39;s efforts are not appreciated.</p>
<p dir=3D"ltr">I meant to say also Paolo&#39;s. But, I didn&#39;t mean to f=
ingerpoint. It is quite normal that from time to time, a well-intended chan=
ge may actually produce unexpected breaking. All is well, no bad feelings a=
t all.</p>
<p dir=3D"ltr">Yours,<br>
Aleksandar</p>
<p dir=3D"ltr"> Just that the patch in question that broke Foolong scenario=
 didn&#39;t fit quite well, however some other its reincarnation may have b=
etter destiny.<br>
&gt;<br>
&gt; Sincerely,<br>
&gt; Aleksandar<br>
&gt;<br>
&gt; &gt; cheers,<br>
&gt; &gt; =C2=A0 Gerd<br>
&gt; &gt;<br>
&gt; &gt;<br>
</p>

--0000000000002ceac2059bce857c--

