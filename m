Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C051C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3EC20708
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyuAQt2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3EC20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHnZ-00069L-3t
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ixHcM-0004cI-8U
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:44:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ixHcK-0003fC-GH
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:44:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51067
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ixHcK-0003c5-Ad
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580420692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EcqaxMqEMxQzt/D3+IxWTW0CvvEpGGrBmPyEZ7IDHOQ=;
 b=SyuAQt2ITsNRo+mxUUn5hEVVokraOMEcss11R1Y/MlwPjJN98pf1Uk1KKDoXXK61Rkmfm3
 QVMmCNWCuqCvQbaHP5eXnlvSxFH3yPIUYp2VSOwJZ6WDouqpeGhp1kgNRrUzsjiejOLxmz
 DYVvJHfRnw+04ak8YzAomZLYad61EZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-VnW5T_20OZC3KEpcVTvGGw-1; Thu, 30 Jan 2020 16:44:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6B826C3F2;
 Thu, 30 Jan 2020 21:44:33 +0000 (UTC)
Received: from localhost (ovpn-204-145.brq.redhat.com [10.40.204.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F61887B00;
 Thu, 30 Jan 2020 21:44:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 00/21] block: Fix check_to_replace_node()
Date: Thu, 30 Jan 2020 22:44:10 +0100
Message-Id: <20200130214431.333510-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: VnW5T_20OZC3KEpcVTvGGw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Branch: https://github.com/XanClic/qemu.git fix-can-replace-v3
Branch: https://git.xanclic.moe/XanClic/qemu.git fix-can-replace-v3

v1: https://lists.nongnu.org/archive/html/qemu-block/2019-09/msg01027.html
v2: https://lists.nongnu.org/archive/html/qemu-block/2019-11/msg00370.html


Hi,

For what this series does, see the cover letter of v1 (linked above).


In v3 I=E2=80=99ve addressed Vladimir=E2=80=99s further comments:
- Patch 9: Skip the loop if c =3D=3D NULL (and also renamed @i to @child_i)

- Patch 10: Drop local_err, check bdrv_child_refresh_perm()=E2=80=99s retur=
n
            value instead

- Patch 11: Amended commit message and comment

- Patch 12: Extended to cover the =E2=80=9Cnew=E2=80=9D compress filter dri=
ver

- Patch 15: Dropped; considering qemu never actually creates loops,
            there is never an unsafe configuration.  Sometimes the user
            may not get what they want, but then maybe this was actually
            what they wanted.  I think the discussion I had with
            Vladimir shows that this issue isn=E2=80=99t as clear-cut as I
            thought, so let=E2=80=99s wait with a =E2=80=9Cfix=E2=80=9D unt=
il someone actually
            has a problem with the current behavior.

- Patch 17: Dropped; was superseded by a patch from Thomas.

- Patch 16 (was 18):
  - Moved doc string under def
  - Pointed out that @expected_node may be None, but this only means
    that the leaf must not exist.
  - Contracted asserts
  - %s/path_node/child_name/
  - Kept the prefix /, because, well, why not
  - Kept % for formatting, because I don=E2=80=99t see the advantage of
    .format() =E2=80=93 I would have liked to use f strings, but those were=
 only
    introduced in 3.6, and our minimum version is 3.5.

- Patch 17: Added

- Patch 18 (was 19): Dropped removal of self.vm.shutdown(), because
                     that=E2=80=99s done by patch 17 now

- Patch 20 (was 21): Moved doc strings under defs (kept R-b, because
                     that seemed right to do)

- Patch 21 (was 22): Moved doc string under def

- Patch 23: Dropped, because it only tested things changed by the old
            patch 17 (which I dropped, too)


git backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely

001/21:[----] [--] 'blockdev: Allow external snapshots everywhere'
002/21:[----] [--] 'blockdev: Allow resizing everywhere'
003/21:[----] [--] 'block: Drop bdrv_is_first_non_filter()'
004/21:[----] [--] 'iotests: Let 041 use -blockdev for quorum children'
005/21:[----] [--] 'quorum: Fix child permissions'
006/21:[----] [--] 'block: Add bdrv_recurse_can_replace()'
007/21:[----] [--] 'blkverify: Implement .bdrv_recurse_can_replace()'
008/21:[----] [--] 'quorum: Store children in own structure'
009/21:[0014] [FC] 'quorum: Add QuorumChild.to_be_replaced'
010/21:[0011] [FC] 'quorum: Implement .bdrv_recurse_can_replace()'
011/21:[0002] [FC] 'block: Use bdrv_recurse_can_replace()'
012/21:[0009] [FC] 'block: Remove bdrv_recurse_is_first_non_filter()'
013/21:[----] [--] 'mirror: Double-check immediately before replacing'
014/21:[----] [--] 'quorum: Stop marking it as a filter'
015/21:[----] [--] 'iotests: Use complete_and_wait() in 155'
016/21:[0053] [FC] 'iotests: Add VM.assert_block_path()'
017/21:[down] 'iotests/041: Drop superfluous shutdowns'
018/21:[0001] [FC] 'iotests: Resolve TODOs in 041'
019/21:[----] [--] 'iotests: Use self.image_len in TestRepairQuorum'
020/21:[0016] [FC] 'iotests: Add tests for invalid Quorum @replaces'
021/21:[0006] [FC] 'iotests: Check that @replaces can replace filters'


Max Reitz (21):
  blockdev: Allow external snapshots everywhere
  blockdev: Allow resizing everywhere
  block: Drop bdrv_is_first_non_filter()
  iotests: Let 041 use -blockdev for quorum children
  quorum: Fix child permissions
  block: Add bdrv_recurse_can_replace()
  blkverify: Implement .bdrv_recurse_can_replace()
  quorum: Store children in own structure
  quorum: Add QuorumChild.to_be_replaced
  quorum: Implement .bdrv_recurse_can_replace()
  block: Use bdrv_recurse_can_replace()
  block: Remove bdrv_recurse_is_first_non_filter()
  mirror: Double-check immediately before replacing
  quorum: Stop marking it as a filter
  iotests: Use complete_and_wait() in 155
  iotests: Add VM.assert_block_path()
  iotests/041: Drop superfluous shutdowns
  iotests: Resolve TODOs in 041
  iotests: Use self.image_len in TestRepairQuorum
  iotests: Add tests for invalid Quorum @replaces
  iotests: Check that @replaces can replace filters

 block.c                       |  85 +++++++++---------
 block/blkverify.c             |  20 ++---
 block/copy-on-read.c          |   9 --
 block/filter-compress.c       |   9 --
 block/mirror.c                |  14 ++-
 block/quorum.c                | 160 ++++++++++++++++++++++++++--------
 block/replication.c           |   7 --
 block/throttle.c              |   8 --
 blockdev.c                    |  10 ---
 include/block/block.h         |   5 --
 include/block/block_int.h     |  16 ++--
 tests/qemu-iotests/041        | 138 +++++++++++++++++++++++++----
 tests/qemu-iotests/041.out    |   4 +-
 tests/qemu-iotests/155        |   7 +-
 tests/qemu-iotests/iotests.py |  56 ++++++++++++
 15 files changed, 375 insertions(+), 173 deletions(-)

--=20
2.24.1


