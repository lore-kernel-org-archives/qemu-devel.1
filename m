Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE21C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 23:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2786D20722
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 23:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYYM+1jS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2786D20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGt3X-00040j-8A
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 19:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jGt2v-0003c0-V0
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pauldzim@gmail.com>) id 1jGt2u-0000RS-IN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:33:21 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:45175)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pauldzim@gmail.com>) id 1jGt2u-0000JA-BL
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:33:20 -0400
Received: by mail-io1-xd41.google.com with SMTP id e20so408299ios.12
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 16:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FIaomcxit2BP63TX0LzHTBHZpKAahSVEdvngUFJg74g=;
 b=aYYM+1jSTlTlaTtQyS6nQWB9vWJIrOQeXAsAd9+/y/6/WO44mCannIo0cyHkAmfYfz
 2mBPm7WD/ypvcoQ15eTXZNIrarQCHiSH3BNnQfFqClVbt2hcmjrcKb45su3boT5VWSt3
 kyd8+yX7LZlzvLFEzGzQ47ozhucGYsfkSFht5vIEhmiBrtdaM+wffILQXtBCBS3e0BEJ
 RsKYBSaERoAkKZGeZ4elwkgfpgrMUI91l7/y+GFpQJXRtcPv2ynN/cmkFm31zaOYiuWO
 VCaxJTGbZZohOKAKTAyaBUHdAq7UF1VxbMrddLHzmZxJChw5Vz9DnqikpTlW8w4ccgxn
 FvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FIaomcxit2BP63TX0LzHTBHZpKAahSVEdvngUFJg74g=;
 b=RVzL/YlAbILz4FIssPIPqdKPHbXZZ/heOUri2RrFCfg5kvh+2IanNfgPPGEJjBPTAO
 NhWBJMr0wRzi9gPTLR/t/hXGIqsoL5ufyGhHsxhhusLRX0TrPQvlElrlap++ikLC0LYR
 3+u9L3+D1mRR7NBFX1yBk3khEyhqaIyAnT/1+q4DtbTjFHbwKpxoyNbaPyvhXf4sAixH
 GZr+j3yNXQjSPfmnHghM6gwrUqMZAJpmnochTPpLmzWb/u6DvmYGfj2kmQSjM7r/xB87
 BKGIhapIb9LWvMY8cDt7XILkdG7nPaaRQbQF7YiX0lsMhVkV+s3+D3cJXCxk1OBwOocY
 JIbg==
X-Gm-Message-State: ANhLgQ1st/rHMsvxCDE9wdwzXvYizfYt77gu+pP9qj+2unWeYnvEN3J4
 MYjjzpvnsnwVkiKv8gJH6dvQNo1U79y/ZAFoFqI=
X-Google-Smtp-Source: ADFU+vuvvDaQmVp+HfO9bkOYgRr27Ka2ddllGuyxZGu/9pokMuvGHNwXQI+L6KftxHOLa0uijtztSUojNl33+bY6z1Q=
X-Received: by 2002:a5d:88ce:: with SMTP id i14mr444550iol.184.1585092793693; 
 Tue, 24 Mar 2020 16:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200322222726.10244-1-pauldzim@gmail.com>
 <20200323110955.mpgbtvp6qoobq5hz@sirius.home.kraxel.org>
In-Reply-To: <20200323110955.mpgbtvp6qoobq5hz@sirius.home.kraxel.org>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Tue, 24 Mar 2020 16:32:47 -0700
Message-ID: <CADBGO7-_J=cgduzH8fRNkLPuUtd2xfMgGT-MVFKfG8+mGzRC=Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] dwc-hsotg (aka dwc2) USB host contoller emulation
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e779ab05a1a22cea"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 stefanha@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e779ab05a1a22cea
Content-Type: text/plain; charset="UTF-8"

Thanks Gerd. I will switch over to using tracepoints, wait a few days to
see if there are any more comments, then resubmit.

Thanks,
Paul

On Mon, Mar 23, 2020 at 4:10 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> > 1) I have used printf-based debug statements while developing the
> >    code, and have not implemented any tracing statements. I'm not
> >    sure if that is considered acceptable for new code?
>
> Please use tracepoints.  I'd suggest to use the "log" trace backend
> which comes very close to printf-debugging; effectively all trace
> points are turned into runtime-switchable printf's.
>
> Mixing (temporary) debug printfs and tracepoints works.
>
> > 2) I have imported the register description file from the Linux
> >    kernel. This file is licensed GPL-2 only, is this OK?
>
> Yes.  There even is a script to keep things in sync and apply some
> tweaks like replacing linux kernel types with standard C types
> (s/u32/uint32_t/ etc).
>
> See scripts/update-linux-headers.sh
>
> You might consider hooking up your file there, but probably this is
> overkill given that the register descriptions are unlikely to see
> frequent updates.
>
> > 3) The emulation does not respect the max-packet size when
> >    transferring packets. Since the dwc-hsotg controller only has
> >    one root port, and the Qemu USB hub is only full-speed, that
> >    means every device connected has to run at full speed. That
> >    makes mass-storage devices in particular run very slowly. Using
> >    transfers greater than max-packet size alleviates this. Is this
> >    OK? I think the EHCI emulation does the same thing, since its
> >    transfers seem to run at greater than real world transfer rates.
>
> I don't think ehci uses larger packets.  I think it simply does more
> transfers than physical hardware would be able to do.
>
> uhci is pretty strict here, it counts bytes transfered and simply stops
> processing queues when it has transfered enough data for the current
> frame.  On the next frame timer tick it resumes work.  There is a
> bandwidth= property to tweak the transfer limit, you can use that to
> make uhci emulation run at the speed you want ;)
>
> ehci and xhci simply don't count bytes and don't have a limit, they go
> process queues as long as there is work to do (and they don't have to
> wait for host block I/O).
>
> > 4) I have only implemented host mode for now. Would there be any
> >    benefit to implementing gadget mode as well? It seems it could
> >    be useful to emulate gadget devices in Qemu, but I am not sure
> >    if Qemu currently offers any support for that?
>
> No, there isn't any gadget support yet.
>
> cheers,
>   Gerd
>
>

--000000000000e779ab05a1a22cea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace,monospace">Thanks Gerd. I will switch over to using trac=
epoints, wait a few days to</div><div class=3D"gmail_default" style=3D"font=
-family:monospace,monospace">see if there are any more comments, then resub=
mit.</div><div class=3D"gmail_default" style=3D"font-family:monospace,monos=
pace"><br></div><div class=3D"gmail_default" style=3D"font-family:monospace=
,monospace">Thanks,</div><div class=3D"gmail_default" style=3D"font-family:=
monospace,monospace">Paul<br></div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 23, 2020 at 4:10 AM Gerd Hof=
fmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0 Hi,<=
br>
<br>
&gt; 1) I have used printf-based debug statements while developing the<br>
&gt;=C2=A0 =C2=A0 code, and have not implemented any tracing statements. I&=
#39;m not<br>
&gt;=C2=A0 =C2=A0 sure if that is considered acceptable for new code?<br>
<br>
Please use tracepoints.=C2=A0 I&#39;d suggest to use the &quot;log&quot; tr=
ace backend<br>
which comes very close to printf-debugging; effectively all trace<br>
points are turned into runtime-switchable printf&#39;s.<br>
<br>
Mixing (temporary) debug printfs and tracepoints works.<br>
<br>
&gt; 2) I have imported the register description file from the Linux<br>
&gt;=C2=A0 =C2=A0 kernel. This file is licensed GPL-2 only, is this OK?<br>
<br>
Yes.=C2=A0 There even is a script to keep things in sync and apply some<br>
tweaks like replacing linux kernel types with standard C types<br>
(s/u32/uint32_t/ etc).<br>
<br>
See scripts/update-linux-headers.sh<br>
<br>
You might consider hooking up your file there, but probably this is<br>
overkill given that the register descriptions are unlikely to see<br>
frequent updates.<br>
<br>
&gt; 3) The emulation does not respect the max-packet size when<br>
&gt;=C2=A0 =C2=A0 transferring packets. Since the dwc-hsotg controller only=
 has<br>
&gt;=C2=A0 =C2=A0 one root port, and the Qemu USB hub is only full-speed, t=
hat<br>
&gt;=C2=A0 =C2=A0 means every device connected has to run at full speed. Th=
at<br>
&gt;=C2=A0 =C2=A0 makes mass-storage devices in particular run very slowly.=
 Using<br>
&gt;=C2=A0 =C2=A0 transfers greater than max-packet size alleviates this. I=
s this<br>
&gt;=C2=A0 =C2=A0 OK? I think the EHCI emulation does the same thing, since=
 its<br>
&gt;=C2=A0 =C2=A0 transfers seem to run at greater than real world transfer=
 rates.<br>
<br>
I don&#39;t think ehci uses larger packets.=C2=A0 I think it simply does mo=
re<br>
transfers than physical hardware would be able to do.<br>
<br>
uhci is pretty strict here, it counts bytes transfered and simply stops<br>
processing queues when it has transfered enough data for the current<br>
frame.=C2=A0 On the next frame timer tick it resumes work.=C2=A0 There is a=
<br>
bandwidth=3D property to tweak the transfer limit, you can use that to<br>
make uhci emulation run at the speed you want ;)<br>
<br>
ehci and xhci simply don&#39;t count bytes and don&#39;t have a limit, they=
 go<br>
process queues as long as there is work to do (and they don&#39;t have to<b=
r>
wait for host block I/O).<br>
<br>
&gt; 4) I have only implemented host mode for now. Would there be any<br>
&gt;=C2=A0 =C2=A0 benefit to implementing gadget mode as well? It seems it =
could<br>
&gt;=C2=A0 =C2=A0 be useful to emulate gadget devices in Qemu, but I am not=
 sure<br>
&gt;=C2=A0 =C2=A0 if Qemu currently offers any support for that?<br>
<br>
No, there isn&#39;t any gadget support yet.<br>
<br>
cheers,<br>
=C2=A0 Gerd<br>
<br>
</blockquote></div></div>

--000000000000e779ab05a1a22cea--

