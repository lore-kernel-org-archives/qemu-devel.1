Received: from eggs.gnu.org ([2001:4830:134:3::10]:60123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dvUFS-0002aI-Sz
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dvUFN-0003Ev-TU
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:08:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dvUFN-0003ED-MX
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:08:25 -0400
Date: Fri, 22 Sep 2017 21:08:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170922200816.GK2620@work-vm>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-28-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504081950-2528-28-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 27/33] migration: free SocketAddress where
 allocated
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
> Freeing the SocketAddress struct in socket_start_incoming_migration is
> slightly confusing. Let's free the address in the same context where we
> allocated it.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/socket.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/socket.c b/migration/socket.c
> index 757d382..9fc6cb3 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -168,7 +168,6 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
>  
>      if (qio_channel_socket_listen_sync(listen_ioc, saddr, errp) < 0) {
>          object_unref(OBJECT(listen_ioc));
> -        qapi_free_SocketAddress(saddr);
>          return;
>      }
>  
> @@ -177,7 +176,6 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
>                            socket_accept_incoming_migration,
>                            listen_ioc,
>                            (GDestroyNotify)object_unref);
> -    qapi_free_SocketAddress(saddr);
>  }
>  
>  void tcp_start_incoming_migration(const char *host_port, Error **errp)
> @@ -188,10 +186,12 @@ void tcp_start_incoming_migration(const char *host_port, Error **errp)
>          socket_start_incoming_migration(saddr, &err);
>      }
>      error_propagate(errp, err);
> +    qapi_free_SocketAddress(saddr);
>  }
>  
>  void unix_start_incoming_migration(const char *path, Error **errp)
>  {
>      SocketAddress *saddr = unix_build_address(path);
>      socket_start_incoming_migration(saddr, errp);
> +    qapi_free_SocketAddress(saddr);
>  }
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
