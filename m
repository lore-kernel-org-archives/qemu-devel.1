Received: from eggs.gnu.org ([2001:4830:134:3::10]:48993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWP19-0003ps-Dg
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWP18-00068D-Ph
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:02:19 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:39009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eWP18-00067z-IN
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:02:18 -0500
Received: by mail-wr0-x244.google.com with SMTP id o101so20292774wrb.6
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 08:02:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171228072945.9573-3-peterx@redhat.com>
References: <20171228072945.9573-1-peterx@redhat.com>
	<20171228072945.9573-3-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jan 2018 17:02:16 +0100
Message-ID: <CAJ+F1C+09+gnHo_NFi8sBs+nMcexP0UkuQAxk+wRMpYNP=fXKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] chardev: let g_idle_add() be with
 chardev gcontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Dec 28, 2017 at 8:29 AM, Peter Xu <peterx@redhat.com> wrote:
> The idle task will be attached to main gcontext even if the chardev
> backend is running in another gcontext.  Fix the only caller by
> extending the g_idle_add() logic into the more powerful
> g_source_attach().  It's basically g_idle_add_full() implementation, but
> with the chardev's gcontext passed in.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  chardev/char-pty.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index 761ae6dec1..dd17b1b823 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -210,9 +210,14 @@ static void pty_chr_state(Chardev *chr, int connecte=
d)
>              s->timer_tag =3D 0;
>          }
>          if (!s->connected) {
> +            GSource *source =3D g_idle_source_new();
> +
>              g_assert(s->open_tag =3D=3D 0);
>              s->connected =3D 1;
> -            s->open_tag =3D g_idle_add(qemu_chr_be_generic_open_func, ch=
r);
> +            g_source_set_callback(source, qemu_chr_be_generic_open_func,
> +                                  chr, NULL);
> +            s->open_tag =3D g_source_attach(source, chr->gcontext);
> +            g_source_unref(source);
>          }
>          if (!chr->gsource) {
>              chr->gsource =3D io_add_watch_poll(chr, s->ioc,
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
