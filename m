Received: from eggs.gnu.org ([2001:4830:134:3::10]:36269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@hotmail.com>) id 1evv5g-0000Ll-UK
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@hotmail.com>) id 1evv5c-0006KH-GI
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:28906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@hotmail.com>)
	id 1evv5c-0006Hx-45
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:24 -0400
From: junyan.he@hotmail.com
Date: Wed, 14 Mar 2018 09:20:09 +0800
Message-Id: <1520990418-28258-2-git-send-email-junyan.he@hotmail.com>
In-Reply-To: <1520990418-28258-1-git-send-email-junyan.he@hotmail.com>
References: <1520990418-28258-1-git-send-email-junyan.he@hotmail.com>
Subject: [Qemu-devel] [PATCH 01/10] RFC: Add save and support snapshot
 dependency function to block driver.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, quintela@redhat.com, rth@twiddle.net, dgilbert@redhat.com, famz@redhat.com, Junyan He <junyan.he@intel.com>

From: Junyan He <junyan.he@intel.com>

We want to support incremental snapshot saving, this needs the file
system support dependency saving. Later snapshots may ref the dependent
snapshot's content, and most time should be cluster aligned.
Add a query function to check whether the file system support this, and
use the save_dependency function to do the real work.

Signed-off-by: Junyan He <junyan.he@intel.com>
---
 include/block/block_int.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 64a5700..be1eca3 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -274,6 +274,15 @@ struct BlockDriver {
                                   const char *snapshot_id,
                                   const char *name,
                                   Error **errp);
+    int (*bdrv_snapshot_save_dependency)(BlockDriverState *bs,
+                                         const char *depend_snapshot_id,
+                                         int64_t depend_offset,
+                                         int64_t depend_size,
+                                         int64_t offset,
+                                         Error **errp);
+    int (*bdrv_snapshot_support_dependency)(BlockDriverState *bs,
+                                            int32_t *alignment);
+
     int (*bdrv_get_info)(BlockDriverState *bs, BlockDriverInfo *bdi);
     ImageInfoSpecific *(*bdrv_get_specific_info)(BlockDriverState *bs);
 
-- 
2.7.4
