Received: from eggs.gnu.org ([2001:4830:134:3::10]:51505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ceLTj-0002xI-RZ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ceLTi-0007UC-5f
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:48:07 -0500
Date: Thu, 16 Feb 2017 13:47:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170216124753.GE4869@noname.redhat.com>
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
	<1487153430-17260-10-git-send-email-vsementsov@virtuozzo.com>
	<20170216114533.GC4869@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170216114533.GC4869@noname.redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v15 09/25] qcow2: add
 .bdrv_load_autoloading_dirty_bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: famz@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com

Sorry, this was sent too early. Next attempt...

Am 16.02.2017 um 12:45 hat Kevin Wolf geschrieben:
> Am 15.02.2017 um 11:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > Auto loading bitmaps are bitmaps in Qcow2, with the AUTO flag set. They
> > are loaded when the image is opened and become BdrvDirtyBitmaps for the
> > corresponding drive.
> > 
> > Extra data in bitmaps is not supported for now.
> > 
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > Reviewed-by: Max Reitz <mreitz@redhat.com>
> > Reviewed-by: John Snow <jsnow@redhat.com>
> > ---
> >  block/Makefile.objs  |   2 +-
> >  block/qcow2-bitmap.c | 724 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  block/qcow2.c        |   2 +
> >  block/qcow2.h        |   3 +
> >  4 files changed, 730 insertions(+), 1 deletion(-)
> >  create mode 100644 block/qcow2-bitmap.c
> > 
> > diff --git a/block/Makefile.objs b/block/Makefile.objs
> > index c6bd14e..ff8d185 100644
> > --- a/block/Makefile.objs
> > +++ b/block/Makefile.objs
> > @@ -1,5 +1,5 @@
> >  block-obj-y += raw-format.o qcow.o vdi.o vmdk.o cloop.o bochs.o vpc.o vvfat.o dmg.o
> > -block-obj-y += qcow2.o qcow2-refcount.o qcow2-cluster.o qcow2-snapshot.o qcow2-cache.o
> > +block-obj-y += qcow2.o qcow2-refcount.o qcow2-cluster.o qcow2-snapshot.o qcow2-cache.o qcow2-bitmap.o
> >  block-obj-y += qed.o qed-gencb.o qed-l2-cache.o qed-table.o qed-cluster.o
> >  block-obj-y += qed-check.o
> >  block-obj-y += vhdx.o vhdx-endian.o vhdx-log.o
> > diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> > new file mode 100644
> > index 0000000..e08e46e
> > --- /dev/null
> > +++ b/block/qcow2-bitmap.c
> > @@ -0,0 +1,724 @@
> > +/*
> > + * Bitmaps for the QCOW version 2 format
> > + *
> > + * Copyright (c) 2014-2017 Vladimir Sementsov-Ogievskiy
> > + *
> > + * This file is derived from qcow2-snapshot.c, original copyright:
> > + * Copyright (c) 2004-2006 Fabrice Bellard
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaining a copy
> > + * of this software and associated documentation files (the "Software"), to deal
> > + * in the Software without restriction, including without limitation the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> > + * copies of the Software, and to permit persons to whom the Software is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "exec/log.h"
> > +
> > +#include "block/block_int.h"
> > +#include "block/qcow2.h"
> > +
> > +/* NOTICE: BME here means Bitmaps Extension and used as a namespace for
> > + * _internal_ constants. Please do not use this _internal_ abbreviation for
> > + * other needs and/or outside of this file. */
> > +
> > +/* Bitmap directory entry constraints */
> > +#define BME_MAX_TABLE_SIZE 0x8000000
> > +#define BME_MAX_PHYS_SIZE 0x20000000 /* restrict BdrvDirtyBitmap size in RAM */
> > +#define BME_MAX_GRANULARITY_BITS 31
> > +#define BME_MIN_GRANULARITY_BITS 9
> > +#define BME_MAX_NAME_SIZE 1023
> > +
> > +/* Bitmap directory entry flags */
> > +#define BME_RESERVED_FLAGS 0xfffffffcU
> > +#define BME_FLAG_IN_USE 1
> > +#define BME_FLAG_AUTO   (1U << 1)

For a more consistent look, I would spell the first one like this:

#define BME_FLAG_IN_USE (1U << 0)

> > +/* bits [1, 8] U [56, 63] are reserved */
> > +#define BME_TABLE_ENTRY_RESERVED_MASK 0xff000000000001feULL
> > +#define BME_TABLE_ENTRY_OFFSET_MASK 0x00fffffffffffe00ULL
> > +
> > +typedef struct QEMU_PACKED Qcow2BitmapDirEntry {
> > +    /* header is 8 byte aligned */
> > +    uint64_t bitmap_table_offset;
> > +
> > +    uint32_t bitmap_table_size;
> > +    uint32_t flags;
> > +
> > +    uint8_t type;
> > +    uint8_t granularity_bits;
> > +    uint16_t name_size;
> > +    uint32_t extra_data_size;
> > +    /* extra data follows  */
> > +    /* name follows  */
> > +} Qcow2BitmapDirEntry;
> > +
> > +typedef struct Qcow2Bitmap {
> > +    uint64_t table_offset;
> > +    uint32_t table_size;
> > +    uint32_t flags;
> > +    uint8_t granularity_bits;
> > +    char *name;
> > +
> > +    QSIMPLEQ_ENTRY(Qcow2Bitmap) entry;
> > +} Qcow2Bitmap;
> > +typedef QSIMPLEQ_HEAD(Qcow2BitmapList, Qcow2Bitmap) Qcow2BitmapList;
> > +
> > +typedef enum BitmapType {
> > +    BT_DIRTY_TRACKING_BITMAP = 1
> > +} BitmapType;
> > +
> > +static inline bool can_write(BlockDriverState *bs)
> > +{
> > +    return !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE);
> > +}
> > +
> > +static int update_header_sync(BlockDriverState *bs)
> > +{
> > +    int ret;
> > +
> > +    ret = qcow2_update_header(bs);
> > +    if (ret < 0) {
> > +        return ret;
> > +    }
> > +
> > +    /* We don't return bdrv_flush error code. Even if it fails, write was
> > +     * successful and it is more logical to consider that header is in the new
> > +     * state than in the old.
> > +     */
> > +    ret = bdrv_flush(bs);
> > +    if (ret < 0) {
> > +        fprintf(stderr, "Failed to flush qcow2 header");
> > +    }

I don't think I can agree with this one. If you don't care whether the
new header is actually on disk, don't call bdrv_flush(). But if you do
care, then bdrv_flush() failure means that most likely the new header
has not made it to the disk, but is just sitting in some volatile cache.

> > +    return 0;
> > +}
> > +
> > +static int check_table_entry(uint64_t entry, int cluster_size)
> > +{
> > +    uint64_t offset;
> > +
> > +    if (cluster_size <= 0) {
> > +        return -EINVAL;
> > +    }

Not really worth checking, s->cluster_size is already checked to be
valid and the rest of the qcow2 code relies on it. If you absolutely
want to do something, you can use assert().

> > +    if (entry & BME_TABLE_ENTRY_RESERVED_MASK) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    offset = entry & BME_TABLE_ENTRY_OFFSET_MASK;
> > +    if (offset != 0) {
> > +        /* if offset specified, bit 0 is reserved */
> > +        if (entry & 1) {

Should we use a constant instead of a magic 1?

> > +            return -EINVAL;
> > +        }
> > +
> > +        if (offset % cluster_size != 0) {
> > +            return -EINVAL;
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int bitmap_table_load(BlockDriverState *bs, Qcow2Bitmap *bm,
> > +                             uint64_t **bitmap_table)
> > +{
> > +    int ret;
> > +    BDRVQcow2State *s = bs->opaque;
> > +    uint32_t i;
> > +    uint64_t *table;
> > +
> > +    assert(bm->table_size != 0);
> > +    table = g_try_new(uint64_t, bm->table_size);
> > +    if (table == NULL) {
> > +        return -ENOMEM;
> > +    }
> > +
> > +    assert(bm->table_size <= BME_MAX_TABLE_SIZE);
> > +    ret = bdrv_pread(bs->file, bm->table_offset,
> > +                     table, bm->table_size * sizeof(uint64_t));
> > +    if (ret < 0) {
> > +        goto fail;
> > +    }
> > +
> > +    for (i = 0; i < bm->table_size; ++i) {
> > +        be64_to_cpus(&table[i]);
> > +        ret = check_table_entry(table[i], s->cluster_size);
> > +        if (ret < 0) {
> > +            goto fail;
> > +        }
> > +    }
> > +
> > +    *bitmap_table = table;
> > +    return 0;
> > +
> > +fail:
> > +    g_free(table);
> > +
> > +    return ret;
> > +}
> > +
> > +/* This function returns the number of disk sectors covered by a single cluster
> > + * of bitmap data. */
> > +static uint64_t disk_sectors_in_bitmap_cluster(const BDRVQcow2State *s,
> > +                                               const BdrvDirtyBitmap *bitmap)
> > +{
> > +    uint32_t sector_granularity =
> > +            bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
> > +
> > +    return (uint64_t)sector_granularity * (s->cluster_size << 3);
> > +}

This has nothing to do with disk sectors, neither of the guest disk nor
of the host disk. It's just using a funny 512 bytes unit. Is there a
good reason for introducing this funny unit in new code?

I'm also not sure what this function calculates, but it's not what the
comment says. The unit of the result is something like sectors * bytes,
and even when normalising it to a single base unit, I've never seen a
use for square bytes so far.

> > +/* bitmap table entries must satisfy specification constraints */
> > +static int load_bitmap_data(BlockDriverState *bs,
> > +                            const uint64_t *bitmap_table,
> > +                            uint32_t bitmap_table_size,
> > +                            BdrvDirtyBitmap *bitmap)
> > +{
> > +    int ret = 0;
> > +    BDRVQcow2State *s = bs->opaque;
> > +    uint64_t sector, dsc;
> > +    uint64_t bm_size = bdrv_dirty_bitmap_size(bitmap);
> > +    uint8_t *buf = NULL;
> > +    uint64_t i, tab_size =
> > +            size_to_clusters(s,
> > +                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size));
> > +
> > +    if (tab_size != bitmap_table_size || tab_size > BME_MAX_TABLE_SIZE) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    bdrv_clear_dirty_bitmap(bitmap, NULL);
> > +
> > +    buf = g_malloc(s->cluster_size);
> > +    dsc = disk_sectors_in_bitmap_cluster(s, bitmap);
> > +    for (i = 0, sector = 0; i < tab_size; ++i, sector += dsc) {
> > +        uint64_t count = MIN(bm_size - sector, dsc);
> > +        uint64_t entry = bitmap_table[i];
> > +        uint64_t offset = entry & BME_TABLE_ENTRY_OFFSET_MASK;
> > +
> > +        assert(check_table_entry(entry, s->cluster_size) == 0);
> > +
> > +        if (offset == 0) {
> > +            if (entry & 1) {

The same magic 1 again.

> > +                bdrv_dirty_bitmap_deserialize_ones(bitmap, sector, count,
> > +                                                   false);

The bdrv_dirty_bitmap_* interfaces are truly confusing. They call their
parameters start/count, which is the convention for byte based
parameters, but they actually seem to expect sector numbers.

Can we make the whole thing a little less confusing by entirely removing
sectors from the block dirty bitmap interfaces? I find it challenging
enough to deal with just bytes, qcow2 clusters and bitmap clusters.

> > +            } else {
> > +                /* No need to deserialize zeros because the dirty bitmap is
> > +                 * already cleared */
> > +            }
> > +        } else {
> > +            ret = bdrv_pread(bs->file, offset, buf, s->cluster_size);
> > +            if (ret < 0) {
> > +                goto finish;
> > +            }
> > +            bdrv_dirty_bitmap_deserialize_part(bitmap, buf, sector, count,
> > +                                               false);
> > +        }
> > +    }
> > +    ret = 0;
> > +
> > +    bdrv_dirty_bitmap_deserialize_finish(bitmap);
> > +
> > +finish:
> > +    g_free(buf);
> > +
> > +    return ret;
> > +}
> > +
> > +static BdrvDirtyBitmap *load_bitmap(BlockDriverState *bs,
> > +                                    Qcow2Bitmap *bm, Error **errp)
> > +{
> > +    int ret;
> > +    uint64_t *bitmap_table = NULL;
> > +    uint32_t granularity;
> > +    BdrvDirtyBitmap *bitmap = NULL;
> > +
> > +    if (bm->flags & BME_FLAG_IN_USE) {
> > +        error_setg(errp, "Bitmap '%s' is in use", bm->name);
> > +        goto fail;
> > +    }
> > +
> > +    ret = bitmap_table_load(bs, bm, &bitmap_table);
> > +    if (ret < 0) {
> > +        error_setg_errno(errp, -ret,
> > +                         "Could not read bitmap_table table from image for "
> > +                         "bitmap '%s'", bm->name);
> > +        goto fail;
> > +    }
> > +
> > +    granularity = 1U << bm->granularity_bits;
> > +    bitmap = bdrv_create_dirty_bitmap(bs, granularity, bm->name, errp);
> > +    if (bitmap == NULL) {
> > +        goto fail;
> > +    }
> > +
> > +    ret = load_bitmap_data(bs, bitmap_table, bm->table_size,
> > +                           bitmap);

This fits in a single line.

> > +    if (ret < 0) {
> > +        error_setg_errno(errp, -ret, "Could not read bitmap '%s' from image",
> > +                         bm->name);
> > +        goto fail;
> > +    }
> > +
> > +    g_free(bitmap_table);
> > +    return bitmap;
> > +
> > +fail:
> > +    g_free(bitmap_table);
> > +    if (bitmap != NULL) {
> > +        bdrv_release_dirty_bitmap(bs, bitmap);
> > +    }
> > +
> > +    return NULL;
> > +}

Kevin
