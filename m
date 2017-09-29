Received: from eggs.gnu.org ([2001:4830:134:3::10]:37525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxuCs-0007ey-9r
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxuCp-0007jD-2S
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:15:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dxuCo-0007hW-PU
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:15:47 -0400
Date: Fri, 29 Sep 2017 13:15:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170929121538.GA2750@work-vm>
References: <1501587624-5915-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170801114037eucas1p2ad2750c687b3a7cdf51b26649312a1b8@eucas1p2.samsung.com>
	<1501587624-5915-4-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501587624-5915-4-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v9 3/3] migration: add bitmap for received
 page
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, i.maximets@samsung.com, heetae82.ahn@samsung.com
List-ID: <qemu-devel.nongnu.org>

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> This patch adds ability to track down already received
> pages, it's necessary for calculation vCPU block time in
> postcopy migration feature, and for recovery after
> postcopy migration failure.
> 
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
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  include/exec/ram_addr.h  | 10 ++++++++++
>  migration/postcopy-ram.c | 17 ++++++++++++-----
>  migration/ram.c          | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  migration/ram.h          |  6 ++++++
>  4 files changed, 73 insertions(+), 5 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index c04f4f6..bb902bb 100644
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
> index be497bb..7a414eb 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -560,22 +560,28 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
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
> +        ramblock_recv_bitmap_set_range(rb, host_addr,
> +                                       pagesize / qemu_target_page_size());
>      }
> +    return ret;
>  }
>  
>  /*
> @@ -592,7 +598,7 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
>       * which would be slightly cheaper, but we'd have to be careful
>       * of the order of updating our page state.
>       */
> -    if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, from, pagesize)) {
> +    if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, from, pagesize, rb)) {
>          int e = errno;
>          error_report("%s: %s copy host: %p from: %p (size: %zd)",
>                       __func__, strerror(e), host, from, pagesize);
> @@ -614,7 +620,8 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
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
> index 9cc1b17..d14b8bb 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -44,6 +44,7 @@
>  #include "qemu/error-report.h"
>  #include "trace.h"
>  #include "exec/ram_addr.h"
> +#include "exec/target_page.h"
>  #include "qemu/rcu_queue.h"
>  #include "migration/colo.h"
>  
> @@ -147,6 +148,40 @@ out:
>      return ret;
>  }
>  
> +static void ramblock_recv_map_init(void)
> +{
> +    RAMBlock *rb;
> +
> +    RAMBLOCK_FOREACH(rb) {
> +        assert(!rb->receivedmap);
> +        rb->receivedmap = bitmap_new(rb->max_length >> qemu_target_page_bits());
> +    }
> +}
> +
> +int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr)
> +{
> +    return test_bit(ramblock_recv_bitmap_offset(host_addr, rb),
> +                    rb->receivedmap);
> +}
> +
> +void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr)
> +{
> +    set_bit_atomic(ramblock_recv_bitmap_offset(host_addr, rb), rb->receivedmap);
> +}
> +
> +void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr,
> +                                    size_t nr)
> +{
> +    bitmap_set_atomic(rb->receivedmap,
> +                      ramblock_recv_bitmap_offset(host_addr, rb),
> +                      nr);
> +}

Can you remember what the logic was behind making the 'set's atomic
but not the clears?  It's probably at least worth a comment.

Other than that, I think this series is fine; it just needs one of the
series that makes use of it to get it merged
(although the 1st two can go in by themselves)

Dave



> +void ramblock_recv_bitmap_clear(RAMBlock *rb, void *host_addr)
> +{
> +    clear_bit(ramblock_recv_bitmap_offset(host_addr, rb), rb->receivedmap);
> +}
> +
>  /*
>   * An outstanding page request, on the source, having been received
>   * and queued
> @@ -1793,6 +1828,8 @@ int ram_discard_range(const char *rbname, uint64_t start, size_t length)
>          goto err;
>      }
>  
> +    bitmap_clear(rb->receivedmap, start >> qemu_target_page_bits(),
> +                 length >> qemu_target_page_bits());
>      ret = ram_block_discard_range(rb, start, length);
>  
>  err:
> @@ -2324,13 +2361,20 @@ static int ram_load_setup(QEMUFile *f, void *opaque)
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
>  
> @@ -2545,6 +2589,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>                  ret = -EINVAL;
>                  break;
>              }
> +            ramblock_recv_bitmap_set(block, host);
>              trace_ram_load_loop(block->idstr, (uint64_t)addr, flags, host);
>          }
>  
> diff --git a/migration/ram.h b/migration/ram.h
> index c081fde..4db9922 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -52,4 +52,10 @@ int ram_discard_range(const char *block_name, uint64_t start, size_t length);
>  int ram_postcopy_incoming_init(MigrationIncomingState *mis);
>  
>  void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
> +
> +int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
> +void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
> +void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_t nr);
> +void ramblock_recv_bitmap_clear(RAMBlock *rb, void *host_addr);
> +
>  #endif
> -- 
> 1.9.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
