Received: from eggs.gnu.org ([2001:4830:134:3::10]:38491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gMm8H-0006CB-UZ
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 22:46:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gMm8C-0000FY-5L
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 22:46:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gMm8B-0000F8-T6
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 22:46:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C36C380F91
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 03:46:18 +0000 (UTC)
References: <20181109195653.11867-1-marcandre.lureau@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <dcc8d960-e970-b8b9-f17c-8cba0c871d0b@redhat.com>
Date: Wed, 14 Nov 2018 11:46:14 +0800
MIME-Version: 1.0
In-Reply-To: <20181109195653.11867-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] RFC: net/socket: learn to talk with a unix
 dgram socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: rjones@redhat.com


On 2018/11/10 =E4=B8=8A=E5=8D=883:56, Marc-Andr=C3=A9 Lureau wrote:
> -net socket has a fd argument, and may be passed pre-opened sockets.
>
> TCP sockets use framing.
> UDP sockets have datagram boundaries.
>
> When given a unix dgram socket, it will be able to read from it, but
> will attempt to send on the dgram_dst, which is unset. The other end
> will not receive the data.
>
> Let's teach -net socket to recognize a UNIX DGRAM socket, and use the
> regular send() command (without dgram_dst).
>
> This makes running slirp out-of-process possible that
> way (python pseudo-code):
>
> a, b =3D socket.socketpair(socket.AF_UNIX, socket.SOCK_DGRAM)
>
> subprocess.Popen('qemu -net socket,fd=3D%d -net user' % a.fileno(), she=
ll=3DTrue)
> subprocess.Popen('qemu ... -net nic -net socket,fd=3D%d' % b.fileno(), =
shell=3DTrue)
>
> (to make slirp a seperate project altogether, we would have to have
> some compatibility code and/or deprecate various options & HMP
> commands for dynamic port forwarding etc - but this looks like a
> reachable goal)
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


I believe instead of supporting unnamed sockets, we should also support=20
named one through cli?


> ---
>   net/socket.c | 25 +++++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/net/socket.c b/net/socket.c
> index 7095eb749f..8a9c30892d 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -119,9 +119,13 @@ static ssize_t net_socket_receive_dgram(NetClientS=
tate *nc, const uint8_t *buf,
>       ssize_t ret;
>  =20
>       do {
> -        ret =3D qemu_sendto(s->fd, buf, size, 0,
> -                          (struct sockaddr *)&s->dgram_dst,
> -                          sizeof(s->dgram_dst));
> +        if (s->dgram_dst.sin_family !=3D AF_UNIX) {
> +            ret =3D qemu_sendto(s->fd, buf, size, 0,
> +                              (struct sockaddr *)&s->dgram_dst,
> +                              sizeof(s->dgram_dst));
> +        } else {
> +            ret =3D send(s->fd, buf, size, 0);
> +        }


Any reason that send is a must here? send(2) said:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 call

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 send(sockfd=
, buf, len, flags);

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is equivalent to

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sendto(sock=
fd, buf, len, flags, NULL, 0);


Thanks


>       } while (ret =3D=3D -1 && errno =3D=3D EINTR);
>  =20
>       if (ret =3D=3D -1 && errno =3D=3D EAGAIN) {
> @@ -322,6 +326,15 @@ static NetSocketState *net_socket_fd_init_dgram(Ne=
tClientState *peer,
>       int newfd;
>       NetClientState *nc;
>       NetSocketState *s;
> +    SocketAddress *sa;
> +    SocketAddressType sa_type;
> +
> +    sa =3D socket_local_address(fd, errp);
> +    if (!sa) {
> +        return NULL;
> +    }
> +    sa_type =3D sa->type;
> +    qapi_free_SocketAddress(sa);
>  =20
>       /* fd passed: multicast: "learn" dgram_dst address from bound add=
ress and save it
>        * Because this may be "shared" socket from a "master" process, d=
atagrams would be recv()
> @@ -365,8 +378,12 @@ static NetSocketState *net_socket_fd_init_dgram(Ne=
tClientState *peer,
>                    "socket: fd=3D%d (cloned mcast=3D%s:%d)",
>                    fd, inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port)=
);
>       } else {
> +        if (sa_type =3D=3D SOCKET_ADDRESS_TYPE_UNIX) {
> +            s->dgram_dst.sin_family =3D AF_UNIX;
> +        }
> +
>           snprintf(nc->info_str, sizeof(nc->info_str),
> -                 "socket: fd=3D%d", fd);
> +                 "socket: fd=3D%d %s", fd, SocketAddressType_str(sa_ty=
pe));
>       }
>  =20
>       return s;
