Received: from eggs.gnu.org ([2001:4830:134:3::10]:52940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBdIo-0007cU-Ij
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBdIl-00057N-Ux
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:34:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46192 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fBdIl-000579-P0
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:34:55 -0400
Date: Thu, 26 Apr 2018 10:34:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180426093443.GA2631@work-vm>
References: <20180426091519.26934-1-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426091519.26934-1-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH] migration: introduce decompress-error-check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

* guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> QEMU 2.13 enables strict check for compression & decompression to
> make the migration more robuster, that depends on the source to fix
> the internal design which triggers the unexpected error conditions

Hmm that's painful!

> To make it work for migrating old version QEMU to 2.13 QEMU, we
> introduce this parameter to disable the error check on the
> destination
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  hmp.c                 |  8 ++++++++
>  migration/migration.c | 19 +++++++++++++++++++
>  migration/migration.h |  1 +
>  migration/ram.c       |  2 +-
>  qapi/migration.json   | 43 +++++++++++++++++++++++++++++++++++++++----
>  5 files changed, 68 insertions(+), 5 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 898e25f3e1..f0b934368b 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -329,6 +329,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_DECOMPRESS_THREADS),
>              params->decompress_threads);
> +        assert(params->has_decompress_error_check);
> +        monitor_printf(mon, "%s: %s\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_DECOMPRESS_ERROR_CHECK),
> +            params->decompress_error_check ? "on" : "off");

Since it's a bool, this should be a migration-capability rather than a
parameter I think.

Also, we need to make sure it defaults to off for compatibility.

Other than that, I think it's OK.

Dave

>          assert(params->has_cpu_throttle_initial);
>          monitor_printf(mon, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL),
> @@ -1593,6 +1597,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_decompress_threads = true;
>          visit_type_int(v, param, &p->decompress_threads, &err);
>          break;
> +    case MIGRATION_PARAMETER_DECOMPRESS_ERROR_CHECK:
> +        p->has_decompress_error_check = true;
> +        visit_type_bool(v, param, &p->decompress_error_check, &err);
> +        break;
>      case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
>          p->has_cpu_throttle_initial = true;
>          visit_type_int(v, param, &p->cpu_throttle_initial, &err);
> diff --git a/migration/migration.c b/migration/migration.c
> index 0bdb28e144..1eef084763 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -534,6 +534,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->compress_threads = s->parameters.compress_threads;
>      params->has_decompress_threads = true;
>      params->decompress_threads = s->parameters.decompress_threads;
> +    params->has_decompress_error_check = true;
> +    params->decompress_error_check = s->parameters.decompress_error_check;
>      params->has_cpu_throttle_initial = true;
>      params->cpu_throttle_initial = s->parameters.cpu_throttle_initial;
>      params->has_cpu_throttle_increment = true;
> @@ -917,6 +919,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>          dest->decompress_threads = params->decompress_threads;
>      }
>  
> +    if (params->has_decompress_error_check) {
> +        dest->decompress_error_check = params->decompress_error_check;
> +    }
> +
>      if (params->has_cpu_throttle_initial) {
>          dest->cpu_throttle_initial = params->cpu_throttle_initial;
>      }
> @@ -979,6 +985,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>          s->parameters.decompress_threads = params->decompress_threads;
>      }
>  
> +    if (params->has_decompress_error_check) {
> +        s->parameters.decompress_error_check = params->decompress_error_check;
> +    }
> +
>      if (params->has_cpu_throttle_initial) {
>          s->parameters.cpu_throttle_initial = params->cpu_throttle_initial;
>      }
> @@ -1620,6 +1630,15 @@ int migrate_decompress_threads(void)
>      return s->parameters.decompress_threads;
>  }
>  
> +bool migrate_decompress_error_check(void)
> +{
> +    MigrationState *s;
> +
> +    s = migrate_get_current();
> +
> +    return s->parameters.decompress_error_check;
> +}
> +
>  bool migrate_dirty_bitmaps(void)
>  {
>      MigrationState *s;
> diff --git a/migration/migration.h b/migration/migration.h
> index 7c69598c54..5efbbaf9d8 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -241,6 +241,7 @@ bool migrate_use_compression(void);
>  int migrate_compress_level(void);
>  int migrate_compress_threads(void);
>  int migrate_decompress_threads(void);
> +bool migrate_decompress_error_check(void);
>  bool migrate_use_events(void);
>  bool migrate_postcopy_blocktime(void);
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index 912810c18e..01cc815410 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2581,7 +2581,7 @@ static void *do_data_decompress(void *opaque)
>  
>              ret = qemu_uncompress_data(&param->stream, des, pagesize,
>                                         param->compbuf, len);
> -            if (ret < 0) {
> +            if (ret < 0 && migrate_decompress_error_check()) {
>                  error_report("decompress data failed");
>                  qemu_file_set_error(decomp_file, ret);
>              }
> diff --git a/qapi/migration.json b/qapi/migration.json
> index f3974c6807..68222358e1 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -455,6 +455,17 @@
>  #          compression, so set the decompress-threads to the number about 1/4
>  #          of compress-threads is adequate.
>  #
> +# @decompress-error-check: check decompression errors. When false, the errors
> +#                          triggered by memory decompression are ignored.
> +#                          When true, migration is aborted if the errors are
> +#                          detected. For the old QEMU versions (< 2.13) the
> +#                          internal design will cause decompression to fail
> +#                          so the destination should completely ignore the
> +#                          error conditions, i.e, make it be false if these
> +#                          QEMUs are going to be migrated. Since 2.13, this
> +#                          design is fixed, make it be true to avoid corrupting
> +#                          the VM silently (Since 2.13)
> +#
>  # @cpu-throttle-initial: Initial percentage of time guest cpus are throttled
>  #                        when migration auto-converge is activated. The
>  #                        default value is 20. (Since 2.7)
> @@ -511,10 +522,10 @@
>  ##
>  { 'enum': 'MigrationParameter',
>    'data': ['compress-level', 'compress-threads', 'decompress-threads',
> -           'cpu-throttle-initial', 'cpu-throttle-increment',
> -           'tls-creds', 'tls-hostname', 'max-bandwidth',
> -           'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
> -           'x-multifd-channels', 'x-multifd-page-count',
> +           'decompress-error-check', 'cpu-throttle-initial',
> +           'cpu-throttle-increment', 'tls-creds', 'tls-hostname',
> +           'max-bandwidth', 'downtime-limit', 'x-checkpoint-delay',
> +           'block-incremental', 'x-multifd-channels', 'x-multifd-page-count',
>             'xbzrle-cache-size' ] }
>  
>  ##
> @@ -526,6 +537,17 @@
>  #
>  # @decompress-threads: decompression thread count
>  #
> +# @decompress-error-check: check decompression errors. When false, the errors
> +#                          triggered by memory decompression are ignored.
> +#                          When true, migration is aborted if the errors are
> +#                          detected. For the old QEMU versions (< 2.13) the
> +#                          internal design will cause decompression to fail
> +#                          so the destination should completely ignore the
> +#                          error conditions, i.e, make it be false if these
> +#                          QEMUs are going to be migrated. Since 2.13, this
> +#                          design is fixed, make it be true to avoid corrupting
> +#                          the VM silently (Since 2.13)
> +#
>  # @cpu-throttle-initial: Initial percentage of time guest cpus are
>  #                        throttled when migration auto-converge is activated.
>  #                        The default value is 20. (Since 2.7)
> @@ -591,6 +613,7 @@
>    'data': { '*compress-level': 'int',
>              '*compress-threads': 'int',
>              '*decompress-threads': 'int',
> +            '*decompress-error-check': 'bool',
>              '*cpu-throttle-initial': 'int',
>              '*cpu-throttle-increment': 'int',
>              '*tls-creds': 'StrOrNull',
> @@ -630,6 +653,17 @@
>  #
>  # @decompress-threads: decompression thread count
>  #
> +# @decompress-error-check: check decompression errors. When false, the errors
> +#                          triggered by memory decompression are ignored.
> +#                          When true, migration is aborted if the errors are
> +#                          detected. For the old QEMU versions (< 2.13) the
> +#                          internal design will cause decompression to fail
> +#                          so the destination should completely ignore the
> +#                          error conditions, i.e, make it be false if these
> +#                          QEMUs are going to be migrated. Since 2.13, this
> +#                          design is fixed, make it be true to avoid corrupting
> +#                          the VM silently (Since 2.13)
> +#
>  # @cpu-throttle-initial: Initial percentage of time guest cpus are
>  #                        throttled when migration auto-converge is activated.
>  #                        (Since 2.7)
> @@ -690,6 +724,7 @@
>    'data': { '*compress-level': 'uint8',
>              '*compress-threads': 'uint8',
>              '*decompress-threads': 'uint8',
> +            '*decompress-error-check': 'bool',
>              '*cpu-throttle-initial': 'uint8',
>              '*cpu-throttle-increment': 'uint8',
>              '*tls-creds': 'str',
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
