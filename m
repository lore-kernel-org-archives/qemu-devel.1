Received: from eggs.gnu.org ([2001:4830:134:3::10]:51309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dhHjL-0005AU-59
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 11:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dhHjG-0006uY-9K
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 11:56:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dhHjG-0006tm-0j
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 11:56:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD74AC04D95B
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 15:47:26 +0000 (UTC)
Date: Mon, 14 Aug 2017 16:47:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170814154720.GB2079@work-vm>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-15-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170808162629.32493-15-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 14/19] migration: Send the fd number
 which we are going to use for this page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We are still sending the page through the main channel, that would
> change later in the series
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 7310da9..169cfc9 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -568,7 +568,7 @@ static uint16_t multifd_send_page(uint8_t *address, bool last_page)
>      qemu_mutex_unlock(&p->mutex);
>      qemu_sem_post(&p->sem);
>  
> -    return 0;
> +    return i;

That should probably be in the patch that defines multifd_send_page

other than that,


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  }
>  
>  struct MultiFDRecvParams {
> @@ -1145,6 +1145,7 @@ static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
>                              bool last_stage)
>  {
>      int pages;
> +    uint16_t fd_num;
>      uint8_t *p;
>      RAMBlock *block = pss->block;
>      ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
> @@ -1156,8 +1157,10 @@ static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
>          ram_counters.transferred +=
>              save_page_header(rs, rs->f, block,
>                               offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
> +        fd_num = multifd_send_page(p, rs->migration_dirty_pages == 1);
> +        qemu_put_be16(rs->f, fd_num);
> +        ram_counters.transferred += 2; /* size of fd_num */
>          qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
> -        multifd_send_page(p, rs->migration_dirty_pages == 1);
>          ram_counters.transferred += TARGET_PAGE_SIZE;
>          pages = 1;
>          ram_counters.normal++;
> @@ -2907,6 +2910,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>      while (!postcopy_running && !ret && !(flags & RAM_SAVE_FLAG_EOS)) {
>          ram_addr_t addr, total_ram_bytes;
>          void *host = NULL;
> +        uint16_t fd_num;
>          uint8_t ch;
>  
>          addr = qemu_get_be64(f);
> @@ -3017,6 +3021,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>              break;
>  
>          case RAM_SAVE_FLAG_MULTIFD_PAGE:
> +            fd_num = qemu_get_be16(f);
> +            if (fd_num != 0) {
> +                /* this is yet an unused variable, changed later */
> +                fd_num = fd_num;
> +            }
>              qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
>              break;
>  
> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
