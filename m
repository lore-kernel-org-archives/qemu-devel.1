Received: from eggs.gnu.org ([2001:4830:134:3::10]:33003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dvUIs-0004qt-Hi
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dvUIn-000500-IJ
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:12:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dvUIn-0004zQ-9s
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:11:57 -0400
Date: Fri, 22 Sep 2017 21:11:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170922201149.GL2620@work-vm>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-29-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504081950-2528-29-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 28/33] migration: return incoming task tag
 for sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> For socket based incoming migration, we attached a background task onto
> main loop to handle the acception of connections. We never had a way to
> destroy it before, only if we finished the migration.
> 
> Let's allow socket_start_incoming_migration() to return the source tag
> of the listening async work, so that we may be able to clean it up in
> the future.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/socket.c | 36 ++++++++++++++++++++++++------------
>  migration/socket.h |  4 ++--
>  2 files changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/migration/socket.c b/migration/socket.c
> index 9fc6cb3..6ee51ef 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -158,8 +158,12 @@ out:
>  }
>  
>  
> -static void socket_start_incoming_migration(SocketAddress *saddr,
> -                                            Error **errp)
> +/*
> + * Returns the tag ID of the watch that is attached to global main
> + * loop (>0), or zero if failure detected.
> + */
> +static guint socket_start_incoming_migration(SocketAddress *saddr,
> +                                             Error **errp)
>  {
>      QIOChannelSocket *listen_ioc = qio_channel_socket_new();
>  
> @@ -168,30 +172,38 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
>  
>      if (qio_channel_socket_listen_sync(listen_ioc, saddr, errp) < 0) {
>          object_unref(OBJECT(listen_ioc));
> -        return;
> +        return 0;
>      }
>  
> -    qio_channel_add_watch(QIO_CHANNEL(listen_ioc),
> -                          G_IO_IN,
> -                          socket_accept_incoming_migration,
> -                          listen_ioc,
> -                          (GDestroyNotify)object_unref);
> +    return qio_channel_add_watch(QIO_CHANNEL(listen_ioc),
> +                                 G_IO_IN,
> +                                 socket_accept_incoming_migration,
> +                                 listen_ioc,
> +                                 (GDestroyNotify)object_unref);
>  }
>  
> -void tcp_start_incoming_migration(const char *host_port, Error **errp)
> +guint tcp_start_incoming_migration(const char *host_port, Error **errp)
>  {
>      Error *err = NULL;
>      SocketAddress *saddr = tcp_build_address(host_port, &err);
> +    guint tag;
> +
>      if (!err) {
> -        socket_start_incoming_migration(saddr, &err);
> +        tag = socket_start_incoming_migration(saddr, &err);
>      }

I'd be tempted to initialise that tag = 0   for the case where
there's an error; but OK.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>      error_propagate(errp, err);
>      qapi_free_SocketAddress(saddr);
> +
> +    return tag;
>  }
>  
> -void unix_start_incoming_migration(const char *path, Error **errp)
> +guint unix_start_incoming_migration(const char *path, Error **errp)
>  {
>      SocketAddress *saddr = unix_build_address(path);
> -    socket_start_incoming_migration(saddr, errp);
> +    guint tag;
> +
> +    tag = socket_start_incoming_migration(saddr, errp);
>      qapi_free_SocketAddress(saddr);
> +
> +    return tag;
>  }
> diff --git a/migration/socket.h b/migration/socket.h
> index 6b91e9d..bc8a59a 100644
> --- a/migration/socket.h
> +++ b/migration/socket.h
> @@ -16,12 +16,12 @@
>  
>  #ifndef QEMU_MIGRATION_SOCKET_H
>  #define QEMU_MIGRATION_SOCKET_H
> -void tcp_start_incoming_migration(const char *host_port, Error **errp);
> +guint tcp_start_incoming_migration(const char *host_port, Error **errp);
>  
>  void tcp_start_outgoing_migration(MigrationState *s, const char *host_port,
>                                    Error **errp);
>  
> -void unix_start_incoming_migration(const char *path, Error **errp);
> +guint unix_start_incoming_migration(const char *path, Error **errp);
>  
>  void unix_start_outgoing_migration(MigrationState *s, const char *path,
>                                     Error **errp);
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
