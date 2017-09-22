Received: from eggs.gnu.org ([2001:4830:134:3::10]:50174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dvJOO-0003sC-0f
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dvJOK-0008SX-Tj
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:33:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dvJOK-0008SB-Nj
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:32:56 -0400
References: <20170922080435.27342-1-jfreimann@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bef3e3f3-e5a6-5e00-64d8-211b89d396b4@redhat.com>
Date: Fri, 22 Sep 2017 16:32:47 +0800
MIME-Version: 1.0
In-Reply-To: <20170922080435.27342-1-jfreimann@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: fix check for number of parameters to
 -netdev socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>, qemu-devel@nongnu.org
Cc: maozy.fnst@cn.fujitsu.com



On 2017=E5=B9=B409=E6=9C=8822=E6=97=A5 16:04, Jens Freimann wrote:
> Since commit 0f8c289ad "net: fix -netdev socket,fd=3D for UDP sockets"
> we allow more than one parameter for -netdev socket. But now
> we run into an assert when no parameter at all is specified
>
>> qemu-system-x86_64 -netdev socket
> socket.c:729: net_init_socket: Assertion `sock->has_udp' failed.
>
> Change the check and error message to reflect that at least
> one of the options has to be specified. An example for when we need
> more than on is when we hand in a UDP socket. Then we have fd=3D and ud=
p=3D
> as parameters.
>
> Cc: Jason Wang <jasowang@redhat.com>
> Fixes: 0f8c289ad539feb5135c545bea947b310a893f4b
> Reported-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>   net/socket.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/socket.c b/net/socket.c
> index e6b471c63d..0a987bcf4f 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -695,9 +695,9 @@ int net_init_socket(const Netdev *netdev, const cha=
r *name,
>       assert(netdev->type =3D=3D NET_CLIENT_DRIVER_SOCKET);
>       sock =3D &netdev->u.socket;
>  =20
> -    if (sock->has_listen + sock->has_connect + sock->has_mcast +
> -        sock->has_udp > 1) {
> -        error_setg(errp, "exactly one of listen=3D, connect=3D, mcast=3D=
 or udp=3D"
> +    if (sock->has_fd + sock->has_listen + sock->has_connect + sock->ha=
s_mcast +
> +        sock->has_udp =3D=3D 0) {
> +        error_setg(errp, "at least one of fd=3D, listen=3D, connect=3D=
, mcast=3D or udp=3D"
>                      " is required");
>           return -1;
>       }

Looks like this allows "listen" and "connect" to be used in the same=20
time which is wrong I think?

Thanks
