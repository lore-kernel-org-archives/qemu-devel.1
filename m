Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514CBC11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 16:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138392080D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 16:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWVZWExL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138392080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6GWv-00081D-7t
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 11:24:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1j6GWF-0007Ct-DO
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 11:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1j6GWD-0004Co-0d
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 11:23:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40620
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1j6GWC-0004C1-RK
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 11:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582561419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jaw3SmCktmpI+hX6wGmut4wg4apv8E/jH+KCDj9ypQ0=;
 b=GWVZWExLZGtdmg+suDC3tkLSdLP5W2F6jE2HXeRVf2yxU+Lr/QV2eQNV6AOuzMW+0avGZp
 UOJi7b32PAwTdf+/67qehXgnl0jS8y7U8lX1wrDH6qjLFUqZqop0qAj/skO84vf51wMa1m
 bRhrQLA/DefEYpyTRUmx+quSrDTTClA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-SC_MP95nOdm1eh3mE8KJJw-1; Mon, 24 Feb 2020 11:23:29 -0500
X-MC-Unique: SC_MP95nOdm1eh3mE8KJJw-1
Received: by mail-wr1-f70.google.com with SMTP id n23so5816136wra.20
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 08:23:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9UbYCv2YQ6hMkWZsrg5XkxDk6aVE19XE40GnZj+ocpk=;
 b=posi0ZEhDU4DyFCaIy4wC9iie6Q808cPhBEV4VDFZdNWxQlovxu8stI2N2b4K2v7Lo
 54B5pI1/+nJ77q1w2pD09RCxyYZHNBiW3WvW1G5f7BZWn8xbQWq6pHflZjSGmwOYjm5o
 H2n8WEFEP7Lagk/WhRqdg1wCjJmopx/WpYh3Y1CpY9DIwBZjIKwTctEL24cBAzleeBMh
 5IgYIJMW04lC46J6UqwGVh2z2SVsvHl2G2J1QWMaFsFZg0FGY78NhSTZ47am7YjIqjb8
 3WNjWC8Yw3JKZcPuSda1Qm2txjOTD/6W5UYsyg3ZpTOFS94UmDHD3F98qLJNDJUdIt6z
 NDlQ==
X-Gm-Message-State: APjAAAU05/qemfsGGWhyUD7ceBqHx675j+7UyWcolwMfs9oP08VRd+md
 zypPiywWLhVOhMqto6EEvZKOAL1PZ7bQH7LfMkWG1c0YryOXLgSyk+bGLyFTax9X8B8TJZhK2M8
 Zd4Z4/UR/fn3KMTkiQ3SrYP2MpXYPWgQ=
X-Received: by 2002:a5d:4d04:: with SMTP id z4mr72674035wrt.157.1582561408071; 
 Mon, 24 Feb 2020 08:23:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZDjliXNWp45/LJGyxIDJohi1FBiGM8JeYDVmLxwhyclX8UsKOvxx42lJOf9zW1kiSOfdo4VPYmH0y3bxL1r4=
X-Received: by 2002:a5d:4d04:: with SMTP id z4mr72674007wrt.157.1582561407847; 
 Mon, 24 Feb 2020 08:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20200214145235.4378-1-ovoshcha@redhat.com>
 <20200214145235.4378-4-ovoshcha@redhat.com>
 <875891d8-23f7-2603-2c51-9a734cf148b6@redhat.com>
In-Reply-To: <875891d8-23f7-2603-2c51-9a734cf148b6@redhat.com>
From: Oksana Voshchana <ovoshcha@redhat.com>
Date: Mon, 24 Feb 2020 18:23:15 +0200
Message-ID: <CAMXCgj4STmWcco4vqr1Mvwrc+YE-B6r+bAh00S0PmPZya001yA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] Acceptance test: provides new functions
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000008ce307059f54cabb"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008ce307059f54cabb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wainer,
Thanks for review

On Fri, Feb 21, 2020 at 8:31 PM Wainer dos Santos Moschetta <
wainersm@redhat.com> wrote:

> Hi Oksana,
>
> On 2/14/20 12:52 PM, Oksana Vohchana wrote:
> > Adds functions to check if service RDMA is enabled and gets the interfa=
ce
> > where it was configured
> >
> > Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
> > ---
> >   tests/acceptance/migration.py | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> >
> > diff --git a/tests/acceptance/migration.py
> b/tests/acceptance/migration.py
> > index 8209dcf71d..bbd88f8dda 100644
> > --- a/tests/acceptance/migration.py
> > +++ b/tests/acceptance/migration.py
> > @@ -11,12 +11,16 @@
> >
> >
> >   import tempfile
> > +import re
> > +import netifaces
>
> Since netifaces isn't a standard Python library that import might fail.
>
> The tests dependencies are listed in tests/requirements.txt, and
> installed in the environment created by `make check-acceptance`. If you
> want to ensure the test behaves well even when executed manually (i.e.
> not via `make check-acceptance`), you can add runtime checks as can be
> seen in tests/acceptance/machine_m68k_nextcube.py
>

Thanks, a "runtime checks" is a good approach
I'll improve it


>
> >   from avocado_qemu import Test
> >   from avocado import skipUnless
> >
> >   from avocado.utils import network
> >   from avocado.utils import wait
> >   from avocado.utils.path import find_command
> > +from avocado.utils import service
> > +from avocado.utils import process
> >
> >
> >   class Migration(Test):
> > @@ -58,6 +62,19 @@ class Migration(Test):
> >               self.cancel('Failed to find a free port')
> >           return port
> >
> > +    def _if_rdma_enable(self):
> > +        rdma_stat =3D service.ServiceManager()
> > +        rdma =3D rdma_stat.status('rdma')
> > +        return rdma
>
>
> Above function is used on patch04, but actually I don't think it needs
> to check this service for RoCE. It would be needed if it was using the
> rxe_cfg to configure the rdma link. Or am I missing something?
>
>  The function _if_rdma_enable() checks if RDMA service enabled in the
system it does not depend on wich utils we will use to check if some
network configuration present (rdma or rxe_cfg)


> > +
> > +    def _get_ip_rdma(self):
> > +        get_ip_rdma =3D process.run('rdma link show').stdout.decode()
> > +        for line in get_ip_rdma.split('\n'):
> > +            if re.search(r"ACTIVE", line):
> > +                interface =3D line.split(" ")[-2]
> > +                ip =3D
> netifaces.ifaddresses(interface)[netifaces.AF_INET][0]['addr']
> > +                return ip
> > +
>
> I suggest that it explicitly returns None if none is found.
>

Ok, I agree
I'll improve it


> Thanks!
>
> - Wainer
>
> >
> >       def test_migration_with_tcp_localhost(self):
> >           dest_uri =3D 'tcp:localhost:%u' % self._get_free_port()
>
>

Thanks!

--0000000000008ce307059f54cabb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0Wainer,</div><div>Thanks for review<br><br></=
div><div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Fri, Feb 21, 2020 at 8:31 PM Wainer dos Santos Moschetta &lt;=
<a href=3D"mailto:wainersm@redhat.com" target=3D"_blank">wainersm@redhat.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Hi Oksana,<br>
<br>
On 2/14/20 12:52 PM, Oksana Vohchana wrote:<br>
&gt; Adds functions to check if service RDMA is enabled and gets the interf=
ace<br>
&gt; where it was configured<br>
&gt;<br>
&gt; Signed-off-by: Oksana Vohchana &lt;<a href=3D"mailto:ovoshcha@redhat.c=
om" target=3D"_blank">ovoshcha@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0tests/acceptance/migration.py | 17 +++++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 17 insertions(+)<br>
&gt;<br>
&gt; diff --git a/tests/acceptance/migration.py b/tests/acceptance/migratio=
n.py<br>
&gt; index 8209dcf71d..bbd88f8dda 100644<br>
&gt; --- a/tests/acceptance/migration.py<br>
&gt; +++ b/tests/acceptance/migration.py<br>
&gt; @@ -11,12 +11,16 @@<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0import tempfile<br>
&gt; +import re<br>
&gt; +import netifaces<br>
<br>
Since netifaces isn&#39;t a standard Python library that import might fail.=
<br>
<br>
The tests dependencies are listed in tests/requirements.txt, and <br>
installed in the environment created by `make check-acceptance`. If you <br=
>
want to ensure the test behaves well even when executed manually (i.e. <br>
not via `make check-acceptance`), you can add runtime checks as can be <br>
seen in tests/acceptance/machine_m68k_nextcube.py<br></blockquote><div><br>=
</div><div>Thanks, a &quot;runtime checks&quot; is a good approach</div><di=
v>I&#39;ll improve it</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0from avocado_qemu import Test<br>
&gt;=C2=A0 =C2=A0from avocado import skipUnless<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0from avocado.utils import network<br>
&gt;=C2=A0 =C2=A0from avocado.utils import wait<br>
&gt;=C2=A0 =C2=A0from avocado.utils.path import find_command<br>
&gt; +from avocado.utils import service<br>
&gt; +from avocado.utils import process<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0class Migration(Test):<br>
&gt; @@ -58,6 +62,19 @@ class Migration(Test):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.cancel(&#39=
;Failed to find a free port&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return port<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 def _if_rdma_enable(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rdma_stat =3D service.ServiceManager()<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rdma =3D rdma_stat.status(&#39;rdma&#39;)=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return rdma<br>
<br>
<br>
Above function is used on patch04, but actually I don&#39;t think it needs =
<br>
to check this service for RoCE. It would be needed if it was using the <br>
rxe_cfg to configure the rdma link. Or am I missing something?<br>
<br></blockquote><div>=C2=A0The function _if_rdma_enable()=C2=A0checks if R=
DMA service enabled in the system it does not depend on wich utils we will =
use to check if some network configuration present (rdma or rxe_cfg)</div><=
div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def _get_ip_rdma(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_ip_rdma =3D process.run(&#39;rdma lin=
k show&#39;).stdout.decode()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for line in get_ip_rdma.split(&#39;\n&#39=
;):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if re.search(r&quot;ACTIVE&=
quot;, line):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interface =3D=
 line.split(&quot; &quot;)[-2]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip =3D netifa=
ces.ifaddresses(interface)[netifaces.AF_INET][0][&#39;addr&#39;]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ip<br>
&gt; +<br>
<br>
I suggest that it explicitly returns None if none is found.<br>
</blockquote><div><br></div><div>Ok, I agree<br>I&#39;ll improve it<br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Thanks=
!<br>
<br>
- Wainer<br>
<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0def test_migration_with_tcp_localhost(self):=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dest_uri =3D &#39;tcp:localhos=
t:%u&#39; % self._get_free_port()<br>
<br></blockquote><div><br></div><div><br></div><div>Thanks!=C2=A0</div></di=
v></div>
</div>

--0000000000008ce307059f54cabb--


