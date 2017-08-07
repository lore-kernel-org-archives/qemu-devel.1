Received: from eggs.gnu.org ([2001:4830:134:3::10]:54564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1debLk-0005Mj-7A
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 02:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1debLf-0004VB-8g
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 02:17:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1debLe-0004Tc-W3
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 02:17:07 -0400
Date: Mon, 7 Aug 2017 14:11:40 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170807061140.GV5561@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-23-git-send-email-peterx@redhat.com>
	<20170803105021.GD2076@work-vm>
	<20170804065914.GH5561@pxdev.xzpeter.org>
	<20170804094941.GD2805@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170804094941.GD2805@work-vm>
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

On Fri, Aug 04, 2017 at 10:49:42AM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Thu, Aug 03, 2017 at 11:50:22AM +0100, Dr. David Alan Gilbert wrote:
> > > > +    /* Size of the bitmap, in bytes */
> > > > +    size = (block->max_length >> TARGET_PAGE_BITS) / 8;
> > > > +    qemu_put_be64(file, size);
> > > > +    qemu_put_buffer(file, (const uint8_t *)block->receivedmap, size);
> > > 
> > > Do we need to be careful about endianness and length of long here?
> > > The migration stream can (theoretically) migrate between hosts of
> > > different endianness, e.g. a Power LE and Power BE host it can also
> > > migrate between a 32bit and 64bit host where the 'long' used in our
> > > bitmap is a different length.
> > 
> > Ah, good catch...
> > 
> > I feel like we'd better provide a new bitmap helper for this when the
> > bitmap will be sent to somewhere else, like:
> > 
> >   void bitmap_to_le(unsigned long *dst, const unsigned long *src,
> >                     long nbits);
> >   void bitmap_from_le(unsigned long *dst, const unsigned long *src,
> >                       long nbits);
> > 
> > I used little endian since I *think* that should work even cross 32/64
> > bits machines (and I think big endian should not work).
> 
> Lets think about some combinations:
> 
> 64 bit LE  G0,G1...G7
> 64 bit BE  G7,G6...G0
> 32 bit LE  A0,A1,A2,A3, B0,B1,B2,B3
> 32 bit BE  A3,A2,A1,A0  B3,B2,B1,B0
> 
> considering a 64bit BE src to a 32bit LE dest:
>   64 bit BE  G7,G6...G0
>   bitmap_to_le swaps that to
>              G0,G1,..G7
> 
> destination reads two 32bit chunks:
>   G0,G1,G2,G3    G4,G5,G6,G7
> 
> dest is LE so no byteswap is needed.
> 
> Yes, I _think_ that's OK.

Hmm, I thought it over again and see another problem, which makes it
more interesting...

The size of the bitmap can actually be different on hosts that are
using different word sizes (or say, long size, which should be the
same size of the word size). E.g., when we allocate a bitmap that
covers nbits=6*32+1, we'll get 28 bytes (6*4+4) sized bitmap on 32bit
machines, and 32 bytes (3*8+8) sized bitmap on 64bit machines.

I really hoped that we have some typedef for current bitmap, like:

  typedef long *Bitmap;

Then I can simply consider to switch the "long" to uint64_t, but sadly
we don't have such. Then, type switching would be slightly overkill
(maybe still doable, at least I need to touch lots of files).

One of the solution is: I always send the bitmap in 8-bytes chunk,
even on 32bit machines. If there is not aligned bitmap size (of course
it'll only happen on 32bit machines), I align it up to 8-bytes, then
fill the rest with zeros. I'll try to do this hack only in migration
code for now.

-- 
Peter Xu
