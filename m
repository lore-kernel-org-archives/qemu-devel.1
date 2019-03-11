Received: from eggs.gnu.org ([209.51.188.92]:56228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3Q1h-0004rD-1e
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3Q1g-0005N5-4I
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:51:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Mar 2019 21:51:44 +0300
Message-Id: <20190311185147.52309-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190311185147.52309-1-vsementsov@virtuozzo.com>
References: <20190311185147.52309-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/4] docs/interop/qcow2: Improve bitmap flag
 in_use specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com, eblake@redhat.com, den@virtuozzo.com

We already use (we didn't notice it) IN_USE flag for marking bitmap
metadata outdated, such as AUTO flag, which mirrors enabled/disabled
bitmaps. No we are going to support bitmap resize, so it's good to
write IN_USE meaning with more details.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 docs/interop/qcow2.txt | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index fb5cb47245..575a5f25e2 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -589,7 +589,19 @@ Structure of a bitmap directory entry:
                     Bit
                       0: in_use
                          The bitmap was not saved correctly and may be
-                         inconsistent.
+                         inconsistent. This inconsitency may touch both bitmap
+                         data and metadata, and this mean that bitmap state
+                         (its data and metadata) was changed but not stored
+                         back to the image. This flag doesn't relate to format
+                         corruption, all fields are still correct from qcow2
+                         point of view, they just may be outdated.
+
+                         Note: Currently, Qemu may change (additionally to
+                         bitmap data) @auto flag and size of the bitmap during
+                         image resize. This mean, that not only bitmap data
+                         may be outdated if @in_use flag set, but also value of
+                         @auto flag and bitmap size (which is indirectly
+                         referenced by @bitmap_table_size).
 
                       1: auto
                          The bitmap must reflect all changes of the virtual
@@ -717,8 +729,8 @@ corresponding range of the virtual disk (see above) was written to while the
 bitmap was 'enabled'. An unset bit means that this range was not written to.
 
 The software doesn't have to sync the bitmap in the image file with its
-representation in RAM after each write. Flag 'in_use' should be set while the
-bitmap is not synced.
+representation in RAM after each write or metadata change. Flag 'in_use'
+should be set while the bitmap is not synced.
 
 In the image file the 'enabled' state is reflected by the 'auto' flag. If this
 flag is set, the software must consider the bitmap as 'enabled' and start
-- 
2.18.0
