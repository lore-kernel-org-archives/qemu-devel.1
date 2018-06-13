Received: from eggs.gnu.org ([2001:4830:134:3::10]:59345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fT9pF-0003LD-Hk
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fT9pC-0006yh-AV
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:44:53 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed, 13 Jun 2018 20:44:18 +0300
Message-Id: <1528911866-37489-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/8] discard blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, eblake@redhat.com, berto@igalia.com, den@virtuozzo.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

new in v3:
    - based on qapi series:
      (http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg03638.html)
    - qapi 'Since' clauses changed 2.12 -> 3.0 (RB tags not stripped)
    - patch 3 rebase: ide_issue_trim_cb invalid path has changed, so
      block_acct_invalid() is moved to ide_dma_cb
    - patch 8: BlockDriverStats union made flat and renamed (BlockStatsSpecific)

v2: - http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg04795.html

----

qmp query-blockstats provides stats info for write/read/flush ops.

Patches 1-6 implement the similar for discard (unmap) command for scsi
and ide disks.
Discard stat "unmap_ops / unmap_bytes" is supposed to account the ops that
have completed without an error.

However, discard operation is advisory. Specifically,
 - common block layer ignores ENOTSUP error code.
   That might be returned if the block driver does not support discard,
   or discard has been configured to be ignored.
 - format drivers such as qcow2 may ignore discard if they were configured
   to ignore that, or if the corresponding area is already marked unused
   (unallocated / zero clusters).

And what is actually useful is the number of bytes actually discarded
down on the host filesystem.
To achieve that, driver-specific statistics has been added to blockstats
(patch 8).
With patch 7, file-posix driver accounts discard operations on its level too.

query-blockstat result:

(note the difference between blockdevice unmap and file discard stats. qcow2
sends fewer ops down to the file as the clusters are actually unallocated
on qcow2 level)

    {
      "device": "drive-scsi0-0-0-0",
      "node-name": "#block159",
      "stats": {
>       "invalid_unmap_operations": 0,
>       "failed_unmap_operations": 0,
        "wr_highest_offset": 13411688448,
        "rd_total_time_ns": 2859566315,
        "rd_bytes": 103182336,
        "rd_merged": 0,
        "flush_operations": 19,
        "invalid_wr_operations": 0,
        "flush_total_time_ns": 23111608,
        "failed_rd_operations": 0,
        "failed_flush_operations": 0,
        "invalid_flush_operations": 0,
        "timed_stats": [
          
        ],
        "wr_merged": 0,
        "wr_bytes": 1702912,
>       "unmap_bytes": 11954954240,
>       "unmap_operations": 865,
        "idle_time_ns": 2669508623,
        "account_invalid": true,
>       "unmap_total_time_ns": 19698002,
        "wr_operations": 143,
        "failed_wr_operations": 0,
        "rd_operations": 4816,
        "account_failed": true,
>       "unmap_merged": 0,
        "wr_total_time_ns": 1262686124,
        "invalid_rd_operations": 0
      },
      "parent": {
>       "driver-specific": {
>         "discard-nb-failed": 0,
>         "discard-bytes-ok": 720896,
>         "driver": "file",
>         "discard-nb-ok": 8
>       },
        "node-name": "#block009",
        "stats": {
        [..]
        }
      }
    },
    {
      "device": "floppy0",


Anton Nefedov (8):
  qapi: group BlockDeviceStats fields
  qapi: add unmap to BlockDeviceStats
  ide: account UNMAP (TRIM) operations
  scsi: store unmap offset and nb_sectors in request struct
  scsi: move unmap error checking to the complete callback
  scsi: account unmap operations
  file-posix: account discard operations
  qapi: query-blockstat: add driver specific file-posix stats

 qapi/block-core.json       | 90 ++++++++++++++++++++++++++++++++++++++++------
 include/block/accounting.h |  1 +
 include/block/block.h      |  1 +
 include/block/block_int.h  |  1 +
 block.c                    |  9 +++++
 block/file-posix.c         | 38 ++++++++++++++++++--
 block/qapi.c               | 11 ++++++
 hw/ide/core.c              | 12 +++++++
 hw/scsi/scsi-disk.c        | 29 +++++++++------
 9 files changed, 168 insertions(+), 24 deletions(-)

-- 
2.7.4
