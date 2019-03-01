Received: from eggs.gnu.org ([209.51.188.92]:33206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gzkyQ-0001vk-3q
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:25:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gzkyO-0001Aj-Vm
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:25:22 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gzkyO-00018h-NM
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:25:20 -0500
Received: by mail-wr1-x442.google.com with SMTP id r5so26493422wrg.9
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 08:25:20 -0800 (PST)
Date: Fri, 1 Mar 2019 16:25:17 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190301162517.GC18260@stefanha-x1.localdomain>
References: <20190222031413.20250-1-peterx@redhat.com>
	<20190222031413.20250-5-peterx@redhat.com>
	<CAMxuvax9+NNe6Mh3TnFgt6p+q=kcgR1tEiQNr+be8bJRDUPCJw@mail.gmail.com>
	<20190222065724.GH8904@xz-x1>
	<20190227133838.GB22539@stefanha-x1.localdomain>
	<20190228055856.GV13653@xz-x1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <20190228055856.GV13653@xz-x1>
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
To: Peter Xu <peterx@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 01:58:56PM +0800, Peter Xu wrote:
> On Wed, Feb 27, 2019 at 01:38:38PM +0000, Stefan Hajnoczi wrote:
> > On Fri, Feb 22, 2019 at 02:57:24PM +0800, Peter Xu wrote:
> > > On Fri, Feb 22, 2019 at 07:37:02AM +0100, Marc-Andr=E9 Lureau wrote:
> > > > Hi
> > > >=20
> > > > On Fri, Feb 22, 2019 at 4:14 AM Peter Xu <peterx@redhat.com> wrote:
> > > > >
> > > > > We were pushing the context until right before running the gmainl=
oop.
> > > > > Now since we have everything unconditionally, we can move this
> > > > > earlier.
> > > > >
> > > > > One benefit is that now it's done even before init_done_sem, so as
> > > > > long as the iothread user calls iothread_create() and completes, =
we
> > > > > know that the thread stack is ready.
> > > > >
> > > >=20
> > > > This will change the default context in the iothread, for code runn=
ing
> > > > there. This may not be a good idea. Until now, only sources dispatc=
hed
> > > > from iothread_get_g_main_context() would have default context
> > > > associated to it.
> > > >=20
> > > > I don't know if the current behaviour is intentional, but it has so=
me
> > > > logic. With this change, you may create hidden races, by changing t=
he
> > > > default context of sources to the iothread.
> > >=20
> > > Yes I agree that the behavior will be changed in this patch that even
> > > if the iothread user does not use the gcontext they'll also have the
> > > context set.  I would think it should be ok because IMHO events hooked
> > > onto the aio context should not depend on the gcontext, but indeed I'd
> > > like to get some confirmation from others, especially the block layer.
> >=20
> > I don't understand why Patch 4 is desirable.  The comment about
> > init_done_sem isn't clear to me but I also wondered the same thing as
> > Marc-Andr=E9.
> >=20
> > Can you explain why we should apply this patch?
>=20
> Hi, Stefan,
>=20
> The patch 4 itself does not help much for current QEMU, but it should
> be required to replace the patch that Marc-Andre proposed below:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg05460.html [1]
>=20
> And IMHO patch 4 along with this whole series should be a cleaner
> approach comparing to the one proposed in [1].  Here if my
> understanding is correct the problem is that
> g_main_context_push_thread_default() is really designed to be called
> at the very beginning of a thread creation but not dynamically called
> during the execution of a thread (prove is that it even does not have
> any error to return when failed to acquire the context so the caller
> will never know if it failed! see [2] below), in that sense this patch
> 4 can be seen as a tiny cleanup too.
>=20
> g_main_context_push_thread_default (GMainContext *context)
> {
>   GQueue *stack;
>   gboolean acquired_context;
>=20
>   acquired_context =3D g_main_context_acquire (context);
>   g_return_if_fail (acquired_context);  <------------- [2]
>=20
>   ...
> }

I see.  This explains why you want to call it early.  If you're worried
about that then there should also be a comment warning people that this
must happen first before anything implicitly uses the thread's
GMainContext.

What about Marc-Andr=E9's concern about the change in behavior?  Now this
thread is associated with the GMainContext that isn't processed at in
aio_poll().  Previously the default main context would be used.

Stefan

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJceVztAAoJEJykq7OBq3PIchUIAL3H42ZoN0dnJqa0IR3aGx0n
Z5aECB0Pxz/lAKllMvw2mfb3gzOlFaoVQRs2GtwLfayqIwkrQ38xx6OO/pUsJZ6U
zcbfM1DpsNnr8076YA554hUiR3VXtEojoGGK0uACi0no+h+xgsya9uNrWT9hOPvr
7bOHmjDtfGySppvCA52uAz4N/ZJvX2KH1bZaalyXbjpOPq5wgLDcPurAgi0c5nRe
jigVv/7JyWWH6ART+ayvlen1atZEzm8yz/T0Z3oI3AZVE+4mvDwPdKJPGWgTrmK3
DS9YEsLMDb3VG5b8X0Mom5PaD8sMWgihdvx3ALOMpSbd0TmX1X6ltOJXC+7alH8=
=JNEw
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
