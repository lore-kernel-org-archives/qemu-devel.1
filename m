Received: from eggs.gnu.org ([2001:4830:134:3::10]:44129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dOOlS-0007PY-F1
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dOOlO-0000sM-Hg
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:36:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dOOlO-0000ru-8K
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:36:42 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1497276062.git.maozy.fnst@cn.fujitsu.com>
	<9f8cd98603274c9f6c14b72212b51f26cf0c8fb5.1497276062.git.maozy.fnst@cn.fujitsu.com>
Date: Fri, 23 Jun 2017 15:36:39 +0200
In-Reply-To: <9f8cd98603274c9f6c14b72212b51f26cf0c8fb5.1497276062.git.maozy.fnst@cn.fujitsu.com>
	(Mao Zhongyi's message of "Mon, 12 Jun 2017 22:15:02 +0800")
Message-ID: <87mv8y4yhk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 1/4] net/socket: Drop the odd 'default'
 case and comment
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

> In the net_socket_fd_init(), the 'default' case and comment is odd.
> If @fd really was a pty, getsockopt() would fail with ENOTSOCK. If
> @fd was a socket, but neither SOCK_DGRAM nor SOCK_STREAM. It should
> not be treated as if it was SOCK_STREAM.
>
> If there is a genuine reason to support something like SOCK_RAW, it
> should be explicitly handled.
>
> So, drop the 'default' case since it is broken already.
>
> Cc: jasowang@redhat.com
> Cc: armbru@redhat.com
> Cc: berrange@redhat.com
> Cc: armbru@redhat.com
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  net/socket.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/socket.c b/net/socket.c
> index dcae1ae..53765bd 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -449,9 +449,9 @@ static NetSocketState *net_socket_fd_init(NetClientState *peer,
>      case SOCK_STREAM:
>          return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
>      default:
> -        /* who knows ... this could be a eg. a pty, do warn and continue as stream */
> -        fprintf(stderr, "qemu: warning: socket type=%d for fd=%d is not SOCK_DGRAM or SOCK_STREAM\n", so_type, fd);
> -        return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
> +        error_report("qemu: error: socket type=%d for fd=%d is not"
> +                " SOCK_DGRAM or SOCK_STREAM", so_type, fd);
> +        closesocket(fd);
>      }
>      return NULL;
>  }

You don't actually "drop the 'default' case", as your commit message
claims.  Perhaps:

    net/socket: Don't treat odd socket type as SOCK_STREAM

    In net_socket_fd_init(), the 'default' case is odd: it warns, then
    continues as if the socket type was SOCK_STREAM.  The comment
    explains "this could be a eg. a pty", but that makes no sense.  If
    @fd really was a pty, getsockopt() would fail with ENOTSOCK.  If @fd
    was a socket, but neither SOCK_DGRAM nor SOCK_STREAM, it should not
    be treated as if it was SOCK_STREAM.

    Turn this case into an error.  If there is a genuine reason to
    support something like SOCK_RAW, it should be handled explicitly.

With something like that:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
