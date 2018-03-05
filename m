Received: from eggs.gnu.org ([2001:4830:134:3::10]:45782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1esob7-00013x-UT
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:48:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1esob4-0007lA-R4
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:48:05 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1esob4-0007kk-Ls
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:48:02 -0500
Received: by mail-qt0-f196.google.com with SMTP id v90so19889393qte.12
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 03:48:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180305065040.10353-4-peterx@redhat.com>
References: <20180305065040.10353-1-peterx@redhat.com>
	<20180305065040.10353-4-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 5 Mar 2018 12:48:01 +0100
Message-ID: <CAMxuvaz1F=AscsWjrVhAk2dmz2gHbmsaWt5u18NiDLE8cHJ0LQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/9] chardev: update net listener gcontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On Mon, Mar 5, 2018 at 7:50 AM, Peter Xu <peterx@redhat.com> wrote:
> TCP chardevs can be using QIO network listeners working in the
> background when in listening mode.  However the network listeners are
> always running in main context.  This can race with chardevs that are
> running in non-main contexts.
>
> To solve this, we need to re-setup the net listeners in
> tcp_chr_update_read_handler() with the newly cached gcontext.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  chardev/char-socket.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 205ee377a4..5aa01e15ff 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -422,8 +422,8 @@ static void tcp_chr_disconnect(Chardev *chr)
>      tcp_chr_free_connection(chr);
>
>      if (s->listener) {
> -        qio_net_listener_set_client_func(s->listener, tcp_chr_accept,
> -                                         chr, NULL);
> +        qio_net_listener_set_client_func_full(s->listener, tcp_chr_accep=
t,
> +                                              chr, NULL, chr->gcontext);
>      }
>      update_disconnected_filename(s);
>      if (emit_close) {
> @@ -559,6 +559,16 @@ static void tcp_chr_update_read_handler(Chardev *chr=
)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
>
> +    if (s->listener) {
> +        /*
> +         * It's possible that chardev context is changed in
> +         * qemu_chr_be_update_read_handlers().  Reset it for QIO net
> +         * listener if there is.
> +         */
> +        qio_net_listener_set_client_func_full(s->listener, tcp_chr_accep=
t,
> +                                              chr, NULL, chr->gcontext);
> +    }
> +
>      if (!s->connected) {
>          return;
>      }
> @@ -743,7 +753,8 @@ static int tcp_chr_new_client(Chardev *chr, QIOChanne=
lSocket *sioc)
>          qio_channel_set_delay(s->ioc, false);
>      }
>      if (s->listener) {
> -        qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
> +        qio_net_listener_set_client_func_full(s->listener, NULL, NULL,
> +                                              NULL, chr->gcontext);
>      }
>
>      if (s->tls_creds) {
> @@ -824,7 +835,8 @@ static void char_socket_finalize(Object *obj)
>      tcp_chr_reconn_timer_cancel(s);
>      qapi_free_SocketAddress(s->addr);
>      if (s->listener) {
> -        qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
> +        qio_net_listener_set_client_func_full(s->listener, NULL, NULL,
> +                                              NULL, chr->gcontext);
>          object_unref(OBJECT(s->listener));
>      }
>      if (s->tls_creds) {
> @@ -980,8 +992,10 @@ static void qmp_chardev_open_socket(Chardev *chr,
>                  return;
>              }
>              if (!s->ioc) {
> -                qio_net_listener_set_client_func(s->listener, tcp_chr_ac=
cept,
> -                                                 chr, NULL);
> +                qio_net_listener_set_client_func_full(s->listener,
> +                                                      tcp_chr_accept,
> +                                                      chr, NULL,
> +                                                      chr->gcontext);
>              }
>          } else if (qemu_chr_wait_connected(chr, errp) < 0) {
>              goto error;
> --
> 2.14.3
>
