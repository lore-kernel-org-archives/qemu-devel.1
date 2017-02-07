Received: from eggs.gnu.org ([2001:4830:134:3::10]:57869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cb7LB-0000Xo-Qt
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cb7L5-00079s-1V
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:05:57 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  7 Feb 2017 18:05:35 +0300
Message-Id: <1486479940-163258-13-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1486479940-163258-1-git-send-email-vsementsov@virtuozzo.com>
References: <1486479940-163258-1-git-send-email-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 12/17] migration: add postcopy migration of
 dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, vsementsov@virtuozzo.com, lirans@il.ibm.com

Postcopy migration of dirty bitmaps. Only named dirty bitmaps,
associated with root nodes and non-root named nodes are migrated.

If destination qemu is already containing a dirty bitmap with the same name
as a migrated bitmap (for the same node), than, if their granularities are
the same the migration will be done, otherwise the error will be generated.

If destination qemu doesn't contain such bitmap it will be created.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/migration/block.h      |   1 +
 include/migration/migration.h  |   4 +
 migration/Makefile.objs        |   2 +-
 migration/block-dirty-bitmap.c | 679 +++++++++++++++++++++++++++++++++++++++++
 migration/migration.c          |   3 +
 migration/savevm.c             |   2 +
 migration/trace-events         |  14 +
 vl.c                           |   1 +
 8 files changed, 705 insertions(+), 1 deletion(-)
 create mode 100644 migration/block-dirty-bitmap.c

diff --git a/include/migration/block.h b/include/migration/block.h
index 41a1ac8..8333c43 100644
--- a/include/migration/block.h
+++ b/include/migration/block.h
@@ -14,6 +14,7 @@
 #ifndef MIGRATION_BLOCK_H
 #define MIGRATION_BLOCK_H
 
+void dirty_bitmap_mig_init(void);
 void blk_mig_init(void);
 int blk_mig_active(void);
 uint64_t blk_mig_bytes_transferred(void);
diff --git a/include/migration/migration.h b/include/migration/migration.h
index 38eba2e..9915e2d 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -372,4 +372,8 @@ int ram_save_queue_pages(MigrationState *ms, const char *rbname,
 PostcopyState postcopy_state_get(void);
 /* Set the state and return the old state */
 PostcopyState postcopy_state_set(PostcopyState new_state);
+
+void dirty_bitmap_mig_before_vm_start(void);
+void init_dirty_bitmap_incoming_migration(void);
+
 #endif
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index 480dd49..fa3bf6a 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -9,5 +9,5 @@ common-obj-y += qjson.o
 
 common-obj-$(CONFIG_RDMA) += rdma.o
 
-common-obj-y += block.o
+common-obj-y += block.o block-dirty-bitmap.o
 
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
new file mode 100644
index 0000000..28e3732
--- /dev/null
+++ b/migration/block-dirty-bitmap.c
@@ -0,0 +1,679 @@
+/*
+ * Block dirty bitmap postcopy migration
+ *
+ * Copyright IBM, Corp. 2009
+ * Copyright (C) 2016 Parallels IP Holdings GmbH. All rights reserved.
+ *
+ * Authors:
+ *  Liran Schour   <lirans@il.ibm.com>
+ *  Vladimir Sementsov-Ogievskiy <vsementsov@parallels.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ * This file is derived from migration/block.c, so it's author and IBM copyright
+ * are here, although content is quite different.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ *
+ *                                ***
+ *
+ * Here postcopy migration of dirty bitmaps is realized. Only named dirty
+ * bitmaps, associated with root nodes and non-root named nodes are migrated.
+ *
+ * If destination qemu is already containing a dirty bitmap with the same name
+ * as a migrated bitmap (for the same node), then, if their granularities are
+ * the same the migration will be done, otherwise the error will be generated.
+ *
+ * If destination qemu doesn't contain such bitmap it will be created.
+ *
+ * format of migration:
+ *
+ * # Header (shared for different chunk types)
+ * 1, 2 or 4 bytes: flags (see qemu_{put,put}_flags)
+ * [ 1 byte: node name size ] \  flags & DEVICE_NAME
+ * [ n bytes: node name     ] /
+ * [ 1 byte: bitmap name size ] \  flags & BITMAP_NAME
+ * [ n bytes: bitmap name     ] /
+ *
+ * # Start of bitmap migration (flags & START)
+ * header
+ * be64: granularity
+ * 1 byte: bitmap enabled flag
+ *
+ * # Complete of bitmap migration (flags & COMPLETE)
+ * header
+ *
+ * # Data chunk of bitmap migration
+ * header
+ * be64: start sector
+ * be32: number of sectors
+ * [ be64: buffer size  ] \ ! (flags & ZEROES)
+ * [ n bytes: buffer    ] /
+ *
+ * The last chunk in stream should contain flags & EOS. The chunk may skip
+ * device and/or bitmap names, assuming them to be the same with the previous
+ * chunk.
+ */
+
+#include "qemu/osdep.h"
+#include "block/block.h"
+#include "block/block_int.h"
+#include "sysemu/block-backend.h"
+#include "qemu/main-loop.h"
+#include "qemu/error-report.h"
+#include "migration/block.h"
+#include "migration/migration.h"
+#include "qemu/hbitmap.h"
+#include "sysemu/sysemu.h"
+#include "qemu/cutils.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include <assert.h>
+
+#define CHUNK_SIZE     (1 << 10)
+
+/* Flags occupy from one to four bytes. In all but one the 7-th (EXTRA_FLAGS)
+ * bit should be set. */
+#define DIRTY_BITMAP_MIG_FLAG_EOS           0x01
+#define DIRTY_BITMAP_MIG_FLAG_ZEROES        0x02
+#define DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME   0x04
+#define DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME   0x08
+#define DIRTY_BITMAP_MIG_FLAG_START         0x10
+#define DIRTY_BITMAP_MIG_FLAG_COMPLETE      0x20
+#define DIRTY_BITMAP_MIG_FLAG_BITS          0x40
+
+#define DIRTY_BITMAP_MIG_EXTRA_FLAGS        0x80
+#define DIRTY_BITMAP_MIG_FLAGS_SIZE_16      0x8000
+#define DIRTY_BITMAP_MIG_FLAGS_SIZE_32      0x8080
+
+#define DEBUG_DIRTY_BITMAP_MIGRATION 0
+
+typedef struct DirtyBitmapMigBitmapState {
+    /* Written during setup phase. */
+    BlockDriverState *bs;
+    const char *node_name;
+    BdrvDirtyBitmap *bitmap;
+    uint64_t total_sectors;
+    uint64_t sectors_per_chunk;
+    QSIMPLEQ_ENTRY(DirtyBitmapMigBitmapState) entry;
+
+    /* For bulk phase. */
+    bool bulk_completed;
+    uint64_t cur_sector;
+} DirtyBitmapMigBitmapState;
+
+typedef struct DirtyBitmapMigState {
+    QSIMPLEQ_HEAD(dbms_list, DirtyBitmapMigBitmapState) dbms_list;
+
+    bool bulk_completed;
+
+    /* for send_bitmap_bits() */
+    BlockDriverState *prev_bs;
+    BdrvDirtyBitmap *prev_bitmap;
+} DirtyBitmapMigState;
+
+typedef struct DirtyBitmapLoadState {
+    uint32_t flags;
+    char node_name[256];
+    char bitmap_name[256];
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
+} DirtyBitmapLoadState;
+
+static DirtyBitmapMigState dirty_bitmap_mig_state;
+
+typedef struct DirtyBitmapLoadBitmapState {
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
+    bool migrated;
+} DirtyBitmapLoadBitmapState;
+static GSList *enabled_bitmaps;
+QemuMutex finish_lock;
+
+void init_dirty_bitmap_incoming_migration(void)
+{
+    qemu_mutex_init(&finish_lock);
+}
+
+static uint32_t qemu_get_bitmap_flags(QEMUFile *f)
+{
+    uint8_t flags = qemu_get_byte(f);
+    if (flags & DIRTY_BITMAP_MIG_EXTRA_FLAGS) {
+        flags = flags << 8 | qemu_get_byte(f);
+        if (flags & DIRTY_BITMAP_MIG_EXTRA_FLAGS) {
+            flags = flags << 16 | qemu_get_be16(f);
+        }
+    }
+
+    return flags;
+}
+
+static void qemu_put_bitmap_flags(QEMUFile *f, uint32_t flags)
+{
+    if (!(flags & 0xffffff00)) {
+        qemu_put_byte(f, flags);
+        return;
+    }
+
+    if (!(flags & 0xffff0000)) {
+        qemu_put_be16(f, flags | DIRTY_BITMAP_MIG_FLAGS_SIZE_16);
+        return;
+    }
+
+    qemu_put_be32(f, flags | DIRTY_BITMAP_MIG_FLAGS_SIZE_32);
+}
+
+static void send_bitmap_header(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
+                               uint32_t additional_flags)
+{
+    BlockDriverState *bs = dbms->bs;
+    BdrvDirtyBitmap *bitmap = dbms->bitmap;
+    uint32_t flags = additional_flags;
+    trace_send_bitmap_header_enter();
+
+    if (bs != dirty_bitmap_mig_state.prev_bs) {
+        dirty_bitmap_mig_state.prev_bs = bs;
+        flags |= DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME;
+    }
+
+    if (bitmap != dirty_bitmap_mig_state.prev_bitmap) {
+        dirty_bitmap_mig_state.prev_bitmap = bitmap;
+        flags |= DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME;
+    }
+
+    qemu_put_bitmap_flags(f, flags);
+
+    if (flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
+        qemu_put_counted_string(f, dbms->node_name);
+    }
+
+    if (flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
+        qemu_put_counted_string(f, bdrv_dirty_bitmap_name(bitmap));
+    }
+}
+
+static void send_bitmap_start(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
+{
+    send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG_START);
+    qemu_put_be32(f, bdrv_dirty_bitmap_granularity(dbms->bitmap));
+    qemu_put_byte(f, bdrv_dirty_bitmap_enabled(dbms->bitmap));
+}
+
+static void send_bitmap_complete(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
+{
+    send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG_COMPLETE);
+}
+
+static void send_bitmap_bits(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
+                             uint64_t start_sector, uint32_t nr_sectors)
+{
+    /* align for buffer_is_zero() */
+    uint64_t align = 4 * sizeof(long);
+    uint64_t unaligned_size =
+        bdrv_dirty_bitmap_serialization_size(dbms->bitmap,
+                                             start_sector, nr_sectors);
+    uint64_t buf_size = (unaligned_size + align - 1) & ~(align - 1);
+    uint8_t *buf = g_malloc0(buf_size);
+    uint32_t flags = DIRTY_BITMAP_MIG_FLAG_BITS;
+
+    bdrv_dirty_bitmap_serialize_part(dbms->bitmap, buf,
+                                     start_sector, nr_sectors);
+
+    if (buffer_is_zero(buf, buf_size)) {
+        g_free(buf);
+        buf = NULL;
+        flags |= DIRTY_BITMAP_MIG_FLAG_ZEROES;
+    }
+
+    trace_send_bitmap_bits(flags, start_sector, nr_sectors, buf_size);
+
+    send_bitmap_header(f, dbms, flags);
+
+    qemu_put_be64(f, start_sector);
+    qemu_put_be32(f, nr_sectors);
+
+    /* if a block is zero we need to flush here since the network
+     * bandwidth is now a lot higher than the storage device bandwidth.
+     * thus if we queue zero blocks we slow down the migration. */
+    if (flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
+        qemu_fflush(f);
+    } else {
+        qemu_put_be64(f, buf_size);
+        qemu_put_buffer(f, buf, buf_size);
+    }
+
+    g_free(buf);
+}
+
+
+/* Called with iothread lock taken.  */
+
+static void init_dirty_bitmap_migration(void)
+{
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
+    DirtyBitmapMigBitmapState *dbms;
+    BdrvNextIterator it;
+    uint64_t total_bytes = 0;
+
+    dirty_bitmap_mig_state.bulk_completed = false;
+    dirty_bitmap_mig_state.prev_bs = NULL;
+    dirty_bitmap_mig_state.prev_bitmap = NULL;
+
+    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
+        for (bitmap = bdrv_next_dirty_bitmap(bs, NULL); bitmap;
+             bitmap = bdrv_next_dirty_bitmap(bs, bitmap)) {
+            if (!bdrv_dirty_bitmap_name(bitmap)) {
+                continue;
+            }
+
+            if (!bdrv_get_device_or_node_name(bs)) {
+                /* not named non-root node */
+                continue;
+            }
+
+            dbms = g_new0(DirtyBitmapMigBitmapState, 1);
+            dbms->bs = bs;
+            dbms->node_name = bdrv_get_node_name(bs);
+            if (!dbms->node_name || dbms->node_name[0] == '\0') {
+                dbms->node_name = bdrv_get_device_name(bs);
+            }
+            dbms->bitmap = bitmap;
+            dbms->total_sectors = bdrv_nb_sectors(bs);
+            dbms->sectors_per_chunk = CHUNK_SIZE * 8 *
+                bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
+
+            total_bytes +=
+                bdrv_dirty_bitmap_serialization_size(bitmap,
+                                                     0, dbms->total_sectors);
+
+            QSIMPLEQ_INSERT_TAIL(&dirty_bitmap_mig_state.dbms_list,
+                                 dbms, entry);
+        }
+    }
+}
+
+/* Called with no lock taken.  */
+static void bulk_phase_send_chunk(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
+{
+    uint32_t nr_sectors = MIN(dbms->total_sectors - dbms->cur_sector,
+                             dbms->sectors_per_chunk);
+
+    send_bitmap_bits(f, dbms, dbms->cur_sector, nr_sectors);
+
+    dbms->cur_sector += nr_sectors;
+    if (dbms->cur_sector >= dbms->total_sectors) {
+        dbms->bulk_completed = true;
+    }
+}
+
+/* Called with no lock taken.  */
+static void bulk_phase(QEMUFile *f, bool limit)
+{
+    DirtyBitmapMigBitmapState *dbms;
+
+    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
+        while (!dbms->bulk_completed) {
+            bulk_phase_send_chunk(f, dbms);
+            if (limit && qemu_file_rate_limit(f)) {
+                return;
+            }
+        }
+    }
+
+    dirty_bitmap_mig_state.bulk_completed = true;
+}
+
+/* Called with iothread lock taken.  */
+static void dirty_bitmap_mig_cleanup(void)
+{
+    DirtyBitmapMigBitmapState *dbms;
+
+    while ((dbms = QSIMPLEQ_FIRST(&dirty_bitmap_mig_state.dbms_list)) != NULL) {
+        QSIMPLEQ_REMOVE_HEAD(&dirty_bitmap_mig_state.dbms_list, entry);
+        g_free(dbms);
+    }
+}
+
+/* for SaveVMHandlers */
+static void dirty_bitmap_migration_cleanup(void *opaque)
+{
+    dirty_bitmap_mig_cleanup();
+}
+
+static int dirty_bitmap_save_iterate(QEMUFile *f, void *opaque)
+{
+    trace_dirty_bitmap_save_iterate(
+            migration_in_postcopy(migrate_get_current()));
+
+    if (migration_in_postcopy(migrate_get_current()) &&
+        !dirty_bitmap_mig_state.bulk_completed) {
+        bulk_phase(f, true);
+    }
+
+    qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EOS);
+
+    return dirty_bitmap_mig_state.bulk_completed;
+}
+
+/* Called with iothread lock taken.  */
+
+static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
+{
+    DirtyBitmapMigBitmapState *dbms;
+    trace_dirty_bitmap_save_complete_enter();
+
+    if (!dirty_bitmap_mig_state.bulk_completed) {
+        bulk_phase(f, false);
+    }
+
+    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
+        send_bitmap_complete(f, dbms);
+    }
+
+    qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EOS);
+
+    trace_dirty_bitmap_save_complete_finish();
+
+    dirty_bitmap_mig_cleanup();
+    return 0;
+}
+
+static void dirty_bitmap_save_pending(QEMUFile *f, void *opaque,
+                                      uint64_t max_size,
+                                      uint64_t *res_precopy_only,
+                                      uint64_t *res_compatible,
+                                      uint64_t *res_postcopy_only)
+{
+    DirtyBitmapMigBitmapState *dbms;
+    uint64_t pending = 0;
+
+    qemu_mutex_lock_iothread();
+
+    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
+        uint64_t gran = bdrv_dirty_bitmap_granularity(dbms->bitmap);
+        uint64_t sectors = dbms->bulk_completed ? 0 :
+                           dbms->total_sectors - dbms->cur_sector;
+
+        pending += (sectors * BDRV_SECTOR_SIZE + gran - 1) / gran;
+    }
+
+    qemu_mutex_unlock_iothread();
+
+    trace_dirty_bitmap_save_pending(pending, max_size);
+
+    *res_postcopy_only += pending;
+}
+
+/* First occurrence of this bitmap. It should be created if doesn't exist */
+static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)
+{
+    Error *local_err = NULL;
+    uint32_t granularity = qemu_get_be32(f);
+    bool enabled = qemu_get_byte(f);
+
+    if (!s->bitmap) {
+        s->bitmap = bdrv_create_dirty_bitmap(s->bs, granularity,
+                                             s->bitmap_name, &local_err);
+        if (!s->bitmap) {
+            error_report_err(local_err);
+            return -EINVAL;
+        }
+    } else {
+        uint32_t dest_granularity =
+            bdrv_dirty_bitmap_granularity(s->bitmap);
+        if (dest_granularity != granularity) {
+            fprintf(stderr,
+                    "Error: "
+                    "Migrated bitmap granularity (%" PRIu32 ") "
+                    "doesn't match the destination bitmap '%s' "
+                    "granularity (%" PRIu32 ")\n",
+                    granularity,
+                    bdrv_dirty_bitmap_name(s->bitmap),
+                    dest_granularity);
+            return -EINVAL;
+        }
+    }
+
+    bdrv_disable_dirty_bitmap(s->bitmap);
+    if (enabled) {
+        DirtyBitmapLoadBitmapState *b;
+
+        bdrv_dirty_bitmap_create_successor(s->bs, s->bitmap, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return -EINVAL;
+        }
+
+        b = g_new(DirtyBitmapLoadBitmapState, 1);
+        b->bs = s->bs;
+        b->bitmap = s->bitmap;
+        b->migrated = false;
+        enabled_bitmaps = g_slist_prepend(enabled_bitmaps, b);
+    }
+
+    return 0;
+}
+
+void dirty_bitmap_mig_before_vm_start(void)
+{
+    GSList *item;
+
+    qemu_mutex_lock(&finish_lock);
+
+    for (item = enabled_bitmaps; item; item = g_slist_next(item)) {
+        DirtyBitmapLoadBitmapState *b = item->data;
+
+        if (b->migrated) {
+            bdrv_enable_dirty_bitmap(b->bitmap);
+        } else {
+            bdrv_dirty_bitmap_enable_successor(b->bitmap);
+        }
+
+        g_free(b);
+    }
+
+    g_slist_free(enabled_bitmaps);
+    enabled_bitmaps = NULL;
+
+    qemu_mutex_unlock(&finish_lock);
+}
+
+static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
+{
+    GSList *item;
+    trace_dirty_bitmap_load_complete();
+    bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
+
+    qemu_mutex_lock(&finish_lock);
+
+    for (item = enabled_bitmaps; item; item = g_slist_next(item)) {
+        DirtyBitmapLoadBitmapState *b = item->data;
+
+        if (b->bitmap == s->bitmap) {
+            b->migrated = true;
+        }
+    }
+
+    if (bdrv_dirty_bitmap_frozen(s->bitmap)) {
+        if (enabled_bitmaps == NULL) {
+            /* in postcopy */
+            AioContext *aio_context = bdrv_get_aio_context(s->bs);
+            aio_context_acquire(aio_context);
+
+            bdrv_reclaim_dirty_bitmap(s->bs, s->bitmap, &error_abort);
+            bdrv_enable_dirty_bitmap(s->bitmap);
+
+            aio_context_release(aio_context);
+        } else {
+            /* target not started, successor is empty */
+            bdrv_dirty_bitmap_release_successor(s->bs, s->bitmap);
+        }
+    }
+
+    qemu_mutex_unlock(&finish_lock);
+}
+
+static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState *s)
+{
+    uint64_t first_sector = qemu_get_be64(f);
+    uint32_t nr_sectors = qemu_get_be32(f);
+    trace_dirty_bitmap_load_bits_enter(first_sector, nr_sectors);
+
+    if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
+        trace_dirty_bitmap_load_bits_zeroes();
+        bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_sector,
+                                             nr_sectors, false);
+    } else {
+        uint8_t *buf;
+        uint64_t buf_size = qemu_get_be64(f);
+        uint64_t needed_size =
+            bdrv_dirty_bitmap_serialization_size(s->bitmap,
+                                                 first_sector, nr_sectors);
+
+        if (needed_size > buf_size) {
+            fprintf(stderr,
+                    "Error: Migrated bitmap granularity doesn't "
+                    "match the destination bitmap '%s' granularity\n",
+                    bdrv_dirty_bitmap_name(s->bitmap));
+            return -EINVAL;
+        }
+
+        buf = g_malloc(buf_size);
+        qemu_get_buffer(f, buf, buf_size);
+        bdrv_dirty_bitmap_deserialize_part(s->bitmap, buf,
+                                           first_sector,
+                                           nr_sectors, false);
+        g_free(buf);
+    }
+
+    return 0;
+}
+
+static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
+{
+    Error *local_err = NULL;
+    s->flags = qemu_get_bitmap_flags(f);
+    trace_dirty_bitmap_load_header(s->flags);
+
+    if (s->flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
+        if (!qemu_get_counted_string(f, s->node_name)) {
+            fprintf(stderr, "Unable to read node name string\n");
+            return -EINVAL;
+        }
+        s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
+        if (!s->bs) {
+            error_report("%s", error_get_pretty(local_err));
+            error_free(local_err);
+            return -EINVAL;
+        }
+    } else if (!s->bs) {
+        fprintf(stderr, "Error: block device name is not set\n");
+        return -EINVAL;
+    }
+
+    if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
+        if (!qemu_get_counted_string(f, s->bitmap_name)) {
+            fprintf(stderr, "Unable to read node name string\n");
+            return -EINVAL;
+        }
+        s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
+
+        /* bitmap may be NULL here, it wouldn't be an error if it is the
+         * first occurrence of the bitmap */
+        if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
+            fprintf(stderr, "Error: unknown dirty bitmap "
+                    "'%s' for block device '%s'\n",
+                    s->bitmap_name, s->node_name);
+            return -EINVAL;
+        }
+    } else if (!s->bitmap) {
+        fprintf(stderr, "Error: block device name is not set\n");
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
+{
+    static DirtyBitmapLoadState s;
+
+    int ret = 0;
+
+    trace_dirty_bitmap_load_enter();
+
+    do {
+        dirty_bitmap_load_header(f, &s);
+
+        if (s.flags & DIRTY_BITMAP_MIG_FLAG_START) {
+            ret = dirty_bitmap_load_start(f, &s);
+        } else if (s.flags & DIRTY_BITMAP_MIG_FLAG_COMPLETE) {
+            dirty_bitmap_load_complete(f, &s);
+        } else if (s.flags & DIRTY_BITMAP_MIG_FLAG_BITS) {
+            ret = dirty_bitmap_load_bits(f, &s);
+        }
+
+        if (!ret) {
+            ret = qemu_file_get_error(f);
+        }
+
+        if (ret) {
+            return ret;
+        }
+    } while (!(s.flags & DIRTY_BITMAP_MIG_FLAG_EOS));
+
+    trace_dirty_bitmap_load_success();
+    return 0;
+}
+
+static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
+{
+    DirtyBitmapMigBitmapState *dbms = NULL;
+    init_dirty_bitmap_migration();
+
+    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
+        send_bitmap_start(f, dbms);
+    }
+    qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EOS);
+
+    return 0;
+}
+
+static bool dirty_bitmap_is_active(void *opaque)
+{
+    return migrate_dirty_bitmaps();
+}
+
+static bool dirty_bitmap_is_active_iterate(void *opaque)
+{
+    return dirty_bitmap_is_active(opaque) && !runstate_is_running();
+}
+
+static bool dirty_bitmap_has_postcopy(void *opaque)
+{
+    return true;
+}
+
+static SaveVMHandlers savevm_dirty_bitmap_handlers = {
+    .save_live_setup = dirty_bitmap_save_setup,
+    .save_live_complete_postcopy = dirty_bitmap_save_complete,
+    .save_live_complete_precopy = dirty_bitmap_save_complete,
+    .has_postcopy = dirty_bitmap_has_postcopy,
+    .save_live_pending = dirty_bitmap_save_pending,
+    .save_live_iterate = dirty_bitmap_save_iterate,
+    .is_active_iterate = dirty_bitmap_is_active_iterate,
+    .load_state = dirty_bitmap_load,
+    .cleanup = dirty_bitmap_migration_cleanup,
+    .is_active = dirty_bitmap_is_active,
+};
+
+void dirty_bitmap_mig_init(void)
+{
+    QSIMPLEQ_INIT(&dirty_bitmap_mig_state.dbms_list);
+
+    register_savevm_live(NULL, "dirty-bitmap", 0, 1,
+                         &savevm_dirty_bitmap_handlers,
+                         &dirty_bitmap_mig_state);
+}
diff --git a/migration/migration.c b/migration/migration.c
index 4716efd..221be74 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -387,6 +387,9 @@ static void process_incoming_migration_co(void *opaque)
     int ret;
 
     mis = migration_incoming_state_new(f);
+
+    init_dirty_bitmap_incoming_migration();
+
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
                       MIGRATION_STATUS_ACTIVE);
diff --git a/migration/savevm.c b/migration/savevm.c
index 94783e5..cc44e5e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1638,6 +1638,8 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 
     trace_loadvm_postcopy_handle_run_vmstart();
 
+    dirty_bitmap_mig_before_vm_start();
+
     if (autostart) {
         /* Hold onto your hats, starting the CPU */
         vm_start();
diff --git a/migration/trace-events b/migration/trace-events
index 0212929..38fca41 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -222,3 +222,17 @@ colo_vm_state_change(const char *old, const char *new) "Change '%s' => '%s'"
 colo_send_message(const char *msg) "Send '%s' message"
 colo_receive_message(const char *msg) "Receive '%s' message"
 colo_failover_set_state(const char *new_state) "new state %s"
+
+# migration/block-dirty-bitmap.c
+send_bitmap_header_enter(void) ""
+send_bitmap_bits(uint32_t flags, uint64_t start_sector, uint32_t nr_sectors, uint64_t data_size) "\n   flags:        %x\n   start_sector: %" PRIu64 "\n   nr_sectors:   %" PRIu32 "\n   data_size:    %" PRIu64 "\n"
+dirty_bitmap_save_iterate(int in_postcopy) "in postcopy: %d"
+dirty_bitmap_save_complete_enter(void) ""
+dirty_bitmap_save_complete_finish(void) ""
+dirty_bitmap_save_pending(uint64_t pending, uint64_t max_size) "pending %" PRIu64 " max: %" PRIu64
+dirty_bitmap_load_complete(void) ""
+dirty_bitmap_load_bits_enter(uint64_t first_sector, uint32_t nr_sectors) "chunk: %" PRIu64 " %" PRIu32
+dirty_bitmap_load_bits_zeroes(void) ""
+dirty_bitmap_load_header(uint32_t flags) "flags %x"
+dirty_bitmap_load_enter(void) ""
+dirty_bitmap_load_success(void) ""
diff --git a/vl.c b/vl.c
index b4eaf03..f1ee9ff 100644
--- a/vl.c
+++ b/vl.c
@@ -4405,6 +4405,7 @@ int main(int argc, char **argv, char **envp)
 
     blk_mig_init();
     ram_mig_init();
+    dirty_bitmap_mig_init();
 
     /* If the currently selected machine wishes to override the units-per-bus
      * property of its default HBA interface type, do so now. */
-- 
1.8.3.1
