Received: from eggs.gnu.org ([2001:4830:134:3::10]:41594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ebqTE-0003zf-MG
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ebqT9-0006ZA-0r
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:21:48 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:44345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ebqT8-0006YZ-Pg
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:21:42 -0500
Received: by mail-wr0-x241.google.com with SMTP id w50so19474330wrc.11
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 08:21:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516112253-14480-9-git-send-email-pbonzini@redhat.com>
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
	<1516112253-14480-9-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 17 Jan 2018 17:21:40 +0100
Message-ID: <CAJ+F1CL9Zno3VGjqavPBXz3p1e_iTSLvi6+PYG2nkUazVaFFVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 08/51] chardev: introduce
 qemu_chr_timeout_add_ms()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

Hi

On Tue, Jan 16, 2018 at 3:16 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> From: Peter Xu <peterx@redhat.com>
>
> It's a replacement of g_timeout_add[_seconds]() for chardevs.  Chardevs
> now can have dedicated gcontext, we should always bind chardev tasks
> onto those gcontext rather than the default main context.  Since there
> are quite a few of g_timeout_add[_seconds]() callers, a new function
> qemu_chr_timeout_add_ms() is introduced.
>
> One thing to mention is that, terminal3270 is still always running on
> main gcontext.  However let's convert that as well since it's still part
> of chardev codes and in case one day we'll miss that when we move it out
> of main gcontext too.
>
> Also, convert all the timers from GSource tags into GSource pointers.
> Gsource tag IDs and g_source_remove()s can only work with default
> gcontext, while now these GSources can logically be attached to other
> contexts.  So let's use explicit g_source_destroy() plus another
> g_source_unref() to remove a timer.
>
> Note: when in the timer handler, we don't need the g_source_destroy()
> any more since that'll be done automatically if the timer handler
> returns false (and that's what all the current handlers do).
>
> Yet another note: in pty_chr_rearm_timer() we take special care for
> ms=3D1000.  This patch merged the two cases into one.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Message-Id: <20180104141835.17987-4-peterx@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  chardev/char-pty.c     | 43 +++++++++++++++++++------------------------
>  chardev/char-socket.c  | 28 ++++++++++++++++++----------
>  chardev/char.c         | 18 ++++++++++++++++++
>  hw/char/terminal3270.c | 28 ++++++++++++++++------------
>  include/chardev/char.h |  3 +++
>  5 files changed, 74 insertions(+), 46 deletions(-)
>
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index 8248e36..89315e6 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -42,7 +42,7 @@ typedef struct {
>
>      /* Protected by the Chardev chr_write_lock.  */
>      int connected;
> -    guint timer_tag;
> +    GSource *timer_src;
>      GSource *open_source;
>  } PtyChardev;
>
> @@ -57,7 +57,8 @@ static gboolean pty_chr_timer(gpointer opaque)
>      PtyChardev *s =3D PTY_CHARDEV(opaque);
>
>      qemu_mutex_lock(&chr->chr_write_lock);
> -    s->timer_tag =3D 0;
> +    s->timer_src =3D NULL;
> +    g_source_unref(s->open_source);

why that line ^ ? It adds criticals every second (for ex with -chardev
pty,id=3Dfoo -device isa-serial,chardev=3Dfoo).



--=20
Marc-Andr=C3=A9 Lureau
