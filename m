Received: from eggs.gnu.org ([2001:4830:134:3::10]:40338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddWZw-0005U3-Nw
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddWZs-0002x5-F2
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:59:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ddWZs-0002w6-6S
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:59:20 -0400
Date: Fri, 4 Aug 2017 14:59:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170804065914.GH5561@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-23-git-send-email-peterx@redhat.com>
	<20170803105021.GD2076@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170803105021.GD2076@work-vm>
Subject: Re: [Qemu-devel] [RFC 22/29] migration: new message
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
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Aug 03, 2017 at 11:50:22AM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Introducing new return path message MIG_RP_MSG_RECV_BITMAP to send
> > received bitmap of ramblock back to source.
> > 
> > This is the reply message of MIG_CMD_RECV_BITMAP, it contains not only
> > the header (including the ramblock name), and it was appended with the
> > whole ramblock received bitmap on the destination side.
> > 
> > When the source receives such a reply message (MIG_RP_MSG_RECV_BITMAP),
> > it parses it, convert it to the dirty bitmap by reverting the bits.
> 
> Inverting not reverting?

Oops.  Sorry for my poor English!

[...]

> > +void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
> > +                                 char *block_name)
> > +{
> > +    char buf[512];
> > +    int len;
> > +    int64_t res;
> > +
> > +    /*
> > +     * First, we send the header part. It contains only the len of
> > +     * idstr, and the idstr itself.
> > +     */
> > +    len = strlen(block_name);
> > +    buf[0] = len;
> > +    memcpy(buf + 1, block_name, len);
> > +
> > +    migrate_send_rp_message(mis, MIG_RP_MSG_RECV_BITMAP, len + 1, buf);
> > +
> > +    /*
> > +     * Next, we dump the received bitmap to the stream.
> > +     *
> > +     * TODO: currently we are safe since we are the only one that is
> > +     * using the to_src_file handle (fault thread is still paused),
> > +     * and it's ok even not taking the mutex. However the best way is
> > +     * to take the lock before sending the message header, and release
> > +     * the lock after sending the bitmap.
> > +     */
> 
> Should we be checking the state?

Sure.  I can add an assertion.

> 
> > +    qemu_mutex_lock(&mis->rp_mutex);
> > +    res = ramblock_recv_bitmap_send(mis->to_src_file, block_name);
> > +    qemu_mutex_unlock(&mis->rp_mutex);
> > +
> > +    trace_migrate_send_rp_recv_bitmap(block_name, res);
> 
> OK, that's a little unusual - I don't think we've got anywhere else
> where the data for the rp_ message isn't in the call to
> migrate_send_rp_message.
> (Another way to structure it would be to make each message send a chunk
> of bitmap; but lets stick with this structure for now)

Yeah, but I thought it is unnecessary complicity, so I didn't do that.

> 
> Can you add, either here or in ramblock_recv_bitmap_send an 'end marker'
> on the bitmap data; just a (non-0) known value byte that would help us
> check if we had a mess where things got misaligned.

Of course. Yes the length at the beginning may not be enough. An
ending mark looks safer.

[...]

> >  /*
> > + * Format: bitmap_size (8 bytes) + whole_bitmap (N bytes).
> > + *
> > + * Returns >0 if success with sent bytes, or <0 if error.
> > + */
> > +int64_t ramblock_recv_bitmap_send(QEMUFile *file, char *block_name)
> > +{
> > +    RAMBlock *block = qemu_ram_block_by_name(block_name);
> > +    uint64_t size;
> > +
> > +    /* We should have made sure that the block exists */
> > +    assert(block);
> 
> Best not to make it assert; just make it fail - the block name is
> coming off the wire anyway.
> (Also can we make it a const char *block_name)

Okay.

> 
> > +    /* Size of the bitmap, in bytes */
> > +    size = (block->max_length >> TARGET_PAGE_BITS) / 8;
> > +    qemu_put_be64(file, size);
> > +    qemu_put_buffer(file, (const uint8_t *)block->receivedmap, size);
> 
> Do we need to be careful about endianness and length of long here?
> The migration stream can (theoretically) migrate between hosts of
> different endianness, e.g. a Power LE and Power BE host it can also
> migrate between a 32bit and 64bit host where the 'long' used in our
> bitmap is a different length.

Ah, good catch...

I feel like we'd better provide a new bitmap helper for this when the
bitmap will be sent to somewhere else, like:

  void bitmap_to_le(unsigned long *dst, const unsigned long *src,
                    long nbits);
  void bitmap_from_le(unsigned long *dst, const unsigned long *src,
                      long nbits);

I used little endian since I *think* that should work even cross 32/64
bits machines (and I think big endian should not work).

> I think that means you have to save it as a series of long's;
> and also just make sure 'size' is a multiple of 'long' - otherwise
> you lose the last few bytes, which on a big endian system would
> be a problem.

Yeah, then the size should possibly be pre-cooked with
BITS_TO_LONGS(). However that's slightly tricky as well, maybe I
should provide another bitmap helper:

  static inline long bitmap_size(long nbits)
  {
      return BITS_TO_LONGS(nbits);
  }

Since the whole thing should be part of bitmap APIs imho.

> 
> Also, should we be using 'max_length' or 'used_length' - ram_save_setup
> stores the used_length.  I don't think we should be accessing outside
> the used_length?  That might also make the thing about 'size' being
> rounded to a 'long' more interesting; maybe need to check you don't use
> the bits outside the used_length.

Yes. AFAIU max_length and used_length are always the same currently in
our codes. I used max_length since in ram_state_init() we inited
block->bmap and block->unsentmap with it. I can switch to used_length
though.

> 
> > +    qemu_fflush(file);
> > +
> > +    if (qemu_file_get_error(file)) {
> > +        return qemu_file_get_error(file);
> > +    }
> > +
> > +    return sizeof(size) + size;
> 
> I think since size is always sent as a 64bit that's  size + 8.

Yes. I "offloaded" the calcluation of sizeof(size) to compiler (in
case I got brain furt when writting the codes...). So you prefer
digits directly in these cases? It might be just fragile if we changed
the type of "size" someday (though I guess we won't).

Let me use "size + 8".

> 
> > +}
> > +
> > +/*
> >   * An outstanding page request, on the source, having been received
> >   * and queued
> >   */
> > @@ -2705,6 +2731,54 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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
> > +    QEMUFile *file = s->rp_state.from_dst_file;
> > +    uint64_t local_size = (block->max_length >> TARGET_PAGE_BITS) / 8;
> > +    uint64_t size;
> > +
> > +    if (s->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
> > +        error_report("%s: incorrect state %s", __func__,
> > +                     MigrationStatus_lookup[s->state]);
> > +        return -EINVAL;
> > +    }
> > +
> > +    size = qemu_get_be64(file);
> > +
> > +    /* The size of the bitmap should match with our ramblock */
> > +    if (size != local_size) {
> > +        error_report("%s: ramblock '%s' bitmap size mismatch "
> > +                     "(0x%lx != 0x%lx)", __func__, block->idstr,
> > +                     size, local_size);
> > +        return -EINVAL;
> > +    }
> 
> Coming back to the used_length thing above;  again I think the rule
> is that the used_length has to match not the max_length.

Yeah. Will switch.

Thanks,

-- 
Peter Xu
