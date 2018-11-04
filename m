Received: from eggs.gnu.org ([2001:4830:134:3::10]:41592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gJIx9-0005UF-86
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 09:00:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gJIx4-0004VJ-4d
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 09:00:35 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gJIx2-0004Km-9K
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 09:00:29 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so10504515qkf.13
	for <qemu-devel@nongnu.org>; Sun, 04 Nov 2018 06:00:23 -0800 (PST)
MIME-Version: 1.0
References: <0084f7223c080cdbdfc2c5a2d132f8d6c0eff866.1541083966.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <0084f7223c080cdbdfc2c5a2d132f8d6c0eff866.1541083966.git.artem.k.pisarenko@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 4 Nov 2018 18:00:11 +0400
Message-ID: <CAMxuvazxmYdvn_0aTH0ETt_Eeo7rxCLXvZ_oANfcKhgGW92+ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev: fix mess in OPENED/CLOSED events
 when muxed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: artem.k.pisarenko@gmail.com
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>

Hi
On Thu, Nov 1, 2018 at 6:55 PM Artem Pisarenko
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
> ---
>
> Notes:
>     This issue actually more complex. Idea of generating events from insi=
de function called '*_set_handlers' isn't good, at least its implicit natur=
e, and especially a fact, that function decides about open state (see 'fe_o=
pen' variable), but generates event only in one direction. Combined with 'm=
ux_chr_set_handlers()' hack this makes things even worse.
>     Better solution is to change fe interface and rewrite all frontends c=
ode (a lot of stuff in hw/char/* and somewhere else).
>     Although this patch doesn't fix any issue/bug (known to me), it preve=
nts them in future. Also it optimizes emulation performance by avoiding ext=
ra activity.
>     I did several trivial tests on x86_64 target and seems like nothing b=
roken.

I am a bit reluctant to take patches that don't actually "fix" things.

Could you add some tests to demonstrate the problems?



>
>  chardev/char-fe.c          |  9 ++++++---
>  chardev/char-mux.c         | 13 ++++++++-----
>  include/chardev/char-mux.h |  2 +-
>  3 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index a8931f7..31cf7f0 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -257,6 +257,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
>  {
>      Chardev *s;
>      int fe_open;
> +    static __thread bool mux_reentered;

Not very elegant. Maybe mux_chr_set_handlers() could call a refactored
internal chr_fe_set_handlers() with an extra arg "no_open_event" ?

>
>      s =3D b->chr;
>      if (!s) {
> @@ -284,14 +285,16 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
>      if (fe_open) {
>          qemu_chr_fe_take_focus(b);
>          /* We're connecting to an already opened device, so let's make s=
ure we
> -           also get the open event */
> -        if (s->be_open) {
> +           also get the open event (hack: except when chardev is muxed) =
*/
> +        if (s->be_open && !mux_reentered) {
>              qemu_chr_be_event(s, CHR_EVENT_OPENED);
>          }
>      }
>
>      if (CHARDEV_IS_MUX(s)) {
> -        mux_chr_set_handlers(s, context);
> +        mux_reentered =3D true;
> +        mux_chr_set_handlers(s, fe_open, context);
> +        mux_reentered =3D false;
>      }
>  }
>
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index 6055e76..9244802 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -272,21 +272,24 @@ static void char_mux_finalize(Object *obj)
>      for (i =3D 0; i < d->mux_cnt; i++) {
>          CharBackend *be =3D d->backends[i];
>          if (be) {
> +            if (be->chr && be->chr->be_open) {
> +                qemu_chr_be_event(be->chr, CHR_EVENT_CLOSED);
> +            }

It looks like this could be a seperate patch, with a seperate test.

>              be->chr =3D NULL;
>          }
>      }
>      qemu_chr_fe_deinit(&d->chr, false);
>  }
>
> -void mux_chr_set_handlers(Chardev *chr, GMainContext *context)
> +void mux_chr_set_handlers(Chardev *chr, bool is_open, GMainContext *cont=
ext)
>  {
>      MuxChardev *d =3D MUX_CHARDEV(chr);
>
>      /* Fix up the real driver with mux routines */
>      qemu_chr_fe_set_handlers(&d->chr,
> -                             mux_chr_can_read,
> -                             mux_chr_read,
> -                             mux_chr_event,
> +                             is_open ? mux_chr_can_read : NULL,
> +                             is_open ? mux_chr_read : NULL,
> +                             is_open ? mux_chr_event : NULL,

same

>                               NULL,
>                               chr,
>                               context, true);
> @@ -367,7 +370,7 @@ static int open_muxes(Chardev *chr)
>       * mark mux as OPENED so any new FEs will immediately receive
>       * OPENED event
>       */
> -    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +    chr->be_open =3D 1;
>
>      return 0;
>  }
> diff --git a/include/chardev/char-mux.h b/include/chardev/char-mux.h
> index 1e13187..4b4df6e 100644
> --- a/include/chardev/char-mux.h
> +++ b/include/chardev/char-mux.h
> @@ -55,7 +55,7 @@ typedef struct MuxChardev {
>  #define CHARDEV_IS_MUX(chr)                             \
>      object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
>
> -void mux_chr_set_handlers(Chardev *chr, GMainContext *context);
> +void mux_chr_set_handlers(Chardev *chr, bool is_open, GMainContext *cont=
ext);
>  void mux_set_focus(Chardev *chr, int focus);
>  void mux_chr_send_all_event(Chardev *chr, int event);
>
> --
> 2.7.4

thanks!
