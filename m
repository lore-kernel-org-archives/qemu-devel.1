Received: from eggs.gnu.org ([2001:4830:134:3::10]:34868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cv1uL-0005XT-V3
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cv1uF-0001H1-Ru
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:20:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cv1uF-0001GX-JI
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:20:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1C507E9E2
	for <qemu-devel@nongnu.org>; Mon,  3 Apr 2017 13:20:24 +0000 (UTC)
Date: Mon, 3 Apr 2017 14:20:11 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170403132011.GG32407@stefanha-x1.localdomain>
References: <20170331164322.24020-1-stefanha@redhat.com>
	<4de63a1a-e385-e22f-9bc4-f29d90cbdc30@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Content-Disposition: inline
In-Reply-To: <4de63a1a-e385-e22f-9bc4-f29d90cbdc30@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] char: kick main loop after adding a watch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Frediano Ziglio <fziglio@redhat.com>


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2017 at 06:53:56PM +0200, Paolo Bonzini wrote:
>=20
>=20
> On 31/03/2017 18:43, Stefan Hajnoczi wrote:
> > The ISA serial port device's output can hang when the pipe on stdout
> > becomes full.  This is a race condition where the vcpu thread executing
> > serial emulation code adds a watch on stdout while the main loop thread
> > is blocked in ppoll(2).  If no timer or other event wakes up the main
> > loop, there will be no further output from the serial device even when
> > the pipe becomes writable.
> >=20
> > Richard W. M. Jones was able to reproduce the hang on recent versions of
> > guestfs-tools-c and libglib2 on Fedora 26 hosts.
> >=20
> > This patch kicks the main loop so the next iteration invokes ppoll(2)
> > with the watch fd.
> >=20
> > Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1435432
> > Reported-by: Richard W. M. Jones <rjones@redhat.com>
> > Tested-by: Richard W. M. Jones <rjones@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  chardev/char.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/chardev/char.c b/chardev/char.c
> > index 3df1163..6c99c34 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -1059,6 +1059,11 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIO=
Condition cond,
> >      tag =3D g_source_attach(src, NULL);
> >      g_source_unref(src);
> > =20
> > +    /* The main loop may be in blocked waiting on events in another th=
read.
> > +     * Kick it so the new watch will be added.
> > +     */
> > +    qemu_notify_event();
> > +
> >      return tag;
> >  }
> > =20
> >=20
>=20
> Thanks for looking at this, I was quite stuck and now I understand=20
> what's going on.  However, I don't believe your patch is the right=20
> solution.
>=20
> According to Richard's bisection, the bug was introduced by the patch=20
> at https://bug761102.bugzilla-attachments.gnome.org/attachment.cgi?id=3D3=
19699.
>=20
> The g_wakeup_signal that is removed (actually made conditional) in that=
=20
> patch is doing exactly the same thing as qemu_notify_event, which is
> fishy...  It would still be a QEMU bug according to the theory below but,
> depending on how they handle backwards-compatibility, they might=20
> consider undoing this change.
>=20
> glib is expecting QEMU to use g_main_context_acquire around accesses to=
=20
> GMainContext.  However QEMU is not doing that, instead it is taking its=
=20
> own mutex.  So we should add g_main_context_acquire and
> g_main_context_release in the two implementations of=20
> os_host_main_loop_wait; these should undo the effect of Frediano's=20
> glib patch.
>=20
> In all fairness, the docs do say "You must be the owner of a context=20
> before you can call g_main_context_prepare(), g_main_context_query(),=20
> g_main_context_check(), g_main_context_dispatch()".  However, it has
> worked until now and the documentation does not say exactly why that
> is necessary.

Thanks Paolo, very interesting.  I never realized that glib has its own
inter-thread signal.

NACK

Stefan

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY4kwLAAoJEJykq7OBq3PIORgIAKioel7HkNms+v9JPhxZXBz3
6Gc8USDdE27HDQwSqH5KxhQLTo4Hio8Y79akFHyxymomLo9uYMsvk7WHUNKkpeC0
BOr56Os0XAi1vA8VakqOs9jwSwqvPKsUe1kam5XGB3MTeY6tDNee/HheMys8ijyR
DLlwXZL3EWGRWbTxfMzw8gFtx2qq7yOnJR3G6QkCqzit2aaFjHyWK3YIscUevWab
QPOnM7blLLisF2wtSHmwJrTFkXoe8OZS044NQlFHyxIHIggQaQjUz0OOVTRkj13e
OQ/Azxea2B61A/4XBtgf2Y1M00AWFYPb11pl8vq+xq6dxtvFBgKwyvhd249uGq8=
=49Sk
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--
