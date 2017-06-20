Received: from eggs.gnu.org ([2001:4830:134:3::10]:34131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3370d2115=Paul.Durrant@citrix.com>)
	id 1dNJVn-000217-5Q
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3370d2115=Paul.Durrant@citrix.com>)
	id 1dNJVk-0008U3-E2
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:48:07 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 20 Jun 2017 09:47:54 -0400
Message-ID: <20170620134756.9632-2-paul.durrant@citrix.com>
In-Reply-To: <20170620134756.9632-1-paul.durrant@citrix.com>
References: <20170620134756.9632-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/3] xen-disk: only advertize
 feature-persistent if grant copy is not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

If grant copy is available then it will always be used in preference to
persistent maps. In this case feature-persistent should not be advertized
to the frontend, otherwise it may needlessly copy data into persistently
granted buffers.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
---
 hw/block/xen_disk.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index 3a22805fbc..9b06e3aa81 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -1023,11 +1023,18 @@ static int blk_init(struct XenDevice *xendev)
 
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
@@ -1202,12 +1209,6 @@ static int blk_connect(struct XenDevice *xendev)
 
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
2.11.0
