Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AAAC32756
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:15:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB5412086A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5412086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7Xx-0002Y0-TW
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56642)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7X0-0000ID-G0
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7Wx-0003qQ-Q1
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7Ws-0003nL-ND; Fri, 09 Aug 2019 12:14:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 92FB23082B1F;
 Fri,  9 Aug 2019 16:14:09 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F0B86600CC;
 Fri,  9 Aug 2019 16:14:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:25 +0200
Message-Id: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 09 Aug 2019 16:14:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 00/42] block: Deal with filters
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

Hi,

When we introduced filters, we did it a bit casually.  Sure, we talked a
lot about them before, but that was mostly discussion about where
implicit filters should be added to the graph (note that we currently
only have two implicit filters, those being mirror and commit).  But in
the end, we really just designated some drivers filters (Quorum,
blkdebug, etc.) and added some specifically (throttle, COR), without
really looking through the block layer to see where issues might occur.

It turns out vast areas of the block layer just don=E2=80=99t know about =
filters
and cannot really handle them.  Many cases will work in practice, in
others, well, too bad, you cannot use some feature because some part
deep inside the block layer looks at your filters and thinks they are
format nodes.

This is one reason why this series is needed.  Over time (since v1), a
second reason has made its way in:

bs->file is not necessarily the place where a node=E2=80=99s data is stor=
ed.
qcow2 now has external data files, and currently there is no way for the
general block layer to know that the data is not stored in bs->file.
Right now, I do not think that has any real consequences (all functions
that need access to the actual data storage file should only do so as a
fallback if the driver does not provide some functionality, but qcow2
should provide it all), but it still shows that we need some way to let
the general block layer know about such data files.  (Also, I will need
this for v1 of my =E2=80=9CInquire images=E2=80=99 rotational info=E2=80=9D=
 series.)

I won=E2=80=99t go on and on about this series now, I think the patches p=
retty
much speak for themselves now.  If the cover letter gets too long,
nobody reads it anyway (see previous versions).


*** I=E2=80=99ve based this series on John=E2=80=99s bitmap branch, which=
 I=E2=80=99ve rebased
    on my block-next branch. ***

I=E2=80=99ve pushed the patches here:

  https://git.xanclic.moe/XanClic/qemu child-access-functions-v6
  https://github.com/XanClic/qemu child-access-functions-v6

I=E2=80=99ve also pushed the base branch to each of those repos, it=E2=80=
=99s
=E2=80=9Cchild-access-functions-base=E2=80=9D.


v6:
- Patch 9: Rename *freeze_backing_chain (etc.) to *freeze_chain (etc.)
- Patch 10: Drop bdrv_is_encrypted() instead of fixing it the wrong way
- Patch 15: Add a comment on why this works
- Patch 16: Just flush all children instead of one
- Patch 20: We have to snapshot all non-backing children, so both
            metadata and storage children; for simplification, just
            disallow the fallback path if there is more than one such
            child
- Patch 22: bdrv_get_allocated_file_size() should report all children=E2=80=
=99s
            sizes, not just the primary or storage child=E2=80=99s
- Patch 24: Make query-blockstats too report any filtered child under
            =E2=80=9Cbacking=E2=80=9D
- Patch 25:
  - bdrv_is_allocated_above()=E2=80=99s new @include_base parameter makes=
 things
    a bit simpler
  - Forbid mirroring to a filter on top of the base
- Patch 27: bdrv_is_allocated_above()=E2=80=99s new @include_base paramet=
er
            makes things a bit simpler
- Patch 28: Requires a few changes to keep stream independent of the
            base node
- Patch 30:
  - Sprinkle in a few bdrv_skip_implicit_filters()s
  - Conflicts with the convert --salvage patches


git backport-diff against v5:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/42:[----] [-C] 'block: Mark commit and mirror as filter drivers'
002/42:[----] [--] 'copy-on-read: Support compressed writes'
003/42:[----] [--] 'throttle: Support compressed writes'
004/42:[----] [--] 'block: Add child access functions'
005/42:[----] [--] 'block: Add chain helper functions'
006/42:[----] [--] 'qcow2: Implement .bdrv_storage_child()'
007/42:[----] [--] 'block: *filtered_cow_child() for *has_zero_init()'
008/42:[----] [--] 'block: bdrv_set_backing_hd() is about bs->backing'
009/42:[0078] [FC] 'block: Include filters when freezing backing chain'
010/42:[down] 'block: Drop bdrv_is_encrypted()'
011/42:[----] [-C] 'block: Add bdrv_supports_compressed_writes()'
012/42:[----] [--] 'block: Use bdrv_filtered_rw* where obvious'
013/42:[----] [-C] 'block: Use CAFs in block status functions'
014/42:[----] [--] 'block: Use CAFs when working with backing chains'
015/42:[0017] [FC] 'block: Re-evaluate backing file handling in reopen'
016/42:[down] 'block: Flush all children in generic code'
017/42:[----] [--] 'block: Use CAFs in bdrv_refresh_limits()'
018/42:[----] [--] 'block: Use CAFs in bdrv_refresh_filename()'
019/42:[----] [--] 'block: Use CAF in bdrv_co_rw_vmstate()'
020/42:[down] 'block/snapshot: Fix fallback'
021/42:[----] [--] 'block: Use CAFs for debug breakpoints'
022/42:[down] 'block: Fix bdrv_get_allocated_file_size's fallback'
023/42:[----] [--] 'blockdev: Use CAF in external_snapshot_prepare()'
024/42:[0012] [FC] 'block: Use child access functions for QAPI queries'
025/42:[0019] [FC] 'mirror: Deal with filters'
026/42:[----] [--] 'backup: Deal with filters'
027/42:[0025] [FC] 'commit: Deal with filters'
028/42:[0048] [FC] 'stream: Deal with filters'
029/42:[----] [--] 'nbd: Use CAF when looking for dirty bitmap'
030/42:[0035] [FC] 'qemu-img: Use child access functions'
031/42:[----] [--] 'block: Drop backing_bs()'
032/42:[----] [-C] 'block: Make bdrv_get_cumulative_perm() public'
033/42:[----] [--] 'blockdev: Fix active commit choice'
034/42:[----] [-C] 'block: Inline bdrv_co_block_status_from_*()'
035/42:[----] [--] 'block: Fix check_to_replace_node()'
036/42:[----] [--] 'iotests: Add tests for mirror @replaces loops'
037/42:[----] [-C] 'block: Leave BDS.backing_file constant'
038/42:[----] [--] 'iotests: Let complete_and_wait() work with commit'
039/42:[----] [--] 'iotests: Add filter commit test cases'
040/42:[----] [--] 'iotests: Add filter mirror test cases'
041/42:[----] [--] 'iotests: Add test for commit in sub directory'
042/42:[----] [--] 'iotests: Test committing to overridden backing'


Max Reitz (42):
  block: Mark commit and mirror as filter drivers
  copy-on-read: Support compressed writes
  throttle: Support compressed writes
  block: Add child access functions
  block: Add chain helper functions
  qcow2: Implement .bdrv_storage_child()
  block: *filtered_cow_child() for *has_zero_init()
  block: bdrv_set_backing_hd() is about bs->backing
  block: Include filters when freezing backing chain
  block: Drop bdrv_is_encrypted()
  block: Add bdrv_supports_compressed_writes()
  block: Use bdrv_filtered_rw* where obvious
  block: Use CAFs in block status functions
  block: Use CAFs when working with backing chains
  block: Re-evaluate backing file handling in reopen
  block: Flush all children in generic code
  block: Use CAFs in bdrv_refresh_limits()
  block: Use CAFs in bdrv_refresh_filename()
  block: Use CAF in bdrv_co_rw_vmstate()
  block/snapshot: Fix fallback
  block: Use CAFs for debug breakpoints
  block: Fix bdrv_get_allocated_file_size's fallback
  blockdev: Use CAF in external_snapshot_prepare()
  block: Use child access functions for QAPI queries
  mirror: Deal with filters
  backup: Deal with filters
  commit: Deal with filters
  stream: Deal with filters
  nbd: Use CAF when looking for dirty bitmap
  qemu-img: Use child access functions
  block: Drop backing_bs()
  block: Make bdrv_get_cumulative_perm() public
  blockdev: Fix active commit choice
  block: Inline bdrv_co_block_status_from_*()
  block: Fix check_to_replace_node()
  iotests: Add tests for mirror @replaces loops
  block: Leave BDS.backing_file constant
  iotests: Let complete_and_wait() work with commit
  iotests: Add filter commit test cases
  iotests: Add filter mirror test cases
  iotests: Add test for commit in sub directory
  iotests: Test committing to overridden backing

 qapi/block-core.json          |   4 +
 include/block/block.h         |  13 +-
 include/block/block_int.h     | 109 ++++---
 block.c                       | 552 ++++++++++++++++++++++++++++------
 block/backup.c                |   9 +-
 block/blkdebug.c              |   7 +-
 block/blklogwrites.c          |   1 -
 block/block-backend.c         |  16 +-
 block/commit.c                | 107 +++++--
 block/copy-on-read.c          |  13 +-
 block/io.c                    | 117 ++++---
 block/mirror.c                | 124 ++++++--
 block/qapi.c                  |  48 +--
 block/qcow2.c                 |   9 +
 block/snapshot.c              | 100 ++++--
 block/stream.c                |  52 ++--
 block/throttle.c              |  11 +-
 blockdev.c                    | 139 +++++++--
 nbd/server.c                  |   6 +-
 qemu-img.c                    |  33 +-
 tests/qemu-iotests/020        |  36 +++
 tests/qemu-iotests/020.out    |  10 +
 tests/qemu-iotests/040        | 238 +++++++++++++++
 tests/qemu-iotests/040.out    |   4 +-
 tests/qemu-iotests/041        | 270 ++++++++++++++++-
 tests/qemu-iotests/041.out    |   4 +-
 tests/qemu-iotests/184.out    |   7 +-
 tests/qemu-iotests/191.out    |   1 -
 tests/qemu-iotests/204.out    |   1 +
 tests/qemu-iotests/228        |   6 +-
 tests/qemu-iotests/228.out    |   6 +-
 tests/qemu-iotests/245        |   4 +-
 tests/qemu-iotests/iotests.py |  10 +-
 33 files changed, 1682 insertions(+), 385 deletions(-)

--=20
2.21.0


