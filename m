Received: from eggs.gnu.org ([2001:4830:134:3::10]:43924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQeF8-00037v-Jx
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQeF7-00081V-Ps
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:37:14 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  6 Jun 2018 21:37:01 +0200
Message-Id: <20180606193702.7113-3-mreitz@redhat.com>
In-Reply-To: <20180606193702.7113-1-mreitz@redhat.com>
References: <20180606193702.7113-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] qcow2: Do not mark inactive images
 corrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>

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
---
 block/qcow2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 6b2d88759d..6fa5e1d71a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4569,7 +4569,7 @@ void qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
     char *message;
     va_list ap;
 
-    fatal = fatal && !bs->read_only;
+    fatal = fatal && bdrv_is_writable(bs);
 
     if (s->signaled_corruption &&
         (!fatal || (s->incompatible_features & QCOW2_INCOMPAT_CORRUPT)))
-- 
2.17.0
