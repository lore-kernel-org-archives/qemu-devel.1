Received: from eggs.gnu.org ([2001:4830:134:3::10]:41280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCLW7-0007rq-GC
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:15:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCLW2-0001V0-CG
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:15:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCLW2-0001Uo-5w
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:15:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 43551A58BF
	for <qemu-devel@nongnu.org>; Wed,  8 Nov 2017 08:15:17 +0000 (UTC)
Date: Wed, 8 Nov 2017 16:15:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171108081510.GD2992@xz-mi>
References: <20171030112112.6952-1-quintela@redhat.com>
	<20171030112112.6952-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171030112112.6952-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/6] migration: free addr in the same
 function that we created it
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

On Mon, Oct 30, 2017 at 12:21:09PM +0100, Juan Quintela wrote:
> Otherwise, we can't use it after calling socket_start_incoming_migration
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

http://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01305.html

So I got a same patch. Let's see which one will go in earlier. I think
it should be this one. :)

> ---
>  migration/socket.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/socket.c b/migration/socket.c
> index dee869044a..3a8232dd2d 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -172,7 +172,6 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
>  
>      if (qio_channel_socket_listen_sync(listen_ioc, saddr, errp) < 0) {
>          object_unref(OBJECT(listen_ioc));
> -        qapi_free_SocketAddress(saddr);
>          return;
>      }
>  
> @@ -181,7 +180,6 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
>                            socket_accept_incoming_migration,
>                            listen_ioc,
>                            (GDestroyNotify)object_unref);
> -    qapi_free_SocketAddress(saddr);
>  }
>  
>  void tcp_start_incoming_migration(const char *host_port, Error **errp)
> @@ -191,6 +189,7 @@ void tcp_start_incoming_migration(const char *host_port, Error **errp)
>      if (!err) {
>          socket_start_incoming_migration(saddr, &err);
>      }
> +    qapi_free_SocketAddress(saddr);
>      error_propagate(errp, err);
>  }
>  
> @@ -198,4 +197,5 @@ void unix_start_incoming_migration(const char *path, Error **errp)
>  {
>      SocketAddress *saddr = unix_build_address(path);
>      socket_start_incoming_migration(saddr, errp);
> +    qapi_free_SocketAddress(saddr);
>  }
> -- 
> 2.13.6
> 

-- 
Peter Xu
