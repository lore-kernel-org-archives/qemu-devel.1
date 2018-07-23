Received: from eggs.gnu.org ([2001:4830:134:3::10]:41895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJU-0002g6-8V
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJT-0004SH-8i
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:12 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:56 -0500
Message-Id: <20180723201748.25573-48-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 47/99] qemu-img: Fix assert when mapping
 unaligned raw file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: Eric Blake <eblake@redhat.com>

Commit a290f085 exposed a latent bug in qemu-img map introduced
during the conversion of block status to be byte-based.  Earlier in
commit 5e344dd8, the internal interface get_block_status() switched
to take byte-based parameters, but still called a sector-based
block layer function; as such, rounding was added in the lone
caller to obey the contract.  However, commit 237d78f8 changed
get_block_status() to truly be byte-based, at which point rounding
to sector boundaries can result in calling bdrv_block_status() with
'bytes == 0' (a coding error) when the boundary between data and a
hole falls mid-sector (true for the past-EOF implicit hole present
in POSIX files).  Fix things by removing the rounding that is now
no longer necessary.

See also https://bugzilla.redhat.com/1589738

Fixes: 237d78f8
Reported-by: Dan Kenigsberg <danken@redhat.com>
Reported-by: Nir Soffer <nsoffer@redhat.com>
Reported-by: Maor Lipchuk <mlipchuk@redhat.com>
CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit e0b371ed5e2db079051139136fd0478728b6a58f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qemu-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index b422fda6f3..a8e2b53dc6 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2827,7 +2827,7 @@ static int img_map(int argc, char **argv)
         int64_t n;
 
         /* Probe up to 1 GiB at a time.  */
-        n = QEMU_ALIGN_DOWN(MIN(1 << 30, length - offset), BDRV_SECTOR_SIZE);
+        n = MIN(1 << 30, length - offset);
         ret = get_block_status(bs, offset, n, &next);
 
         if (ret < 0) {
-- 
2.17.1
