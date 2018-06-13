Received: from eggs.gnu.org ([2001:4830:134:3::10]:47291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT6mr-0001AA-0k
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT6ml-0004AZ-5z
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:30:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48570 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fT6ml-00049Z-0F
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:30:07 -0400
Date: Wed, 13 Jun 2018 15:30:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180613143005.GW24528@stefanha-x1.localdomain>
References: <20180604080630.10946-1-peterx@redhat.com>
	<87tvqeyfs2.fsf@dusky.pond.sub.org> <20180608044235.GA7736@xz-mi>
	<20180608080446.GH29183@stefanha-x1.localdomain>
	<87a7s5snce.fsf@dusky.pond.sub.org>
	<20180611164549.GI17756@stefanha-x1.localdomain>
	<20180612054700.GN7736@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fCmRXBY78W5odcVA"
Content-Disposition: inline
In-Reply-To: <20180612054700.GN7736@xz-mi>
Subject: Re: [Qemu-devel] [PATCH] monitor: postpone
 monitor_qmp_cleanup_queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--fCmRXBY78W5odcVA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2018 at 01:47:00PM +0800, Peter Xu wrote:
> On Mon, Jun 11, 2018 at 05:45:49PM +0100, Stefan Hajnoczi wrote:
> > On Fri, Jun 08, 2018 at 10:18:25AM +0200, Markus Armbruster wrote:
> > > Stefan Hajnoczi <stefanha@gmail.com> writes:
> > > > On Fri, Jun 08, 2018 at 12:42:35PM +0800, Peter Xu wrote:
> > > >> On Thu, Jun 07, 2018 at 01:53:01PM +0200, Markus Armbruster wrote:
> > > >> > Peter Xu <peterx@redhat.com> writes:
> > > >> >=20
> > > >> > > Previously we cleanup the queues when we got CLOSED event.  It=
 was used
> > > >> >=20
> > > >> > we clean up
> > > >> >=20
> > > >> > > to make sure we won't leftover replies/events of a old client =
to a new
> > > >> >=20
> > > >> > we won't send leftover replies/events of an old client
> > > >> >=20
> > > >> > > client.  Now this patch postpones that until OPENED.
> > > >> >=20
> > > >> > What if OPENED never comes?
> > > >>=20
> > > >> Then we clean that up until destruction of the monitor.  IMHO it's
> > > >> fine, but I'm not sure whether that's an overall acceptable approa=
ch.
> > > >
> > > > I think this patch fixes the problem at the wrong level.  Marc-Andr=
=E9's
> > > > fix seemed like a cleaner solution.
> > >=20
> > > Is it the right solution?
> > >=20
> > > I proposed another one:
> >=20
> > Sorry, I won't be able to participate in this because I'm behind on
> > other patches and tasks.  Therefore, feel free to disregard but I'll
> > give my 2 cents:
> >=20
> > This seems like a chardev bug.  The solution should probably be in the
> > chardev layer (Marc-Andr=E9's patch or something else), not in the moni=
tor
> > (this patch).
>=20
> Yes that's why I said I like Marc-Andre's patch. :) I just don't know
> an reliable way to achieve what we want there.
>=20
> The thing is that we don't really monitor the ioc_out for fd-typed
> chardevs.  We only do that when we call qemu_chr_fe_add_watch() (e.g.,
> in monitor_flush_locked()) when the writting buffer is full.  But
> normally we can't detect any event from the output side, hence no way
> to deliever a CLOSED event when the output fd is the last fd that is
> closed.
>=20
> Maybe we can keep that output watch for the whole lifecycle of the
> chardev?  I'm not sure yet.

It's not possible to keep a POLLOUT fd watch since poll(2) would return
instantly and the event loop would spin.  However, POLLHUP (G_IO_HUP)
might work.

Stefan

--fCmRXBY78W5odcVA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbISptAAoJEJykq7OBq3PIJzQH/i8dwBORqDXikSNgGw6NQaIQ
d0NdADXDYChbhkLkQgenhQ8PP6hZGKiqS14gelkA0QEDx+Bos1+9qG8o9VplpPja
1utEVq04R29j7oLU83YzFiM+l7F2KfU4yMWEGaQ9xq063jIc00dpudlCq8Rcls9w
ZWl3pENZDSYN5+0nUIJdGFJ3rEXNU5HlEcDtcR2aFlZr7hJKD/CFkZmiNWjzV+NL
AxC76+owa73nvkdbwf0/lE+dSUxVSzlZaqF5zdnmT0FxXDYtq0K8zjmIZlehd8Fd
EojZvllWIsaLiiv+OgAmZiqB5f6i948j7sfYFonYovcvW5hpjOQxN0Dj5KELeos=
=DTnv
-----END PGP SIGNATURE-----

--fCmRXBY78W5odcVA--
