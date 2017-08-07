Received: from eggs.gnu.org ([2001:4830:134:3::10]:53498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dehIu-0003Vu-S7
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dehIp-0003Ib-PW
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:38:40 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon,  7 Aug 2017 08:38:19 -0400
Message-Id: <102a86250b48b54d3a5a60bfa9f49a33c0735c13.1502109078.git.jcody@redhat.com>
In-Reply-To: <cover.1502109078.git.jcody@redhat.com>
References: <cover.1502109078.git.jcody@redhat.com>
In-Reply-To: <cover.1502109078.git.jcody@redhat.com>
References: <cover.1502109078.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 1/4] block/vhdx: check error return
 of bdrv_getlength()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, kwolf@redhat.com, eblake@redhat.com

Calls to bdrv_getlength() were not checking for error.  In vhdx.c, this
can lead to truncating an image file, so it is a definite bug.  In
vhdx-log.c, the path for improper behavior is less clear, but it is best
to check in any case.

Some minor code movement of the log_guid intialization, as well.

Reported-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/vhdx-log.c | 23 ++++++++++++++++++-----
 block/vhdx.c     |  9 ++++++++-
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 01278f3..2e26fd4 100644
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
@@ -904,6 +911,12 @@ static int vhdx_log_write(BlockDriverState *bs, BDRVVHDXState *s,
 
     sectors += partial_sectors;
 
+    file_length = bdrv_getlength(bs->file->bs);
+    if (file_length < 0) {
+        ret = file_length;
+        goto exit;
+    }
+
     /* sectors is now how many sectors the data itself takes, not
      * including the header and descriptor metadata */
 
@@ -913,11 +926,11 @@ static int vhdx_log_write(BlockDriverState *bs, BDRVVHDXState *s,
                 .sequence_number     = s->log.sequence,
                 .descriptor_count    = sectors,
                 .reserved            = 0,
-                .flushed_file_offset = bdrv_getlength(bs->file->bs),
-                .last_file_offset    = bdrv_getlength(bs->file->bs),
+                .flushed_file_offset = file_length,
+                .last_file_offset    = file_length,
+                .log_guid            = header->log_guid,
               };
 
-    new_hdr.log_guid = header->log_guid;
 
     desc_sectors = vhdx_compute_desc_sectors(new_hdr.descriptor_count);
 
diff --git a/block/vhdx.c b/block/vhdx.c
index a9cecd2..37224b8 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1166,7 +1166,14 @@ exit:
 static int vhdx_allocate_block(BlockDriverState *bs, BDRVVHDXState *s,
                                     uint64_t *new_offset)
 {
-    *new_offset = bdrv_getlength(bs->file->bs);
+    int64_t current_len;
+
+    current_len = bdrv_getlength(bs->file->bs);
+    if (current_len < 0) {
+        return current_len;
+    }
+
+    *new_offset = current_len;
 
     /* per the spec, the address for a block is in units of 1MB */
     *new_offset = ROUND_UP(*new_offset, 1024 * 1024);
-- 
2.9.4
