Received: from eggs.gnu.org ([209.51.188.92]:50921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gyzU8-000502-FR
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gyzQ5-0007l4-8L
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:38:46 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gyzQ4-0007iv-Rz
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:38:45 -0500
Received: by mail-wr1-x442.google.com with SMTP id w17so17971122wrn.12
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 05:38:41 -0800 (PST)
Date: Wed, 27 Feb 2019 13:38:38 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190227133838.GB22539@stefanha-x1.localdomain>
References: <20190222031413.20250-1-peterx@redhat.com>
	<20190222031413.20250-5-peterx@redhat.com>
	<CAMxuvax9+NNe6Mh3TnFgt6p+q=kcgR1tEiQNr+be8bJRDUPCJw@mail.gmail.com>
	<20190222065724.GH8904@xz-x1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <20190222065724.GH8904@xz-x1>
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


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 02:57:24PM +0800, Peter Xu wrote:
> On Fri, Feb 22, 2019 at 07:37:02AM +0100, Marc-Andr=E9 Lureau wrote:
> > Hi
> >=20
> > On Fri, Feb 22, 2019 at 4:14 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > We were pushing the context until right before running the gmainloop.
> > > Now since we have everything unconditionally, we can move this
> > > earlier.
> > >
> > > One benefit is that now it's done even before init_done_sem, so as
> > > long as the iothread user calls iothread_create() and completes, we
> > > know that the thread stack is ready.
> > >
> >=20
> > This will change the default context in the iothread, for code running
> > there. This may not be a good idea. Until now, only sources dispatched
> > from iothread_get_g_main_context() would have default context
> > associated to it.
> >=20
> > I don't know if the current behaviour is intentional, but it has some
> > logic. With this change, you may create hidden races, by changing the
> > default context of sources to the iothread.
>=20
> Yes I agree that the behavior will be changed in this patch that even
> if the iothread user does not use the gcontext they'll also have the
> context set.  I would think it should be ok because IMHO events hooked
> onto the aio context should not depend on the gcontext, but indeed I'd
> like to get some confirmation from others, especially the block layer.

I don't understand why Patch 4 is desirable.  The comment about
init_done_sem isn't clear to me but I also wondered the same thing as
Marc-Andr=E9.

Can you explain why we should apply this patch?

Stefan

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdpLeAAoJEJykq7OBq3PIaY8IAIktuajPSANNq4EhfPo+I603
MIDQliFU0J1HNZ7pw8D4EcNlnoaIVnbiEAqI2iWg3HIk3RwkxPEynoeBvfuGjsln
BsqDFKIU+ubJHpxh1gUbH2pGLEe122N6NeUxju5vUGWASVlg9pK7/pB2+rFLle0y
gG2xz4fTQuniw6aKKUJApvlP/p6x+4x8goI7S/lipZfmjC8+Cwzbrs7e/E0Pg7vS
ZQu9P7afKR8ipTSzfQ4oTiJ9ILuNhuQ3Lr+WLQMfZ0kaEn6090K5iLKBAuHrMRMW
aAGbaGsymhN9qOHphH0DpKluScFxRRnXoR9CM9i9pF8BpZARnQ9/iYZPp+TPUH4=
=wbwI
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
