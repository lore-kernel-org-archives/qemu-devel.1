Received: from eggs.gnu.org ([2001:4830:134:3::10]:34238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ds5xM-00072K-Ao
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ds5xI-00019Q-S4
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:35:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ds5xI-00018p-H5
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:35:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C2B8C04B945
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:35:43 +0000 (UTC)
Date: Wed, 13 Sep 2017 12:35:34 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170913113534.GC3067@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170913105953.13760-1-quintela@redhat.com>
	<20170913105953.13760-13-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913105953.13760-13-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 12/20] migration: Start of multiple fd
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

On Wed, Sep 13, 2017 at 12:59:45PM +0200, Juan Quintela wrote:
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
> Add name parameter
> Use local_err
> Add Error * parameter to socket_send_channel_create()
> Use qio_channel_*_all
> Use asynchronous connect
> ---
>  migration/migration.c |   5 ++
>  migration/ram.c       | 138 +++++++++++++++++++++++++++++++++++++++++++-------
>  migration/ram.h       |   3 ++
>  migration/socket.c    |  34 ++++++++++++-
>  migration/socket.h    |  10 ++++
>  5 files changed, 172 insertions(+), 18 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 1401841997..679be8e8d4 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -419,6 +419,11 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
>   */
>  bool migration_has_all_channels(void)
>  {
> +    if (migrate_use_multifd()) {
> +        int thread_count = migrate_multifd_channels();
> +
> +        return thread_count == multifd_created_channels();
> +    }
>      return true;
>  }
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index a3e2abb2a5..8577eeb032 100644
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
> @@ -362,6 +365,7 @@ struct MultiFDSendParams {
>      uint8_t id;
>      char *name;
>      QemuThread thread;
> +    QIOChannel *c;
>      QemuSemaphore sem;
>      QemuMutex mutex;
>      bool quit;
> @@ -378,6 +382,12 @@ static void terminate_multifd_send_threads(Error *errp)
>  {
>      int i;
>  
> +    if (errp) {
> +        MigrationState *s = migrate_get_current();
> +        migrate_set_error(s, errp);
> +        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> +                          MIGRATION_STATUS_FAILED);
> +    }
>      for (i = 0; i < multifd_send_state->count; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> @@ -403,6 +413,7 @@ int multifd_save_cleanup(Error **errp)
>          qemu_thread_join(&p->thread);
>          qemu_mutex_destroy(&p->mutex);
>          qemu_sem_destroy(&p->sem);
> +        socket_send_channel_destroy(p->c);
>          g_free(p->name);
>          p->name = NULL;
>      }
> @@ -413,9 +424,32 @@ int multifd_save_cleanup(Error **errp)
>      return ret;
>  }
>  
> +/* Default uuid for multifd when qemu is not started with uuid */
> +static char multifd_uuid[] = "5c49fd7e-af88-4a07-b6e8-091fd696ad40";

Same comment as last time - this is pointless. You should just
unconditionally send 'qemu_uuid'.  If the user hasn't set it
via '--uuid', it'll be a fixed UUID of all-zeros which is not
a semantic problem for the usage you have here.

> +/* strlen(multifd) + '-' + <channel id> + '-' +  UUID_FMT + '\0' */
> +#define MULTIFD_UUID_MSG (7 + 1 + 3 + 1 + UUID_FMT_LEN + 1)

>  static void *multifd_send_thread(void *opaque)
>  {
>      MultiFDSendParams *p = opaque;
> +    Error *local_err = NULL;
> +    char *string;
> +    char *string_uuid;
> +    size_t ret;
> +
> +    if (qemu_uuid_set) {
> +        string_uuid = qemu_uuid_unparse_strdup(&qemu_uuid);
> +    } else {
> +        string_uuid = g_strdup(multifd_uuid);
> +    }
> +    string = g_strdup_printf("%s multifd %03d", string_uuid, p->id);

As before, if we need to send some structured data to the other
end, we should define a struct with fields for that, not send
plain text with printf+scanf.

Even better if you put a version in the struct so that you have
something to detect if you need to add more fields at a later
date. eg

 struct MigrateMultiFDInit {
     uint32_t version;
     char uuid[32];
     uint32_t id;
 };


> +    g_free(string_uuid);
> +    ret = qio_channel_write_all(p->c, string, MULTIFD_UUID_MSG, &local_err);
> +    g_free(string);
> +    if (ret != 0) {
> +        terminate_multifd_send_threads(local_err);
> +        return NULL;
> +    }
>  
>      while (true) {
>          qemu_mutex_lock(&p->mutex);
> @@ -430,6 +464,27 @@ static void *multifd_send_thread(void *opaque)
>      return NULL;
>  }
>  
> +static void multifd_new_channel_async(QIOTask *task, gpointer opaque)
> +{
> +    MultiFDSendParams *p = opaque;
> +    QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
> +    Error *local_err;
> +
> +    if (qio_task_propagate_error(task, &local_err)) {
> +        if (multifd_save_cleanup(&local_err) != 0) {
> +            migrate_set_error(migrate_get_current(), local_err);
> +        }
> +    } else {
> +        p->c = QIO_CHANNEL(sioc);
> +        qio_channel_set_delay(p->c, false);
> +
> +        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
> +                           QEMU_THREAD_JOINABLE);
> +
> +        multifd_send_state->count++;
> +    }
> +}
> +
>  int multifd_save_setup(void)
>  {
>      int thread_count;
> @@ -450,10 +505,7 @@ int multifd_save_setup(void)
>          p->quit = false;
>          p->id = i;
>          p->name = g_strdup_printf("multifdsend_%d", i);
> -        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
> -                           QEMU_THREAD_JOINABLE);
> -
> -        multifd_send_state->count++;
> +        socket_send_channel_create(multifd_new_channel_async, p);
>      }
>      return 0;
>  }
> @@ -462,6 +514,7 @@ struct MultiFDRecvParams {
>      uint8_t id;
>      char *name;
>      QemuThread thread;
> +    QIOChannel *c;
>      QemuSemaphore sem;
>      QemuMutex mutex;
>      bool quit;
> @@ -472,12 +525,22 @@ struct {
>      MultiFDRecvParams *params;
>      /* number of created threads */
>      int count;
> +    /* Should we finish */
> +    bool quit;
>  } *multifd_recv_state;
>  
>  static void terminate_multifd_recv_threads(Error *errp)
>  {
>      int i;
>  
> +    if (errp) {
> +        MigrationState *s = migrate_get_current();
> +        migrate_set_error(s, errp);
> +        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> +                          MIGRATION_STATUS_FAILED);
> +    }
> +    multifd_recv_state->quit = true;
> +
>      for (i = 0; i < multifd_recv_state->count; i++) {
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
> @@ -503,6 +566,7 @@ int multifd_load_cleanup(Error **errp)
>          qemu_thread_join(&p->thread);
>          qemu_mutex_destroy(&p->mutex);
>          qemu_sem_destroy(&p->sem);
> +        socket_recv_channel_destroy(p->c);
>          g_free(p->name);
>          p->name = NULL;
>      }
> @@ -531,10 +595,56 @@ static void *multifd_recv_thread(void *opaque)
>      return NULL;
>  }
>  
> +void multifd_new_channel(QIOChannel *ioc)
> +{
> +    MultiFDRecvParams *p;
> +    char string[MULTIFD_UUID_MSG];
> +    char string_uuid[UUID_FMT_LEN];
> +    Error *local_err = NULL;
> +    char *uuid;
> +    size_t ret;
> +    int id;
> +
> +    ret = qio_channel_read_all(ioc, string, sizeof(string), &local_err);
> +    if (ret != 0) {
> +        terminate_multifd_recv_threads(local_err);
> +        return;
> +    }

Now here initially read sizeof(struct MigrateMultiFDInit).

If we need to add extra fields in a v2 struct for example

 struct MigrateMultiFDInitV2 {
     struct MigrateMultiFDInit v1;
     uint32_t extra;
 };

This side now just has to check of version == 2, and then it can
read (sizeof(MigrateMultiFDInitV2) - sizeof(MigrateMultiFDInit))
to get the extra bytes for the new fields from v2.

This is vastly better than non-extensible printf()+scanf()


> +    sscanf(string, "%s multifd %03d", string_uuid, &id);
> +
> +    if (qemu_uuid_set) {
> +        uuid = qemu_uuid_unparse_strdup(&qemu_uuid);
> +    } else {
> +        uuid = g_strdup(multifd_uuid);
> +    }
> +    if (strcmp(string_uuid, uuid)) {
> +        error_setg(&local_err, "multifd: received uuid '%s' and expected "
> +                   "uuid '%s' for channel %d", string_uuid, uuid, id);
> +        terminate_multifd_recv_threads(local_err);
> +        return;
> +    }
> +    g_free(uuid);

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
