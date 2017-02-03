Received: from eggs.gnu.org ([2001:4830:134:3::10]:56812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZj4h-0006cG-HF
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:59:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZj4d-0007Kg-0f
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:59:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cZj4c-0007KV-OT
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:59:06 -0500
References: <1486045589-8074-1-git-send-email-den@openvz.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <39302e65-dc18-724f-df66-80c848832719@redhat.com>
Date: Fri, 3 Feb 2017 10:59:00 -0800
MIME-Version: 1.0
In-Reply-To: <1486045589-8074-1-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/1] qemu-char: socket backend:
 disconnect on write error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Daniel P . Berrange" <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>



On 02/02/2017 06:26, Denis V. Lunev wrote:
> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>=20
> Socket backend read handler should normally perform a disconnect, howev=
er
> the read handler may not get a chance to run if the frontend is not rea=
dy
> (qemu_chr_be_can_write() =3D=3D 0).
>=20
> This means that in virtio-serial frontend case if
>  - the host has disconnected (giving EPIPE on socket write)
>  - and the guest has disconnected (-> frontend not ready -> backend
>    will not read)
>  - and there is still data (frontend->backend) to flush (has to be a re=
ally
>    tricky timing but nevertheless, we have observed the case in product=
ion)
>=20
> This results in virtio-serial trying to flush this data continiously fo=
rming
> a busy loop.
>=20
> Solution: react on write error in the socket write handler.
> errno is not reliable after qio_channel_writev_full(), so we may not ge=
t
> the exact EPIPE, so disconnect on any error but QIO_CHANNEL_ERR_BLOCK w=
hich
> io_channel_send_full() converts to errno EAGAIN.
> We must not disconnect right away though, there still may be data to re=
ad
> (see 4bf1cb0).
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Daniel P. Berrange <berrange@redhat.com>
> CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
> Changes from v2:
> - fixed prototype of tcp_chr_disconnect
>=20
> Changes from v1:
> - we do not rely on EPIPE anynore. Socket should be closed on all error=
s
>   except EAGAIN
>=20
>  chardev/char-socket.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 4068dc5..865c527 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -97,6 +97,9 @@ static gboolean tcp_chr_accept(QIOChannel *chan,
>                                 GIOCondition cond,
>                                 void *opaque);
> =20
> +static int tcp_chr_read_poll(void *opaque);
> +static void tcp_chr_disconnect(Chardev *chr);
> +
>  /* Called with chr_write_lock held.  */
>  static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
>  {
> @@ -114,6 +117,13 @@ static int tcp_chr_write(Chardev *chr, const uint8=
_t *buf, int len)
>              s->write_msgfds_num =3D 0;
>          }
> =20
> +        if (ret < 0 && errno !=3D EAGAIN) {
> +            if (tcp_chr_read_poll(chr) <=3D 0) {
> +                tcp_chr_disconnect(chr);
> +                return len;
> +            } /* else let the read handler finish it properly */
> +        }
> +
>          return ret;
>      } else {
>          /* XXX: indicate an error ? */
>=20

Queued, thanks.

Paolo
