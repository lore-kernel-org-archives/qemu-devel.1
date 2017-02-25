Received: from eggs.gnu.org ([2001:4830:134:3::10]:50338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1chga2-0001VY-AN
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 12:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1chga1-0006G9-EE
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 12:56:26 -0500
References: <1486979689-230770-1-git-send-email-vsementsov@virtuozzo.com>
	<1486979689-230770-13-git-send-email-vsementsov@virtuozzo.com>
	<20170216130409.GA28784@lemon.lan>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <665e5244-6f2c-1a34-f7bb-1021ced052c2@virtuozzo.com>
Date: Sat, 25 Feb 2017 20:56:11 +0300
MIME-Version: 1.0
In-Reply-To: <20170216130409.GA28784@lemon.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

16.02.2017 16:04, Fam Zheng wrote:
> On Mon, 02/13 12:54, Vladimir Sementsov-Ogievskiy wrote:
>> Postcopy migration of dirty bitmaps. Only named dirty bitmaps,
>> associated with root nodes and non-root named nodes are migrated.
>>
>> If destination qemu is already containing a dirty bitmap with the same name
>> as a migrated bitmap (for the same node), than, if their granularities are

[...]

>> +
>> +#define CHUNK_SIZE     (1 << 10)
>> +
>> +/* Flags occupy from one to four bytes. In all but one the 7-th (EXTRA_FLAGS)
>> + * bit should be set. */
>> +#define DIRTY_BITMAP_MIG_FLAG_EOS           0x01
>> +#define DIRTY_BITMAP_MIG_FLAG_ZEROES        0x02
>> +#define DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME   0x04
>> +#define DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME   0x08
>> +#define DIRTY_BITMAP_MIG_FLAG_START         0x10
>> +#define DIRTY_BITMAP_MIG_FLAG_COMPLETE      0x20
>> +#define DIRTY_BITMAP_MIG_FLAG_BITS          0x40
>> +
>> +#define DIRTY_BITMAP_MIG_EXTRA_FLAGS        0x80
>> +#define DIRTY_BITMAP_MIG_FLAGS_SIZE_16      0x8000
> This flag means two bytes, right? But your above comment says "7-th bit should
> be set". This doesn't make sense. Should this be "0x80" too?

Hmm, good caught, you are right. Also, the comment should be fixed so 
that there are may be 1,2 or 4 bytes, and of course EXTRA_FLAGS bit may 
be only in first and second bytes (the code do so).

>
>> +#define DIRTY_BITMAP_MIG_FLAGS_SIZE_32      0x8080
>> +
>> +#define DEBUG_DIRTY_BITMAP_MIGRATION 0

[...]

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
> While these bdrv_dirty_bitmap_* calls here seem fine, BdrvDirtyBitmap API is not
> in general thread-safe, while this function is called without any lock. This
> feels dangerous, as noted below, I'm most concerned about use-after-free.

This should be safe as it is a postcopy migration - source should be 
already inactive.

>
>> +
>> +    if (buffer_is_zero(buf, buf_size)) {
>> +        g_free(buf);
>> +        buf = NULL;
>> +        flags |= DIRTY_BITMAP_MIG_FLAG_ZEROES;
>> +    }
>> +
>> +    trace_send_bitmap_bits(flags, start_sector, nr_sectors, buf_size);
>> +
>> +    send_bitmap_header(f, dbms, flags);
>> +
>> +    qemu_put_be64(f, start_sector);
>> +    qemu_put_be32(f, nr_sectors);
>> +
>> +    /* if a block is zero we need to flush here since the network
>> +     * bandwidth is now a lot higher than the storage device bandwidth.
>> +     * thus if we queue zero blocks we slow down the migration. */
>> +    if (flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
>> +        qemu_fflush(f);
>> +    } else {
>> +        qemu_put_be64(f, buf_size);
>> +        qemu_put_buffer(f, buf, buf_size);
>> +    }
>> +
>> +    g_free(buf);
>> +}
>> +
>> +

[...]

>> +
>> +static void dirty_bitmap_save_pending(QEMUFile *f, void *opaque,
>> +                                      uint64_t max_size,
>> +                                      uint64_t *res_precopy_only,
>> +                                      uint64_t *res_compatible,
>> +                                      uint64_t *res_postcopy_only)
>> +{
>> +    DirtyBitmapMigBitmapState *dbms;
>> +    uint64_t pending = 0;
>> +
>> +    qemu_mutex_lock_iothread();
> Why do you need the BQL here but not in bulk_phase()?

bulk_phase is in postcopy, source is inactive


-- 
Best regards,
Vladimir
