Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA36C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02BDF2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/5W4nM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BDF2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j40GS-0006rq-0P
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 05:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j40Dl-0001CV-88
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j40Dj-0007MX-Nv
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57576
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j40Dj-0007MG-Hp
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582022115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qfx6sx2A0ABd7buq7C5ss1lhcszgTR0ujqzJpqrzylY=;
 b=c/5W4nM3MMAqOCsGIid0VZO1qVkWupG9LsBDMl5x7WZmOW5ExWJii6Te6hTdRBMvT38FBP
 KY4oZEqNTczALC6IEbMWFkR3PZQnzl7K5BQJx2mAy2Y1mTlccjejOX3ImOLT5W2T7tGTce
 7Jdp8K7aDqMGi/18kAJLlKMsLPZx01c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-XfxqxMLQPPyhSp2ZKO7fJg-1; Tue, 18 Feb 2020 05:34:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 596AA100550E;
 Tue, 18 Feb 2020 10:34:57 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C909384;
 Tue, 18 Feb 2020 10:34:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 00/19] block: Fix check_to_replace_node()
Date: Tue, 18 Feb 2020 11:34:35 +0100
Message-Id: <20200218103454.296704-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: XfxqxMLQPPyhSp2ZKO7fJg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Branch: https://github.com/XanClic/qemu.git fix-can-replace-v4
Branch: https://git.xanclic.moe/XanClic/qemu.git fix-can-replace-v4

v1: https://lists.nongnu.org/archive/html/qemu-block/2019-09/msg01027.html
v2: https://lists.nongnu.org/archive/html/qemu-block/2019-11/msg00370.html
v3: https://lists.nongnu.org/archive/html/qemu-block/2020-01/msg00922.html


Hi,

For what this series does, see the cover letter of v1 (linked above).


Changes in v4 compared to v3:
- Following the discussion with Kevin, I changed Quorum=E2=80=99s
  .bdrv_recurse_can_replace() implementation from unsharing the
  CONSISTENT_READ permission and taking the WRITE permission to just
  checking whether there are any other parents
  - This made the old patches 8 and 9 unnecessary, so they=E2=80=99ve been
    dropped
  - And of course it requires some changes to patch 10 (now 8)
  - (Patch 10 (was: 12) gets a rebase conflict that=E2=80=99s obvious to
    resolve, so I kept Vladimir=E2=80=99s R-b)

- As suggested by Vladimir, I added the root node name to the
  cannot-follow-path error message in patch 14 (was: 16), and added an
  assertion that the root node exists in the first place


git-backport-diff against v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely

001/19:[----] [--] 'blockdev: Allow external snapshots everywhere'
002/19:[----] [--] 'blockdev: Allow resizing everywhere'
003/19:[----] [--] 'block: Drop bdrv_is_first_non_filter()'
004/19:[----] [--] 'iotests: Let 041 use -blockdev for quorum children'
005/19:[----] [--] 'quorum: Fix child permissions'
006/19:[----] [--] 'block: Add bdrv_recurse_can_replace()'
007/19:[----] [--] 'blkverify: Implement .bdrv_recurse_can_replace()'
008/19:[0019] [FC] 'quorum: Implement .bdrv_recurse_can_replace()'
009/19:[----] [--] 'block: Use bdrv_recurse_can_replace()'
010/19:[0002] [FC] 'block: Remove bdrv_recurse_is_first_non_filter()'
011/19:[----] [--] 'mirror: Double-check immediately before replacing'
012/19:[----] [--] 'quorum: Stop marking it as a filter'
013/19:[----] [--] 'iotests: Use complete_and_wait() in 155'
014/19:[0005] [FC] 'iotests: Add VM.assert_block_path()'
015/19:[----] [--] 'iotests/041: Drop superfluous shutdowns'
016/19:[----] [--] 'iotests: Resolve TODOs in 041'
017/19:[----] [--] 'iotests: Use self.image_len in TestRepairQuorum'
018/19:[----] [--] 'iotests: Add tests for invalid Quorum @replaces'
019/19:[----] [--] 'iotests: Check that @replaces can replace filters'


Max Reitz (19):
  blockdev: Allow external snapshots everywhere
  blockdev: Allow resizing everywhere
  block: Drop bdrv_is_first_non_filter()
  iotests: Let 041 use -blockdev for quorum children
  quorum: Fix child permissions
  block: Add bdrv_recurse_can_replace()
  blkverify: Implement .bdrv_recurse_can_replace()
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

 block.c                       |  85 ++++++++++-----------
 block/blkverify.c             |  20 ++---
 block/copy-on-read.c          |   9 ---
 block/filter-compress.c       |   9 ---
 block/mirror.c                |  14 +++-
 block/quorum.c                |  70 ++++++++++++++---
 block/replication.c           |   7 --
 block/throttle.c              |   8 --
 blockdev.c                    |  10 ---
 include/block/block.h         |   5 --
 include/block/block_int.h     |  16 ++--
 tests/qemu-iotests/041        | 138 +++++++++++++++++++++++++++++-----
 tests/qemu-iotests/041.out    |   4 +-
 tests/qemu-iotests/155        |   7 +-
 tests/qemu-iotests/iotests.py |  59 +++++++++++++++
 15 files changed, 315 insertions(+), 146 deletions(-)

--=20
2.24.1


