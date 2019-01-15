Received: from eggs.gnu.org ([209.51.188.92]:33636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gjUZ5-0001a6-6U
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:40:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gjUZ4-0001X3-4a
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:39:59 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gjUZ3-0001W6-Us
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:39:58 -0500
Received: by mail-qt1-f195.google.com with SMTP id d19so4345957qtq.9
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 11:39:57 -0800 (PST)
MIME-Version: 1.0
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-7-berrange@redhat.com>
In-Reply-To: <20190115145256.9593-7-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 15 Jan 2019 23:39:45 +0400
Message-ID: <CAMxuvaxfpEiT97VC0UbGip-wjk6HNasONXvhVyLyN8T=phuf0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/12] chardev: remove unused 'sioc'
 variable & cleanup paths
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

On Tue, Jan 15, 2019 at 6:53 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> The 'sioc' variable in qmp_chardev_open_socket was unused since
>
>   commit 3e7d4d20d3a528b1ed10b1dc3d83119bfb0c5f24
>   Author: Peter Xu <peterx@redhat.com>
>   Date:   Tue Mar 6 13:33:17 2018 +0800
>
>     chardev: use chardev's gcontext for async connect
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-socket.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index ba86284ea9..3b6ff6619b 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1073,7 +1073,6 @@ static void qmp_chardev_open_socket(Chardev *chr,
>      bool is_waitconnect =3D sock->has_wait    ? sock->wait    : false;
>      bool is_websock     =3D sock->has_websocket ? sock->websocket : fals=
e;
>      int64_t reconnect   =3D sock->has_reconnect ? sock->reconnect : 0;
> -    QIOChannelSocket *sioc =3D NULL;
>      SocketAddress *addr;
>
>      s->is_listen =3D is_listen;
> @@ -1088,7 +1087,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>          if (!creds) {
>              error_setg(errp, "No TLS credentials with id '%s'",
>                         sock->tls_creds);
> -            goto error;
> +            return;
>          }
>          s->tls_creds =3D (QCryptoTLSCreds *)
>              object_dynamic_cast(creds,
> @@ -1096,20 +1095,20 @@ static void qmp_chardev_open_socket(Chardev *chr,
>          if (!s->tls_creds) {
>              error_setg(errp, "Object with id '%s' is not TLS credentials=
",
>                         sock->tls_creds);
> -            goto error;
> +            return;
>          }
>          object_ref(OBJECT(s->tls_creds));
>          if (is_listen) {
>              if (s->tls_creds->endpoint !=3D QCRYPTO_TLS_CREDS_ENDPOINT_S=
ERVER) {
>                  error_setg(errp, "%s",
>                             "Expected TLS credentials for server endpoint=
");
> -                goto error;
> +                return;
>              }
>          } else {
>              if (s->tls_creds->endpoint !=3D QCRYPTO_TLS_CREDS_ENDPOINT_C=
LIENT) {
>                  error_setg(errp, "%s",
>                             "Expected TLS credentials for client endpoint=
");
> -                goto error;
> +                return;
>              }
>          }
>      }
> @@ -1117,7 +1116,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>      s->addr =3D addr =3D socket_address_flatten(sock->addr);
>
>      if (!qmp_chardev_validate_socket(sock, addr, errp)) {
> -        goto error;
> +        return;
>      }
>
>      qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTABLE);
> @@ -1153,7 +1152,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>              if (qio_net_listener_open_sync(s->listener, s->addr, errp) <=
 0) {
>                  object_unref(OBJECT(s->listener));
>                  s->listener =3D NULL;
> -                goto error;
> +                return;
>              }
>
>              qapi_free_SocketAddress(s->addr);
> @@ -1171,16 +1170,9 @@ static void qmp_chardev_open_socket(Chardev *chr,
>                                                        chr->gcontext);
>              }
>          } else if (qemu_chr_wait_connected(chr, errp) < 0) {
> -            goto error;
> +            return;
>          }
>      }
> -
> -    return;
> -
> -error:
> -    if (sioc) {
> -        object_unref(OBJECT(sioc));
> -    }
>  }
>
>  static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backen=
d,
> --
> 2.20.1
>
