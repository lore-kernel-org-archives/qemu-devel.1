Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E07BC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC96206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkUjFP4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC96206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42xI-0007Bc-Du
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:30:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j42wa-0006HP-Cg
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:29:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j42wZ-0003mT-1m
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:29:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44898
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j42wY-0003lg-Sp
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582032582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=louIaOHDbvh9EzTQgj7vvaxYt+wJwlQE0P6WfTsuq4k=;
 b=TkUjFP4sNnHOwqFjfDuJ82rkhHpqI3Ojqk79EDothSVOlNSLuqyC2tMQT5NmRB5PtQuVDE
 Fqg7he2Pphb0exn+WY2H5KLQ5Vxu40gJfk9alV/tKMtUYCMnVhjlS+5pzMiOB0m//e//8r
 PJz+vnX2KHjbqbbRbeZh8/mGez5dnO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-YP6wPajRMfqaYCeCDNk6Pw-1; Tue, 18 Feb 2020 08:29:40 -0500
X-MC-Unique: YP6wPajRMfqaYCeCDNk6Pw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AB76107B26F;
 Tue, 18 Feb 2020 13:29:39 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-181.ams2.redhat.com [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3AA81BC6D;
 Tue, 18 Feb 2020 13:29:37 +0000 (UTC)
Date: Tue, 18 Feb 2020 14:29:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v4 18/19] iotests: Add tests for invalid Quorum @replaces
Message-ID: <20200218132936.GD6157@linux.fritz.box>
References: <20200218103454.296704-1-mreitz@redhat.com>
 <20200218103454.296704-19-mreitz@redhat.com>
 <20200218123827.GC6157@linux.fritz.box>
 <49c02a45-dc13-078a-fb16-4ef57feb04e1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <49c02a45-dc13-078a-fb16-4ef57feb04e1@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 18.02.2020 um 13:49 hat Max Reitz geschrieben:
> On 18.02.20 13:38, Kevin Wolf wrote:
> > Am 18.02.2020 um 11:34 hat Max Reitz geschrieben:
> >> Add two tests to see that you cannot replace a Quorum child with the
> >> mirror job while the child is in use by a different parent.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> ---
> >>  tests/qemu-iotests/041     | 70 +++++++++++++++++++++++++++++++++++++=
-
> >>  tests/qemu-iotests/041.out |  4 +--
> >>  2 files changed, 71 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> >> index 1d9e64ff6d..53c8671969 100755
> >> --- a/tests/qemu-iotests/041
> >> +++ b/tests/qemu-iotests/041
> >> @@ -20,6 +20,7 @@
> >> =20
> >>  import time
> >>  import os
> >> +import re
> >>  import iotests
> >>  from iotests import qemu_img, qemu_io
> >> =20
> >> @@ -34,6 +35,8 @@ quorum_img3 =3D os.path.join(iotests.test_dir, 'quor=
um3.img')
> >>  quorum_repair_img =3D os.path.join(iotests.test_dir, 'quorum_repair.i=
mg')
> >>  quorum_snapshot_file =3D os.path.join(iotests.test_dir, 'quorum_snaps=
hot.img')
> >> =20
> >> +nbd_sock_path =3D os.path.join(iotests.test_dir, 'nbd.sock')
> >> +
> >>  class TestSingleDrive(iotests.QMPTestCase):
> >>      image_len =3D 1 * 1024 * 1024 # MB
> >>      qmp_cmd =3D 'drive-mirror'
> >> @@ -892,7 +895,8 @@ class TestRepairQuorum(iotests.QMPTestCase):
> >> =20
> >>      def tearDown(self):
> >>          self.vm.shutdown()
> >> -        for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_f=
ile ]:
> >> +        for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_f=
ile,
> >> +                                 nbd_sock_path ]:
> >>              # Do a try/except because the test may have deleted some =
images
> >>              try:
> >>                  os.remove(i)
> >> @@ -1032,6 +1036,70 @@ class TestRepairQuorum(iotests.QMPTestCase):
> >>          self.assert_has_block_node("repair0", quorum_repair_img)
> >>          self.vm.assert_block_path('quorum0', '/children.1', 'repair0'=
)
> >> =20
> >> +    def test_with_other_parent(self):
> >> +        """
> >> +        Check that we cannot replace a Quorum child when it has other
> >> +        parents.
> >> +        """
> >> +        result =3D self.vm.qmp('nbd-server-start',
> >> +                             addr=3D{
> >> +                                 'type': 'unix',
> >> +                                 'data': {'path': nbd_sock_path}
> >> +                             })
> >> +        self.assert_qmp(result, 'return', {})
> >> +
> >> +        result =3D self.vm.qmp('nbd-server-add', device=3D'img1')
> >> +        self.assert_qmp(result, 'return', {})
> >> +
> >> +        result =3D self.vm.qmp('drive-mirror', job_id=3D'mirror', dev=
ice=3D'quorum0',
> >> +                             sync=3D'full', node_name=3D'repair0', re=
places=3D'img1',
> >> +                             target=3Dquorum_repair_img, format=3Diot=
ests.imgfmt)
> >> +        self.assert_qmp(result, 'error/desc',
> >> +                        "Cannot replace 'img1' by a node mirrored fro=
m "
> >> +                        "'quorum0', because it cannot be guaranteed t=
hat doing "
> >> +                        "so would not lead to an abrupt change of vis=
ible data")
> >> +
> >> +    def test_with_other_parents_after_mirror_start(self):
> >> +        """
> >> +        The same as test_with_other_parent(), but add the NBD server
> >> +        only when the mirror job is already running.
> >> +        """
> >> +        result =3D self.vm.qmp('nbd-server-start',
> >> +                             addr=3D{
> >> +                                 'type': 'unix',
> >> +                                 'data': {'path': nbd_sock_path}
> >> +                             })
> >> +        self.assert_qmp(result, 'return', {})
> >> +
> >> +        result =3D self.vm.qmp('drive-mirror', job_id=3D'mirror', dev=
ice=3D'quorum0',
> >> +                             sync=3D'full', node_name=3D'repair0', re=
places=3D'img1',
> >> +                             target=3Dquorum_repair_img, format=3Diot=
ests.imgfmt)
> >> +        self.assert_qmp(result, 'return', {})
> >> +
> >> +        result =3D self.vm.qmp('nbd-server-add', device=3D'img1')
> >> +        self.assert_qmp(result, 'return', {})
> >> +
> >> +        # The full error message goes to stderr, we will check it lat=
er
> >> +        self.complete_and_wait('mirror',
> >> +                               completion_error=3D'Operation not perm=
itted')
> >> +
> >> +        # Should not have been replaced
> >> +        self.vm.assert_block_path('quorum0', '/children.1', 'img1')
> >> +
> >> +        # Check the full error message now
> >> +        self.vm.shutdown()
> >> +        log =3D self.vm.get_log()
> >> +        log =3D re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
> >> +        log =3D re.sub(r'^Formatting.*\n', '', log)
> >> +        log =3D re.sub(r'\n\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
> >> +        log =3D re.sub(r'^qemu-system-[^:]*: ', '', log)
> >=20
> > I would have applied the series, but:
> >=20
> > +.........................F............................................=
........................
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +FAIL: test_with_other_parents_after_mirror_start (__main__.TestRepairQ=
uorum)
> > +----------------------------------------------------------------------
> > +Traceback (most recent call last):
> > +  File "041", line 1099, in test_with_other_parents_after_mirror_start
> > +    "it can no longer be guaranteed that doing so would " +
> > +AssertionError: "qemu: Can no longer replace 'img1' by 're[107 chars]d=
ata" !=3D "Can no longer replace 'img1' by 'repair0'[101 chars]data"
> > +- qemu: Can no longer replace 'img1' by 'repair0', because it can no l=
onger be guaranteed that doing so would not lead to an abrupt change of vis=
ible data
> > +? ------
> > ++ Can no longer replace 'img1' by 'repair0', because it can no longer =
be guaranteed that doing so would not lead to an abrupt change of visible d=
ata
> > +
> > +
> >=20
> > If you agree, I can just change this line while applying into:
> >=20
> >     log =3D re.sub(r'^qemu[^:]*: ', '', log)
>=20
> Sure, thanks!  I just hope noone uses the QEMU environment variable to
> point to something that isn=E2=80=99t prefixed by =E2=80=9Cqemu=E2=80=9D.=
..

Ok, I'll use this instead:

+        log =3D re.sub(r'^%s[^:]*: ' % os.path.basename(iotests.qemu_prog)=
,
+                     '', log)

Kevin

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJeS+bAAAoJEH8JsnLIjy/WyvYQAIsxwBNRFlaUklkyRgvIQrdB
LWPk33XzfgkuNy1NPeVbp/B/T/c/k3PEG3lmxPEvj+yqWY/B1E15TDz5ahNwFI1j
wiSFFrVUTZYwOxF8Ep30Jzj+tTApMCLQ4tl7bgofT3KTo05IQ20Zqi6WtaqrwaHv
DdPwEpZsUjLBHikFnfRCjpI9b8o1sfOvjnB5emiiDdrYR578yUIOmXELMj93l+BH
2M4qiYfZ8juZtxcIeB/U8v0mV3hOLvAeW7ne9D+0OQroba7A6BvUCjgm3lCpwABX
pAj0mrBas0qRCPl1RCIitRBfaQ2bi+E5sqY3T2gOoDwHwefmyAVyoqFupxUScV9W
A+LQUi4rSSd1LX5cuk6Q+AogBbW8SaojRm/KkEwW5u4wxDEzcA4NVMMuX4bFtxFR
soZkdGJG4FpOJ1vas6pS6drZM4Gi2p0E/yjbrbXu2087/t2NNk4qbmnKEghLGJ3H
nwiFlNFwCyuK2jMknhWKCSzCnCeJAuGXc1GCkRG6wPFjo4D/HctZim53p/Qr+21y
RrxSDpdBVJtoEayW7l+FBBLJc3u6jdEYBIZb/TkXmUrNoZSadbEgBoMEz2ICX74P
omeMXEeINT9oK2BWlm3BzCgcFum6xrMtF7izQgBArjBgq0AM7jrBGKcy0Ae2ld+e
+2cks2j5IT2B4dTuedB0
=Cxwr
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--


