Received: from eggs.gnu.org ([2001:4830:134:3::10]:58838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTpbL-0005q9-S4
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTpbK-0003TK-Qv
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:21:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 15 Jun 2018 16:20:43 +0200
Message-Id: <20180615142108.27814-2-kwolf@redhat.com>
In-Reply-To: <20180615142108.27814-1-kwolf@redhat.com>
References: <20180615142108.27814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/26] qemu-img: Fix assert when mapping
 unaligned raw file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

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
---
 qemu-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 1dcdd47254..e1a506f7f6 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2906,7 +2906,7 @@ static int img_map(int argc, char **argv)
         int64_t n;
 
         /* Probe up to 1 GiB at a time.  */
-        n = QEMU_ALIGN_DOWN(MIN(1 << 30, length - offset), BDRV_SECTOR_SIZE);
+        n = MIN(1 << 30, length - offset);
         ret = get_block_status(bs, offset, n, &next);
 
         if (ret < 0) {
-- 
2.13.6
