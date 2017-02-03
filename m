Received: from eggs.gnu.org ([2001:4830:134:3::10]:33128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZbax-0007Hl-JJ
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:00:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZbau-0003Id-At
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:59:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cZbau-0003HY-1P
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:59:56 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF6D07E9D6
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 10:59:55 +0000 (UTC)
Date: Fri, 3 Feb 2017 10:59:51 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170203105950.GC3208@work-vm>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-14-git-send-email-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485207141-1941-14-git-send-email-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/17] migration: Send the fd number which
 we are going to use for this page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We are still sending the page through the main channel, that would
> change later in the series
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 1267730..ca94704 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -566,7 +566,7 @@ static int multifd_send_page(uint8_t *address)
>      qemu_cond_signal(&multifd_send[i].cond);
>      qemu_mutex_unlock(&multifd_send[i].mutex);
> 
> -    return 0;
> +    return i;
>  }
> 
>  struct MultiFDRecvParams {
> @@ -1083,6 +1083,7 @@ static int ram_multifd_page(QEMUFile *f, PageSearchStatus *pss,
>                              bool last_stage, uint64_t *bytes_transferred)
>  {
>      int pages;
> +    uint16_t fd_num;
>      uint8_t *p;
>      RAMBlock *block = pss->block;
>      ram_addr_t offset = pss->offset;
> @@ -1096,8 +1097,10 @@ static int ram_multifd_page(QEMUFile *f, PageSearchStatus *pss,
>      if (pages == -1) {
>          *bytes_transferred +=
>              save_page_header(f, block, offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
> +        fd_num = multifd_send_page(p);
> +        qemu_put_be16(f, fd_num);
> +        *bytes_transferred += 2; /* size of fd_num */
>          qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
> -        multifd_send_page(p);
>          *bytes_transferred += TARGET_PAGE_SIZE;
>          pages = 1;
>          acct_info.norm_pages++;
> @@ -2815,6 +2818,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>      while (!postcopy_running && !ret && !(flags & RAM_SAVE_FLAG_EOS)) {
>          ram_addr_t addr, total_ram_bytes;
>          void *host = NULL;
> +        uint16_t fd_num;
>          uint8_t ch;
> 
>          addr = qemu_get_be64(f);
> @@ -2915,6 +2919,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
