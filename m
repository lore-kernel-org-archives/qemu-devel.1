Received: from eggs.gnu.org ([209.51.188.92]:50113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gybEN-0003GF-W5
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gybEM-0004di-Hf
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:49:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:2928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gybEK-0004bF-GY
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:49:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBA94C053FCD
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 11:48:58 +0000 (UTC)
Date: Tue, 26 Feb 2019 11:48:52 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190226114852.GE2721@work-vm>
References: <20190220125755.3906-1-quintela@redhat.com>
	<20190220125755.3906-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220125755.3906-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Add multifd-compress
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hmp.c                        | 17 +++++++++++++++++
>  hw/core/qdev-properties.c    | 11 +++++++++++
>  include/hw/qdev-properties.h |  1 +
>  migration/migration.c        | 25 +++++++++++++++++++++++++
>  migration/migration.h        |  1 +
>  qapi/common.json             | 15 +++++++++++++++
>  qapi/migration.json          | 20 ++++++++++++++++----
>  7 files changed, 86 insertions(+), 4 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 34edad6ea3..abbd49ec17 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -422,6 +422,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
>              params->multifd_channels);
> +        monitor_printf(mon, "%s: %s\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESS),
> +            MultifdCompress_str(params->multifd_compress));
>          monitor_printf(mon, "%s: %" PRIu64 "\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
>              params->xbzrle_cache_size);
> @@ -1690,6 +1693,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>      MigrateSetParameters *p = g_new0(MigrateSetParameters, 1);
>      uint64_t valuebw = 0;
>      uint64_t cache_size;
> +    int compress_type;
>      Error *err = NULL;
>      int val, ret;
>  
> @@ -1769,6 +1773,19 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_multifd_channels = true;
>          visit_type_int(v, param, &p->multifd_channels, &err);
>          break;
> +    case MIGRATION_PARAMETER_MULTIFD_COMPRESS:
> +        p->has_multifd_compress = true;
> +        visit_type_enum(v, param, &compress_type,
> +                        &MultifdCompress_lookup, &err);
> +        if (err) {
> +            break;
> +        }
> +        if (compress_type < 0 || compress_type > MULTIFD_COMPRESS__MAX) {

I think that needs to be >= rather than >
(Actually it surprises me visit_type_enum doesn't turn those cases into
errors)

> +            error_setg(&err, "Invalid multifd_compress option %s", valuestr);
> +            break;
> +        }
> +        p->multifd_compress = compress_type;
> +        break;
>      case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
>          p->has_xbzrle_cache_size = true;
>          visit_type_size(v, param, &cache_size, &err);
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 5da1439a8b..7c8e71532f 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -645,6 +645,17 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
>      .set_default_value = set_default_value_enum,
>  };
>  
> +/* --- MultifdCompress --- */
> +
> +const PropertyInfo qdev_prop_multifd_compress = {
> +    .name = "MultifdCompress",
> +    .description = "multifd_compress values",
> +    .enum_table = &MultifdCompress_lookup,
> +    .get = get_enum,
> +    .set = set_enum,
> +    .set_default_value = set_default_value_enum,
> +};
> +
>  /* --- pci address --- */
>  
>  /*
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index b6758c852e..ac452d8f2c 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -23,6 +23,7 @@ extern const PropertyInfo qdev_prop_tpm;
>  extern const PropertyInfo qdev_prop_ptr;
>  extern const PropertyInfo qdev_prop_macaddr;
>  extern const PropertyInfo qdev_prop_on_off_auto;
> +extern const PropertyInfo qdev_prop_multifd_compress;
>  extern const PropertyInfo qdev_prop_losttickpolicy;
>  extern const PropertyInfo qdev_prop_blockdev_on_error;
>  extern const PropertyInfo qdev_prop_bios_chs_trans;
> diff --git a/migration/migration.c b/migration/migration.c
> index f246519ec8..568ec8530f 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -81,6 +81,7 @@
>  /* The delay time (in ms) between two COLO checkpoints */
>  #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
>  #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
> +#define DEFAULT_MIGRATE_MULTIFD_COMPRESS false

Shouldn't that be an enum value?

>  /* Background transfer rate for postcopy, 0 means unlimited, note
>   * that page requests can still exceed this limit.
> @@ -748,6 +749,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->block_incremental = s->parameters.block_incremental;
>      params->has_multifd_channels = true;
>      params->multifd_channels = s->parameters.multifd_channels;
> +    params->has_multifd_compress = true;
> +    params->multifd_compress = s->parameters.multifd_compress;
>      params->has_xbzrle_cache_size = true;
>      params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
>      params->has_max_postcopy_bandwidth = true;
> @@ -1191,6 +1194,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_multifd_channels) {
>          dest->multifd_channels = params->multifd_channels;
>      }
> +    if (params->has_multifd_compress) {
> +        dest->multifd_compress = params->multifd_compress;
> +    }
>      if (params->has_xbzrle_cache_size) {
>          dest->xbzrle_cache_size = params->xbzrle_cache_size;
>      }
> @@ -1269,6 +1275,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      if (params->has_multifd_channels) {
>          s->parameters.multifd_channels = params->multifd_channels;
>      }
> +    if (params->has_multifd_compress) {
> +        s->parameters.multifd_compress = params->multifd_compress;
> +    }
>      if (params->has_xbzrle_cache_size) {
>          s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
>          xbzrle_cache_resize(params->xbzrle_cache_size, errp);
> @@ -2008,6 +2017,15 @@ bool migrate_use_multifd(void)
>      return s->enabled_capabilities[MIGRATION_CAPABILITY_MULTIFD];
>  }
>  
> +bool migrate_use_multifd_zlib(void)
> +{
> +    MigrationState *s;
> +
> +    s = migrate_get_current();
> +
> +    return s->parameters.multifd_compress == MULTIFD_COMPRESS_ZLIB;
> +}
> +
>  bool migrate_pause_before_switchover(void)
>  {
>      MigrationState *s;
> @@ -3220,6 +3238,9 @@ void migration_global_dump(Monitor *mon)
>  #define DEFINE_PROP_MIG_CAP(name, x)             \
>      DEFINE_PROP_BOOL(name, MigrationState, enabled_capabilities[x], false)
>  
> +#define DEFINE_PROP_MULTIFD_COMPRESS(_n, _s, _f, _d) \
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compress, MultifdCompress)
> +
>  static Property migration_properties[] = {
>      DEFINE_PROP_BOOL("store-global-state", MigrationState,
>                       store_global_state, true),
> @@ -3260,6 +3281,9 @@ static Property migration_properties[] = {
>      DEFINE_PROP_UINT8("multifd-channels", MigrationState,
>                        parameters.multifd_channels,
>                        DEFAULT_MIGRATE_MULTIFD_CHANNELS),
> +    DEFINE_PROP_MULTIFD_COMPRESS("multifd-compress", MigrationState,
> +                      parameters.multifd_compress,
> +                      DEFAULT_MIGRATE_MULTIFD_COMPRESS),
>      DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
>                        parameters.xbzrle_cache_size,
>                        DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
> @@ -3337,6 +3361,7 @@ static void migration_instance_init(Object *obj)
>      params->has_x_checkpoint_delay = true;
>      params->has_block_incremental = true;
>      params->has_multifd_channels = true;
> +    params->has_multifd_compress = true;
>      params->has_xbzrle_cache_size = true;
>      params->has_max_postcopy_bandwidth = true;
>      params->has_max_cpu_throttle = true;
> diff --git a/migration/migration.h b/migration/migration.h
> index 7e03643683..646614f71b 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -267,6 +267,7 @@ bool migrate_dirty_bitmaps(void);
>  
>  bool migrate_auto_converge(void);
>  bool migrate_use_multifd(void);
> +bool migrate_use_multifd_zlib(void);
>  bool migrate_pause_before_switchover(void);
>  int migrate_multifd_channels(void);
>  
> diff --git a/qapi/common.json b/qapi/common.json
> index 99d313ef3b..ccdd58d21b 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -193,3 +193,18 @@
>               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>               'x86_64', 'xtensa', 'xtensaeb' ] }
> +
> +##
> +# @MultifdCompress:
> +#
> +# An enumeration of multifd compression.
> +#
> +# @none: no compression.
> +#
> +# @zlib: Compress using zlib.
> +#
> +# Since: 3.1

4.

> +#
> +##
> +{ 'enum': 'MultifdCompress',
> +  'data': [ 'none', 'zlib' ] }
> diff --git a/qapi/migration.json b/qapi/migration.json
> index c202703889..a882fc0823 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -558,6 +558,10 @@
>  #
>  # @max-cpu-throttle: maximum cpu throttle percentage.
>  #                    Defaults to 99. (Since 3.1)
> +#
> +# @multifd-compress: What compression method to use.
> +#                    Defaults to none. (Since 4.0)
> +#

I think that should be 'Which' rather than 'What'.

>  # Since: 2.4
>  ##
>  { 'enum': 'MigrationParameter',
> @@ -568,7 +572,7 @@
>             'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
>             'multifd-channels',
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
> -           'max-cpu-throttle' ] }
> +           'max-cpu-throttle', 'multifd-compress' ] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -644,7 +648,10 @@
>  #                     (Since 3.0)
>  #
>  # @max-cpu-throttle: maximum cpu throttle percentage.
> -#                    The default value is 99. (Since 3.1)
> +#                    The default value is 99. (Since 4.0)

That change is wrong?

> +# @multifd-compress: What compression method to use.
> +#                    Defaults to none. (Since 4.0)
>  #
>  # Since: 2.4
>  ##
> @@ -666,7 +673,8 @@
>              '*multifd-channels': 'int',
>              '*xbzrle-cache-size': 'size',
>              '*max-postcopy-bandwidth': 'size',
> -	    '*max-cpu-throttle': 'int' } }
> +	    '*max-cpu-throttle': 'int',
> +            '*multifd-compress': 'MultifdCompress' } }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -760,6 +768,9 @@
>  #                    Defaults to 99.
>  #                     (Since 3.1)
>  #
> +# @multifd-compress: What compression method to use.
> +#                    Defaults to none. (Since 4.0)
> +#
>  # Since: 2.4
>  ##
>  { 'struct': 'MigrationParameters',
> @@ -778,7 +789,8 @@
>              '*multifd-channels': 'uint8',
>              '*xbzrle-cache-size': 'size',
>  	    '*max-postcopy-bandwidth': 'size',
> -            '*max-cpu-throttle':'uint8'} }
> +            '*max-cpu-throttle': 'uint8',
> +            '*multifd-compress': 'MultifdCompress' } }
>  
>  ##
>  # @query-migrate-parameters:

Dave

> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
