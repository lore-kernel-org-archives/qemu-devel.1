Received: from eggs.gnu.org ([2001:4830:134:3::10]:55847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ceLjX-00040u-C6
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:04:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ceLjU-00056t-V1
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:04:27 -0500
Date: Thu, 16 Feb 2017 21:04:09 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170216130409.GA28784@lemon.lan>
References: <1486979689-230770-1-git-send-email-vsementsov@virtuozzo.com>
	<1486979689-230770-13-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486979689-230770-13-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 12/17] migration: add postcopy migration of
 dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

On Mon, 02/13 12:54, Vladimir Sementsov-Ogievskiy wrote:
> Postcopy migration of dirty bitmaps. Only named dirty bitmaps,
> associated with root nodes and non-root named nodes are migrated.
> 
> If destination qemu is already containing a dirty bitmap with the same name
> as a migrated bitmap (for the same node), than, if their granularities are

s/than/then/

> the same the migration will be done, otherwise the error will be generated.
> 
> If destination qemu doesn't contain such bitmap it will be created.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> +#include "qemu/osdep.h"
> +#include "block/block.h"
> +#include "block/block_int.h"
> +#include "sysemu/block-backend.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/error-report.h"
> +#include "migration/block.h"
> +#include "migration/migration.h"
> +#include "qemu/hbitmap.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/cutils.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +#include <assert.h>

Please drop this line since "assert.h" is already included in osdep.h. (And
system headers, if any, ought to be included before local headers.)

> +
> +#define CHUNK_SIZE     (1 << 10)
> +
> +/* Flags occupy from one to four bytes. In all but one the 7-th (EXTRA_FLAGS)
> + * bit should be set. */
> +#define DIRTY_BITMAP_MIG_FLAG_EOS           0x01
> +#define DIRTY_BITMAP_MIG_FLAG_ZEROES        0x02
> +#define DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME   0x04
> +#define DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME   0x08
> +#define DIRTY_BITMAP_MIG_FLAG_START         0x10
> +#define DIRTY_BITMAP_MIG_FLAG_COMPLETE      0x20
> +#define DIRTY_BITMAP_MIG_FLAG_BITS          0x40
> +
> +#define DIRTY_BITMAP_MIG_EXTRA_FLAGS        0x80
> +#define DIRTY_BITMAP_MIG_FLAGS_SIZE_16      0x8000

This flag means two bytes, right? But your above comment says "7-th bit should
be set". This doesn't make sense. Should this be "0x80" too?

> +#define DIRTY_BITMAP_MIG_FLAGS_SIZE_32      0x8080
> +
> +#define DEBUG_DIRTY_BITMAP_MIGRATION 0

This macro is unused, and you have done well in adding trace point, should it be
removed?

> +
> +typedef struct DirtyBitmapMigBitmapState {
> +    /* Written during setup phase. */
> +    BlockDriverState *bs;
> +    const char *node_name;
> +    BdrvDirtyBitmap *bitmap;
> +    uint64_t total_sectors;
> +    uint64_t sectors_per_chunk;
> +    QSIMPLEQ_ENTRY(DirtyBitmapMigBitmapState) entry;
> +
> +    /* For bulk phase. */
> +    bool bulk_completed;
> +    uint64_t cur_sector;
> +} DirtyBitmapMigBitmapState;
> +
> +typedef struct DirtyBitmapMigState {
> +    QSIMPLEQ_HEAD(dbms_list, DirtyBitmapMigBitmapState) dbms_list;
> +
> +    bool bulk_completed;
> +
> +    /* for send_bitmap_bits() */
> +    BlockDriverState *prev_bs;
> +    BdrvDirtyBitmap *prev_bitmap;
> +} DirtyBitmapMigState;
> +
> +typedef struct DirtyBitmapLoadState {
> +    uint32_t flags;
> +    char node_name[256];
> +    char bitmap_name[256];
> +    BlockDriverState *bs;
> +    BdrvDirtyBitmap *bitmap;
> +} DirtyBitmapLoadState;
> +
> +static DirtyBitmapMigState dirty_bitmap_mig_state;
> +
> +typedef struct DirtyBitmapLoadBitmapState {
> +    BlockDriverState *bs;
> +    BdrvDirtyBitmap *bitmap;
> +    bool migrated;
> +} DirtyBitmapLoadBitmapState;
> +static GSList *enabled_bitmaps;
> +QemuMutex finish_lock;
> +
> +void init_dirty_bitmap_incoming_migration(void)
> +{
> +    qemu_mutex_init(&finish_lock);
> +}
> +
> +static uint32_t qemu_get_bitmap_flags(QEMUFile *f)
> +{
> +    uint8_t flags = qemu_get_byte(f);
> +    if (flags & DIRTY_BITMAP_MIG_EXTRA_FLAGS) {
> +        flags = flags << 8 | qemu_get_byte(f);
> +        if (flags & DIRTY_BITMAP_MIG_EXTRA_FLAGS) {
> +            flags = flags << 16 | qemu_get_be16(f);
> +        }
> +    }
> +
> +    return flags;
> +}
> +
> +static void qemu_put_bitmap_flags(QEMUFile *f, uint32_t flags)
> +{
> +    if (!(flags & 0xffffff00)) {
> +        qemu_put_byte(f, flags);

Maybe "assert(!(flags & 0x80))",

> +        return;
> +    }
> +
> +    if (!(flags & 0xffff0000)) {
> +        qemu_put_be16(f, flags | DIRTY_BITMAP_MIG_FLAGS_SIZE_16);
> +        return;
> +    }
> +
> +    qemu_put_be32(f, flags | DIRTY_BITMAP_MIG_FLAGS_SIZE_32);
> +}
> +
> +static void send_bitmap_header(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
> +                               uint32_t additional_flags)
> +{
> +    BlockDriverState *bs = dbms->bs;
> +    BdrvDirtyBitmap *bitmap = dbms->bitmap;
> +    uint32_t flags = additional_flags;
> +    trace_send_bitmap_header_enter();
> +
> +    if (bs != dirty_bitmap_mig_state.prev_bs) {
> +        dirty_bitmap_mig_state.prev_bs = bs;
> +        flags |= DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME;
> +    }
> +
> +    if (bitmap != dirty_bitmap_mig_state.prev_bitmap) {
> +        dirty_bitmap_mig_state.prev_bitmap = bitmap;
> +        flags |= DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME;
> +    }
> +
> +    qemu_put_bitmap_flags(f, flags);
> +
> +    if (flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
> +        qemu_put_counted_string(f, dbms->node_name);
> +    }
> +
> +    if (flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
> +        qemu_put_counted_string(f, bdrv_dirty_bitmap_name(bitmap));
> +    }
> +}
> +
> +static void send_bitmap_start(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
> +{
> +    send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG_START);
> +    qemu_put_be32(f, bdrv_dirty_bitmap_granularity(dbms->bitmap));
> +    qemu_put_byte(f, bdrv_dirty_bitmap_enabled(dbms->bitmap));
> +}
> +
> +static void send_bitmap_complete(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
> +{
> +    send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG_COMPLETE);
> +}
> +
> +static void send_bitmap_bits(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
> +                             uint64_t start_sector, uint32_t nr_sectors)
> +{
> +    /* align for buffer_is_zero() */
> +    uint64_t align = 4 * sizeof(long);
> +    uint64_t unaligned_size =
> +        bdrv_dirty_bitmap_serialization_size(dbms->bitmap,
> +                                             start_sector, nr_sectors);
> +    uint64_t buf_size = (unaligned_size + align - 1) & ~(align - 1);
> +    uint8_t *buf = g_malloc0(buf_size);
> +    uint32_t flags = DIRTY_BITMAP_MIG_FLAG_BITS;
> +
> +    bdrv_dirty_bitmap_serialize_part(dbms->bitmap, buf,
> +                                     start_sector, nr_sectors);

While these bdrv_dirty_bitmap_* calls here seem fine, BdrvDirtyBitmap API is not
in general thread-safe, while this function is called without any lock. This
feels dangerous, as noted below, I'm most concerned about use-after-free.

> +
> +    if (buffer_is_zero(buf, buf_size)) {
> +        g_free(buf);
> +        buf = NULL;
> +        flags |= DIRTY_BITMAP_MIG_FLAG_ZEROES;
> +    }
> +
> +    trace_send_bitmap_bits(flags, start_sector, nr_sectors, buf_size);
> +
> +    send_bitmap_header(f, dbms, flags);
> +
> +    qemu_put_be64(f, start_sector);
> +    qemu_put_be32(f, nr_sectors);
> +
> +    /* if a block is zero we need to flush here since the network
> +     * bandwidth is now a lot higher than the storage device bandwidth.
> +     * thus if we queue zero blocks we slow down the migration. */
> +    if (flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
> +        qemu_fflush(f);
> +    } else {
> +        qemu_put_be64(f, buf_size);
> +        qemu_put_buffer(f, buf, buf_size);
> +    }
> +
> +    g_free(buf);
> +}
> +
> +
> +/* Called with iothread lock taken.  */
> +
> +static void init_dirty_bitmap_migration(void)
> +{
> +    BlockDriverState *bs;
> +    BdrvDirtyBitmap *bitmap;
> +    DirtyBitmapMigBitmapState *dbms;
> +    BdrvNextIterator it;
> +    uint64_t total_bytes = 0;
> +
> +    dirty_bitmap_mig_state.bulk_completed = false;
> +    dirty_bitmap_mig_state.prev_bs = NULL;
> +    dirty_bitmap_mig_state.prev_bitmap = NULL;
> +
> +    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
> +        for (bitmap = bdrv_next_dirty_bitmap(bs, NULL); bitmap;
> +             bitmap = bdrv_next_dirty_bitmap(bs, bitmap)) {
> +            if (!bdrv_dirty_bitmap_name(bitmap)) {
> +                continue;
> +            }
> +
> +            if (!bdrv_get_device_or_node_name(bs)) {
> +                /* not named non-root node */
> +                continue;
> +            }

Moving this to the outter loop is better, no need to check dirty bitmap 

> +
> +            dbms = g_new0(DirtyBitmapMigBitmapState, 1);
> +            dbms->bs = bs;

Should we do bdrv_ref? migration/block.c references its BDSes indirectly through
BlockBackends it owns.

> +            dbms->node_name = bdrv_get_node_name(bs);
> +            if (!dbms->node_name || dbms->node_name[0] == '\0') {
> +                dbms->node_name = bdrv_get_device_name(bs);
> +            }
> +            dbms->bitmap = bitmap;

What protects the case that the bitmap is released before migration completes?

> +            dbms->total_sectors = bdrv_nb_sectors(bs);
> +            dbms->sectors_per_chunk = CHUNK_SIZE * 8 *
> +                bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
> +
> +            total_bytes +=
> +                bdrv_dirty_bitmap_serialization_size(bitmap,
> +                                                     0, dbms->total_sectors);

Please drop total_bytes as it is assigned but not used.

> +
> +            QSIMPLEQ_INSERT_TAIL(&dirty_bitmap_mig_state.dbms_list,
> +                                 dbms, entry);
> +        }
> +    }
> +}
> +
> +/* Called with no lock taken.  */
> +static void bulk_phase_send_chunk(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
> +{
> +    uint32_t nr_sectors = MIN(dbms->total_sectors - dbms->cur_sector,
> +                             dbms->sectors_per_chunk);
> +
> +    send_bitmap_bits(f, dbms, dbms->cur_sector, nr_sectors);
> +
> +    dbms->cur_sector += nr_sectors;
> +    if (dbms->cur_sector >= dbms->total_sectors) {
> +        dbms->bulk_completed = true;
> +    }
> +}
> +
> +/* Called with no lock taken.  */
> +static void bulk_phase(QEMUFile *f, bool limit)
> +{
> +    DirtyBitmapMigBitmapState *dbms;
> +
> +    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
> +        while (!dbms->bulk_completed) {
> +            bulk_phase_send_chunk(f, dbms);
> +            if (limit && qemu_file_rate_limit(f)) {
> +                return;
> +            }
> +        }
> +    }
> +
> +    dirty_bitmap_mig_state.bulk_completed = true;
> +}
> +
> +/* Called with iothread lock taken.  */
> +static void dirty_bitmap_mig_cleanup(void)
> +{
> +    DirtyBitmapMigBitmapState *dbms;
> +
> +    while ((dbms = QSIMPLEQ_FIRST(&dirty_bitmap_mig_state.dbms_list)) != NULL) {
> +        QSIMPLEQ_REMOVE_HEAD(&dirty_bitmap_mig_state.dbms_list, entry);
> +        g_free(dbms);
> +    }
> +}
> +
> +/* for SaveVMHandlers */
> +static void dirty_bitmap_migration_cleanup(void *opaque)
> +{
> +    dirty_bitmap_mig_cleanup();
> +}
> +
> +static int dirty_bitmap_save_iterate(QEMUFile *f, void *opaque)
> +{
> +    trace_dirty_bitmap_save_iterate(
> +            migration_in_postcopy(migrate_get_current()));
> +
> +    if (migration_in_postcopy(migrate_get_current()) &&
> +        !dirty_bitmap_mig_state.bulk_completed) {
> +        bulk_phase(f, true);
> +    }
> +
> +    qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EOS);
> +
> +    return dirty_bitmap_mig_state.bulk_completed;
> +}
> +
> +/* Called with iothread lock taken.  */
> +
> +static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
> +{
> +    DirtyBitmapMigBitmapState *dbms;
> +    trace_dirty_bitmap_save_complete_enter();
> +
> +    if (!dirty_bitmap_mig_state.bulk_completed) {
> +        bulk_phase(f, false);
> +    }
> +
> +    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
> +        send_bitmap_complete(f, dbms);
> +    }
> +
> +    qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EOS);
> +
> +    trace_dirty_bitmap_save_complete_finish();
> +
> +    dirty_bitmap_mig_cleanup();
> +    return 0;
> +}
> +
> +static void dirty_bitmap_save_pending(QEMUFile *f, void *opaque,
> +                                      uint64_t max_size,
> +                                      uint64_t *res_precopy_only,
> +                                      uint64_t *res_compatible,
> +                                      uint64_t *res_postcopy_only)
> +{
> +    DirtyBitmapMigBitmapState *dbms;
> +    uint64_t pending = 0;
> +
> +    qemu_mutex_lock_iothread();

Why do you need the BQL here but not in bulk_phase()?

> +
> +    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
> +        uint64_t gran = bdrv_dirty_bitmap_granularity(dbms->bitmap);
> +        uint64_t sectors = dbms->bulk_completed ? 0 :
> +                           dbms->total_sectors - dbms->cur_sector;
> +
> +        pending += (sectors * BDRV_SECTOR_SIZE + gran - 1) / gran;
> +    }
> +
> +    qemu_mutex_unlock_iothread();
> +
> +    trace_dirty_bitmap_save_pending(pending, max_size);
> +
> +    *res_postcopy_only += pending;
> +}
> +
> +/* First occurrence of this bitmap. It should be created if doesn't exist */
> +static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)
> +{
> +    Error *local_err = NULL;
> +    uint32_t granularity = qemu_get_be32(f);
> +    bool enabled = qemu_get_byte(f);
> +
> +    if (!s->bitmap) {
> +        s->bitmap = bdrv_create_dirty_bitmap(s->bs, granularity,
> +                                             s->bitmap_name, &local_err);
> +        if (!s->bitmap) {
> +            error_report_err(local_err);
> +            return -EINVAL;
> +        }
> +    } else {
> +        uint32_t dest_granularity =
> +            bdrv_dirty_bitmap_granularity(s->bitmap);
> +        if (dest_granularity != granularity) {
> +            fprintf(stderr,

error_report please, to be consistent with the error_report_err above. Applies
to some other places in this patch, too.

> +                    "Error: "
> +                    "Migrated bitmap granularity (%" PRIu32 ") "
> +                    "doesn't match the destination bitmap '%s' "
> +                    "granularity (%" PRIu32 ")\n",
> +                    granularity,
> +                    bdrv_dirty_bitmap_name(s->bitmap),
> +                    dest_granularity);
> +            return -EINVAL;
> +        }
> +    }
> +
> +    bdrv_disable_dirty_bitmap(s->bitmap);
> +    if (enabled) {
> +        DirtyBitmapLoadBitmapState *b;
> +
> +        bdrv_dirty_bitmap_create_successor(s->bs, s->bitmap, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return -EINVAL;
> +        }
> +
> +        b = g_new(DirtyBitmapLoadBitmapState, 1);
> +        b->bs = s->bs;
> +        b->bitmap = s->bitmap;
> +        b->migrated = false;
> +        enabled_bitmaps = g_slist_prepend(enabled_bitmaps, b);
> +    }
> +
> +    return 0;
> +}
> +
> +void dirty_bitmap_mig_before_vm_start(void)
> +{
> +    GSList *item;
> +
> +    qemu_mutex_lock(&finish_lock);
> +
> +    for (item = enabled_bitmaps; item; item = g_slist_next(item)) {
> +        DirtyBitmapLoadBitmapState *b = item->data;
> +
> +        if (b->migrated) {
> +            bdrv_enable_dirty_bitmap(b->bitmap);
> +        } else {
> +            bdrv_dirty_bitmap_enable_successor(b->bitmap);
> +        }
> +
> +        g_free(b);
> +    }
> +
> +    g_slist_free(enabled_bitmaps);
> +    enabled_bitmaps = NULL;
> +
> +    qemu_mutex_unlock(&finish_lock);
> +}
> +
> +static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
> +{
> +    GSList *item;
> +    trace_dirty_bitmap_load_complete();
> +    bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
> +
> +    qemu_mutex_lock(&finish_lock);
> +
> +    for (item = enabled_bitmaps; item; item = g_slist_next(item)) {
> +        DirtyBitmapLoadBitmapState *b = item->data;
> +
> +        if (b->bitmap == s->bitmap) {
> +            b->migrated = true;
> +        }
> +    }
> +
> +    if (bdrv_dirty_bitmap_frozen(s->bitmap)) {
> +        if (enabled_bitmaps == NULL) {
> +            /* in postcopy */
> +            AioContext *aio_context = bdrv_get_aio_context(s->bs);
> +            aio_context_acquire(aio_context);
> +
> +            bdrv_reclaim_dirty_bitmap(s->bs, s->bitmap, &error_abort);
> +            bdrv_enable_dirty_bitmap(s->bitmap);
> +
> +            aio_context_release(aio_context);
> +        } else {
> +            /* target not started, successor is empty */
> +            bdrv_dirty_bitmap_release_successor(s->bs, s->bitmap);
> +        }
> +    }
> +
> +    qemu_mutex_unlock(&finish_lock);
> +}
> +
> +static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState *s)
> +{
> +    uint64_t first_sector = qemu_get_be64(f);
> +    uint32_t nr_sectors = qemu_get_be32(f);
> +    trace_dirty_bitmap_load_bits_enter(first_sector, nr_sectors);
> +
> +    if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
> +        trace_dirty_bitmap_load_bits_zeroes();
> +        bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_sector,
> +                                             nr_sectors, false);
> +    } else {
> +        uint8_t *buf;
> +        uint64_t buf_size = qemu_get_be64(f);
> +        uint64_t needed_size =
> +            bdrv_dirty_bitmap_serialization_size(s->bitmap,
> +                                                 first_sector, nr_sectors);
> +
> +        if (needed_size > buf_size) {
> +            fprintf(stderr,
> +                    "Error: Migrated bitmap granularity doesn't "
> +                    "match the destination bitmap '%s' granularity\n",
> +                    bdrv_dirty_bitmap_name(s->bitmap));
> +            return -EINVAL;
> +        }
> +
> +        buf = g_malloc(buf_size);
> +        qemu_get_buffer(f, buf, buf_size);
> +        bdrv_dirty_bitmap_deserialize_part(s->bitmap, buf,
> +                                           first_sector,
> +                                           nr_sectors, false);
> +        g_free(buf);
> +    }
> +
> +    return 0;
> +}
> +
> +static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
> +{
> +    Error *local_err = NULL;
> +    s->flags = qemu_get_bitmap_flags(f);
> +    trace_dirty_bitmap_load_header(s->flags);
> +
> +    if (s->flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
> +        if (!qemu_get_counted_string(f, s->node_name)) {
> +            fprintf(stderr, "Unable to read node name string\n");
> +            return -EINVAL;
> +        }
> +        s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
> +        if (!s->bs) {
> +            error_report("%s", error_get_pretty(local_err));
> +            error_free(local_err);
> +            return -EINVAL;
> +        }
> +    } else if (!s->bs) {
> +        fprintf(stderr, "Error: block device name is not set\n");
> +        return -EINVAL;
> +    }
> +
> +    if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
> +        if (!qemu_get_counted_string(f, s->bitmap_name)) {
> +            fprintf(stderr, "Unable to read node name string\n");
> +            return -EINVAL;
> +        }
> +        s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
> +
> +        /* bitmap may be NULL here, it wouldn't be an error if it is the
> +         * first occurrence of the bitmap */
> +        if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
> +            fprintf(stderr, "Error: unknown dirty bitmap "
> +                    "'%s' for block device '%s'\n",
> +                    s->bitmap_name, s->node_name);
> +            return -EINVAL;
> +        }
> +    } else if (!s->bitmap) {
> +        fprintf(stderr, "Error: block device name is not set\n");
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
> +{
> +    static DirtyBitmapLoadState s;
> +
> +    int ret = 0;
> +
> +    trace_dirty_bitmap_load_enter();
> +

Should version_id be checked? We should detect a version bump of a future
release and fail if not supported.

> +    do {
> +        dirty_bitmap_load_header(f, &s);
> +
> +        if (s.flags & DIRTY_BITMAP_MIG_FLAG_START) {
> +            ret = dirty_bitmap_load_start(f, &s);
> +        } else if (s.flags & DIRTY_BITMAP_MIG_FLAG_COMPLETE) {
> +            dirty_bitmap_load_complete(f, &s);
> +        } else if (s.flags & DIRTY_BITMAP_MIG_FLAG_BITS) {
> +            ret = dirty_bitmap_load_bits(f, &s);
> +        }
> +
> +        if (!ret) {
> +            ret = qemu_file_get_error(f);
> +        }
> +
> +        if (ret) {
> +            return ret;
> +        }
> +    } while (!(s.flags & DIRTY_BITMAP_MIG_FLAG_EOS));
> +
> +    trace_dirty_bitmap_load_success();
> +    return 0;
> +}
> +
> +static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
> +{
> +    DirtyBitmapMigBitmapState *dbms = NULL;
> +    init_dirty_bitmap_migration();
> +
> +    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
> +        send_bitmap_start(f, dbms);
> +    }
> +    qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EOS);
> +
> +    return 0;
> +}
> +
> +static bool dirty_bitmap_is_active(void *opaque)
> +{
> +    return migrate_dirty_bitmaps();
> +}
> +
> +static bool dirty_bitmap_is_active_iterate(void *opaque)
> +{
> +    return dirty_bitmap_is_active(opaque) && !runstate_is_running();
> +}
> +

Fam
