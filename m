Received: from eggs.gnu.org ([2001:4830:134:3::10]:57951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eyJyT-0002KX-96
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eyJyS-0001um-7p
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:18:57 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eyJyS-0001uH-1L
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:18:56 -0400
Received: by mail-wr0-x242.google.com with SMTP id 80so1218636wrb.2
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 09:18:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180320151857.26340-1-pbonzini@redhat.com>
References: <20180320151857.26340-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 20 Mar 2018 17:18:54 +0100
Message-ID: <CAJ+F1CLc=tN0kDnJmzEbSL6KUYRiRB5_Pd_LGxF84iPo5EWQpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev-socket: remove useless if
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Tue, Mar 20, 2018 at 4:18 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> This trips Coverity, which believes the subsequent qio_channel_create_wat=
ch
> can dereference a NULL pointer.  In reality, tcp_chr_connect's callers
> all have s->ioc properly initialized, since they are all rooted at
> tcp_chr_new_client.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>  chardev/char-socket.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index d057192ced..159e69c3b1 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -550,12 +550,10 @@ static void tcp_chr_connect(void *opaque)
>          s->is_listen, s->is_telnet);
>
>      s->connected =3D 1;
> -    if (s->ioc) {
> -        chr->gsource =3D io_add_watch_poll(chr, s->ioc,
> -                                           tcp_chr_read_poll,
> -                                           tcp_chr_read,
> -                                           chr, chr->gcontext);
> -    }
> +    chr->gsource =3D io_add_watch_poll(chr, s->ioc,
> +                                       tcp_chr_read_poll,
> +                                       tcp_chr_read,
> +                                       chr, chr->gcontext);
>
>      s->hup_source =3D qio_channel_create_watch(s->ioc, G_IO_HUP);
>      g_source_set_callback(s->hup_source, (GSourceFunc)tcp_chr_hup,
> --
> 2.16.2
>
>



--=20
Marc-Andr=C3=A9 Lureau
