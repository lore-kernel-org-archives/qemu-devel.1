Received: from eggs.gnu.org ([2001:4830:134:3::10]:60178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gSk4k-0005LW-QJ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gSk4f-0003zK-PL
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:47:26 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 30 Nov 2018 14:47:17 +0000
Message-ID: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v6 0/9] discard blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

new in v6:
    - since clauses -> 4.0
    - patch 9: qapi json cosmetic changes as suggested by Vladimir
    - patch 9: proper "driver" field setting for host_device driver

v5: http://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg06828.html
v4: http://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg04308.html
v3: http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg03688.html

----

qmp query-blockstats provides stats info for write/read/flush ops.

Patches 1-7 implement the similar for discard (unmap) command for scsi
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
(patch 9).
With patch 8, file-posix driver accounts discard operations on its level to=
o.

query-blockstat result:

(note the difference between blockdevice unmap and file discard stats. qcow=
2
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
         =20
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

Anton Nefedov (9):
  qapi: group BlockDeviceStats fields
  qapi: add unmap to BlockDeviceStats
  block: add empty account cookie type
  ide: account UNMAP (TRIM) operations
  scsi: store unmap offset and nb_sectors in request struct
  scsi: move unmap error checking to the complete callback
  scsi: account unmap operations
  file-posix: account discard operations
  qapi: query-blockstat: add driver specific file-posix stats

 qapi/block-core.json       | 81 ++++++++++++++++++++++++++++++++------
 include/block/accounting.h |  2 +
 include/block/block.h      |  1 +
 include/block/block_int.h  |  1 +
 block.c                    |  9 +++++
 block/accounting.c         |  6 +++
 block/file-posix.c         | 60 ++++++++++++++++++++++++++--
 block/qapi.c               | 11 ++++++
 hw/ide/core.c              | 12 ++++++
 hw/scsi/scsi-disk.c        | 32 +++++++++------
 tests/qemu-iotests/227.out | 18 +++++++++
 11 files changed, 208 insertions(+), 25 deletions(-)

--=20
2.17.1
