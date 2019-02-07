Received: from eggs.gnu.org ([209.51.188.92]:35321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grkbn-0002Wo-E0
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grkbm-0001zC-B9
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:24:55 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1grkbm-0001yA-62
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:24:54 -0500
Received: by mail-qk1-f196.google.com with SMTP id y78so6512131qka.12
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 06:24:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549545591.git.berto@igalia.com>
	<c741408825d01f5a186901c5a8248126ffebe9fd.1549545591.git.berto@igalia.com>
	<CAMxuvayhuXEWTvJqNyKFjuae3u47MnjN4NPQ_J+vVWLK9pM5Rg@mail.gmail.com>
In-Reply-To: <CAMxuvayhuXEWTvJqNyKFjuae3u47MnjN4NPQ_J+vVWLK9pM5Rg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 7 Feb 2019 15:24:40 +0100
Message-ID: <CAMxuvawnNqvUYf2Z-+8zX63wRNFp+F_A7Uo==pY_9n1HDXumqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] main-loop: Don't leak GSources
 attached to a GMainContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>

On Thu, Feb 7, 2019 at 3:23 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> On Thu, Feb 7, 2019 at 2:23 PM Alberto Garcia <berto@igalia.com> wrote:
> >
> > After g_source_attach() the GMainContext holds a reference to the
> > GSource, so the caller does not need to keep it.
> >
> > pty_chr_state() and qio_task_thread_worker() are not doing this, so
> > the GSource is being leaked in both cases (pty_chr_open_src_cancel()
> > is the exception here because it does remove the extra reference
> > correctly).
> >
> > Signed-off-by: Alberto Garcia <berto@igalia.com>
>
> You could mention this is a fix for regression from
> a17536c594bfed94d05667b419f747b692f5fc7f
>

and 938eb9e9c83d34d90cac6ec5c5388e7998840e4e


>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>
> > ---
> >  chardev/char-pty.c | 2 +-
> >  io/task.c          | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> > index f681d637c1..f16a5e8d59 100644
> > --- a/chardev/char-pty.c
> > +++ b/chardev/char-pty.c
> > @@ -60,7 +60,6 @@ static void pty_chr_open_src_cancel(PtyChardev *s)
> >  {
> >      if (s->open_source) {
> >          g_source_destroy(s->open_source);
> > -        g_source_unref(s->open_source);
> >          s->open_source =3D NULL;
> >      }
> >  }
> > @@ -216,6 +215,7 @@ static void pty_chr_state(Chardev *chr, int connect=
ed)
> >                                    qemu_chr_be_generic_open_func,
> >                                    chr, NULL);
> >              g_source_attach(s->open_source, chr->gcontext);
> > +            g_source_unref(s->open_source);
> >          }
> >          if (!chr->gsource) {
> >              chr->gsource =3D io_add_watch_poll(chr, s->ioc,
> > diff --git a/io/task.c b/io/task.c
> > index 2886a2c1bc..c8489fb790 100644
> > --- a/io/task.c
> > +++ b/io/task.c
> > @@ -120,6 +120,7 @@ static gpointer qio_task_thread_worker(gpointer opa=
que)
> >      idle =3D g_idle_source_new();
> >      g_source_set_callback(idle, qio_task_thread_result, data, NULL);
> >      g_source_attach(idle, data->context);
> > +    g_source_unref(idle);
> >
> >      return NULL;
> >  }
> > --
> > 2.11.0
> >
