Received: from eggs.gnu.org ([209.51.188.92]:58374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h0dJx-0006dI-4x
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 21:27:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h0dJw-0006Mf-1m
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 21:27:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1h0dJv-0006Lw-Om
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 21:27:11 -0500
Date: Mon, 4 Mar 2019 10:26:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190304022658.GE22229@xz-x1>
References: <20190222031413.20250-1-peterx@redhat.com>
	<20190222031413.20250-5-peterx@redhat.com>
	<CAMxuvax9+NNe6Mh3TnFgt6p+q=kcgR1tEiQNr+be8bJRDUPCJw@mail.gmail.com>
	<20190222065724.GH8904@xz-x1>
	<20190227133838.GB22539@stefanha-x1.localdomain>
	<20190228055856.GV13653@xz-x1>
	<20190301162517.GC18260@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190301162517.GC18260@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Mar 01, 2019 at 04:25:17PM +0000, Stefan Hajnoczi wrote:
> On Thu, Feb 28, 2019 at 01:58:56PM +0800, Peter Xu wrote:
> > On Wed, Feb 27, 2019 at 01:38:38PM +0000, Stefan Hajnoczi wrote:
> > > On Fri, Feb 22, 2019 at 02:57:24PM +0800, Peter Xu wrote:
> > > > On Fri, Feb 22, 2019 at 07:37:02AM +0100, Marc-Andr=C3=A9 Lureau =
wrote:
> > > > > Hi
> > > > >=20
> > > > > On Fri, Feb 22, 2019 at 4:14 AM Peter Xu <peterx@redhat.com> wr=
ote:
> > > > > >
> > > > > > We were pushing the context until right before running the gm=
ainloop.
> > > > > > Now since we have everything unconditionally, we can move thi=
s
> > > > > > earlier.
> > > > > >
> > > > > > One benefit is that now it's done even before init_done_sem, =
so as
> > > > > > long as the iothread user calls iothread_create() and complet=
es, we
> > > > > > know that the thread stack is ready.
> > > > > >
> > > > >=20
> > > > > This will change the default context in the iothread, for code =
running
> > > > > there. This may not be a good idea. Until now, only sources dis=
patched
> > > > > from iothread_get_g_main_context() would have default context
> > > > > associated to it.
> > > > >=20
> > > > > I don't know if the current behaviour is intentional, but it ha=
s some
> > > > > logic. With this change, you may create hidden races, by changi=
ng the
> > > > > default context of sources to the iothread.
> > > >=20
> > > > Yes I agree that the behavior will be changed in this patch that =
even
> > > > if the iothread user does not use the gcontext they'll also have =
the
> > > > context set.  I would think it should be ok because IMHO events h=
ooked
> > > > onto the aio context should not depend on the gcontext, but indee=
d I'd
> > > > like to get some confirmation from others, especially the block l=
ayer.
> > >=20
> > > I don't understand why Patch 4 is desirable.  The comment about
> > > init_done_sem isn't clear to me but I also wondered the same thing =
as
> > > Marc-Andr=C3=A9.
> > >=20
> > > Can you explain why we should apply this patch?
> >=20
> > Hi, Stefan,
> >=20
> > The patch 4 itself does not help much for current QEMU, but it should
> > be required to replace the patch that Marc-Andre proposed below:
> >=20
> > https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg05460.html [=
1]
> >=20
> > And IMHO patch 4 along with this whole series should be a cleaner
> > approach comparing to the one proposed in [1].  Here if my
> > understanding is correct the problem is that
> > g_main_context_push_thread_default() is really designed to be called
> > at the very beginning of a thread creation but not dynamically called
> > during the execution of a thread (prove is that it even does not have
> > any error to return when failed to acquire the context so the caller
> > will never know if it failed! see [2] below), in that sense this patc=
h
> > 4 can be seen as a tiny cleanup too.
> >=20
> > g_main_context_push_thread_default (GMainContext *context)
> > {
> >   GQueue *stack;
> >   gboolean acquired_context;
> >=20
> >   acquired_context =3D g_main_context_acquire (context);
> >   g_return_if_fail (acquired_context);  <------------- [2]
> >=20
> >   ...
> > }
>=20
> I see.  This explains why you want to call it early.  If you're worried
> about that then there should also be a comment warning people that this
> must happen first before anything implicitly uses the thread's
> GMainContext.

Sure, I can add a comment above g_main_context_push_thread_default()
to emphasize why it's preferred at the entry.

>=20
> What about Marc-Andr=C3=A9's concern about the change in behavior?  Now=
 this
> thread is associated with the GMainContext that isn't processed at in
> aio_poll().  Previously the default main context would be used.

IIUC Paolo has answered this question (Message-ID:
<0faeceb2-68fa-59b0-48c3-b8e907b2a75f@redhat.com>) - if the block
layer (or say, the explicit aio_poll in the iothread_run) does not use
the GMainContext at all then it should affect nothing, and with that
there should have no real functional change.

Regards,

--=20
Peter Xu
