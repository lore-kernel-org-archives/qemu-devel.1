Received: from eggs.gnu.org ([2001:4830:134:3::10]:44282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1db53n-0007fW-Es
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1db53m-00048M-H2
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:12:07 -0400
From: Olaf Hering <olaf@aepfle.de>
Date: Fri, 28 Jul 2017 15:11:51 +0200
Message-Id: <20170728131151.4802-1-olaf@aepfle.de>
Subject: [Qemu-devel] [PATCH v2] xen-disk: use g_new0 to fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Olaf Hering <olaf@aepfle.de>

g_malloc0_n is available since glib-2.24. To allow build with older glib
versions use the generic g_new0, which is already used in many other
places in the code.

Fixes commit 3284fad728 ("xen-disk: add support for multi-page shared rings")

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 hw/block/xen_disk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index d42ed7070d..536e2ee735 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -1232,7 +1232,7 @@ static int blk_connect(struct XenDevice *xendev)
         return -1;
     }
 
-    domids = g_malloc0_n(blkdev->nr_ring_ref, sizeof(uint32_t));
+    domids = g_new0(uint32_t, blkdev->nr_ring_ref);
     for (i = 0; i < blkdev->nr_ring_ref; i++) {
         domids[i] = blkdev->xendev.dom;
     }
