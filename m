Received: from eggs.gnu.org ([2001:4830:134:3::10]:51849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gH5oa-0007z2-5i
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gH5oZ-0006HM-ER
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:34:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gH5oX-000690-F1
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:34:33 -0400
Received: by mail-wr1-x442.google.com with SMTP id t10-v6so8258643wrn.10
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 04:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181009131251.721-1-marcandre.lureau@redhat.com>
	<20181009131251.721-3-marcandre.lureau@redhat.com>
	<20181010034525.GM18728@xz-x1>
In-Reply-To: <20181010034525.GM18728@xz-x1>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 29 Oct 2018 15:34:16 +0400
Message-ID: <CAJ+F1C+mXtAMt2JG9tS03dJFP4qOK=1qkhtB3GsrNAEaSyL-gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6] monitor: accept chardev input from
 iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Hi

On Wed, Oct 10, 2018 at 7:45 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 09, 2018 at 05:12:47PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Chardev backends may not handle safely IO events from concurrent
> > threads. Better to wake up the chardev from the monitor IO thread if
> > it's being used as the chardev context.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  monitor.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/monitor.c b/monitor.c
> > index ab60c9f87e..a25514490a 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -4297,6 +4297,13 @@ int monitor_suspend(Monitor *mon)
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
> > @@ -4310,13 +4317,14 @@ void monitor_resume(Monitor *mon)
> >               * let's kick the thread in case it's sleeping.
> >               */
> >              if (mon->use_io_thread) {
> > -                aio_notify(iothread_get_aio_context(mon_iothread));
> > +                aio_bh_schedule_oneshot(iothread_get_aio_context(mon_i=
othread),
> > +                                        monitor_accept_input, mon);
>
> Just to make sure: this will definitely cover the previous
> aio_notify(), am I right?
>
> Imho some comment would always be nice here because QMPs with
> use_io_thread=3Dtrue seems special anyway.
>
> >              }
> >          } else {
> >              assert(mon->rs);
> >              readline_show_prompt(mon->rs);
> > +            monitor_accept_input(mon);
> >          }
> > -        qemu_chr_fe_accept_input(&mon->chr);
>
> How about the QMP monitors with oob=3Doff?  Will it miss the call?

good catch

>
> I would consider caching the aio context into Monitor struct when
> monitor init, then call aio_bh_schedule_oneshot() always with the
> per-monitor aio cache.  This could unify the code paths too so we keep
> the oob special path as less as possible.

Saving the aio context isn't really necessary. However, I'll unify the
code paths in v2.

thanks

>
> >      }
> >      trace_monitor_suspend(mon, -1);
> >  }
> > --
> > 2.19.0.271.gfe8321ec05
> >
>
> Regards,
>
> --
> Peter Xu
>


--=20
Marc-Andr=C3=A9 Lureau
