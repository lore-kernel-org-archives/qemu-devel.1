Received: from eggs.gnu.org ([2001:4830:134:3::10]:44510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dPlrs-0008Jy-Jh
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dPlro-0008Gy-I1
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:29:04 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:31934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dPlro-0008Dc-8o
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:29:00 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OS700AL2684GA60@mailout2.w1.samsung.com> for
	qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:28:52 +0100 (BST)
Date: Tue, 27 Jun 2017 11:28:48 +0300
From: Alexey <a.perevalov@samsung.com>
Message-id: <20170627082848.GA4827@aperevalov-ubuntu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <20170627040310.GL3936@pxdev.xzpeter.org>
References: <1498466120-5836-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170626083552eucas1p2db6a8bd9188a95d72aad188d6b633dd9@eucas1p2.samsung.com>
	<1498466120-5836-4-git-send-email-a.perevalov@samsung.com>
	<20170627040310.GL3936@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v4 3/3] migration: add bitmap for received
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: i.maximets@samsung.com, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com

On Tue, Jun 27, 2017 at 12:03:10PM +0800, Peter Xu wrote:
> On Mon, Jun 26, 2017 at 11:35:20AM +0300, Alexey Perevalov wrote:
> > This patch adds ability to track down already received
> > pages, it's necessary for calculation vCPU block time in
> > postcopy migration feature, maybe for restore after
> > postcopy migration failure.
> > Also it's necessary to solve shared memory issue in
> > postcopy livemigration. Information about received pages
> > will be transferred to the software virtual bridge
> > (e.g. OVS-VSWITCHD), to avoid fallocate (unmap) for
> > already received pages. fallocate syscall is required for
> > remmaped shared memory, due to remmaping itself blocks
> > ioctl(UFFDIO_COPY, ioctl in this case will end with EEXIT
> > error (struct page is exists after remmap).
> > 
> > Bitmap is placed into RAMBlock as another postcopy/precopy
> > related bitmaps.
> > 
> > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> 
> Mostly good to me, some minor nits only...
> 
> [...]
> 
> >  static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
> > -        void *from_addr, uint64_t pagesize)
> > +                               void *from_addr, uint64_t pagesize, RAMBlock *rb)
> >  {
> > +    int ret;
> >      if (from_addr) {
> >          struct uffdio_copy copy_struct;
> >          copy_struct.dst = (uint64_t)(uintptr_t)host_addr;
> >          copy_struct.src = (uint64_t)(uintptr_t)from_addr;
> >          copy_struct.len = pagesize;
> >          copy_struct.mode = 0;
> > -        return ioctl(userfault_fd, UFFDIO_COPY, &copy_struct);
> > +        ret = ioctl(userfault_fd, UFFDIO_COPY, &copy_struct);
> >      } else {
> >          struct uffdio_zeropage zero_struct;
> >          zero_struct.range.start = (uint64_t)(uintptr_t)host_addr;
> >          zero_struct.range.len = pagesize;
> >          zero_struct.mode = 0;
> > -        return ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
> > +        ret = ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
> > +    }
> > +    /* received page isn't feature of blocktime calculation,
> > +     * it's more general entity, so keep it here,
> > +     * but gup betwean two following operation could be high,
> > +     * and in this case blocktime for such small interval will be lost */
> 
> I would drop this comment for this patch. It didn't help me to be
> clearer on the code but a bit more messy... Maybe it suites for some
> place in the blocktime series? Not sure.
yes, here could be a problem in stats, so it worth to mention about
it in stats series.
> 
> [...]
> 
> > +void ramblock_recv_map_init(void)
> > +{
> > +    RAMBlock *rb;
> > +
> > +    RAMBLOCK_FOREACH(rb) {
> > +        unsigned long pages;
> > +        pages = rb->max_length >> TARGET_PAGE_BITS;
> > +        assert(!rb->receivedmap);
> > +        rb->receivedmap = bitmap_new(pages);
> 
> I'll prefer removing pages variable since used only once.
no problem )
> 
> [...]
> 
> > +static void ramblock_recv_bitmap_clear_range(uint64_t start, size_t length,
> > +                                             RAMBlock *rb)
> > +{
> > +    int i, range_count;
> > +    long nr_bit = start >> TARGET_PAGE_BITS;
> > +    range_count = length >> TARGET_PAGE_BITS;
> > +    for (i = 0; i < range_count; i++) {
> > +        clear_bit(nr_bit, rb->receivedmap);
> > +        nr_bit += 1;
> 
> (Dave commented this one)
I agree with Dave, looks like I invented bitmap_clear ;)
> 
> [...]
> 
> > @@ -2513,6 +2560,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
> >          ram_addr_t addr, total_ram_bytes;
> >          void *host = NULL;
> >          uint8_t ch;
> > +        RAMBlock *rb = NULL;
> >  
> >          addr = qemu_get_be64(f);
> >          flags = addr & ~TARGET_PAGE_MASK;
> > @@ -2520,15 +2568,15 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
> >  
> >          if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
> >                       RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
> > -            RAMBlock *block = ram_block_from_stream(f, flags);
> > +            rb = ram_block_from_stream(f, flags);
> >  
> > -            host = host_from_ram_block_offset(block, addr);
> > +            host = host_from_ram_block_offset(rb, addr);
> >              if (!host) {
> >                  error_report("Illegal RAM offset " RAM_ADDR_FMT, addr);
> >                  ret = -EINVAL;
> >                  break;
> >              }
> 
> IMHO it's ok to set the bit once here.  Thanks,
yes, this is common place for all copying operations here.
> 
> > -            trace_ram_load_loop(block->idstr, (uint64_t)addr, flags, host);
> > +            trace_ram_load_loop(rb->idstr, (uint64_t)addr, flags, host);
> >          }
> >  
> >          switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
> > @@ -2582,10 +2630,12 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
> >  
> >          case RAM_SAVE_FLAG_ZERO:
> >              ch = qemu_get_byte(f);
> > +            ramblock_recv_bitmap_set(host, rb);
> >              ram_handle_compressed(host, ch, TARGET_PAGE_SIZE);
> >              break;
> >  
> >          case RAM_SAVE_FLAG_PAGE:
> > +            ramblock_recv_bitmap_set(host, rb);
> >              qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
> >              break;
> >  
> > @@ -2596,10 +2646,13 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
> >                  ret = -EINVAL;
> >                  break;
> >              }
> > +
> > +            ramblock_recv_bitmap_set(host, rb);
> >              decompress_data_with_multi_threads(f, host, len);
> >              break;
> >  
> >          case RAM_SAVE_FLAG_XBZRLE:
> > +            ramblock_recv_bitmap_set(host, rb);
> >              if (load_xbzrle(f, addr, host) < 0) {
> >                  error_report("Failed to decompress XBZRLE page at "
> >                               RAM_ADDR_FMT, addr);
> 
> -- 
> Peter Xu
> 

-- 

BR
Alexey
