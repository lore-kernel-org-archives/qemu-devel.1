Received: from eggs.gnu.org ([209.51.188.92]:34690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjdaZ-0001vL-0n
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:18:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjdUT-0008Ug-59
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:11:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjdUS-0008SN-IL
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:11:48 -0500
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6fcdecb2-118a-0f7c-fc4b-a03226846739@redhat.com>
Date: Wed, 16 Jan 2019 06:11:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190115145256.9593-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/12] chardev: forbid 'reconnect' option
 with server sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Yongji Xie <elohimes@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 2019-01-15 15:52, Daniel P. Berrang=C3=A9 wrote:
> The 'reconnect' option is used to give the sleep time, in seconds,
> before a client socket attempts to re-establish a connection to the
> server. It does not make sense to set this for server sockets, as they
> will always accept a new client connection immediately after the
> previous one went away.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  chardev/char-socket.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 6669acb35f..4570755adf 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1035,7 +1035,14 @@ static bool qmp_chardev_validate_socket(ChardevS=
ocket *sock,
>      }
> =20
>      /* Validate any options which have a dependancy on client vs serve=
r */
> -    if (!(sock->has_server && sock->server)) {
> +    if (!sock->has_server || sock->server) {
> +        if (sock->has_reconnect) {
> +            error_setg(errp,
> +                       "'reconnect' option is incompatible with "
> +                       "socket in server listen mode");
> +            return false;
> +        }
> +    } else {
>          if (sock->has_websocket && sock->websocket) {
>              error_setg(errp, "%s", "Websocket client is not implemente=
d");
>              return false;
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
