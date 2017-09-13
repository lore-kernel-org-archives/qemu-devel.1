Received: from eggs.gnu.org ([2001:4830:134:3::10]:39365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ds65e-0003rM-8p
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ds65a-0000AN-6k
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:44:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ds65Z-00009o-Tq
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:44:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA4965F73C
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:44:16 +0000 (UTC)
Date: Wed, 13 Sep 2017 12:44:10 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170913114410.GE3067@redhat.com>
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
> +
> +    p = &multifd_recv_state->params[id];
> +    if (p->id != 0) {
> +        error_setg(&local_err, "multifd: received id '%d' already setup'", id);
> +        terminate_multifd_recv_threads(local_err);
> +        return;
> +    }
> +    qemu_mutex_init(&p->mutex);
> +    qemu_sem_init(&p->sem, 0);
> +    p->quit = false;
> +    p->id = id;
> +    p->c = ioc;

You must acquire a reference on 'ioc', so that the thread you are
about to spawn will own a reference on it.

The function that you later call  multifd_new_channel() from
expects it to acquire its own reference.

> +    multifd_recv_state->count++;
> +    p->name = g_strdup_printf("multifdrecv_%d", id);
> +    qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
> +                       QEMU_THREAD_JOINABLE);
> +}

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
