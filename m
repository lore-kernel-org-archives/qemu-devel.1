Received: from eggs.gnu.org ([2001:4830:134:3::10]:58540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dY8Dv-0007DZ-J8
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dY8Dr-0002IN-NB
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:58:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dY8Dr-0002Hr-DX
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:58:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F81DC058ECA
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 09:58:18 +0000 (UTC)
Date: Thu, 20 Jul 2017 10:58:11 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170720095811.GB2101@work-vm>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-13-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717134238.1966-13-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 12/17] migration: Send the fd number
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
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

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
> index 90e1bcb..ac0742f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -568,7 +568,7 @@ static int multifd_send_page(uint8_t *address)
>      qemu_mutex_unlock(&p->mutex);
>      qemu_sem_post(&p->sem);
>  
> -    return 0;
> +    return i;

is 'i' anything sane so far - I think this is currently a bogus value
so perhaps it's best to keep it as 0 till later?
Also, add a comment to multifd_send_page to say it'll return the fd
to use.


>  }
>  
>  struct MultiFDRecvParams {
> @@ -1143,6 +1143,7 @@ static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
>                              bool last_stage)
>  {
>      int pages;
> +    uint16_t fd_num;
>      uint8_t *p;
>      RAMBlock *block = pss->block;
>      ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
> @@ -1154,8 +1155,10 @@ static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
>          ram_counters.transferred +=
>              save_page_header(rs, rs->f, block,
>                               offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
> +        fd_num = multifd_send_page(p);
> +        qemu_put_be16(rs->f, fd_num);

Check for errors from multifd_send_page?
(I'd have preferred to have made this one field in a new fixed size word
which will get used for other things as well, but I'm OK with it this
way).

I think you've also got a 2^8 fd limit in some of the other configs
as opposed to the 2^16 here.

> +        ram_counters.transferred += 2; /* size of fd_num */
>          qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
> -        multifd_send_page(p);
>          ram_counters.transferred += TARGET_PAGE_SIZE;
>          pages = 1;
>          ram_counters.normal++;
> @@ -2905,6 +2908,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>      while (!postcopy_running && !ret && !(flags & RAM_SAVE_FLAG_EOS)) {
>          ram_addr_t addr, total_ram_bytes;
>          void *host = NULL;
> +        uint16_t fd_num;
>          uint8_t ch;
>  
>          addr = qemu_get_be64(f);
> @@ -3015,6 +3019,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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

Dave

> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
