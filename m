Received: from eggs.gnu.org ([209.51.188.92]:37458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gzEpN-0008Ix-Ne
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 01:05:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gzEpH-0005QG-Tm
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 01:05:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gzEpF-00038F-O5
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 01:05:45 -0500
Date: Thu, 28 Feb 2019 13:58:56 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190228055856.GV13653@xz-x1>
References: <20190222031413.20250-1-peterx@redhat.com>
	<20190222031413.20250-5-peterx@redhat.com>
	<CAMxuvax9+NNe6Mh3TnFgt6p+q=kcgR1tEiQNr+be8bJRDUPCJw@mail.gmail.com>
	<20190222065724.GH8904@xz-x1>
	<20190227133838.GB22539@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190227133838.GB22539@stefanha-x1.localdomain>
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

On Wed, Feb 27, 2019 at 01:38:38PM +0000, Stefan Hajnoczi wrote:
> On Fri, Feb 22, 2019 at 02:57:24PM +0800, Peter Xu wrote:
> > On Fri, Feb 22, 2019 at 07:37:02AM +0100, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > Hi
> > >=20
> > > On Fri, Feb 22, 2019 at 4:14 AM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > We were pushing the context until right before running the gmainl=
oop.
> > > > Now since we have everything unconditionally, we can move this
> > > > earlier.
> > > >
> > > > One benefit is that now it's done even before init_done_sem, so a=
s
> > > > long as the iothread user calls iothread_create() and completes, =
we
> > > > know that the thread stack is ready.
> > > >
> > >=20
> > > This will change the default context in the iothread, for code runn=
ing
> > > there. This may not be a good idea. Until now, only sources dispatc=
hed
> > > from iothread_get_g_main_context() would have default context
> > > associated to it.
> > >=20
> > > I don't know if the current behaviour is intentional, but it has so=
me
> > > logic. With this change, you may create hidden races, by changing t=
he
> > > default context of sources to the iothread.
> >=20
> > Yes I agree that the behavior will be changed in this patch that even
> > if the iothread user does not use the gcontext they'll also have the
> > context set.  I would think it should be ok because IMHO events hooke=
d
> > onto the aio context should not depend on the gcontext, but indeed I'=
d
> > like to get some confirmation from others, especially the block layer=
.
>=20
> I don't understand why Patch 4 is desirable.  The comment about
> init_done_sem isn't clear to me but I also wondered the same thing as
> Marc-Andr=C3=A9.
>=20
> Can you explain why we should apply this patch?

Hi, Stefan,

The patch 4 itself does not help much for current QEMU, but it should
be required to replace the patch that Marc-Andre proposed below:

https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg05460.html [1]

And IMHO patch 4 along with this whole series should be a cleaner
approach comparing to the one proposed in [1].  Here if my
understanding is correct the problem is that
g_main_context_push_thread_default() is really designed to be called
at the very beginning of a thread creation but not dynamically called
during the execution of a thread (prove is that it even does not have
any error to return when failed to acquire the context so the caller
will never know if it failed! see [2] below), in that sense this patch
4 can be seen as a tiny cleanup too.

g_main_context_push_thread_default (GMainContext *context)
{
  GQueue *stack;
  gboolean acquired_context;

  acquired_context =3D g_main_context_acquire (context);
  g_return_if_fail (acquired_context);  <------------- [2]

  ...
}

Regards,

--=20
Peter Xu
