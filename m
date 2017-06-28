Received: from eggs.gnu.org ([2001:4830:134:3::10]:55909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQCs1-0002ll-SE
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQCry-0004XD-NW
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:19:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dQCry-0004Wq-GL
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:18:58 -0400
Date: Wed, 28 Jun 2017 14:18:52 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170628131852.GH29134@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1498654240.git.maozy.fnst@cn.fujitsu.com>
	<d9660b46628b52aa8c63c21fe20618b5bc33bb4c.1498654240.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9660b46628b52aa8c63c21fe20618b5bc33bb4c.1498654240.git.maozy.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/4] net/socket: Don't treat odd socket
 type as SOCK_STREAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, armbru@redhat.com

On Wed, Jun 28, 2017 at 09:08:47PM +0800, Mao Zhongyi wrote:
> In net_socket_fd_init(), the 'default' case is odd: it warns,
> then continues as if the socket type was SOCK_STREAM. The
> comment explains "this could be a eg. a pty", but that makes
> no sense. If @fd really was a pty, getsockopt() would fail
> with ENOTSOCK. If @fd was a socket, but neither SOCK_DGRAM nor
> SOCK_STREAM. It should not be treated as if it was SOCK_STREAM.
> 
> Turn this case into an Error. If there is a genuine reason to
> support something like SOCK_RAW, it should be explicitly
> handled.
> 
> Cc: jasowang@redhat.com
> Cc: armbru@redhat.com
> Cc: berrange@redhat.com
> Cc: armbru@redhat.com
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
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

Please drop the 'qemu: error: ' prefix on the message

Also, rather than 'is not' I suggest 'must be either'


> +        closesocket(fd);
>      }
>      return NULL;
>  }


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
