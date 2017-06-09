Received: from eggs.gnu.org ([2001:4830:134:3::10]:58509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJJrd-0003Ij-VS
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJJrc-0001ip-VZ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:22:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJJrc-0001id-Pp
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:22:08 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1496924675.git.maozy.fnst@cn.fujitsu.com>
	<92b1a896753cc1b2a1200f5a525bad314152cdd9.1496924675.git.maozy.fnst@cn.fujitsu.com>
Date: Fri, 09 Jun 2017 15:22:05 +0200
In-Reply-To: <92b1a896753cc1b2a1200f5a525bad314152cdd9.1496924675.git.maozy.fnst@cn.fujitsu.com>
	(Mao Zhongyi's message of "Fri, 9 Jun 2017 18:01:45 +0800")
Message-ID: <87shj9i9du.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/4] net/socket: Drop the odd 'default'
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
> index dcae1ae..a503cfe 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -449,9 +449,9 @@ static NetSocketState *net_socket_fd_init(NetClientState *peer,
>      case SOCK_STREAM:
>          return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
>      default:
> -        /* who knows ... this could be a eg. a pty, do warn and continue as stream */
> -        fprintf(stderr, "qemu: warning: socket type=%d for fd=%d is not SOCK_DGRAM or SOCK_STREAM\n", so_type, fd);
> -        return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
> +        fprintf(stderr, "qemu: error: socket type=%d for fd=%d is not"
> +                " SOCK_DGRAM or SOCK_STREAM\n", so_type, fd);
> +        closesocket(fd);
>      }
>      return NULL;
>  }

Please use error_report() here.
