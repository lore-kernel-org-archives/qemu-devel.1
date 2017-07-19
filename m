Received: from eggs.gnu.org ([2001:4830:134:3::10]:42350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXssh-0005cL-9j
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXsse-0000gu-4h
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:35:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dXssd-0000fY-QM
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:35:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A0AA7F413
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 17:35:22 +0000 (UTC)
Date: Wed, 19 Jul 2017 18:35:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170719173513.GJ3500@work-vm>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-10-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We create new channels for each new thread created. We only send through
> them a character to be sure that we are creating the channels in the
> right order.

That text is out of date isn't it?

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
> diff --git a/migration/migration.c b/migration/migration.c
> index b81c498..e1c79d5 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -389,8 +389,13 @@ gboolean migration_ioc_process_incoming(QIOChannel *ioc)
>          QEMUFile *f = qemu_fopen_channel_input(ioc);
>          mis->from_src_file = f;
>          migration_fd_process_incoming(f);
> +        if (!migrate_use_multifd()) {
> +            return FALSE;
> +        } else {
> +            return TRUE;
> +        }
>      }
> -    return FALSE; /* unregister */
> +    return multifd_new_channel(ioc);
>  }
>  
>  /*
> diff --git a/migration/ram.c b/migration/ram.c
> index 8e87533..b80f511 100644
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
> +    g_free(string_uuid);
> +
> +    /* -1 due to the wonders of '\0' accounting */
> +    if (res != (MULTIFD_UUID_MSG - 1)) {
> +        error_report("Multifd UUID message '%s' is not of right length",
> +            string);
> +        exit = true;
> +    } else {
> +        qio_channel_write(p->c, string, MULTIFD_UUID_MSG, &error_abort);
> +    }
> +
> +    while (!exit) {
>          qemu_mutex_lock(&p->mutex);
>          if (p->quit) {
>              qemu_mutex_unlock(&p->mutex);
> @@ -445,6 +477,12 @@ int multifd_save_setup(void)
>          qemu_sem_init(&p->sem, 0);
>          p->quit = false;
>          p->id = i;
> +        p->c = socket_send_channel_create();
> +        if (!p->c) {
> +            error_report("Error creating a send channel");
> +            multifd_save_cleanup();
> +            return -1;
> +        }
>          snprintf(thread_name, sizeof(thread_name), "multifdsend_%d", i);
>          qemu_thread_create(&p->thread, thread_name, multifd_send_thread, p,
>                             QEMU_THREAD_JOINABLE);
> @@ -456,6 +494,7 @@ int multifd_save_setup(void)
>  struct MultiFDRecvParams {
>      uint8_t id;
>      QemuThread thread;
> +    QIOChannel *c;
>      QemuSemaphore sem;
>      QemuMutex mutex;
>      bool quit;
> @@ -463,7 +502,7 @@ struct MultiFDRecvParams {
>  typedef struct MultiFDRecvParams MultiFDRecvParams;
>  
>  struct {
> -    MultiFDRecvParams *params;
> +    MultiFDRecvParams **params;

Probably want to push that upto where you added that struct?

>      /* number of created threads */
>      int count;
>  } *multifd_recv_state;
> @@ -473,7 +512,7 @@ static void terminate_multifd_recv_threads(void)
>      int i;
>  
>      for (i = 0; i < multifd_recv_state->count; i++) {
> -        MultiFDRecvParams *p = &multifd_recv_state->params[i];
> +        MultiFDRecvParams *p = multifd_recv_state->params[i];
>  
>          qemu_mutex_lock(&p->mutex);
>          p->quit = true;
> @@ -491,11 +530,13 @@ void multifd_load_cleanup(void)
>      }
>      terminate_multifd_recv_threads();
>      for (i = 0; i < multifd_recv_state->count; i++) {
> -        MultiFDRecvParams *p = &multifd_recv_state->params[i];
> +        MultiFDRecvParams *p = multifd_recv_state->params[i];
>  
>          qemu_thread_join(&p->thread);
>          qemu_mutex_destroy(&p->mutex);
>          qemu_sem_destroy(&p->sem);
> +        socket_recv_channel_destroy(p->c);
> +        g_free(p);
>      }
>      g_free(multifd_recv_state->params);
>      multifd_recv_state->params = NULL;
> @@ -520,31 +561,70 @@ static void *multifd_recv_thread(void *opaque)
>      return NULL;
>  }
>  
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

probably worth adding the channel id as well so we can see
when it fails.

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

Can you explain why this is quite so careful about ordering ? Is there
something that could look at params or try and take the mutex before
the count is incremented?

I think it's safe to do:
 p->quit = false;
 p->id = id;
 p->c = ioc;
 &multifd_recv_state->params[id] = p;
 qemu_sem_init(&p->sem, 0);
 qemu_mutex_init(&p->mutex);
 qemu_thread_create(...)
 atomic_inc(&multifd_recv_state->count);    <-- I'm not sure if this
 needs to be atomic

> +    qemu_thread_create(&p->thread, "multifd_recv", multifd_recv_thread, p,
> +                       QEMU_THREAD_JOINABLE);

You've lost the nice numbered thread names you had created in the
previous version of this that you're removing.

> +    multifd_recv_state->count++;
> +
> +    /* We need to return FALSE for the last channel */
> +    if (multifd_recv_state->count == thread_count) {
> +        return FALSE;
> +    } else {
> +        return TRUE;
> +    }

return multifd_recv_state->count != thread_count;   ?

> +}
> +
>  int multifd_load_setup(void)
>  {
>      int thread_count;
> -    uint8_t i;
>  
>      if (!migrate_use_multifd()) {
>          return 0;
>      }
>      thread_count = migrate_multifd_threads();
>      multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
> -    multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
> +    multifd_recv_state->params = g_new0(MultiFDRecvParams *, thread_count);
>      multifd_recv_state->count = 0;
> -    for (i = 0; i < thread_count; i++) {
> -        char thread_name[16];
> -        MultiFDRecvParams *p = &multifd_recv_state->params[i];
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
>      return 0;
>  }
>  
> diff --git a/migration/ram.h b/migration/ram.h
> index 93c2bb4..9413544 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -31,6 +31,7 @@
>  
>  #include "qemu-common.h"
>  #include "exec/cpu-common.h"
> +#include "io/channel.h"
>  
>  extern MigrationStats ram_counters;
>  extern XBZRLECacheStats xbzrle_counters;
> @@ -43,6 +44,7 @@ int multifd_save_setup(void);
>  void multifd_save_cleanup(void);
>  int multifd_load_setup(void);
>  void multifd_load_cleanup(void);
> +gboolean multifd_new_channel(QIOChannel *ioc);
>  
>  uint64_t ram_pagesize_summary(void);
>  int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
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

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
