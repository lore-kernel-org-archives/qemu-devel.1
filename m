Received: from eggs.gnu.org ([209.51.188.92]:57170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwlle-0003wL-Ib
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:39:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwllc-0007a5-RI
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:39:50 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gwllc-0007Ye-H6
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:39:48 -0500
Received: by mail-qk1-f194.google.com with SMTP id f196so3936149qke.10
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 02:39:44 -0800 (PST)
MIME-Version: 1.0
References: <20190220160628.6555-1-marcandre.lureau@redhat.com>
	<20190220160628.6555-2-marcandre.lureau@redhat.com>
	<20190221075959.GB3091@xz-x1>
In-Reply-To: <20190221075959.GB3091@xz-x1>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 21 Feb 2019 11:39:32 +0100
Message-ID: <CAMxuvawaLapw0EtqASj6U2C-0oruf06RhqoU4GBjAk2vSZFoZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] iothread: wait until the glib context
 is acquired
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Thu, Feb 21, 2019 at 9:00 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Feb 20, 2019 at 05:06:25PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> > Another thread may acquire the glib context (temporarily) before
> > g_main_context_push_thread_default().
> >
> > This can happen with the following qemu_chr_fe_set_handlers()
> > modifications.
> >
> > Unfortunately, g_main_context_wait() is deprecated in glib
> > 2.58 (apparently it was a broken interface). Use a polling loop.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  iothread.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/iothread.c b/iothread.c
> > index e615b7ae52..93cc3aa875 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -70,6 +70,11 @@ static void *iothread_run(void *opaque)
> >          if (iothread->running && atomic_read(&iothread->worker_context=
)) {
> >              GMainLoop *loop;
> >
> > +            /* we may race with another thread acquiring the context *=
/
> > +            while (!g_main_context_acquire(iothread->worker_context)) =
{
> > +                g_usleep(10000);
> > +            }
>
> Could you help explain why need this explicitly?  Since AFAIU
> g_main_loop_run() below will do context acquire too so IIUC you're
> taking it twice (while g_main_context_acquire should allow it to
> happen, though)?
>

We call g_main_context_push_thread_default() before run(). It will
fail if the context is not acquirable.

> > +
> >              g_main_context_push_thread_default(iothread->worker_contex=
t);
> >              iothread->main_loop =3D
> >                  g_main_loop_new(iothread->worker_context, TRUE);
> > @@ -80,6 +85,8 @@ static void *iothread_run(void *opaque)
> >              g_main_loop_unref(loop);
> >
> >              g_main_context_pop_thread_default(iothread->worker_context=
);
> > +
> > +            g_main_context_release(iothread->worker_context);
> >          }
> >      }
> >
> > --
> > 2.21.0.rc1
> >
> >
>
> Regards,
>
> --
> Peter Xu
