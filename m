Received: from eggs.gnu.org ([2001:4830:134:3::10]:39622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d0VaP-0003s2-Lg
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 12:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d0VaL-0002dX-4Q
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 12:02:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d0VaK-0002cv-Rc
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 12:02:33 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170418083045.14956-1-maozy.fnst@cn.fujitsu.com>
	<20170418083045.14956-2-maozy.fnst@cn.fujitsu.com>
Date: Tue, 18 Apr 2017 18:02:29 +0200
In-Reply-To: <20170418083045.14956-2-maozy.fnst@cn.fujitsu.com> (Mao Zhongyi's
	message of "Tue, 18 Apr 2017 16:30:45 +0800")
Message-ID: <87pog9ya96.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] net/socket: Improve -net socket error
 reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com

Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:

> When -net socket fails, it first reports a specific error, then
> a generic one, like this:
>
>     $ qemu-system-x86_64 -net socket,
>     qemu-system-x86_64: -net socket: exactly one of fd=, listen=, connect=, mcast= or udp= is required
>     qemu-system-x86_64: -net socket: Device 'socket' could not be initialized
>
> Convert net_init_socket() to Error to get rid of the unwanted second
> error message.
>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

Thanks for trying to tackle this.

> ---
>  net/socket.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/net/socket.c b/net/socket.c
> index 1886f98..85ad9cd 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -691,7 +691,6 @@ static int net_socket_udp_init(NetClientState *peer,
>  int net_init_socket(const Netdev *netdev, const char *name,
>                      NetClientState *peer, Error **errp)
>  {
> -    /* FIXME error_setg(errp, ...) on failure */
>      Error *err = NULL;
>      const NetdevSocketOptions *sock;
>  
> @@ -700,13 +699,13 @@ int net_init_socket(const Netdev *netdev, const char *name,
>  
>      if (sock->has_fd + sock->has_listen + sock->has_connect + sock->has_mcast +
>          sock->has_udp != 1) {
> -        error_report("exactly one of fd=, listen=, connect=, mcast= or udp="
> +        error_setg(errp, "exactly one of fd=, listen=, connect=, mcast= or udp="
>                       " is required");
>          return -1;
>      }
>  
>      if (sock->has_localaddr && !sock->has_mcast && !sock->has_udp) {
> -        error_report("localaddr= is only valid with mcast= or udp=");
> +        error_setg(errp, "localaddr= is only valid with mcast= or udp=");
>          return -1;
>      }
>  
       if (sock->has_fd) {
           int fd;

           fd = monitor_fd_param(cur_mon, sock->fd, &err);
           if (fd == -1) {
               error_report_err(err);

You missed this one.

               return -1;
           }
           qemu_set_nonblock(fd);
           if (!net_socket_fd_init(peer, "socket", name, fd, 1)) {
               return -1;
           }
           return 0;
       }

       if (sock->has_listen) {
           if (net_socket_listen_init(peer, "socket", name, sock->listen) == -1) {

net_socket_listen_init() calls error_report_err().  You need to convert
it to Error.

               return -1;
           }
           return 0;
       }

       if (sock->has_connect) {
           if (net_socket_connect_init(peer, "socket", name, sock->connect) ==
               -1) {

Likewise.

You also need to convert net_socket_connected().

You should review everything called by this function for use of
error_report() or similar.

               return -1;
           }
           return 0;
       }

       if (sock->has_mcast) {
           /* if sock->localaddr is missing, it has been initialized to "all bits
            * zero" */
           if (net_socket_mcast_init(peer, "socket", name, sock->mcast,
               sock->localaddr) == -1) {

Different kind of problem here: this function can fail without reporting
an error.  You need to fix it to set an error when it fails.

               return -1;
           }
           return 0;
       }
> @@ -752,7 +751,7 @@ int net_init_socket(const Netdev *netdev, const char *name,
>  
>      assert(sock->has_udp);
>      if (!sock->has_localaddr) {
> -        error_report("localaddr= is mandatory with udp=");
> +        error_setg(errp, "localaddr= is mandatory with udp=");
>          return -1;
>      }
>      if (net_socket_udp_init(peer, "socket", name, sock->udp, sock->localaddr) ==
