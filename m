Received: from eggs.gnu.org ([209.51.188.92]:38285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwsVt-0006k8-Cl
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:52:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwsVp-0007Hw-3R
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:52:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gwsVn-0007Fw-JK
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:51:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8F553082E50
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 17:51:49 +0000 (UTC)
Date: Thu, 21 Feb 2019 17:51:45 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190221175144.GN2605@work-vm>
References: <20190220115611.3192-1-quintela@redhat.com>
	<20190220115611.3192-5-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220115611.3192-5-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/8] multifd: Drop x-multifd-page-count
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
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Juan Quintela (quintela@redhat.com) wrote:
> Libvirt don't want to expose (and explain it).  From now on we measure
> the number of packages in bytes instead of pages, so it is the same
> independently of architecture.  We choose the page size of x86.
> Notice that in the following patch we make this variable.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Fortunately it's so easy to remove and add parameters....


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hmp.c                 |  7 -------
>  migration/migration.c | 30 ------------------------------
>  migration/migration.h |  1 -
>  migration/ram.c       | 15 ++++++++++-----
>  qapi/migration.json   | 13 +------------
>  5 files changed, 11 insertions(+), 55 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 8e283153b5..8bd5e48005 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -422,9 +422,6 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_X_MULTIFD_CHANNELS),
>              params->x_multifd_channels);
> -        monitor_printf(mon, "%s: %u\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_X_MULTIFD_PAGE_COUNT),
> -            params->x_multifd_page_count);
>          monitor_printf(mon, "%s: %" PRIu64 "\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
>              params->xbzrle_cache_size);
> @@ -1772,10 +1769,6 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_x_multifd_channels = true;
>          visit_type_int(v, param, &p->x_multifd_channels, &err);
>          break;
> -    case MIGRATION_PARAMETER_X_MULTIFD_PAGE_COUNT:
> -        p->has_x_multifd_page_count = true;
> -        visit_type_int(v, param, &p->x_multifd_page_count, &err);
> -        break;
>      case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
>          p->has_xbzrle_cache_size = true;
>          visit_type_size(v, param, &cache_size, &err);
> diff --git a/migration/migration.c b/migration/migration.c
> index 5ecf0978ac..f1b34bfe29 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -81,7 +81,6 @@
>  /* The delay time (in ms) between two COLO checkpoints */
>  #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
>  #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
> -#define DEFAULT_MIGRATE_MULTIFD_PAGE_COUNT 16
>  
>  /* Background transfer rate for postcopy, 0 means unlimited, note
>   * that page requests can still exceed this limit.
> @@ -749,8 +748,6 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->block_incremental = s->parameters.block_incremental;
>      params->has_x_multifd_channels = true;
>      params->x_multifd_channels = s->parameters.x_multifd_channels;
> -    params->has_x_multifd_page_count = true;
> -    params->x_multifd_page_count = s->parameters.x_multifd_page_count;
>      params->has_xbzrle_cache_size = true;
>      params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
>      params->has_max_postcopy_bandwidth = true;
> @@ -1112,14 +1109,6 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
>                     "is invalid, it should be in the range of 1 to 255");
>          return false;
>      }
> -    if (params->has_x_multifd_page_count &&
> -        (params->x_multifd_page_count < 1 ||
> -         params->x_multifd_page_count > 10000)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "multifd_page_count",
> -                   "is invalid, it should be in the range of 1 to 10000");
> -        return false;
> -    }
>  
>      if (params->has_xbzrle_cache_size &&
>          (params->xbzrle_cache_size < qemu_target_page_size() ||
> @@ -1202,9 +1191,6 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_x_multifd_channels) {
>          dest->x_multifd_channels = params->x_multifd_channels;
>      }
> -    if (params->has_x_multifd_page_count) {
> -        dest->x_multifd_page_count = params->x_multifd_page_count;
> -    }
>      if (params->has_xbzrle_cache_size) {
>          dest->xbzrle_cache_size = params->xbzrle_cache_size;
>      }
> @@ -1283,9 +1269,6 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      if (params->has_x_multifd_channels) {
>          s->parameters.x_multifd_channels = params->x_multifd_channels;
>      }
> -    if (params->has_x_multifd_page_count) {
> -        s->parameters.x_multifd_page_count = params->x_multifd_page_count;
> -    }
>      if (params->has_xbzrle_cache_size) {
>          s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
>          xbzrle_cache_resize(params->xbzrle_cache_size, errp);
> @@ -2044,15 +2027,6 @@ int migrate_multifd_channels(void)
>      return s->parameters.x_multifd_channels;
>  }
>  
> -int migrate_multifd_page_count(void)
> -{
> -    MigrationState *s;
> -
> -    s = migrate_get_current();
> -
> -    return s->parameters.x_multifd_page_count;
> -}
> -
>  int migrate_use_xbzrle(void)
>  {
>      MigrationState *s;
> @@ -3286,9 +3260,6 @@ static Property migration_properties[] = {
>      DEFINE_PROP_UINT8("x-multifd-channels", MigrationState,
>                        parameters.x_multifd_channels,
>                        DEFAULT_MIGRATE_MULTIFD_CHANNELS),
> -    DEFINE_PROP_UINT32("x-multifd-page-count", MigrationState,
> -                      parameters.x_multifd_page_count,
> -                      DEFAULT_MIGRATE_MULTIFD_PAGE_COUNT),
>      DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
>                        parameters.xbzrle_cache_size,
>                        DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
> @@ -3366,7 +3337,6 @@ static void migration_instance_init(Object *obj)
>      params->has_x_checkpoint_delay = true;
>      params->has_block_incremental = true;
>      params->has_x_multifd_channels = true;
> -    params->has_x_multifd_page_count = true;
>      params->has_xbzrle_cache_size = true;
>      params->has_max_postcopy_bandwidth = true;
>      params->has_max_cpu_throttle = true;
> diff --git a/migration/migration.h b/migration/migration.h
> index 837709d8a1..7e03643683 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -269,7 +269,6 @@ bool migrate_auto_converge(void);
>  bool migrate_use_multifd(void);
>  bool migrate_pause_before_switchover(void);
>  int migrate_multifd_channels(void);
> -int migrate_multifd_page_count(void);
>  
>  int migrate_use_xbzrle(void);
>  int64_t migrate_xbzrle_cache_size(void);
> diff --git a/migration/ram.c b/migration/ram.c
> index 26ed26fc2d..e22d02760b 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -520,6 +520,9 @@ exit:
>  
>  #define MULTIFD_FLAG_SYNC (1 << 0)
>  
> +/* This value needs to be a multiple of qemu_target_page_size() */
> +#define MULTIFD_PACKET_SIZE (64 * 1024)
> +
>  typedef struct {
>      uint32_t magic;
>      uint32_t version;
> @@ -720,12 +723,13 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
>  static void multifd_send_fill_packet(MultiFDSendParams *p)
>  {
>      MultiFDPacket_t *packet = p->packet;
> +    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
>      int i;
>  
>      packet->magic = cpu_to_be32(MULTIFD_MAGIC);
>      packet->version = cpu_to_be32(MULTIFD_VERSION);
>      packet->flags = cpu_to_be32(p->flags);
> -    packet->pages_alloc = cpu_to_be32(migrate_multifd_page_count());
> +    packet->pages_alloc = cpu_to_be32(page_count);
>      packet->pages_used = cpu_to_be32(p->pages->used);
>      packet->next_packet_size = cpu_to_be32(p->next_packet_size);
>      packet->packet_num = cpu_to_be64(p->packet_num);
> @@ -742,6 +746,7 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
>  static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>  {
>      MultiFDPacket_t *packet = p->packet;
> +    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
>      RAMBlock *block;
>      int i;
>  
> @@ -764,10 +769,10 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>      p->flags = be32_to_cpu(packet->flags);
>  
>      packet->pages_alloc = be32_to_cpu(packet->pages_alloc);
> -    if (packet->pages_alloc > migrate_multifd_page_count()) {
> +    if (packet->pages_alloc > page_count) {
>          error_setg(errp, "multifd: received packet "
>                     "with size %d and expected maximum size %d",
> -                   packet->pages_alloc, migrate_multifd_page_count()) ;
> +                   packet->pages_alloc, page_count) ;
>          return -1;
>      }
>  
> @@ -1099,7 +1104,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>  int multifd_save_setup(void)
>  {
>      int thread_count;
> -    uint32_t page_count = migrate_multifd_page_count();
> +    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
>      uint8_t i;
>  
>      if (!migrate_use_multifd()) {
> @@ -1299,7 +1304,7 @@ static void *multifd_recv_thread(void *opaque)
>  int multifd_load_setup(void)
>  {
>      int thread_count;
> -    uint32_t page_count = migrate_multifd_page_count();
> +    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
>      uint8_t i;
>  
>      if (!migrate_use_multifd()) {
> diff --git a/qapi/migration.json b/qapi/migration.json
> index b62947791f..8c5db60406 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -547,9 +547,6 @@
>  #                     number of sockets used for migration.  The
>  #                     default value is 2 (since 2.11)
>  #
> -# @x-multifd-page-count: Number of pages sent together to a thread.
> -#                        The default value is 16 (since 2.11)
> -#
>  # @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
>  #                     needs to be a multiple of the target page size
>  #                     and a power of 2
> @@ -569,7 +566,7 @@
>             'cpu-throttle-initial', 'cpu-throttle-increment',
>             'tls-creds', 'tls-hostname', 'max-bandwidth',
>             'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
> -           'x-multifd-channels', 'x-multifd-page-count',
> +           'x-multifd-channels',
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
>             'max-cpu-throttle' ] }
>  
> @@ -637,9 +634,6 @@
>  #                     number of sockets used for migration.  The
>  #                     default value is 2 (since 2.11)
>  #
> -# @x-multifd-page-count: Number of pages sent together to a thread.
> -#                        The default value is 16 (since 2.11)
> -#
>  # @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
>  #                     needs to be a multiple of the target page size
>  #                     and a power of 2
> @@ -670,7 +664,6 @@
>              '*x-checkpoint-delay': 'int',
>              '*block-incremental': 'bool',
>              '*x-multifd-channels': 'int',
> -            '*x-multifd-page-count': 'int',
>              '*xbzrle-cache-size': 'size',
>              '*max-postcopy-bandwidth': 'size',
>  	    '*max-cpu-throttle': 'int' } }
> @@ -754,9 +747,6 @@
>  #                     number of sockets used for migration.
>  #                     The default value is 2 (since 2.11)
>  #
> -# @x-multifd-page-count: Number of pages sent together to a thread.
> -#                        The default value is 16 (since 2.11)
> -#
>  # @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
>  #                     needs to be a multiple of the target page size
>  #                     and a power of 2
> @@ -786,7 +776,6 @@
>              '*x-checkpoint-delay': 'uint32',
>              '*block-incremental': 'bool' ,
>              '*x-multifd-channels': 'uint8',
> -            '*x-multifd-page-count': 'uint32',
>              '*xbzrle-cache-size': 'size',
>  	    '*max-postcopy-bandwidth': 'size',
>              '*max-cpu-throttle':'uint8'} }
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
