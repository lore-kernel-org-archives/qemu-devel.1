Received: from eggs.gnu.org ([209.51.188.92]:53583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=99015e4a8=anthony.perard@citrix.com>)
	id 1hC5pz-0005ug-A3
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 13:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=99015e4a8=anthony.perard@citrix.com>)
	id 1hC5py-0002LI-41
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 13:07:39 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:38283)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=99015e4a8=anthony.perard@citrix.com>)
	id 1hC5px-00028D-M6
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 13:07:38 -0400
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Thu, 4 Apr 2019 18:07:21 +0100
Message-ID: <20190404170722.4492-2-anthony.perard@citrix.com>
In-Reply-To: <20190404170722.4492-1-anthony.perard@citrix.com>
References: <20190404170722.4492-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 1/2] xen-block: only advertize discard to the
 frontend when it is enabled...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Peter Maydell <peter.maydell@linaro.org>, Anthony PERARD <anthony.perard@citrix.com>

From: Paul Durrant <paul.durrant@citrix.com>

...and properly enable it when synthesizing a drive.

The Xen toolstack sets 'discard-enable' to '1' in xenstore when it wants
to enable discard on a specified image. The code in
xen_block_drive_create() correctly parses this and uses it to set
'discard' to 'unmap' for the file_layer, but fails to do the same for the
driver_layer (which effectively disables it). Meanwhile the code in
xen_block_realize() advertizes discard support to the frontend in the
default case (because conf->discard_granularity defaults to -1), even when
the underlying image may not handle it.

This patch adds the missing option to the driver_layer in
xen_block_driver_create() and checks whether BDRV_O_UNMAP is actually
set on the block device before advertizing discard to the frontend.
In the case that discard is supported it also makes sure that the
granularity is set to the physical block size.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20190320142825.24565-1-paul.durrant@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/block/xen-block.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 9c722b9b95..475a67845d 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -232,8 +232,14 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
     blk_set_dev_ops(conf->blk, &xen_block_dev_ops, blockdev);
     blk_set_guest_block_size(conf->blk, conf->logical_block_size);
 
-    if (conf->discard_granularity > 0) {
+    if (conf->discard_granularity == -1) {
+        conf->discard_granularity = conf->physical_block_size;
+    }
+
+    if (blk_get_flags(conf->blk) & BDRV_O_UNMAP) {
         xen_device_backend_printf(xendev, "feature-discard", "%u", 1);
+        xen_device_backend_printf(xendev, "discard-granularity", "%u",
+                                  conf->discard_granularity);
     }
 
     xen_device_backend_printf(xendev, "feature-flush-cache", "%u", 1);
@@ -755,6 +761,7 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
     drive->id = g_strdup(id);
 
     file_layer = qdict_new();
+    driver_layer = qdict_new();
 
     qdict_put_str(file_layer, "driver", "file");
     qdict_put_str(file_layer, "filename", filename);
@@ -782,6 +789,7 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
 
         if (!qemu_strtoul(discard_enable, NULL, 2, &value) && !!value) {
             qdict_put_str(file_layer, "discard", "unmap");
+            qdict_put_str(driver_layer, "discard", "unmap");
         }
     }
 
@@ -791,8 +799,6 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
      */
     qdict_put_str(file_layer, "locking", "off");
 
-    driver_layer = qdict_new();
-
     qdict_put_str(driver_layer, "driver", driver);
     g_free(driver);
 
-- 
Anthony PERARD
