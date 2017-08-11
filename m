Received: from eggs.gnu.org ([2001:4830:134:3::10]:42948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dgBMI-0005D1-Ks
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dgBMF-0000JP-FL
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:56:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dgBMF-0000I4-5K
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:56:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0E302C9726
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 14:56:13 +0000 (UTC)
Date: Fri, 11 Aug 2017 15:56:01 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170811145601.GP2554@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-8-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808162629.32493-8-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 07/19] migration: Create
 x-multifd-threads parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Tue, Aug 08, 2017 at 06:26:17PM +0200, Juan Quintela wrote:
> Indicates the number of threads that we would create.  By default we
> create 2 threads.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> --
> 
> Catch inconsistent defaults (eric).
> Improve comment stating that number of threads is the same than number
> of sockets
> Use new DEFIN_PROP_*
> ---
>  hmp.c                 |  7 +++++++
>  migration/migration.c | 26 ++++++++++++++++++++++++++
>  migration/migration.h |  1 +
>  qapi-schema.json      | 25 ++++++++++++++++++++++---
>  4 files changed, 56 insertions(+), 3 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index fd80dce..7899813 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -337,6 +337,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %s\n",
>              MigrationParameter_lookup[MIGRATION_PARAMETER_BLOCK_INCREMENTAL],
>                         params->block_incremental ? "on" : "off");
> +        monitor_printf(mon, "%s: %" PRId64 "\n",
> +            MigrationParameter_lookup[MIGRATION_PARAMETER_X_MULTIFD_THREADS],
> +            params->x_multifd_threads);
>      }
>  
>      qapi_free_MigrationParameters(params);
> @@ -1622,6 +1625,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>                  p->has_block_incremental = true;
>                  visit_type_bool(v, param, &p->block_incremental, &err);
>                  break;
> +            case MIGRATION_PARAMETER_X_MULTIFD_THREADS:
> +                p->has_x_multifd_threads = true;
> +                visit_type_int(v, param, &p->x_multifd_threads, &err);
> +                break;
>              }
>  
>              if (err) {
> diff --git a/migration/migration.c b/migration/migration.c
> index 4e6ad87..6ed9600 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -78,6 +78,7 @@
>   * Note: Please change this default value to 10000 when we support hybrid mode.
>   */
>  #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY 200
> +#define DEFAULT_MIGRATE_MULTIFD_THREADS 2
>  
>  static NotifierList migration_state_notifiers =
>      NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
> @@ -483,6 +484,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
>      params->has_block_incremental = true;
>      params->block_incremental = s->parameters.block_incremental;
> +    params->has_x_multifd_threads = true;
> +    params->x_multifd_threads = s->parameters.x_multifd_threads;
>  
>      return params;
>  }
> @@ -764,6 +767,13 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
>                      "is invalid, it should be positive");
>          return false;
>      }
> +    if (params->has_x_multifd_threads &&
> +        (params->x_multifd_threads < 1 || params->x_multifd_threads > 255)) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +                   "multifd_threads",
> +                   "is invalid, it should be in the range of 1 to 255");
> +        return false;
> +    }
>  
>      return true;
>  }
> @@ -882,6 +892,9 @@ static void migrate_params_apply(MigrateSetParameters *params)
>      if (params->has_block_incremental) {
>          s->parameters.block_incremental = params->block_incremental;
>      }
> +    if (params->has_x_multifd_threads) {
> +        s->parameters.x_multifd_threads = params->x_multifd_threads;
> +    }
>  }
>  
>  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
> @@ -1459,6 +1472,15 @@ bool migrate_use_multifd(void)
>      return s->enabled_capabilities[MIGRATION_CAPABILITY_X_MULTIFD];
>  }
>  
> +int migrate_multifd_threads(void)
> +{
> +    MigrationState *s;
> +
> +    s = migrate_get_current();
> +
> +    return s->parameters.x_multifd_threads;
> +}
> +
>  int migrate_use_xbzrle(void)
>  {
>      MigrationState *s;
> @@ -2224,6 +2246,9 @@ static Property migration_properties[] = {
>      DEFINE_PROP_INT64("x-checkpoint-delay", MigrationState,
>                        parameters.x_checkpoint_delay,
>                        DEFAULT_MIGRATE_X_CHECKPOINT_DELAY),
> +    DEFINE_PROP_INT64("x-multifd-threads", MigrationState,
> +                      parameters.x_multifd_threads,
> +                      DEFAULT_MIGRATE_MULTIFD_THREADS),
>  
>      /* Migration capabilities */
>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> @@ -2281,6 +2306,7 @@ static void migration_instance_init(Object *obj)
>      params->has_downtime_limit = true;
>      params->has_x_checkpoint_delay = true;
>      params->has_block_incremental = true;
> +    params->has_x_multifd_threads = true;
>  }
>  
>  /*
> diff --git a/migration/migration.h b/migration/migration.h
> index b7437f1..8e4803d 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -175,6 +175,7 @@ bool migrate_zero_blocks(void);
>  
>  bool migrate_auto_converge(void);
>  bool migrate_use_multifd(void);
> +int migrate_multifd_threads(void);
>  
>  int migrate_use_xbzrle(void);
>  int64_t migrate_xbzrle_cache_size(void);
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 521e15c..3fe1a64 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -918,6 +918,7 @@
>  #
>  # @return-path: If enabled, migration will use the return path even
>  #               for precopy. (since 2.10)
> +#
>  # @x-multifd: Use more than one fd for migration (since 2.11)
>  #
>  # Since: 1.2
> @@ -1043,13 +1044,19 @@
>  # 	migrated and the destination must already have access to the
>  # 	same backing chain as was used on the source.  (since 2.10)
>  #
> +# @x-multifd-threads: Number of threads used to migrate data in
> +#                     parallel. This is the same number that the
> +#                     number of sockets used for migration.
> +#                     The default value is 2 (since 2.11)

The feature is called "multifd" but we're configuring number of threads,
with the implicit suggestion that number of threads == number of sockets.

I wonder if its better to call this  "x-multifd-connections" so that it
is explicit that we're determining the number of socket connections.

This leaves room for adapting code to use a different number of threads,
but same number of sockets. eg with post-copy, there's potential to have
2 threads for each socket (1 reading, 1 writing).

> +#
>  # Since: 2.4
>  ##
>  { 'enum': 'MigrationParameter',
>    'data': ['compress-level', 'compress-threads', 'decompress-threads',
>             'cpu-throttle-initial', 'cpu-throttle-increment',
>             'tls-creds', 'tls-hostname', 'max-bandwidth',
> -           'downtime-limit', 'x-checkpoint-delay', 'block-incremental' ] }
> +           'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
> +           'x-multifd-threads'] }


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
