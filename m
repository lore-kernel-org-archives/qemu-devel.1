Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EC5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE4820679
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U803/jW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE4820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTpN-0006cU-Gn
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiE-0005as-60
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:22:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58123
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiB-0000kF-HW
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/WZmL2Joxor7HYuLRHzoNFWWzAN09lJG95MdJlcxD7k=;
 b=U803/jW5e+ToEvhrn76GxcWA+r8zAcTSacbPqff5OQ3/CnglOUJwabFa69NjXoCyZ8uWmB
 laGtXJQOoFrP718SrjUFt9q94gc6h+4UjoUuKMHvTrVwGzPBHvnajbaSjRd8Y9LGBL8GxX
 rzIIoDasdXzrJQIWuQskSNEpvgFNjyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-IsdbFXTsOz6trisVRp4DCQ-1; Thu, 25 Jun 2020 11:22:18 -0400
X-MC-Unique: IsdbFXTsOz6trisVRp4DCQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFE6B800C64;
 Thu, 25 Jun 2020 15:22:17 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2754011A9D8;
 Thu, 25 Jun 2020 15:22:17 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 00/47] block: Deal with filters
Date: Thu, 25 Jun 2020 17:21:28 +0200
Message-Id: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v6: https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg01715.html

Branch: https://github.com/XanClic/qemu.git child-access-functions-v7
Branch: https://git.xanclic.moe/XanClic/qemu.git child-access-functions-v7


Hello!

This is v7.  Conceptually, not much has changed, so please follow the
above link to v6’s cover letter if you’re looking for an introduction
to this series.

I did say that conceptually, not much has changed, but from a diff
standpoint, a lot has changed all over this series.


Changes from v6:
- Patch 1:
  - More elaborate explanation of .is_filter
  - Changed function names
  - Dropped bdrv_storage_child() and bdrv_metadata_child()
  - Some checking of the BdrvChildRole

- Patch 2:
  - Mostly changes resulting from the different naming scheme

- Patch 3: New

- Patch 5:
  - Don’t rename those functions
  - Don’t drop a comment that shouldn’t be dropped

- Patch 7:
  - Use block_driver_can_compress()
  - Move setting @filtered down where it’s needed

- Patches 10 and 11: New (extension of 8 and 9)

- Patch 12:
  - Function name changes
  - More cases:
    - bdrv_recurse_can_replace()
    - init_dirty_bitmap_migration()
  - bdrv_co_truncate() has changed

- Patch 13:
  - Function name changes

- Patch 14:
  - Variables renamed to be more consistent with the rest of this series
  - Function name changes
  - The freeze backing chain functions haven’t been renamed
  - STREAM_BUFFER_SIZE is STREAM_CHUNK as of some point last year
  - Fix overlay finding (e.g. handle when @base is not in the device’s
    backing chain)

- Patch 15:
  - Added note to the commit message that bdrv_find_overlay()’s behavior
    changes a bit
  - Function name changes
  - Restructured bdrv_find_backing_image() loop a bit

- Patch 16: New (became necessary because of truncate having to look at
            the backing file as of 955c7d6687fefcd903900)

- Patch 17:
  - Function name changes
  - The freeze backing chain functions haven’t been renamed

- Patch 18:
  - Only flush children for which the parent has taken the WRITE
    permission
  - Mention that this is a bug fix for qcow2

- Patch 19: New

- Patch 20: New, replaces “block: Use CAFs in bdrv_refresh_limits()”

- Patch 23:
  - We can only really fall back to bs->file or bs->backing, so stop
    pretending otherwise

- Patch 24:
  - Rebase conflicts

- Patches 25, 26, 27, and 28: New, they replace “block: Fix
  bdrv_get_allocated_file_size's fallback”

- Patch 29:
  - Function name changes

- Patch 30: New, split out from the next patch

- Patch 31:
  - Function name changes
  - bdrv_skip_implicit_filters() can deal with NULL arguments, so don’t
    wrap it in an “if (bs) {}” block
  - For bdrv_query_bds_stats(), the bs->file part has been split into
    the preceding patch (patch 30)
  - Addional actual-size line in the iotest output thanks to patch 28

- Patch 32: New

- Patch 33:
  - Additional note in the QAPI documentation concerning @replaces (that
    by default, the first non-implicit node on @device is replaced)
    - Move that skippage of implicit nodes to blockdev_mirror_common()
      (from qmp_drive_mirror() and qmp_blockdev_mirror())
  - Function name changes
  - Rename s/source/target_backing_bs/ in qmp_drive_mirror(), because
    that’s better
  - Don’t disallow mirroring through filters with sync=top

- Patch 34:
  - Function name changes
  - There is backup-top.c to care about, too, now

- Patch 35:
  - Function name changes
  - Call bdrv_commit() even for nodes that do not have backing files so
    we get an error
  - s/above_base/base_overlay/

- Patch 36:
  - Function name changes

- Patch 37:
  - Function name changes
  - In img_convert(), when inquiring target_backing_sectors, use
    bdrv_backing_chain_next() instead of bdrv_cow_bs() (because @out_bs
    may be a filter)
  - Forgot to use the backing file of @unfiltered_bs for
    bdrv_is_allocated_above() in img_rebase() (instead of @unfiltered_bs
    itself), fixed

- Patch 39:
  - Function name changes

- Patch 40:
  - Function name changes
  - There are backup-top and filter-compress now

- Patch 41:
  - Make bdrv_backing_overridden() globally available, so block/qapi.c
    can use it to determine whether we can inquire bs->backing’s format
    to get the backing_format
  - Function name changes

- Patch 42: New

- Patch 43:
  - Rebase conflicts

- Patch 44:
  - Create a dedicated do_test_io() function
  - Don’t unnecessarily clear and pass has_quit
  - Drop assert_no_active_block_jobs() that does very little
  - Additional graph constraint check
  - Rebase conflict in the reference output

- Patch 45:
  - Rebase conflict in the reference output

- Patch 46:
  - Use _rm_test_img rather than rm -f
  - Skip one of the test cases when IMGOPTS asks for a data_file

- Patch 47:
  - Rebase conflict in the reference output


Patches removed:
- The whole check_to_replace_node() stuff for mirror (was its own
  series)

- Making bdrv_get_cumulative_perm() public, because it already was

- bdrv_storage_child() (was replaced by child roles)


git-backport-diff against v6:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/47:[0126] [FC] 'block: Add child access functions'
002/47:[0032] [FC] 'block: Add chain helper functions'
003/47:[down] 'block: bdrv_cow_child() for bdrv_has_zero_init()'
004/47:[----] [-C] 'block: bdrv_set_backing_hd() is about bs->backing'
005/47:[0067] [FC] 'block: Include filters when freezing backing chain'
006/47:[----] [--] 'block: Drop bdrv_is_encrypted()'
007/47:[0005] [FC] 'block: Add bdrv_supports_compressed_writes()'
008/47:[----] [-C] 'throttle: Support compressed writes'
009/47:[----] [--] 'copy-on-read: Support compressed writes'
010/47:[down] 'mirror-top: Support compressed writes'
011/47:[down] 'backup-top: Support compressed writes'
012/47:[0036] [FC] 'block: Use bdrv_filtered_rw* where obvious'
013/47:[0010] [FC] 'block: Use CAFs in block status functions'
014/47:[0079] [FC] 'stream: Deal with filters'
015/47:[0015] [FC] 'block: Use CAFs when working with backing chains'
016/47:[down] 'block: Use bdrv_cow_child() in bdrv_co_truncate()'
017/47:[0019] [FC] 'block: Re-evaluate backing file handling in reopen'
018/47:[0010] [FC] 'block: Flush all children in generic code'
019/47:[down] 'vmdk: Drop vmdk_co_flush()'
020/47:[down] 'block: Iterate over children in refresh_limits'
021/47:[----] [--] 'block: Use CAFs in bdrv_refresh_filename()'
022/47:[----] [--] 'block: Use CAF in bdrv_co_rw_vmstate()'
023/47:[0094] [FC] 'block/snapshot: Fix fallback'
024/47:[0014] [FC] 'block: Use CAFs for debug breakpoints'
025/47:[down] 'block: Def. impl.s for get_allocated_file_size'
026/47:[down] 'block: Improve get_allocated_file_size's default'
027/47:[down] 'blkverify: Use bdrv_sum_allocated_file_size()'
028/47:[down] 'block/null: Implement bdrv_get_allocated_file_size'
029/47:[0002] [FC] 'blockdev: Use CAF in external_snapshot_prepare()'
030/47:[down] 'block: Report data child for query-blockstats'
031/47:[0031] [FC] 'block: Use child access functions for QAPI queries'
032/47:[down] 'block-copy: Use CAF to find sync=top base'
033/47:[0086] [FC] 'mirror: Deal with filters'
034/47:[0006] [FC] 'backup: Deal with filters'
035/47:[0035] [FC] 'commit: Deal with filters'
036/47:[0002] [FC] 'nbd: Use CAF when looking for dirty bitmap'
037/47:[0017] [FC] 'qemu-img: Use child access functions'
038/47:[----] [--] 'block: Drop backing_bs()'
039/47:[0002] [FC] 'blockdev: Fix active commit choice'
040/47:[0009] [FC] 'block: Inline bdrv_co_block_status_from_*()'
041/47:[0019] [FC] 'block: Leave BDS.backing_file constant'
042/47:[down] 'iotests: Test that qcow2's data-file is flushed'
043/47:[0016] [FC] 'iotests: Let complete_and_wait() work with commit'
044/47:[0042] [FC] 'iotests: Add filter commit test cases'
045/47:[0008] [FC] 'iotests: Add filter mirror test cases'
046/47:[0018] [FC] 'iotests: Add test for commit in sub directory'
047/47:[0008] [FC] 'iotests: Test committing to overridden backing'


Max Reitz (47):
  block: Add child access functions
  block: Add chain helper functions
  block: bdrv_cow_child() for bdrv_has_zero_init()
  block: bdrv_set_backing_hd() is about bs->backing
  block: Include filters when freezing backing chain
  block: Drop bdrv_is_encrypted()
  block: Add bdrv_supports_compressed_writes()
  throttle: Support compressed writes
  copy-on-read: Support compressed writes
  mirror-top: Support compressed writes
  backup-top: Support compressed writes
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
  block: Def. impl.s for get_allocated_file_size
  block: Improve get_allocated_file_size's default
  blkverify: Use bdrv_sum_allocated_file_size()
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
  block: Leave BDS.backing_file constant
  iotests: Test that qcow2's data-file is flushed
  iotests: Let complete_and_wait() work with commit
  iotests: Add filter commit test cases
  iotests: Add filter mirror test cases
  iotests: Add test for commit in sub directory
  iotests: Test committing to overridden backing

 qapi/block-core.json           |  10 +-
 include/block/block.h          |   2 +-
 include/block/block_int.h      |  99 ++++---
 block.c                        | 500 +++++++++++++++++++++++++++------
 block/backup-top.c             |  14 +-
 block/backup.c                 |   9 +-
 block/blkdebug.c               |   7 +-
 block/blklogwrites.c           |   1 -
 block/blkverify.c              |   1 +
 block/block-backend.c          |   9 +-
 block/block-copy.c             |   4 +-
 block/commit.c                 |  97 +++++--
 block/copy-on-read.c           |  13 +-
 block/filter-compress.c        |   2 -
 block/io.c                     | 142 +++++-----
 block/mirror.c                 | 129 +++++++--
 block/monitor/block-hmp-cmds.c |   2 +-
 block/null.c                   |   7 +
 block/qapi.c                   |  83 ++++--
 block/snapshot.c               | 104 +++++--
 block/stream.c                 |  63 +++--
 block/throttle.c               |  11 +-
 block/vmdk.c                   |  16 --
 blockdev.c                     |  94 +++++--
 migration/block-dirty-bitmap.c |   8 +-
 nbd/server.c                   |   6 +-
 qemu-img.c                     |  36 ++-
 tests/qemu-iotests/020         |  44 +++
 tests/qemu-iotests/020.out     |  10 +
 tests/qemu-iotests/040         | 238 ++++++++++++++++
 tests/qemu-iotests/040.out     |   4 +-
 tests/qemu-iotests/041         | 146 +++++++++-
 tests/qemu-iotests/041.out     |   4 +-
 tests/qemu-iotests/153.out     |   2 +-
 tests/qemu-iotests/184.out     |  14 +-
 tests/qemu-iotests/204.out     |   1 +
 tests/qemu-iotests/228         |   6 +-
 tests/qemu-iotests/228.out     |   6 +-
 tests/qemu-iotests/244         |  49 ++++
 tests/qemu-iotests/244.out     |   7 +
 tests/qemu-iotests/245         |   4 +-
 tests/qemu-iotests/iotests.py  |  10 +-
 42 files changed, 1602 insertions(+), 412 deletions(-)

-- 
2.26.2


