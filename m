Received: from eggs.gnu.org ([2001:4830:134:3::10]:38116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f8fOb-000211-8q
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 01:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f8fOY-0007ND-2i
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 01:12:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42510 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1f8fOX-0007Mt-T0
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 01:12:38 -0400
Date: Wed, 18 Apr 2018 13:12:24 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180418051224.GD25649@stefanha-x1.localdomain>
References: <20180412061108.10875-1-peterx@redhat.com>
	<20180416083748.GD28904@stefanha-x1.localdomain>
	<20180416091732.GB21143@xz-mi>
	<20180417070843.GI10770@stefanha-x1.localdomain>
	<874lkai4no.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline
In-Reply-To: <874lkai4no.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3] monitor: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 11:05:47AM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > On Mon, Apr 16, 2018 at 05:17:32PM +0800, Peter Xu wrote:
> >> On Mon, Apr 16, 2018 at 04:37:48PM +0800, Stefan Hajnoczi wrote:
> >> > On Thu, Apr 12, 2018 at 02:11:08PM +0800, Peter Xu wrote:
> >> > > In the future the monitor iothread may be accessing the cur_mon as
> >> > > well (via monitor_qmp_dispatch_one()).  Before we introduce a real
> >> > > Out-Of-Band command, let's convert the cur_mon variable to be a
> >> > > per-thread variable to make sure there won't be a race between thr=
eads.
> >> > >
> >> > > Note that thread variables are not initialized to a valid value wh=
en new
> >> > > thread is created.  However for our case we don't need to set it u=
p,
> >> > > since the cur_mon variable is only used in such a pattern:
> >> > >=20
> >> > >   old_mon =3D cur_mon;
> >> > >   cur_mon =3D xxx;
> >> > >   (do something, read cur_mon if necessary in the stack)
> >> > >   cur_mon =3D old_mon;
> >> > >=20
> >> > > It plays a role as stack variable, so no need to be initialized at=
 all.
> >> > > We only need to make sure the variable won't be changed unexpected=
ly by
> >> > > other threads.
> >> > >=20
> >> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> >> > > ---
> >> > > v3:
> >> > > - fix code style warning from patchew
> >> > > v2:
> >> > > - drop qemu-thread changes
> >> > > ---
> >> > >  include/monitor/monitor.h | 2 +-
> >> > >  monitor.c                 | 2 +-
> >> > >  stubs/monitor.c           | 2 +-
> >> > >  tests/test-util-sockets.c | 2 +-
> >> > >  4 files changed, 4 insertions(+), 4 deletions(-)
> >> >=20
> >> > The Monitor object is not fully thread-safe, so although the correct
> >> > cur_mon is now accessible, code may still be unsafe.  For example,
> >> > monitor_get_fd(cur_mon, ...) is not thread-safe and must not be used=
 by
> >> > OOB commands.
> >>=20
> >> IMHO things like monitor_get_fd() should only be called in QMP
> >> context, so there should always be a monitor_qmp_dispatch_one() in the
> >> stack already (no matter whether it is in main thread or the monitor
> >> iothread), which means that cur_mon should have been setup.  So IMHO
> >> it's a programming error if monitor_get_fd() is called without correct
> >> cur_mon setup after this patch.
> >
> > The pointer value of cur_mon is not the issue, you have made that work
> > correctly.  The problem is that some monitor.h APIs do not access the
> > Monitor object in a thread-safe fashion.
> >
> > Two QMP commands executing simultaneously in the main loop thread and
> > the monitor IOThread can hit race conditions.  The example I gave was
> > the monitor_get_fd() API, which iterates and modifies the mon->fds
> > QLIST without a lock.
> >
> > Please audit monitor.h and either make things thread-safe or document
> > the thread-safety rules (e.g. "This function cannot be called from
> > out-of-band QMP context").  This wasn't necessary before but now that
> > you are adding multi-threading it is.
>=20
> Code working with the current thread's monitor via thread-local cur_mon
> is easier to analyze in some ways than code working with a Monitor *
> parameter: the latter can interfere with some other thread's monitor,
> and you may have to argue what values the parameter can take.
>=20
> You might want to replace parameters by cur_mon in certain cases.
>=20
> Funnily, the plan used to be the opposite.  Commit 376253ece48: "On the
> mid or long term, those use case will be obsoleted so that [cur_mon] can
> be removed again."

Either way, the issue I described can still happen since two QMP
commands for a single Monitor object can execute simultaneously in the
main loop thread and the monitor IOThread.

I'm basically warning that QMP multi-threading isn't a solved problem
yet.  It needs to be solved by a combination of making things
thread-safe, documentation, and assertions so code fails loudly and
early when called from an unsupported context.

Stefan

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa1tO3AAoJEJykq7OBq3PInQ4H/06ZQXjlatLV6vxx6KyGy+AC
DNIQojVrvPFIdQkL9vjrr8wRvGbYBH2hfodJbzMVHN1EWyG3Sk0Y/zdJZuiPsKr+
MZvC4kg1qHJnjeM7iKMbhjsop50nKBZfbWnGnvbH+vvIVfWJLVqipoEMBfKM3Z8t
43NxpYoCLNMps+Dh+Zcc9Fzx7vQs5QraYw1D4illkoEwwqCMGNogico5c9xRh442
FCnnCHnTWRKoiPiiZZFEbReCfORjO77ePrwkbgPf+0eXc4XJHUEymf9E1y9+ZzLL
SxUlKCuPo6M/UlX0Uy4X9mYKnORE6ID36kqIskbEXZ8LnrzHBMUhsDIfVxIcXSM=
=ZT7y
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
