Received: from eggs.gnu.org ([2001:4830:134:3::10]:48823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCSqo-0005at-DJ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCSqm-0003Pc-U5
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:09:46 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 18:09:38 +0100
Message-Id: <20181016170938.29303-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] block/vhdx: Don't take address of fields in
 packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Jeff Cody <codyprime@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Taking the address of a field in a packed struct is a bad idea, because
it might not be actually aligned enough for that pointer type (and
thus cause a crash on dereference on some host architectures). Newer
versions of clang warn about this. Avoid the bug by not using the
"modify in place" byte swapping functions.

There are a few places where the in-place swap function is
used on something other than a packed struct field; we convert
those anyway, for consistency.

Patch produced with scripts/coccinelle/inplace-byteswaps.cocci.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Usual disclaimer: produced with "make check" only, but purely
automated conversion should be safe.

 block/vhdx.h        |  12 ++---
 block/vhdx-endian.c | 118 ++++++++++++++++++++++----------------------
 block/vhdx-log.c    |   4 +-
 block/vhdx.c        |  18 +++----
 4 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/block/vhdx.h b/block/vhdx.h
index 7003ab7a795..3a5f5293adc 100644
--- a/block/vhdx.h
+++ b/block/vhdx.h
@@ -420,16 +420,16 @@ int vhdx_log_write_and_flush(BlockDriverState *bs, BDRVVHDXState *s,
 
 static inline void leguid_to_cpus(MSGUID *guid)
 {
-    le32_to_cpus(&guid->data1);
-    le16_to_cpus(&guid->data2);
-    le16_to_cpus(&guid->data3);
+    guid->data1 = le32_to_cpu(guid->data1);
+    guid->data2 = le16_to_cpu(guid->data2);
+    guid->data3 = le16_to_cpu(guid->data3);
 }
 
 static inline void cpu_to_leguids(MSGUID *guid)
 {
-    cpu_to_le32s(&guid->data1);
-    cpu_to_le16s(&guid->data2);
-    cpu_to_le16s(&guid->data3);
+    guid->data1 = cpu_to_le32(guid->data1);
+    guid->data2 = cpu_to_le16(guid->data2);
+    guid->data3 = cpu_to_le16(guid->data3);
 }
 
 void vhdx_header_le_import(VHDXHeader *h);
diff --git a/block/vhdx-endian.c b/block/vhdx-endian.c
index 41fbdd2b8f0..ebfa33cb8a4 100644
--- a/block/vhdx-endian.c
+++ b/block/vhdx-endian.c
@@ -35,18 +35,18 @@ void vhdx_header_le_import(VHDXHeader *h)
 {
     assert(h != NULL);
 
-    le32_to_cpus(&h->signature);
-    le32_to_cpus(&h->checksum);
-    le64_to_cpus(&h->sequence_number);
+    h->signature = le32_to_cpu(h->signature);
+    h->checksum = le32_to_cpu(h->checksum);
+    h->sequence_number = le64_to_cpu(h->sequence_number);
 
     leguid_to_cpus(&h->file_write_guid);
     leguid_to_cpus(&h->data_write_guid);
     leguid_to_cpus(&h->log_guid);
 
-    le16_to_cpus(&h->log_version);
-    le16_to_cpus(&h->version);
-    le32_to_cpus(&h->log_length);
-    le64_to_cpus(&h->log_offset);
+    h->log_version = le16_to_cpu(h->log_version);
+    h->version = le16_to_cpu(h->version);
+    h->log_length = le32_to_cpu(h->log_length);
+    h->log_offset = le64_to_cpu(h->log_offset);
 }
 
 void vhdx_header_le_export(VHDXHeader *orig_h, VHDXHeader *new_h)
@@ -80,68 +80,68 @@ void vhdx_log_desc_le_import(VHDXLogDescriptor *d)
 {
     assert(d != NULL);
 
-    le32_to_cpus(&d->signature);
-    le64_to_cpus(&d->file_offset);
-    le64_to_cpus(&d->sequence_number);
+    d->signature = le32_to_cpu(d->signature);
+    d->file_offset = le64_to_cpu(d->file_offset);
+    d->sequence_number = le64_to_cpu(d->sequence_number);
 }
 
 void vhdx_log_desc_le_export(VHDXLogDescriptor *d)
 {
     assert(d != NULL);
 
-    cpu_to_le32s(&d->signature);
-    cpu_to_le32s(&d->trailing_bytes);
-    cpu_to_le64s(&d->leading_bytes);
-    cpu_to_le64s(&d->file_offset);
-    cpu_to_le64s(&d->sequence_number);
+    d->signature = cpu_to_le32(d->signature);
+    d->trailing_bytes = cpu_to_le32(d->trailing_bytes);
+    d->leading_bytes = cpu_to_le64(d->leading_bytes);
+    d->file_offset = cpu_to_le64(d->file_offset);
+    d->sequence_number = cpu_to_le64(d->sequence_number);
 }
 
 void vhdx_log_data_le_import(VHDXLogDataSector *d)
 {
     assert(d != NULL);
 
-    le32_to_cpus(&d->data_signature);
-    le32_to_cpus(&d->sequence_high);
-    le32_to_cpus(&d->sequence_low);
+    d->data_signature = le32_to_cpu(d->data_signature);
+    d->sequence_high = le32_to_cpu(d->sequence_high);
+    d->sequence_low = le32_to_cpu(d->sequence_low);
 }
 
 void vhdx_log_data_le_export(VHDXLogDataSector *d)
 {
     assert(d != NULL);
 
-    cpu_to_le32s(&d->data_signature);
-    cpu_to_le32s(&d->sequence_high);
-    cpu_to_le32s(&d->sequence_low);
+    d->data_signature = cpu_to_le32(d->data_signature);
+    d->sequence_high = cpu_to_le32(d->sequence_high);
+    d->sequence_low = cpu_to_le32(d->sequence_low);
 }
 
 void vhdx_log_entry_hdr_le_import(VHDXLogEntryHeader *hdr)
 {
     assert(hdr != NULL);
 
-    le32_to_cpus(&hdr->signature);
-    le32_to_cpus(&hdr->checksum);
-    le32_to_cpus(&hdr->entry_length);
-    le32_to_cpus(&hdr->tail);
-    le64_to_cpus(&hdr->sequence_number);
-    le32_to_cpus(&hdr->descriptor_count);
+    hdr->signature = le32_to_cpu(hdr->signature);
+    hdr->checksum = le32_to_cpu(hdr->checksum);
+    hdr->entry_length = le32_to_cpu(hdr->entry_length);
+    hdr->tail = le32_to_cpu(hdr->tail);
+    hdr->sequence_number = le64_to_cpu(hdr->sequence_number);
+    hdr->descriptor_count = le32_to_cpu(hdr->descriptor_count);
     leguid_to_cpus(&hdr->log_guid);
-    le64_to_cpus(&hdr->flushed_file_offset);
-    le64_to_cpus(&hdr->last_file_offset);
+    hdr->flushed_file_offset = le64_to_cpu(hdr->flushed_file_offset);
+    hdr->last_file_offset = le64_to_cpu(hdr->last_file_offset);
 }
 
 void vhdx_log_entry_hdr_le_export(VHDXLogEntryHeader *hdr)
 {
     assert(hdr != NULL);
 
-    cpu_to_le32s(&hdr->signature);
-    cpu_to_le32s(&hdr->checksum);
-    cpu_to_le32s(&hdr->entry_length);
-    cpu_to_le32s(&hdr->tail);
-    cpu_to_le64s(&hdr->sequence_number);
-    cpu_to_le32s(&hdr->descriptor_count);
+    hdr->signature = cpu_to_le32(hdr->signature);
+    hdr->checksum = cpu_to_le32(hdr->checksum);
+    hdr->entry_length = cpu_to_le32(hdr->entry_length);
+    hdr->tail = cpu_to_le32(hdr->tail);
+    hdr->sequence_number = cpu_to_le64(hdr->sequence_number);
+    hdr->descriptor_count = cpu_to_le32(hdr->descriptor_count);
     cpu_to_leguids(&hdr->log_guid);
-    cpu_to_le64s(&hdr->flushed_file_offset);
-    cpu_to_le64s(&hdr->last_file_offset);
+    hdr->flushed_file_offset = cpu_to_le64(hdr->flushed_file_offset);
+    hdr->last_file_offset = cpu_to_le64(hdr->last_file_offset);
 }
 
 
@@ -150,18 +150,18 @@ void vhdx_region_header_le_import(VHDXRegionTableHeader *hdr)
 {
     assert(hdr != NULL);
 
-    le32_to_cpus(&hdr->signature);
-    le32_to_cpus(&hdr->checksum);
-    le32_to_cpus(&hdr->entry_count);
+    hdr->signature = le32_to_cpu(hdr->signature);
+    hdr->checksum = le32_to_cpu(hdr->checksum);
+    hdr->entry_count = le32_to_cpu(hdr->entry_count);
 }
 
 void vhdx_region_header_le_export(VHDXRegionTableHeader *hdr)
 {
     assert(hdr != NULL);
 
-    cpu_to_le32s(&hdr->signature);
-    cpu_to_le32s(&hdr->checksum);
-    cpu_to_le32s(&hdr->entry_count);
+    hdr->signature = cpu_to_le32(hdr->signature);
+    hdr->checksum = cpu_to_le32(hdr->checksum);
+    hdr->entry_count = cpu_to_le32(hdr->entry_count);
 }
 
 void vhdx_region_entry_le_import(VHDXRegionTableEntry *e)
@@ -169,9 +169,9 @@ void vhdx_region_entry_le_import(VHDXRegionTableEntry *e)
     assert(e != NULL);
 
     leguid_to_cpus(&e->guid);
-    le64_to_cpus(&e->file_offset);
-    le32_to_cpus(&e->length);
-    le32_to_cpus(&e->data_bits);
+    e->file_offset = le64_to_cpu(e->file_offset);
+    e->length = le32_to_cpu(e->length);
+    e->data_bits = le32_to_cpu(e->data_bits);
 }
 
 void vhdx_region_entry_le_export(VHDXRegionTableEntry *e)
@@ -179,9 +179,9 @@ void vhdx_region_entry_le_export(VHDXRegionTableEntry *e)
     assert(e != NULL);
 
     cpu_to_leguids(&e->guid);
-    cpu_to_le64s(&e->file_offset);
-    cpu_to_le32s(&e->length);
-    cpu_to_le32s(&e->data_bits);
+    e->file_offset = cpu_to_le64(e->file_offset);
+    e->length = cpu_to_le32(e->length);
+    e->data_bits = cpu_to_le32(e->data_bits);
 }
 
 
@@ -190,16 +190,16 @@ void vhdx_metadata_header_le_import(VHDXMetadataTableHeader *hdr)
 {
     assert(hdr != NULL);
 
-    le64_to_cpus(&hdr->signature);
-    le16_to_cpus(&hdr->entry_count);
+    hdr->signature = le64_to_cpu(hdr->signature);
+    hdr->entry_count = le16_to_cpu(hdr->entry_count);
 }
 
 void vhdx_metadata_header_le_export(VHDXMetadataTableHeader *hdr)
 {
     assert(hdr != NULL);
 
-    cpu_to_le64s(&hdr->signature);
-    cpu_to_le16s(&hdr->entry_count);
+    hdr->signature = cpu_to_le64(hdr->signature);
+    hdr->entry_count = cpu_to_le16(hdr->entry_count);
 }
 
 void vhdx_metadata_entry_le_import(VHDXMetadataTableEntry *e)
@@ -207,16 +207,16 @@ void vhdx_metadata_entry_le_import(VHDXMetadataTableEntry *e)
     assert(e != NULL);
 
     leguid_to_cpus(&e->item_id);
-    le32_to_cpus(&e->offset);
-    le32_to_cpus(&e->length);
-    le32_to_cpus(&e->data_bits);
+    e->offset = le32_to_cpu(e->offset);
+    e->length = le32_to_cpu(e->length);
+    e->data_bits = le32_to_cpu(e->data_bits);
 }
 void vhdx_metadata_entry_le_export(VHDXMetadataTableEntry *e)
 {
     assert(e != NULL);
 
     cpu_to_leguids(&e->item_id);
-    cpu_to_le32s(&e->offset);
-    cpu_to_le32s(&e->length);
-    cpu_to_le32s(&e->data_bits);
+    e->offset = cpu_to_le32(e->offset);
+    e->length = cpu_to_le32(e->length);
+    e->data_bits = cpu_to_le32(e->data_bits);
 }
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index d2f1b98199c..ecd64266c5e 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -835,11 +835,11 @@ static void vhdx_log_raw_to_le_sector(VHDXLogDescriptor *desc,
     /* 8 + 4084 + 4 = 4096, 1 log sector */
     memcpy(&desc->leading_bytes, data, 8);
     data += 8;
-    cpu_to_le64s(&desc->leading_bytes);
+    desc->leading_bytes = cpu_to_le64(desc->leading_bytes);
     memcpy(sector->data, data, 4084);
     data += 4084;
     memcpy(&desc->trailing_bytes, data, 4);
-    cpu_to_le32s(&desc->trailing_bytes);
+    desc->trailing_bytes = cpu_to_le32(desc->trailing_bytes);
     data += 4;
 
     sector->sequence_high  = (uint32_t) (seq >> 32);
diff --git a/block/vhdx.c b/block/vhdx.c
index 0795ca19857..b785aef4b7b 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -156,7 +156,7 @@ uint32_t vhdx_update_checksum(uint8_t *buf, size_t size, int crc_offset)
 
     memset(buf + crc_offset, 0, sizeof(crc));
     crc =  crc32c(0xffffffff, buf, size);
-    cpu_to_le32s(&crc);
+    crc = cpu_to_le32(crc);
     memcpy(buf + crc_offset, &crc, sizeof(crc));
 
     return crc;
@@ -753,8 +753,8 @@ static int vhdx_parse_metadata(BlockDriverState *bs, BDRVVHDXState *s)
         goto exit;
     }
 
-    le32_to_cpus(&s->params.block_size);
-    le32_to_cpus(&s->params.data_bits);
+    s->params.block_size = le32_to_cpu(s->params.block_size);
+    s->params.data_bits = le32_to_cpu(s->params.data_bits);
 
 
     /* We now have the file parameters, so we can tell if this is a
@@ -803,9 +803,9 @@ static int vhdx_parse_metadata(BlockDriverState *bs, BDRVVHDXState *s)
         goto exit;
     }
 
-    le64_to_cpus(&s->virtual_disk_size);
-    le32_to_cpus(&s->logical_sector_size);
-    le32_to_cpus(&s->physical_sector_size);
+    s->virtual_disk_size = le64_to_cpu(s->virtual_disk_size);
+    s->logical_sector_size = le32_to_cpu(s->logical_sector_size);
+    s->physical_sector_size = le32_to_cpu(s->physical_sector_size);
 
     if (s->params.block_size < VHDX_BLOCK_SIZE_MIN ||
         s->params.block_size > VHDX_BLOCK_SIZE_MAX) {
@@ -985,7 +985,7 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
     /* endian convert, and verify populated BAT field file offsets against
      * region table and log entries */
     for (i = 0; i < s->bat_entries; i++) {
-        le64_to_cpus(&s->bat[i]);
+        s->bat[i] = le64_to_cpu(s->bat[i]);
         if (payblocks--) {
             /* payload bat entries */
             if ((s->bat[i] & VHDX_BAT_STATE_BIT_MASK) ==
@@ -1509,7 +1509,7 @@ static int vhdx_create_new_metadata(BlockBackend *blk,
     mt_file_params->block_size = cpu_to_le32(block_size);
     if (type == VHDX_TYPE_FIXED) {
         mt_file_params->data_bits |= VHDX_PARAMS_LEAVE_BLOCKS_ALLOCED;
-        cpu_to_le32s(&mt_file_params->data_bits);
+        mt_file_params->data_bits = cpu_to_le32(mt_file_params->data_bits);
     }
 
     vhdx_guid_generate(&mt_page83->page_83_data);
@@ -1656,7 +1656,7 @@ static int vhdx_create_bat(BlockBackend *blk, BDRVVHDXState *s,
             sinfo.file_offset = ROUND_UP(sinfo.file_offset, MiB);
             vhdx_update_bat_table_entry(blk_bs(blk), s, &sinfo, &unused, &unused,
                                         block_state);
-            cpu_to_le64s(&s->bat[sinfo.bat_idx]);
+            s->bat[sinfo.bat_idx] = cpu_to_le64(s->bat[sinfo.bat_idx]);
             sector_num += s->sectors_per_block;
         }
         ret = blk_pwrite(blk, file_offset, s->bat, length, 0);
-- 
2.19.0
