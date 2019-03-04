Received: from eggs.gnu.org ([209.51.188.92]:44678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h0k2e-000504-79
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 04:37:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h0k2c-0001fQ-So
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 04:37:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1h0k2c-0001fA-Hy
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 04:37:46 -0500
Date: Mon, 4 Mar 2019 17:37:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190304093736.GD1657@xz-x1>
References: <20190222031413.20250-1-peterx@redhat.com>
	<20190222031413.20250-5-peterx@redhat.com>
	<CAMxuvax9+NNe6Mh3TnFgt6p+q=kcgR1tEiQNr+be8bJRDUPCJw@mail.gmail.com>
	<20190222065724.GH8904@xz-x1>
	<20190227133838.GB22539@stefanha-x1.localdomain>
	<20190228055856.GV13653@xz-x1>
	<20190301162517.GC18260@stefanha-x1.localdomain>
	<20190304022658.GE22229@xz-x1>
	<CAMxuvaxk3JnDAQT2Lt9JPXvZkZKdoOYgeK3ys4m_skZXiayqxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvaxk3JnDAQT2Lt9JPXvZkZKdoOYgeK3ys4m_skZXiayqxQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] iothread: push gcontext earlier in the
 thread_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, Mar 04, 2019 at 10:12:10AM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Mar 4, 2019 at 3:27 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Mar 01, 2019 at 04:25:17PM +0000, Stefan Hajnoczi wrote:
> > > On Thu, Feb 28, 2019 at 01:58:56PM +0800, Peter Xu wrote:
> > > > On Wed, Feb 27, 2019 at 01:38:38PM +0000, Stefan Hajnoczi wrote:
> > > > > On Fri, Feb 22, 2019 at 02:57:24PM +0800, Peter Xu wrote:
> > > > > > On Fri, Feb 22, 2019 at 07:37:02AM +0100, Marc-Andr=C3=A9 Lur=
eau wrote:
> > > > > > > Hi
> > > > > > >
> > > > > > > On Fri, Feb 22, 2019 at 4:14 AM Peter Xu <peterx@redhat.com=
> wrote:
> > > > > > > >
> > > > > > > > We were pushing the context until right before running th=
e gmainloop.
> > > > > > > > Now since we have everything unconditionally, we can move=
 this
> > > > > > > > earlier.
> > > > > > > >
> > > > > > > > One benefit is that now it's done even before init_done_s=
em, so as
> > > > > > > > long as the iothread user calls iothread_create() and com=
pletes, we
> > > > > > > > know that the thread stack is ready.
> > > > > > > >
> > > > > > >
> > > > > > > This will change the default context in the iothread, for c=
ode running
> > > > > > > there. This may not be a good idea. Until now, only sources=
 dispatched
> > > > > > > from iothread_get_g_main_context() would have default conte=
xt
> > > > > > > associated to it.
> > > > > > >
> > > > > > > I don't know if the current behaviour is intentional, but i=
t has some
> > > > > > > logic. With this change, you may create hidden races, by ch=
anging the
> > > > > > > default context of sources to the iothread.
> > > > > >
> > > > > > Yes I agree that the behavior will be changed in this patch t=
hat even
> > > > > > if the iothread user does not use the gcontext they'll also h=
ave the
> > > > > > context set.  I would think it should be ok because IMHO even=
ts hooked
> > > > > > onto the aio context should not depend on the gcontext, but i=
ndeed I'd
> > > > > > like to get some confirmation from others, especially the blo=
ck layer.
> > > > >
> > > > > I don't understand why Patch 4 is desirable.  The comment about
> > > > > init_done_sem isn't clear to me but I also wondered the same th=
ing as
> > > > > Marc-Andr=C3=A9.
> > > > >
> > > > > Can you explain why we should apply this patch?
> > > >
> > > > Hi, Stefan,
> > > >
> > > > The patch 4 itself does not help much for current QEMU, but it sh=
ould
> > > > be required to replace the patch that Marc-Andre proposed below:
> > > >
> > > > https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg05460.ht=
ml [1]

[1]

> > > >
> > > > And IMHO patch 4 along with this whole series should be a cleaner
> > > > approach comparing to the one proposed in [1].  Here if my
> > > > understanding is correct the problem is that
> > > > g_main_context_push_thread_default() is really designed to be cal=
led
> > > > at the very beginning of a thread creation but not dynamically ca=
lled
> > > > during the execution of a thread (prove is that it even does not =
have
> > > > any error to return when failed to acquire the context so the cal=
ler
> > > > will never know if it failed! see [2] below), in that sense this =
patch
> > > > 4 can be seen as a tiny cleanup too.
> > > >
> > > > g_main_context_push_thread_default (GMainContext *context)
> > > > {
> > > >   GQueue *stack;
> > > >   gboolean acquired_context;
> > > >
> > > >   acquired_context =3D g_main_context_acquire (context);
> > > >   g_return_if_fail (acquired_context);  <------------- [2]
> > > >
> > > >   ...
> > > > }
> > >
> > > I see.  This explains why you want to call it early.  If you're wor=
ried
> > > about that then there should also be a comment warning people that =
this
> > > must happen first before anything implicitly uses the thread's
> > > GMainContext.
> >
> > Sure, I can add a comment above g_main_context_push_thread_default()
> > to emphasize why it's preferred at the entry.
> >
> > >
> > > What about Marc-Andr=C3=A9's concern about the change in behavior? =
 Now this
> > > thread is associated with the GMainContext that isn't processed at =
in
> > > aio_poll().  Previously the default main context would be used.
> >
> > IIUC Paolo has answered this question (Message-ID:
> > <0faeceb2-68fa-59b0-48c3-b8e907b2a75f@redhat.com>) - if the block
> > layer (or say, the explicit aio_poll in the iothread_run) does not us=
e
> > the GMainContext at all then it should affect nothing, and with that
> > there should have no real functional change.
> >
>=20
> It's a bold claim though, iothread isn't used only by the block layer.
> It's used also by colo in qemu tree, and I used to have a branch for
> virgl rendering for example. There might be other experimental work or
> usage I missed. Furthermore, even the block layer, and its various
> dependencies, is hard to review thoroughly. But it looks like it
> doesn't rely on glib main context, I agree. But I would get prepared
> for some weird (difficult to debug) regressions eventually.

For COLO: it should be using GMainContext all the time (IIRC it's the
one who introduced this "push default gcontext" stuff to iothread
world...) so it should be fine too?  After all it's the only real user
of that so far!

For virgl rendering: I'm not sure whether there's assumption on
running them on the main thread and whether there would be race
against it if running on the iothread (AFAIU that's what the "push
default gcontext will affect"), but I would assume there's no such
requirement otherwise IMHO it should not need a dedicated iothread at
all if it needs serialization on main thread tasks...

For other "experimental work": I can't tell because I never know them.

I'm fine to drop this patch if any of us worries that this patch will
break something and I cannot guarantee anything for sure if we're even
considering experimental works... but still if any of us wants to move
on with [1] above I would still prefer to consider this patch 4.

Regards,

--=20
Peter Xu
