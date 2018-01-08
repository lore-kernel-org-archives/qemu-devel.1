Received: from eggs.gnu.org ([2001:4830:134:3::10]:45588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYacO-00047V-Ck
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:49:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYacL-0005b0-RI
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:49:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eYacL-0005ae-Hf
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:49:45 -0500
Date: Mon, 8 Jan 2018 16:49:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180108164936.GG11758@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-16-peterx@redhat.com>
	<20171221112738.GL10812@lemon> <20171225032613.GD2443@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KIzF6Cje4W/osXrF"
Content-Disposition: inline
In-Reply-To: <20171225032613.GD2443@xz-mi>
Subject: Re: [Qemu-devel] [RFC v6 15/27] monitor: let suspend/resume work
 even with QMPs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--KIzF6Cje4W/osXrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2017 at 11:26:13AM +0800, Peter Xu wrote:
> On Thu, Dec 21, 2017 at 07:27:38PM +0800, Fam Zheng wrote:
> > On Tue, 12/19 16:45, Peter Xu wrote:
> > > One thing to mention is that for QMPs that are using IOThreads, we ne=
ed
> > > an explicit kick for the IOThread in case it is sleeping.
> > >=20
> > > Since at it, add traces for the operations.
> > >=20
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  monitor.c    | 26 +++++++++++++++++++++-----
> > >  trace-events |  1 +
> > >  2 files changed, 22 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/monitor.c b/monitor.c
> > > index 844508d134..5f05f2e9da 100644
> > > --- a/monitor.c
> > > +++ b/monitor.c
> > > @@ -3992,19 +3992,35 @@ static void monitor_command_cb(void *opaque, =
const char *cmdline,
> > > =20
> > >  int monitor_suspend(Monitor *mon)
> > >  {
> > > -    if (!mon->rs)
> > > -        return -ENOTTY;
> >=20
> > Please add to the commit message why the mon->rs check is dropped, for =
this and
> > the other one.
>=20
> I thought it would be clear enough since mon->rs is only used by HMP
> and the subject tells us that this patch is adding support for QMP.
> But... sure I can add one more sentence for that!

This change breaks hmp.c:hmp_migrate():

  if (monitor_suspend(mon) < 0) {
      monitor_printf(mon, "terminal does not allow synchronous "
                     "migration, continuing detached\n");
      return;
  }

mon->rs is used by HMP code to determine whether this is an interactive
terminal.  Both live migration and password prompting rely on this
because they must be forbidden when doing so would be impossible (e.g.
GDB stub tunneling HMP commands).

Suspending the QMP monitor is useful, but please don't break the HMP
code.

Stefan

--KIzF6Cje4W/osXrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaU6EgAAoJEJykq7OBq3PI7FUH/1p2gyJrv+g1gUtpm0/8PYf2
RBNGVh65kGvdpqs+RRBv/kmowzx/9gpI0V+s4s1syLgaHcXPhiWYQvL0fo4mqgK5
nXS2V80HLs5NfReJaHQH1wK97kNz9ObgwGluKizL9UszwtudNNzOYYKCaZuJwM+X
D39mwXuwtV6FFKGK4UusgDmhabI5EOwPZnEmS53GskLr9hWvy0iuqGfzd2rkFpkB
4Uw9U6ZTbCANyrITsNG9E1S9a1aOtzaXatZnl/UR5YYbY34+/aq0ghvjWlCotcyS
U4H1rYd0xCJrnyQ1v/h9Cy0ckisCaoIqPSDI+r5tORHKOFgkHaeL+JPUkQx1V+g=
=g39C
-----END PGP SIGNATURE-----

--KIzF6Cje4W/osXrF--
