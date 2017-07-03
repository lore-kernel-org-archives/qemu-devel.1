Received: from eggs.gnu.org ([2001:4830:134:3::10]:56376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dRuSX-0004vX-LC
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 02:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dRuSS-0007PH-SG
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 02:03:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dRuSS-0007OY-K2
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 02:03:40 -0400
Date: Mon, 3 Jul 2017 14:03:38 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170703060338.GA32568@pxdev.xzpeter.org>
References: <1498817910-20454-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170630102107eucas1p28e19080c358dd88dfaf8a46e3a6a5ae7@eucas1p2.samsung.com>
	<1498817910-20454-4-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1498817910-20454-4-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v7 3/3] migration: add bitmap for received
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
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, quintela@redhat.com, dgilbert@redhat.com, heetae82.ahn@samsung.com

On Fri, Jun 30, 2017 at 06:18:30AM -0400, Alexey Perevalov wrote:
> This patch adds ability to track down already received
> pages, it's necessary for calculation vCPU block time in
> postcopy migration feature, maybe for restore after
> postcopy migration failure.
> Also it's necessary to solve shared memory issue in
> postcopy livemigration. Information about received pages
> will be transferred to the software virtual bridge
> (e.g. OVS-VSWITCHD), to avoid fallocate (unmap) for
> already received pages. fallocate syscall is required for
> remmaped shared memory, due to remmaping itself blocks
> ioctl(UFFDIO_COPY, ioctl in this case will end with EEXIT
> error (struct page is exists after remmap).
> 
> Bitmap is placed into RAMBlock as another postcopy/precopy
> related bitmaps.
> 
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  include/exec/ram_addr.h  | 10 ++++++++++
>  migration/postcopy-ram.c | 16 +++++++++++-----
>  migration/ram.c          | 43 ++++++++++++++++++++++++++++++++++++++++---
>  migration/ram.h          |  6 ++++++
>  4 files changed, 67 insertions(+), 8 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 73d1bea..af5bf26 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -47,6 +47,8 @@ struct RAMBlock {
>       * of the postcopy phase
>       */
>      unsigned long *unsentmap;
> +    /* bitmap of already received pages in postcopy */
> +    unsigned long *receivedmap;
>  };
>  
>  static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
> @@ -60,6 +62,14 @@ static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
>      return (char *)block->host + offset;
>  }
>  
> +static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
> +                                                            RAMBlock *rb)
> +{
> +    uint64_t host_addr_offset =
> +            (uint64_t)(uintptr_t)(host_addr - (void *)rb->host);
> +    return host_addr_offset >> TARGET_PAGE_BITS;
> +}
> +
>  long qemu_getrampagesize(void);
>  unsigned long last_ram_page(void);
>  RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index be497bb..276ce12 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -560,22 +560,27 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
>  }
>  
>  static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
> -        void *from_addr, uint64_t pagesize)
> +                               void *from_addr, uint64_t pagesize, RAMBlock *rb)
>  {
> +    int ret;
>      if (from_addr) {
>          struct uffdio_copy copy_struct;
>          copy_struct.dst = (uint64_t)(uintptr_t)host_addr;
>          copy_struct.src = (uint64_t)(uintptr_t)from_addr;
>          copy_struct.len = pagesize;
>          copy_struct.mode = 0;
> -        return ioctl(userfault_fd, UFFDIO_COPY, &copy_struct);
> +        ret = ioctl(userfault_fd, UFFDIO_COPY, &copy_struct);
>      } else {
>          struct uffdio_zeropage zero_struct;
>          zero_struct.range.start = (uint64_t)(uintptr_t)host_addr;
>          zero_struct.range.len = pagesize;
>          zero_struct.mode = 0;
> -        return ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
> +        ret = ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
> +    }
> +    if (!ret) {
> +        ramblock_recv_bitmap_set(host_addr, rb);
>      }
> +    return ret;
>  }
>  
>  /*
> @@ -592,7 +597,7 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
>       * which would be slightly cheaper, but we'd have to be careful
>       * of the order of updating our page state.
>       */
> -    if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, from, pagesize)) {
> +    if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, from, pagesize, rb)) {
>          int e = errno;
>          error_report("%s: %s copy host: %p from: %p (size: %zd)",
>                       __func__, strerror(e), host, from, pagesize);
> @@ -614,7 +619,8 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
>      trace_postcopy_place_page_zero(host);
>  
>      if (qemu_ram_pagesize(rb) == getpagesize()) {
> -        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, NULL, getpagesize())) {
> +        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, NULL, getpagesize(),
> +                                rb)) {
>              int e = errno;
>              error_report("%s: %s zero host: %p",
>                           __func__, strerror(e), host);
> diff --git a/migration/ram.c b/migration/ram.c
> index 9cc1b17..dfbb36b 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -147,6 +147,32 @@ out:
>      return ret;
>  }
>  
> +void ramblock_recv_map_init(void)
> +{
> +    RAMBlock *rb;
> +
> +    RAMBLOCK_FOREACH(rb) {
> +        assert(!rb->receivedmap);
> +        rb->receivedmap = bitmap_new(rb->max_length >> TARGET_PAGE_BITS);
> +    }
> +}
> +
> +int ramblock_recv_bitmap_test(void *host_addr, RAMBlock *rb)
> +{
> +    return test_bit(ramblock_recv_bitmap_offset(host_addr, rb),
> +                    rb->receivedmap);
> +}
> +
> +void ramblock_recv_bitmap_set(void *host_addr, RAMBlock *rb)
> +{
> +    set_bit_atomic(ramblock_recv_bitmap_offset(host_addr, rb), rb->receivedmap);
> +}
> +
> +void ramblock_recv_bitmap_clear(void *host_addr, RAMBlock *rb)
> +{
> +    clear_bit(ramblock_recv_bitmap_offset(host_addr, rb), rb->receivedmap);
> +}
> +
>  /*
>   * An outstanding page request, on the source, having been received
>   * and queued
> @@ -1793,6 +1819,8 @@ int ram_discard_range(const char *rbname, uint64_t start, size_t length)
>          goto err;
>      }
>  
> +    bitmap_clear(rb->receivedmap, start >> TARGET_PAGE_BITS,
> +                 length >> TARGET_PAGE_BITS);
>      ret = ram_block_discard_range(rb, start, length);
>  
>  err:
> @@ -2324,13 +2352,20 @@ static int ram_load_setup(QEMUFile *f, void *opaque)
>  {
>      xbzrle_load_setup();
>      compress_threads_load_setup();
> +    ramblock_recv_map_init();
>      return 0;
>  }
>  
>  static int ram_load_cleanup(void *opaque)
>  {
> +    RAMBlock *rb;
>      xbzrle_load_cleanup();
>      compress_threads_load_cleanup();
> +
> +    RAMBLOCK_FOREACH(rb) {
> +        g_free(rb->receivedmap);
> +        rb->receivedmap = NULL;
> +    }
>      return 0;
>  }

Yeah, this looks much better. Thanks. Though I may not bother export
ramblock_recv_map_init(), but it's ok.

>  
> @@ -2521,6 +2556,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>          ram_addr_t addr, total_ram_bytes;
>          void *host = NULL;
>          uint8_t ch;
> +        RAMBlock *rb = NULL;
>  
>          addr = qemu_get_be64(f);
>          flags = addr & ~TARGET_PAGE_MASK;
> @@ -2537,15 +2573,16 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>  
>          if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
>                       RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
> -            RAMBlock *block = ram_block_from_stream(f, flags);
> +            rb = ram_block_from_stream(f, flags);
>  
> -            host = host_from_ram_block_offset(block, addr);
> +            host = host_from_ram_block_offset(rb, addr);
>              if (!host) {
>                  error_report("Illegal RAM offset " RAM_ADDR_FMT, addr);
>                  ret = -EINVAL;
>                  break;
>              }
> -            trace_ram_load_loop(block->idstr, (uint64_t)addr, flags, host);
> +            ramblock_recv_bitmap_set(host, rb);

If we move this line here, then we can keep the above *block
definition, then no need to touch other lines as well, so only one new
line addition is needed in ram_load.

> +            trace_ram_load_loop(rb->idstr, (uint64_t)addr, flags, host);
>          }
>  
>          switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
> diff --git a/migration/ram.h b/migration/ram.h
> index c081fde..98d68df 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -52,4 +52,10 @@ int ram_discard_range(const char *block_name, uint64_t start, size_t length);
>  int ram_postcopy_incoming_init(MigrationIncomingState *mis);
>  
>  void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
> +
> +void ramblock_recv_map_init(void);
> +int ramblock_recv_bitmap_test(void *host_addr, RAMBlock *rb);
> +void ramblock_recv_bitmap_set(void *host_addr, RAMBlock *rb);
> +void ramblock_recv_bitmap_clear(void *host_addr, RAMBlock *rb);
> +
>  #endif
> -- 
> 1.8.3.1
> 

Only trivial nitpicks, maybe no need to repost? Anyway:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
