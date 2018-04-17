Received: from eggs.gnu.org ([2001:4830:134:3::10]:53399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f8Kja-0000WQ-AD
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f8KjX-0003hr-41
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:08:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48330 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1f8KjW-0003hG-Si
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:08:55 -0400
Date: Tue, 17 Apr 2018 15:08:43 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180417070843.GI10770@stefanha-x1.localdomain>
References: <20180412061108.10875-1-peterx@redhat.com>
	<20180416083748.GD28904@stefanha-x1.localdomain>
	<20180416091732.GB21143@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WR+jf/RUebEcofwt"
Content-Disposition: inline
In-Reply-To: <20180416091732.GB21143@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v3] monitor: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--WR+jf/RUebEcofwt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2018 at 05:17:32PM +0800, Peter Xu wrote:
> On Mon, Apr 16, 2018 at 04:37:48PM +0800, Stefan Hajnoczi wrote:
> > On Thu, Apr 12, 2018 at 02:11:08PM +0800, Peter Xu wrote:
> > > In the future the monitor iothread may be accessing the cur_mon as
> > > well (via monitor_qmp_dispatch_one()).  Before we introduce a real
> > > Out-Of-Band command, let's convert the cur_mon variable to be a
> > > per-thread variable to make sure there won't be a race between thread=
s.
> > >
> > > Note that thread variables are not initialized to a valid value when =
new
> > > thread is created.  However for our case we don't need to set it up,
> > > since the cur_mon variable is only used in such a pattern:
> > >=20
> > >   old_mon =3D cur_mon;
> > >   cur_mon =3D xxx;
> > >   (do something, read cur_mon if necessary in the stack)
> > >   cur_mon =3D old_mon;
> > >=20
> > > It plays a role as stack variable, so no need to be initialized at al=
l.
> > > We only need to make sure the variable won't be changed unexpectedly =
by
> > > other threads.
> > >=20
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > > v3:
> > > - fix code style warning from patchew
> > > v2:
> > > - drop qemu-thread changes
> > > ---
> > >  include/monitor/monitor.h | 2 +-
> > >  monitor.c                 | 2 +-
> > >  stubs/monitor.c           | 2 +-
> > >  tests/test-util-sockets.c | 2 +-
> > >  4 files changed, 4 insertions(+), 4 deletions(-)
> >=20
> > The Monitor object is not fully thread-safe, so although the correct
> > cur_mon is now accessible, code may still be unsafe.  For example,
> > monitor_get_fd(cur_mon, ...) is not thread-safe and must not be used by
> > OOB commands.
>=20
> IMHO things like monitor_get_fd() should only be called in QMP
> context, so there should always be a monitor_qmp_dispatch_one() in the
> stack already (no matter whether it is in main thread or the monitor
> iothread), which means that cur_mon should have been setup.  So IMHO
> it's a programming error if monitor_get_fd() is called without correct
> cur_mon setup after this patch.

The pointer value of cur_mon is not the issue, you have made that work
correctly.  The problem is that some monitor.h APIs do not access the
Monitor object in a thread-safe fashion.

Two QMP commands executing simultaneously in the main loop thread and
the monitor IOThread can hit race conditions.  The example I gave was
the monitor_get_fd() API, which iterates and modifies the mon->fds
QLIST without a lock.

Please audit monitor.h and either make things thread-safe or document
the thread-safety rules (e.g. "This function cannot be called from
out-of-band QMP context").  This wasn't necessary before but now that
you are adding multi-threading it is.

Stefan

--WR+jf/RUebEcofwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa1Z17AAoJEJykq7OBq3PIEdsH+wcpJxNMD+beP9hIPRlaOj1k
A9NSNicIYxRVgewgda78qLG74holEjRZNs+q6VvUnra+MpJdNL/N7UTyiNAR5SdC
znX3STNX5E0Dwyo5Z0aucN5LcgVLsResnHWLmiE25WEnjgeiNYRSxYs8Xo7Pb33u
DS4Nc1Js3FWNFRcgNIEl33h+0pVEmveL2o5mAOKVPEtyD4XGbU7pIzEqoXDmaqcw
3Dp4D/e8Nd8EWkh1wF2FLiDDXM5U3wnURtaKF170jZzWV5TQvRTHEWHZSD0tU+Gy
1stqJptP/4cIEdnAIWanshgDTepZCdRBOcT4RznYJiHRgaZjdKLRmEznS9CAiok=
=laGQ
-----END PGP SIGNATURE-----

--WR+jf/RUebEcofwt--
