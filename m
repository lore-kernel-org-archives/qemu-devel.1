Received: from eggs.gnu.org ([209.51.188.92]:46014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcs-0002BG-5P
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcp-0004xq-Ni
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:26 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  1 Apr 2019 09:09:01 -0500
Message-Id: <20190401140903.19186-13-eblake@redhat.com>
In-Reply-To: <20190401140903.19186-1-eblake@redhat.com>
References: <20190401140903.19186-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/14] block: Add bdrv_get_request_alignment()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

The next patch needs access to a device's minimum permitted
alignment, since NBD wants to advertise this to clients. Add
an accessor function, borrowing from blk_get_max_transfer()
for accessing a backend's block limits.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20190329042750.14704-6-eblake@redhat.com>
---
 include/sysemu/block-backend.h | 1 +
 block/block-backend.c          | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backen=
d.h
index e2066eb06b2..3be05c2d689 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -177,6 +177,7 @@ bool blk_is_available(BlockBackend *blk);
 void blk_lock_medium(BlockBackend *blk, bool locked);
 void blk_eject(BlockBackend *blk, bool eject_flag);
 int blk_get_flags(BlockBackend *blk);
+uint32_t blk_get_request_alignment(BlockBackend *blk);
 uint32_t blk_get_max_transfer(BlockBackend *blk);
 int blk_get_max_iov(BlockBackend *blk);
 void blk_set_guest_block_size(BlockBackend *blk, int align);
diff --git a/block/block-backend.c b/block/block-backend.c
index edad02a0f2a..f78e82a707f 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1764,6 +1764,13 @@ int blk_get_flags(BlockBackend *blk)
     }
 }

+/* Returns the minimum request alignment, in bytes; guaranteed nonzero *=
/
+uint32_t blk_get_request_alignment(BlockBackend *blk)
+{
+    BlockDriverState *bs =3D blk_bs(blk);
+    return bs ? bs->bl.request_alignment : BDRV_SECTOR_SIZE;
+}
+
 /* Returns the maximum transfer length, in bytes; guaranteed nonzero */
 uint32_t blk_get_max_transfer(BlockBackend *blk)
 {
--=20
2.20.1
