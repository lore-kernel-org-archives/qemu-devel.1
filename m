Received: from eggs.gnu.org ([209.51.188.92]:38430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1grTJI-0000aW-0Y
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1grTJG-0008BM-CX
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1grTJG-0008B6-3C
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD43640F00
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 19:56:36 +0000 (UTC)
Date: Wed, 6 Feb 2019 19:56:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190206195626.GE2670@work-vm>
References: <20190206123625.1147-1-quintela@redhat.com>
	<20190206123625.1147-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206123625.1147-3-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 2/3] migration: Create socket-address
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
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

* Juan Quintela (quintela@redhat.com) wrote:
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
> Move SocketAddress_to_str here.  I used to try to generalize the one
> in chardev/char-socket.c, but it is not worth it.
> 
> Free string (eric)
> Handle VSOCK address nicely (not that migration can use them yet).
> ---
>  hmp.c                 | 37 +++++++++++++++++++++++++++++++++++++
>  migration/migration.c | 24 ++++++++++++++++++++++++
>  migration/migration.h |  4 ++++
>  migration/socket.c    | 11 +++++++++++
>  qapi/migration.json   |  6 +++++-
>  qapi/sockets.json     | 13 +++++++++++++
>  6 files changed, 94 insertions(+), 1 deletion(-)
> 
> diff --git a/hmp.c b/hmp.c
> index b2a2b1f84e..63019729ed 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -166,6 +166,31 @@ void hmp_info_mice(Monitor *mon, const QDict *qdict)
>      qapi_free_MouseInfoList(mice_list);
>  }
>  
> +static char *SocketAddress_to_str(SocketAddress *addr)
> +{
> +    switch (addr->type) {
> +    case SOCKET_ADDRESS_TYPE_INET:
> +        return g_strdup_printf("tcp:%s:%s",
> +                               addr->u.inet.host,
> +                               addr->u.inet.port);
> +        break;

(Minor)
You don't need the 'break's with the return.

> +    case SOCKET_ADDRESS_TYPE_UNIX:
> +        return g_strdup_printf("unix:%s",
> +                               addr->u.q_unix.path);
> +        break;


> +    case SOCKET_ADDRESS_TYPE_FD:
> +        return g_strdup_printf("fd:%s", addr->u.fd.str);
> +        break;
> +    case SOCKET_ADDRESS_TYPE_VSOCK:
> +        return g_strdup_printf("tcp:%s:%s",
> +                               addr->u.vsock.cid,
> +                               addr->u.vsock.port);
> +        break;
> +    default:
> +        return g_strdup("unknown adrress type");

Typo in 'ad*r*ress'
Can be fixed in commit.

> +    }
> +}
> +
>  void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>  {
>      MigrationInfo *info;
> @@ -306,6 +331,18 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>          g_free(str);
>          visit_free(v);
>      }
> +    if (info->has_socket_address) {
> +        SocketAddressList *addr;
> +
> +        monitor_printf(mon, "socket address: [\n");
> +
> +        for (addr = info->socket_address; addr; addr = addr->next) {

I guess you could use the visitors to walk that list; but it may be more
painful than it's worth.

> +            char *s = SocketAddress_to_str(addr->value);
> +            monitor_printf(mon, "\t%s\n", s);
> +            g_free(s);
> +        }
> +        monitor_printf(mon, "]\n");
> +    }
>      qapi_free_MigrationInfo(info);
>      qapi_free_MigrationCapabilityStatusList(caps);
>  }
> diff --git a/migration/migration.c b/migration/migration.c
> index 37e06b76dc..ef1d53cde2 100644
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
> @@ -197,6 +199,11 @@ void migration_incoming_state_destroy(void)
>      }
>  
>      qemu_event_reset(&mis->main_thread_load_event);
> +
> +    if (mis->socket_address) {
> +        qapi_free_SocketAddressList(mis->socket_address);
> +        mis->socket_address = NULL;
> +    }
>  }
>  
>  static void migrate_generate_event(int new_state)
> @@ -312,6 +319,17 @@ void migration_incoming_enable_colo(void)
>      migration_colo_enabled = true;
>  }
>  
> +void migrate_add_address(SocketAddress *address)
> +{
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +    SocketAddressList *addrs;
> +
> +    addrs = g_new0(SocketAddressList, 1);
> +    addrs->next = mis->socket_address;
> +    mis->socket_address = addrs;
> +    addrs->value = QAPI_CLONE(SocketAddress, address);
> +}
> +
>  void qemu_start_incoming_migration(const char *uri, Error **errp)
>  {
>      const char *p;
> @@ -966,6 +984,12 @@ static void fill_destination_migration_info(MigrationInfo *info)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
>  
> +    if (mis->socket_address) {
> +        info->has_socket_address = true;
> +        info->socket_address =
> +            QAPI_CLONE(SocketAddressList, mis->socket_address);
> +    }
> +
>      switch (mis->state) {
>      case MIGRATION_STATUS_NONE:
>          return;
> diff --git a/migration/migration.h b/migration/migration.h
> index dcd05d9f87..bd41b57af9 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -80,6 +80,9 @@ struct MigrationIncomingState {
>      bool postcopy_recover_triggered;
>      QemuSemaphore postcopy_pause_sem_dst;
>      QemuSemaphore postcopy_pause_sem_fault;
> +
> +    /* List of listening socket addresses  */
> +    SocketAddressList *socket_address;

It's slightly confusing to have a list of addresses called
'socket_address'.

>  };
>  
>  MigrationIncomingState *migration_incoming_get_current(void);
> @@ -300,6 +303,7 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
>  
>  void dirty_bitmap_mig_before_vm_start(void);
>  void init_dirty_bitmap_incoming_migration(void);
> +void migrate_add_address(SocketAddress *address);
>  
>  #define qemu_ram_foreach_block \
>    #warning "Use qemu_ram_foreach_block_migratable in migration code"
> diff --git a/migration/socket.c b/migration/socket.c
> index f4c8174400..239527fb1f 100644
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
> @@ -177,6 +178,7 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
>                                              Error **errp)
>  {
>      QIONetListener *listener = qio_net_listener_new();
> +    size_t i;
>  
>      qio_net_listener_set_name(listener, "migration-socket-listener");
>  
> @@ -189,6 +191,15 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
>                                            socket_accept_incoming_migration,
>                                            NULL, NULL,
>                                            g_main_context_get_thread_default());
> +
> +    for (i = 0; i < listener->nsioc; i++)  {
> +        SocketAddress *address =
> +            qio_channel_socket_get_local_address(listener->sioc[i], errp);
> +        if (!address) {
> +            return;
> +        }
> +        migrate_add_address(address);
> +    }
>  }
>  
>  void tcp_start_incoming_migration(const char *host_port, Error **errp)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7a795ecc16..b62947791f 100644
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
> @@ -199,6 +200,8 @@
>  # @compression: migration compression statistics, only returned if compression
>  #           feature is on and status is 'active' or 'completed' (Since 3.1)
>  #
> +# @socket-address: Only used for tcp, to know what the real port is (Since 4.0)
> +#
>  # Since: 0.14.0
>  ##
>  { 'struct': 'MigrationInfo',
> @@ -213,7 +216,8 @@
>             '*error-desc': 'str',
>             '*postcopy-blocktime' : 'uint32',
>             '*postcopy-vcpu-blocktime': ['uint32'],
> -           '*compression': 'CompressionStats'} }
> +           '*compression': 'CompressionStats',
> +           '*socket-address': ['SocketAddress'] } }
>  
>  ##
>  # @query-migrate:
> diff --git a/qapi/sockets.json b/qapi/sockets.json
> index fc81d8d5e8..d7f77984af 100644
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
> +#
> +# @dummy-list: A dummy list
> +#
> +# Since: 3.1
> +##
> +{ 'struct': 'DummyStruct',
> +  'data': { 'dummy-list': ['SocketAddress'] } }
> -- 
> 2.20.1

All the above are minor, so:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
