Received: from eggs.gnu.org ([2001:4830:134:3::10]:54164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gJzRJ-0008S2-IB
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gJzRH-0006QG-GI
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:22:33 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gJzRH-0006Gw-7n
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:22:31 -0500
Received: by mail-wm1-x342.google.com with SMTP id r63-v6so11092428wma.4
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 03:22:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541421653.git.artem.k.pisarenko@gmail.com>
	<ae16b7e9df62708e0556a13a1efa8aa2628c1c56.1541421653.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <ae16b7e9df62708e0556a13a1efa8aa2628c1c56.1541421653.git.artem.k.pisarenko@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 6 Nov 2018 15:22:11 +0400
Message-ID: <CAJ+F1C+B4swAvyEYvvaeBX=bjtDoPgGPOHq46md7WgSmWGuuhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] tests/test-char: add muxed chardev
 testing for open/close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: artem.k.pisarenko@gmail.com
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Mon, Nov 5, 2018 at 4:47 PM Artem Pisarenko
<artem.k.pisarenko@gmail.com> wrote:
>
> Validate that frontend callbacks for CHR_EVENT_OPENED/CHR_EVENT_CLOSED
> events are being issued when expected and in strictly pairing order.
>
> Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
> ---
>  tests/test-char.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 78 insertions(+), 2 deletions(-)
>
> diff --git a/tests/test-char.c b/tests/test-char.c
> index 831e37f..657cb4c 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -16,6 +16,9 @@ static bool quit;
>
>  typedef struct FeHandler {
>      int read_count;
> +    bool is_open;
> +    int openclose_count;
> +    bool openclose_mismatch;
>      int last_event;
>      char read_buf[128];
>  } FeHandler;
> @@ -49,10 +52,24 @@ static void fe_read(void *opaque, const uint8_t *buf,=
 int size)
>  static void fe_event(void *opaque, int event)
>  {
>      FeHandler *h =3D opaque;
> +    bool new_open_state;
>
>      h->last_event =3D event;
> -    if (event !=3D CHR_EVENT_BREAK) {
> +    switch (event) {
> +    case CHR_EVENT_BREAK:
> +        break;
> +    case CHR_EVENT_OPENED:
> +    case CHR_EVENT_CLOSED:
> +        h->openclose_count++;
> +        new_open_state =3D (event =3D=3D CHR_EVENT_OPENED);
> +        if (h->is_open =3D=3D new_open_state) {
> +            h->openclose_mismatch =3D true;
> +        }
> +        h->is_open =3D new_open_state;
> +        /* no break */
> +    default:
>          quit =3D true;
> +        break;
>      }
>  }
>
> @@ -161,7 +178,7 @@ static void char_mux_test(void)
>      QemuOpts *opts;
>      Chardev *chr, *base;
>      char *data;
> -    FeHandler h1 =3D { 0, }, h2 =3D { 0, };
> +    FeHandler h1 =3D { 0, false, 0, false, }, h2 =3D { 0, false, 0, fals=
e, };

this is unnecessary change, I can drop on commit

>      CharBackend chr_be1, chr_be2;
>
>      opts =3D qemu_opts_create(qemu_find_opts("chardev"), "mux-label",
> @@ -233,6 +250,65 @@ static void char_mux_test(void)
>      g_assert_cmpint(h1.last_event, =3D=3D, CHR_EVENT_BREAK);
>      g_assert_cmpint(h2.last_event, =3D=3D, CHR_EVENT_MUX_OUT);
>
> +    /* open/close state and corresponding events */
> +    g_assert_true(qemu_chr_fe_backend_open(&chr_be1));
> +    g_assert_true(qemu_chr_fe_backend_open(&chr_be2));
> +    g_assert_true(h1.is_open);
> +    g_assert_false(h1.openclose_mismatch);
> +    g_assert_true(h2.is_open);
> +    g_assert_false(h2.openclose_mismatch);
> +
> +    h1.openclose_count =3D h2.openclose_count =3D 0;
> +
> +    qemu_chr_fe_set_handlers(&chr_be1, NULL, NULL, NULL, NULL,
> +                             NULL, NULL, false);
> +    qemu_chr_fe_set_handlers(&chr_be2, NULL, NULL, NULL, NULL,
> +                             NULL, NULL, false);
> +    g_assert_cmpint(h1.openclose_count, =3D=3D, 0);
> +    g_assert_cmpint(h2.openclose_count, =3D=3D, 0);
> +
> +    h1.is_open =3D h2.is_open =3D false;
> +    qemu_chr_fe_set_handlers(&chr_be1,
> +                             NULL,
> +                             NULL,
> +                             fe_event,
> +                             NULL,
> +                             &h1,
> +                             NULL, false);
> +    qemu_chr_fe_set_handlers(&chr_be2,
> +                             NULL,
> +                             NULL,
> +                             fe_event,
> +                             NULL,
> +                             &h2,
> +                             NULL, false);
> +    g_assert_cmpint(h1.openclose_count, =3D=3D, 1);
> +    g_assert_false(h1.openclose_mismatch);
> +    g_assert_cmpint(h2.openclose_count, =3D=3D, 1);
> +    g_assert_false(h2.openclose_mismatch);
> +
> +    qemu_chr_be_event(base, CHR_EVENT_CLOSED);
> +    qemu_chr_be_event(base, CHR_EVENT_OPENED);
> +    g_assert_cmpint(h1.openclose_count, =3D=3D, 3);
> +    g_assert_false(h1.openclose_mismatch);
> +    g_assert_cmpint(h2.openclose_count, =3D=3D, 3);
> +    g_assert_false(h2.openclose_mismatch);
> +
> +    qemu_chr_fe_set_handlers(&chr_be2,
> +                             fe_can_read,
> +                             fe_read,
> +                             fe_event,
> +                             NULL,
> +                             &h2,
> +                             NULL, false);
> +    qemu_chr_fe_set_handlers(&chr_be1,
> +                             fe_can_read,
> +                             fe_read,
> +                             fe_event,
> +                             NULL,
> +                             &h1,
> +                             NULL, false);
> +

otherwise, looks good to me
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>      /* remove first handler */
>      qemu_chr_fe_set_handlers(&chr_be1, NULL, NULL, NULL, NULL,
>                               NULL, NULL, true);
> --
> 2.7.4
>
>


--=20
Marc-Andr=C3=A9 Lureau
