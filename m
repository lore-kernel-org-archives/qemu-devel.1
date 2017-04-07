Received: from eggs.gnu.org ([2001:4830:134:3::10]:38277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwQRz-00044A-RC
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:45:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwQRv-0000Aw-Uy
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:45:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cwQRv-0000Am-PF
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:44:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D84781243
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 09:44:58 +0000 (UTC)
Date: Fri, 7 Apr 2017 10:44:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170407094454.GD2138@work-vm>
References: <20170406130913.2232-1-quintela@redhat.com>
	<20170406130913.2232-12-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406130913.2232-12-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/54] ram: Change num_dirty_pages_period
 type to uint64_t
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
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/exec/ram_addr.h | 2 +-
>  migration/ram.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index b05dc84..9aadc5c 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -356,7 +356,7 @@ static inline
>  uint64_t cpu_physical_memory_sync_dirty_bitmap(unsigned long *dest,
>                                                 ram_addr_t start,
>                                                 ram_addr_t length,
> -                                               int64_t *real_dirty_pages)
> +                                               uint64_t *real_dirty_pages)

right that makes sense because num_dirty_pages_period gets passed to it.

>  {
>      ram_addr_t addr;
>      unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
> diff --git a/migration/ram.c b/migration/ram.c
> index d6cf032..9a82355 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -160,7 +160,7 @@ struct RAMState {
>      /* bytes transferred at start_time */
>      uint64_t bytes_xfer_prev;
>      /* number of dirty pages since start_time */
> -    int64_t num_dirty_pages_period;
> +    uint64_t num_dirty_pages_period;

and trace_migration_bitmap_sync_end is already using PRIu64 so
that sohuld be OK.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  };
>  typedef struct RAMState RAMState;
>  
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
