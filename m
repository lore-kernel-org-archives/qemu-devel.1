Received: from eggs.gnu.org ([2001:4830:134:3::10]:57250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLkY-0003R7-FD
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLkX-0004QQ-Dq
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:12:50 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:09:41 -0300
Message-Id: <20170718061005.29518-6-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 05/29] block: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 block/io.c          | 4 ++--
 block/qcow2-cache.c | 2 +-
 block/vhdx-log.c    | 2 +-
 block/vvfat.c       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index aece54c015..2db571c310 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1232,7 +1232,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
                                     MAX_WRITE_ZEROES_BOUNCE_BUFFER);
 
-    assert(alignment % bs->bl.request_alignment == 0);
+    assert(QEMU_IS_ALIGNED(alignment, bs->bl.request_alignment));
     head = offset % alignment;
     tail = (offset + bytes) % alignment;
     max_write_zeroes = QEMU_ALIGN_DOWN(max_write_zeroes, alignment);
@@ -2342,7 +2342,7 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
      * unaligned requests (by returning -ENOTSUP), so we must fragment
      * the request accordingly.  */
     align = MAX(bs->bl.pdiscard_alignment, bs->bl.request_alignment);
-    assert(align % bs->bl.request_alignment == 0);
+    assert(QEMU_IS_ALIGNED(align, bs->bl.request_alignment));
     head = offset % align;
     tail = (offset + bytes) % align;
 
diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 1d25147392..a4886c581e 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -58,7 +58,7 @@ static inline int qcow2_cache_get_table_idx(BlockDriverState *bs,
     BDRVQcow2State *s = bs->opaque;
     ptrdiff_t table_offset = (uint8_t *) table - (uint8_t *) c->table_array;
     int idx = table_offset / s->cluster_size;
-    assert(idx >= 0 && idx < c->size && table_offset % s->cluster_size == 0);
+    assert(idx >= 0 && idx < c->size && QEMU_IS_ALIGNED(table_offset, s->cluster_size));
     return idx;
 }
 
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 01278f3fc9..bdcaa4cc16 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -282,7 +282,7 @@ static bool vhdx_log_desc_is_valid(VHDXLogDescriptor *desc,
     }
 
     if (desc->signature == VHDX_LOG_ZERO_SIGNATURE) {
-        if (desc->zero_length % VHDX_LOG_SECTOR_SIZE == 0) {
+        if (QEMU_IS_ALIGNED(desc->zero_length, VHDX_LOG_SECTOR_SIZE)) {
             /* valid */
             ret = true;
         }
diff --git a/block/vvfat.c b/block/vvfat.c
index 4dae790203..5eb827fbd6 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -454,7 +454,7 @@ static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
         entry=array_get(&(s->directory),s->directory.next-1-(i/26));
         if (i >= 2 * length + 2) {
             entry->name[offset] = 0xff;
-        } else if (i % 2 == 0) {
+        } else if (QEMU_IS_ALIGNED(i, 2)) {
             entry->name[offset] = longname[i / 2] & 0xff;
         } else {
             entry->name[offset] = longname[i / 2] >> 8;
-- 
2.13.2
