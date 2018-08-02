Received: from eggs.gnu.org ([2001:4830:134:3::10]:36354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1flEuB-0002BU-DJ
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1flEuA-0008VW-L0
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:48:43 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  2 Aug 2018 09:48:31 -0500
Message-Id: <20180802144834.520904-2-eblake@redhat.com>
In-Reply-To: <20180802144834.520904-1-eblake@redhat.com>
References: <20180802144834.520904-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] block: Add bdrv_get_request_alignment()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, rjones@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The next patch needs access to a device's minimum permitted
alignment, since NBD wants to advertise this to clients. Add
an accessor function, borrowing from blk_get_max_transfer()
for accessing a backend's block limits.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/sysemu/block-backend.h | 1 +
 block/block-backend.c          | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 830d873f24f..20f8bbbce37 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -176,6 +176,7 @@ bool blk_is_available(BlockBackend *blk);
 void blk_lock_medium(BlockBackend *blk, bool locked);
 void blk_eject(BlockBackend *blk, bool eject_flag);
 int blk_get_flags(BlockBackend *blk);
+uint32_t blk_get_request_alignment(BlockBackend *blk);
 uint32_t blk_get_max_transfer(BlockBackend *blk);
 int blk_get_max_iov(BlockBackend *blk);
 void blk_set_guest_block_size(BlockBackend *blk, int align);
diff --git a/block/block-backend.c b/block/block-backend.c
index f2f75a977d7..fb8c827d117 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1798,6 +1798,13 @@ int blk_get_flags(BlockBackend *blk)
     }
 }

+/* Returns the minimum request alignment, in bytes; guaranteed nonzero */
+uint32_t blk_get_request_alignment(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    return bs ? bs->bl.request_alignment : BDRV_SECTOR_SIZE;
+}
+
 /* Returns the maximum transfer length, in bytes; guaranteed nonzero */
 uint32_t blk_get_max_transfer(BlockBackend *blk)
 {
-- 
2.14.4
