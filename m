Received: from eggs.gnu.org ([2001:4830:134:3::10]:38748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnjxE-0006AM-Dg
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnjxB-0002hs-RS
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:45:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cnjxB-0002hi-IF
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:45:21 -0400
Date: Tue, 14 Mar 2017 10:45:16 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170314104516.GF2652@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170314102747.31395-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170314102747.31395-1-fanc.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH] Output dirty-bytes-rate instead of
 dirty-pages-rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: eblake@redhat.com, quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com, maozy.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>

On Tue, Mar 14, 2017 at 06:27:47PM +0800, Chao Fan wrote:
> In hmp, dirty-bytes-rate is more friendly than dirty-pages-rate.
> It's also better for other tools to determine the cpu throttle
> value in different architecture.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  hmp.c                 | 6 +++---
>  migration/migration.c | 2 +-
>  qapi-schema.json      | 8 ++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 261843f..7334bc5 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -215,9 +215,9 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>                         info->ram->normal_bytes >> 10);
>          monitor_printf(mon, "dirty sync count: %" PRIu64 "\n",
>                         info->ram->dirty_sync_count);
> -        if (info->ram->dirty_pages_rate) {
> -            monitor_printf(mon, "dirty pages rate: %" PRIu64 " pages\n",
> -                           info->ram->dirty_pages_rate);
> +        if (info->ram->dirty_bytes_rate) {
> +            monitor_printf(mon, "dirty bytes rate: %" PRIu64 " bytes/s\n",
> +                           info->ram->dirty_bytes_rate);
>          }
>          if (info->ram->postcopy_requests) {
>              monitor_printf(mon, "postcopy request count: %" PRIu64 "\n",
> diff --git a/migration/migration.c b/migration/migration.c
> index 3dab684..7e7b62c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -648,7 +648,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>  
>      if (s->state != MIGRATION_STATUS_COMPLETED) {
>          info->ram->remaining = ram_bytes_remaining();
> -        info->ram->dirty_pages_rate = s->dirty_pages_rate;
> +        info->ram->dirty_bytes_rate = s->dirty_bytes_rate;
>      }
>  }
>  
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 32b4a4b..83a45f8 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -565,9 +565,6 @@
>  #
>  # @normal-bytes: number of normal bytes sent (since 1.2)
>  #
> -# @dirty-pages-rate: number of pages dirtied by second by the
> -#        guest (since 1.3)
> -#
>  # @mbps: throughput in megabits/sec. (since 1.6)
>  #
>  # @dirty-sync-count: number of times that dirty ram was synchronized (since 2.1)
> @@ -575,12 +572,15 @@
>  # @postcopy-requests: The number of page requests received from the destination
>  #        (since 2.7)
>  #
> +# @dirty-bytes-rate: how many bytes  dirtied by second by the
> +#        guest (since 2.9)
> +#
>  # Since: 0.14.0
>  ##
>  { 'struct': 'MigrationStats',
>    'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
>             'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
> -           'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
> +           'normal-bytes': 'int', 'dirty-bytes-rate' : 'int',
>             'mbps' : 'number', 'dirty-sync-count' : 'int',
>             'postcopy-requests' : 'int' } }

You can't do this - this breaks every single app that uses dirty-pages-rate.

The only option is to add dirty-bytes-rate as a second field, and leave
the existing field unchanged. Alternatively, output 'page-size' and let
the application do the math.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
