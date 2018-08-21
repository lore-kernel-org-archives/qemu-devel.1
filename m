Received: from eggs.gnu.org ([2001:4830:134:3::10]:48644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fs3FR-0003qo-1X
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fs3FL-0007rF-Sj
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:46:48 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 21 Aug 2018 12:46:11 +0300
Message-Id: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 0/8] discard blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

new in v4:
    - patch 7: discard and write-zeroes code paths had been separated in
      34fa110e: file-posix: Fix write_zeroes with unmap on block devices.
      This patch now only accounts discards that come explicitly
      through .bdrv_co_pdiscard handler.
    - qapi 'Since' clauses changed 3.0 -> 3.1

v3: http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg03688.html

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
  "return": [
    {
      "device": "drive-scsi0-0-0-0",
      "parent": {
>       "discard-bytes-ok": 262144,
>       "discard-nb-ok": 4,
        "stats": {
>         "unmap_operations": 0,
>         "unmap_merged": 0,
          "flush_total_time_ns": 0,
          "wr_highest_offset": 8111718400,
          "wr_total_time_ns": 0,
          "failed_wr_operations": 0,
          "failed_rd_operations": 0,
          "wr_merged": 0,
          "wr_bytes": 0,
          "timed_stats": [
            
          ],
>         "failed_unmap_operations": 0,
          "failed_flush_operations": 0,
          "account_invalid": false,
          "rd_total_time_ns": 0,
>         "invalid_unmap_operations": 0,
          "flush_operations": 0,
          "wr_operations": 0,
>         "unmap_bytes": 0,
          "rd_merged": 0,
          "rd_bytes": 0,
>         "unmap_total_time_ns": 0,
          "invalid_flush_operations": 0,
          "account_failed": false,
          "rd_operations": 0,
          "invalid_wr_operations": 0,
          "invalid_rd_operations": 0
        },
        "node-name": "#block012",
>       "driver": "file",
>       "discard-nb-failed": 0
      },
      "stats": {
>       "unmap_operations": 860,
>       "unmap_merged": 0,
        "flush_total_time_ns": 21506733,
        "wr_highest_offset": 13411741696,
        "wr_total_time_ns": 2212749334,
        "failed_wr_operations": 0,
        "failed_rd_operations": 0,
        "wr_merged": 0,
        "wr_bytes": 3426304,
        "timed_stats": [
          
        ],
>       "failed_unmap_operations": 0,
        "failed_flush_operations": 0,
        "account_invalid": true,
        "rd_total_time_ns": 3617478206,
>       "invalid_unmap_operations": 0,
        "flush_operations": 24,
        "wr_operations": 309,
>       "unmap_bytes": 11949633536,
        "rd_merged": 0,
        "rd_bytes": 141967360,
>       "unmap_total_time_ns": 14871816,
        [..]

Anton Nefedov (8):
  qapi: group BlockDeviceStats fields
  qapi: add unmap to BlockDeviceStats
  ide: account UNMAP (TRIM) operations
  scsi: store unmap offset and nb_sectors in request struct
  scsi: move unmap error checking to the complete callback
  scsi: account unmap operations
  file-posix: account discard operations
  qapi: query-blockstat: add driver specific file-posix stats

 qapi/block-core.json       | 82 +++++++++++++++++++++++++++++++++++++++-------
 include/block/accounting.h |  1 +
 include/block/block.h      |  1 +
 include/block/block_int.h  |  1 +
 block.c                    |  9 +++++
 block/file-posix.c         | 45 +++++++++++++++++++++++--
 block/qapi.c               | 11 +++++++
 hw/ide/core.c              | 12 +++++++
 hw/scsi/scsi-disk.c        | 29 +++++++++-------
 tests/qemu-iotests/227.out | 18 ++++++++++
 10 files changed, 184 insertions(+), 25 deletions(-)

-- 
2.7.4
