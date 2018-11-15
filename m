Received: from eggs.gnu.org ([2001:4830:134:3::10]:53800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70x-0002SI-C8
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70v-0005mg-U3
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:04:14 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 14 Nov 2018 20:03:33 -0600
Message-Id: <20181115020334.1189829-13-eblake@redhat.com>
In-Reply-To: <20181115020334.1189829-1-eblake@redhat.com>
References: <20181115020334.1189829-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/13] block: Document need for audit of
 read/write 64-bit cleanness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>, Josh Durgin <jdurgin@redhat.com>, Jeff Cody <jcody@redhat.com>

At this time, any block driver that has not been audited for
64-bit cleanness, but which uses byte-based callbacks, should
explicitly document that the driver wants the block layer to
cap things at 2G.  This patch has no semantic change.  And it
shows that the things I'm not interested in auditing are:
bochs, cloop, dmg, file-win32, qcow, rbd, vvfat, vxhs

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/bochs.c      | 1 +
 block/cloop.c      | 1 +
 block/dmg.c        | 1 +
 block/file-win32.c | 2 ++
 block/qcow.c       | 1 +
 block/rbd.c        | 1 +
 block/vvfat.c      | 1 +
 block/vxhs.c       | 1 +
 8 files changed, 9 insertions(+)

diff --git a/block/bochs.c b/block/bochs.c
index 22e7d442113..cfa449ffb6f 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -202,6 +202,7 @@ fail:
 static void bochs_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     bs->bl.request_alignment = BDRV_SECTOR_SIZE; /* No sub-sector I/O */
+    bs->bl.max_transfer = BDRV_REQUEST_MAX_BYTES;
 }

 static int64_t seek_to_sector(BlockDriverState *bs, int64_t sector_num)
diff --git a/block/cloop.c b/block/cloop.c
index df2b85f7234..1ac0ed234d8 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -211,6 +211,7 @@ fail:
 static void cloop_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     bs->bl.request_alignment = BDRV_SECTOR_SIZE; /* No sub-sector I/O */
+    bs->bl.max_transfer = BDRV_REQUEST_MAX_BYTES;
 }

 static inline int cloop_read_block(BlockDriverState *bs, int block_num)
diff --git a/block/dmg.c b/block/dmg.c
index 50e91aef6d9..ea5553b6bf2 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -555,6 +555,7 @@ fail:
 static void dmg_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     bs->bl.request_alignment = BDRV_SECTOR_SIZE; /* No sub-sector I/O */
+    bs->bl.max_transfer = BDRV_REQUEST_MAX_BYTES;
 }

 static inline int is_sector_in_chunk(BDRVDMGState* s,
diff --git a/block/file-win32.c b/block/file-win32.c
index f1e2187f3bd..91b2dd9ed88 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -256,6 +256,7 @@ static void raw_probe_alignment(BlockDriverState *bs, Error **errp)

     /* XXX Does Windows support AIO on less than 512-byte alignment? */
     bs->bl.request_alignment = 512;
+    bs->bl.max_transfer = BDRV_REQUEST_MAX_BYTES;
 }

 static void raw_parse_flags(int flags, bool use_aio, int *access_flags,
@@ -716,6 +717,7 @@ static void hdev_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     /* XXX Does Windows support AIO on less than 512-byte alignment? */
     bs->bl.request_alignment = 512;
+    bs->bl.max_transfer = BDRV_REQUEST_MAX_BYTES;
 }

 static int hdev_open(BlockDriverState *bs, QDict *options, int flags,
diff --git a/block/qcow.c b/block/qcow.c
index 4518cb4c35e..ae6deacdb1f 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -618,6 +618,7 @@ static void qcow_refresh_limits(BlockDriverState *bs, Error **errp)
      * it's easier to let the block layer handle rounding than to
      * audit this code further. */
     bs->bl.request_alignment = BDRV_SECTOR_SIZE;
+    bs->bl.max_transfer = BDRV_REQUEST_MAX_BYTES;
 }

 static coroutine_fn int qcow_co_preadv(BlockDriverState *bs, uint64_t offset,
diff --git a/block/rbd.c b/block/rbd.c
index 8a1a9f4b6e2..248e635b077 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -236,6 +236,7 @@ static void qemu_rbd_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     /* XXX Does RBD support AIO on less than 512-byte alignment? */
     bs->bl.request_alignment = 512;
+    bs->bl.max_transfer = BDRV_REQUEST_MAX_BYTES;
 }


diff --git a/block/vvfat.c b/block/vvfat.c
index 915a05ae4f2..35f35328baf 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1304,6 +1304,7 @@ fail:
 static void vvfat_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     bs->bl.request_alignment = BDRV_SECTOR_SIZE; /* No sub-sector I/O */
+    bs->bl.max_transfer = BDRV_REQUEST_MAX_BYTES;
 }

 static inline void vvfat_close_current_file(BDRVVVFATState *s)
diff --git a/block/vxhs.c b/block/vxhs.c
index 0cb0a007e90..5828f53432c 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -221,6 +221,7 @@ static void vxhs_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     /* XXX Does VXHS support AIO on less than 512-byte alignment? */
     bs->bl.request_alignment = 512;
+    bs->bl.max_transfer = BDRV_REQUEST_MAX_BYTES;
 }

 static int vxhs_init_and_ref(void)
-- 
2.17.2
