Received: from eggs.gnu.org ([2001:4830:134:3::10]:35923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dx9Cf-0006bj-3O
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dx9Cb-0003sA-4u
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:04:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dx9Ca-0003rk-SN
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:04:25 -0400
Date: Wed, 27 Sep 2017 18:04:16 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170927100416.GA17044@pxdev.xzpeter.org>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-21-git-send-email-peterx@redhat.com>
	<20170922110542.GD2620@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170922110542.GD2620@work-vm>
Subject: Re: [Qemu-devel] [RFC v2 20/33] migration: new message
 MIG_RP_MSG_RECV_BITMAP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Fri, Sep 22, 2017 at 12:05:42PM +0100, Dr. David Alan Gilbert wrote:

[...]

> > diff --git a/migration/ram.c b/migration/ram.c
> > index 7e20097..5d938e3 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -182,6 +182,70 @@ void ramblock_recv_bitmap_clear(RAMBlock *rb, void *host_addr)
> >      clear_bit(ramblock_recv_bitmap_offset(host_addr, rb), rb->receivedmap);
> >  }
> >  
> > +#define  RAMBLOCK_RECV_BITMAP_ENDING  (0x0123456789abcdefULL)
> > +
> > +/*
> > + * Format: bitmap_size (8 bytes) + whole_bitmap (N bytes).
> > + *
> > + * Returns >0 if success with sent bytes, or <0 if error.
> > + */
> > +int64_t ramblock_recv_bitmap_send(QEMUFile *file,
> > +                                  const char *block_name)
> > +{
> > +    RAMBlock *block = qemu_ram_block_by_name(block_name);
> > +    unsigned long *le_bitmap, nbits;
> > +    uint64_t size;
> > +
> > +    if (!block) {
> > +        error_report("%s: invalid block name: %s", __func__, block_name);
> > +        return -1;
> > +    }
> > +
> > +    nbits = block->used_length >> TARGET_PAGE_BITS;
> > +
> > +    /*
> > +     * Make sure the tmp bitmap buffer is big enough, e.g., on 32bit
> > +     * machines we may need 4 more bytes for padding (see below
> > +     * comment). So extend it a bit before hand.
> > +     */
> > +    le_bitmap = bitmap_new(nbits + BITS_PER_LONG);
> 
> I do worry what will happen on really huge RAMBlocks; the worst case is
> that this temporary bitmap is a few GB.

IIUC the bitmap ratio is 32K, so the ramblock will be 1GB only if the
guest RAM region size is 1GB * 32K = 32TB.

Then, can I just assume allocating (only) 1GB temporary memory for a
guest using more than 32TB memory not a problem? :-)

I hope I didn't calculate it wrongly though.

> 
> > +    /*
> > +     * Always use little endian when sending the bitmap. This is
> > +     * required that when source and destination VMs are not using the
> > +     * same endianess. (Note: big endian won't work.)
> > +     */
> > +    bitmap_to_le(le_bitmap, block->receivedmap, nbits);
> > +
> > +    /* Size of the bitmap, in bytes */
> > +    size = nbits / 8;
> > +
> > +    /*
> > +     * size is always aligned to 8 bytes for 64bit machines, but it
> > +     * may not be true for 32bit machines. We need this padding to
> > +     * make sure the migration can survive even between 32bit and
> > +     * 64bit machines.
> > +     */
> > +    size = ROUND_UP(size, 8);
> > +
> > +    qemu_put_be64(file, size);
> > +    qemu_put_buffer(file, (const uint8_t *)le_bitmap, size);
> > +    /*
> > +     * Mark as an end, in case the middle part is screwed up due to
> > +     * some "misterious" reason.
> > +     */
> > +    qemu_put_be64(file, RAMBLOCK_RECV_BITMAP_ENDING);
> > +    qemu_fflush(file);
> > +
> > +    free(le_bitmap);
> > +
> > +    if (qemu_file_get_error(file)) {
> > +        return qemu_file_get_error(file);
> > +    }
> > +
> > +    return size + sizeof(size);
> > +}
> > +
> >  /*
> >   * An outstanding page request, on the source, having been received
> >   * and queued
> > @@ -2706,6 +2770,83 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
> >      return ret;
> >  }
> >  
> > +/*
> > + * Read the received bitmap, revert it as the initial dirty bitmap.
> > + * This is only used when the postcopy migration is paused but wants
> > + * to resume from a middle point.
> > + */
> > +int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
> > +{
> > +    int ret = -EINVAL;
> > +    QEMUFile *file = s->rp_state.from_dst_file;
> > +    unsigned long *le_bitmap, nbits = block->used_length >> TARGET_PAGE_BITS;
> > +    uint64_t local_size = nbits / 8;
> > +    uint64_t size, end_mark;
> > +
> > +    if (s->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
> > +        error_report("%s: incorrect state %s", __func__,
> > +                     MigrationStatus_lookup[s->state]);
> > +        return -EINVAL;
> > +    }
> > +
> > +    /*
> > +     * Note: see comments in ramblock_recv_bitmap_send() on why we
> > +     * need the endianess convertion, and the paddings.
> > +     */
> > +    local_size = ROUND_UP(local_size, 8);
> > +
> > +    /* Add addings */
> > +    le_bitmap = bitmap_new(nbits + BITS_PER_LONG);
> > +
> > +    size = qemu_get_be64(file);
> > +
> > +    /* The size of the bitmap should match with our ramblock */
> > +    if (size != local_size) {
> > +        error_report("%s: ramblock '%s' bitmap size mismatch "
> > +                     "(0x%lx != 0x%lx)", __func__, block->idstr,
> > +                     size, local_size);
> 
> You need to use PRIx64 formatters there - %lx isn't portable.

Yes. Fixing.

> 
> > +        ret = -EINVAL;
> > +        goto out;
> > +    }
> > +
> > +    size = qemu_get_buffer(file, (uint8_t *)le_bitmap, local_size);
> > +    end_mark = qemu_get_be64(file);
> > +
> > +    ret = qemu_file_get_error(file);
> > +    if (ret || size != local_size) {
> > +        error_report("%s: read bitmap failed for ramblock '%s': %d",
> > +                     __func__, block->idstr, ret);
> 
> You might like to include size/local_size in the error.

Will do.  Thanks,

-- 
Peter Xu
