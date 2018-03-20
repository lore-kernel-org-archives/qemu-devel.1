Received: from eggs.gnu.org ([2001:4830:134:3::10]:51516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyLBl-00008o-OL
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyLBk-0000QX-Qx
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:36:45 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 20 Mar 2018 18:36:22 +0100
Message-Id: <20180320173632.25480-3-kwolf@redhat.com>
In-Reply-To: <20180320173632.25480-1-kwolf@redhat.com>
References: <20180320173632.25480-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 02/12] vdi: Fix build with
 CONFIG_VDI_DEBUG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

Use qemu_uuid_unparse() instead of uuid_unparse() to make vdi.c compile
again when CONFIG_VDI_DEBUG is set. In order to prevent future bitrot,
replace '#ifdef CONFIG_VDI_DEBUG' by 'if (VDI_DEBUG)' so that the
compiler always sees the code.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vdi.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 73c059e69d..4a2d1ff88d 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -235,7 +235,6 @@ static void vdi_header_to_le(VdiHeader *header)
     qemu_uuid_bswap(&header->uuid_parent);
 }
 
-#if defined(CONFIG_VDI_DEBUG)
 static void vdi_header_print(VdiHeader *header)
 {
     char uuid[37];
@@ -257,16 +256,15 @@ static void vdi_header_print(VdiHeader *header)
     logout("block extra 0x%04x\n", header->block_extra);
     logout("blocks tot. 0x%04x\n", header->blocks_in_image);
     logout("blocks all. 0x%04x\n", header->blocks_allocated);
-    uuid_unparse(header->uuid_image, uuid);
+    qemu_uuid_unparse(&header->uuid_image, uuid);
     logout("uuid image  %s\n", uuid);
-    uuid_unparse(header->uuid_last_snap, uuid);
+    qemu_uuid_unparse(&header->uuid_last_snap, uuid);
     logout("uuid snap   %s\n", uuid);
-    uuid_unparse(header->uuid_link, uuid);
+    qemu_uuid_unparse(&header->uuid_link, uuid);
     logout("uuid link   %s\n", uuid);
-    uuid_unparse(header->uuid_parent, uuid);
+    qemu_uuid_unparse(&header->uuid_parent, uuid);
     logout("uuid parent %s\n", uuid);
 }
-#endif
 
 static int coroutine_fn vdi_co_check(BlockDriverState *bs, BdrvCheckResult *res,
                                      BdrvCheckMode fix)
@@ -387,9 +385,9 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     vdi_header_to_cpu(&header);
-#if defined(CONFIG_VDI_DEBUG)
-    vdi_header_print(&header);
-#endif
+    if (VDI_DEBUG) {
+        vdi_header_print(&header);
+    }
 
     if (header.disk_size > VDI_DISK_SIZE_MAX) {
         error_setg(errp, "Unsupported VDI image size (size is 0x%" PRIx64
@@ -825,9 +823,9 @@ static int coroutine_fn vdi_co_do_create(BlockdevCreateOptions *create_options,
     qemu_uuid_generate(&header.uuid_image);
     qemu_uuid_generate(&header.uuid_last_snap);
     /* There is no need to set header.uuid_link or header.uuid_parent here. */
-#if defined(CONFIG_VDI_DEBUG)
-    vdi_header_print(&header);
-#endif
+    if (VDI_DEBUG) {
+        vdi_header_print(&header);
+    }
     vdi_header_to_le(&header);
     ret = blk_pwrite(blk, offset, &header, sizeof(header), 0);
     if (ret < 0) {
-- 
2.13.6
