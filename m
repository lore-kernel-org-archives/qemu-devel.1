Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8A4C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:17:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E9120896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E9120896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35416 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbBYy-000408-Vu
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 18:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45109)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBRd-0006wU-9z
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBRb-0007FI-I4
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:10:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34474)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBRX-00077s-C4; Wed, 12 Jun 2019 18:10:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 61A70A3B6F;
 Wed, 12 Jun 2019 22:10:06 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E33C91001B15;
 Wed, 12 Jun 2019 22:10:05 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:09:22 +0200
Message-Id: <20190612221004.2317-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 12 Jun 2019 22:10:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 00/42] block: Deal with filters
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


*** This series depends on some others. ***

Dependencies:
- [PATCH 0/4] block: Keep track of parent quiescing
- [PATCH 0/2] vl: Drain before (block) job cancel when quitting
- [PATCH v2 0/2] blockdev: Overlays are not snapshots

Based-on: <20190605161118.14544-1-mreitz@redhat.com>
Based-on: <20190612220839.1374-1-mreitz@redhat.com>
Based-on: <20190603202236.1342-1-mreitz@redhat.com>


v5:
- Split the huge patches 2 and 3 from the previous version into many
  smaller patches to maintain the potential reviewers=E2=80=99 sanity [Vl=
adimir]

- Added support for compressed writes to the COR and throttle filter
  drivers to demonstrate how that looks, because the backup job needs to
  deal with filters that have such support

- Added differentiation between bdrv_storage_child(),
  bdrv_primary_child(), and bdrv_metadata_child()

- A whole lot of things Vladimir has noted

- Made the block jobs really work with filters.  In case of commit and
  stream, this now means that filters go away if they are between top
  and base.  I think that=E2=80=99s OK because it=E2=80=99s the user=E2=80=
=99s choice to include
  filters or not.  (They can move the filters around if they prefer a
  different result.)
  - This changes the =E2=80=9CAdd filter commit test cases=E2=80=9D from =
checking that
    most things do not work to checking that they do

- Added the =E2=80=9Cblockdev: Fix active commit choice=E2=80=9D patch be=
cause it turned
  out this became necessary after I allowed committing through and with
  filters.


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
  block: Use CAF in bdrv_is_encrypted()
  block: Add bdrv_supports_compressed_writes()
  block: Use bdrv_filtered_rw* where obvious
  block: Use CAFs in block status functions
  block: Use CAFs when working with backing chains
  block: Re-evaluate backing file handling in reopen
  block: Use child access functions when flushing
  block: Use CAFs in bdrv_refresh_limits()
  block: Use CAFs in bdrv_refresh_filename()
  block: Use CAF in bdrv_co_rw_vmstate()
  block/snapshot: Fall back to storage child
  block: Use CAFs for debug breakpoints
  block: Use CAFs in bdrv_get_allocated_file_size()
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
 include/block/block.h         |   2 +
 include/block/block_int.h     | 109 ++++---
 block.c                       | 523 +++++++++++++++++++++++++++++-----
 block/backup.c                |   9 +-
 block/blkdebug.c              |   7 +-
 block/blklogwrites.c          |   1 -
 block/block-backend.c         |  16 +-
 block/commit.c                | 100 +++++--
 block/copy-on-read.c          |  13 +-
 block/io.c                    | 115 ++++----
 block/mirror.c                | 113 ++++++--
 block/qapi.c                  |  42 +--
 block/qcow2.c                 |   9 +
 block/snapshot.c              |  74 +++--
 block/stream.c                |  23 +-
 block/throttle.c              |  11 +-
 blockdev.c                    | 139 +++++++--
 nbd/server.c                  |   6 +-
 qemu-img.c                    |  36 +--
 tests/qemu-iotests/020        |  36 +++
 tests/qemu-iotests/020.out    |  10 +
 tests/qemu-iotests/040        | 238 ++++++++++++++++
 tests/qemu-iotests/040.out    |   4 +-
 tests/qemu-iotests/041        | 270 +++++++++++++++++-
 tests/qemu-iotests/041.out    |   4 +-
 tests/qemu-iotests/184.out    |   7 +-
 tests/qemu-iotests/191.out    |   1 -
 tests/qemu-iotests/204.out    |   1 +
 tests/qemu-iotests/228        |   6 +-
 tests/qemu-iotests/228.out    |   6 +-
 tests/qemu-iotests/245        |   4 +-
 tests/qemu-iotests/iotests.py |  10 +-
 33 files changed, 1610 insertions(+), 339 deletions(-)

--=20
2.21.0


