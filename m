Received: from eggs.gnu.org ([2001:4830:134:3::10]:38431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPnZ9-0001Tj-61
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 06:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPnZ5-0005Jf-6N
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 06:17:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dPnZ4-0005JP-WA
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 06:17:47 -0400
Date: Tue, 27 Jun 2017 18:17:40 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170627101740.GB14652@pxdev.xzpeter.org>
References: <1498557027-18143-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170627095333eucas1p28a2d86104f8df64c05758cd08f1a48df@eucas1p2.samsung.com>
	<1498557027-18143-4-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1498557027-18143-4-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v5 3/3] migration: add bitmap for received
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
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, quintela@redhat.com, dgilbert@redhat.com

On Tue, Jun 27, 2017 at 05:50:27AM -0400, Alexey Perevalov wrote:

[...]

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
> diff --git a/migration/migration.c b/migration/migration.c
> index 71e38bc..53fbd41 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -143,6 +143,7 @@ MigrationIncomingState *migration_incoming_get_current(void)
>          qemu_mutex_init(&mis_current.rp_mutex);
>          qemu_event_init(&mis_current.main_thread_load_event, false);
>          once = true;
> +        ramblock_recv_map_init();

One tiny more comment: shall we init this at the beginning of incoming
migration? Maybe into migration_fd_process_incoming(), before entering
the coroutine?

Then, for the destruction of it below...

[...]

> @@ -2324,8 +2352,14 @@ static int ram_load_setup(QEMUFile *f, void *opaque)
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

... maybe move to migration_incoming_state_destroy()?

And, I didn't really find ram_load_cleanup() in my repo. Am I missing
something?

Other than above, this patch looks good to me.  Thanks,

-- 
Peter Xu
