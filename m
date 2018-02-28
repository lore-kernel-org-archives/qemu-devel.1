Received: from eggs.gnu.org ([2001:4830:134:3::10]:46224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eqxla-0001qt-3Q
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:11:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eqxlW-0007DZ-2C
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:11:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60140 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eqxlV-0007CA-Sz
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:11:09 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EE3D8182D17
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 09:11:09 +0000 (UTC)
Date: Wed, 28 Feb 2018 09:10:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180228091058.GC31550@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180228050633.7410-1-peterx@redhat.com>
	<20180228050633.7410-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On Wed, Feb 28, 2018 at 01:06:23PM +0800, Peter Xu wrote:
> The old incoming migration is running in main thread and default
> gcontext.  With the new qio_channel_add_watch_full() we can now let it
> run in the thread's own gcontext (if there is one).
> 
> Currently this patch does nothing alone.  But when any of the incoming
> migration is run in another iothread (e.g., the upcoming migrate-recover
> command), this patch will bind the incoming logic to the iothread
> instead of the main thread (which may already get page faulted and
> hanged).
> 
> RDMA is not considered for now since it's not even using the QIO APIs at
> all.

Errm, yes, it is.

  struct QIOChannelRDMA {
    QIOChannel parent;
    RDMAContext *rdma;
    QEMUFile *file;
    size_t len;
    bool blocking; /* XXX we don't actually honour this yet */
  };
  ....

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

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
