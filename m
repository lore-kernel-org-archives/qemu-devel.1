Received: from eggs.gnu.org ([2001:4830:134:3::10]:35361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1er5m5-0003gv-JY
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 12:44:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1er5m2-00074e-GM
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 12:44:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36940 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1er5m2-00074S-9t
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 12:44:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE4AA8D6F1
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 17:43:53 +0000 (UTC)
Date: Wed, 28 Feb 2018 17:43:50 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180228174349.GJ2981@work-vm>
References: <20180228050633.7410-1-peterx@redhat.com>
	<20180228050633.7410-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228050633.7410-5-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/14] migration: let incoming side use
 thread context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> The old incoming migration is running in main thread and default
> gcontext.  With the new qio_channel_add_watch_full() we can now let it
> run in the thread's own gcontext (if there is one).
> 
> Currently this patch does nothing alone.  But when any of the incoming
> migration is run in another iothread (e.g., the upcoming migrate-recover
> command), this patch will bind the incoming logic to the iothread
> instead of the main thread (which may already get page faulted and
> hanged).

Does this make any difference to the Postcopy listener thread, which
takes over reading from the main thread once in postcopy mode?
(See savevm.c:postcopy_ram_listen_thread).

Dave

> RDMA is not considered for now since it's not even using the QIO APIs at
> all.
> 
> CC: Juan Quintela <quintela@redhat.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/exec.c   | 11 ++++++-----
>  migration/fd.c     | 11 ++++++-----
>  migration/socket.c | 12 +++++++-----
>  3 files changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/migration/exec.c b/migration/exec.c
> index 0bc5a427dd..f401fc005e 100644
> --- a/migration/exec.c
> +++ b/migration/exec.c
> @@ -55,6 +55,7 @@ void exec_start_incoming_migration(const char *command, Error **errp)
>  {
>      QIOChannel *ioc;
>      const char *argv[] = { "/bin/sh", "-c", command, NULL };
> +    GSource *source;
>  
>      trace_migration_exec_incoming(command);
>      ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
> @@ -65,9 +66,9 @@ void exec_start_incoming_migration(const char *command, Error **errp)
>      }
>  
>      qio_channel_set_name(ioc, "migration-exec-incoming");
> -    qio_channel_add_watch(ioc,
> -                          G_IO_IN,
> -                          exec_accept_incoming_migration,
> -                          NULL,
> -                          NULL);
> +    source = qio_channel_add_watch_full(ioc, G_IO_IN,
> +                                        exec_accept_incoming_migration,
> +                                        NULL, NULL,
> +                                        g_main_context_get_thread_default());
> +    g_source_unref(source);
>  }
> diff --git a/migration/fd.c b/migration/fd.c
> index cd06182d1e..9c593eb3ff 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -55,6 +55,7 @@ void fd_start_incoming_migration(const char *infd, Error **errp)
>  {
>      QIOChannel *ioc;
>      int fd;
> +    GSource *source;
>  
>      fd = strtol(infd, NULL, 0);
>      trace_migration_fd_incoming(fd);
> @@ -66,9 +67,9 @@ void fd_start_incoming_migration(const char *infd, Error **errp)
>      }
>  
>      qio_channel_set_name(QIO_CHANNEL(ioc), "migration-fd-incoming");
> -    qio_channel_add_watch(ioc,
> -                          G_IO_IN,
> -                          fd_accept_incoming_migration,
> -                          NULL,
> -                          NULL);
> +    source = qio_channel_add_watch_full(ioc, G_IO_IN,
> +                                        fd_accept_incoming_migration,
> +                                        NULL, NULL,
> +                                        g_main_context_get_thread_default());
> +    g_source_unref(source);
>  }
> diff --git a/migration/socket.c b/migration/socket.c
> index e090097077..82c330083c 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -164,6 +164,7 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
>                                              Error **errp)
>  {
>      QIOChannelSocket *listen_ioc = qio_channel_socket_new();
> +    GSource *source;
>  
>      qio_channel_set_name(QIO_CHANNEL(listen_ioc),
>                           "migration-socket-listener");
> @@ -173,11 +174,12 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
>          return;
>      }
>  
> -    qio_channel_add_watch(QIO_CHANNEL(listen_ioc),
> -                          G_IO_IN,
> -                          socket_accept_incoming_migration,
> -                          listen_ioc,
> -                          (GDestroyNotify)object_unref);
> +    source = qio_channel_add_watch_full(QIO_CHANNEL(listen_ioc), G_IO_IN,
> +                                        socket_accept_incoming_migration,
> +                                        listen_ioc,
> +                                        (GDestroyNotify)object_unref,
> +                                        g_main_context_get_thread_default());
> +    g_source_unref(source);
>  }
>  
>  void tcp_start_incoming_migration(const char *host_port, Error **errp)
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
