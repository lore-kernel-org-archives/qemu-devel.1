Received: from eggs.gnu.org ([209.51.188.92]:36401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=955018df6=anthony.perard@citrix.com>)
	id 1gzPbT-0006nn-Rp
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:36:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=955018df6=anthony.perard@citrix.com>)
	id 1gzPbR-0003xo-Ft
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:36:15 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:52091)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=955018df6=anthony.perard@citrix.com>)
	id 1gzPbP-0003qn-2m
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:36:13 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Thu, 28 Feb 2019 17:34:39 +0000
Message-ID: <20190228173439.8013-5-anthony.perard@citrix.com>
In-Reply-To: <20190228173439.8013-1-anthony.perard@citrix.com>
References: <20190228173439.8013-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 4/4] xen-block: stop leaking memory in
 xen_block_drive_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Peter Maydell <peter.maydell@linaro.org>

From: Paul Durrant <paul.durrant@citrix.com>

The locally allocated QDict-s need to be freed. ('file_layer' will be
freed implicitly since it is added as an object to 'driver_layer').

Spotted by Coverity: CID 1398649

While in the neighbourhood free 'driver' and 'filename' as soon as they are
added to the QDicts. Freeing after the 'done' label doesn't make that much
sense as, if the error path jumps to that label, the values would be NULL
anyway.

This patch also makes that more obvious by taking the error path if
'params' is NULL and then asserting that both driver and filename are
non-NULL in the normal path.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Message-Id: <20190219163440.15702-1-paul.durrant@citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/block/xen-block.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 37a456c207..70fc2455e8 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -743,12 +743,12 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
         }
 
         g_strfreev(v);
-    }
-
-    if (!filename) {
-        error_setg(errp, "no filename");
+    } else {
+        error_setg(errp, "no params");
         goto done;
     }
+
+    assert(filename);
     assert(driver);
 
     drive = g_new0(XenBlockDrive, 1);
@@ -758,6 +758,7 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
 
     qdict_put_str(file_layer, "driver", "file");
     qdict_put_str(file_layer, "filename", filename);
+    g_free(filename);
 
     if (mode && *mode != 'w') {
         qdict_put_bool(file_layer, "read-only", true);
@@ -793,16 +794,17 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
     driver_layer = qdict_new();
 
     qdict_put_str(driver_layer, "driver", driver);
+    g_free(driver);
+
     qdict_put_obj(driver_layer, "file", QOBJECT(file_layer));
 
     g_assert(!drive->node_name);
     drive->node_name = xen_block_blockdev_add(drive->id, driver_layer,
                                               &local_err);
 
-done:
-    g_free(driver);
-    g_free(filename);
+    qobject_unref(driver_layer);
 
+done:
     if (local_err) {
         error_propagate(errp, local_err);
         xen_block_drive_destroy(drive, NULL);
-- 
Anthony PERARD
