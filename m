Received: from eggs.gnu.org ([2001:4830:134:3::10]:49905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dPybP-0008E2-Lr
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dPybL-0000NG-NC
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dPybL-0000Mp-Gq
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:04:51 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue, 27 Jun 2017 15:04:42 -0700
Message-Id: <1498601083-11799-2-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1498601083-11799-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1706271456310.24648@sstabellini-ThinkPad-X260>
	<1498601083-11799-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL 2/3] xen-disk: only advertize feature-persistent
 if grant copy is not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Paul Durrant <paul.durrant@citrix.com>

From: Paul Durrant <paul.durrant@citrix.com>

If grant copy is available then it will always be used in preference to
persistent maps. In this case feature-persistent should not be advertized
to the frontend, otherwise it may needlessly copy data into persistently
granted buffers.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/block/xen_disk.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index 9200511..8218741 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -1022,11 +1022,18 @@ static int blk_init(struct XenDevice *xendev)
 
     blkdev->file_blk  = BLOCK_SIZE;
 
+    blkdev->feature_grant_copy =
+                (xengnttab_grant_copy(blkdev->xendev.gnttabdev, 0, NULL) == 0);
+
+    xen_pv_printf(&blkdev->xendev, 3, "grant copy operation %s\n",
+                  blkdev->feature_grant_copy ? "enabled" : "disabled");
+
     /* fill info
      * blk_connect supplies sector-size and sectors
      */
     xenstore_write_be_int(&blkdev->xendev, "feature-flush-cache", 1);
-    xenstore_write_be_int(&blkdev->xendev, "feature-persistent", 1);
+    xenstore_write_be_int(&blkdev->xendev, "feature-persistent",
+                          !blkdev->feature_grant_copy);
     xenstore_write_be_int(&blkdev->xendev, "info", info);
 
     blk_parse_discard(blkdev);
@@ -1201,12 +1208,6 @@ static int blk_connect(struct XenDevice *xendev)
 
     xen_be_bind_evtchn(&blkdev->xendev);
 
-    blkdev->feature_grant_copy =
-                (xengnttab_grant_copy(blkdev->xendev.gnttabdev, 0, NULL) == 0);
-
-    xen_pv_printf(&blkdev->xendev, 3, "grant copy operation %s\n",
-                  blkdev->feature_grant_copy ? "enabled" : "disabled");
-
     xen_pv_printf(&blkdev->xendev, 1, "ok: proto %s, ring-ref %d, "
                   "remote port %d, local port %d\n",
                   blkdev->xendev.protocol, blkdev->ring_ref,
-- 
1.9.1
