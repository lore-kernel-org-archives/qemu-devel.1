Received: from eggs.gnu.org ([2001:4830:134:3::10]:37860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coY3A-00060G-Ue
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coY35-0005E9-UN
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:14:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1coY35-0005Cc-OL
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:14:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3DAF81247
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 16:14:47 +0000 (UTC)
Date: Thu, 16 Mar 2017 16:14:43 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170316161443.GM2567@work-vm>
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-14-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315135021.6978-14-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/31] ram: Remove
 norm_mig_bytes_transferred
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
> Its value can be calculated by other exported.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/migration/migration.h | 1 -
>  migration/migration.c         | 3 ++-
>  migration/ram.c               | 5 -----
>  3 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 9c83951..84cef4b 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -277,7 +277,6 @@ void free_xbzrle_decoded_buf(void);
>  void acct_update_position(QEMUFile *f, size_t size, bool zero);
>  
>  uint64_t dup_mig_pages_transferred(void);
> -uint64_t norm_mig_bytes_transferred(void);
>  uint64_t norm_mig_pages_transferred(void);
>  uint64_t xbzrle_mig_bytes_transferred(void);
>  uint64_t xbzrle_mig_pages_transferred(void);
> diff --git a/migration/migration.c b/migration/migration.c
> index c3e1b95..46645b6 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -642,7 +642,8 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>      /* legacy value.  It is not used anymore */
>      info->ram->skipped = 0;
>      info->ram->normal = norm_mig_pages_transferred();
> -    info->ram->normal_bytes = norm_mig_bytes_transferred();
> +    info->ram->normal_bytes = norm_mig_pages_transferred() *
> +        (1ul << qemu_target_page_bits());
>      info->ram->mbps = s->mbps;
>      info->ram->dirty_sync_count = s->dirty_sync_count;
>      info->ram->postcopy_requests = s->postcopy_requests;
> diff --git a/migration/ram.c b/migration/ram.c
> index 58c7dc7..8caeb4f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -191,11 +191,6 @@ uint64_t dup_mig_pages_transferred(void)
>      return ram_state.zero_pages;
>  }
>  
> -uint64_t norm_mig_bytes_transferred(void)
> -{
> -    return ram_state.norm_pages * TARGET_PAGE_SIZE;
> -}
> -
>  uint64_t norm_mig_pages_transferred(void)
>  {
>      return ram_state.norm_pages;
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
