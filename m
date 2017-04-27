Received: from eggs.gnu.org ([2001:4830:134:3::10]:50599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3mDP-0000om-Bw
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3mDM-0004Wh-7e
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:24:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d3mDL-0004Vg-UV
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:24:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
	<2bc05de0edd61cdcdd3d2b894378a874d1e12327.1493191677.git.maozy.fnst@cn.fujitsu.com>
Date: Thu, 27 Apr 2017 18:24:17 +0200
In-Reply-To: <2bc05de0edd61cdcdd3d2b894378a874d1e12327.1493191677.git.maozy.fnst@cn.fujitsu.com>
	(Mao Zhongyi's message of "Wed, 26 Apr 2017 16:04:17 +0800")
Message-ID: <87shktu8cu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/4] net/socket: Convert error report
 message to Error
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

No review, just an observation.

Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:

> Currently, net_socket_mcast_create(), net_socket_fd_init_dgram() and
> net_socket_fd_init() use the function such as fprintf(), perror() to
> report an error message.
>
> Now, convert these functions to Error.
>
> CC: jasowang@redhat.com, armbru@redhat.com
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  net/socket.c | 66 +++++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 41 insertions(+), 25 deletions(-)
>
> diff --git a/net/socket.c b/net/socket.c
> index b0decbe..559e09a 100644
> --- a/net/socket.c
> +++ b/net/socket.c
[...]
> @@ -433,25 +437,27 @@ static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
>  
>  static NetSocketState *net_socket_fd_init(NetClientState *peer,
>                                            const char *model, const char *name,
> -                                          int fd, int is_connected)
> +                                          int fd, int is_connected,
> +                                          Error **errp)
>  {
>      int so_type = -1, optlen=sizeof(so_type);
>  
>      if(getsockopt(fd, SOL_SOCKET, SO_TYPE, (char *)&so_type,
>          (socklen_t *)&optlen)< 0) {
> -        fprintf(stderr, "qemu: error: getsockopt(SO_TYPE) for fd=%d failed\n",
> +        error_setg(errp, "qemu: error: getsockopt(SO_TYPE) for fd=%d failed",
>                  fd);
>          closesocket(fd);
>          return NULL;
>      }
>      switch(so_type) {
>      case SOCK_DGRAM:
> -        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected);
> +        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected, errp);
>      case SOCK_STREAM:
>          return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
>      default:
>          /* who knows ... this could be a eg. a pty, do warn and continue as stream */
> -        fprintf(stderr, "qemu: warning: socket type=%d for fd=%d is not SOCK_DGRAM or SOCK_STREAM\n", so_type, fd);
> +        error_setg(errp, "qemu: warning: socket type=%d for fd=%d is not SOCK_DGRAM"
> +                   " or SOCK_STREAM", so_type, fd);

Not this patches problem: this case is odd, and the comment is bogus.
If @fd really was a pty, getsockopt() would fail with ENOTSOCK, wouldn't
it?  If @fd is a socket, but neither SOCK_DGRAM nor SOCK_STREAM (say
SOCK_RAW), why is it safe to continue as if it was SOCK_STREAM?  Jason?

>          return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
>      }
>      return NULL;

Not reachable.  Ugly, but not your patch's concern.

[...]
