Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A02C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8DE2466E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwEyPHfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8DE2466E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFeC-0005Ql-5P
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1idElI-0000mY-8d
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1idElG-0001h5-A8
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:39:16 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38821)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1idElG-0001gE-3n
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:39:14 -0500
Received: by mail-oi1-x243.google.com with SMTP id b8so6352276oiy.5
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=tvojVvlszRJsOZIKiDHXWwmX7KNBTuSyKRFi9PCSntc=;
 b=BwEyPHfPpNzON+e9C4cbmCLTeY9ZMkpMK2CvDQRK9UtOOZqlDig8BzH2TQelc/Vo1u
 CPssKwoPvz2NRgI93NqxyVAeW9kjt/I7PBA4vDNjOzizVRkJqSG11Mry/CXGMhCF/Yd+
 AvTk4DhZn5OGFAVlOVnbqNq9/bI3fWs+izlyjhWhImbFIM1jjpdd1qiEhH8RtHndCco+
 ky1ISl/SwvEyg0xcJomc+E9WfCjC3PWwMcNsDwJYakp57AwxlDi7IZH/1+YGGAsozzdg
 5ondS8rqmN0m97S/rMSUL8evxnSjs3VJvgQ+w86IWi7uDjd1nKjPP8bw+8FEviLwpRHS
 FLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=tvojVvlszRJsOZIKiDHXWwmX7KNBTuSyKRFi9PCSntc=;
 b=Uj/niqVTVe7olrK+hopIhNzs8zgUOtCuCm/tJcNHwrFk8mC/fWN76l0frtwP8shlOz
 +r6qgk2uhKZRdaoRkKFaV2TICXjYUTBlyJ04bqvSZSSxUZ4Vn1bX9A8dy+d+iZDJi/d3
 NHQljmfQPT3HKZrjnKQxM9fKNPd9rGr1JA5fcYsOZLTdOfmV7V0RPgF3SxVcGIE8CVlY
 voZTII15DhMJrV4zXGhGxNGtQvwGmQybLW5WmhWEpdfn5UgbWmmYQiHy3rHSj24hOWs8
 BXnsUEfB/dGM1H/CUnLlVXLbmo9631H4dzUj3hWJ2LkWrUpIs2FPGjpIs2zziXEuzk1y
 rrhQ==
X-Gm-Message-State: APjAAAXaWeGstv4GqPzzGfLj3sGfSmkIIyPTtMLuLkUexnuecjZjn9Hn
 y/O0QqmayvCy85sROavZaHzvZOTLLk1sgZwn58X5+w==
X-Google-Smtp-Source: APXvYqyU2gCSwQhTgLN7Pe3/29Pde4mqvAMK2UKCX0Bzxk7vZJjILp0MwVnWoUt06b081nE7Kju2UGB1FDtolm+4Nys=
X-Received: by 2002:aca:1b08:: with SMTP id b8mr507653oib.106.1575620665044;
 Fri, 06 Dec 2019 00:24:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Fri, 6 Dec 2019 00:24:24 -0800 (PST)
In-Reply-To: <20191205212729.GA1797@localhost.localdomain>
References: <1574687098-26689-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1574687098-26689-3-git-send-email-Filip.Bozuta@rt-rk.com>
 <CAL1e-=jeECJRjOR+Mo79D5VA8q0gSZsf__MOtRhiU0fgDF1DRA@mail.gmail.com>
 <20191202204958.GP14595@habkost.net>
 <20191205212729.GA1797@localhost.localdomain>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 6 Dec 2019 09:24:24 +0100
Message-ID: <CAL1e-=iTVsTpMy81vVj2H7JQk4AJax+_PoVZZ80vXvzFpoatqg@mail.gmail.com>
Subject: Re: [PATCH 2/5] mips: malta: Renovate coding style
To: Cleber Rosa <crosa@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000a749c059904c6d0"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: "pburton@wavecomp.com" <pburton@wavecomp.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Filip Bozuta <Filip.Bozuta@rt-rk.com>,
 "hpoussin@reactos.org" <hpoussin@reactos.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000a749c059904c6d0
Content-Type: text/plain; charset="UTF-8"

On Thursday, December 5, 2019, Cleber Rosa <crosa@redhat.com> wrote:

> On Mon, Dec 02, 2019 at 05:49:58PM -0300, Eduardo Habkost wrote:
> > On Sun, Dec 01, 2019 at 12:46:12AM +0100, Aleksandar Markovic wrote:
> > > On Monday, November 25, 2019, Filip Bozuta <Filip.Bozuta@rt-rk.com>
> wrote:
> > >
> > > > The script checkpatch.pl located in scripts folder was
> > > > used to detect all errors and warrnings in files:
> > > >     hw/mips/mips_malta.c
> > > >     hw/mips/gt64xxx_pci.c
> > > >     tests/acceptance/linux_ssh_mips_malta.py
> > > >
> > > > All these mips malta machine files were edited and
> > > > all the errors and warrings generated by the checkpatch.pl
> > > > script were corrected and then the script was
> > > > ran again to make sure there are no more errors and warnings.
> > > >
> > > > Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> > > > ---
> > > >  hw/mips/mips_malta.c                     | 139
> > > > ++++++++++++++++---------------
> > > >  tests/acceptance/linux_ssh_mips_malta.py |   6 +-
> > > >  2 files changed, 75 insertions(+), 70 deletions(-)
> > > >
> > > >
> > > Very good cleanup!
> > >
> > > Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > >
> > > I think this snippet is good, but I am just in case cc-ing Cleber and
> > > Eduardo to check if it is in accordance with any applicable guidelines
> of
> > > our test framework:
> >
> > Thanks for CCing us.
> >
> > >
> > >
> > > > diff --git a/tests/acceptance/linux_ssh_mips_malta.py
> > > > b/tests/acceptance/linux_ssh_mips_malta.py
> > > > index fc13f9e..44e1118 100644
> > > > --- a/tests/acceptance/linux_ssh_mips_malta.py
> > > > +++ b/tests/acceptance/linux_ssh_mips_malta.py
> > > > @@ -99,10 +99,12 @@ class LinuxSSH(Test):
> > > >      def ssh_command(self, command, is_root=True):
> > > >          self.ssh_logger.info(command)
> > > >          result = self.ssh_session.cmd(command)
> > > > -        stdout_lines = [line.rstrip() for line in
> > > > result.stdout_text.splitlines()]
> > > > +        stdout_lines = [line.rstrip() for line
> > > > +        in result.stdout_text.splitlines()]
> > > >          for line in stdout_lines:
> > > >              self.ssh_logger.info(line)
> > > > -        stderr_lines = [line.rstrip() for line in
> > > > result.stderr_text.splitlines()]
> > > > +        stderr_lines = [line.rstrip() for line
> > > > +        in result.stderr_text.splitlines()]
> >
> > If you really want to split those lines, please indent them
> > properly.  e.g.:
> >
> >         stdout_lines = [line.rstrip() for line
> >                         in result.stdout_text.splitlines()]
> >
> > See PEP 8 [1] for additional examples.
> >
> > Personally, I would just keep the existing
> > linux_ssh_mips_malta.py code as is.  I don't think splitting
> > those lines improves readability.
> >
> > [1] https://www.python.org/dev/peps/pep-0008/#indentation
> >
> > --
> > Eduardo
>
> Right.  It only helps when running terminal or editor settings are
> limited to ~80 cols.  And even in those cases, sometimes such code
> split across lines needs a lot of gymnastics to not degrade in
> readability when compared to a longer line.
>
> We're not (yet?) enforcing PEP 8, so either as Eduardo suggested, or
> with no changes LGTM.
>
>
Eduardo, Cleber,

I truly appreciate your responses and clarifications.

Best regards,
Aleksandar




> Cheers,
> - Cleber.
>
>

--0000000000000a749c059904c6d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, December 5, 2019, Cleber Rosa &lt;<a href=3D"mailto:cr=
osa@redhat.com">crosa@redhat.com</a>&gt; wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">On Mon, Dec 02, 2019 at 05:49:58PM -0300, Eduardo Habkost wrote:<br>
&gt; On Sun, Dec 01, 2019 at 12:46:12AM +0100, Aleksandar Markovic wrote:<b=
r>
&gt; &gt; On Monday, November 25, 2019, Filip Bozuta &lt;<a href=3D"mailto:=
Filip.Bozuta@rt-rk.com">Filip.Bozuta@rt-rk.com</a>&gt; wrote:<br>
&gt; &gt; <br>
&gt; &gt; &gt; The script <a href=3D"http://checkpatch.pl" target=3D"_blank=
">checkpatch.pl</a> located in scripts folder was<br>
&gt; &gt; &gt; used to detect all errors and warrnings in files:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0hw/mips/mips_malta.c<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0hw/mips/gt64xxx_pci.c<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0tests/acceptance/linux_ssh_<wbr>mips_malt=
a.py<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; All these mips malta machine files were edited and<br>
&gt; &gt; &gt; all the errors and warrings generated by the <a href=3D"http=
://checkpatch.pl" target=3D"_blank">checkpatch.pl</a><br>
&gt; &gt; &gt; script were corrected and then the script was<br>
&gt; &gt; &gt; ran again to make sure there are no more errors and warnings=
.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Filip Bozuta &lt;<a href=3D"mailto:Filip.Bozu=
ta@rt-rk.com">Filip.Bozuta@rt-rk.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 hw/mips/mips_malta.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 139<br>
&gt; &gt; &gt; ++++++++++++++++--------------<wbr>-<br>
&gt; &gt; &gt;=C2=A0 tests/acceptance/linux_ssh_<wbr>mips_malta.py |=C2=A0 =
=C2=A06 +-<br>
&gt; &gt; &gt;=C2=A0 2 files changed, 75 insertions(+), 70 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; Very good cleanup!<br>
&gt; &gt; <br>
&gt; &gt; Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@=
wavecomp.com">amarkovic@wavecomp.com</a>&gt;<br>
&gt; &gt; <br>
&gt; &gt; I think this snippet is good, but I am just in case cc-ing Cleber=
 and<br>
&gt; &gt; Eduardo to check if it is in accordance with any applicable guide=
lines of<br>
&gt; &gt; our test framework:<br>
&gt; <br>
&gt; Thanks for CCing us.<br>
&gt; <br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; &gt; diff --git a/tests/acceptance/linux_ssh_<wbr>mips_malta.py<b=
r>
&gt; &gt; &gt; b/tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
&gt; &gt; &gt; index fc13f9e..44e1118 100644<br>
&gt; &gt; &gt; --- a/tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
&gt; &gt; &gt; +++ b/tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
&gt; &gt; &gt; @@ -99,10 +99,12 @@ class LinuxSSH(Test):<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 def ssh_command(self, command, is_root=
=3DTrue):<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.ssh=
_logger.info" target=3D"_blank">self.ssh_logger.info</a>(command)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D self.ssh_sessio=
n.cmd(command)<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 stdout_lines =3D [line.rstrip()=
 for line in<br>
&gt; &gt; &gt; result.stdout_text.splitlines(<wbr>)]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 stdout_lines =3D [line.rstrip()=
 for line<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 in result.stdout_text.splitline=
s(<wbr>)]<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for line in stdout_lines:<=
br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"h=
ttp://self.ssh_logger.info" target=3D"_blank">self.ssh_logger.info</a>(line=
)<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 stderr_lines =3D [line.rstrip()=
 for line in<br>
&gt; &gt; &gt; result.stderr_text.splitlines(<wbr>)]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 stderr_lines =3D [line.rstrip()=
 for line<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 in result.stderr_text.splitline=
s(<wbr>)]<br>
&gt; <br>
&gt; If you really want to split those lines, please indent them<br>
&gt; properly.=C2=A0 e.g.:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout_lines =3D [line.rstrip() for l=
ine<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0in result.stdout_text.splitlines(<wbr>)]<br>
&gt; <br>
&gt; See PEP 8 [1] for additional examples.<br>
&gt; <br>
&gt; Personally, I would just keep the existing<br>
&gt; linux_ssh_mips_malta.py code as is.=C2=A0 I don&#39;t think splitting<=
br>
&gt; those lines improves readability.<br>
&gt;<br>
&gt; [1] <a href=3D"https://www.python.org/dev/peps/pep-0008/#indentation" =
target=3D"_blank">https://www.python.org/dev/<wbr>peps/pep-0008/#indentatio=
n</a><br>
&gt; <br>
&gt; -- <br>
&gt; Eduardo<br>
<br>
Right.=C2=A0 It only helps when running terminal or editor settings are<br>
limited to ~80 cols.=C2=A0 And even in those cases, sometimes such code<br>
split across lines needs a lot of gymnastics to not degrade in<br>
readability when compared to a longer line.<br>
<br>
We&#39;re not (yet?) enforcing PEP 8, so either as Eduardo suggested, or<br=
>
with no changes LGTM.<br>
<br></blockquote><div><br></div><div>Eduardo, Cleber,</div><div><br></div><=
div>I truly appreciate your responses and clarifications.</div><div><br></d=
iv><div>Best regards,</div><div>Aleksandar</div><div><br></div><div><br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Cheers,<br>
- Cleber.<br>
<br>
</blockquote>

--0000000000000a749c059904c6d0--

