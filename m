Received: from eggs.gnu.org ([2001:4830:134:3::10]:48007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXpT9-0008L6-QG
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXpT5-00041f-Rq
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:56:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXpT5-00041M-GJ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:56:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63DCCBCFE0
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 13:56:46 +0000 (UTC)
Date: Wed, 19 Jul 2017 14:56:39 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170719135639.GI30084@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-10-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170717134238.1966-10-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 09/17] migration: Start of multiple fd
 work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

On Mon, Jul 17, 2017 at 03:42:30PM +0200, Juan Quintela wrote:
> We create new channels for each new thread created. We only send through
> them a character to be sure that we are creating the channels in the
> right order.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> Split SocketArgs into incoming and outgoing args
> 
> Use UUID's on the initial message, so we are sure we are connecting to
> the right channel.
> 
> Remove init semaphore.  Now that we use uuids on the init message, we
> know that this is our channel.
> 
> Fix recv socket destwroy, we were destroying send channels.
> This was very interesting, because we were using an unreferred object
> without problems.
> 
> Move to struct of pointers
> init channel sooner.
> split recv thread creation.
> listen on main thread
> ---
>  migration/migration.c |   7 ++-
>  migration/ram.c       | 118 ++++++++++++++++++++++++++++++++++++++++++--------
>  migration/ram.h       |   2 +
>  migration/socket.c    |  38 ++++++++++++++--
>  migration/socket.h    |  10 +++++
>  5 files changed, 152 insertions(+), 23 deletions(-)
> 


> diff --git a/migration/ram.c b/migration/ram.c
> index 8e87533..b80f511 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -408,11 +413,38 @@ void multifd_save_cleanup(void)
>      multifd_send_state = NULL;
>  }
>  
> +/* Default uuid for multifd when qemu is not started with uuid */
> +static char multifd_uuid[] = "5c49fd7e-af88-4a07-b6e8-091fd696ad40";
> +/* strlen(multifd) + '-' + <channel id> + '-' +  UUID_FMT + '\0' */
> +#define MULTIFD_UUID_MSG (7 + 1 + 3 + 1 + UUID_FMT_LEN + 1)

> +
>  static void *multifd_send_thread(void *opaque)
>  {
>      MultiFDSendParams *p = opaque;
> +    char string[MULTIFD_UUID_MSG];
> +    char *string_uuid;
> +    int res;
> +    bool exit = false;
>  
> -    while (true) {
> +    if (qemu_uuid_set) {
> +        string_uuid = qemu_uuid_unparse_strdup(&qemu_uuid);
> +    } else {
> +        string_uuid = g_strdup(multifd_uuid);
> +    }
> +    res = snprintf(string, MULTIFD_UUID_MSG, "%s multifd %03d",
> +                   string_uuid, p->id);

Just use  g_strdup_printf() here and avoid the error prone
logically for calculating the "correct"  buffer size.

> +    g_free(string_uuid);
> +
> +    /* -1 due to the wonders of '\0' accounting */
> +    if (res != (MULTIFD_UUID_MSG - 1)) {
> +        error_report("Multifd UUID message '%s' is not of right length",
> +            string);
> +        exit = true;
> +    } else {
> +        qio_channel_write(p->c, string, MULTIFD_UUID_MSG, &error_abort);

Ewwww, you can't have QEMU abort when there's an I/O error on the
a file descriptor. It needs to fail the migration cleanly.

> +    }
> +
> +    while (!exit) {
>          qemu_mutex_lock(&p->mutex);
>          if (p->quit) {
>              qemu_mutex_unlock(&p->mutex);

> +gboolean multifd_new_channel(QIOChannel *ioc)
> +{
> +    int thread_count = migrate_multifd_threads();
> +    MultiFDRecvParams *p = g_new0(MultiFDRecvParams, 1);
> +    MigrationState *s = migrate_get_current();
> +    char string[MULTIFD_UUID_MSG];
> +    char string_uuid[UUID_FMT_LEN];
> +    char *uuid;
> +    int id;
> +
> +    qio_channel_read(ioc, string, sizeof(string), &error_abort);

Again, we can't abort QEMU on I/O errors

> +    sscanf(string, "%s multifd %03d", string_uuid, &id);
> +
> +    if (qemu_uuid_set) {
> +        uuid = qemu_uuid_unparse_strdup(&qemu_uuid);
> +    } else {
> +        uuid = g_strdup(multifd_uuid);
> +    }
> +    if (strcmp(string_uuid, uuid)) {
> +        error_report("multifd: received uuid '%s' and expected uuid '%s'",
> +                     string_uuid, uuid);
> +        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> +                          MIGRATION_STATUS_FAILED);
> +        terminate_multifd_recv_threads();
> +        return FALSE;
> +    }
> +    g_free(uuid);
> +
> +    if (multifd_recv_state->params[id] != NULL) {
> +        error_report("multifd: received id '%d' is already setup'", id);
> +        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> +                          MIGRATION_STATUS_FAILED);
> +        terminate_multifd_recv_threads();
> +        return FALSE;
> +    }
> +    qemu_mutex_init(&p->mutex);
> +    qemu_sem_init(&p->sem, 0);
> +    p->quit = false;
> +    p->id = id;
> +    p->c = ioc;
> +    atomic_set(&multifd_recv_state->params[id], p);
> +    qemu_thread_create(&p->thread, "multifd_recv", multifd_recv_thread, p,
> +                       QEMU_THREAD_JOINABLE);
> +    multifd_recv_state->count++;
> +
> +    /* We need to return FALSE for the last channel */
> +    if (multifd_recv_state->count == thread_count) {
> +        return FALSE;
> +    } else {
> +        return TRUE;
> +    }
> +}
> +

> diff --git a/migration/socket.c b/migration/socket.c
> index 6195596..32a6b39 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -26,6 +26,38 @@
>  #include "io/channel-socket.h"
>  #include "trace.h"
>  
> +int socket_recv_channel_destroy(QIOChannel *recv)
> +{
> +    /* Remove channel */
> +    object_unref(OBJECT(recv));
> +    return 0;
> +}
> +
> +struct SocketOutgoingArgs {
> +    SocketAddress *saddr;
> +    Error **errp;
> +} outgoing_args;
> +
> +QIOChannel *socket_send_channel_create(void)
> +{
> +    QIOChannelSocket *sioc = qio_channel_socket_new();
> +
> +    qio_channel_socket_connect_sync(sioc, outgoing_args.saddr,
> +                                    outgoing_args.errp);

This is going to block the caller, which means if someonee
calls migrate_cancel it won't be possible to cleanup
any threads stuck in this connect call. It is preferrable
to use connect_async, and return the sioc immediately. THis
lets the callce close the sioc to cancel the connect attempt.

> +    qio_channel_set_delay(QIO_CHANNEL(sioc), false);
> +    return QIO_CHANNEL(sioc);
> +}
> +
> +int socket_send_channel_destroy(QIOChannel *send)
> +{
> +    /* Remove channel */
> +    object_unref(OBJECT(send));
> +    if (outgoing_args.saddr) {
> +        qapi_free_SocketAddress(outgoing_args.saddr);
> +        outgoing_args.saddr = NULL;
> +    }
> +    return 0;
> +}
>  
>  static SocketAddress *tcp_build_address(const char *host_port, Error **errp)
>  {
> @@ -96,6 +128,9 @@ static void socket_start_outgoing_migration(MigrationState *s,
>      struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
>  
>      data->s = s;
> +    outgoing_args.saddr = saddr;
> +    outgoing_args.errp = errp;

If socket_start_outgoing_migration() is called multiple times, then
we're going to leak saddr.

Also 'errp' is pointing to stack memory in the caller, so you're
saving a pointer to a stack frame that will no longer be valid
once this method returns. So that doesn't look safe to me.

> +
>      if (saddr->type == SOCKET_ADDRESS_TYPE_INET) {
>          data->hostname = g_strdup(saddr->u.inet.host);
>      }
> @@ -106,7 +141,6 @@ static void socket_start_outgoing_migration(MigrationState *s,
>                                       socket_outgoing_migration,
>                                       data,
>                                       socket_connect_data_free);
> -    qapi_free_SocketAddress(saddr);
>  }
>  
>  void tcp_start_outgoing_migration(MigrationState *s,
> @@ -151,8 +185,6 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
>  
>      qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-incoming");
>      result = migration_channel_process_incoming(QIO_CHANNEL(sioc));
> -    object_unref(OBJECT(sioc));
> -
>  out:
>      if (result == FALSE) {
>          /* Close listening socket as its no longer needed */
> diff --git a/migration/socket.h b/migration/socket.h
> index 6b91e9d..dabce0e 100644
> --- a/migration/socket.h
> +++ b/migration/socket.h
> @@ -16,6 +16,16 @@
>  
>  #ifndef QEMU_MIGRATION_SOCKET_H
>  #define QEMU_MIGRATION_SOCKET_H
> +
> +#include "io/channel.h"
> +
> +QIOChannel *socket_recv_channel_create(void);
> +int socket_recv_channel_destroy(QIOChannel *recv);
> +
> +QIOChannel *socket_send_channel_create(void);
> +
> +int socket_send_channel_destroy(QIOChannel *send);
> +
>  void tcp_start_incoming_migration(const char *host_port, Error **errp);
>  
>  void tcp_start_outgoing_migration(MigrationState *s, const char *host_port,
> -- 
> 2.9.4
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
