Received: from eggs.gnu.org ([208.118.235.92]:56398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ehRiE-0007X9-3O
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 22:09:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ehRcI-0006Az-7h
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 22:03:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ehRcH-00068x-RH
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 22:02:18 -0500
References: <1517473228-8402-1-git-send-email-whois.zihan.yang@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c09a3dc1-fd15-5537-849a-2eda6b95e71e@redhat.com>
Date: Fri, 2 Feb 2018 11:02:10 +0800
MIME-Version: 1.0
In-Reply-To: <1517473228-8402-1-git-send-email-whois.zihan.yang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net/socket: change net_socket_listen_init
 to use qemu-socket functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org



On 2018=E5=B9=B402=E6=9C=8801=E6=97=A5 16:20, Zihan Yang wrote:
> net_socket_listen_init directly uses parse_host_port, bind and listen,
> change it to use functions in include/qemu/sockets.h
>
> Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
> ---
>   net/socket.c | 30 +++++++++---------------------
>   1 file changed, 9 insertions(+), 21 deletions(-)
>
> diff --git a/net/socket.c b/net/socket.c
> index 6917fbc..e4b1f47 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -494,36 +494,24 @@ static int net_socket_listen_init(NetClientState =
*peer,
>   {
>       NetClientState *nc;
>       NetSocketState *s;
> -    struct sockaddr_in saddr;
> -    int fd, ret;
> +    SocketAddress *saddr;
> +    Error *local_err =3D NULL;
> +    int fd;
>  =20
> -    if (parse_host_port(&saddr, host_str, errp) < 0) {
> +    saddr =3D socket_parse(host_str, &local_err);
> +    if (NULL !=3D local_err) {
> +        error_setg_errno(errp, errno, "socket_parse failed");
>           return -1;
>       }
>  =20
> -    fd =3D qemu_socket(PF_INET, SOCK_STREAM, 0);
> +    fd =3D socket_listen(saddr, errp);
>       if (fd < 0) {
> -        error_setg_errno(errp, errno, "can't create stream socket");
> +        error_setg_errno(errp, errno, "can't listen on address");
> +        qapi_free_SocketAddress(saddr);
>           return -1;
>       }
>       qemu_set_nonblock(fd);
>  =20
> -    socket_set_fast_reuse(fd);
> -
> -    ret =3D bind(fd, (struct sockaddr *)&saddr, sizeof(saddr));
> -    if (ret < 0) {
> -        error_setg_errno(errp, errno, "can't bind ip=3D%s to socket",
> -                         inet_ntoa(saddr.sin_addr));
> -        closesocket(fd);
> -        return -1;
> -    }
> -    ret =3D listen(fd, 0);
> -    if (ret < 0) {
> -        error_setg_errno(errp, errno, "can't listen on socket");
> -        closesocket(fd);
> -        return -1;
> -    }
> -
>       nc =3D qemu_new_net_client(&net_socket_info, peer, model, name);
>       s =3D DO_UPCAST(NetSocketState, nc, nc);
>       s->fd =3D -1;

This allows more kinds of socket to be created with listen=3D e.g unix=20
domain socket or vsock but it doesn't allow such kinds of socket to be=20
created with connect=3D.

And change to use socket_()* is tricky especially the connect part. You=20
may have a look at:

6701e5514bea Revert "Change net/socket.c to use socket_*() functions" aga=
in
616018352c24 Revert "Change net/socket.c to use socket_*() functions"

Thanks
