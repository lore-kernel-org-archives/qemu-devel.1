Received: from eggs.gnu.org ([2001:4830:134:3::10]:43055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dKNzs-0001H8-3a
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dKNzp-0003hs-1L
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:59:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1dKNzo-0003hh-Ph
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:59:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C006AC04B316
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 11:58:59 +0000 (UTC)
References: <20170607105810.3003-1-quintela@redhat.com>
	<20170607105810.3003-2-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <d7621000-bb1f-3f83-9d02-595c7ea8fc5d@redhat.com>
Date: Mon, 12 Jun 2017 13:58:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170607105810.3003-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ram: Print block stats also in the
 complete case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com

On 07/06/2017 12:58, Juan Quintela wrote:
> Once there, create populate_disk_info.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> 
> --
> 
> - create populate_disk_info instead of "abusing" populate_ram_info
> ---
>  migration/migration.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 4dbc4f2..cfa266b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -515,6 +515,17 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>      }
>  }
>  
> +static void populate_disk_info(MigrationInfo *info)
> +{
> +    if (blk_mig_active()) {
> +        info->has_disk = true;
> +        info->disk = g_malloc0(sizeof(*info->disk));
> +        info->disk->transferred = blk_mig_bytes_transferred();
> +        info->disk->remaining = blk_mig_bytes_remaining();
> +        info->disk->total = blk_mig_bytes_total();
> +    }
> +}
> +
>  MigrationInfo *qmp_query_migrate(Error **errp)
>  {
>      MigrationInfo *info = g_malloc0(sizeof(*info));
> @@ -540,15 +551,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
>          info->setup_time = s->setup_time;
>  
>          populate_ram_info(info, s);
> -
> -        if (blk_mig_active()) {
> -            info->has_disk = true;
> -            info->disk = g_malloc0(sizeof(*info->disk));
> -            info->disk->transferred = blk_mig_bytes_transferred();
> -            info->disk->remaining = blk_mig_bytes_remaining();
> -            info->disk->total = blk_mig_bytes_total();
> -        }
> -
> +        populate_disk_info(info);
>          break;
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>          /* Mostly the same as active; TODO add some postcopy stats */
> @@ -562,15 +565,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
>          info->setup_time = s->setup_time;
>  
>          populate_ram_info(info, s);
> -
> -        if (blk_mig_active()) {
> -            info->has_disk = true;
> -            info->disk = g_malloc0(sizeof(*info->disk));
> -            info->disk->transferred = blk_mig_bytes_transferred();
> -            info->disk->remaining = blk_mig_bytes_remaining();
> -            info->disk->total = blk_mig_bytes_total();
> -        }
> -
> +        populate_disk_info(info);
>          break;
>      case MIGRATION_STATUS_COLO:
>          info->has_status = true;
> 
