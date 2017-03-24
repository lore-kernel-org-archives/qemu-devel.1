Received: from eggs.gnu.org ([2001:4830:134:3::10]:53907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1crREp-0001uB-0k
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1crREl-0004K8-3A
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:34:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1crREk-0004Jz-TK
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:34:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E94977AEAC
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 15:34:46 +0000 (UTC)
Date: Fri, 24 Mar 2017 15:34:42 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170324153442.GG19076@work-vm>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-29-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-29-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 28/51] ram: Remove ram_save_remaining
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> Just unfold it.  Move ram_bytes_remaining() with the rest of exported
> functions.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 3ae00e2..dd5a453 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -243,16 +243,16 @@ uint64_t xbzrle_mig_pages_overflow(void)
>      return ram_state.xbzrle_overflows;
>  }
>  
> -static ram_addr_t ram_save_remaining(void)
> -{
> -    return ram_state.migration_dirty_pages;
> -}
> -
>  uint64_t ram_bytes_transferred(void)
>  {
>      return ram_state.bytes_transferred;
>  }
>  
> +uint64_t ram_bytes_remaining(void)
> +{
> +    return ram_state.migration_dirty_pages * TARGET_PAGE_SIZE;
> +}
> +
>  /* used by the search for pages to send */
>  struct PageSearchStatus {
>      /* Current block being searched */
> @@ -1438,11 +1438,6 @@ void acct_update_position(QEMUFile *f, size_t size, bool zero)
>      }
>  }
>  
> -uint64_t ram_bytes_remaining(void)
> -{
> -    return ram_save_remaining() * TARGET_PAGE_SIZE;
> -}
> -
>  uint64_t ram_bytes_total(void)
>  {
>      RAMBlock *block;
> @@ -2210,7 +2205,7 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
>      RAMState *rs = opaque;
>      uint64_t remaining_size;
>  
> -    remaining_size = ram_save_remaining() * TARGET_PAGE_SIZE;
> +    remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
>  
>      if (!migration_in_postcopy(migrate_get_current()) &&
>          remaining_size < max_size) {
> @@ -2219,7 +2214,7 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
>          migration_bitmap_sync(rs);
>          rcu_read_unlock();
>          qemu_mutex_unlock_iothread();
> -        remaining_size = ram_save_remaining() * TARGET_PAGE_SIZE;
> +        remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
>      }
>  
>      /* We can do postcopy, and all the data is postcopiable */
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
