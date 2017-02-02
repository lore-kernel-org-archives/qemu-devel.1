Received: from eggs.gnu.org ([2001:4830:134:3::10]:52221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cZJUw-0008S2-01
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:40:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cZJUs-0001Mm-0K
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:40:34 -0500
Received: from mail-eopbgr00112.outbound.protection.outlook.com
	([40.107.0.112]:46240
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1cZJUr-0001MK-Fh
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:40:29 -0500
References: <1486041504-23627-1-git-send-email-den@openvz.org>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <a494fa49-21d3-0d5c-2c77-585843bcc1fd@openvz.org>
Date: Thu, 2 Feb 2017 17:07:28 +0300
MIME-Version: 1.0
In-Reply-To: <1486041504-23627-1-git-send-email-den@openvz.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qemu-char: socket backend:
 disconnect on write error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 02/02/2017 04:18 PM, Denis V. Lunev wrote:
> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>
> Socket backend read handler should normally perform a disconnect, however
> the read handler may not get a chance to run if the frontend is not ready
> (qemu_chr_be_can_write() =3D=3D 0).
>
> This means that in virtio-serial frontend case if
>  - the host has disconnected (giving EPIPE on socket write)
>  - and the guest has disconnected (-> frontend not ready -> backend
>    will not read)
>  - and there is still data (frontend->backend) to flush (has to be a real=
ly
>    tricky timing but nevertheless, we have observed the case in productio=
n)
>
> This results in virtio-serial trying to flush this data continiously form=
ing
> a busy loop.
>
> Solution: react on write error in the socket write handler.
> errno is not reliable after qio_channel_writev_full(), so we may not get
> the exact EPIPE, so disconnect on any error but QIO_CHANNEL_ERR_BLOCK whi=
ch
> io_channel_send_full() converts to errno EAGAIN.
> We must not disconnect right away though, there still may be data to read
> (see 4bf1cb0).
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Daniel P. Berrange <berrange@redhat.com>
> CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
> Changes from v1:
> - we do not rely on EPIPE anynore. Socket should be closed on all errors
>   except EAGAIN
>
>  chardev/char-socket.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 4068dc5..e2137aa 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -97,6 +97,9 @@ static gboolean tcp_chr_accept(QIOChannel *chan,
>                                 GIOCondition cond,
>                                 void *opaque);
> =20
> +static int tcp_chr_read_poll(void *opaque);
> +static void tcp_chr_disconnect(CharDriverState *chr);
> +
>  /* Called with chr_write_lock held.  */
>  static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
>  {
> @@ -114,6 +117,13 @@ static int tcp_chr_write(Chardev *chr, const uint8_t=
 *buf, int len)
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
pls disregard. I am very sorry. This patch was made against all version
and will not compile.

Den
