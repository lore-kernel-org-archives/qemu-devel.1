Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1135C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:40:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80829207D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KK5okqMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80829207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7SJ-0002K7-Mi
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7N3-0007Sc-3L
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:34:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38532
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7N0-00075O-Km
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598970885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GIeSHtUmokJ87NXOtrgQB1hjR88SMYizIyGtWpfwBjo=;
 b=KK5okqMRiMvW0jOqE3IRrrpLCEJJTK3YosunCg4aHebrQ7cGSxSFF2barj2q/OPAV36y8b
 cUG7u9ZDRMzy9cRF2hT9C6pVlMU09Jkg7Cg7Y60o4FmCUCrKxrrcZ8eeRfDPs/wOM/5amk
 hCAcyjNIuZXBzGCTPNHLt7n1zv3Ap5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-P1eT4Iz2PfevB5iiW7Zh8Q-1; Tue, 01 Sep 2020 10:34:29 -0400
X-MC-Unique: P1eT4Iz2PfevB5iiW7Zh8Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32C6381CAF8;
 Tue,  1 Sep 2020 14:34:27 +0000 (UTC)
Received: from localhost (ovpn-113-83.ams2.redhat.com [10.36.113.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 955C87C564;
 Tue,  1 Sep 2020 14:34:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 00/43] block: Deal with filters
Date: Tue,  1 Sep 2020 16:33:41 +0200
Message-Id: <20200901143424.884735-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v6: https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg01715.html
v7: https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg01357.html

Branch: https://github.com/XanClic/qemu.git child-access-functions-v8
Branch: https://git.xanclic.moe/XanClic/qemu.git child-access-functions-v8


Hi,

In v8, there is not too much that has changed in respect to v7.  I tried
to address all of your comments and hope I got it right.  I also hope I
got the R-bs right.


Changes from v7:
- Patch 1: Let bdrv_primary_child() assert that there’s only a single
           primary child

- Patch 2: Assert that bdrv_do_skip_filters() will not return a filter
           node

- Patch 3: Drop bdrv_unallocated_blocks_are_zero() hunk (that function
           no longer exists)

- Old patch 10: Dropped, it isn’t really important to let mirror-top
                support compressed writes, and
                bdrv_supports_compressed_writes() doesn’t really work
                with this patch

- Old patch 11: Dropped, it isn’t really important to let backup-top
                support compressed writes

- Patch 10: Rebase conflict in init_dirty_bitmap_migration()
            (The modified block is now nested one level deeper)

- Patch 11: Rebase conflict in bdrv_co_block_status()
            (bdrv_unallocated_blocks_are_zero() is no longer used)

- Patch 12:
  - Fix documentation on what the backing node after streaming is going
    to be
  - bdrv_change_backing_file() rebase conflict

- Patch 13: Try to clarify what bdrv_find_overlay() returns in its doc
            comment

- Patch 15: Optimize the overlay_bs finding loop

- Old patch 25: Rolled into the next patch (now patch 23)

- Patch 23:
  - Inline two of the three functions introduced in the old patch 25
  - The other one (bdrv_sum_allocated_file_size()) stays, but is static
    now
  (Turns out we don’t need to let block drivers use any of these
  functions for their BlockDriver.bdrv_get_allocated_File_size().)

- Old patch 27: Dropped, just let blkverify be handled like any other
                filter, because it doesn’t matter, really
                (and this allows us squashing the previous to patches)

- Patch 24: Remove _filter_actual_image_size from iotest 184

- Patch 27: Reference output change due to 184 no longer invoking
            _filter_actual_image_size

- Patch 29:
  - Let the commit message explain why base_overlay is introduced
  - Drop @replaces_node_name from qmp_drive_mirror(), because it isn’t
    needed

- Patch 31:
  - Let blk_commit_all() only commit those nodes that have a backing
    file; and ignore all filters on top of them (instead of just
    implicit filters)
  - In commit_start: %s/\<perms\>/base_perms/
  - Under commit_start.ro_cleanup: Restore the original backing file
    only if necessary, so we do not run into an abort because the
    backing chain is frozen

- Patch 33: Let img_rebase() refer to the unfiltered_bs in three more
            places

- Patch 35:
  - Documentation modifications:
    - Move a chunk of it up where it belongs (from below @backing-file
      to the general area of @block-commit)
    - Explain that you now need to issue block-job-complete whenever
      there’s a writer on @top
    - Also, @backing-file is no longer allowed whenever there’s a writer
      on @top
      - In the code, this should cause a different error message than
        when @top is in the active layer, though
  - Comment note: If @top is a root node without any writers on it, we
    still need to do an active commit, because everything else would be
    an incompatible change

- Patch 36: Trivial rebase conflict in block_int.h (necessary because
            the old patch 25 was dropped)

- Patch 37: Don’t try to fetch ImageInfo.backing-filename-format from
            the backing file open at runtime.  If the image header does
            not specify a format, just leave it empty.

- Patch 40: Use format string instead of ''.format()

- Patch 42: Add -F $IMGFMT to _make_test_img -b


git-backport-diff against v7:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/43:[0007] [FC] 'block: Add child access functions'
002/43:[0007] [FC] 'block: Add chain helper functions'
003/43:[0002] [FC] 'block: bdrv_cow_child() for bdrv_has_zero_init()'
004/43:[----] [--] 'block: bdrv_set_backing_hd() is about bs->backing'
005/43:[----] [--] 'block: Include filters when freezing backing chain'
006/43:[----] [--] 'block: Drop bdrv_is_encrypted()'
007/43:[----] [--] 'block: Add bdrv_supports_compressed_writes()'
008/43:[----] [--] 'throttle: Support compressed writes'
009/43:[----] [--] 'copy-on-read: Support compressed writes'
010/43:[0016] [FC] 'block: Use bdrv_filter_(bs|child) where obvious'
011/43:[0008] [FC] 'block: Use CAFs in block status functions'
012/43:[0017] [FC] 'stream: Deal with filters'
013/43:[0007] [FC] 'block: Use CAFs when working with backing chains'
014/43:[----] [--] 'block: Use bdrv_cow_child() in bdrv_co_truncate()'
015/43:[0009] [FC] 'block: Re-evaluate backing file handling in reopen'
016/43:[----] [--] 'block: Flush all children in generic code'
017/43:[----] [--] 'vmdk: Drop vmdk_co_flush()'
018/43:[----] [--] 'block: Iterate over children in refresh_limits'
019/43:[----] [--] 'block: Use CAFs in bdrv_refresh_filename()'
020/43:[----] [--] 'block: Use CAF in bdrv_co_rw_vmstate()'
021/43:[----] [--] 'block/snapshot: Fix fallback'
022/43:[----] [--] 'block: Use CAFs for debug breakpoints'
023/43:[0031] [FC] 'block: Improve get_allocated_file_size's default'
024/43:[0007] [FC] 'block/null: Implement bdrv_get_allocated_file_size'
025/43:[----] [--] 'blockdev: Use CAF in external_snapshot_prepare()'
026/43:[----] [--] 'block: Report data child for query-blockstats'
027/43:[0002] [FC] 'block: Use child access functions for QAPI queries'
028/43:[----] [--] 'block-copy: Use CAF to find sync=top base'
029/43:[0004] [FC] 'mirror: Deal with filters'
030/43:[----] [--] 'backup: Deal with filters'
031/43:[0020] [FC] 'commit: Deal with filters'
032/43:[----] [--] 'nbd: Use CAF when looking for dirty bitmap'
033/43:[0007] [FC] 'qemu-img: Use child access functions'
034/43:[----] [--] 'block: Drop backing_bs()'
035/43:[0052] [FC] 'blockdev: Fix active commit choice'
036/43:[0001] [FC] 'block: Inline bdrv_co_block_status_from_*()'
037/43:[0013] [FC] 'block: Leave BDS.backing_file constant'
038/43:[----] [--] 'iotests: Test that qcow2's data-file is flushed'
039/43:[----] [--] 'iotests: Let complete_and_wait() work with commit'
040/43:[0004] [FC] 'iotests: Add filter commit test cases'
041/43:[----] [--] 'iotests: Add filter mirror test cases'
042/43:[0008] [FC] 'iotests: Add test for commit in sub directory'
043/43:[----] [--] 'iotests: Test committing to overridden backing'


Max Reitz (43):
  block: Add child access functions
  block: Add chain helper functions
  block: bdrv_cow_child() for bdrv_has_zero_init()
  block: bdrv_set_backing_hd() is about bs->backing
  block: Include filters when freezing backing chain
  block: Drop bdrv_is_encrypted()
  block: Add bdrv_supports_compressed_writes()
  throttle: Support compressed writes
  copy-on-read: Support compressed writes
  block: Use bdrv_filter_(bs|child) where obvious
  block: Use CAFs in block status functions
  stream: Deal with filters
  block: Use CAFs when working with backing chains
  block: Use bdrv_cow_child() in bdrv_co_truncate()
  block: Re-evaluate backing file handling in reopen
  block: Flush all children in generic code
  vmdk: Drop vmdk_co_flush()
  block: Iterate over children in refresh_limits
  block: Use CAFs in bdrv_refresh_filename()
  block: Use CAF in bdrv_co_rw_vmstate()
  block/snapshot: Fix fallback
  block: Use CAFs for debug breakpoints
  block: Improve get_allocated_file_size's default
  block/null: Implement bdrv_get_allocated_file_size
  blockdev: Use CAF in external_snapshot_prepare()
  block: Report data child for query-blockstats
  block: Use child access functions for QAPI queries
  block-copy: Use CAF to find sync=top base
  mirror: Deal with filters
  backup: Deal with filters
  commit: Deal with filters
  nbd: Use CAF when looking for dirty bitmap
  qemu-img: Use child access functions
  block: Drop backing_bs()
  blockdev: Fix active commit choice
  block: Inline bdrv_co_block_status_from_*()
  block: Leave BDS.backing_{file,format} constant
  iotests: Test that qcow2's data-file is flushed
  iotests: Let complete_and_wait() work with commit
  iotests: Add filter commit test cases
  iotests: Add filter mirror test cases
  iotests: Add test for commit in sub directory
  iotests: Test committing to overridden backing

 qapi/block-core.json           |  58 ++--
 include/block/block.h          |   2 +-
 include/block/block_int.h      |  95 ++++---
 block.c                        | 488 ++++++++++++++++++++++++++-------
 block/backup-top.c             |   4 +-
 block/backup.c                 |   9 +-
 block/blkdebug.c               |   7 +-
 block/blklogwrites.c           |   1 -
 block/block-backend.c          |   7 +-
 block/block-copy.c             |   4 +-
 block/commit.c                 |  95 +++++--
 block/copy-on-read.c           |  13 +-
 block/filter-compress.c        |   2 -
 block/io.c                     | 142 +++++-----
 block/mirror.c                 | 119 ++++++--
 block/monitor/block-hmp-cmds.c |   2 +-
 block/null.c                   |   7 +
 block/qapi.c                   |  74 +++--
 block/snapshot.c               | 104 +++++--
 block/stream.c                 |  63 +++--
 block/throttle.c               |  11 +-
 block/vmdk.c                   |  16 --
 blockdev.c                     | 101 +++++--
 migration/block-dirty-bitmap.c |   8 +-
 nbd/server.c                   |   6 +-
 qemu-img.c                     |  43 +--
 tests/qemu-iotests/020         |  44 +++
 tests/qemu-iotests/020.out     |  10 +
 tests/qemu-iotests/040         | 238 ++++++++++++++++
 tests/qemu-iotests/040.out     |   4 +-
 tests/qemu-iotests/041         | 146 +++++++++-
 tests/qemu-iotests/041.out     |   4 +-
 tests/qemu-iotests/153.out     |   2 +-
 tests/qemu-iotests/184         |   3 +-
 tests/qemu-iotests/184.out     |  14 +-
 tests/qemu-iotests/204.out     |   1 +
 tests/qemu-iotests/228         |   6 +-
 tests/qemu-iotests/228.out     |   6 +-
 tests/qemu-iotests/244         |  49 ++++
 tests/qemu-iotests/244.out     |   7 +
 tests/qemu-iotests/245         |   4 +-
 tests/qemu-iotests/273.out     |   4 +-
 tests/qemu-iotests/iotests.py  |  10 +-
 43 files changed, 1591 insertions(+), 442 deletions(-)

-- 
2.26.2


