Received: from eggs.gnu.org ([2001:4830:134:3::10]:55545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fsnKu-0007vf-LF
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fsnH7-0006e8-Cb
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:55:38 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:40233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fsnH7-0006dJ-2V
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:55:37 -0400
Received: by mail-wm0-x22a.google.com with SMTP id 207-v6so5296192wme.5
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 03:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-11-peterx@redhat.com>
	<20180105172226.GL28322@stefanha-x1.localdomain>
In-Reply-To: <20180105172226.GL28322@stefanha-x1.localdomain>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Aug 2018 12:55:23 +0200
Message-ID: <CAJ+F1C+wutJ1Pk4JPWdkDaVhfB2CMOiQHTgpB+-Vg0hcpcZrbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v6 10/27] monitor: allow to use IO thread for
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Fri, Jan 5, 2018 at 6:22 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Tue, Dec 19, 2017 at 04:45:40PM +0800, Peter Xu wrote:
> >      if (monitor_is_qmp(mon)) {
> > -        qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_=
qmp_read,
> > -                                 monitor_qmp_event, NULL, mon, NULL, t=
rue);
> >          qemu_chr_fe_set_echo(&mon->chr, true);
> >          json_message_parser_init(&mon->qmp.parser, handle_qmp_command)=
;
> > +        qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_=
qmp_read,
> > +                                 monitor_qmp_event, NULL, mon, context=
, true);
> >      } else {
> > +        assert(!context);       /* HMP does not support IOThreads */
> >          qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_=
read,
> >                                   monitor_event, NULL, mon, NULL, true)=
;
> >      }
>
> qemu_chr_fe_set_handlers() isn't thread-safe.  It looks like
> monitor_can_read()/monitor_qmp_read() can run in the IOThread at the
> same time as monitor_qmp_event() runs in the main loop:
>
>   void qemu_chr_fe_set_handlers(CharBackend *b,
>                                 IOCanReadHandler *fd_can_read,
>                                 IOReadHandler *fd_read,
>                                 IOEventHandler *fd_event,
>                                 BackendChangeHandler *be_change,
>                                 void *opaque,
>                                 GMainContext *context,
>                                 bool set_open)
>   {
>       ...
>
>       qemu_chr_be_update_read_handlers(s, context);
>         ^-- The IOThread may invoke handler functions from now on!
>
>       <-- Everything below races with the IOThread!
>
>       if (set_open) {
>           qemu_chr_fe_set_open(b, fe_open);
>       }
>
>       if (fe_open) {
>           qemu_chr_fe_take_focus(b);
>           /* We're connecting to an already opened device, so let's make =
sure we
>              also get the open event */
>           if (s->be_open) {
>               qemu_chr_be_event(s, CHR_EVENT_OPENED);
>           }
>       }
>
>       if (CHARDEV_IS_MUX(s)) {
>           mux_chr_set_handlers(s, context);
>       }
>   }
>
> It looks like chr_*() functions must be called from the event loop
> thread that monitors the chardev.  You can use aio_bh_schedule_oneshot()
> or g_idle_source_new() to execute the last part of monitor_init() in the
> GMainContext.

Sadly, it looks like moving the qemu_chr_fe_set_handlers() call to the
target thread isn't yet safe either.

Even if remove_fd_in_watch() is called from the source thread, there
might be other sources that are still running in the main thread. For
example, the socket telnet_source. This will create races in
telnet_init & telnet_init_io callback between source & target threads.
We have to review this more carefully.

(btw, there are other code paths in the monitor chardev callbacks that
look unsafe to me, mon_refcount for ex)


>
> That way there is no race condition because qemu_chr_fe_set_handlers()
> is called from within the event loop thread.



--=20
Marc-Andr=C3=A9 Lureau
