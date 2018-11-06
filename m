Received: from eggs.gnu.org ([2001:4830:134:3::10]:59195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gJzeF-00027B-3k
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gJzeE-0006Wj-6O
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:35:55 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gJzeE-0006Up-02
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:35:54 -0500
Received: by mail-wm1-x341.google.com with SMTP id v24-v6so11119382wmh.3
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 03:35:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541421653.git.artem.k.pisarenko@gmail.com>
	<a0c4014ec4a385affeb1c97fbf77d4cd5fc1c214.1541421653.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <a0c4014ec4a385affeb1c97fbf77d4cd5fc1c214.1541421653.git.artem.k.pisarenko@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 6 Nov 2018 15:35:41 +0400
Message-ID: <CAJ+F1C+op8o1wiCEXn+vQKq6uVW80PzD4BeAATi5PQJUPEhxeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] chardev: fix mess in OPENED/CLOSED
 events when muxed
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

On Mon, Nov 5, 2018 at 4:46 PM Artem Pisarenko
<artem.k.pisarenko@gmail.com> wrote:
>
> When chardev is multiplexed (mux=3Don) there are a lot of cases, when
> CHR_EVENT_OPENED/CHR_EVENT_CLOSED events pairing (expected from
> frontend side) is broken. There are either generation of multiple
> repeated or extra CHR_EVENT_OPENED events, or CHR_EVENT_CLOSED just
> isn't generated at all (when it does with mux=3Doff).
> Fix that.
>
> Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>

I can see that this fixes the mismatch you describe, and the changes
look reasonably simple that I can understand how it works. But if you
could also describe with your own words the "why" it happened and the
"how" you fixed it in the commit message, that would be really helpful
for the future readers (including ourself).

otherwise, patch looks good to me.

Since it's not for 3.1, after you send v3, I will queue those patches
for merge early in 3.2, so we get enough testing.

thanks!

> ---
>  chardev/char-fe.c         | 33 ++++++++++++++++++++++++---------
>  chardev/char-mux.c        | 16 ++++++++--------
>  include/chardev/char-fe.h | 18 +++++++++++++++++-
>  3 files changed, 49 insertions(+), 18 deletions(-)
>
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index a8931f7..b7bcbd5 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -246,14 +246,15 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
>      }
>  }
>
> -void qemu_chr_fe_set_handlers(CharBackend *b,
> -                              IOCanReadHandler *fd_can_read,
> -                              IOReadHandler *fd_read,
> -                              IOEventHandler *fd_event,
> -                              BackendChangeHandler *be_change,
> -                              void *opaque,
> -                              GMainContext *context,
> -                              bool set_open)
> +void qemu_chr_fe_set_handlers_full(CharBackend *b,
> +                                   IOCanReadHandler *fd_can_read,
> +                                   IOReadHandler *fd_read,
> +                                   IOEventHandler *fd_event,
> +                                   BackendChangeHandler *be_change,
> +                                   void *opaque,
> +                                   GMainContext *context,
> +                                   bool set_open,
> +                                   bool sync_state)
>  {
>      Chardev *s;
>      int fe_open;
> @@ -285,7 +286,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
>          qemu_chr_fe_take_focus(b);
>          /* We're connecting to an already opened device, so let's make s=
ure we
>             also get the open event */
> -        if (s->be_open) {
> +        if (sync_state && s->be_open) {
>              qemu_chr_be_event(s, CHR_EVENT_OPENED);
>          }
>      }
> @@ -295,6 +296,20 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
>      }
>  }
>
> +void qemu_chr_fe_set_handlers(CharBackend *b,
> +                              IOCanReadHandler *fd_can_read,
> +                              IOReadHandler *fd_read,
> +                              IOEventHandler *fd_event,
> +                              BackendChangeHandler *be_change,
> +                              void *opaque,
> +                              GMainContext *context,
> +                              bool set_open)
> +{
> +    qemu_chr_fe_set_handlers_full(b, fd_can_read, fd_read, fd_event, be_=
change,
> +                                  opaque, context, set_open,
> +                                  true);
> +}
> +
>  void qemu_chr_fe_take_focus(CharBackend *b)
>  {
>      if (!b->chr) {
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index 6055e76..1199d32 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -283,13 +283,13 @@ void mux_chr_set_handlers(Chardev *chr, GMainContex=
t *context)
>      MuxChardev *d =3D MUX_CHARDEV(chr);
>
>      /* Fix up the real driver with mux routines */
> -    qemu_chr_fe_set_handlers(&d->chr,
> -                             mux_chr_can_read,
> -                             mux_chr_read,
> -                             mux_chr_event,
> -                             NULL,
> -                             chr,
> -                             context, true);
> +    qemu_chr_fe_set_handlers_full(&d->chr,
> +                                  mux_chr_can_read,
> +                                  mux_chr_read,
> +                                  mux_chr_event,
> +                                  NULL,
> +                                  chr,
> +                                  context, true, false);
>  }
>
>  void mux_set_focus(Chardev *chr, int focus)
> @@ -367,7 +367,7 @@ static int open_muxes(Chardev *chr)
>       * mark mux as OPENED so any new FEs will immediately receive
>       * OPENED event
>       */
> -    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +    chr->be_open =3D 1;
>
>      return 0;
>  }
> diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
> index 46c997d..c1b7fd9 100644
> --- a/include/chardev/char-fe.h
> +++ b/include/chardev/char-fe.h
> @@ -67,7 +67,7 @@ bool qemu_chr_fe_backend_connected(CharBackend *be);
>  bool qemu_chr_fe_backend_open(CharBackend *be);
>
>  /**
> - * qemu_chr_fe_set_handlers:
> + * qemu_chr_fe_set_handlers_full:
>   * @b: a CharBackend
>   * @fd_can_read: callback to get the amount of data the frontend may
>   *               receive
> @@ -79,12 +79,28 @@ bool qemu_chr_fe_backend_open(CharBackend *be);
>   * @context: a main loop context or NULL for the default
>   * @set_open: whether to call qemu_chr_fe_set_open() implicitely when
>   * any of the handler is non-NULL
> + * @sync_state: whether to issue event callback with updated state
>   *
>   * Set the front end char handlers. The front end takes the focus if
>   * any of the handler is non-NULL.
>   *
>   * Without associated Chardev, nothing is changed.
>   */
> +void qemu_chr_fe_set_handlers_full(CharBackend *b,
> +                                   IOCanReadHandler *fd_can_read,
> +                                   IOReadHandler *fd_read,
> +                                   IOEventHandler *fd_event,
> +                                   BackendChangeHandler *be_change,
> +                                   void *opaque,
> +                                   GMainContext *context,
> +                                   bool set_open,
> +                                   bool sync_state);
> +
> +/**
> + * qemu_chr_fe_set_handlers:
> + *
> + * Version of qemu_chr_fe_set_handlers_full() with sync_state =3D true.
> + */
>  void qemu_chr_fe_set_handlers(CharBackend *b,
>                                IOCanReadHandler *fd_can_read,
>                                IOReadHandler *fd_read,
> --
> 2.7.4
>
>


--=20
Marc-Andr=C3=A9 Lureau
