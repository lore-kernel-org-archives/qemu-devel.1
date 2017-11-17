Received: from eggs.gnu.org ([2001:4830:134:3::10]:52002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFVRJ-0003Dx-DX
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 20:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFVRF-0001lw-A2
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 20:27:29 -0500
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
	<20171030163309.75770-11-vsementsov@virtuozzo.com>
	<97084802-ba48-4bc0-f106-dbeb906fd6e4@redhat.com>
	<20171116165050.GE2472@work-vm>
From: John Snow <jsnow@redhat.com>
Message-ID: <a1754568-3c02-0e79-1f1c-e657ea59ea82@redhat.com>
Date: Thu, 16 Nov 2017 20:27:03 -0500
MIME-Version: 1.0
In-Reply-To: <20171116165050.GE2472@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 10/14] migration: add postcopy migration
 of dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, famz@redhat.com, lirans@il.ibm.com, quintela@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com



On 11/16/2017 11:50 AM, Dr. David Alan Gilbert wrote:
> * John Snow (jsnow@redhat.com) wrote:
>>
>>
>> On 10/30/2017 12:33 PM, Vladimir Sementsov-Ogievskiy wrote:
>>> Postcopy migration of dirty bitmaps. Only named dirty bitmaps,
>>> associated with root nodes and non-root named nodes are migrated.
>>>
>>> If destination qemu is already containing a dirty bitmap with the same name
>>> as a migrated bitmap (for the same node), then, if their granularities are
>>> the same the migration will be done, otherwise the error will be generated.
>>>
>>> If destination qemu doesn't contain such bitmap it will be created.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>  include/migration/misc.h       |   3 +
>>>  migration/migration.h          |   3 +
>>>  migration/block-dirty-bitmap.c | 734 +++++++++++++++++++++++++++++++++++++++++
>>
>> Ouch :\
>>
>>>  migration/migration.c          |   3 +
>>>  migration/savevm.c             |   2 +
>>>  vl.c                           |   1 +
>>>  migration/Makefile.objs        |   1 +
>>>  migration/trace-events         |  14 +
>>>  8 files changed, 761 insertions(+)
>>>  create mode 100644 migration/block-dirty-bitmap.c
>>>
>>
>> Organizationally, you introduce three new 'public' prototypes:
>>
>> dirty_bitmap_mig_init
>> dirty_bitmap_mig_before_vm_start
>> init_dirty_bitmap_incoming_migration
>>
>> mig_init is advertised in migration/misc.h, the other two are in
>> migration/migration.h.
>> The definitions for all three are in migration/block-dirty-bitmap.c
>>
>> In pure naivety, I find it weird to have something that you use in
>> migration.c and advertised in migration.h actually exist separately in
>> block-dirty-bitmap.c; but maybe this is the sanest thing to do.
> 
> Actually I think that's OK; it makes sense for all of the code for this
> feature to sit in one place,   and there doesn't seem any point creating
> a header just for this one function.
> 

OK, just stood out to me at first. I don't really have better ideas.

>>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>>> index c079b7771b..9cc539e232 100644
>>> --- a/include/migration/misc.h
>>> +++ b/include/migration/misc.h
>>> @@ -55,4 +55,7 @@ bool migration_has_failed(MigrationState *);
>>>  bool migration_in_postcopy_after_devices(MigrationState *);
>>>  void migration_global_dump(Monitor *mon);
>>>  
>>> +/* migration/block-dirty-bitmap.c */
>>> +void dirty_bitmap_mig_init(void);
>>> +
>>>  #endif
>>> diff --git a/migration/migration.h b/migration/migration.h
>>> index 50d1f01346..4e3ad04664 100644
>>> --- a/migration/migration.h
>>> +++ b/migration/migration.h
>>> @@ -211,4 +211,7 @@ void migrate_send_rp_pong(MigrationIncomingState *mis,
>>>  void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
>>>                                ram_addr_t start, size_t len);
>>>  
>>> +void dirty_bitmap_mig_before_vm_start(void);
>>> +void init_dirty_bitmap_incoming_migration(void);
>>> +
>>>  #endif
>>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>>> new file mode 100644
>>> index 0000000000..53cb20045d
>>> --- /dev/null
>>> +++ b/migration/block-dirty-bitmap.c
>>> @@ -0,0 +1,734 @@
>>> +/*
>>> + * Block dirty bitmap postcopy migration
>>> + *
>>> + * Copyright IBM, Corp. 2009
>>> + * Copyright (c) 2016-2017 Parallels International GmbH
>>> + *
>>> + * Authors:
>>> + *  Liran Schour   <lirans@il.ibm.com>
>>> + *  Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2.  See
>>> + * the COPYING file in the top-level directory.
>>> + * This file is derived from migration/block.c, so it's author and IBM copyright
>>> + * are here, although content is quite different.
>>> + *
>>> + * Contributions after 2012-01-13 are licensed under the terms of the
>>> + * GNU GPL, version 2 or (at your option) any later version.
>>> + *
>>> + *                                ***
>>> + *
>>> + * Here postcopy migration of dirty bitmaps is realized. Only named dirty
>>> + * bitmaps, associated with root nodes and non-root named nodes are migrated.
>>
>> Put another way, only QMP-addressable bitmaps. Nodes without a name that
>> are not the root have no way to be addressed.
>>
>>> + *
>>> + * If destination qemu is already containing a dirty bitmap with the same name
>>
>> "If the destination QEMU already contains a dirty bitmap with the same name"
>>
>>> + * as a migrated bitmap (for the same node), then, if their granularities are
>>> + * the same the migration will be done, otherwise the error will be generated.
>>
>> "an error"
>>
>>> + *
>>> + * If destination qemu doesn't contain such bitmap it will be created.
>>
>> "If the destination QEMU doesn't contain such a bitmap, it will be created."
>>
>>> + *
>>> + * format of migration:
>>> + *
>>> + * # Header (shared for different chunk types)
>>> + * 1, 2 or 4 bytes: flags (see qemu_{put,put}_flags)
>>> + * [ 1 byte: node name size ] \  flags & DEVICE_NAME
>>> + * [ n bytes: node name     ] /
>>> + * [ 1 byte: bitmap name size ] \  flags & BITMAP_NAME
>>> + * [ n bytes: bitmap name     ] /
>>> + *
>>> + * # Start of bitmap migration (flags & START)
>>> + * header
>>> + * be64: granularity
>>> + * 1 byte: bitmap flags (corresponds to BdrvDirtyBitmap)
>>> + *   bit 0    -  bitmap is enabled
>>> + *   bit 1    -  bitmap is persistent
>>> + *   bit 2    -  bitmap is autoloading
>>> + *   bits 3-7 - reserved, must be zero
>>> + *
>>> + * # Complete of bitmap migration (flags & COMPLETE)
>>> + * header
>>> + *
>>> + * # Data chunk of bitmap migration
>>> + * header
>>> + * be64: start sector
>>> + * be32: number of sectors
>>> + * [ be64: buffer size  ] \ ! (flags & ZEROES)
>>> + * [ n bytes: buffer    ] /
>>> + *
>>> + * The last chunk in stream should contain flags & EOS. The chunk may skip
>>> + * device and/or bitmap names, assuming them to be the same with the previous
>>> + * chunk.
>>> + */
>>> +
>>
>> Been a while since I reviewed the format, but it seems sane.
>>
>>> +#include "qemu/osdep.h"
>>> +#include "block/block.h"
>>> +#include "block/block_int.h"
>>> +#include "sysemu/block-backend.h"
>>> +#include "qemu/main-loop.h"
>>> +#include "qemu/error-report.h"
>>> +#include "migration/misc.h"
>>> +#include "migration/migration.h"
>>> +#include "migration/qemu-file.h"
>>> +#include "migration/vmstate.h"
>>> +#include "migration/register.h"
>>> +#include "qemu/hbitmap.h"
>>> +#include "sysemu/sysemu.h"
>>> +#include "qemu/cutils.h"
>>> +#include "qapi/error.h"
>>> +#include "trace.h"
>>> +
>>> +#define CHUNK_SIZE     (1 << 10)
>>> +
>>> +/* Flags occupy one, two or four bytes (Big Endian). The size is determined as
>>> + * follows:
>>> + * in first (most significant) byte bit 8 is clear  -->  one byte
>>> + * in first byte bit 8 is set    -->  two or four bytes, depending on second
>>> + *                                    byte:
>>> + *    | in second byte bit 8 is clear  -->  two bytes
>>> + *    | in second byte bit 8 is set    -->  four bytes
>>> + */
>>> +#define DIRTY_BITMAP_MIG_FLAG_EOS           0x01
>>> +#define DIRTY_BITMAP_MIG_FLAG_ZEROES        0x02
>>> +#define DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME   0x04
>>> +#define DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME   0x08
>>> +#define DIRTY_BITMAP_MIG_FLAG_START         0x10
>>> +#define DIRTY_BITMAP_MIG_FLAG_COMPLETE      0x20
>>> +#define DIRTY_BITMAP_MIG_FLAG_BITS          0x40
>>> +
>>> +#define DIRTY_BITMAP_MIG_EXTRA_FLAGS        0x80
>>> +
>>> +#define DIRTY_BITMAP_MIG_START_FLAG_ENABLED          0x01
>>> +#define DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT       0x02
>>> +#define DIRTY_BITMAP_MIG_START_FLAG_AUTOLOAD         0x04
>>> +#define DIRTY_BITMAP_MIG_START_FLAG_RESERVED_MASK    0xf8
>>> +
>>> +typedef struct DirtyBitmapMigBitmapState {
>>> +    /* Written during setup phase. */
>>> +    BlockDriverState *bs;
>>> +    const char *node_name;
>>> +    BdrvDirtyBitmap *bitmap;
>>> +    uint64_t total_sectors;
>>> +    uint64_t sectors_per_chunk;
>>> +    QSIMPLEQ_ENTRY(DirtyBitmapMigBitmapState) entry;
>>> +    uint8_t flags;
>>> +
>>> +    /* For bulk phase. */
>>> +    bool bulk_completed;
>>> +    uint64_t cur_sector;
>>> +} DirtyBitmapMigBitmapState;
>>> +
>>> +typedef struct DirtyBitmapMigState {
>>> +    QSIMPLEQ_HEAD(dbms_list, DirtyBitmapMigBitmapState) dbms_list;
>>> +
>>> +    bool bulk_completed;
>>> +
>>> +    /* for send_bitmap_bits() */
>>> +    BlockDriverState *prev_bs;
>>> +    BdrvDirtyBitmap *prev_bitmap;
>>> +} DirtyBitmapMigState;
>>> +
>>> +typedef struct DirtyBitmapLoadState {
>>> +    uint32_t flags;
>>> +    char node_name[256];
>>> +    char bitmap_name[256];
>>> +    BlockDriverState *bs;
>>> +    BdrvDirtyBitmap *bitmap;
>>> +} DirtyBitmapLoadState;
>>> +
>>> +static DirtyBitmapMigState dirty_bitmap_mig_state;
>>> +
>>> +typedef struct DirtyBitmapLoadBitmapState {
>>> +    BlockDriverState *bs;
>>> +    BdrvDirtyBitmap *bitmap;
>>> +    bool migrated;
>>> +} DirtyBitmapLoadBitmapState;
>>> +static GSList *enabled_bitmaps;
>>> +QemuMutex finish_lock;
>>> +
>>> +void init_dirty_bitmap_incoming_migration(void)
>>> +{
>>> +    qemu_mutex_init(&finish_lock);
>>> +}
>>> +
>>
>> This is a little odd as public interface. David, is there a nicer way to
>> integrate in-migrate hooks? I guess it hasn't come up yet. Anyway, it
>> might be nice to leave a comment here for now that says that the only
>> caller is migration.c, and it will only ever call it once.
> 
> I don't think having an init_ function like that is a problem;
> we've got an init_blk_migration, so I guess it's similar.
> I generally prefer things to be part of the incoming state structure
> rather than a file global; but that's not a huge one.
> 

Okey-Dokey.

>>> +static uint32_t qemu_get_bitmap_flags(QEMUFile *f)
>>> +{
>>> +    uint8_t flags = qemu_get_byte(f);
>>> +    if (flags & DIRTY_BITMAP_MIG_EXTRA_FLAGS) {
>>> +        flags = flags << 8 | qemu_get_byte(f);
>>> +        if (flags & DIRTY_BITMAP_MIG_EXTRA_FLAGS) {
>>> +            flags = flags << 16 | qemu_get_be16(f);
>>> +        }
>>> +    }
>>> +
>>> +    return flags;
>>> +}
>>> +
>>
>> ok
>>
>> (Sorry for the per-function ACKs, it's just helpful for me to know which
>> functions I followed execution of on paper to make sure I got everything
>> in this big patch.)
>>
>>> +static void qemu_put_bitmap_flags(QEMUFile *f, uint32_t flags)
>>> +{
>>> +    /* The code currently do not send flags more than one byte */
>>> +    assert(!(flags & (0xffffff00 | DIRTY_BITMAP_MIG_EXTRA_FLAGS)));
>>> +
>>> +    qemu_put_byte(f, flags);
>>> +}
>>> +
>>
>> ok
>>
>>> +static void send_bitmap_header(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
>>> +                               uint32_t additional_flags)
>>> +{
>>> +    BlockDriverState *bs = dbms->bs;
>>> +    BdrvDirtyBitmap *bitmap = dbms->bitmap;
>>> +    uint32_t flags = additional_flags;
>>> +    trace_send_bitmap_header_enter();
>>> +
>>> +    if (bs != dirty_bitmap_mig_state.prev_bs) {
>>> +        dirty_bitmap_mig_state.prev_bs = bs;
>>> +        flags |= DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME;
>>> +    }
>>> +
>>> +    if (bitmap != dirty_bitmap_mig_state.prev_bitmap) {
>>> +        dirty_bitmap_mig_state.prev_bitmap = bitmap;
>>> +        flags |= DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME;
>>> +    }
>>> +
>>
>> I guess the idea here is that we might be able to skip the node name
>> broadcast, leaving the possibilities as:
>>
>> - new node and bitmap: send both
>> - new bitmap, but not node: send bitmap name only
>> - same for both: send neither
>>
>> and that otherwise it's not possible to have a new node but "same
>> bitmap" by nature of how the structures are organized.
>>
>>> +    qemu_put_bitmap_flags(f, flags);
>>> +
>>> +    if (flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
>>> +        qemu_put_counted_string(f, dbms->node_name);
>>> +    }
>>> +
>>> +    if (flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
>>> +        qemu_put_counted_string(f, bdrv_dirty_bitmap_name(bitmap));
>>> +    }
>>> +}
>>> +
>>
>> ok
>>
>>> +static void send_bitmap_start(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
>>> +{
>>> +    send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG_START);
>>> +    qemu_put_be32(f, bdrv_dirty_bitmap_granularity(dbms->bitmap));
>>> +    qemu_put_byte(f, dbms->flags);
>>> +}
>>> +
>>
>> ok
>>
>>> +static void send_bitmap_complete(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
>>> +{
>>> +    send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG_COMPLETE);
>>> +}
>>> +
>>
>> ok
>>
>>> +static void send_bitmap_bits(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
>>> +                             uint64_t start_sector, uint32_t nr_sectors)
>>> +{
>>> +    /* align for buffer_is_zero() */
>>> +    uint64_t align = 4 * sizeof(long);
>>> +    uint64_t unaligned_size =
>>> +        bdrv_dirty_bitmap_serialization_size(
>>> +            dbms->bitmap, start_sector << BDRV_SECTOR_BITS,
>>> +            (uint64_t)nr_sectors << BDRV_SECTOR_BITS);
>>> +    uint64_t buf_size = (unaligned_size + align - 1) & ~(align - 1);
>>> +    uint8_t *buf = g_malloc0(buf_size);
>>> +    uint32_t flags = DIRTY_BITMAP_MIG_FLAG_BITS;
>>> +
>>> +    bdrv_dirty_bitmap_serialize_part(
>>> +        dbms->bitmap, buf, start_sector << BDRV_SECTOR_BITS,
>>> +        (uint64_t)nr_sectors << BDRV_SECTOR_BITS);
>>> +
>>> +    if (buffer_is_zero(buf, buf_size)) {
>>> +        g_free(buf);
>>> +        buf = NULL;
>>> +        flags |= DIRTY_BITMAP_MIG_FLAG_ZEROES;
>>> +    }
>>> +
>>> +    trace_send_bitmap_bits(flags, start_sector, nr_sectors, buf_size);
>>> +
>>> +    send_bitmap_header(f, dbms, flags);
>>> +
>>> +    qemu_put_be64(f, start_sector);
>>> +    qemu_put_be32(f, nr_sectors);
>>> +
>>> +    /* if a block is zero we need to flush here since the network
>>> +     * bandwidth is now a lot higher than the storage device bandwidth.
>>> +     * thus if we queue zero blocks we slow down the migration. */
>>
>> Can you elaborate on this for me?
>>
>>> +    if (flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
>>> +        qemu_fflush(f);
>>> +    } else {
>>> +        qemu_put_be64(f, buf_size);
>>> +        qemu_put_buffer(f, buf, buf_size);
>>> +    }
>>> +
>>> +    g_free(buf);
>>> +}
>>> +
>>> +
>>> +/* Called with iothread lock taken.  */
>>> +
>>> +static int init_dirty_bitmap_migration(void)
>>> +{
>>> +    BlockDriverState *bs;
>>> +    BdrvDirtyBitmap *bitmap;
>>> +    DirtyBitmapMigBitmapState *dbms;
>>> +    BdrvNextIterator it;
>>> +
>>> +    dirty_bitmap_mig_state.bulk_completed = false;
>>> +    dirty_bitmap_mig_state.prev_bs = NULL;
>>> +    dirty_bitmap_mig_state.prev_bitmap = NULL;
>>> +
>>> +    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
>>> +        if (!bdrv_get_device_or_node_name(bs)) {
>>> +            /* not named non-root node */
>>
>> I can't imagine the situation it would arise in, but is it possible to
>> have a named bitmap attached to a now-anonymous node?
>>
>> Let's say we attach a bitmap to a root node, but then later we insert a
>> filter or something above it and it's no longer at the root.
>>
>> We should probably prohibit such things, or at the very least toss out
>> an error here instead of silently continuing.
>>
>> I think the only things valid to just *skip* are nameless bitmaps.
>> Anything named we really ought to either migrate or error out over, I
>> think, even if the circumstances leading to such a configuration are
>> very unlikely.
>>
>>> +            continue;
>>> +        }
>>> +
>>> +        for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap;
>>> +             bitmap = bdrv_dirty_bitmap_next(bs, bitmap)) {
>>> +            if (!bdrv_dirty_bitmap_name(bitmap)) {
>>> +                continue;
>>> +            }
>>> +
>>> +            if (bdrv_dirty_bitmap_frozen(bitmap)) {
>>> +                error_report("Can't migrate frozen dirty bitmap: '%s",
>>> +                             bdrv_dirty_bitmap_name(bitmap));
>>> +                return -1;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>> +    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
>>> +        if (!bdrv_get_device_or_node_name(bs)) {
>>> +            /* not named non-root node */
>>> +            continue;
>>> +        }
>>
>> Why two-pass? I guess because we don't have to tear anything down if we
>> check for errors in advance?
>>
>> I worry that if we need to amend the logic here that it's error-prone to
>> update it in two places, so maybe we ought to just have one loop.
>>
>>> +
>>> +        for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap;
>>> +             bitmap = bdrv_dirty_bitmap_next(bs, bitmap)) {
>>> +            if (!bdrv_dirty_bitmap_name(bitmap)) {
>>> +                continue;
>>> +            }
>>> +
>>> +            bdrv_ref(bs);
>>> +            bdrv_dirty_bitmap_set_frozen(bitmap, true);
>>> +
>>
>> We could say that for any bitmap in the list of pending bitmaps to
>> migrate, we know that we have to un-freeze it, since we never add any
>> bitmaps that are frozen to our list.
>>
>>> +            dbms = g_new0(DirtyBitmapMigBitmapState, 1);
>>> +            dbms->bs = bs;
>>> +            dbms->node_name = bdrv_get_node_name(bs);
>>> +            if (!dbms->node_name || dbms->node_name[0] == '\0') {
>>> +                dbms->node_name = bdrv_get_device_name(bs);
>>> +            }
>>> +            dbms->bitmap = bitmap;
>>> +            dbms->total_sectors = bdrv_nb_sectors(bs);
>>> +            dbms->sectors_per_chunk = CHUNK_SIZE * 8 *
>>> +                bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
>>
>> Eric may want to avoid checking in new code that thinks in sectors, but
>> for the sake of review I don't mind right now.
>>
>> (Sorry, Eric!)
>>
>>> +            if (bdrv_dirty_bitmap_enabled(bitmap)) {
>>> +                dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_ENABLED;
>>> +            }
>>> +            if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
>>> +                dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT;
>>> +            }
>>> +            if (bdrv_dirty_bitmap_get_autoload(bitmap)) {
>>> +                dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_AUTOLOAD;
>>> +            }
>>> +
>>> +            bdrv_dirty_bitmap_set_persistance(bitmap, false);
>>
>> Oh, this might be stranger to undo. Perhaps what we CAN do is limit the
>> second pass to just this action and allow ourselves to unroll everything
>> else.
>>
>>> +
>>> +            QSIMPLEQ_INSERT_TAIL(&dirty_bitmap_mig_state.dbms_list,
>>> +                                 dbms, entry);
>>> +        }
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/* Called with no lock taken.  */
>>> +static void bulk_phase_send_chunk(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
>>> +{
>>> +    uint32_t nr_sectors = MIN(dbms->total_sectors - dbms->cur_sector,
>>> +                             dbms->sectors_per_chunk);
>>> +
>>> +    send_bitmap_bits(f, dbms, dbms->cur_sector, nr_sectors);
>>> +
>>> +    dbms->cur_sector += nr_sectors;
>>> +    if (dbms->cur_sector >= dbms->total_sectors) {
>>> +        dbms->bulk_completed = true;
>>> +    }
>>> +}
>>> +
>>> +/* Called with no lock taken.  */
>>> +static void bulk_phase(QEMUFile *f, bool limit)
>>> +{
>>> +    DirtyBitmapMigBitmapState *dbms;
>>> +
>>> +    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
>>> +        while (!dbms->bulk_completed) {
>>> +            bulk_phase_send_chunk(f, dbms);
>>> +            if (limit && qemu_file_rate_limit(f)) {
>>> +                return;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>> +    dirty_bitmap_mig_state.bulk_completed = true;
>>> +}
>>> +
>>> +/* Called with iothread lock taken.  */
>>> +static void dirty_bitmap_mig_cleanup(void)
>>> +{
>>> +    DirtyBitmapMigBitmapState *dbms;
>>> +
>>> +    while ((dbms = QSIMPLEQ_FIRST(&dirty_bitmap_mig_state.dbms_list)) != NULL) {
>>> +        QSIMPLEQ_REMOVE_HEAD(&dirty_bitmap_mig_state.dbms_list, entry);
>>> +        bdrv_dirty_bitmap_set_frozen(dbms->bitmap, false);
>>> +        bdrv_unref(dbms->bs);
>>> +        g_free(dbms);
>>> +    }
>>> +}
>>> +
>>
>> ok
>>
>>> +/* for SaveVMHandlers */
>>> +static void dirty_bitmap_save_cleanup(void *opaque)
>>> +{
>>> +    dirty_bitmap_mig_cleanup();
>>> +}
>>> +
>>
>> ok
>>
>>> +static int dirty_bitmap_save_iterate(QEMUFile *f, void *opaque)
>>> +{
>>> +    trace_dirty_bitmap_save_iterate(migration_in_postcopy());
>>> +
>>> +    if (migration_in_postcopy() && !dirty_bitmap_mig_state.bulk_completed) {
>>> +        bulk_phase(f, true);
>>> +    }
>>> +
>>> +    qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EOS);
>>> +
>>> +    return dirty_bitmap_mig_state.bulk_completed;
>>> +}
>>> +
>>
>> What's the purpose behind doing bulk save both here and in
>> dirty_bitmap_save_complete? Is there a path that isn't guaranteed to
>> call one of the completion functions?
>>
>> (The way it's coded seems like it'll work fine, but I'm curious about
>> what looks like a redundancy at a glance.)
> 
> I think I can see the reasoning; I think the idea is that in each
> iteration you send a chunk of data (note the 'true' means that it
> gets modulated by bandwidth limiting - although we currently don't
> have that in postcopy - I need to fix that) - so it might
> not actually send all of it.
> The complete guarantees it's all sent.
> So note this IS iterating potentially (OK but probably not
> at the moment)
> 

OK, thanks for the insight on it! It's probably fine as-is, then, it
just looks odd at a glance.

>>> +/* Called with iothread lock taken.  */
>>> +
>>> +static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
>>> +{
>>> +    DirtyBitmapMigBitmapState *dbms;
>>> +    trace_dirty_bitmap_save_complete_enter();
>>> +
>>> +    if (!dirty_bitmap_mig_state.bulk_completed) {
>>> +        bulk_phase(f, false);
>>> +    }
>>> +
>>
>> funny now that we don't actually really iterate over the data, and the
>> bulk phase is now really the _only_ phase :)
>>
>>> +    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
>>> +        send_bitmap_complete(f, dbms);
>>> +    }
>>> +
>>> +    qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EOS);
>>> +
>>> +    trace_dirty_bitmap_save_complete_finish();
>>> +
>>> +    dirty_bitmap_mig_cleanup();
>>> +    return 0;
>>> +}
>>> +
>>
>> ok
>>
>>> +static void dirty_bitmap_save_pending(QEMUFile *f, void *opaque,
>>> +                                      uint64_t max_size,
>>> +                                      uint64_t *res_precopy_only,
>>> +                                      uint64_t *res_compatible,
>>> +                                      uint64_t *res_postcopy_only)
>>> +{
>>> +    DirtyBitmapMigBitmapState *dbms;
>>> +    uint64_t pending = 0;
>>> +
>>> +    qemu_mutex_lock_iothread();
>>> +
>>> +    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
>>> +        uint64_t gran = bdrv_dirty_bitmap_granularity(dbms->bitmap);
>>> +        uint64_t sectors = dbms->bulk_completed ? 0 :
>>> +                           dbms->total_sectors - dbms->cur_sector;
>>> +
>>> +        pending += (sectors * BDRV_SECTOR_SIZE + gran - 1) / gran;
>>> +    }
>>> +
>>> +    qemu_mutex_unlock_iothread();
>>> +
>>> +    trace_dirty_bitmap_save_pending(pending, max_size);
>>> +
>>> +    *res_postcopy_only += pending;
>>> +}
>>> +
>>
>> ok
>>
>>> +/* First occurrence of this bitmap. It should be created if doesn't exist */
>>> +static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)
>>> +{
>>> +    Error *local_err = NULL;
>>> +    uint32_t granularity = qemu_get_be32(f);
>>> +    uint8_t flags = qemu_get_byte(f);
>>> +
>>> +    if (!s->bitmap) {
>>> +        s->bitmap = bdrv_create_dirty_bitmap(s->bs, granularity,
>>> +                                             s->bitmap_name, &local_err);
>>> +        if (!s->bitmap) {
>>> +            error_report_err(local_err);
>>> +            return -EINVAL;
>>> +        }
>>> +    } else {
>>> +        uint32_t dest_granularity =
>>> +            bdrv_dirty_bitmap_granularity(s->bitmap);
>>> +        if (dest_granularity != granularity) {
>>> +            error_report("Error: "
>>> +                         "Migrated bitmap granularity (%" PRIu32 ") "
>>> +                         "doesn't match the destination bitmap '%s' "
>>> +                         "granularity (%" PRIu32 ")",
>>> +                         granularity,
>>> +                         bdrv_dirty_bitmap_name(s->bitmap),
>>> +                         dest_granularity);
>>> +            return -EINVAL;
>>> +        }
>>> +    }
>>> +
>>
>> I'm a fan of auto-creating the bitmaps. Do you have a use-case for why
>> creating them ahead of time is better, or are you just attempting to be
>> flexible?
>>
>>> +    if (flags & DIRTY_BITMAP_MIG_START_FLAG_RESERVED_MASK) {
>>> +        error_report("Unknown flags in migrated dirty bitmap header: %x",
>>> +                     flags);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (flags & DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT) {
>>> +        bdrv_dirty_bitmap_set_persistance(s->bitmap, true);
>>> +    }
>>> +    if (flags & DIRTY_BITMAP_MIG_START_FLAG_AUTOLOAD) {
>>> +        bdrv_dirty_bitmap_set_autoload(s->bitmap, true);
>>> +    }
>>> +
>>> +    bdrv_disable_dirty_bitmap(s->bitmap);
>>
>> OK, so we start them off as disabled, and
>>
>>> +    if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) {
>>> +        DirtyBitmapLoadBitmapState *b;
>>> +
>>> +        bdrv_dirty_bitmap_create_successor(s->bs, s->bitmap, &local_err);
>>> +        if (local_err) {
>>> +            error_report_err(local_err);
>>> +            return -EINVAL;
>>> +        }
>>> +
>>
>> If they weren't disabled on the host, we create a successor to record
>> writes while we wait for the rest of the data to arrive.
>>
>>> +        b = g_new(DirtyBitmapLoadBitmapState, 1);
>>> +        b->bs = s->bs;
>>> +        b->bitmap = s->bitmap;
>>> +        b->migrated = false;
>>> +        enabled_bitmaps = g_slist_prepend(enabled_bitmaps, b);
>>
>> And we make a note of which ones we were supposed to re-enable.
>>
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>
>> OK
>>
>>> +
>>> +void dirty_bitmap_mig_before_vm_start(void)
>>
>> Similarly, I guess I find it weird that this is a callable interface.
>>
>> David, no nice hook for just-prior-to-vm-start calls? a
>> .postcopy_pivot() hook or something might be nice..
> 
> Hmm, the other way a lot of devices do it is to hook the runstate
> change.
> 

I guess we're not a device as-such, and that usually occurs after the
change, doesn't it? It's pretty vitally important that we *guarantee*
not a single bit gets written until we can install our bitmaps properly
to make sure we track every last write properly.

If you're fine with the hardcoded hook for now, I am too, but I wanted
to point it out.

>>> +{
>>> +    GSList *item;
>>> +
>>> +    qemu_mutex_lock(&finish_lock);
>>> +
>>> +    for (item = enabled_bitmaps; item; item = g_slist_next(item)) {
>>> +        DirtyBitmapLoadBitmapState *b = item->data;
>>> +
>>
>> Anyway, if I am reading this right; we call this in the postcopy phase
>> prior to receiving the entirety of the bitmaps (so before receiving
>> COMPLETE) ... right?
>>
>>> +        if (b->migrated) {
>>> +            bdrv_enable_dirty_bitmap(b->bitmap);
>>
>> ...or, am I confused, and we might receive a COMPLETE event prior to the
>> postcopy pivot?
>>
>> Anyway, I suppose this code says "If we received the entire bitmap, go
>> ahead and enable it."
>>
>>> +        } else {
>>> +            bdrv_dirty_bitmap_enable_successor(b->bitmap);
>>
>> And this says "If we haven't received it yet, enable the successor to
>> record writes until we get the rest of the data."
>>
>>> +        }
>>> +
>>> +        g_free(b);
>>> +    }
>>> +
>>> +    g_slist_free(enabled_bitmaps);
>>> +    enabled_bitmaps = NULL;
>>> +
>>> +    qemu_mutex_unlock(&finish_lock);
>>> +}
>>> +
>>> +static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
>>> +{
>>> +    GSList *item;
>>> +    trace_dirty_bitmap_load_complete();
>>> +    bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
>>> +
>>> +    qemu_mutex_lock(&finish_lock);
>>> +
>>> +    for (item = enabled_bitmaps; item; item = g_slist_next(item)) {
>>> +        DirtyBitmapLoadBitmapState *b = item->data;
>>> +
>>> +        if (b->bitmap == s->bitmap) {
>>> +            b->migrated = true;
>>
>> we can probably break; here now, right?
>>
>> (This whole stanza is a little strange, can't we cache the active
>> DirtyBitmapLoadBitmapState in DirtyBitmapLoadState? I guess not, because
>> we're looking up the BdrvDirtyBitmap itself and caching that instead, so
>> either way we have some kind of lookup on every context switch.)
>>
>>> +        }
>>> +    }
>>> +
>>> +    if (bdrv_dirty_bitmap_frozen(s->bitmap)) {
>>> +        if (enabled_bitmaps == NULL) {
>>> +            /* in postcopy */
>>> +            AioContext *aio_context = bdrv_get_aio_context(s->bs);
>>> +            aio_context_acquire(aio_context);
>>> +
>>> +            bdrv_reclaim_dirty_bitmap(s->bs, s->bitmap, &error_abort);
>>> +            bdrv_enable_dirty_bitmap(s->bitmap);
>>> +
>>
>> OK, so if enabled_bitmaps is gone, that means we already pivoted and
>> we're live on the receiving end here. We merge the successor into the
>> fully deserialized bitmap and enable it.
>>
>>> +            aio_context_release(aio_context);
>>> +        } else {
>>> +            /* target not started, successor is empty */
>>> +            bdrv_dirty_bitmap_release_successor(s->bs, s->bitmap);
>>
>> Otherwise we just trash the successor. Did we really need a new call for
>> this? I suppose it's faster than merging a 0-bit bitmap, but the
>> additional API complexity for the speed win here seems like premature
>> optimization.
>>
>> ...well, you already wrote it, so I won't argue.
>>
>>> +        }
>>> +    }
>>> +
>>> +    qemu_mutex_unlock(&finish_lock);
>>> +}
>>> +
>>> +static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState *s)
>>> +{
>>> +    uint64_t first_byte = qemu_get_be64(f) << BDRV_SECTOR_BITS;
>>> +    uint64_t nr_bytes = (uint64_t)qemu_get_be32(f) << BDRV_SECTOR_BITS;
>>> +    trace_dirty_bitmap_load_bits_enter(first_byte >> BDRV_SECTOR_BITS,
>>> +                                       nr_bytes >> BDRV_SECTOR_BITS);
>>> +
>>> +    if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
>>> +        trace_dirty_bitmap_load_bits_zeroes();
>>> +        bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte, nr_bytes,
>>> +                                             false);
>>> +    } else {
>>> +        uint8_t *buf;
>>> +        uint64_t buf_size = qemu_get_be64(f);
>>> +        uint64_t needed_size =
>>> +            bdrv_dirty_bitmap_serialization_size(s->bitmap,
>>> +                                                 first_byte, nr_bytes);
>>> +
>>> +        if (needed_size > buf_size) {
>>> +            error_report("Error: Migrated bitmap granularity doesn't "
>>> +                         "match the destination bitmap '%s' granularity",
>>> +                         bdrv_dirty_bitmap_name(s->bitmap));
>>> +            return -EINVAL;
>>> +        }
>>> +
>>> +        buf = g_malloc(buf_size);
>>> +        qemu_get_buffer(f, buf, buf_size);
>>> +        bdrv_dirty_bitmap_deserialize_part(s->bitmap, buf, first_byte, nr_bytes,
>>> +                                           false);
>>> +        g_free(buf);
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>
>> ok
>>
>>> +static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
>>> +{
>>> +    Error *local_err = NULL;
>>> +    s->flags = qemu_get_bitmap_flags(f);
>>> +    trace_dirty_bitmap_load_header(s->flags);
>>> +
>>> +    if (s->flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
>>> +        if (!qemu_get_counted_string(f, s->node_name)) {
>>> +            error_report("Unable to read node name string");
>>> +            return -EINVAL;
>>> +        }
>>> +        s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
>>> +        if (!s->bs) {
>>> +            error_report_err(local_err);
>>> +            return -EINVAL;
>>> +        }
>>> +    } else if (!s->bs) {
>>> +        error_report("Error: block device name is not set");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
>>> +        if (!qemu_get_counted_string(f, s->bitmap_name)) {
>>> +            error_report("Unable to read node name string");
>>> +            return -EINVAL;
>>> +        }
>>> +        s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
>>> +
>>> +        /* bitmap may be NULL here, it wouldn't be an error if it is the
>>> +         * first occurrence of the bitmap */
>>> +        if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
>>> +            error_report("Error: unknown dirty bitmap "
>>> +                         "'%s' for block device '%s'",
>>> +                         s->bitmap_name, s->node_name);
>>> +            return -EINVAL;
>>> +        }
>>> +    } else if (!s->bitmap) {
>>> +        error_report("Error: block device name is not set");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>
>> ok
>>
>>> +static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>>> +{
>>> +    static DirtyBitmapLoadState s;
>>> +    int ret = 0;
>>> +
>>> +    trace_dirty_bitmap_load_enter();
>>> +
>>> +    if (version_id != 1) {
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    do {
>>> +        dirty_bitmap_load_header(f, &s);
>>> +
>>> +        if (s.flags & DIRTY_BITMAP_MIG_FLAG_START) {
>>> +            ret = dirty_bitmap_load_start(f, &s);
>>> +        } else if (s.flags & DIRTY_BITMAP_MIG_FLAG_COMPLETE) {
>>> +            dirty_bitmap_load_complete(f, &s);
>>> +        } else if (s.flags & DIRTY_BITMAP_MIG_FLAG_BITS) {
>>> +            ret = dirty_bitmap_load_bits(f, &s);
>>> +        }
>>> +
>>> +        if (!ret) {
>>> +            ret = qemu_file_get_error(f);
>>> +        }
>>> +
>>> +        if (ret) {
>>> +            return ret;
>>> +        }
>>> +    } while (!(s.flags & DIRTY_BITMAP_MIG_FLAG_EOS));
>>> +
>>> +    trace_dirty_bitmap_load_success();
>>> +    return 0;
>>> +}
>>
>> OK
>>
>>> +
>>> +static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
>>> +{
>>> +    DirtyBitmapMigBitmapState *dbms = NULL;
>>> +    if (init_dirty_bitmap_migration() < 0) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
>>> +        send_bitmap_start(f, dbms);
>>> +    }
>>> +    qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EOS);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>
>> ok
>>
>>> +static bool dirty_bitmap_is_active(void *opaque)
>>> +{
>>> +    return migrate_dirty_bitmaps();
>>> +}
>>> +
>>
>> ok
>>
>>> +static bool dirty_bitmap_is_active_iterate(void *opaque)
>>> +{
>>> +    return dirty_bitmap_is_active(opaque) && !runstate_is_running();
>>> +}
>>> +
>>
>> On second thought, in patch 9, can you add a little tiny bit of
>> documentation text explaining the exact nature of this callback?
>>
>> Is the second portion of the conditional here so that once we reach the
>> postcopy state that .is_active_iterate starts returning true?
>>
>> "ok" if I'm reading this right, but it might be helped along by a little
>> comment.
>>
>>> +static bool dirty_bitmap_has_postcopy(void *opaque)
>>> +{
>>> +    return true;
>>> +}
>>> +
>>
>> ok! :)
>>
>>> +static SaveVMHandlers savevm_dirty_bitmap_handlers = {
>>> +    .save_setup = dirty_bitmap_save_setup,
>>> +    .save_live_complete_postcopy = dirty_bitmap_save_complete,
>>> +    .save_live_complete_precopy = dirty_bitmap_save_complete,
>>> +    .has_postcopy = dirty_bitmap_has_postcopy,
>>> +    .save_live_pending = dirty_bitmap_save_pending,
>>> +    .save_live_iterate = dirty_bitmap_save_iterate,
>>> +    .is_active_iterate = dirty_bitmap_is_active_iterate,
>>> +    .load_state = dirty_bitmap_load,
>>> +    .save_cleanup = dirty_bitmap_save_cleanup,
>>> +    .is_active = dirty_bitmap_is_active,
>>> +};
>>> +
>>> +void dirty_bitmap_mig_init(void)
>>> +{
>>> +    QSIMPLEQ_INIT(&dirty_bitmap_mig_state.dbms_list);
>>> +
>>> +    register_savevm_live(NULL, "dirty-bitmap", 0, 1,
>>> +                         &savevm_dirty_bitmap_handlers,
>>> +                         &dirty_bitmap_mig_state);
>>> +}
>>
>> ok
>>
>> dgilbert, would it be worth registering a block-driver-like registration
>> trick that automatically invokes these functions instead of having to
>> hook them up in vl.c? the more we add, the more hacky it looks to not
>> have some subsystem-wide registration hook.
> 
> Maybe it's just simpler to put a mig_init in migration/migration.c and
> make one call in vl.c; I'd rather keep a simple function than a whole
> registration mechanism.
> 

Yup. I just sometimes think about if vl.c could be ... prettied up to
any acceptable level. It's kind of a wilderness up there.

>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index e973837bfd..66e9cf03cd 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -150,6 +150,9 @@ MigrationIncomingState *migration_incoming_get_current(void)
>>>          memset(&mis_current, 0, sizeof(MigrationIncomingState));
>>>          qemu_mutex_init(&mis_current.rp_mutex);
>>>          qemu_event_init(&mis_current.main_thread_load_event, false);
>>> +
>>> +        init_dirty_bitmap_incoming_migration();
>>> +
>>>          once = true;
>>>      }
>>>      return &mis_current;
>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>> index 9bbfb3fa1b..b0c37ef9f1 100644
>>> --- a/migration/savevm.c
>>> +++ b/migration/savevm.c
>>> @@ -1673,6 +1673,8 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
>>>  
>>>      trace_loadvm_postcopy_handle_run_vmstart();
>>>  
>>> +    dirty_bitmap_mig_before_vm_start();
>>> +
>>>      if (autostart) {
>>>          /* Hold onto your hats, starting the CPU */
>>>          vm_start();
>>> diff --git a/vl.c b/vl.c
>>> index ec299099ff..3d393aaf2c 100644
>>> --- a/vl.c
>>> +++ b/vl.c
>>> @@ -4642,6 +4642,7 @@ int main(int argc, char **argv, char **envp)
>>>  
>>>      blk_mig_init();
>>>      ram_mig_init();
>>> +    dirty_bitmap_mig_init();
>>>  
>>>      /* If the currently selected machine wishes to override the units-per-bus
>>>       * property of its default HBA interface type, do so now. */
>>> diff --git a/migration/Makefile.objs b/migration/Makefile.objs
>>> index 99e038024d..c83ec47ba8 100644
>>> --- a/migration/Makefile.objs
>>> +++ b/migration/Makefile.objs
>>> @@ -6,6 +6,7 @@ common-obj-y += qemu-file.o global_state.o
>>>  common-obj-y += qemu-file-channel.o
>>>  common-obj-y += xbzrle.o postcopy-ram.o
>>>  common-obj-y += qjson.o
>>> +common-obj-y += block-dirty-bitmap.o
>>>  
>>>  common-obj-$(CONFIG_RDMA) += rdma.o
>>>  
>>> diff --git a/migration/trace-events b/migration/trace-events
>>> index a04fffb877..e9eb8078d4 100644
>>> --- a/migration/trace-events
>>> +++ b/migration/trace-events
>>> @@ -227,3 +227,17 @@ colo_vm_state_change(const char *old, const char *new) "Change '%s' => '%s'"
>>>  colo_send_message(const char *msg) "Send '%s' message"
>>>  colo_receive_message(const char *msg) "Receive '%s' message"
>>>  colo_failover_set_state(const char *new_state) "new state %s"
>>> +
>>> +# migration/block-dirty-bitmap.c
>>> +send_bitmap_header_enter(void) ""
>>> +send_bitmap_bits(uint32_t flags, uint64_t start_sector, uint32_t nr_sectors, uint64_t data_size) "\n   flags:        0x%x\n   start_sector: %" PRIu64 "\n   nr_sectors:   %" PRIu32 "\n   data_size:    %" PRIu64 "\n"
>>> +dirty_bitmap_save_iterate(int in_postcopy) "in postcopy: %d"
>>> +dirty_bitmap_save_complete_enter(void) ""
>>> +dirty_bitmap_save_complete_finish(void) ""
>>> +dirty_bitmap_save_pending(uint64_t pending, uint64_t max_size) "pending %" PRIu64 " max: %" PRIu64
>>> +dirty_bitmap_load_complete(void) ""
>>> +dirty_bitmap_load_bits_enter(uint64_t first_sector, uint32_t nr_sectors) "chunk: %" PRIu64 " %" PRIu32
>>> +dirty_bitmap_load_bits_zeroes(void) ""
>>> +dirty_bitmap_load_header(uint32_t flags) "flags 0x%x"
>>> +dirty_bitmap_load_enter(void) ""
>>> +dirty_bitmap_load_success(void) ""
>>>
>>
>> OK, I think everything here is probably in order, and it's only my
>> understanding that is a barrier at this point. Help me understand the
>> rest of this patch and I'll re-pester migration to get this staged for
>> qemu-next.
>>
>> --js
> 
> Dave
> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

Thanks for taking a peek, David.

--js
