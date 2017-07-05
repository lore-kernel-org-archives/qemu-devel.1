Received: from eggs.gnu.org ([2001:4830:134:3::10]:49658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dSmpJ-0005m4-Ox
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dSmpE-00051T-2z
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:06:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dSmpD-000515-ST
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:06:48 -0400
Date: Wed, 5 Jul 2017 17:06:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170705160640.GB2284@work-vm>
References: <CAGKXQyfO-yu3qZf7RHiUPXQZDSZwn6N_48Ji8adPHozkpK9JBQ@mail.gmail.com>
	<20170630112610.GA2437@work-vm>
	<20170705151030.GF29910@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170705151030.GF29910@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] DIRTY_MEMORY_BLOCK_SIZE;
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: ali saeedi <ali.saeedi56@gmail.com>, qemu-devel@nongnu.org

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Fri, Jun 30, 2017 at 12:26:10PM +0100, Dr. David Alan Gilbert wrote:
> > * ali saeedi (ali.saeedi56@gmail.com) wrote:
> > > Hello
> > > what does 'DIRTY_MEMORY_BLOCK_SIZE' mean?
> > > is it the number of words in a block? or number of pages in a block? or
> > > number of bytes in a block?
> > > thanks a lot
> > 
> > (cc'ing Stefan)
> > I think that DIRTY_MEMORY_BLOCK_SIZE is the number of TARGET_PAGEs
> > within one DIRTY_MEMORY_BLOCK
> > So with the common 4k target page that's 4k*256k*8=8GB/dirty memory
> > block - note these are just the size of structure sin qemu, it's still
> > got the ranularity ot mark individual target pages as dirty.
> 
> Right, the calculation is shown in the comment above the code:
> 
>  *   rcu_read_lock();
>  *
>  *   DirtyMemoryBlocks *blocks =
>  *       atomic_rcu_read(&ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]);
>  *
>  *   ram_addr_t idx = (addr >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK_SIZE;
>  *   unsigned long *block = blocks.blocks[idx];
>  *   ...access block bitmap...
>  *
>  *   rcu_read_unlock();
> 
> Rather than focussing on DIRTY_MEMORY_BLOCK_SIZE, make sure you
> understand how DirtyMemoryBlocks works.  It is an array of bitmap
> pointers.
> 
> Instead of directly indexing into a single huge dirty memory bitmap,
> QEMU divides the dirty memory bitmap into fixed-sized chunks.  Each
> chunk covers DIRTY_MEMORY_BLOCK_SIZE pages.
> 
> The reason for this layer of indirection is so that the dirty memory
> bitmap can be accessed without taking a traditional lock (just RCU) and
> also supports memory hotplug.
> 
> Without indirection it would be difficult to grow the bitmap while other
> threads are writing to it.  Thanks to the indirection, it's possible to
> allocate new chunks and continue using the old chunks when growth
> occurs.

I guess this works like the old non-chunk version, in that there's no
direct correspondence between DirtyMemoryBlocks and RAMBlock's - i.e.
one RAMBlock might span two DirtyMemoryBlocks even if it's smaller
than DIRTY_MEMORY_BLOCK_SIZE.

Dave


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
