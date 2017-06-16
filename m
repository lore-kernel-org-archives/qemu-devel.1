Received: from eggs.gnu.org ([2001:4830:134:3::10]:42076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dLwGH-0000LI-8k
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dLwGE-0007jX-4o
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:46:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62803)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dLwGD-0007iQ-Rc
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:46:22 -0400
Date: Fri, 16 Jun 2017 19:46:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170616184613.GG19805@work-vm>
References: <1497544575-18628-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170615163630eucas1p24f8f92a8acc7e408849696645f9557f2@eucas1p2.samsung.com>
	<1497544575-18628-4-git-send-email-a.perevalov@samsung.com>
	<20170616171412.GA19805@work-vm>
	<c32fa26f-7de7-63f8-4202-2eaaa914add3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c32fa26f-7de7-63f8-4202-2eaaa914add3@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] migration: add bitmap for received
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, i.maximets@samsung.com, quintela@redhat.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> On 06/16/2017 08:14 PM, Dr. David Alan Gilbert wrote:
> > * Alexey Perevalov (a.perevalov@samsung.com) wrote:
> > > This patch adds ability to track down already received
> > > pages, it's necessary for calculation vCPU block time in
> > > postcopy migration feature, maybe for restore after
> > > postcopy migration failure.
> > > Also it's necessary to solve shared memory issue in
> > > postcopy livemigration. Information about received pages
> > > will be transferred to the software virtual bridge
> > > (e.g. OVS-VSWITCHD), to avoid fallocate (unmap) for
> > > already received pages. fallocate syscall is required for
> > > remmaped shared memory, due to remmaping itself blocks
> > > ioctl(UFFDIO_COPY, ioctl in this case will end with EEXIT
> > > error (struct page is exists after remmap).
> > > 
> > > Bitmap is placed into RAMBlock as another postcopy/precopy
> > > related bitmaps.
> > > 
> > > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > > ---
> > >   include/exec/ram_addr.h  |  2 ++
> > >   migration/postcopy-ram.c | 11 ++++++++---
> > >   migration/ram.c          | 33 +++++++++++++++++++++++++++++++++
> > >   migration/ram.h          |  5 +++++
> > >   migration/savevm.c       |  1 +
> > >   5 files changed, 49 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> > > index 140efa8..c2c1dfe 100644
> > > --- a/include/exec/ram_addr.h
> > > +++ b/include/exec/ram_addr.h
> > > @@ -47,6 +47,8 @@ struct RAMBlock {
> > >        * of the postcopy phase
> > >        */
> > >       unsigned long *unsentmap;
> > > +    /* bitmap of already received pages in postcopy */
> > > +    unsigned long *receivedmap;
> > >   };
> > >   static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
> > > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > > index 38a429a..5ac3ed2 100644
> > > --- a/migration/postcopy-ram.c
> > > +++ b/migration/postcopy-ram.c
> > > @@ -562,8 +562,13 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
> > >   }
> > >   static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
> > > -        void *from_addr, uint64_t pagesize)
> > > +        void *from_addr, uint64_t pagesize, RAMBlock *rb)
> > >   {
> > > +    /* received page isn't feature of blocktime calculation,
> > > +     * it's more general entity, so keep it here,
> > > +     * but gup betwean two following operation could be high,
> > > +     * and in this case blocktime for such small interval will be lost */
> > > +    set_receivedmap_by_addr(host_addr, rb);
> > >       if (from_addr) {
> > >           struct uffdio_copy copy_struct;
> > >           copy_struct.dst = (uint64_t)(uintptr_t)host_addr;
> > > @@ -595,7 +600,7 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
> > >        * which would be slightly cheaper, but we'd have to be careful
> > >        * of the order of updating our page state.
> > >        */
> > > -    if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, from, pagesize)) {
> > > +    if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, from, pagesize, rb)) {
> > In your first patch of the series you changed postcopy_place_page to
> > take a RAMBlock* *rather* than a pagesize; perhaps it would be better
> > to do the same here?
> that's true only for postcopy_place_page where pagesize is getting from
> ramblock,
> but not true for postcopy_place_page_zero, where initially was len =
> getpagesize()

Ah, yes:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> > 
> > Other than that looks pretty good.
> > 
> > Dave
> > 
> > >           int e = errno;
> > >           error_report("%s: %s copy host: %p from: %p (size: %zd)",
> > >                        __func__, strerror(e), host, from, pagesize);
> > > @@ -619,7 +624,7 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
> > >       pagesize = qemu_ram_pagesize(rb);
> > >       if (pagesize == getpagesize()) {
> > > -        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, 0, getpagesize())) {
> > > +        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, 0, getpagesize(), rb)) {
> > >               int e = errno;
> > >               error_report("%s: %s zero host: %p",
> > >                            __func__, strerror(e), host);
> > > diff --git a/migration/ram.c b/migration/ram.c
> > > index f50479d..f5ea3c2 100644
> > > --- a/migration/ram.c
> > > +++ b/migration/ram.c
> > > @@ -151,6 +151,34 @@ out:
> > >       return ret;
> > >   }
> > > +void init_receivedmap(void)
> > > +{
> > > +    RAMBlock *rb;
> > > +
> > > +    RAMBLOCK_FOREACH(rb) {
> > > +        unsigned long pages;
> > > +        pages = rb->max_length >> TARGET_PAGE_BITS;
> > > +        rb->receivedmap = bitmap_new(pages);
> > > +    }
> > > +}
> > > +
> > > +static unsigned long int get_received_bit_offset(void *host_addr, RAMBlock *rb)
> > > +{
> > > +    uint64_t host_addr_offset = (uint64_t)(uintptr_t)(host_addr
> > > +                                                      - (void *)rb->host);
> > > +    return host_addr_offset >> TARGET_PAGE_BITS;
> > > +}
> > > +
> > > +int test_receivedmap_by_addr(void *host_addr, RAMBlock *rb)
> > > +{
> > > +    return test_bit(get_received_bit_offset(host_addr, rb), rb->receivedmap);
> > > +}
> > > +
> > > +void set_receivedmap_by_addr(void *host_addr, RAMBlock *rb)
> > > +{
> > > +    set_bit_atomic(get_received_bit_offset(host_addr, rb), rb->receivedmap);
> > > +}
> > > +
> > >   /*
> > >    * An outstanding page request, on the source, having been received
> > >    * and queued
> > > @@ -2324,8 +2352,13 @@ static int ram_load_setup(QEMUFile *f, void *opaque)
> > >   static int ram_load_cleanup(void *opaque)
> > >   {
> > > +    RAMBlock *rb;
> > >       xbzrle_load_cleanup();
> > >       compress_threads_load_cleanup();
> > > +
> > > +    RAMBLOCK_FOREACH(rb) {
> > > +        g_free(rb->receivedmap);
> > > +    }
> > >       return 0;
> > >   }
> > > diff --git a/migration/ram.h b/migration/ram.h
> > > index c081fde..7048ff9 100644
> > > --- a/migration/ram.h
> > > +++ b/migration/ram.h
> > > @@ -52,4 +52,9 @@ int ram_discard_range(const char *block_name, uint64_t start, size_t length);
> > >   int ram_postcopy_incoming_init(MigrationIncomingState *mis);
> > >   void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
> > > +
> > > +void init_receivedmap(void);
> > > +int test_receivedmap_by_addr(void *host_addr, RAMBlock *rb);
> > > +void set_receivedmap_by_addr(void *host_addr, RAMBlock *rb);
> > > +
> > >   #endif
> > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > index 31158da..668d3bb 100644
> > > --- a/migration/savevm.c
> > > +++ b/migration/savevm.c
> > > @@ -1372,6 +1372,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
> > >           return -1;
> > >       }
> > > +    init_receivedmap();
> > >       remote_pagesize_summary = qemu_get_be64(mis->from_src_file);
> > >       local_pagesize_summary = ram_pagesize_summary();
> > > -- 
> > > 1.9.1
> > > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> > 
> > 
> 
> -- 
> Best regards,
> Alexey Perevalov
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
