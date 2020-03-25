Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DD9C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B79A20722
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdFpuYAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B79A20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH6kX-0003mA-PX
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 10:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1jH6jo-0003Cw-MX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1jH6jl-0003Bb-Ti
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:10:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1jH6jl-0003Am-O2
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585145429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ipphwamGdSymJIvelK0Pesx0X7Dw5TKqJ7wbJy+9E+0=;
 b=YdFpuYAxEi7CqFEZFQPkPYaBHm69kUEBLFASrE44Ohzw1QyRmBHl6mZcps/9CFJU6UXQWN
 McbG2II3vH4YrG5zgLFJIX8TitWiRP4zIOOO+IEm4p9BrQ2BMyMjpCK5GDcz2aub4E7Fd8
 j8Fi/r3UOg9r7AF8mqfzomRz+5tLkD8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-0yNlKfFwNr29QJ0EcBc9GQ-1; Wed, 25 Mar 2020 10:10:24 -0400
X-MC-Unique: 0yNlKfFwNr29QJ0EcBc9GQ-1
Received: by mail-wm1-f70.google.com with SMTP id 2so938452wmf.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 07:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ipphwamGdSymJIvelK0Pesx0X7Dw5TKqJ7wbJy+9E+0=;
 b=Vftqz8DLUGAPom+Oeo01RsScgONDIKmDM5h3wuf1nSnhxbEXUxxXGfqBeQZ328yhkg
 hWKbxHCk9ofxl/WbGZ9Pytlb5lH8gbJYpoizcqw9n6lP7OdDMfNDZDMSXLpurZ4Xjsxx
 BkiR45VLkIbq1UYGv+AgJtkZbRBInOfnZX4hn6MGn3W79cSO0jzXV4NtD052mY8Z4gZG
 gI9J620Di+ljFNO8p8RRCxdD6UikPjjNvOxYqVZWicBTiCj+neyEOdv7N+MPXwMT54uY
 vz1LSYknGHtT8Bu0tlziPeJ2sBFx8nyAqk7eoni3isDBqJABA7MEADcnCW5Tgw7VpD2/
 7VMQ==
X-Gm-Message-State: ANhLgQ0g6Jip9J8cB39FO9Qoo4TBkwISuVSF0BiG2D0qYgRhrqGQ18TJ
 BfxFyugCuzzyUDRvG2i+K0qVIpfEmyssLTs+j8rNqH0sDRx6BJ7qLH2KsAEXB05TMKE7iCH97vV
 YAD0V8CNLRVo3mP07sX1MQwGjWMIFxXo=
X-Received: by 2002:a05:600c:2101:: with SMTP id
 u1mr3622399wml.177.1585145422893; 
 Wed, 25 Mar 2020 07:10:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt4xmAYJ8vlo8YyKC2BdXPYIieVxDtqGmpKo5ylsUFUqYLNhivhypebRlJ2CTt+gqtsn88MNn7dSs+0mqveNUY=
X-Received: by 2002:a05:600c:2101:: with SMTP id
 u1mr3622332wml.177.1585145421861; 
 Wed, 25 Mar 2020 07:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200325113138.20337-1-ovoshcha@redhat.com>
 <c2007a51-318a-c935-dd77-232e45587b08@redhat.com>
In-Reply-To: <c2007a51-318a-c935-dd77-232e45587b08@redhat.com>
From: Oksana Voshchana <ovoshcha@redhat.com>
Date: Wed, 25 Mar 2020 16:10:10 +0200
Message-ID: <CAMXCgj6dop2SFBnN3Yr6otxpMVSMMrh9_DdJw9SB3RV7z+eQ2Q@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 v3] Acceptance test: Fix to EXEC migration
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000c9ace205a1ae6ddb"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Wainer Moschetta <wainersm@redhat.com>,
 Cleber Rosa Junior <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c9ace205a1ae6ddb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe
Thanks for the review
I have some comments

On Wed, Mar 25, 2020 at 2:30 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> Hi Oksana,
>
> v2 was
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg682899.html, so
> this is v3. Please increment the version in the patch subject.
>
> You could also send a simple "ping" to the specific patch, instead of
> resending it.
>
> On 3/25/20 12:31 PM, Oksana Vohchana wrote:
> > The exec migration test isn't run a whole test scenario.
> > This patch fixes it
> >
> > Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
>
> v1 of this patch has already received reviewers tags
> (https://www.mail-archive.com/qemu-devel@nongnu.org/msg679629.html),
> please collect them and keep them when you resend the same patch:
>

I have reposted patch without this fix because this change isn't related to
the series:
https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg06919.html
Is it make sense to keep this fix as a separate patch?


> Fixes: 2e768cb682bf
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>
> > ---
> >   tests/acceptance/migration.py | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tests/acceptance/migration.py
> b/tests/acceptance/migration.py
> > index a8367ca023..0365289cda 100644
> > --- a/tests/acceptance/migration.py
> > +++ b/tests/acceptance/migration.py
> > @@ -70,8 +70,8 @@ class Migration(Test):
> >
> >       @skipUnless(find_command('nc', default=3DFalse), "'nc' command no=
t
> found")
> >       def test_migration_with_exec(self):
> > -        """
> > -        The test works for both netcat-traditional and netcat-openbsd
> packages
> > -        """
> > +        """The test works for both netcat-traditional and
> netcat-openbsd packages."""
>
> Btw why are you changing the comment style?
>

I got failure in PEP257


> >           free_port =3D self._get_free_port()
> >           dest_uri =3D 'exec:nc -l localhost %u' % free_port
> > +        src_uri =3D 'exec:nc localhost %u' % free_port
> > +        self.do_migrate(dest_uri, src_uri)
> >
>
> Alex, if there is no Python testing pullreq, can you take this patch via
> your testing tree?
>
> Thanks,
>
> Phil.
>
> Thanks

--000000000000c9ace205a1ae6ddb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0Philippe</div><div>Thanks for the review</div=
>I have some comments<div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Wed, Mar 25, 2020 at 2:30 PM Philippe Mathieu-Daud=
=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Oksana,=
<br>
<br>
v2 was <br>
<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg682899.htm=
l" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qemu-d=
evel@nongnu.org/msg682899.html</a>, so <br>
this is v3. Please increment the version in the patch subject.<br>
<br>
You could also send a simple &quot;ping&quot; to the specific patch, instea=
d of <br>
resending it.<br>
<br>
On 3/25/20 12:31 PM, Oksana Vohchana wrote:<br>
&gt; The exec migration test isn&#39;t run a whole test scenario.<br>
&gt; This patch fixes it<br>
&gt; <br>
&gt; Signed-off-by: Oksana Vohchana &lt;<a href=3D"mailto:ovoshcha@redhat.c=
om" target=3D"_blank">ovoshcha@redhat.com</a>&gt;<br>
<br>
v1 of this patch has already received reviewers tags <br>
(<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg679629.ht=
ml" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qemu-=
devel@nongnu.org/msg679629.html</a>), <br>
please collect them and keep them when you resend the same patch:<br></bloc=
kquote><div>=C2=A0</div><div>I have reposted patch without this fix because=
 this change isn&#39;t related to the series:</div><div><a href=3D"https://=
lists.gnu.org/archive/html/qemu-devel/2020-03/msg06919.html">https://lists.=
gnu.org/archive/html/qemu-devel/2020-03/msg06919.html</a><br></div><div>Is =
it make sense to keep this fix as a separate patch?<br></div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
Fixes: 2e768cb682bf<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
Tested-by: Wainer dos Santos Moschetta &lt;<a href=3D"mailto:wainersm@redha=
t.com" target=3D"_blank">wainersm@redhat.com</a>&gt;<br>
<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0tests/acceptance/migration.py | 6 +++---<br>
&gt;=C2=A0 =C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/tests/acceptance/migration.py b/tests/acceptance/migratio=
n.py<br>
&gt; index a8367ca023..0365289cda 100644<br>
&gt; --- a/tests/acceptance/migration.py<br>
&gt; +++ b/tests/acceptance/migration.py<br>
&gt; @@ -70,8 +70,8 @@ class Migration(Test):<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@skipUnless(find_command(&#39;nc&#39;, defau=
lt=3DFalse), &quot;&#39;nc&#39; command not found&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0def test_migration_with_exec(self):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 The test works for both netcat-traditiona=
l and netcat-openbsd packages<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;The test works for both=
 netcat-traditional and netcat-openbsd packages.&quot;&quot;&quot;<br>
<br>
Btw why are you changing the comment style?<br></blockquote><div>=C2=A0</di=
v><div>I got failure=C2=A0in PEP257<br></div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_port =3D self._get_free_p=
ort()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dest_uri =3D &#39;exec:nc -l l=
ocalhost %u&#39; % free_port<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 src_uri =3D &#39;exec:nc localhost %u&#39=
; % free_port<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_migrate(dest_uri, src_uri)<br>
&gt; <br>
<br>
Alex, if there is no Python testing pullreq, can you take this patch via <b=
r>
your testing tree?<br>
<br>
Thanks,<br>
<br>
Phil.<br>
<br></blockquote><div>Thanks=C2=A0</div></div></div></div>

--000000000000c9ace205a1ae6ddb--


