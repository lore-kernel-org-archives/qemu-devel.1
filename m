Received: from eggs.gnu.org ([2001:4830:134:3::10]:49492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eYRQH-0000Hl-Ib
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 02:00:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eYRQE-0003wb-H9
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 02:00:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eYRQE-0003v9-8M
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 02:00:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FBD37EA8B
	for <qemu-devel@nongnu.org>; Mon,  8 Jan 2018 07:00:36 +0000 (UTC)
Date: Mon, 8 Jan 2018 15:00:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180108070026.GB10749@xz-mi>
References: <20180105205109.683-1-quintela@redhat.com>
	<20180105205109.683-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180105205109.683-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] migration: Create tcp_port parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Fri, Jan 05, 2018 at 09:51:08PM +0100, Juan Quintela wrote:
> It will be used to store the uri tcp_port parameter.  This is the only
> parameter than can change and we can need to be able to connect to it.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 
> This used to be uri parameter, but it has so many troubles to
> reproduce that it don't just make sense.
> ---
>  hmp.c                 |  7 +++++++
>  migration/migration.c | 10 ++++++++++
>  qapi/migration.json   | 19 ++++++++++++++++---
>  3 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 354baaa6b6..1bb9d5d8f8 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -360,6 +360,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %" PRIu64 "\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
>              params->xbzrle_cache_size);
> +        monitor_printf(mon, "%s: %d\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_TCP_PORT),
> +            params->tcp_port);
>      }
>  
>      qapi_free_MigrationParameters(params);
> @@ -1674,6 +1677,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          }
>          p->xbzrle_cache_size = cache_size;
>          break;
> +    case MIGRATION_PARAMETER_TCP_PORT:
> +        p->has_tcp_port = true;
> +        visit_type_uint16(v, param, &p->tcp_port, &err);
> +        break;
>      default:
>          assert(0);
>      }
> diff --git a/migration/migration.c b/migration/migration.c
> index 7a77b193c1..4cdd8ee31b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -522,6 +522,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->x_multifd_page_count = s->parameters.x_multifd_page_count;
>      params->has_xbzrle_cache_size = true;
>      params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
> +    params->has_tcp_port = true;
> +    params->tcp_port = s->parameters.tcp_port;
>  
>      return params;
>  }
> @@ -923,6 +925,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_xbzrle_cache_size) {
>          dest->xbzrle_cache_size = params->xbzrle_cache_size;
>      }
> +    if (params->has_tcp_port) {
> +        dest->tcp_port = params->tcp_port;
> +    }
>  }
>  
>  static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
> @@ -995,6 +1000,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>          s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
>          xbzrle_cache_resize(params->xbzrle_cache_size, errp);
>      }
> +    if (params->has_tcp_port) {
> +        s->parameters.tcp_port = params->tcp_port;
> +    }

Looks like this version still allows users to set tcp_port, no?

-- 
Peter Xu
