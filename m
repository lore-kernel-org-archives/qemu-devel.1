Received: from eggs.gnu.org ([2001:4830:134:3::10]:38916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eE8wd-0003Bx-NZ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 02:14:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eE8wa-0004eI-B4
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 02:14:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eE8wa-0004dq-4Y
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 02:14:08 -0500
References: <20171106132805.19986-1-jfreimann@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ad15537b-8a7d-3bca-7ec2-fcd37eea7756@redhat.com>
Date: Mon, 13 Nov 2017 15:13:59 +0800
MIME-Version: 1.0
In-Reply-To: <20171106132805.19986-1-jfreimann@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net/socket: fix coverity issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org



On 2017=E5=B9=B411=E6=9C=8806=E6=97=A5 21:28, Jens Freimann wrote:
> This fixes coverity issue CID1005339.
>
> Make sure that saddr is not used uninitialized if the
> mcast parameter is NULL.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>   net/socket.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/socket.c b/net/socket.c
> index e6b471c63d..51eaea67a0 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -332,7 +332,7 @@ static NetSocketState *net_socket_fd_init_dgram(Net=
ClientState *peer,
>                                                   const char *mcast,
>                                                   Error **errp)
>   {
> -    struct sockaddr_in saddr;
> +    struct sockaddr_in saddr =3D { 0 };
>       int newfd;
>       NetClientState *nc;
>       NetSocketState *s;
> @@ -373,7 +373,7 @@ static NetSocketState *net_socket_fd_init_dgram(Net=
ClientState *peer,
>       net_socket_read_poll(s, true);
>  =20
>       /* mcast: save bound address as dst */
> -    if (is_connected) {
> +    if (is_connected && mcast !=3D NULL) {
>           s->dgram_dst =3D saddr;
>           snprintf(nc->info_str, sizeof(nc->info_str),
>                    "socket: fd=3D%d (cloned mcast=3D%s:%d)",

Applied, thanks.
