Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1CAC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:15:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C989B20730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfoXX+K6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C989B20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0r7-0006tZ-V3
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:15:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iz0oo-0003fi-5x
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:12:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iz0ol-0003ZG-Qn
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:12:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52824
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iz0ok-0003Uc-6i
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580832769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XuRgo2gVvOWb7XWQIgk/zfqFllH+u7AtjPo21uToWq0=;
 b=FfoXX+K6NJh++9Wa3lMhuh48mtS1J6F8hk4oxXLb1TltEzSnTO6cVzzk0UP1O5sRzcENu/
 LuDCJaQpUmdv4wRxT0HZE+Qb8Ra0xLG1Cwx+OfaoVX/XGJ42tAe30k8HZwGYbgBdm/4nhV
 xoZR6fEBBnLytuAt2LjmC864EMsJxSI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-Qdfsj3_wOi6ggjAaXeNZNA-1; Tue, 04 Feb 2020 11:12:45 -0500
Received: by mail-wr1-f70.google.com with SMTP id w6so10529369wrm.16
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 08:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9RK1g2HvlBmFUnA6xkKr2noBxMSBMuwgbK6/McbrsBU=;
 b=dDAdmZ0RoONYnIdzrJ0iTWJjR3aY6rm0b1XvFm93IdeQWCWnDacDwXCcqxmLP1vHzL
 ckqstT3SgmhOKuhWEsuAoJKhGRMX1ZKakvN0CSxfykzisNKnbUa1f0cCED+oL+8NJC2q
 AguwU+OV8aohJOtomXaxYZdRKPdOerP5J7QFbamr1rBqDiFBat6TnuXTHiXF7yd+wXAS
 hZkYvIAMTAKcZRfQAMS8k6MN34WT2kFjaOt9mNdaepdoY6aVC09XTq4e1t1o0VVqqXgB
 PAowTVIMj+fREkJOi9zMwy27mbCLZ4gp5fqv/Boa8HzM4tLfzphWUyjdCV5SAI++ZaH4
 2WMA==
X-Gm-Message-State: APjAAAUQartty/6SwTMl7s4R146kRGGe40zs1qBNetnQdUEO9iYYDX8Y
 JFQ+wNW2wFyAR6WbR5M0Me9ld9hF3mZMA2D6OrL8E/nshj3rEF2D0f9hewWXJSnEumQAUcwJwX4
 vNoDC5ES1RFYSdus=
X-Received: by 2002:a1c:ac46:: with SMTP id v67mr6315466wme.153.1580832764116; 
 Tue, 04 Feb 2020 08:12:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4GyN7DneiPczhefbkAWQLgzVpcdG0p4Sl+5ne5wuhJyKwLKZOaK3/1wS10C6GVHn/t74WIw==
X-Received: by 2002:a1c:ac46:: with SMTP id v67mr6315444wme.153.1580832763886; 
 Tue, 04 Feb 2020 08:12:43 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id f14sm11386712wrt.7.2020.02.04.08.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 08:12:43 -0800 (PST)
Subject: Re: [PATCH v3 2/2] Acceptance test: provides to use different
 transport for migration
To: Oksana Voshchana <ovoshcha@redhat.com>
References: <20200203111631.18796-1-ovoshcha@redhat.com>
 <20200203111631.18796-3-ovoshcha@redhat.com>
 <45078d7a-d934-5238-511e-876e0eb56858@redhat.com>
 <CAMXCgj6EVLAApuaqwEg28Kt-UvRxoW1dVFJWqDkZtxjF8vS92Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8b14476e-358b-46a5-fcfa-f3944d725074@redhat.com>
Date: Tue, 4 Feb 2020 17:12:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMXCgj6EVLAApuaqwEg28Kt-UvRxoW1dVFJWqDkZtxjF8vS92Q@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: Qdfsj3_wOi6ggjAaXeNZNA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On 2/4/20 4:02 PM, Oksana Voshchana wrote:
> Hi Philippe
> You can do whatever it takes
> I appreciate you for a review
> Thanks

OK I'll split as suggested then.

>=20
> On Tue, Feb 4, 2020 at 4:12 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     On 2/3/20 12:16 PM, Oksana Vohchana wrote:
>      > Along with VM migration via TCP, we can use migration through EXEC
>      > and UNIX transport protocol
>      >
>      > Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com
>     <mailto:ovoshcha@redhat.com>>
>      > ---
>      > v2:
>      >=C2=A0 =C2=A0 - Removes unnecessary symbols and unused method
>      >
>      > v3:
>      >=C2=A0 =C2=A0- Makes refactoring and split into 2 patches
>      >=C2=A0 =C2=A0- Provides TCP and EXEC migration
>      > Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com
>     <mailto:ovoshcha@redhat.com>>
>      > ---
>      >=C2=A0 =C2=A0tests/acceptance/migration.py | 16 ++++++++++++++++
>      >=C2=A0 =C2=A01 file changed, 16 insertions(+)
>      >
>      > diff --git a/tests/acceptance/migration.py
>     b/tests/acceptance/migration.py
>      > index 34263d8eeb..4419e38384 100644
>      > --- a/tests/acceptance/migration.py
>      > +++ b/tests/acceptance/migration.py
>      > @@ -10,10 +10,13 @@
>      >=C2=A0 =C2=A0# later.=C2=A0 See the COPYING file in the top-level d=
irectory.
>      >
>      >
>      > +import tempfile
>      >=C2=A0 =C2=A0from avocado_qemu import Test
>      > +from avocado import skipUnless
>      >
>      >=C2=A0 =C2=A0from avocado.utils import network
>      >=C2=A0 =C2=A0from avocado.utils import wait
>      > +from avocado.utils.path import find_command
>      >
>      >
>      >=C2=A0 =C2=A0class Migration(Test):
>      > @@ -54,3 +57,16 @@ class Migration(Test):
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0def test_migration_with_tcp_localhost(se=
lf):
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dest_uri =3D 'tcp:localhos=
t:%u' % self._get_free_port()
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.do_migrate(dest_uri)
>      > +
>      > +=C2=A0 =C2=A0 def test_migration_with_unix(self):
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 with tempfile.TemporaryDirectory(pref=
ix=3D'socket_') as
>     socket_path:
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dest_uri =3D 'unix:%s/q=
emu-test.sock' % socket_path
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_migrate(dest_ur=
i)
>=20
>     Similarly, do you mind if I split and update subjects to "Test the UN=
IX
>     transport when migrating" and "Test the TCP transport when migrating"=
?
>=20
>     Meanwhile:
>     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>=20
>      > +
>      > +=C2=A0 =C2=A0 @skipUnless(find_command('nc', default=3DFalse), "n=
c command
>     not found on the system")
>      > +=C2=A0 =C2=A0 def test_migration_with_exec(self):
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 """
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The test works for both netcat-tradit=
ional and
>     netcat-openbsd packages
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 """
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 free_port =3D self._get_free_port()
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dest_uri =3D 'exec:nc -l localhost %u=
' % free_port
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 src_uri =3D 'exec:nc localhost %u' % =
free_port
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_migrate(dest_uri, src_uri)
>      >
>=20


