Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2D3C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 02:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53474206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 02:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TO0QWYb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53474206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ichFb-0001nH-HA
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 21:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hhan@redhat.com>) id 1ichCt-00085g-2T
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 21:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hhan@redhat.com>) id 1ichCr-0008PC-Hv
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 21:49:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51412
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hhan@redhat.com>) id 1ichCr-0008OK-B8
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 21:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575514169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=INrzNWQ2sEFB49pmeNP5OwZF3YgSouxq+qJpAnZvbAI=;
 b=TO0QWYb3WoZe1sltX17NdF/7kjwG93gnaB4kyG5yPP18Jrm4df+ONLkOuLrhbTjAlnh/nq
 9nGksHlBjWv/V/YaB78wqjwGhBitKgOp0boMlBoSyylqZZ5SfBHzIquNeg5evzzjcZDEfg
 upxFnQ2QHpfsDGQ8Edse2CBSiAazxPk=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-YC6CkzaCPHiv0j7R0oAjHQ-1; Wed, 04 Dec 2019 21:49:25 -0500
Received: by mail-oi1-f200.google.com with SMTP id 23so965942oii.4
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 18:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/FHyWsJWlmYQyUU2NNNx+HtFBNJMHMBbTGB3Wb/GcF8=;
 b=esltr+HfgiQSOl0S0oHzC0ZeMg6JNjLzGcEuKHZJ0+ijdvsqHDLbZJwNWQcO5Od/hY
 f5zi5fOFjEN68jxUfAFu70Wt3RpKpoK/m97Pg3U1wKAs50TEwsfsUcAzptPSVw8ggUEc
 UjZJgBIU0FMsetKj5v3uENoJ4TZ2r5/b7c8KkRM8AECM3Ayl79+MExU6hfKjVw3oTK7H
 7ZpOIP+FJbK8kWb1nKY4zGHnrEz3Whg1J0J77zjHpk5xHDXbDQ5kdiR4TJyGaAQ4BxkZ
 WY+N3xIKll9qqxYnNvfrOfX5OX5qIwRFDrr8c4ZbSgmmz83eJhu+kDNKuO77/NTjed4Z
 7JJg==
X-Gm-Message-State: APjAAAW45zVexr/70Big0DHH5qZv0YJoEORF2x2arEldmCkdq1sI/caI
 WAptrzYxln/fEZFSsTb4trGf+/CDyFcQSoNA4WI74Idkrm08YeYPgYOeeifpR54g5TLsWvzcpgY
 H8xPHl7e+N/1+c0a1SyJGLoY0ExBKuz8=
X-Received: by 2002:aca:ab85:: with SMTP id u127mr5278975oie.96.1575514164773; 
 Wed, 04 Dec 2019 18:49:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqwlyAXtUyyxI3QGjsh/EoRk9Z3MpOWYCeWbYx9irJzOxpktrb7T4jsC/UkzgbDqmZXwrH4hX82YzbeQnqp96e4=
X-Received: by 2002:aca:ab85:: with SMTP id u127mr5278972oie.96.1575514164558; 
 Wed, 04 Dec 2019 18:49:24 -0800 (PST)
MIME-Version: 1.0
References: <20191204085628.2892-1-hhan@redhat.com>
 <20191204122140.GI3325@work-vm>
In-Reply-To: <20191204122140.GI3325@work-vm>
From: Han Han <hhan@redhat.com>
Date: Thu, 5 Dec 2019 10:49:13 +0800
Message-ID: <CAHjf+S_qH0MSxQX+A98uVi5iFYPvLd-dzAoArkPFovYGFvLs6A@mail.gmail.com>
Subject: Re: [PATCH] Revert "qemu-options.hx: Update for reboot-timeout
 parameter"
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
X-MC-Unique: YC6CkzaCPHiv0j7R0oAjHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/alternative; boundary="0000000000001e17d70598ebfa3d"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001e17d70598ebfa3d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK. Updated in version 2.

On Wed, Dec 4, 2019 at 8:21 PM Dr. David Alan Gilbert <dgilbert@redhat.com>
wrote:

> * Han Han (hhan@redhat.com) wrote:
> > This reverts commit bbd9e6985ff342cbe15b9cb7eb30e842796fbbe8.
>
> Patchew spotted you're missing the signed-off-by; please send one.
>
> Dave
>
> > In 20a1922032 we allowed reboot-timeout=3D-1 again, so update the doc
> > accordingly.
> > ---
> >  qemu-options.hx | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 65c9473b73..e14d88e9b2 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -327,8 +327,8 @@ format(true color). The resolution should be
> supported by the SVGA mode, so
> >  the recommended is 320x240, 640x480, 800x640.
> >
> >  A timeout could be passed to bios, guest will pause for
> @var{rb_timeout} ms
> > -when boot failed, then reboot. If @option{reboot-timeout} is not set,
> > -guest will not reboot by default. Currently Seabios for X86
> > +when boot failed, then reboot. If @var{rb_timeout} is '-1', guest will
> not
> > +reboot, qemu passes '-1' to bios by default. Currently Seabios for X86
> >  system support it.
> >
> >  Do strict boot via @option{strict=3Don} as far as firmware/BIOS
> > --
> > 2.24.0.rc1
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>

--=20
Best regards,
-----------------------------------
Han Han
Quality Engineer
Redhat.

Email: hhan@redhat.com
Phone: +861065339333

--0000000000001e17d70598ebfa3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">OK. Updated in version 2.<br></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 4, 2019 at 8:21 P=
M Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgilbert@redhat.com">dgilber=
t@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">* Han Han (<a href=3D"mailto:hhan@redhat.com" target=3D"_blank"=
>hhan@redhat.com</a>) wrote:<br>
&gt; This reverts commit bbd9e6985ff342cbe15b9cb7eb30e842796fbbe8.<br>
<br>
Patchew spotted you&#39;re missing the signed-off-by; please send one.<br>
<br>
Dave<br>
<br>
&gt; In 20a1922032 we allowed reboot-timeout=3D-1 again, so update the doc<=
br>
&gt; accordingly.<br>
&gt; ---<br>
&gt;=C2=A0 qemu-options.hx | 4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/qemu-options.hx b/qemu-options.hx<br>
&gt; index 65c9473b73..e14d88e9b2 100644<br>
&gt; --- a/qemu-options.hx<br>
&gt; +++ b/qemu-options.hx<br>
&gt; @@ -327,8 +327,8 @@ format(true color). The resolution should be suppo=
rted by the SVGA mode, so<br>
&gt;=C2=A0 the recommended is 320x240, 640x480, 800x640.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 A timeout could be passed to bios, guest will pause for @var{rb_=
timeout} ms<br>
&gt; -when boot failed, then reboot. If @option{reboot-timeout} is not set,=
<br>
&gt; -guest will not reboot by default. Currently Seabios for X86<br>
&gt; +when boot failed, then reboot. If @var{rb_timeout} is &#39;-1&#39;, g=
uest will not<br>
&gt; +reboot, qemu passes &#39;-1&#39; to bios by default. Currently Seabio=
s for X86<br>
&gt;=C2=A0 system support it.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Do strict boot via @option{strict=3Don} as far as firmware/BIOS<=
br>
&gt; -- <br>
&gt; 2.24.0.rc1<br>
&gt; <br>
--<br>
Dr. David Alan Gilbert / <a href=3D"mailto:dgilbert@redhat.com" target=3D"_=
blank">dgilbert@redhat.com</a> / Manchester, UK<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr=
">Best regards,</div><div dir=3D"ltr">-----------------------------------<b=
r></div><div dir=3D"ltr">Han Han<br>Quality Engineer<br>Redhat.<br><br>Emai=
l: <a href=3D"mailto:hhan@redhat.com" target=3D"_blank">hhan@redhat.com</a>=
<br>Phone: +861065339333<br></div></div></div></div></div></div>

--0000000000001e17d70598ebfa3d--


