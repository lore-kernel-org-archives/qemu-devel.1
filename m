Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4CAC73C63
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 23:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A212082A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 23:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A212082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkzY9-0000x1-UQ
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 19:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48684)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hkzVD-0007Fu-RL
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 19:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hkzVB-00030A-M4
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 19:26:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hkzV4-0002Vk-TS; Tue, 09 Jul 2019 19:26:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E5FE82EED0F;
 Tue,  9 Jul 2019 23:25:56 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E12725B80B;
 Tue,  9 Jul 2019 23:25:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 19:25:32 -0400
Message-Id: <20190709232550.10724-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 09 Jul 2019 23:25:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 00/18] bitmaps: introduce 'bitmap' sync mode
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 John Snow <jsnow@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds a new "BITMAP" sync mode that is meant to replace the
existing "INCREMENTAL" sync mode.

This mode can have its behavior modified by issuing any of three bitmap s=
ync
modes, passed as arguments to the job.

The three bitmap sync modes are:
- ON-SUCCESS: This is an alias for the old incremental mode. The bitmap i=
s
              conditionally synchronized based on the return code of the =
job
              upon completion.
- NEVER: This is, effectively, the differential backup mode. It never cle=
ars
         the bitmap, as the name suggests.
- ALWAYS: Here is the new, exciting thing. The bitmap is always synchroni=
zed,
          even on failure. On success, this is identical to incremental, =
but
          on failure it clears only the bits that were copied successfull=
y.
          This can be used to "resume" incremental backups from later poi=
nts
          in times.

I wrote this series by accident on my way to implement incremental mode
for mirror, but this happened first -- the problem is that Mirror mode
uses its existing modes in a very particular way; and this was the best
way to add bitmap support into the mirror job properly.

Summary:
- 01-03: refactor blockdev-backup and drive-backup to share more interfac=
e code
- 04-05: add the new 'bitmap' sync mode with sync policy 'conditional',
         which is functionally identical to 'incremental' sync mode.
- 06:    add sync policy 'never' ("Differential" backups.)
- 07-11: rework some merging code to facilite patch 12;
- 12:    add sync policy 'always' ("Resumable" backups)
- 13-16: test infrastructure changes to support patch 16:
- 17:    new iotest!
- 18:    minor policy loosening as a QOL improvement

Future work:
 - Update bitmaps.rst to explain these. (WIP, it's hard, sorry!)
 - Add these modes to Mirror. (Done*, but needs tests.)
 - Allow the use of bitmaps and bitmap sync modes with non-BITMAP modes;
   This will allow for resumable/re-tryable full backups.

=3D=3D=3D
V4:
=3D=3D=3D

[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/18:[----] [--] 'qapi/block-core: Introduce BackupCommon'
002/18:[----] [--] 'drive-backup: create do_backup_common'
003/18:[----] [--] 'blockdev-backup: utilize do_backup_common'
004/18:[----] [--] 'qapi: add BitmapSyncMode enum'
005/18:[----] [--] 'block/backup: Add mirror sync mode 'bitmap''
006/18:[----] [--] 'block/backup: add 'never' policy to bitmap sync mode'
007/18:[----] [--] 'hbitmap: Fix merge when b is empty, and result is not=
 an alias of a'
008/18:[----] [--] 'hbitmap: enable merging across granularities'
009/18:[0004] [FC] 'block/dirty-bitmap: add bdrv_dirty_bitmap_merge_inter=
nal'
010/18:[----] [--] 'block/dirty-bitmap: add bdrv_dirty_bitmap_get'
011/18:[0008] [FC] 'block/backup: upgrade copy_bitmap to BdrvDirtyBitmap'
012/18:[----] [--] 'block/backup: add 'always' bitmap sync policy'
013/18:[----] [--] 'iotests: add testing shim for script-style python tes=
ts'
014/18:[----] [--] 'iotests: teach run_job to cancel pending jobs'
015/18:[----] [--] 'iotests: teach FilePath to produce multiple paths'
016/18:[----] [--] 'iotests: Add virtio-scsi device helper'
017/18:[0063] [FC] 'iotests: add test 257 for bitmap-mode backups'
018/18:[----] [--] 'block/backup: loosen restriction on readonly bitmaps'

Changes:
009: Added assertions.
011: Moved copy bitmap to source node.
017: Rework get_bitmap to tolerate multiple anonymous bitmaps
     Update test output to accommodate the same.

=3D=3D=3D
V3:
=3D=3D=3D

Changes:
001: Made suggested doc fixes.
     Changed 'since' to 4.2.
002: Added bds and aio_context to backup_common
     Removed accidental extraneous unref on target_bs
     Removed local_err propagation
003: Fallout from #002; hoist aio_context acquisition up into do_blockdev=
_backup
004: 'conditional' --> 'on-success'
005: Rediscover the lost stanza that ensures a bitmap mode was given
     Fallout from 2, 3, 4.
006: Block comment fix for patchew
     Fallout from #4
009: Fix assert() style issue. Why'd they let a macro be lowercase like t=
hat?
     Probably to make specifically my life difficult.
010: Fix style issue {
011: Fix long lines
     rename "bs" --> "target_bs" where appropriate
     Free copy_bitmap from the right node
012: Multiline comment changes for patchew
     Fallout from #4
015: Fix long line for patchew
     Reinstate that second newline that Max likes
017: Fallout from #4.

=3D=3D=3D
V2:
=3D=3D=3D

Changes:
004: Fixed typo
     Change @conditional docstring
005: Moved desugaring code into blockdev.c, facilitated by patches 1-3.
006: Change @never docstring slightly.
007: Merge will clear the target bitmap when both components bitmaps are =
empty,
     and the target bitmap is not an alias of either component bitmap.
008: Check orig_size (logical size) instead of size (actual size) to enab=
le
         cross-granularity merging.
     Fix the sparse merge itself, based on the block/backup code.
     Clear the target bitmap before cross-granularity merge.
     Assert the size is itself equal when logical size and granularities =
are
         equal.
---: Dropped bdrv_dirty_bitmap_claim.
012: Rewrote the cleanup logic to hopefully be clearer.
     use merge intsead of dropped reclaim.
015: Changed docstring
     factored out filename pattern generation.
017: Fix mkpattern indent.
     Use integer division!!!
     Add parenthesis to boolean assignment
     Change test run ordering; update output to reflect this
     Use virtio-scsi-ccw when appropriate
     Update test output to reflect new test running order
018: Fallout from patches 1-3; restrictions only need loosened in one pla=
ce
         instead of two.

Changes not made:
- Allowing 'cancel' to skip synchronization on cancel:
  Decided against it, opting for consistency. The user asked for a sync,
  and it's simpler logistically to execute on that desire.
  Use the new mode carefully, please!

John Snow (18):
  qapi/block-core: Introduce BackupCommon
  drive-backup: create do_backup_common
  blockdev-backup: utilize do_backup_common
  qapi: add BitmapSyncMode enum
  block/backup: Add mirror sync mode 'bitmap'
  block/backup: add 'never' policy to bitmap sync mode
  hbitmap: Fix merge when b is empty, and result is not an alias of a
  hbitmap: enable merging across granularities
  block/dirty-bitmap: add bdrv_dirty_bitmap_merge_internal
  block/dirty-bitmap: add bdrv_dirty_bitmap_get
  block/backup: upgrade copy_bitmap to BdrvDirtyBitmap
  block/backup: add 'always' bitmap sync policy
  iotests: add testing shim for script-style python tests
  iotests: teach run_job to cancel pending jobs
  iotests: teach FilePath to produce multiple paths
  iotests: Add virtio-scsi device helper
  iotests: add test 257 for bitmap-mode backups
  block/backup: loosen restriction on readonly bitmaps

 block/backup.c                |  135 +-
 block/dirty-bitmap.c          |   73 +-
 block/mirror.c                |    8 +-
 block/replication.c           |    2 +-
 blockdev.c                    |  208 ++-
 include/block/block_int.h     |    7 +-
 include/block/dirty-bitmap.h  |    4 +-
 migration/block.c             |    5 +-
 nbd/server.c                  |    2 +-
 qapi/block-core.json          |  138 +-
 tests/qemu-iotests/040        |    6 +-
 tests/qemu-iotests/093        |    6 +-
 tests/qemu-iotests/139        |    7 +-
 tests/qemu-iotests/238        |    5 +-
 tests/qemu-iotests/257        |  416 ++++++
 tests/qemu-iotests/257.out    | 2247 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group      |    1 +
 tests/qemu-iotests/iotests.py |  100 +-
 util/hbitmap.c                |   49 +-
 19 files changed, 3107 insertions(+), 312 deletions(-)
 create mode 100755 tests/qemu-iotests/257
 create mode 100644 tests/qemu-iotests/257.out

--=20
2.21.0


