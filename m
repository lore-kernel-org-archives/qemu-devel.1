Received: from eggs.gnu.org ([2001:4830:134:3::10]:53469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dhVZ2-00087g-Be
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dhVZ1-0005la-9n
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:42:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dhVZ1-0005lE-0q
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:42:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA0EE80491
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 06:42:53 +0000 (UTC)
Date: Tue, 15 Aug 2017 14:42:48 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170815064248.GT26015@pxdev.xzpeter.org>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-10-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808162629.32493-10-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 09/19] migration: Create multifd
 migration threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Tue, Aug 08, 2017 at 06:26:19PM +0200, Juan Quintela wrote:

[...]

> diff --git a/migration/migration.c b/migration/migration.c
> index 6c4eb4b..d031c93 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -296,6 +296,7 @@ static void process_incoming_migration_bh(void *opaque)
>      } else {
>          runstate_set(global_state_get_runstate());
>      }
> +    multifd_load_cleanup();

Maybe we can put multifd_load_cleanup() into
migration_incoming_state_destroy(), then this line can be removed,
and...

>      /*
>       * This must happen after any state changes since as soon as an external
>       * observer sees this event they might start to prod at the VM assuming
> @@ -358,6 +359,7 @@ static void process_incoming_migration_co(void *opaque)
>                            MIGRATION_STATUS_FAILED);
>          error_report("load of migration failed: %s", strerror(-ret));
>          qemu_fclose(mis->from_src_file);
> +        multifd_load_cleanup();

... here we can call migration_incoming_state_destroy() as well, and
we also don't need "qemu_fclose(mis->from_src_file)" any more.

>          exit(EXIT_FAILURE);
>      }
>      mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
> @@ -368,7 +370,12 @@ void migration_fd_process_incoming(QEMUFile *f)
>  {
>      Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
>      MigrationIncomingState *mis = migration_incoming_get_current();
> -    
> +
> +    if (multifd_load_setup() != 0) {
> +        /* We haven't been able to create multifd threads
> +           nothing better to do */

Nit: maybe an error_report() before quit (though I see that
multifd_load_setup() actually never fails)?

> +        exit(EXIT_FAILURE);
> +    }
>      if (!mis->from_src_file) {
>          mis->from_src_file = f;
>      }

[...]

> +int multifd_load_setup(void)
> +{
> +    int thread_count;
> +    uint8_t i;
> +
> +    if (!migrate_use_multifd()) {
> +        return 0;
> +    }
> +    thread_count = migrate_multifd_threads();
> +    multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
> +    multifd_recv_state->params = g_new0(MultiFDRecvParams *, thread_count);
> +    multifd_recv_state->count = 0;
> +    for (i = 0; i < thread_count; i++) {
> +        char thread_name[16];
> +        MultiFDRecvParams *p = multifd_recv_state->params[i];
> +
> +        qemu_mutex_init(&p->mutex);

multifd_recv_state->params is still an array of pointers, and we are
trying to use "p", which is still uninitialized?

> +        qemu_sem_init(&p->sem, 0);
> +        p->quit = false;
> +        p->id = i;
> +        snprintf(thread_name, sizeof(thread_name), "multifdrecv_%d", i);
> +        qemu_thread_create(&p->thread, thread_name, multifd_recv_thread, p,
> +                           QEMU_THREAD_JOINABLE);
> +        multifd_recv_state->count++;
> +    }
> +    return 0;
> +}

Thanks,

-- 
Peter Xu
