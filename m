Received: from eggs.gnu.org ([2001:4830:134:3::10]:58953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1deYP9-0003hK-Ok
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 23:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1deYP8-0005qF-Em
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 23:08:31 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Sun,  6 Aug 2017 23:08:19 -0400
Message-Id: <85fe374c783a6d659bc86aa7f15d5f442b9d7a45.1502075213.git.jcody@redhat.com>
In-Reply-To: <cover.1502075213.git.jcody@redhat.com>
References: <cover.1502075213.git.jcody@redhat.com>
In-Reply-To: <cover.1502075213.git.jcody@redhat.com>
References: <cover.1502075213.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] block/vhdx: check error return of
 bdrv_getlength()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com

Calls to bdrv_getlength() were not checking for error.  In vhdx.c, this
can lead to truncating an image file, so it is a definite bug.  In
vhdx-log.c, the path for improper behavior is less clear, but it is best
to check in any case.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/vhdx-log.c | 20 ++++++++++++++++----
 block/vhdx.c     |  9 ++++++++-
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 01278f3..fd4e7af 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -491,6 +491,7 @@ static int vhdx_log_flush(BlockDriverState *bs, BDRVVHDXState *s,
     uint32_t cnt, sectors_read;
     uint64_t new_file_size;
     void *data = NULL;
+    int64_t file_length;
     VHDXLogDescEntries *desc_entries = NULL;
     VHDXLogEntryHeader hdr_tmp = { 0 };
 
@@ -510,10 +511,15 @@ static int vhdx_log_flush(BlockDriverState *bs, BDRVVHDXState *s,
         if (ret < 0) {
             goto exit;
         }
+        file_length = bdrv_getlength(bs->file->bs);
+        if (file_length < 0) {
+            ret = file_length;
+            goto exit;
+        }
         /* if the log shows a FlushedFileOffset larger than our current file
          * size, then that means the file has been truncated / corrupted, and
          * we must refused to open it / use it */
-        if (hdr_tmp.flushed_file_offset > bdrv_getlength(bs->file->bs)) {
+        if (hdr_tmp.flushed_file_offset > file_length) {
             ret = -EINVAL;
             goto exit;
         }
@@ -543,7 +549,7 @@ static int vhdx_log_flush(BlockDriverState *bs, BDRVVHDXState *s,
                 goto exit;
             }
         }
-        if (bdrv_getlength(bs->file->bs) < desc_entries->hdr.last_file_offset) {
+        if (file_length < desc_entries->hdr.last_file_offset) {
             new_file_size = desc_entries->hdr.last_file_offset;
             if (new_file_size % (1024*1024)) {
                 /* round up to nearest 1MB boundary */
@@ -851,6 +857,7 @@ static int vhdx_log_write(BlockDriverState *bs, BDRVVHDXState *s,
     uint32_t partial_sectors = 0;
     uint32_t bytes_written = 0;
     uint64_t file_offset;
+    int64_t file_length;
     VHDXHeader *header;
     VHDXLogEntryHeader new_hdr;
     VHDXLogDescriptor *new_desc = NULL;
@@ -913,10 +920,15 @@ static int vhdx_log_write(BlockDriverState *bs, BDRVVHDXState *s,
                 .sequence_number     = s->log.sequence,
                 .descriptor_count    = sectors,
                 .reserved            = 0,
-                .flushed_file_offset = bdrv_getlength(bs->file->bs),
-                .last_file_offset    = bdrv_getlength(bs->file->bs),
               };
 
+    file_length = bdrv_getlength(bs->file->bs);
+    if (file_length < 0) {
+        ret = file_length;
+        goto exit;
+    }
+    new_hdr.flushed_file_offset = file_length;
+    new_hdr.last_file_offset    = file_length;
     new_hdr.log_guid = header->log_guid;
 
     desc_sectors = vhdx_compute_desc_sectors(new_hdr.descriptor_count);
diff --git a/block/vhdx.c b/block/vhdx.c
index a9cecd2..6a14999 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1166,7 +1166,14 @@ exit:
 static int vhdx_allocate_block(BlockDriverState *bs, BDRVVHDXState *s,
                                     uint64_t *new_offset)
 {
-    *new_offset = bdrv_getlength(bs->file->bs);
+    int64_t current_len;
+    current_len = bdrv_getlength(bs->file->bs);
+
+    if (current_len < 0) {
+        return current_len;
+    }
+
+    *new_offset = current_len;
 
     /* per the spec, the address for a block is in units of 1MB */
     *new_offset = ROUND_UP(*new_offset, 1024 * 1024);
-- 
2.9.4
