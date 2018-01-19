Received: from eggs.gnu.org ([2001:4830:134:3::10]:57878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ecW7o-0006lU-37
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:50:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ecW7k-00036S-UO
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:50:28 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 19 Jan 2018 15:49:59 +0300
Message-Id: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/8] discard blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@virtuozzo.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

v2: - rebased on top of series 'ide: abort TRIM operation for invalid range'
      (http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg01432.html)
      Now invalid trim requests are properly accounted

    - patches 1/2 - qapi fields regrouped together

v1: http://lists.nongnu.org/archive/html/qemu-devel/2017-11/msg03664.html

----

qmp query-blockstats provides stats info for write/read/flush ops.

Patches 1-5 implement the similar for discard (unmap) command for scsi
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
(patch 7).
With patch 6, file-posix driver accounts discard operations on its level too.

query-blockstat result:

(note the difference between blockdevice unmap and file discard stats. qcow2
sends a few ops down to the file as the clusters are actually unallocated
on qcow2 level)

{"return": [
{"device": "drive-scsi0-0-0-0"
  "parent": {
    "stats": {
>      "unmap_operations": 0
>      "unmap_merged": 0
      "flush_total_time_ns": 0
      "wr_highest_offset": 8111718400
      [..]
      "invalid_wr_operations": 0
      "invalid_rd_operations": 0}
    "node-name": "#block047"
>    "driver_stats": {
>      "type": "file"
>      "data": {
>        "discard_bytes_ok": 1572864
>        "discard_nb_failed": 0
>        "discard_nb_ok": 5}}}
  "stats": {
>   "unmap_operations": 472
>   "unmap_merged": 0
    "flush_total_time_ns": 44530540
    "wr_highest_offset": 7106662400
    "wr_total_time_ns": 45518856
    "failed_wr_operations": 0
    "failed_rd_operations": 0
    "wr_merged": 0
    "wr_bytes": 889856
    "timed_stats": []
>    "failed_unmap_operations": 0
    "failed_flush_operations": 0
    "account_invalid": true
    "rd_total_time_ns": 3306264098
>    "invalid_unmap_operations": 0
    "flush_operations": 18
    "wr_operations": 120
>    "unmap_bytes": 12312014848
    "rd_merged": 0
    "rd_bytes": 137103360
>    "unmap_total_time_ns": 22664692
    "invalid_flush_operations": 0
    "account_failed": true
    "idle_time_ns": 437316567
    "rd_operations": 5636
    "invalid_wr_operations": 0
    "invalid_rd_operations": 0}
  "node-name": "#block128"}

  {"device": "drive-ide0-0-0"
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

 qapi/block-core.json       | 78 ++++++++++++++++++++++++++++++++++++++++++----
 include/block/accounting.h |  1 +
 include/block/block.h      |  1 +
 include/block/block_int.h  |  1 +
 block.c                    |  9 ++++++
 block/file-posix.c         | 42 +++++++++++++++++++++++--
 block/qapi.c               | 11 +++++++
 hw/ide/core.c              | 13 ++++++++
 hw/scsi/scsi-disk.c        | 29 ++++++++++-------
 9 files changed, 166 insertions(+), 19 deletions(-)

-- 
2.7.4
