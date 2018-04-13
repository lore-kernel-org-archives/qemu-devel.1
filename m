Received: from eggs.gnu.org ([2001:4830:134:3::10]:47668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f6xOb-0001DZ-5Z
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f6xOW-0007PA-GN
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:01:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f6xOW-0007Ow-B7
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:01:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F76A4075A70
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 12:01:27 +0000 (UTC)
Date: Fri, 13 Apr 2018 13:01:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180413120120.GE16263@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180404112731.5922-1-quintela@redhat.com>
	<20180404112731.5922-5-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180404112731.5922-5-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 4/8] migration: Create socket-address
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
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Wed, Apr 04, 2018 at 01:27:27PM +0200, Juan Quintela wrote:
> It will be used to store the uri parameters. We want this only for
> tcp, so we don't set it for other uris.  We need it to know what port
> is migration running.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 
> This used to be uri parameter, but it has so many troubles to
> reproduce that it don't just make sense.
> 
> This used to be a port parameter.  I was asked to move to
> SocketAddress, done.
> I also merged the setting of the migration tcp port in this one
> because now I need to free the address, and this makes it easier.
> This used to be x-socket-address with a single direction, now it is a
> list of addresses.
> ---
>  hmp.c                 | 14 ++++++++++++++
>  migration/migration.c | 25 +++++++++++++++++++++++++
>  migration/migration.h |  1 +
>  migration/socket.c    | 11 +++++++++++
>  qapi/migration.json   | 13 +++++++++++--
>  qapi/sockets.json     | 13 +++++++++++++
>  6 files changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index a25c7bd9a8..caf94345c9 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -355,6 +355,20 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %" PRIu64 "\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
>              params->xbzrle_cache_size);
> +        if (params->has_socket_address) {
> +            SocketAddressList *addr;
> +
> +            monitor_printf(mon, "%s: [\n",
> +                MigrationParameter_str(MIGRATION_PARAMETER_SOCKET_ADDRESS));
> +
> +            for (addr = params->socket_address; addr; addr = addr->next) {
> +                char *s = SocketAddress_to_str("", addr->value,
> +                                               false, false);
> +                monitor_printf(mon, "\t%s\n", s);
> +            }
> +
> +            monitor_printf(mon, "]\n");
> +        }
>      }
>  
>      qapi_free_MigrationParameters(params);
> diff --git a/migration/migration.c b/migration/migration.c
> index 58bd382730..71fa4c8176 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -31,6 +31,8 @@
>  #include "migration/vmstate.h"
>  #include "block/block.h"
>  #include "qapi/error.h"
> +#include "qapi/clone-visitor.h"
> +#include "qapi/qapi-visit-sockets.h"
>  #include "qapi/qapi-commands-migration.h"
>  #include "qapi/qapi-events-migration.h"
>  #include "qapi/qmp/qerror.h"
> @@ -277,6 +279,21 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
>      return migrate_send_rp_message(mis, msg_type, msglen, bufc);
>  }
>  
> +void migrate_set_address(SocketAddress *address)

s/set/add/ in the method name since you're expecting this to be called
multiple times, augmenting the value, not replacing it.

> +{
> +    MigrationState *s = migrate_get_current();
> +    SocketAddressList *addrs;
> +
> +    addrs = g_new0(SocketAddressList, 1);
> +    addrs->next = s->parameters.socket_address;
> +    s->parameters.socket_address = addrs;
> +
> +    if (!s->parameters.has_socket_address) {
> +        s->parameters.has_socket_address = true;
> +    }
> +    addrs->value = QAPI_CLONE(SocketAddress, address);
> +}
> +
>  void qemu_start_incoming_migration(const char *uri, Error **errp)
>  {
>      const char *p;
> @@ -564,6 +581,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->x_multifd_page_count = s->parameters.x_multifd_page_count;
>      params->has_xbzrle_cache_size = true;
>      params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
> +    if (s->parameters.socket_address) {

nitpick, should really check  s->parameters.has_socket_address

> +        params->has_socket_address = true;
> +        params->socket_address =
> +            QAPI_CLONE(SocketAddressList, s->parameters.socket_address);
> +    }
>  
>      return params;
>  }
> @@ -2571,6 +2593,9 @@ static void migration_instance_finalize(Object *obj)
>      qemu_mutex_destroy(&ms->error_mutex);
>      g_free(params->tls_hostname);
>      g_free(params->tls_creds);
> +    if (params->socket_address) {
> +        qapi_free_SocketAddressList(params->socket_address);
> +    }
>      qemu_sem_destroy(&ms->pause_sem);
>      error_free(ms->error);
>  }
> diff --git a/migration/migration.h b/migration/migration.h
> index 8d2f320c48..4774ee305f 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -241,5 +241,6 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
>  
>  void dirty_bitmap_mig_before_vm_start(void);
>  void init_dirty_bitmap_incoming_migration(void);
> +void migrate_set_address(SocketAddress *address);
>  
>  #endif
> diff --git a/migration/socket.c b/migration/socket.c
> index 122d8ccfbe..5195fd57c5 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -15,6 +15,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  
>  #include "qemu-common.h"
>  #include "qemu/error-report.h"
> @@ -152,6 +153,7 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
>                                              Error **errp)
>  {
>      QIONetListener *listener = qio_net_listener_new();
> +    int i;

Nitpick   size_t for array indexes

>  
>      qio_net_listener_set_name(listener, "migration-socket-listener");
>  
> @@ -163,6 +165,15 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
>      qio_net_listener_set_client_func(listener,
>                                       socket_accept_incoming_migration,
>                                       NULL, NULL);
> +
> +    for (i = 0; i < listener->nsioc; i++)  {
> +        SocketAddress *address =
> +            qio_channel_socket_get_local_address(listener->sioc[i], errp);
> +        if (address < 0) {

'address' is a pointer, so comparing to ' < 0' is wrong - I'm surprised
the compiler isn't issuing a warning about this.

> +            return;
> +        }
> +        migrate_set_address(address);
> +    }
>  }
>  
>  void tcp_start_incoming_migration(const char *host_port, Error **errp)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 9d0bf82cf4..c3aafaf8fe 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -6,6 +6,7 @@
>  ##
>  
>  { 'include': 'common.json' }
> +{ 'include': 'sockets.json' }
>  
>  ##
>  # @MigrationStats:
> @@ -494,6 +495,9 @@
>  #                     and a power of 2
>  #                     (Since 2.11)
>  #
> +# @socket-address: Only used for tcp, to know what the real port is
> +#                  (Since 2.13)
> +#
>  # Since: 2.4
>  ##
>  { 'enum': 'MigrationParameter',
> @@ -502,7 +506,7 @@
>             'tls-creds', 'tls-hostname', 'max-bandwidth',
>             'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
>             'x-multifd-channels', 'x-multifd-page-count',
> -           'xbzrle-cache-size' ] }
> +           'xbzrle-cache-size', 'socket-address' ] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -671,6 +675,10 @@
>  #                     needs to be a multiple of the target page size
>  #                     and a power of 2
>  #                     (Since 2.11)
> +#
> +# @socket-address: Only used for tcp, to know what the real port is
> +#                  (Since 2.13)
> +#
>  # Since: 2.4
>  ##
>  { 'struct': 'MigrationParameters',
> @@ -687,7 +695,8 @@
>              '*block-incremental': 'bool' ,
>              '*x-multifd-channels': 'uint8',
>              '*x-multifd-page-count': 'uint32',
> -            '*xbzrle-cache-size': 'size' } }
> +            '*xbzrle-cache-size': 'size',
> +            '*socket-address': ['SocketAddress'] } }
>  
>  ##
>  # @query-migrate-parameters:
> diff --git a/qapi/sockets.json b/qapi/sockets.json
> index fc81d8d5e8..f1ca09a927 100644
> --- a/qapi/sockets.json
> +++ b/qapi/sockets.json
> @@ -152,3 +152,16 @@
>              'unix': 'UnixSocketAddress',
>              'vsock': 'VsockSocketAddress',
>              'fd': 'String' } }
> +
> +##
> +# @DummyStruct:
> +#
> +# Both block-core and migration needs SocketAddressList
> +# I am open to comments about how to share it

What's the actual problem you're addressing with this ?

> +#
> +# @dummy-list: A dummy list
> +#
> +# Since: 2.13
> +##
> +{ 'struct': 'DummyStruct',
> +  'data': { 'dummy-list': ['SocketAddress'] } }
> -- 
> 2.14.3
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
