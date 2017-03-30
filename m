Received: from eggs.gnu.org ([2001:4830:134:3::10]:36682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctTVb-0003Xp-1O
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctTVX-0004ah-T1
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:24:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ctTVX-0004aF-Nt
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:24:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DC7C63E06
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 06:24:30 +0000 (UTC)
Date: Thu, 30 Mar 2017 14:24:24 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170330062424.GA19648@pxdev.xzpeter.org>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-29-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

On Thu, Mar 23, 2017 at 09:45:21PM +0100, Juan Quintela wrote:
> Just unfold it.  Move ram_bytes_remaining() with the rest of exported
> functions.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
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

Here we can directly use ram_bytes_remaining()?

>  
>      if (!migration_in_postcopy(migrate_get_current()) &&
>          remaining_size < max_size) {
> @@ -2219,7 +2214,7 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
>          migration_bitmap_sync(rs);
>          rcu_read_unlock();
>          qemu_mutex_unlock_iothread();
> -        remaining_size = ram_save_remaining() * TARGET_PAGE_SIZE;
> +        remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;

Same here?

Besides:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- peterx
