Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B83CC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:03:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 061E620674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YG3jf78y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061E620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyzjq-0002BK-5z
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 10:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1iyziz-0001gS-3E
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1iyzix-0002Wl-7d
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:02:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26235
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1iyziq-0001bk-6A
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580828557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xXybZnjOOP6fWdEgf/uL1pRuRodA1PKhnVNN3MRHPOQ=;
 b=YG3jf78yfFgf5ry5E/7bkJYCmFwdbF5LmyzUFO8CW1F8hN7FlMK6E9uXU/187+68194vz/
 PrM4eP4BF9/TeWqeIk3TGe6wgsHohrxqI3CvYdPc1DATo8dk5GCkRe84bVvYsj9XvfWNzo
 6Ykuc61J93LzzhWxs2vPAwfpaB725Y8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-eoAIf-cxNAyw34pdfDYdUg-1; Tue, 04 Feb 2020 10:02:35 -0500
Received: by mail-wr1-f72.google.com with SMTP id j4so10358553wrs.13
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 07:02:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xXybZnjOOP6fWdEgf/uL1pRuRodA1PKhnVNN3MRHPOQ=;
 b=L3b+6nqueVFg/fBjVOKGpW9+KasY9SDA1QE4GyFIVaJ3TWdbSYdo21YoDlwnk5j42d
 MNgoZhHJRFZCQym/83lw6AenwQJ9SaNP8ZWNhTh10/FPPeZT/+oZmAmXytBGVWlCSHs6
 kn9bXwUUh1C+3QU9wlB7ODdx/VKc1d1sX5i1kZJ67sezHeB0vK2v2AdcSkxfAtmpn7LB
 D1cxuWNIXq/4KQJkHwE3O5zQQI51lt1tQZFjJ9mSQPwAZKNAjY7m+6Wh2hgtZbjVGA2f
 DV2IBbFKdS1SZWh/g7HOc+HrS+w0nAFXMQZScdsOVRvB04G8Y6Fg4ChXnCFFX8B0nfHd
 l6qA==
X-Gm-Message-State: APjAAAUyxvC8E1RANRNPBxbmKyjhcTDIcbiMureJNs246ArP8taDy7qq
 JosJhpOELBDG3Jo5JCK/0zyqv3MG6bBFq73ddLH0vJ9qbFGZnEfK8Hr5UcG9yWE7rPntM5Skjy2
 zhCOUv8iLf0FMn1NXwdNMF2aLImPXM/0=
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr6199030wmf.60.1580828554727; 
 Tue, 04 Feb 2020 07:02:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqzhjUwUl1wiGHaFwQDHme5KwbyBJaeJqLaZDMw/TnG5JMd33gIjtLwb+qFaOQjtckMD4UxC0frQcH/6r0Rn+D0=
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr6198652wmf.60.1580828549920; 
 Tue, 04 Feb 2020 07:02:29 -0800 (PST)
MIME-Version: 1.0
References: <20200203111631.18796-1-ovoshcha@redhat.com>
 <20200203111631.18796-3-ovoshcha@redhat.com>
 <45078d7a-d934-5238-511e-876e0eb56858@redhat.com>
In-Reply-To: <45078d7a-d934-5238-511e-876e0eb56858@redhat.com>
From: Oksana Voshchana <ovoshcha@redhat.com>
Date: Tue, 4 Feb 2020 17:02:18 +0200
Message-ID: <CAMXCgj6EVLAApuaqwEg28Kt-UvRxoW1dVFJWqDkZtxjF8vS92Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Acceptance test: provides to use different
 transport for migration
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-MC-Unique: eoAIf-cxNAyw34pdfDYdUg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000002b4d65059dc1549f"
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
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002b4d65059dc1549f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe
You can do whatever it takes
I appreciate you for a review
Thanks

On Tue, Feb 4, 2020 at 4:12 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> On 2/3/20 12:16 PM, Oksana Vohchana wrote:
> > Along with VM migration via TCP, we can use migration through EXEC
> > and UNIX transport protocol
> >
> > Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
> > ---
> > v2:
> >    - Removes unnecessary symbols and unused method
> >
> > v3:
> >   - Makes refactoring and split into 2 patches
> >   - Provides TCP and EXEC migration
> > Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
> > ---
> >   tests/acceptance/migration.py | 16 ++++++++++++++++
> >   1 file changed, 16 insertions(+)
> >
> > diff --git a/tests/acceptance/migration.py
> b/tests/acceptance/migration.py
> > index 34263d8eeb..4419e38384 100644
> > --- a/tests/acceptance/migration.py
> > +++ b/tests/acceptance/migration.py
> > @@ -10,10 +10,13 @@
> >   # later.  See the COPYING file in the top-level directory.
> >
> >
> > +import tempfile
> >   from avocado_qemu import Test
> > +from avocado import skipUnless
> >
> >   from avocado.utils import network
> >   from avocado.utils import wait
> > +from avocado.utils.path import find_command
> >
> >
> >   class Migration(Test):
> > @@ -54,3 +57,16 @@ class Migration(Test):
> >       def test_migration_with_tcp_localhost(self):
> >           dest_uri =3D 'tcp:localhost:%u' % self._get_free_port()
> >           self.do_migrate(dest_uri)
> > +
> > +    def test_migration_with_unix(self):
> > +        with tempfile.TemporaryDirectory(prefix=3D'socket_') as
> socket_path:
> > +            dest_uri =3D 'unix:%s/qemu-test.sock' % socket_path
> > +            self.do_migrate(dest_uri)
>
> Similarly, do you mind if I split and update subjects to "Test the UNIX
> transport when migrating" and "Test the TCP transport when migrating"?
>
> Meanwhile:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> > +
> > +    @skipUnless(find_command('nc', default=3DFalse), "nc command not
> found on the system")
> > +    def test_migration_with_exec(self):
> > +        """
> > +        The test works for both netcat-traditional and netcat-openbsd
> packages
> > +        """
> > +        free_port =3D self._get_free_port()
> > +        dest_uri =3D 'exec:nc -l localhost %u' % free_port
> > +        src_uri =3D 'exec:nc localhost %u' % free_port
> > +        self.do_migrate(dest_uri, src_uri)
> >
>
>

--0000000000002b4d65059dc1549f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Philippe<div>You can do whatever it takes<br></div><div=
>I appreciate you for a review<br></div><div>Thanks</div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 4, 202=
0 at 4:12 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com">philmd@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On 2/3/20 12:16 PM, Oksana Vohchana wrote:<br>
&gt; Along with VM migration via TCP, we can use migration through EXEC<br>
&gt; and UNIX transport protocol<br>
&gt; <br>
&gt; Signed-off-by: Oksana Vohchana &lt;<a href=3D"mailto:ovoshcha@redhat.c=
om" target=3D"_blank">ovoshcha@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt; v2:<br>
&gt;=C2=A0 =C2=A0 - Removes unnecessary symbols and unused method<br>
&gt; <br>
&gt; v3:<br>
&gt;=C2=A0 =C2=A0- Makes refactoring and split into 2 patches<br>
&gt;=C2=A0 =C2=A0- Provides TCP and EXEC migration<br>
&gt; Signed-off-by: Oksana Vohchana &lt;<a href=3D"mailto:ovoshcha@redhat.c=
om" target=3D"_blank">ovoshcha@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0tests/acceptance/migration.py | 16 ++++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 16 insertions(+)<br>
&gt; <br>
&gt; diff --git a/tests/acceptance/migration.py b/tests/acceptance/migratio=
n.py<br>
&gt; index 34263d8eeb..4419e38384 100644<br>
&gt; --- a/tests/acceptance/migration.py<br>
&gt; +++ b/tests/acceptance/migration.py<br>
&gt; @@ -10,10 +10,13 @@<br>
&gt;=C2=A0 =C2=A0# later.=C2=A0 See the COPYING file in the top-level direc=
tory.<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +import tempfile<br>
&gt;=C2=A0 =C2=A0from avocado_qemu import Test<br>
&gt; +from avocado import skipUnless<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0from avocado.utils import network<br>
&gt;=C2=A0 =C2=A0from avocado.utils import wait<br>
&gt; +from avocado.utils.path import find_command<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0class Migration(Test):<br>
&gt; @@ -54,3 +57,16 @@ class Migration(Test):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0def test_migration_with_tcp_localhost(self):=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dest_uri =3D &#39;tcp:localhos=
t:%u&#39; % self._get_free_port()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.do_migrate(dest_uri)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_migration_with_unix(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 with tempfile.TemporaryDirectory(prefix=
=3D&#39;socket_&#39;) as socket_path:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dest_uri =3D &#39;unix:%s/q=
emu-test.sock&#39; % socket_path<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_migrate(dest_uri)<b=
r>
<br>
Similarly, do you mind if I split and update subjects to &quot;Test the UNI=
X <br>
transport when migrating&quot; and &quot;Test the TCP transport when migrat=
ing&quot;?<br>
<br>
Meanwhile:<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 @skipUnless(find_command(&#39;nc&#39;, default=3DFalse)=
, &quot;nc command not found on the system&quot;)<br>
&gt; +=C2=A0 =C2=A0 def test_migration_with_exec(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The test works for both netcat-traditiona=
l and netcat-openbsd packages<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 free_port =3D self._get_free_port()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dest_uri =3D &#39;exec:nc -l localhost %u=
&#39; % free_port<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 src_uri =3D &#39;exec:nc localhost %u&#39=
; % free_port<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_migrate(dest_uri, src_uri)<br>
&gt; <br>
<br>
</blockquote></div>

--0000000000002b4d65059dc1549f--


