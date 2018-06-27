Received: from eggs.gnu.org ([2001:4830:134:3::10]:33826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fY7Gh-0005o5-Ih
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fY7Ge-0007Lb-FL
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:01:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fY7Ge-0007Kw-7C
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:01:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D322818F6E5
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 10:01:39 +0000 (UTC)
Date: Wed, 27 Jun 2018 11:01:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180627100135.GC2423@work-vm>
References: <20180626181932.11909-1-quintela@redhat.com>
	<20180626181932.11909-9-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626181932.11909-9-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v16 09/14] migration: Create multifd_bytes
 ram_counter
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
> This will include how many bytes they are sent through multifd.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hmp.c                 | 2 ++
>  migration/migration.c | 1 +
>  qapi/migration.json   | 5 ++++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hmp.c b/hmp.c
> index f601099f90..0da0b0ac33 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -234,6 +234,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>                         info->ram->dirty_sync_count);
>          monitor_printf(mon, "page size: %" PRIu64 " kbytes\n",
>                         info->ram->page_size >> 10);
> +        monitor_printf(mon, "multifd bytes: %" PRIu64 " kbytes\n",
> +                       info->ram->multifd_bytes >> 10);
>  
>          if (info->ram->dirty_pages_rate) {
>              monitor_printf(mon, "dirty pages rate: %" PRIu64 " pages\n",
> diff --git a/migration/migration.c b/migration/migration.c
> index 264f3ce84e..2680ba2d47 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -708,6 +708,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>      info->ram->dirty_sync_count = ram_counters.dirty_sync_count;
>      info->ram->postcopy_requests = ram_counters.postcopy_requests;
>      info->ram->page_size = qemu_target_page_size();
> +    info->ram->multifd_bytes = ram_counters.multifd_bytes;
>  
>      if (migrate_use_xbzrle()) {
>          info->has_xbzrle_cache = true;
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 1b4c1db670..186e8a7303 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -39,6 +39,8 @@
>  # @page-size: The number of bytes per page for the various page-based
>  #        statistics (since 2.10)
>  #
> +# @multifd-bytes: The number of bytes sent through multifd (since 3.0)
> +#
>  # Since: 0.14.0
>  ##
>  { 'struct': 'MigrationStats',
> @@ -46,7 +48,8 @@
>             'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
>             'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
>             'mbps' : 'number', 'dirty-sync-count' : 'int',
> -           'postcopy-requests' : 'int', 'page-size' : 'int' } }
> +           'postcopy-requests' : 'int', 'page-size' : 'int',
> +           'multifd-bytes' : 'uint64' } }
>  
>  ##
>  # @XBZRLECacheStats:
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
