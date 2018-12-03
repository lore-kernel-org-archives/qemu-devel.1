Received: from eggs.gnu.org ([2001:4830:134:3::10]:39978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gTjUU-0001oE-C7
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gTjDC-0001px-VP
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:04:15 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gTjDC-0001pP-Pl
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:04:14 -0500
Received: by mail-wr1-x442.google.com with SMTP id j2so11056786wrw.1
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 00:04:14 -0800 (PST)
MIME-Version: 1.0
References: <20181029125733.14597-1-marcandre.lureau@redhat.com>
	<20181029125733.14597-3-marcandre.lureau@redhat.com>
	<87in0b84r6.fsf@dusky.pond.sub.org>
In-Reply-To: <87in0b84r6.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 3 Dec 2018 12:04:00 +0400
Message-ID: <CAJ+F1CJQ0SGWnQvL7A8oYHCiuyv-2wS_78Aoeco2ZMLVpH9gLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/6] monitor: accept chardev input from
 iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Mon, Dec 3, 2018 at 11:26 AM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Chardev backends may not handle safely IO events from concurrent
> > threads.
>
> What exactly could go wrong?  Or is this a well-known fact that doesn't
> need further elaboration?

chardev are not thread-safe. Only the write path is, since commit
9005b2a7589540a3733b3abdcfbccfe7746cd1a1.

> "safely handle I/O events"
>
> >          Better to wake up the chardev from the monitor IO thread if
> > it's being used as the chardev context.
> >
> > Unify code paths by using a BH in all cases.
> >
> > Drop the now redundant aio_notify() call.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  monitor.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/monitor.c b/monitor.c
> > index 07712d89f9..511dd11d1c 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -4304,6 +4304,13 @@ int monitor_suspend(Monitor *mon)
> >      return 0;
> >  }
> >
> > +static void monitor_accept_input(void *opaque)
> > +{
> > +    Monitor *mon =3D opaque;
> > +
> > +    qemu_chr_fe_accept_input(&mon->chr);
> > +}
> > +
> >  void monitor_resume(Monitor *mon)
> >  {
> >      if (monitor_is_hmp_non_interactive(mon)) {
> > @@ -4311,20 +4318,24 @@ void monitor_resume(Monitor *mon)
> >      }
> >
> >      if (atomic_dec_fetch(&mon->suspend_cnt) =3D=3D 0) {
> > +        AioContext *ctx =3D qemu_get_aio_context();
> > +
> >          if (monitor_is_qmp(mon)) {
> >              /*
> >               * For QMP monitors that are running in the I/O thread,
> >               * let's kick the thread in case it's sleeping.
> >               */
> >              if (mon->use_io_thread) {
> > -                aio_notify(iothread_get_aio_context(mon_iothread));
> > +                ctx =3D iothread_get_aio_context(mon_iothread);
> >              }
> >          } else {
> >              assert(mon->rs);
> >              readline_show_prompt(mon->rs);
> >          }
>
> Correct, since mon->use_io_thread can only be true in a QMP monitor so
> far.  But there's no need to depend on that here:
>
>            AioContext *ctx;
>
>            if (mon->use_io_thread) {
>                ctx =3D iothread_get_aio_context(mon_iothread);
>            } else {
>                ctx =3D qemu_get_aio_context();
>            }
>
>            if (!monitor_is_qmp(mon)) {
>                assert(mon->rs);
>                readline_show_prompt(mon->rs);
>            }
>
> Same in monitor_suspend(), by the way.
>

ok


> The dependence in monitor_init() is tolerable, because it's the place
> where the dependence is established.
>
> > -        qemu_chr_fe_accept_input(&mon->chr);
> > +
> > +        aio_bh_schedule_oneshot(ctx, monitor_accept_input, mon);
> >      }
> > +
> >      trace_monitor_suspend(mon, -1);
> >  }
>


--=20
Marc-Andr=C3=A9 Lureau
