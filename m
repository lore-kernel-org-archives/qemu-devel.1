Received: from eggs.gnu.org ([209.51.188.92]:52556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gjWAR-00039B-Je
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:22:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gjWAA-0006Sw-CS
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:22:29 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gjWA9-0006QV-4i
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:22:21 -0500
Received: by mail-qt1-f194.google.com with SMTP id r14so4785100qtp.1
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 13:22:20 -0800 (PST)
MIME-Version: 1.0
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-11-berrange@redhat.com>
In-Reply-To: <20190115145256.9593-11-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 16 Jan 2019 01:22:08 +0400
Message-ID: <CAMxuvaz_Ywpq257mcwhZbuUN42=p01eG=ds9k0Xf0aQH1h8KqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/12] chardev: honour the reconnect
 setting in tcp_chr_wait_connected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Yongji Xie <elohimes@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Tue, Jan 15, 2019 at 6:54 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> If establishing a client connection fails, the tcp_chr_wait_connected
> method should sleep for the reconnect timeout and then retry the
> attempt. This ensures the callers don't immediately abort with an
> error when the initial connection fails.

Obviously, that function is already a bit problematic, since it may
block the thread with no easy way to cancel (well, the _sync functions
in general..).

You change doesn't make it much worse, but it will now loop also in
case of errors. That's what reconnect_time is supposed to do, so

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  chardev/char-socket.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 96a60eb105..91d775e9c5 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -957,8 +957,15 @@ static int tcp_chr_wait_connected(Chardev *chr, Erro=
r **errp)
>          if (s->is_listen) {
>              tcp_chr_accept_server_sync(chr);
>          } else {
> -            if (tcp_chr_connect_client_sync(chr, errp) < 0) {
> -                return -1;
> +            Error *err =3D NULL;
> +            if (tcp_chr_connect_client_sync(chr, &err) < 0) {
> +                if (s->reconnect_time) {
> +                    error_free(err);
> +                    g_usleep(s->reconnect_time);
> +                } else {
> +                    error_propagate(errp, err);
> +                    return -1;
> +                }
>              }
>          }
>      }
> --
> 2.20.1
>
