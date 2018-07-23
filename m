Received: from eggs.gnu.org ([2001:4830:134:3::10]:41554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJB-0002L8-5c
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJA-0003vq-9x
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:53 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:48 -0500
Message-Id: <20180723201748.25573-40-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 39/99] qcow2: Do not mark inactive images
 corrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

When signaling a corruption on a read-only image, qcow2 already makes
fatal events non-fatal (i.e., they will not result in the image being
closed, and the image header's corrupt flag will not be set).  This is
necessary because we cannot set the corrupt flag on read-only images,
and it is possible because further corruption of read-only images is
impossible.

Inactive images are effectively read-only, too, so we should do the same
for them.  bdrv_is_writable() can tell us whether an image can actually
be written to, so use its result instead of !bs->read_only.

(Otherwise, the assert(!(bs->open_flags & BDRV_O_INACTIVE)) in
bdrv_co_pwritev() will fail, crashing qemu.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180606193702.7113-3-mreitz@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit ddf3b47ef4b5ed0bf6558d4c2c8ae130b8d8a580)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/qcow2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index ef68772aca..a2b2e5d4cd 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4386,7 +4386,7 @@ void qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
     char *message;
     va_list ap;
 
-    fatal = fatal && !bs->read_only;
+    fatal = fatal && bdrv_is_writable(bs);
 
     if (s->signaled_corruption &&
         (!fatal || (s->incompatible_features & QCOW2_INCOMPAT_CORRUPT)))
-- 
2.17.1
