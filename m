Received: from eggs.gnu.org ([209.51.188.92]:48315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gx1XM-00058m-Bh
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 22:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gx1XK-000849-V9
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 22:30:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gx1XK-00070C-IT
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 22:30:06 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDE7059473
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 03:29:12 +0000 (UTC)
Date: Fri, 22 Feb 2019 11:29:06 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190222032906.GA8904@xz-x1>
References: <20190220160628.6555-1-marcandre.lureau@redhat.com>
	<20190220160628.6555-2-marcandre.lureau@redhat.com>
	<20190221075959.GB3091@xz-x1>
	<CAMxuvawaLapw0EtqASj6U2C-0oruf06RhqoU4GBjAk2vSZFoZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvawaLapw0EtqASj6U2C-0oruf06RhqoU4GBjAk2vSZFoZw@mail.gmail.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Feb 21, 2019 at 11:39:32AM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, Feb 21, 2019 at 9:00 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Feb 20, 2019 at 05:06:25PM +0100, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > Another thread may acquire the glib context (temporarily) before
> > > g_main_context_push_thread_default().
> > >
> > > This can happen with the following qemu_chr_fe_set_handlers()
> > > modifications.
> > >
> > > Unfortunately, g_main_context_wait() is deprecated in glib
> > > 2.58 (apparently it was a broken interface). Use a polling loop.
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  iothread.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/iothread.c b/iothread.c
> > > index e615b7ae52..93cc3aa875 100644
> > > --- a/iothread.c
> > > +++ b/iothread.c
> > > @@ -70,6 +70,11 @@ static void *iothread_run(void *opaque)
> > >          if (iothread->running && atomic_read(&iothread->worker_con=
text)) {
> > >              GMainLoop *loop;
> > >
> > > +            /* we may race with another thread acquiring the conte=
xt */
> > > +            while (!g_main_context_acquire(iothread->worker_contex=
t)) {
> > > +                g_usleep(10000);
> > > +            }
> >
> > Could you help explain why need this explicitly?  Since AFAIU
> > g_main_loop_run() below will do context acquire too so IIUC you're
> > taking it twice (while g_main_context_acquire should allow it to
> > happen, though)?
> >
>=20
> We call g_main_context_push_thread_default() before run(). It will
> fail if the context is not acquirable.

Thanks for explaining.  It wasn't obvious to me.

I've posted another series to refactor iothread a bit and it should be
able to drop this patch if based on that series (that series should
even remove code instead of adding new).  Please feel free to have a
look, or give it a shot:

  [PATCH 0/4] iothread: create gcontext unconditionally

Regards,

--=20
Peter Xu
