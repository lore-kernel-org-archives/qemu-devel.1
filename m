Received: from eggs.gnu.org ([2001:4830:134:3::10]:48039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fPqFz-0003yd-Gd
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fPqFy-0004hU-Q5
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:14:47 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  4 Jun 2018 16:14:36 +0200
Message-Id: <20180604141437.22758-2-mreitz@redhat.com>
In-Reply-To: <20180604141437.22758-1-mreitz@redhat.com>
References: <20180604141437.22758-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] qcow2: Do not mark inactive images corrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

When signaling a corruption on a read-only image, qcow2 already makes
fatal events non-fatal (i.e., they will not result in the image being
closed, and the image header's corrupt flag will not be set).  This is
necessary because we cannot set the corrupt flag on read-only images,
and it is possible because further corruption of read-only images is
impossible.

Inactive images are effectively read-only, too, so we should do the same
for them.

(Otherwise, the assert(!(bs->open_flags & BDRV_O_INACTIVE)) in
bdrv_co_pwritev() will fail, crashing qemu.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 59a38b9cd3..8b5f7386f7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4402,7 +4402,9 @@ void qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
     char *message;
     va_list ap;
 
-    fatal = fatal && !bs->read_only;
+    if ((bs->open_flags & (BDRV_O_RDWR | BDRV_O_INACTIVE)) != BDRV_O_RDWR) {
+        fatal = false;
+    }
 
     if (s->signaled_corruption &&
         (!fatal || (s->incompatible_features & QCOW2_INCOMPAT_CORRUPT)))
-- 
2.17.0
