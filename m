Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52A7C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708F82196E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6V1BE2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708F82196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCC0-0001jp-8y
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iUC93-0007VE-Lb
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iUC92-0002bA-3q
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:02:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49258
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iUC92-0002aL-0N
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QTZz8SJ2g1j005GQqmZemMI7nc7bLOtiiF1dHolqpwQ=;
 b=B6V1BE2thS67jnCodNhYzmI6KKUIFgX+1P0mqkk1QyRWBve8NnAGyv/c0n+gIeUDHUB3Ij
 Bv/npGGAuKUwUWk4TEWf8OPTcMDGQX5OVJ0qBAqhBVPlt6v9tQvYyM44gnntSvkuCLOQMU
 82UX5tJxPXWM7UGx6Dhx3guctBvV6w4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-10AOw8HaPxqAyuAdb2tIng-1; Mon, 11 Nov 2019 11:02:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6FA1100550E;
 Mon, 11 Nov 2019 16:02:18 +0000 (UTC)
Received: from localhost (ovpn-117-116.ams2.redhat.com [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 450471C6;
 Mon, 11 Nov 2019 16:02:18 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 00/23] block: Fix check_to_replace_node()
Date: Mon, 11 Nov 2019 17:01:53 +0100
Message-Id: <20191111160216.197086-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 10AOw8HaPxqAyuAdb2tIng-1
X-Mimecast-Spam-Score: 0
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20191108123455.39445-1-mreitz@redhat.com>
(=E2=80=9Ciotests: Test failing mirror complete=E2=80=9D)

(Because both add cases to 041.)


Hi,

For what this series does, see the cover letter of v1:

https://lists.nongnu.org/archive/html/qemu-block/2019-09/msg01027.html


Now, in v2 I=E2=80=99ve addressed Vladimir=E2=80=99s comments:
- Patch 5: Extend explanation in the commit message
- Patch 6: Prefer driver-specific .bdrv_recurse_can_replace()
           implementation before the generic one for filters
- Patch 8: Some more s/BdrvChild \*/QuorumChild/
- Patch 15: Fix typo in the commit message
- Patch 17: Added
- Patch 18:
  - Split @path into @root + @path
  - In one instance, use x =3D next(y, z) instead of
    try: x =3D next(y); except StopIteration: x =3D z;
  - %s/'''/"""/
- Patch 19: Fallout from the patch 18 changes
- Patch 20: Fix in the commit message (uncommenting -> commenting out)
- Patch 21:
  - Check full stderr message by inspecting the VM log
  - Fallout from the patch 18 changes
  - %s/'''/"""/
- Patch 22:
  - Skip case if COR is unsupported
  - Fallout from the patch 18 changes
  - %s/'''/"""/
- Patch 23:
  - Added more comments
  - Skip cases if throttle/COR/quorum (as appropriate) is unsupported
  - Use imgfmt instead of hard-coding qcow2
  - Fallout from the patch 18 changes
  - %s/'''/"""/


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely

001/23:[----] [--] 'blockdev: Allow external snapshots everywhere'
002/23:[----] [--] 'blockdev: Allow resizing everywhere'
003/23:[----] [--] 'block: Drop bdrv_is_first_non_filter()'
004/23:[----] [--] 'iotests: Let 041 use -blockdev for quorum children'
005/23:[----] [--] 'quorum: Fix child permissions'
006/23:[0012] [FC] 'block: Add bdrv_recurse_can_replace()'
007/23:[----] [--] 'blkverify: Implement .bdrv_recurse_can_replace()'
008/23:[0006] [FC] 'quorum: Store children in own structure'
009/23:[----] [--] 'quorum: Add QuorumChild.to_be_replaced'
010/23:[----] [--] 'quorum: Implement .bdrv_recurse_can_replace()'
011/23:[----] [--] 'block: Use bdrv_recurse_can_replace()'
012/23:[----] [--] 'block: Remove bdrv_recurse_is_first_non_filter()'
013/23:[----] [--] 'mirror: Double-check immediately before replacing'
014/23:[----] [--] 'quorum: Stop marking it as a filter'
015/23:[----] [--] 'mirror: Prevent loops'
016/23:[----] [--] 'iotests: Use complete_and_wait() in 155'
017/23:[down] 'iotests: Use skip_if_unsupported decorator in 041'
018/23:[0037] [FC] 'iotests: Add VM.assert_block_path()'
019/23:[0004] [FC] 'iotests: Resolve TODOs in 041'
020/23:[----] [--] 'iotests: Use self.image_len in TestRepairQuorum'
021/23:[0027] [FC] 'iotests: Add tests for invalid Quorum @replaces'
022/23:[0007] [FC] 'iotests: Check that @replaces can replace filters'
023/23:[0141] [FC] 'iotests: Mirror must not attempt to create loops'


Max Reitz (23):
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
  mirror: Prevent loops
  iotests: Use complete_and_wait() in 155
  iotests: Use skip_if_unsupported decorator in 041
  iotests: Add VM.assert_block_path()
  iotests: Resolve TODOs in 041
  iotests: Use self.image_len in TestRepairQuorum
  iotests: Add tests for invalid Quorum @replaces
  iotests: Check that @replaces can replace filters
  iotests: Mirror must not attempt to create loops

 block.c                       | 115 ++++++----
 block/blkverify.c             |  20 +-
 block/copy-on-read.c          |   9 -
 block/mirror.c                |  31 ++-
 block/quorum.c                | 161 +++++++++++---
 block/replication.c           |   7 -
 block/throttle.c              |   8 -
 blockdev.c                    |  58 ++++-
 include/block/block.h         |   5 -
 include/block/block_int.h     |  19 +-
 tests/qemu-iotests/041        | 402 ++++++++++++++++++++++++++++++----
 tests/qemu-iotests/041.out    |   4 +-
 tests/qemu-iotests/155        |   7 +-
 tests/qemu-iotests/iotests.py |  59 +++++
 14 files changed, 715 insertions(+), 190 deletions(-)

--=20
2.23.0


