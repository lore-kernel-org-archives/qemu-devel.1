Received: from eggs.gnu.org ([2001:4830:134:3::10]:45843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1esobQ-0001JT-DB
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1esobN-0007q3-Bx
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:48:24 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1esobN-0007pl-6m
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:48:21 -0500
Received: by mail-qk0-f196.google.com with SMTP id j4so20145273qke.10
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 03:48:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180305065040.10353-3-peterx@redhat.com>
References: <20180305065040.10353-1-peterx@redhat.com>
	<20180305065040.10353-3-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 5 Mar 2018 12:48:20 +0100
Message-ID: <CAMxuvaxoDjz5zUpeMB9wNEzG4vdFNBEbatHUyQVa6Zxsbs3vAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/9] chardev: fix leak in
 tcp_chr_telnet_init_io()
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
> Need to free TCPChardevTelnetInit when session established.
>
> Since at it, switch to use G_SOURCE_* macros.
>
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  chardev/char-socket.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 113feaf948..205ee377a4 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -591,19 +591,23 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *=
ioc,
>              ret =3D 0;
>          } else {
>              tcp_chr_disconnect(init->chr);
> -            return FALSE;
> +            goto end;
>          }
>      }
>      init->buflen -=3D ret;
>
>      if (init->buflen =3D=3D 0) {
>          tcp_chr_connect(init->chr);
> -        return FALSE;
> +        goto end;
>      }
>
>      memmove(init->buf, init->buf + ret, init->buflen);
>
> -    return TRUE;
> +    return G_SOURCE_CONTINUE;
> +
> +end:
> +    g_free(init);
> +    return G_SOURCE_REMOVE;
>  }
>
>  static void tcp_chr_telnet_init(Chardev *chr)
> --
> 2.14.3
>
