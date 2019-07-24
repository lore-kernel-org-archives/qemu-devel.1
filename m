Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4C2C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 17:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7122C21911
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 17:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7122C21911
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqKpO-0004zO-Ez
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 13:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49380)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hqKov-0003S3-K5
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 13:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hqKot-0004a8-5m
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 13:12:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42692)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hqKoo-00045r-BR; Wed, 24 Jul 2019 13:12:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 608B189ACB;
 Wed, 24 Jul 2019 17:12:42 +0000 (UTC)
Received: from localhost (ovpn-204-115.brq.redhat.com [10.40.204.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE4FF60605;
 Wed, 24 Jul 2019 17:12:41 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 24 Jul 2019 19:12:28 +0200
Message-Id: <20190724171239.8764-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 24 Jul 2019 17:12:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 00/11] block: Fix some things about
 bdrv_has_zero_init()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

See the previous cover letter for the reason for patches 6 through 9:
https://lists.nongnu.org/archive/html/qemu-block/2019-07/msg00563.html

But no only some bdrv_has_zero_init() implementations are wrong, some
callers also use it the wrong way.

First, qemu-img and mirror use it for pre-existing images, where it
doesn=E2=80=99t have any meaning.  Both should consider pre-existing imag=
es to
always be non-zero and not look at bdrv_has-zero_init() (patches 1, 2,
and the tests in 10 and 11).

Second, vhdx and parallels call bdrv_has_zero_init() when they do not
really care about an image=E2=80=99s post-create state but only about wha=
t
happens when you grow an image.  That is a bit ugly, and also overly
safe when growing preallocated images without preallocating the new
areas.  So this series adds a new function bdrv_has_zero_init_truncate()
that is more suited to vhdx's and parallel's needs (patches 3 through
5).


v2:
- Simplified preallocation checks in qcow2 and vhdx [Kevin]
- Added patches 1 =E2=80=93 5, 10, 11


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/11:[down] 'qemu-img: Fix bdrv_has_zero_init() use in convert'
002/11:[down] 'mirror: Fix bdrv_has_zero_init() use'
003/11:[down] 'block: Add bdrv_has_zero_init_truncate()'
004/11:[down] 'block: Implement .bdrv_has_zero_init_truncate()'
005/11:[down] 'block: Use bdrv_has_zero_init_truncate()'
006/11:[0077] [FC] 'qcow2: Fix .bdrv_has_zero_init()'
007/11:[----] [--] 'vdi: Fix .bdrv_has_zero_init()'
008/11:[0021] [FC] 'vhdx: Fix .bdrv_has_zero_init()'
009/11:[----] [--] 'iotests: Convert to preallocated encrypted qcow2'
010/11:[down] 'iotests: Test convert -n to pre-filled image'
011/11:[down] 'iotests: Full mirror to existing non-zero image'


Max Reitz (11):
  qemu-img: Fix bdrv_has_zero_init() use in convert
  mirror: Fix bdrv_has_zero_init() use
  block: Add bdrv_has_zero_init_truncate()
  block: Implement .bdrv_has_zero_init_truncate()
  block: Use bdrv_has_zero_init_truncate()
  qcow2: Fix .bdrv_has_zero_init()
  vdi: Fix .bdrv_has_zero_init()
  vhdx: Fix .bdrv_has_zero_init()
  iotests: Convert to preallocated encrypted qcow2
  iotests: Test convert -n to pre-filled image
  iotests: Full mirror to existing non-zero image

 include/block/block.h       |  1 +
 include/block/block_int.h   |  9 ++++++
 block.c                     | 21 +++++++++++++
 block/file-posix.c          |  1 +
 block/file-win32.c          |  1 +
 block/gluster.c             |  4 +++
 block/mirror.c              | 11 +++++--
 block/nfs.c                 |  1 +
 block/parallels.c           |  2 +-
 block/qcow2.c               | 30 +++++++++++++++++-
 block/qed.c                 |  1 +
 block/raw-format.c          |  6 ++++
 block/rbd.c                 |  1 +
 block/sheepdog.c            |  1 +
 block/ssh.c                 |  1 +
 block/vdi.c                 | 13 +++++++-
 block/vhdx.c                | 28 +++++++++++++++--
 blockdev.c                  | 16 ++++++++--
 qemu-img.c                  | 11 +++++--
 tests/test-block-iothread.c |  2 +-
 tests/qemu-iotests/041      | 62 ++++++++++++++++++++++++++++++++++---
 tests/qemu-iotests/041.out  |  4 +--
 tests/qemu-iotests/122      | 17 ++++++++++
 tests/qemu-iotests/122.out  |  8 +++++
 tests/qemu-iotests/188      | 20 +++++++++++-
 tests/qemu-iotests/188.out  |  4 +++
 26 files changed, 254 insertions(+), 22 deletions(-)

--=20
2.21.0


