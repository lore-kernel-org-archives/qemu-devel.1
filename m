Received: from eggs.gnu.org ([2001:4830:134:3::10]:46096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eURTI-0007w2-1h
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 01:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eURTG-0001eL-Q9
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 01:15:16 -0500
Date: Thu, 28 Dec 2017 14:14:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171228061457.GI9192@lemon>
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-11-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220154945.88410-11-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v9 10/13] migration: add postcopy migration
 of dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, lirans@il.ibm.com, quintela@redhat.com, jsnow@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com

On Wed, 12/20 18:49, Vladimir Sementsov-Ogievskiy wrote:
> Postcopy migration of dirty bitmaps. Only named dirty bitmaps,
> associated with root nodes and non-root named nodes are migrated.
> 
> If destination qemu is already containing a dirty bitmap with the same name
> as a migrated bitmap (for the same node), then, if their granularities are
> the same the migration will be done, otherwise the error will be generated.
> 
> If destination qemu doesn't contain such bitmap it will be created.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Looks good in general, a few nits below.

> +static void send_bitmap_bits(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
> +                             uint64_t start_sector, uint32_t nr_sectors)
> +{
> +    /* align for buffer_is_zero() */
> +    uint64_t align = 4 * sizeof(long);
> +    uint64_t unaligned_size =
> +        bdrv_dirty_bitmap_serialization_size(
> +            dbms->bitmap, start_sector << BDRV_SECTOR_BITS,
> +            (uint64_t)nr_sectors << BDRV_SECTOR_BITS);
> +    uint64_t buf_size = (unaligned_size + align - 1) & ~(align - 1);

QEMU_ALIGN_UP() ?

> +    uint8_t *buf = g_malloc0(buf_size);
> +    uint32_t flags = DIRTY_BITMAP_MIG_FLAG_BITS;
> +
> +    bdrv_dirty_bitmap_serialize_part(
> +        dbms->bitmap, buf, start_sector << BDRV_SECTOR_BITS,
> +        (uint64_t)nr_sectors << BDRV_SECTOR_BITS);
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

<snip>

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
> +
> +    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
> +        uint64_t gran = bdrv_dirty_bitmap_granularity(dbms->bitmap);
> +        uint64_t sectors = dbms->bulk_completed ? 0 :
> +                           dbms->total_sectors - dbms->cur_sector;
> +
> +        pending += (sectors * BDRV_SECTOR_SIZE + gran - 1) / gran;

DIV_ROUND_UP()?

> +    }
> +
> +    qemu_mutex_unlock_iothread();
> +
> +    trace_dirty_bitmap_save_pending(pending, max_size);
> +
> +    *res_postcopy_only += pending;
> +}

<snip>

> +static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
> +{
> +    Error *local_err = NULL;
> +    s->flags = qemu_get_bitmap_flags(f);
> +    trace_dirty_bitmap_load_header(s->flags);
> +
> +    if (s->flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
> +        if (!qemu_get_counted_string(f, s->node_name)) {
> +            error_report("Unable to read node name string");
> +            return -EINVAL;
> +        }
> +        s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
> +        if (!s->bs) {
> +            error_report_err(local_err);
> +            return -EINVAL;
> +        }
> +    } else if (!s->bs) {
> +        error_report("Error: block device name is not set");
> +        return -EINVAL;
> +    }
> +
> +    if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
> +        if (!qemu_get_counted_string(f, s->bitmap_name)) {
> +            error_report("Unable to read node name string");

s/node name/bitmap name/

> +            return -EINVAL;
> +        }
> +        s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
> +
> +        /* bitmap may be NULL here, it wouldn't be an error if it is the
> +         * first occurrence of the bitmap */
> +        if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
> +            error_report("Error: unknown dirty bitmap "
> +                         "'%s' for block device '%s'",
> +                         s->bitmap_name, s->node_name);
> +            return -EINVAL;
> +        }
> +    } else if (!s->bitmap) {
> +        error_report("Error: block device name is not set");
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +

Fam
