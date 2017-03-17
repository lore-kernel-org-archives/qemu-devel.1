Received: from eggs.gnu.org ([2001:4830:134:3::10]:57768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cop0R-0001YW-JD
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cop0M-0006E0-II
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:21:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cop0M-0006Dn-9y
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:21:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CE75804FE
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 10:21:06 +0000 (UTC)
Date: Fri, 17 Mar 2017 10:21:02 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170317102101.GD2396@work-vm>
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-30-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315135021.6978-30-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 29/31] ram: Remove dirty_bytes_rate
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
> It can be recalculated from dirty_pages_rate.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/migration/migration.h | 1 -
>  migration/migration.c         | 5 ++---
>  migration/ram.c               | 1 -
>  3 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 54a1a4f..42b9edf 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -167,7 +167,6 @@ struct MigrationState
>      int64_t downtime;
>      int64_t expected_downtime;
>      int64_t dirty_pages_rate;
> -    int64_t dirty_bytes_rate;
>      bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
>      int64_t xbzrle_cache_size;
>      int64_t setup_time;
> diff --git a/migration/migration.c b/migration/migration.c
> index 09d02be..2f8c440 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1107,7 +1107,6 @@ MigrationState *migrate_init(const MigrationParams *params)
>      s->downtime = 0;
>      s->expected_downtime = 0;
>      s->dirty_pages_rate = 0;
> -    s->dirty_bytes_rate = 0;
>      s->setup_time = 0;
>      s->start_postcopy = false;
>      s->postcopy_after_devices = false;
> @@ -1999,8 +1998,8 @@ static void *migration_thread(void *opaque)
>                                        bandwidth, max_size);
>              /* if we haven't sent anything, we don't want to recalculate
>                 10000 is a small enough number for our purposes */
> -            if (s->dirty_bytes_rate && transferred_bytes > 10000) {
> -                s->expected_downtime = s->dirty_bytes_rate / bandwidth;
> +            if (s->dirty_pages_rate && transferred_bytes > 10000) {
> +                s->expected_downtime = s->dirty_pages_rate * (1ul << qemu_target_page_bits())/ bandwidth;

The line got a bit long, please wrap.

Other than that,

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>              }
>  
>              qemu_file_reset_rate_limit(s->to_dst_file);
> diff --git a/migration/ram.c b/migration/ram.c
> index 4563e3d..1006e60 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -687,7 +687,6 @@ static void migration_bitmap_sync(RAMState *rs)
>          }
>          s->dirty_pages_rate = rs->num_dirty_pages_period * 1000
>              / (end_time - rs->start_time);
> -        s->dirty_bytes_rate = s->dirty_pages_rate * TARGET_PAGE_SIZE;
>          rs->start_time = end_time;
>          rs->num_dirty_pages_period = 0;
>      }
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
