Received: from eggs.gnu.org ([2001:4830:134:3::10]:34610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dur8G-0002Sa-TY
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 22:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dur8F-0008CF-T6
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 22:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dur8F-0008Bk-N7
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 22:22:27 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Wed, 20 Sep 2017 19:22:23 -0700
Message-Id: <1505960544-12202-1-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1709201906040.2968@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1709201906040.2968@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL 1/2] xen-disk: use g_new0 to fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Olaf Hering <olaf@aepfle.de>

From: Olaf Hering <olaf@aepfle.de>

g_malloc0_n is available since glib-2.24. To allow build with older glib
versions use the generic g_new0, which is already used in many other
places in the code.

Fixes commit 3284fad728 ("xen-disk: add support for multi-page shared rings")

Signed-off-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/block/xen_disk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index d42ed70..536e2ee 100644
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
-- 
1.9.1
