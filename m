Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931BEC5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521CD2085B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQDZBiUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521CD2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSjaF-0007qh-Eg
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 10:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iSjZR-00073A-Tg
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iSjZP-0001qD-9c
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:19:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28177
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iSjZP-0001pz-5S
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573139974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=awK3nK8ZAxAQXPHUUTZ/Kt0NLbGFJSib0qIzZhErfIQ=;
 b=hQDZBiUExdPWrlwh/ah1EHvJHZYPVEtA1tdALuReHoxcbQZ5tOP1UdSauIsEmMJyg1PdME
 nYPa19ZgHPu61cO0vMcCWiRvqDznkw8BILL+SV3sKomDRaf+luqW1GmLFDbU1+Ro7ZbPn6
 UREtfOGKugpQuy9vYwMjkHw0rbuNgls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-vvLlCgTCN8-DbKvAdP4W0w-1; Thu, 07 Nov 2019 10:19:30 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3A3E800C61;
 Thu,  7 Nov 2019 15:19:29 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22AAC5D9E5;
 Thu,  7 Nov 2019 15:19:27 +0000 (UTC)
Message-ID: <4505781779e0e23d2c6df6ba3e6874fe4e4a9db2.camel@redhat.com>
Subject: Re: [PATCH v2 20/21] iotests: Disable data_file where it cannot be
 used
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Thu, 07 Nov 2019 17:19:26 +0200
In-Reply-To: <ec97587f-db3b-65ba-0dab-16b2c86002d0@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
 <20191015142729.18123-21-mreitz@redhat.com>
 <d6b0e876927d8e6c28d708f7ac460e48f2b24384.camel@redhat.com>
 <ec97587f-db3b-65ba-0dab-16b2c86002d0@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: vvLlCgTCN8-DbKvAdP4W0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-11-07 at 12:36 +0100, Max Reitz wrote:
> On 06.11.19 16:52, Maxim Levitsky wrote:
> > On Tue, 2019-10-15 at 16:27 +0200, Max Reitz wrote:
> > > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > > ---
> > >  tests/qemu-iotests/007 | 5 +++--
> > >  tests/qemu-iotests/014 | 2 ++
> > >  tests/qemu-iotests/015 | 5 +++--
> > >  tests/qemu-iotests/026 | 5 ++++-
> > >  tests/qemu-iotests/029 | 5 +++--
> > >  tests/qemu-iotests/031 | 6 +++---
> > >  tests/qemu-iotests/036 | 5 +++--
> > >  tests/qemu-iotests/039 | 3 +++
> > >  tests/qemu-iotests/046 | 2 ++
> > >  tests/qemu-iotests/048 | 2 ++
> > >  tests/qemu-iotests/051 | 5 +++--
> > >  tests/qemu-iotests/058 | 5 +++--
> > >  tests/qemu-iotests/060 | 6 ++++--
> > >  tests/qemu-iotests/061 | 6 ++++--
> > >  tests/qemu-iotests/062 | 2 +-
> > >  tests/qemu-iotests/066 | 2 +-
> > >  tests/qemu-iotests/067 | 6 ++++--
> > >  tests/qemu-iotests/068 | 5 +++--
> > >  tests/qemu-iotests/071 | 3 +++
> > >  tests/qemu-iotests/073 | 2 ++
> > >  tests/qemu-iotests/074 | 2 ++
> > >  tests/qemu-iotests/080 | 5 +++--
> > >  tests/qemu-iotests/090 | 2 ++
> > >  tests/qemu-iotests/098 | 6 ++++--
> > >  tests/qemu-iotests/099 | 3 ++-
> > >  tests/qemu-iotests/103 | 5 +++--
> > >  tests/qemu-iotests/108 | 6 ++++--
> > >  tests/qemu-iotests/112 | 5 +++--
> > >  tests/qemu-iotests/114 | 2 ++
> > >  tests/qemu-iotests/121 | 3 +++
> > >  tests/qemu-iotests/138 | 2 ++
> > >  tests/qemu-iotests/156 | 2 ++
> > >  tests/qemu-iotests/176 | 7 +++++--
> > >  tests/qemu-iotests/191 | 2 ++
> > >  tests/qemu-iotests/201 | 6 +++---
> > >  tests/qemu-iotests/214 | 3 ++-
> > >  tests/qemu-iotests/217 | 3 ++-
> > >  tests/qemu-iotests/220 | 5 +++--
> > >  tests/qemu-iotests/243 | 6 ++++--
> > >  tests/qemu-iotests/244 | 5 +++--
> > >  tests/qemu-iotests/250 | 2 ++
> > >  tests/qemu-iotests/267 | 5 +++--
> > >  42 files changed, 117 insertions(+), 52 deletions(-)
>=20
> [...]
>=20
> > > diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
> > > index c44fcf91bb..646ecd593f 100755
> > > --- a/tests/qemu-iotests/031
> > > +++ b/tests/qemu-iotests/031
> > > @@ -40,9 +40,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> > >  # This tests qcow2-specific low-level functionality
> > >  _supported_fmt qcow2
> > >  _supported_proto file
> > > -# We want to test compat=3D0.10, which does not support refcount wid=
ths
> > > -# other than 16
> > > -_unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
> > > +# We want to test compat=3D0.10, which does not support external dat=
a
> > > +# files or refcount widths other than 16
> > > +_unsupported_imgopts data_file 'refcount_bits=3D\([^1]\|.\([^6]\|$\)=
\)'
> >=20
> > This is maybe another reason to split this test for compat=3D0.10 and f=
or compat=3D1.1
> > But still can be done later of course.
>=20
> Hm, but I don=E2=80=99t really think this test is important for external =
data
> files.  There is no I/O.
I guess both yes and no, the external data file is a header extension as we=
ll.
I am looking at the tests from the point of view of someone that
doesn't know the qcow2 internally well yet, so I noted all the tests
that looked like they can still catch something.


>=20
> [...]
>=20
> > > diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
> > > index bbaf0ef45b..512598421c 100755
> > > --- a/tests/qemu-iotests/036
> > > +++ b/tests/qemu-iotests/036
> > > @@ -43,8 +43,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> > >  # This tests qcow2-specific low-level functionality
> > >  _supported_fmt qcow2
> > >  _supported_proto file
> > > -# Only qcow2v3 and later supports feature bits
> > > -_unsupported_imgopts 'compat=3D0.10'
> > > +# Only qcow2v3 and later supports feature bits;
> > > +# qcow2.py does not support external data files
> >=20
> > Minor nitpick, maybe tag this with TODO or so. No need to do now.
>=20
> Hm, well, and the same applies here.  (Just not a very important test.)
Same here, in theory external data file is a feature, and it could
'interact' with other features, but most likely you are right here as well.

>=20
> [...]
>=20
> > > diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
> > > index 4e03ead7b1..a066eec605 100755
> > > --- a/tests/qemu-iotests/046
> > > +++ b/tests/qemu-iotests/046
> > > @@ -38,6 +38,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> > > =20
> > >  _supported_fmt qcow2
> > >  _supported_proto file
> > > +# data_file does not support compressed clusters
> > > +_unsupported_imgopts data_file
> >=20
> > This is a very nice test, which doesn't seem to  use compressed
> > clusters that much. I think it should be split as well.
> > No need to do this now of course, but maybe mark with TODO to=20
> > avoid loosing that info.
>=20
> The other problem is that blkdebug doesn=E2=80=99t work so well with exte=
rnal
> data files, so basically this whole test doesn=E2=80=99t work.
Yes, I see now that the test uses the blkdebug.

>=20
> [...]
>=20
> > > diff --git a/tests/qemu-iotests/048 b/tests/qemu-iotests/048
> > > index a8feb76184..2af6b74b41 100755
> > > --- a/tests/qemu-iotests/048
> > > +++ b/tests/qemu-iotests/048
> > > @@ -49,6 +49,8 @@ _compare()
> > >  _supported_fmt raw qcow2 qed luks
> > >  _supported_proto file
> > >  _supported_os Linux
> > > +# Using 'cp' is incompatible with external data files
> > > +_unsupported_imgopts data_file
> >=20
> > You could compare the external files instead in theory *I think*.
> > Another item on some TODO list I guess.
>=20
> This is a test of qemu-img compare, not of the image format.  So it
> doesn=E2=80=99t make much sense to me to compare the external files, and =
also it
> should be completely sufficient to run this test only without external
> data files.
Yes but on the other hand, its is kind of nice to test that it can compare =
correctly
two qcow2 files which have external data files attached.


>=20
> [...]
>=20
> > > diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
> > > index 9cd1d60d45..0053bad46a 100755
> > > --- a/tests/qemu-iotests/051
> > > +++ b/tests/qemu-iotests/051
> > > @@ -39,8 +39,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> > >  _supported_fmt qcow2
> > >  _supported_proto file
> > >  # A compat=3D0.10 image is created in this test which does not suppo=
rt anything
> > > -# other than refcount_bits=3D16
> >=20
> > Here also the compat=3D0.10 image is only a small part of the test,
> > although it seems to get used later in the rest of the test,
> >=20
> > so the test I think should be split so that rest of the test could run =
in all
> > configurations.=20
>=20
> This too isn=E2=80=99t an image format test (specifically, there=E2=80=99=
s no I/O but
> for the snapshotting test, which mostly uses a different image anyway),
> so I don=E2=80=99t think it=E2=80=99s necessary to allow this test for da=
ta_file.
Same here, I agree but still what if there is some interaction between back=
ing
file and data file?

>=20
> [...]
>=20
> > > diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
> > > index 92243c2edd..8ad0d7a904 100755
> > > --- a/tests/qemu-iotests/060
> > > +++ b/tests/qemu-iotests/060
> > > @@ -48,8 +48,10 @@ _filter_io_error()
> > >  _supported_fmt qcow2
> > >  _supported_proto file
> > >  _supported_os Linux
> > > -# These tests only work for compat=3D1.1 images with refcount_bits=
=3D16
> > > -_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D\([^1]\|.\([^6=
]\|$\)\)'
> > > +# These tests only work for compat=3D1.1 images without an external
> > > +# data file with refcount_bits=3D16
> >=20
> > Yea, with all hardcoded offsets, that isn't going to work.
>=20
> This isn=E2=80=99t about hardcoded offsets, it=E2=80=99s about the fact t=
hat the test
> references data cluster that are part of the qcow2 file (i.e., not in an
> external file).
That true too! In theory, the test could have asked the qcow2 image
where the data clusters are instead.

I think that in the long term, it would add a value to have some kind
of qcow2 specific test framework that would allow to query the qcow2 conten=
ts,
and manipulate it in the out of spec ways. Not now of course.



>=20
> [...]
>=20
> > > diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
> > > index ac0d2a9a3b..68e52a6402 100755
> > > --- a/tests/qemu-iotests/062
> > > +++ b/tests/qemu-iotests/062
> > > @@ -41,7 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> > >  _supported_fmt qcow2
> > >  _supported_proto generic
> > >  # We need zero clusters and snapshots
> > > -_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D1[^0-9]'
> > > +_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D1[^0-9]' data_=
file
> > > =20
> > >  IMG_SIZE=3D64M
> > > =20
> >=20
> > Maybe split that test as well in the long run.
>=20
> How would that be possible, though?  There is only a single test case her=
e.
Oops, I probably meant test 061, which might have a value to be split in=20
two tests, one that upgrades/downgrades the version (and thus indeed can't =
use
any compat=3D1.1 features) and other test that works only on changing featu=
res of compat=3D1.1
images, where it could have used both different refcount bit settings and e=
xternal data file.
(I suppose you can't take a regular qcow2 image and move its data clusters =
to an external data file, but still)


>=20
> > > diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
> > > index 00eb80d89e..0fff3e3a52 100755
> > > --- a/tests/qemu-iotests/066
> > > +++ b/tests/qemu-iotests/066
> > > @@ -40,7 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> > >  _supported_fmt qcow2
> > >  _supported_proto generic
> > >  # We need zero clusters and snapshots
> > > -_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D1[^0-9]'
> > > +_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D1[^0-9]' data_=
file
> >=20
> > Yet again, one small test case forcing the whole test to be skipped.
> > This should be split as well eventually.
>=20
> This I agree with.
>=20
> > > diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
> > > index 926c79b37c..3bc6e719eb 100755
> > > --- a/tests/qemu-iotests/067
> > > +++ b/tests/qemu-iotests/067
> > > @@ -32,8 +32,10 @@ status=3D1=09# failure is the default!
> > > =20
> > >  _supported_fmt qcow2
> > >  _supported_proto file
> > > -# Because anything other than 16 would change the output of query-bl=
ock
> > > -_unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
> > > +# Because anything other than 16 would change the output of query-bl=
ock,
> > > +# and external data files would change the output of
> > > +# query-named-block-ndoes
> > > +_unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)' data_f=
ile
> >=20
> > OK. There probably is a way to filter that, but I don't know if this is=
 worth it.
>=20
> Not really, because this again isn=E2=80=99t really a test of the image f=
ormat.
I think I agree on this test now. Still in theory it adds/removes lot of bl=
ock devices,
thus the qcow2 driver now has to open/close the external file, which might =
reveal some bugs.

>=20
> [...]
>=20
> > > diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
> > > index e684b1b780..903dc9c9ab 100755
> > > --- a/tests/qemu-iotests/073
> > > +++ b/tests/qemu-iotests/073
> > > @@ -39,6 +39,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> > >  _supported_fmt qcow2
> > >  _supported_proto generic
> > >  _unsupported_proto vxhs
> > > +# External data files do not support compressed clusters
> > > +_unsupported_imgopts data_file
> >=20
> > This test should be split as well eventually.
>=20
> Hm, yes.  I don=E2=80=99t know if it can be fully split.  I think what wo=
uld
> work is a trimmed down copy just for external data files, but, well...
That what I was thinking as well...

>=20
> [...]
>=20
> > > diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
> > > index b1ecafb41e..a3d13c414e 100755
> > > --- a/tests/qemu-iotests/080
> > > +++ b/tests/qemu-iotests/080
> > > @@ -40,9 +40,10 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> > >  _supported_fmt qcow2
> > >  _supported_proto file
> > >  _supported_os Linux
> > > -# - Internal snapshots are (currently) impossible with refcount_bits=
=3D1
> > > +# - Internal snapshots are (currently) impossible with refcount_bits=
=3D1,
> > > +#   and generally impossible with external data files
> > >  # - This is generally a test for compat=3D1.1 images
> > > -_unsupported_imgopts 'refcount_bits=3D1[^0-9]' 'compat=3D0.10'
> > > +_unsupported_imgopts 'refcount_bits=3D1[^0-9]' data_file 'compat=3D0=
.10'
> >=20
> > I would more say that the test is too hardcoded for more that exact
> > settings it expects. It is all right in this case IMHO.
> > ACK.
>=20
> I suppose we=E2=80=99d want a different test for data file validation, if
> anything, but I don=E2=80=99t think there is anything to validate there..=
.
>=20
Well the external data file as I understand is an extension on its own,
so in theory if you put some garbage there, it could reveal some bugs.
What if for example data file points to the same qcow2 file?
(or points through a symlink?) or it is NULL, or whatever.
The test for example tests for 'Invalid backing file size'
I guess that is what you mean here.

> [...]
>=20
> > > diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
> > > index 700068b328..1e29d96b3d 100755
> > > --- a/tests/qemu-iotests/098
> > > +++ b/tests/qemu-iotests/098
> > > @@ -40,8 +40,10 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> > > =20
> > >  _supported_fmt qcow2
> > >  _supported_proto file
> > > -# The code path we want to test here only works for compat=3D1.1 ima=
ges
> > > -_unsupported_imgopts 'compat=3D0.10'
> > > +# The code path we want to test here only works for compat=3D1.1 ima=
ges;
> > > +# blkdebug can only inject errors on bs->file, so external data file=
s
> > > +# do not work with this test
> > > +_unsupported_imgopts 'compat=3D0.10' data_file
> >=20
> > ACK, but this is already 3rd test we loose. Maybe add to a TODO to exte=
nd blkdebug
> > to access data file as well.
>=20
> That won=E2=80=99t work, though.  The problem is that in the block graph,
> blkdebug just exists between the format and the file node.  You=E2=80=99d=
 need a
> second instance above the external data file node, but then those
> instances wouldn=E2=80=99t share data, and qcow2 only issues blkdebug eve=
nts to
> the file node.
>=20
> One could make qcow2 duplicate all events to the data file, but then you
> still wouldn=E2=80=99t share the same state in both instances.
>=20
> In all, it would just be a mess.

I agree. That is more or less what I suspected.
In theory you could make single blkdebug instance have 2 inputs and 2 outpu=
ts
so it could filter both IO channels. Interesting how we deal with backing f=
iles,
since even without data file the qcow2 driver accesses two block devices, a=
nd
with data file it can access 3.




>=20
> > > diff --git a/tests/qemu-iotests/099 b/tests/qemu-iotests/099
> > > index b383c11e6a..65e8e92572 100755
> > > --- a/tests/qemu-iotests/099
> > > +++ b/tests/qemu-iotests/099
> > > @@ -46,8 +46,9 @@ _supported_fmt qcow qcow2 qed vdi vhdx vmdk vpc
> > >  _supported_proto file
> > >  _supported_os Linux
> > >  _require_drivers blkdebug blkverify
> > > +# data_file would change the json:{} filenames
> >=20
> > True but maybe still worth it to support the case?
>=20
> I don=E2=80=99t think so, because this is specifically a test to check th=
ose
> filenames.
All right!
>=20
> [...]
>=20
> > > diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
> > > index 554b9de054..8c1ebe0443 100755
> > > --- a/tests/qemu-iotests/103
> > > +++ b/tests/qemu-iotests/103
> > > @@ -38,8 +38,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> > > =20
> > >  _supported_fmt qcow2
> > >  _supported_proto file nfs
> > > -# Internal snapshots are (currently) impossible with refcount_bits=
=3D1
> > > -_unsupported_imgopts 'refcount_bits=3D1[^0-9]'
> > > +# Internal snapshots are (currently) impossible with refcount_bits=
=3D1,
> > > +# and generally impossible with external data files
> > > +_unsupported_imgopts 'refcount_bits=3D1[^0-9]' data_file
> >=20
> > ACK.
> > The test also only needs the snapshot in a part of it, so maybe split a=
s well
> > later.
>=20
> But this test too is just an interface test, so I don=E2=80=99t quite see=
 the need.
All right.

>=20
> [...]
>=20
> > > diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
> > > index f90a744fc0..26104fff6c 100755
> > > --- a/tests/qemu-iotests/114
> > > +++ b/tests/qemu-iotests/114
> > > @@ -39,6 +39,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> > >  _supported_fmt qcow2
> > >  _supported_proto generic
> > >  _unsupported_proto vxhs
> > > +# qcow2.py does not work too well with external data files
> >=20
> > ACK, but should be fixed later.
>=20
> Probably, but I don=E2=80=99t think this test would benefit much from it.
> (Because it isn=E2=80=99t too important to be able to run this with an ex=
ternal
> data file)
Looking again, I agree, but like I mentioned earlier, it might be worth
it to have test that fuzzes the backing file location (if we don't have one=
 that is).

>=20
> [...]
>=20
> > > diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
> > > index 66ae9d5e78..7b0bc62a74 100755
> > > --- a/tests/qemu-iotests/138
> > > +++ b/tests/qemu-iotests/138
> > > @@ -40,6 +40,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> > >  _supported_fmt qcow2
> > >  _supported_proto file
> > >  _supported_os Linux
> > > +# These refcount calculations do not work with external data files
> > > +_unsupported_imgopts data_file
> >=20
> > Thats why I don't like the hardcoded tests that much.
>=20
> Good point.  I was wondering what the problem was here because I was
> sure it didn=E2=80=99t have anything to do with something hard-coded, and=
 it
> doesn=E2=80=99t.
>=20
> The actual reason is simply that there is no refcounting for external
> data files.  I=E2=80=99ll fix the comment.
Thanks!

>=20
> > > diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
> > > index 3f27db71f2..5559df63a5 100755
> > > --- a/tests/qemu-iotests/156
> > > +++ b/tests/qemu-iotests/156
> > > @@ -51,6 +51,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> > >  _supported_fmt qcow2 qed
> > >  _supported_proto generic
> > >  _unsupported_proto vxhs
> > > +# Copying files around with cp does not work with external data file=
s
> > > +_unsupported_imgopts data_file
> >=20
> > Another place to fix later I guess.
>=20
> I don=E2=80=99t know, this type of storage migration simply doesn=E2=80=
=99t work this
> way with external data files.
I am curios why? The test seems only to use external snapshots, so why it
would be different, other that copying the external files.

>=20
> Max
>=20

I want to note again, that I noted all the tests just in case,
most if not all of them probably indeed are best to be
blacklisted for external files.


Best regards,
=09Maxim Levitsky



