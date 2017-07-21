Received: from eggs.gnu.org ([2001:4830:134:3::10]:39116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYcjU-0007VC-GU
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYcjT-0003yf-L1
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:33:00 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 21 Jul 2017 13:32:43 -0500
Message-Id: <20170721183243.22706-3-eblake@redhat.com>
In-Reply-To: <20170721183243.22706-1-eblake@redhat.com>
References: <20170721183243.22706-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qcow2: Fix sector calculation in
 qcow2_measure()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

We used MAX() instead of the intended MIN() when computing how many
sectors to view in the current loop iteration of qcow2_measure(),
and passed in a value of INT_MAX sectors instead of our more usual
limit of BDRV_REQUEST_MAX_SECTORS (the latter avoids 32-bit overflow
on conversion to bytes).  For small files, the bug is harmless:
bdrv_get_block_status_above() clamps its *pnum answer to the BDS
size, regardless of any insanely larger input request.  However, for
any file at least 2T in size, we can very easily end up going into an
infinite loop (the maximum of 0x100000000 sectors and INT_MAX is a
64-bit quantity, which becomes 0 when assigned to int; once nb_sectors
is 0, we never make progress).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 048df7e88b..d7c600b5a2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3670,8 +3670,8 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
             for (sector_num = 0;
                  sector_num < ssize / BDRV_SECTOR_SIZE;
                  sector_num += pnum) {
-                int nb_sectors = MAX(ssize / BDRV_SECTOR_SIZE - sector_num,
-                                     INT_MAX);
+                int nb_sectors = MIN(ssize / BDRV_SECTOR_SIZE - sector_num,
+                                     BDRV_REQUEST_MAX_SECTORS);
                 BlockDriverState *file;
                 int64_t ret;

-- 
2.13.3
