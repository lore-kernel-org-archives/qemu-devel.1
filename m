Received: from eggs.gnu.org ([2001:4830:134:3::10]:54770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evREH-00050j-WA
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evREE-0002Hl-Rv
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:27:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36296 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evREE-0002HJ-Lx
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:27:18 -0400
Date: Mon, 12 Mar 2018 17:27:14 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180312172714.GR3219@work-vm>
References: <20180309091535.13315-1-peterx@redhat.com>
	<20180309091535.13315-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309091535.13315-2-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 01/23] migration: let incoming side use
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
Cc: qemu-devel@nongnu.org, Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Laurent Vivier <lvivier@redhat.com>

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
> 
> RDMA is not considered for now since it's not even using the QIO watch
> framework at all.

> CC: Juan Quintela <quintela@redhat.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/exec.c   |  9 ++++-----
>  migration/fd.c     |  9 ++++-----
>  migration/socket.c | 10 +++++-----
>  3 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/migration/exec.c b/migration/exec.c
> index 0bc5a427dd..9d0f82f1f0 100644
> --- a/migration/exec.c
> +++ b/migration/exec.c
> @@ -65,9 +65,8 @@ void exec_start_incoming_migration(const char *command, Error **errp)
>      }
>  
>      qio_channel_set_name(ioc, "migration-exec-incoming");
> -    qio_channel_add_watch(ioc,
> -                          G_IO_IN,
> -                          exec_accept_incoming_migration,
> -                          NULL,
> -                          NULL);
> +    qio_channel_add_watch_full(ioc, G_IO_IN,
> +                               exec_accept_incoming_migration,
> +                               NULL, NULL,
> +                               g_main_context_get_thread_default());
>  }
> diff --git a/migration/fd.c b/migration/fd.c
> index cd06182d1e..9a380bbbc4 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -66,9 +66,8 @@ void fd_start_incoming_migration(const char *infd, Error **errp)
>      }
>  
>      qio_channel_set_name(QIO_CHANNEL(ioc), "migration-fd-incoming");
> -    qio_channel_add_watch(ioc,
> -                          G_IO_IN,
> -                          fd_accept_incoming_migration,
> -                          NULL,
> -                          NULL);
> +    qio_channel_add_watch_full(ioc, G_IO_IN,
> +                               fd_accept_incoming_migration,
> +                               NULL, NULL,
> +                               g_main_context_get_thread_default());
>  }
> diff --git a/migration/socket.c b/migration/socket.c
> index 8a93fb1af5..91071b06ef 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -174,11 +174,11 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
>          return;
>      }
>  
> -    qio_channel_add_watch(QIO_CHANNEL(listen_ioc),
> -                          G_IO_IN,
> -                          socket_accept_incoming_migration,
> -                          listen_ioc,
> -                          (GDestroyNotify)object_unref);
> +    qio_channel_add_watch_full(QIO_CHANNEL(listen_ioc), G_IO_IN,
> +                               socket_accept_incoming_migration,
> +                               listen_ioc,
> +                               (GDestroyNotify)object_unref,
> +                               g_main_context_get_thread_default());
>  }
>  
>  void tcp_start_incoming_migration(const char *host_port, Error **errp)
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
