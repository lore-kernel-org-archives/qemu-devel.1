Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20723CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 12:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12EA21734
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 12:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGzHN44c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12EA21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQVtR-000324-0C
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 08:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1iQVsl-0002cW-TM
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 08:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1iQVsk-00074E-18
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 08:18:23 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:40786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1iQVsj-00073N-Pu
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 08:18:21 -0400
Received: by mail-oi1-x22e.google.com with SMTP id r27so7966480oij.7
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 05:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=50xHcggga0PZe9GvAMuAVH7UHjbsX9k28TXztwIjnzM=;
 b=QGzHN44ceS2mi8hntpYFBeBgodFPbMfePlAKPIDT5eZm/PFKxpDri19a6Vuu+6gG5e
 26cK/f2YHv45g3pzXYZD0DPAa1L5fmK9y+p1qs0Ei3yPBT29KvWWvD5SPTKWIC9+eJ/t
 YDClHwuRoXhQC/YHL7R1xS2GCsJFeF3CkiJxpeAZN9psyU7ANYRuvRT+dHsXXhMLYwde
 Vc7Orj3Bfadc9ydZGNmKHWgKbP8qVt4fLRpYwtmErYfQGWjc8R61mFVnzrzQBTVzNjp9
 GKReEuyKDaT/oSEbnFYidEVOjb8CiSAAOdthcPjGDcqpd6JpVcDbOZnNjQ0BxbpC20RG
 iZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=50xHcggga0PZe9GvAMuAVH7UHjbsX9k28TXztwIjnzM=;
 b=RZ5IRJZS9jowza9piOYCv6gJlICyx25rKDD5cD7+5M/J+2FS6x8U1sYz3dbj6cia2w
 D7Obu6rijLjbT0oBFUh1NUKDI/PNGUJ0HYzM7JGYH1niV+fZUpYDXi5VthRL/KvBvGMH
 z3IvaSEk75YKlr78Ub85cN3Bo5rFLilOBmkhZSXK/i5nR4odE+vx3Lx+bzNRsXmCJ1Oq
 3yuizVyQC4miejDNdLRTbO/Mm/qCmOFEYZiXjTZzst4ZLtwCt0DflQlDlQcdYXkcaAsX
 6BfnpRYqM7kv7rm/XEIenJMiKqkUArBuUPcIlAWxDacAedZVsFAnZaCfHG+oOJM6oJEr
 yX/g==
X-Gm-Message-State: APjAAAUYsXx2INoa0g7Vytaq25VWuWo+DgXIKFHvwLpky9qSPZpXOZxi
 OE0ENxq3XX2rSl3frTTEY3nxl9+vtw6s3JblG5I=
X-Google-Smtp-Source: APXvYqyU+1J/5yCnT9XgXaLvi+8vjCEvkZ01Lmv9BCmKWOAit9stQq8mDRruSjxeU6xfkHwrkEnEIM/IgokENmSQHWk=
X-Received: by 2002:aca:3a86:: with SMTP id h128mr8093445oia.131.1572610700564; 
 Fri, 01 Nov 2019 05:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <mailman.214.1572564951.13345.qemu-devel@nongnu.org>
 <47A92732-E94E-4DD9-8D47-E8DCF4E364B1@gmail.com>
In-Reply-To: <47A92732-E94E-4DD9-8D47-E8DCF4E364B1@gmail.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Fri, 1 Nov 2019 13:18:07 +0100
Message-ID: <CABLmASGTRF3OJRh0QvmND8Nr=2OiUQnQcJK+ru1PUc2oW0A_Mw@mail.gmail.com>
Subject: Re: [Bug 1850570] Re: Cannot use usb-host on Mac OS
To: Programmingkid <programmingkidx@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000002d5baf059647f6d1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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
Cc: 1850570@bugs.launchpad.net, qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002d5baf059647f6d1
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 1, 2019 at 11:35 AM Programmingkid <programmingkidx@gmail.com>
wrote:

>
> > On Oct 31, 2019, at 7:35 PM, qemu-devel-request@nongnu.org wrote:
> >
> > Message: 10
> > Date: Thu, 31 Oct 2019 18:39:11 -0000
> > From: John Canada <1850570@bugs.launchpad.net>
> > To: qemu-devel@nongnu.org
> > Subject: [Bug 1850570] Re: Cannot use usb-host on Mac OS
> > Message-ID:
> >       <157254715118.3076.2379100780378521691.malone@gac.canonical.com>
> > Content-Type: text/plain; charset="utf-8"
> >
> > Yes, I tried running as root.  I also tried it on a different computer
> > that is running Mac OS 10.13, and it gave the same errors.
> >
> > --
> > You received this bug notification because you are a member of qemu-
> > devel-ml, which is subscribed to QEMU.
> > https://bugs.launchpad.net/bugs/1850570
> >
> > Title:
> >  Cannot use usb-host on Mac OS
> >
> > Status in QEMU:
> >  New
> >
> > Bug description:
> >  Usb-host will not work on Mac OS 10.15.  Qemu runs, though it gives
> >  these errors and the drive does not show up.  Also, when Qemu is
> >  starting the drive ejects and remounts twice. Qemu built with
> >  ./configure --target-list=i386-softmmu,x86_64-softmmu --enable-sdl
> >  --disable-cocoa --enable-sdl-image.
> >
> >  qemu-system-i386 image.qcow -usb -device usb-kbd  -device
> usb-host,vendorid=0x0781,productid=0x5571
> >  libusb: error [darwin_claim_interface] USBInterfaceOpen: another
> process has device opened for exclusive access
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] USBInterfaceOpen: another
> process has device opened for exclusive access
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >  libusb: error [darwin_claim_interface] interface not found
> >
> > To manage notifications about this bug go to:
> > https://bugs.launchpad.net/qemu/+bug/1850570/+subscriptions
>
>
> Try this. Unplug the USB device. Plug it back in, and as fast as you can
> start QEMU.
>
> My theory is another program might be using the device. This could be
> Spotlight trying to index the drive.
>
> Another possibility is libusb is not compatible with Mac OS 10.13 yet.
>
> Do you have another computer that runs Mac OS 10.12 or under that you can
> test on?
>
>
I guess the longstanding issue with libusb and OSX is that some kext has
already claimed the device. A solution would be to unload the kext
currently claiming the device before starting Qemu. If possible.
Also see here:
https://apple.stackexchange.com/questions/363491/how-to-disable-usb-mass-storage-in-mojave-to-free-up-device-for-libusb
and the links from that page:
https://github.com/libusb/libusb/wiki/FAQ#How_can_I_run_libusb_applications_under_Mac_OS_X_if_there_is_already_a_kernel_extension_installed_for_the_device
https://stackoverflow.com/questions/33545656/codeless-kext-for-usb-storage-device

Best,
Howard

--0000000000002d5baf059647f6d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 1, 2019 at 11:35 AM Progr=
ammingkid &lt;<a href=3D"mailto:programmingkidx@gmail.com">programmingkidx@=
gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><br>
&gt; On Oct 31, 2019, at 7:35 PM, <a href=3D"mailto:qemu-devel-request@nong=
nu.org" target=3D"_blank">qemu-devel-request@nongnu.org</a> wrote:<br>
&gt; <br>
&gt; Message: 10<br>
&gt; Date: Thu, 31 Oct 2019 18:39:11 -0000<br>
&gt; From: John Canada &lt;<a href=3D"mailto:1850570@bugs.launchpad.net" ta=
rget=3D"_blank">1850570@bugs.launchpad.net</a>&gt;<br>
&gt; To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-de=
vel@nongnu.org</a><br>
&gt; Subject: [Bug 1850570] Re: Cannot use usb-host on Mac OS<br>
&gt; Message-ID:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:157254715118.3076.2379=
100780378521691.malone@gac.canonical.com" target=3D"_blank">157254715118.30=
76.2379100780378521691.malone@gac.canonical.com</a>&gt;<br>
&gt; Content-Type: text/plain; charset=3D&quot;utf-8&quot;<br>
&gt; <br>
&gt; Yes, I tried running as root.=C2=A0 I also tried it on a different com=
puter<br>
&gt; that is running Mac OS 10.13, and it gave the same errors.<br>
&gt; <br>
&gt; -- <br>
&gt; You received this bug notification because you are a member of qemu-<b=
r>
&gt; devel-ml, which is subscribed to QEMU.<br>
&gt; <a href=3D"https://bugs.launchpad.net/bugs/1850570" rel=3D"noreferrer"=
 target=3D"_blank">https://bugs.launchpad.net/bugs/1850570</a><br>
&gt; <br>
&gt; Title:<br>
&gt;=C2=A0 Cannot use usb-host on Mac OS<br>
&gt; <br>
&gt; Status in QEMU:<br>
&gt;=C2=A0 New<br>
&gt; <br>
&gt; Bug description:<br>
&gt;=C2=A0 Usb-host will not work on Mac OS 10.15.=C2=A0 Qemu runs, though =
it gives<br>
&gt;=C2=A0 these errors and the drive does not show up.=C2=A0 Also, when Qe=
mu is<br>
&gt;=C2=A0 starting the drive ejects and remounts twice. Qemu built with<br=
>
&gt;=C2=A0 ./configure --target-list=3Di386-softmmu,x86_64-softmmu --enable=
-sdl<br>
&gt;=C2=A0 --disable-cocoa --enable-sdl-image.<br>
&gt; <br>
&gt;=C2=A0 qemu-system-i386 image.qcow -usb -device usb-kbd=C2=A0 -device u=
sb-host,vendorid=3D0x0781,productid=3D0x5571<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] USBInterfaceOpen: another=
 process has device opened for exclusive access<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] USBInterfaceOpen: another=
 process has device opened for exclusive access<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt;=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
&gt; <br>
&gt; To manage notifications about this bug go to:<br>
&gt; <a href=3D"https://bugs.launchpad.net/qemu/+bug/1850570/+subscriptions=
" rel=3D"noreferrer" target=3D"_blank">https://bugs.launchpad.net/qemu/+bug=
/1850570/+subscriptions</a><br>
<br>
<br>
Try this. Unplug the USB device. Plug it back in, and as fast as you can st=
art QEMU. <br>
<br>
My theory is another program might be using the device. This could be Spotl=
ight trying to index the drive.<br>
<br>
Another possibility is libusb is not compatible with Mac OS 10.13 yet.<br>
<br>
Do you have another computer that runs Mac OS 10.12 or under that you can t=
est on?<br>
<br></blockquote><div><br></div><div>I guess the longstanding issue with li=
busb and OSX is that some kext has already claimed the device. A solution w=
ould be to unload the kext currently claiming the device before starting Qe=
mu. If possible.<br></div><div>Also see here: <br></div><div><a href=3D"htt=
ps://apple.stackexchange.com/questions/363491/how-to-disable-usb-mass-stora=
ge-in-mojave-to-free-up-device-for-libusb">https://apple.stackexchange.com/=
questions/363491/how-to-disable-usb-mass-storage-in-mojave-to-free-up-devic=
e-for-libusb</a></div><div>and the links from that page:</div><div><a href=
=3D"https://github.com/libusb/libusb/wiki/FAQ#How_can_I_run_libusb_applicat=
ions_under_Mac_OS_X_if_there_is_already_a_kernel_extension_installed_for_th=
e_device">https://github.com/libusb/libusb/wiki/FAQ#How_can_I_run_libusb_ap=
plications_under_Mac_OS_X_if_there_is_already_a_kernel_extension_installed_=
for_the_device</a></div><div><a href=3D"https://stackoverflow.com/questions=
/33545656/codeless-kext-for-usb-storage-device">https://stackoverflow.com/q=
uestions/33545656/codeless-kext-for-usb-storage-device</a></div><div><br></=
div><div>Best,</div><div>Howard<br></div><div> <br></div></div></div>

--0000000000002d5baf059647f6d1--

