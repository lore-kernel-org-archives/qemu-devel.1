Received: from eggs.gnu.org ([2001:4830:134:3::10]:59879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dLu2u-0005Mo-Ve
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dLu2r-0006hO-Lz
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:24:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dLu2r-0006ga-Dd
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:24:25 -0400
Date: Fri, 16 Jun 2017 17:24:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170616162416.GC2179@work-vm>
References: <1497544575-18628-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170615163629eucas1p1f0abc79e0d893f6b442a380630821e5d@eucas1p1.samsung.com>
	<1497544575-18628-2-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497544575-18628-2-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] migration: postcopy_place_page
 factoring out
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
> Need to mark copied pages as closer as possible to the place where it
> tracks down. That will be necessary in futher patch.
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/postcopy-ram.c | 13 ++++++++-----
>  migration/postcopy-ram.h |  4 ++--
>  migration/ram.c          |  4 ++--
>  3 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index c8c4500..743ca6c 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -566,9 +566,10 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
>   * returns 0 on success
>   */
>  int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
> -                        size_t pagesize)
> +                        RAMBlock *rb)
>  {
>      struct uffdio_copy copy_struct;
> +    size_t pagesize = qemu_ram_pagesize(rb);
>  
>      copy_struct.dst = (uint64_t)(uintptr_t)host;
>      copy_struct.src = (uint64_t)(uintptr_t)from;
> @@ -597,10 +598,12 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
>   * returns 0 on success
>   */
>  int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
> -                             size_t pagesize)
> +                             RAMBlock *rb)
>  {
> +    size_t pagesize;
>      trace_postcopy_place_page_zero(host);
>  
> +    pagesize = qemu_ram_pagesize(rb);
>      if (pagesize == getpagesize()) {
>          struct uffdio_zeropage zero_struct;
>          zero_struct.range.start = (uint64_t)(uintptr_t)host;
> @@ -631,7 +634,7 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
>              memset(mis->postcopy_tmp_zero_page, '\0', mis->largest_page_size);
>          }
>          return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_page,
> -                                   pagesize);
> +                                   rb);
>      }
>  
>      return 0;
> @@ -694,14 +697,14 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
>  }
>  
>  int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
> -                        size_t pagesize)
> +                        RAMBlock *rb)
>  {
>      assert(0);
>      return -1;
>  }
>  
>  int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
> -                        size_t pagesize)
> +                        RAMBlock *rb)
>  {
>      assert(0);
>      return -1;
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index 52d51e8..78a3591 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -72,14 +72,14 @@ void postcopy_discard_send_finish(MigrationState *ms,
>   * returns 0 on success
>   */
>  int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
> -                        size_t pagesize);
> +                        RAMBlock *rb);
>  
>  /*
>   * Place a zero page at (host) atomically
>   * returns 0 on success
>   */
>  int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
> -                             size_t pagesize);
> +                             RAMBlock *rb);
>  
>  /* The current postcopy state is read/set by postcopy_state_get/set
>   * which update it atomically.
> diff --git a/migration/ram.c b/migration/ram.c
> index 8dbdfdb..f50479d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2465,10 +2465,10 @@ static int ram_load_postcopy(QEMUFile *f)
>  
>              if (all_zero) {
>                  ret = postcopy_place_page_zero(mis, place_dest,
> -                                               block->page_size);
> +                                               block);
>              } else {
>                  ret = postcopy_place_page(mis, place_dest,
> -                                          place_source, block->page_size);
> +                                          place_source, block);
>              }
>          }
>          if (!ret) {
> -- 
> 1.9.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
