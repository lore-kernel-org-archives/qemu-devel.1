Received: from eggs.gnu.org ([2001:4830:134:3::10]:54612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evJsZ-0004Nq-3B
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evJsV-0002Gu-Qj
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:36:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33660 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1evJsV-0002F7-ME
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:36:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73C844067F25
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:36:19 +0000 (UTC)
Date: Mon, 12 Mar 2018 17:36:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180312093608.GH5234@xz-mi>
References: <20180307110010.2205-1-quintela@redhat.com>
	<20180307110010.2205-21-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180307110010.2205-21-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 20/24] migration: Delay start of
 migration main routines
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

On Wed, Mar 07, 2018 at 12:00:06PM +0100, Juan Quintela wrote:
> We need to make sure that we have started all the multifd threads.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 4 ++--
>  migration/migration.h | 1 +
>  migration/ram.c       | 3 +++
>  migration/socket.c    | 3 +++
>  4 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index c06c34ca0f..a355618220 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -429,7 +429,7 @@ static void migration_incoming_setup(QEMUFile *f)
>      qemu_file_set_blocking(f, false);
>  }
>  
> -static void migration_incoming_process(void)
> +void migration_incoming_process(void)
>  {
>      Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
>      qemu_coroutine_enter(co);
> @@ -447,7 +447,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
>  
>      if (!mis->from_src_file) {
>          QEMUFile *f = qemu_fopen_channel_input(ioc);
> -        migration_fd_process_incoming(f);
> +        migration_incoming_setup(f);
>          return;
>      }
>      multifd_recv_new_channel(ioc);
> diff --git a/migration/migration.h b/migration/migration.h
> index f40014cf94..03a940831d 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -184,6 +184,7 @@ void migrate_set_state(int *state, int old_state, int new_state);
>  
>  void migration_fd_process_incoming(QEMUFile *f);
>  void migration_ioc_process_incoming(QIOChannel *ioc);
> +void migration_incoming_process(void);
>  
>  bool  migration_has_all_channels(void);
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index 7ef0c2b7e2..1aab96bd5e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -743,6 +743,9 @@ void multifd_recv_new_channel(QIOChannel *ioc)
>      qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
>                         QEMU_THREAD_JOINABLE);
>      atomic_inc(&multifd_recv_state->count);
> +    if (multifd_recv_state->count == migrate_multifd_channels()) {
> +        migration_incoming_process();
> +    }
>  }
>  
>  /**
> diff --git a/migration/socket.c b/migration/socket.c
> index b3b5571ebb..deda193de7 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -189,6 +189,9 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
>      if (migration_has_all_channels()) {
>          /* Close listening socket as its no longer needed */
>          qio_channel_close(ioc, NULL);
> +        if (!migrate_use_multifd()) {
> +            migration_incoming_process();

Calling this in socket code seems a bit odd to me.

Can we do something like this?

void migration_ioc_process_incoming(QIOChannel *ioc)
{
    MigrationIncomingState *mis = migration_incoming_get_current();

    if (!mis->from_src_file) {
        /* This is the main channel */
        QEMUFile *f = qemu_fopen_channel_input(ioc);
        migration_incoming_setup(f);
    } else {
        /* This is one of the multifd channels */
        assert(migrate_use_multifd());
        multifd_recv_new_channel(ioc);
    }

    /*
     * Trigger the migration either if:
     * (1) we are not using multifd, or
     * (2) we have setup all the multifd channels
     */
    if (!migrate_use_multifd() || multifd_recv_all_channels_created()) {
        migration_incoming_process();
    }
}

Then we possibly won't need patch 13 as well.  Thanks,

-- 
Peter Xu
