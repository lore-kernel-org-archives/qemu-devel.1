Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF78C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8ED20775
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMN3sW6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8ED20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7aO-0001zi-Kw
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jU7Zc-00010W-Vc
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jU7Zc-00005S-9K
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:41:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46654
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jU7Zb-00005E-Ps
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588246906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtah996KwPNEKNspzBsMiDGO49CMAIeJdfusJLjjEPw=;
 b=iMN3sW6GjiuYW9HkyQcsd7+4XLdbo/0g1WGFnM6IlGy70w/6ZsSHdwRMJnRwCeNg0kDPYt
 uWKuM7ZokQtp7yJoPYZnIN4BRzHGWPX/Q63EEjdq2Rytw4OvXRjf7+O48AfMh0ClBzneHP
 NWdRLLS7PWSLt0oNFt5+YNH6ZrZiR10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-UF86YpppNwCHQYTxT7kqYA-1; Thu, 30 Apr 2020 07:41:45 -0400
X-MC-Unique: UF86YpppNwCHQYTxT7kqYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4F75107ACCA;
 Thu, 30 Apr 2020 11:41:43 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 956A3396;
 Thu, 30 Apr 2020 11:41:42 +0000 (UTC)
Date: Thu, 30 Apr 2020 13:41:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 3/3] iotests: Backup with different source/target size
Message-ID: <20200430114141.GB6578@linux.fritz.box>
References: <20200429111539.42103-1-kwolf@redhat.com>
 <20200429111539.42103-4-kwolf@redhat.com>
 <c43b4e88-848c-4ffa-151d-beecbe2863a8@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <c43b4e88-848c-4ffa-151d-beecbe2863a8@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 29.04.2020 um 14:28 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 29.04.2020 14:15, Kevin Wolf wrote:
> > This tests that the backup jobs catches situations where the target nod=
e
> > has a different size than the source node. It must also forbid resize
> > operations when the job is already running.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   tests/qemu-iotests/055     | 60 ++++++++++++++++++++++++++++++++++++-=
-
> >   tests/qemu-iotests/055.out |  4 +--

One general remark and question that came up while I was running 055 a
lot and really got annonyed by the long time it takes:

TestDriveCompression is quite unconventional in that 055 is raw/qcow2
only per se, but some of the test cases always test qcow2 and vmdk. The
slow one is vmdk.

I found out that zero writes in vmdk are completely broken (I'll send
patches), but even after fixing this, it's still slow. I think this is
the combination of VMDK not having writeback metadata caching and
backup serving lots of tiny 64k zero writes.

Has anyone ever looked into making backup use more reasonable request
sizes for the background copy like mirror does?

> >   2 files changed, 60 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
> > index 82b9f5f47d..243d66a62e 100755
> > --- a/tests/qemu-iotests/055
> > +++ b/tests/qemu-iotests/055
> > @@ -48,8 +48,10 @@ class TestSingleDrive(iotests.QMPTestCase):
> >       def setUp(self):
> >           qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img,=
 str(image_len))
> > -        self.vm =3D iotests.VM().add_drive('blkdebug::' + test_img)
> > -        self.vm.add_drive(blockdev_target_img, interface=3D"none")
> > +        self.vm =3D iotests.VM()
> > +        self.vm.add_drive('blkdebug::' + test_img, 'node-name=3Dsource=
')
> > +        self.vm.add_drive(blockdev_target_img, 'node-name=3Dtarget',
> > +                          interface=3D"none")
> >           if iotests.qemu_default_machine =3D=3D 'pc':
> >               self.vm.add_drive(None, 'media=3Dcdrom', 'ide')
> >           self.vm.launch()
> > @@ -112,6 +114,60 @@ class TestSingleDrive(iotests.QMPTestCase):
> >       def test_pause_blockdev_backup(self):
> >           self.do_test_pause('blockdev-backup', 'drive1', blockdev_targ=
et_img)
> > +    def test_source_resize_blockdev_backup(self):
> > +        self.assert_no_active_block_jobs()
>=20
> this will never fire, as vm is created a moment before, I'd drop it.

This pattern exists all over the place in 055, but you're right, it's
kind of pointless.

> > +
> > +        def pre_finalize():
> > +            result =3D self.vm.qmp('block_resize', device=3D'drive0', =
size=3D65536)
> > +            self.assert_qmp(result, 'error/class', 'GenericError')
> > +
> > +            result =3D self.vm.qmp('block_resize', node_name=3D'source=
', size=3D65536)
> > +            self.assert_qmp(result, 'error/class', 'GenericError')
> > +
> > +        result =3D self.vm.qmp('blockdev-backup', job_id=3D'job0', dev=
ice=3D'drive0',
> > +                             target=3D'drive1', sync=3D'full', auto_fi=
nalize=3DFalse,
> > +                             auto_dismiss=3DFalse)
> > +        self.assert_qmp(result, 'return', {})
> > +
> > +        self.vm.run_job('job0', auto_finalize=3DFalse, pre_finalize=3D=
pre_finalize,
> > +                        use_log=3DFalse)
> > +
> > +    def test_target_resize_blockdev_backup(self):
> > +        self.assert_no_active_block_jobs()
> > +
> > +        def pre_finalize():
> > +            result =3D self.vm.qmp('block_resize', device=3D'drive1', =
size=3D65536)
> > +            self.assert_qmp(result, 'error/class', 'GenericError')
> > +
> > +            result =3D self.vm.qmp('block_resize', node_name=3D'target=
', size=3D65536)
> > +            self.assert_qmp(result, 'error/class', 'GenericError')
> > +
> > +        result =3D self.vm.qmp('blockdev-backup', job_id=3D'job0', dev=
ice=3D'drive0',
> > +                             target=3D'drive1', sync=3D'full', auto_fi=
nalize=3DFalse,
> > +                             auto_dismiss=3DFalse)
> > +        self.assert_qmp(result, 'return', {})
> > +
> > +        self.vm.run_job('job0', auto_finalize=3DFalse, pre_finalize=3D=
pre_finalize,
> > +                        use_log=3DFalse)
>=20
> these two functions are almost identical.. worth refactoring to be use co=
mmon helper?

Ok, I'll see what I can do.

Kevin


