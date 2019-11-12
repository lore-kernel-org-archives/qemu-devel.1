Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8589C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 20:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F3BF21872
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 20:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNV/7jbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3BF21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUdEr-00079N-JH
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 15:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iUdDy-0006f5-AN
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 15:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iUdDv-0008Uv-NG
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 15:57:18 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41077)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iUdDu-0008TE-Hk
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 15:57:15 -0500
Received: by mail-oi1-x243.google.com with SMTP id e9so16168341oif.8
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 12:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=3EtxS1gBzRcDuo4Wl6SUpDEG1FLOTwDekzY18u3HWEE=;
 b=eNV/7jbtcKMaInvtlYGV+T64gt5Jqvdu8ZDN+m2TQGD0NNHqx7h3dD5uFSrs/UJ0+r
 9Sp1kPPygB73XRuR7fKD8Um5wLz+SPjUWWteEFh3M+R0AgTLi1SHFzHIBJ+CF6gRlzMt
 ELn+vmrdWeL2nGOXJwaMPlJldmy8UXonqkG9SLk6NucS6X7PjjRYf+iE/omXz30cTEW+
 rwQPTNwCfRtiglIQ0tJW13gCjhAykjOUxhSft2k/ri5aPiBdBwp8Cw4ukuD8NB1oSIol
 gDwQG3h9VKbZipxNcozQfz80bfipZhmMvaxSgj4tDSX35yMAOPDyD73dwhhYcj09Z0wo
 2xsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=3EtxS1gBzRcDuo4Wl6SUpDEG1FLOTwDekzY18u3HWEE=;
 b=ObhYZdutWwx+amfB25eJsVXrwto3b/S7kguYC+1blQeoTMHV7NmiC9LXM7uiKk9uId
 ytJS/QJjJ0zklTT2Wv7CGoAkepmQLg/KJ2ZwB0aJnt4OJlSUfSd1HnGlohY8LZ6kDsVH
 qf33xsS3+ciH+OKodrkpZ4hrxFmZOFQKEgazCdlzjeHmsjuxqo726H0+oPTyV5X65bN6
 qATUuu/hlhRRMPDf+k34F72CABupwjZzUZQPhdfPZjxH7eq68m9P3zmQn6LaogoujOcK
 y4grk27oFxDbVSDNlTaUsD763mU6R5pcubUZoiwoGnh+aENuohrTEEXi+DVP6OpuUmQC
 kVIw==
X-Gm-Message-State: APjAAAWLYax1EL8j5r/Q//RyX00WwOJBEkKvECIUpYEs3xZLQmAXTlED
 xguXXeeFC3Nj8SqxQPzT1iJCQcDletJF3oENFX4=
X-Google-Smtp-Source: APXvYqwNGNYETi7ng8es+TXtOFFin6vTcu5udZz9IHy+ZmrDy2RrR6zf1eAB/LVHZerCcV15i2hYmaM9vCydHZM/3Ks=
X-Received: by 2002:aca:650a:: with SMTP id m10mr836881oim.106.1573592232984; 
 Tue, 12 Nov 2019 12:57:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Tue, 12 Nov 2019 12:57:12
 -0800 (PST)
In-Reply-To: <87tv79823k.fsf@linaro.org>
References: <1573240249-6966-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573240249-6966-2-git-send-email-aleksandar.markovic@rt-rk.com>
 <87tv79823k.fsf@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 12 Nov 2019 21:57:12 +0100
Message-ID: <CAL1e-=hr6RACEo=uVZZRNSyrmVd3yvqS=Qj24Pny6C=Sryvwuw@mail.gmail.com>
Subject: Re: [PATCH 1/5] MAINTAINERS: Add a section on git infrastructure
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000001185d605972c7e96"
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "hpoussin@reactos.org" <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001185d605972c7e96
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, November 12, 2019, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:

>
> Aleksandar Markovic <aleksandar.markovic@rt-rk.com> writes:
>
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > There should be a patient person maintaining gory details of
> > git-related files, and there is no better person for that role
> > than Philippe. Alex should be the reviewer for some relations
> > with gitdm.
>
> I'm not sure about this. The .gitignore files are best updated by people
> responsible for the various parts of the tree. Once out-of-tree builds
> become standard we should be able to eliminate them all together. As far
> as .mailmap is concerned I think people are quite capable of updating it
> themselves without putting the changes through a maintainer tree.
>
>
Thank you Alex for your feedback.

People here are mainly concerned about the substance of their contribution,
and don't know or don't care about .mailmap file - as evidenced by many
items Philippe had to add to that file. The essence of this patch was not
to force people to go to the maintainer approval, but that the maintainer
ftom time to time refreshes the file, if needed.

But, OK, if you have such reservations that you mentioned, I am going to
remove this patch in v2. We leave all these files listed in this patch
unmaintained.

Yours,
Aleksandar



> >
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > ---
> >  MAINTAINERS | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4964fbb..be43ccb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2664,6 +2664,23 @@ M: Daniel P. Berrange <berrange@redhat.com>
> >  S: Odd Fixes
> >  F: scripts/git-submodule.sh
> >
> > +GIT infrastructure
> > +M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > +R: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > +S: Maintained
> > +F: .mailmap
> > +F: scripts/git.orderfile
> > +F: .gitignore
> > +F: tests/fp/.gitignore
> > +F: tests/fp/berkeley-softfloat-3/.gitignore
> > +F: tests/fp/berkeley-testfloat-3/.gitignore
> > +F: tests/migration/.gitignore
> > +F: tests/multiboot/.gitignore
> > +F: tests/qemu-iotests/.gitignore
> > +F: tests/tcg/.gitignore
> > +F: tests/uefi-test-tools/.gitignore
> > +F: ui/keycodemapdb/tests/.gitignore
> > +
> >  Sphinx documentation configuration and build machinery
> >  M: Peter Maydell <peter.maydell@linaro.org>
> >  S: Maintained
>
>
> --
> Alex Benn=C3=A9e
>
>

--0000000000001185d605972c7e96
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, November 12, 2019, Alex Benn=C3=A9e &lt;<a href=3D"mail=
to:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><br>
Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.markovic@rt-rk.com">al=
eksandar.markovic@rt-rk.com</a>&gt; writes:<br>
<br>
&gt; From: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com=
">amarkovic@wavecomp.com</a>&gt;<br>
&gt;<br>
&gt; There should be a patient person maintaining gory details of<br>
&gt; git-related files, and there is no better person for that role<br>
&gt; than Philippe. Alex should be the reviewer for some relations<br>
&gt; with gitdm.<br>
<br>
I&#39;m not sure about this. The .gitignore files are best updated by peopl=
e<br>
responsible for the various parts of the tree. Once out-of-tree builds<br>
become standard we should be able to eliminate them all together. As far<br=
>
as .mailmap is concerned I think people are quite capable of updating it<br=
>
themselves without putting the changes through a maintainer tree.<br>
<br></blockquote><div><br></div><div>Thank you Alex for your feedback.</div=
><div><br></div><div>People here are mainly concerned about the substance o=
f their contribution, and don&#39;t know or don&#39;t care about .mailmap f=
ile - as evidenced by many items Philippe had to add to that file. The esse=
nce of this patch was not to force people to go to the maintainer approval,=
 but that the maintainer ftom time to time refreshes the file, if needed.</=
div><div><br></div><div>But, OK, if you have such reservations that you men=
tioned, I am going to remove this patch in v2. We leave all these files lis=
ted in this patch unmaintained.</div><div><br></div><div>Yours,</div><div>A=
leksandar</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
&gt;<br>
&gt; Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wav=
ecomp.com">amarkovic@wavecomp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 MAINTAINERS | 17 +++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 17 insertions(+)<br>
&gt;<br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 4964fbb..be43ccb 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -2664,6 +2664,23 @@ M: Daniel P. Berrange &lt;<a href=3D"mailto:ber=
range@redhat.com">berrange@redhat.com</a>&gt;<br>
&gt;=C2=A0 S: Odd Fixes<br>
&gt;=C2=A0 F: scripts/git-submodule.sh<br>
&gt;<br>
&gt; +GIT infrastructure<br>
&gt; +M: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.co=
m">philmd@redhat.com</a>&gt;<br>
&gt; +R: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">ale=
x.bennee@linaro.org</a>&gt;<br>
&gt; +S: Maintained<br>
&gt; +F: .mailmap<br>
&gt; +F: scripts/git.orderfile<br>
&gt; +F: .gitignore<br>
&gt; +F: tests/fp/.gitignore<br>
&gt; +F: tests/fp/berkeley-softfloat-3/<wbr>.gitignore<br>
&gt; +F: tests/fp/berkeley-testfloat-3/<wbr>.gitignore<br>
&gt; +F: tests/migration/.gitignore<br>
&gt; +F: tests/multiboot/.gitignore<br>
&gt; +F: tests/qemu-iotests/.gitignore<br>
&gt; +F: tests/tcg/.gitignore<br>
&gt; +F: tests/uefi-test-tools/.<wbr>gitignore<br>
&gt; +F: ui/keycodemapdb/tests/.<wbr>gitignore<br>
&gt; +<br>
&gt;=C2=A0 Sphinx documentation configuration and build machinery<br>
&gt;=C2=A0 M: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org"=
>peter.maydell@linaro.org</a>&gt;<br>
&gt;=C2=A0 S: Maintained<br>
<br>
<br>
--<br>
Alex Benn=C3=A9e<br>
<br>
</blockquote>

--0000000000001185d605972c7e96--

