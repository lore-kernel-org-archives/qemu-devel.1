Received: from eggs.gnu.org ([2001:4830:134:3::10]:38643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ddZEu-0006UH-Na
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ddZEr-000499-Ft
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:49:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ddZEr-00048M-69
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:49:49 -0400
Date: Fri, 4 Aug 2017 10:49:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170804094941.GD2805@work-vm>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-23-git-send-email-peterx@redhat.com>
	<20170803105021.GD2076@work-vm>
	<20170804065914.GH5561@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170804065914.GH5561@pxdev.xzpeter.org>
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> On Thu, Aug 03, 2017 at 11:50:22AM +0100, Dr. David Alan Gilbert wrote:
> > > +    /* Size of the bitmap, in bytes */
> > > +    size = (block->max_length >> TARGET_PAGE_BITS) / 8;
> > > +    qemu_put_be64(file, size);
> > > +    qemu_put_buffer(file, (const uint8_t *)block->receivedmap, size);
> > 
> > Do we need to be careful about endianness and length of long here?
> > The migration stream can (theoretically) migrate between hosts of
> > different endianness, e.g. a Power LE and Power BE host it can also
> > migrate between a 32bit and 64bit host where the 'long' used in our
> > bitmap is a different length.
> 
> Ah, good catch...
> 
> I feel like we'd better provide a new bitmap helper for this when the
> bitmap will be sent to somewhere else, like:
> 
>   void bitmap_to_le(unsigned long *dst, const unsigned long *src,
>                     long nbits);
>   void bitmap_from_le(unsigned long *dst, const unsigned long *src,
>                       long nbits);
> 
> I used little endian since I *think* that should work even cross 32/64
> bits machines (and I think big endian should not work).

Lets think about some combinations:

64 bit LE  G0,G1...G7
64 bit BE  G7,G6...G0
32 bit LE  A0,A1,A2,A3, B0,B1,B2,B3
32 bit BE  A3,A2,A1,A0  B3,B2,B1,B0

considering a 64bit BE src to a 32bit LE dest:
  64 bit BE  G7,G6...G0
  bitmap_to_le swaps that to
             G0,G1,..G7

destination reads two 32bit chunks:
  G0,G1,G2,G3    G4,G5,G6,G7

dest is LE so no byteswap is needed.

Yes, I _think_ that's OK.

> > I think that means you have to save it as a series of long's;
> > and also just make sure 'size' is a multiple of 'long' - otherwise
> > you lose the last few bytes, which on a big endian system would
> > be a problem.
> 
> Yeah, then the size should possibly be pre-cooked with
> BITS_TO_LONGS(). However that's slightly tricky as well, maybe I
> should provide another bitmap helper:
> 
>   static inline long bitmap_size(long nbits)
>   {
>       return BITS_TO_LONGS(nbits);
>   }
> 
> Since the whole thing should be part of bitmap APIs imho.

The macro is enough I think.

> > 
> > Also, should we be using 'max_length' or 'used_length' - ram_save_setup
> > stores the used_length.  I don't think we should be accessing outside
> > the used_length?  That might also make the thing about 'size' being
> > rounded to a 'long' more interesting; maybe need to check you don't use
> > the bits outside the used_length.
> 
> Yes. AFAIU max_length and used_length are always the same currently in
> our codes. I used max_length since in ram_state_init() we inited
> block->bmap and block->unsentmap with it. I can switch to used_length
> though.

I remember it went in a couple of years ago because there were cases it
was different; they're rare though - I think it was an ACPI case.

> > > +    qemu_fflush(file);
> > > +
> > > +    if (qemu_file_get_error(file)) {
> > > +        return qemu_file_get_error(file);
> > > +    }
> > > +
> > > +    return sizeof(size) + size;
> > 
> > I think since size is always sent as a 64bit that's  size + 8.
> 
> Yes. I "offloaded" the calcluation of sizeof(size) to compiler (in
> case I got brain furt when writting the codes...). So you prefer
> digits directly in these cases? It might be just fragile if we changed
> the type of "size" someday (though I guess we won't).
> 
> Let me use "size + 8".

Lets stick with what you have actually; it's OK since size is a
uint64_t.

Dave

> 
> > 
> > > +}
> > > +
> > > +/*
> > >   * An outstanding page request, on the source, having been received
> > >   * and queued
> > >   */
> > > @@ -2705,6 +2731,54 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
> > >      return ret;
> > >  }
> > >  
> > > +/*
> > > + * Read the received bitmap, revert it as the initial dirty bitmap.
> > > + * This is only used when the postcopy migration is paused but wants
> > > + * to resume from a middle point.
> > > + */
> > > +int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
> > > +{
> > > +    QEMUFile *file = s->rp_state.from_dst_file;
> > > +    uint64_t local_size = (block->max_length >> TARGET_PAGE_BITS) / 8;
> > > +    uint64_t size;
> > > +
> > > +    if (s->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
> > > +        error_report("%s: incorrect state %s", __func__,
> > > +                     MigrationStatus_lookup[s->state]);
> > > +        return -EINVAL;
> > > +    }
> > > +
> > > +    size = qemu_get_be64(file);
> > > +
> > > +    /* The size of the bitmap should match with our ramblock */
> > > +    if (size != local_size) {
> > > +        error_report("%s: ramblock '%s' bitmap size mismatch "
> > > +                     "(0x%lx != 0x%lx)", __func__, block->idstr,
> > > +                     size, local_size);
> > > +        return -EINVAL;
> > > +    }
> > 
> > Coming back to the used_length thing above;  again I think the rule
> > is that the used_length has to match not the max_length.
> 
> Yeah. Will switch.
> 
> Thanks,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
