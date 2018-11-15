Received: from eggs.gnu.org ([2001:4830:134:3::10]:53473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70c-0002AU-6X
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70Y-0005bw-Vv
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:03:54 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 14 Nov 2018 20:03:21 -0600
Message-Id: <20181115020334.1189829-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-4.0 00/13] block: byte-based blocking
 read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

Based-on: <20181114210548.1098207-1-eblake@redhat.com>
[file-posix: Better checks of 64-bit copy_range]
Based-on: <20181101182738.70462-1-vsementsov@virtuozzo.com>
[0/7 qcow2 decompress in threads] - more specifically, on Kevin's block-next branch

Also available at
https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/block-byte-blocking-v2

This series is a logical followup to other byte-based cleanups I have
done. The only remaining mention of sectors in public block.h APIs after
this series are in bdrv_nb_sectors() (converting those callser to use
bdrv_getlength() not only requires more work, but would be our
opportunity to see if we can quit rounding block sizes up beyond
request_align sizes for protocols that support sub-sector sizes), and
for computing geometries (where sectors actually make sense).

v1 was: https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg04686.html
Since then:

- fold in a straggler patch that dropped from my v8 qcow2 compression
series for 3.1
- improve commit message of 4/13, to show what auditing I performed [Berto]
- based on that audit, add a lot more patches to change bl.max_transfer
to be guaranteed non-zero and allow > 2G values where safe (note that
the block layer still fragments < 2G, so a larger advertisement doesn't
actually cause large read/write transactions)

001/13:[0005] [FC] 'qcow2: Prefer byte-based calls into bs->file'
002/13:[----] [--] 'vdi: Switch to byte-based calls'
003/13:[----] [--] 'vvfat: Switch to byte-based calls'
004/13:[----] [--] 'block: Removed unused sector-based blocking I/O'
005/13:[down] 'block: Switch to 64-bit bl.max_transfer'
006/13:[down] 'blkdebug: Audit for read/write 64-bit cleanness'
007/13:[down] 'blklogwrites: Audit for read/write 64-bit cleanness'
008/13:[down] 'crypto: Audit for read/write 64-bit cleanness'
009/13:[down] 'RFC: crypto: Rely on block layer for fragmentation'
010/13:[down] 'file-posix: Audit for read/write 64-bit cleanness'
011/13:[down] 'qcow2: Audit for read/write 64-bit cleanness'
012/13:[down] 'block: Document need for audit of read/write 64-bit cleanness'
013/13:[down] 'block: Enforce non-zero bl.max_transfer'

Patch 9/13 is marked RFC; if we like it, I'd rather squash 8 and 9
into a single patch; if we don't like it, it can be dropped without
affecting the rest of the series.

Eric Blake (13):
  qcow2: Prefer byte-based calls into bs->file
  vdi: Switch to byte-based calls
  vvfat: Switch to byte-based calls
  block: Removed unused sector-based blocking I/O
  block: Switch to 64-bit bl.max_transfer
  blkdebug: Audit for read/write 64-bit cleanness
  blklogwrites: Audit for read/write 64-bit cleanness
  crypto: Audit for read/write 64-bit cleanness
  RFC: crypto: Rely on block layer for fragmentation
  file-posix: Audit for read/write 64-bit cleanness
  qcow2: Audit for read/write 64-bit cleanness
  block: Document need for audit of read/write 64-bit cleanness
  block: Enforce non-zero bl.max_transfer

 qapi/block-core.json      |  2 +-
 include/block/block.h     |  4 --
 include/block/block_int.h | 10 +++--
 block/io.c                | 68 +++++++++++----------------------
 block/blkdebug.c          | 17 +++------
 block/blklogwrites.c      |  1 +
 block/bochs.c             |  1 +
 block/cloop.c             |  1 +
 block/crypto.c            | 79 +++++++++++++++------------------------
 block/dmg.c               |  1 +
 block/file-posix.c        |  3 ++
 block/file-win32.c        |  2 +
 block/qcow.c              |  1 +
 block/qcow2-refcount.c    |  6 +--
 block/qcow2.c             |  1 +
 block/rbd.c               |  1 +
 block/vdi.c               | 14 +++----
 block/vvfat.c             | 21 ++++++-----
 block/vxhs.c              |  1 +
 19 files changed, 98 insertions(+), 136 deletions(-)

-- 
2.17.2
