Received: from eggs.gnu.org ([2001:4830:134:3::10]:42574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coL30-0006B7-U4
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coL2z-0005yD-Uh
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:21:50 -0400
Date: Thu, 16 Mar 2017 10:21:39 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170316022139.GC11074@stefanha-x1.localdomain>
References: <20170310031521.630-1-eblake@redhat.com>
	<033881fe-b3d3-2c3a-48fc-c08691f2c9cb@redhat.com>
	<19efa7dc-fa97-410f-df4d-3962453dcd8e@redhat.com>
	<20170315101835.GF8147@stefanha-x1.localdomain>
	<20170315102644.GF7770@redhat.com>
	<20170315105924.GH7770@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <20170315105924.GH7770@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] mirror: Fix backwards mirror_yield
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2017 at 10:59:24AM +0000, Daniel P. Berrange wrote:
> On Wed, Mar 15, 2017 at 10:26:44AM +0000, Daniel P. Berrange wrote:
> > On Wed, Mar 15, 2017 at 06:18:35PM +0800, Stefan Hajnoczi wrote:
> > > On Fri, Mar 10, 2017 at 02:49:22PM -0600, Eric Blake wrote:
> > > > And here's where I'm stuck: the makefiles are broken.  Touching
> > > > scripts/tracetool/format/h.py does NOT cause tracetool to be re-run=
 by a
> > > > mere 'make'; I've had to resort to 'make -B block/trace.h-timestamp=
' to
> > > > get things to rebuild.  And this is in spite of the fact that h.py
> > > > _should_ be getting listed in $(tracetool-y) by trace/Makefile.objs=
, and
> > > > $(tracetool-y) is listed as a dependency of %/trace.h-timestamp in =
the
> > > > top-level Makefile.  I would appreciate anyone with advice or an id=
ea on
> > > > how to patch Makefile to get the dependency working without me havi=
ng to
> > > > manually kick it.
> > >=20
> > > Also CCing Daniel Berrange.  He recently touched the tracing Makefiles
> > > and may have ideas.
> >=20
> > I've been looking at this and I'm damned if I understand what's broken.
> > All the required dependancies look to be expressed in the Makefile
> >=20
> >   %/trace.h: %/trace.h-timestamp
> >   %/trace.h-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y)
> >=20
> > and $(tracetool-y) expands to the list of source files
> >=20
> >   tracetool-y =3D $(SRC_PATH)/scripts/tracetool.py
> >   tracetool-y +=3D $(shell find $(SRC_PATH)/scripts/tracetool -name "*.=
py")
> >=20
> >=20
> > If I do 'touch hw/net/trace-events', then hw/net/trace.h gets rebuilt,
> > but if do 'touch scripts/tracetool.py' it doesn't get built. So somehow
> > make seems to be dropping the $(tracetool-y) deps despite being listed
> > against the %/trace-h-timestamp file, and despite earlier deps on
> > trace-events being honoured
>=20
> Oh this is a fun one.  While the $(tracetool-y) variable *is* defined at
> the time the build rules execute, it is *not* defined at the time make
> evaluates dependancies, so it expanded to be empty ! I copied you on
> the easy fix

Nice find, thanks for the help!

Stefan

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYyfazAAoJEJykq7OBq3PI3bsH/2J8YFYJZ4UXoy5ad2ay3TW2
q3mB35XwBC5ftl8HiZ580lsO8SzWf841CsrkGVdJLUdRaixQKJqyDBWmnUuctCU9
ap0wcDbTPfdrfGf2+slUl4SVEb+EcXDZ7PpRfy1PMJMhtUFy+/Dv+WkNkZlqLW9t
zzZEVuxxPpUC7pNEbHDJfATBzWnfqqb/eM5E5r746vYf9GjyWUnrsLxMvP0Acz9r
GX/cje0tHnf8n8F0GiBeD1xedB0HTvK+b0QqFIKGnl7I/2RFOGiTsoW4CHqSF706
M5fpOi+/TjJ1qd5ukZqYQAFRBPCKv0nSv2G9FdN9KzcBelBrVVlxlrBxQoKT8zY=
=S/6h
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
