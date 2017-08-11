Received: from eggs.gnu.org ([2001:4830:134:3::10]:52488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dgBmH-0003uf-QF
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:23:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dgBmD-0006ch-Ma
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:23:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dgBmD-0006cQ-CW
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:23:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19E1B264B6
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 15:23:04 +0000 (UTC)
Date: Fri, 11 Aug 2017 16:22:56 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170811152256.GS2554@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-12-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808162629.32493-12-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 11/19] migration: Start of multiple fd
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
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Tue, Aug 08, 2017 at 06:26:21PM +0200, Juan Quintela wrote:
> We create new channels for each new thread created. We send through
> them a string containing <uuid> multifd <channel number> so we are
> sure that we connect the right channels in both sides.
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
> We count the number of created threads to know when we need to stop listening
> Use g_strdup_printf
> report channel id on errors
> ---
>  migration/migration.c |  5 +++
>  migration/ram.c       | 99 +++++++++++++++++++++++++++++++++++++++++++--------
>  migration/ram.h       |  3 ++
>  migration/socket.c    | 36 ++++++++++++++++++-
>  migration/socket.h    | 10 ++++++
>  5 files changed, 138 insertions(+), 15 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index e36e880..944d6e2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -413,6 +413,11 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
>   */
>  bool migration_has_all_channels(void)
>  {
> +    if (migrate_use_multifd()) {
> +        int thread_count = migrate_multifd_threads();
> +
> +        return thread_count == multifd_created_threads();
> +    }
>      return true;
>  }
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index 9fb3496..e9fa556 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -36,6 +36,7 @@
>  #include "xbzrle.h"
>  #include "ram.h"
>  #include "migration.h"
> +#include "socket.h"
>  #include "migration/register.h"
>  #include "migration/misc.h"
>  #include "qemu-file.h"
> @@ -46,6 +47,8 @@
>  #include "exec/ram_addr.h"
>  #include "qemu/rcu_queue.h"
>  #include "migration/colo.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/uuid.h"
>  
>  /***********************************************************/
>  /* ram save/restore */
> @@ -361,6 +364,7 @@ static void compress_threads_save_setup(void)
>  struct MultiFDSendParams {
>      uint8_t id;
>      QemuThread thread;
> +    QIOChannel *c;
>      QemuSemaphore sem;
>      QemuMutex mutex;
>      bool quit;
> @@ -401,6 +405,7 @@ void multifd_save_cleanup(void)
>          qemu_thread_join(&p->thread);
>          qemu_mutex_destroy(&p->mutex);
>          qemu_sem_destroy(&p->sem);
> +        socket_send_channel_destroy(p->c);
>      }
>      g_free(multifd_send_state->params);
>      multifd_send_state->params = NULL;
> @@ -408,9 +413,26 @@ void multifd_save_cleanup(void)
>      multifd_send_state = NULL;
>  }
>  
> +/* Default uuid for multifd when qemu is not started with uuid */
> +static char multifd_uuid[] = "5c49fd7e-af88-4a07-b6e8-091fd696ad40";

Why is this better than just using the qemu_uuid unconditionally.
UUIC, it'll just be 00000000-0000-0000-0000-000000000000.

Either way you've got a non-unique UUID if multiple QEMUs are
started, so I dont see a benefit in inventing a new uuid here.

> +/* strlen(multifd) + '-' + <channel id> + '-' +  UUID_FMT + '\0' */
> +#define MULTIFD_UUID_MSG (7 + 1 + 3 + 1 + UUID_FMT_LEN + 1)
> +
>  static void *multifd_send_thread(void *opaque)
>  {
>      MultiFDSendParams *p = opaque;
> +    char *string;
> +    char *string_uuid;
> +
> +    if (qemu_uuid_set) {
> +        string_uuid = qemu_uuid_unparse_strdup(&qemu_uuid);
> +    } else {
> +        string_uuid = g_strdup(multifd_uuid);
> +    }
> +    string = g_strdup_printf("%s multifd %03d", string_uuid, p->id);
> +    g_free(string_uuid);
> +    qio_channel_write(p->c, string, MULTIFD_UUID_MSG, &error_abort);

Must check return code here as it can do a short write, which won't
trigger error_abort.  Also you must not use error_abort at all. QEMU
must not abort when migration hits an I/O error as that needlessly
kills the user's VM.

I also think it is not nice to be formatting a string with printf
here, sending it and then using scanf to extract the data. If we
need to send structured data, then we should define a proper binary
format for it eg 

  struct MigrateUUIDMsg {
      uint32_t chnanelid;
      QemuUUID uuid;
  } __attribute__((__packed__));

and then just send the raw struct across.

> +    g_free(string);
>  
>      while (true) {
>          qemu_mutex_lock(&p->mutex);
> @@ -445,6 +467,12 @@ int multifd_save_setup(void)
>          qemu_sem_init(&p->sem, 0);
>          p->quit = false;
>          p->id = i;
> +        p->c = socket_send_channel_create();
> +        if (!p->c) {
> +            error_report("Error creating a send channel");
> +            multifd_save_cleanup();
> +            return -1;
> +        }

We should pass an 'Error *' object into socket_send_channel_create()
so that we can receive  & report the actual error message, instead
of a useless generic message.


> @@ -522,10 +556,54 @@ static void *multifd_recv_thread(void *opaque)
>      return NULL;
>  }
>  
> +void multifd_new_channel(QIOChannel *ioc)
> +{
> +    MultiFDRecvParams *p = g_new0(MultiFDRecvParams, 1);
> +    MigrationState *s = migrate_get_current();
> +    char string[MULTIFD_UUID_MSG];
> +    char string_uuid[UUID_FMT_LEN];
> +    char *uuid;
> +    int id;
> +
> +    qio_channel_read(ioc, string, sizeof(string), &error_abort);

Must not use error_abort which kills the whole VM ungracefully

> +    sscanf(string, "%s multifd %03d", string_uuid, &id);
> +
> +    if (qemu_uuid_set) {
> +        uuid = qemu_uuid_unparse_strdup(&qemu_uuid);
> +    } else {
> +        uuid = g_strdup(multifd_uuid);
> +    }
> +    if (strcmp(string_uuid, uuid)) {
> +        error_report("multifd: received uuid '%s' and expected uuid '%s'"
> +                     " for channel %d", string_uuid, uuid, id);
> +        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> +                          MIGRATION_STATUS_FAILED);
> +        terminate_multifd_recv_threads();
> +        return;
> +    }
> +    g_free(uuid);

As mentioned above, we should receive a binary struct here instead
of playing games with scanf.

> +
> +    if (multifd_recv_state->params[id] != NULL) {
> +        error_report("multifd: received id '%d' is already setup'", id);
> +        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> +                          MIGRATION_STATUS_FAILED);
> +        terminate_multifd_recv_threads();
> +        return;
> +    }
> +    qemu_mutex_init(&p->mutex);
> +    qemu_sem_init(&p->sem, 0);
> +    p->quit = false;
> +    p->id = id;
> +    p->c = ioc;
> +    atomic_set(&multifd_recv_state->params[id], p);
> +    multifd_recv_state->count++;
> +    qemu_thread_create(&p->thread, "multifd_recv", multifd_recv_thread, p,
> +                       QEMU_THREAD_JOINABLE);
> +}
> +
>  int multifd_load_setup(void)
>  {
>      int thread_count;
> -    uint8_t i;
>  
>      if (!migrate_use_multifd()) {
>          return 0;
> @@ -534,22 +612,15 @@ int multifd_load_setup(void)
>      multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
>      multifd_recv_state->params = g_new0(MultiFDRecvParams *, thread_count);
>      multifd_recv_state->count = 0;
> -    for (i = 0; i < thread_count; i++) {
> -        char thread_name[16];
> -        MultiFDRecvParams *p = multifd_recv_state->params[i];
> -
> -        qemu_mutex_init(&p->mutex);
> -        qemu_sem_init(&p->sem, 0);
> -        p->quit = false;
> -        p->id = i;
> -        snprintf(thread_name, sizeof(thread_name), "multifdrecv_%d", i);
> -        qemu_thread_create(&p->thread, thread_name, multifd_recv_thread, p,
> -                           QEMU_THREAD_JOINABLE);
> -        multifd_recv_state->count++;
> -    }

It us a little strange to be deleting a bunch of code you just added in the
previous patch

> +    multifd_recv_state->quit = false;
>      return 0;
>  }

> diff --git a/migration/socket.c b/migration/socket.c
> index dee8690..5dd6f42 100644
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

Taking a stack local 'errp' pointer and saving it for later use
in a global variable is asking for trouble. There's no guarantee
that stack frame will still be valid when 'outgoing_args.errp'
is later used. 

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

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
