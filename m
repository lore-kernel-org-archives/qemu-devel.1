Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51F1C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A14E7206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMvWw5yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14E7206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSdf-0005Be-Q7
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iXSZf-0001NF-DD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:11:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iXSZb-0008Qf-Lu
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:11:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31842
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iXSZb-0008Pw-I8
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574266278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ax1R7Ve30qk8yn7kg/hRP8Sxub9HM+fgnKnuaP24JDU=;
 b=WMvWw5yuTvDLXUsmLzLu/NmWVWIB1vZ373wmDTa2oACMfGvL5iTTCfvNkhjN9Lva5goFvN
 H+bGctkR2DeCN0U/I9vAYsHkb8RE9yQdB0XyFr3pfhLp0Za8H8aspBFDQ2E5/o0Aj2rak9
 hxu6Fm3btlVg7NSgBkgp5y/hKx/jQQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-V_Q4fACxO5eIhuYA_Dfqug-1; Wed, 20 Nov 2019 11:11:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF67018B5FA2;
 Wed, 20 Nov 2019 16:11:12 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37DE610493BD;
 Wed, 20 Nov 2019 16:11:08 +0000 (UTC)
Date: Wed, 20 Nov 2019 17:11:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 6/6] iotests: Test committing to short backing file
Message-ID: <20191120161106.GE5779@linux.fritz.box>
References: <20191120140319.1505-1-kwolf@redhat.com>
 <20191120140319.1505-7-kwolf@redhat.com>
 <b5f3fb13-7467-d87e-07db-45bd014c6464@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <b5f3fb13-7467-d87e-07db-45bd014c6464@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: V_Q4fACxO5eIhuYA_Dfqug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.11.2019 um 16:41 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 20.11.2019 17:03, Kevin Wolf wrote:
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   tests/qemu-iotests/274        | 131 +++++++++++++++++++++++++++++
> >   tests/qemu-iotests/274.out    | 150 +++++++++++++++++++++++++++++++++=
+
> >   tests/qemu-iotests/group      |   1 +
> >   tests/qemu-iotests/iotests.py |   2 +-
> >   4 files changed, 283 insertions(+), 1 deletion(-)
> >   create mode 100755 tests/qemu-iotests/274
> >   create mode 100644 tests/qemu-iotests/274.out
> >=20
> > diff --git a/tests/qemu-iotests/274 b/tests/qemu-iotests/274
> > new file mode 100755
> > index 0000000000..f3b71e2859
> > --- /dev/null
> > +++ b/tests/qemu-iotests/274
> > @@ -0,0 +1,131 @@
> > +#!/usr/bin/env python
> > +#
> > +# Copyright (C) 2019 Red Hat, Inc.
> > +#
> > +# This program is free software; you can redistribute it and/or modify
> > +# it under the terms of the GNU General Public License as published by
> > +# the Free Software Foundation; either version 2 of the License, or
> > +# (at your option) any later version.
> > +#
> > +# This program is distributed in the hope that it will be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program.  If not, see <http://www.gnu.org/licenses/>=
.
> > +#
> > +# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
> > +#
> > +# Some tests for short backing files and short overlays
> > +
> > +import iotests
> > +import os
> > +
> > +iotests.verify_image_format(supported_fmts=3D['qcow2'])
> > +iotests.verify_platform(['linux'])
> > +
> > +size_short =3D 1 * 1024 * 1024
> > +size_long =3D 2 * 1024 * 1024
> > +size_diff =3D size_long - size_short
> > +
> > +def create_chain():
> > +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, base,
> > +                         str(size_long))
> > +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', base, m=
id,
> > +                         str(size_short))
> > +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', mid, to=
p,
> > +                         str(size_long))
> > +
> > +    iotests.qemu_io_log('-c', 'write -P 1 0 %d' % size_long, base)
> > +
> > +def create_vm():
> > +    vm =3D iotests.VM()
> > +    vm.add_blockdev('file,filename=3D%s,node-name=3Dbase-file' % (base=
))
> > +    vm.add_blockdev('%s,file=3Dbase-file,node-name=3Dbase' % (iotests.=
imgfmt))
> > +    vm.add_blockdev('file,filename=3D%s,node-name=3Dmid-file' % (mid))
> > +    vm.add_blockdev('%s,file=3Dmid-file,node-name=3Dmid,backing=3Dbase=
' % (iotests.imgfmt))
> > +    vm.add_drive(top, 'backing=3Dmid,node-name=3Dtop')
> > +    return vm
> > +
> > +with iotests.FilePath('base') as base, \
> > +     iotests.FilePath('mid') as mid, \
> > +     iotests.FilePath('top') as top:
> > +
> > +    iotests.log('=3D=3D Commit tests =3D=3D')
> > +
> > +    create_chain()
> > +
> > +    iotests.log('=3D=3D=3D Check visible data =3D=3D=3D')
> > +
> > +    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, top)
> > +    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_di=
ff), top)
> > +
> > +    iotests.log('=3D=3D=3D Checking allocation status =3D=3D=3D')
> > +
> > +    iotests.qemu_io_log('-c', 'alloc 0 %d' % size_short,
> > +                        '-c', 'alloc %d %d' % (size_short, size_diff),
> > +                        base)
> > +
> > +    iotests.qemu_io_log('-c', 'alloc 0 %d' % size_short,
> > +                        '-c', 'alloc %d %d' % (size_short, size_diff),
> > +                        mid)
> > +
> > +    iotests.qemu_io_log('-c', 'alloc 0 %d' % size_short,
> > +                        '-c', 'alloc %d %d' % (size_short, size_diff),
> > +                        top)
> > +
> > +    iotests.log('=3D=3D=3D Checking map =3D=3D=3D')
> > +
> > +    iotests.qemu_img_log('map', '--output=3Djson', base)
> > +    iotests.qemu_img_log('map', '--output=3Dhuman', base)
> > +    iotests.qemu_img_log('map', '--output=3Djson', mid)
> > +    iotests.qemu_img_log('map', '--output=3Dhuman', mid)
> > +    iotests.qemu_img_log('map', '--output=3Djson', top)
> > +    iotests.qemu_img_log('map', '--output=3Dhuman', top)
> > +
> > +    iotests.log('=3D=3D=3D Testing qemu-img commit (top -> mid) =3D=3D=
=3D')
> > +
> > +    iotests.qemu_img_log('commit', top)
> > +    iotests.img_info_log(mid)
> > +    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
> > +    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_di=
ff), mid)
> > +
> > +    iotests.log('=3D=3D=3D Testing HMP commit (top -> mid) =3D=3D=3D')
> > +
> > +    create_chain()
> > +    with create_vm() as vm:
> > +        vm.launch()
> > +        vm.qmp_log('human-monitor-command', command_line=3D'commit dri=
ve0')
> > +
> > +    iotests.img_info_log(mid)
> > +    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
> > +    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_di=
ff), mid)
> > +
> > +    iotests.log('=3D=3D=3D Testing QMP active commit (top -> mid) =3D=
=3D=3D')
> > +
> > +    create_chain()
> > +    with create_vm() as vm:
> > +        vm.launch()
> > +        vm.qmp_log('block-commit', device=3D'top', base_node=3D'mid',
> > +                   job_id=3D'job0', auto_dismiss=3DFalse)
> > +        vm.run_job('job0', wait=3D5)
> > +
> > +    iotests.img_info_log(mid)
> > +    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
> > +    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_di=
ff), mid)
> > +
> > +
> > +    iotests.log('=3D=3D Resize tests =3D=3D')
> > +
> > +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, base, '6G')
> > +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', base, t=
op, '1G')
> > +    iotests.qemu_io_log('-c', 'write -P 1 3G 64k', base)
> > +    iotests.qemu_io_log('-c', 'write -P 2 5G 64k', base)
> > +
> > +    # After this, 0 to 6 GB should be allocated/zeroed
> > +    # 6 GB to 8 BG should be unallocated
>=20
> Hmm, the problem is that the following qemu-img map can't show it, as it =
merges
> 1G..6G and 6G..8G into one chunk..

Hm, true, because it's more about the content of the blocks than about
the allocation status. I'll add a qemu-io 'map' call, which display the
actual allocation status:

1 GiB (0x40000000) bytes not allocated at offset 0 bytes (0x0)
5 GiB (0x140000000) bytes     allocated at offset 1 GiB (0x40000000)
2 GiB (0x80000000) bytes not allocated at offset 6 GiB (0x180000000)

> > +    iotests.qemu_img_log('resize', '-f', iotests.imgfmt, top, '8G')
> > +    iotests.qemu_io_log('-c', 'read -P 0 3G 64k', top)
> > +    iotests.qemu_io_log('-c', 'read -P 0 5G 64k', top)
> > +    iotests.qemu_img_log('map', '--output=3Djson', top)
> > diff --git a/tests/qemu-iotests/274.out b/tests/qemu-iotests/274.out
> > new file mode 100644
> > index 0000000000..def0ac7d27
> > --- /dev/null
> > +++ b/tests/qemu-iotests/274.out
> > @@ -0,0 +1,150 @@
> > +=3D=3D Commit tests =3D=3D
> > +Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D2097152 cluster_siz=
e=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> > +
> > +Formatting 'TEST_DIR/PID-mid', fmt=3Dqcow2 size=3D1048576 backing_file=
=3DTEST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bit=
s=3D16
> > +
> > +Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D2097152 backing_file=
=3DTEST_DIR/PID-mid cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=
=3D16
> > +
> > +wrote 2097152/2097152 bytes at offset 0
> > +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +
> > +=3D=3D=3D Check visible data =3D=3D=3D
> > +read 1048576/1048576 bytes at offset 0
> > +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +
> > +read 1048576/1048576 bytes at offset 1048576
> > +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +
> > +=3D=3D=3D Checking allocation status =3D=3D=3D
> > +1048576/1048576 bytes allocated at offset 0 bytes
> > +1048576/1048576 bytes allocated at offset 1 MiB
> > +
> > +0/1048576 bytes allocated at offset 0 bytes
> > +0/0 bytes allocated at offset 1 MiB
> > +
> > +0/1048576 bytes allocated at offset 0 bytes
> > +0/1048576 bytes allocated at offset 1 MiB
> > +
> > +=3D=3D=3D Checking map =3D=3D=3D
> > +[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": t=
rue, "offset": 327680}]
> > +
> > +Offset          Length          Mapped to       File
> > +0               0x200000        0x50000         TEST_DIR/PID-base
> > +
> > +[{ "start": 0, "length": 1048576, "depth": 1, "zero": false, "data": t=
rue, "offset": 327680}]
> > +
> > +Offset          Length          Mapped to       File
> > +0               0x100000        0x50000         TEST_DIR/PID-base
> > +
> > +[{ "start": 0, "length": 1048576, "depth": 2, "zero": false, "data": t=
rue, "offset": 327680},
> > +{ "start": 1048576, "length": 1048576, "depth": 0, "zero": true, "data=
": false}]
>=20
> I think depth of second chunk should be 1, not 0.. But this is for
> another fixing series.

The part from 1 GB to 6 GB should be 0 without any question, this is
where we wrote zeros into the overlay.

The part from 7 GB to 8 GB is a bit more open to interpretation because
this is unallocated in the overlay and reads zeros because the backing
file is shorter. I think 0 makes sense, but it's debatable.

Kevin


