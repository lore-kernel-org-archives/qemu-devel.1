Received: from eggs.gnu.org ([209.51.188.92]:56722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gva2I-0001vP-M5
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 22:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gva2H-0007XN-NP
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 22:56:06 -0500
Date: Mon, 18 Feb 2019 14:23:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190218032334.GA9345@umbus.fritz.box>
References: <20190215133005.15955-1-david@redhat.com>
	<20190215133005.15955-7-david@redhat.com>
	<0d3aba1b-2a6c-c8a8-b421-c6c2ad55e494@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <0d3aba1b-2a6c-c8a8-b421-c6c2ad55e494@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] tests/device-plug: Add memory
 unplug request test for spapr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 04:56:53PM +0100, Thomas Huth wrote:
> On 15/02/2019 14.30, David Hildenbrand wrote:
> > We can easily test this, just like PCI.
> >=20
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  tests/device-plug-test.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >=20
> > diff --git a/tests/device-plug-test.c b/tests/device-plug-test.c
> > index ec6cb5de7b..4c581319c0 100644
> > --- a/tests/device-plug-test.c
> > +++ b/tests/device-plug-test.c
> > @@ -116,6 +116,22 @@ static void test_spapr_cpu_unplug_request(void)
> >      qtest_quit(qtest);
> >  }
> > =20
> > +static void test_spapr_memory_unplug_request(void)
> > +{
> > +    QTestState *qtest;
> > +
> > +    qtest =3D qtest_initf("-m 1G,slots=3D1,maxmem=3D2G "
> > +                        "-object memory-backend-ram,id=3Dmem0,size=3D1=
G "
> > +                        "-device pc-dimm,id=3Ddev0,memdev=3Dmem0");
> > +
> > +    /* similar to test_pci_unplug_request */
> > +    device_del_request(qtest, "dev0");
> > +    system_reset(qtest);
> > +    wait_device_deleted_event(qtest, "dev0");
> > +
> > +    qtest_quit(qtest);
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >      const char *arch =3D qtest_get_arch();
> > @@ -140,5 +156,10 @@ int main(int argc, char **argv)
> >                         test_spapr_cpu_unplug_request);
> >      }
> > =20
> > +    if (!strcmp(arch, "ppc64")) {
> > +        qtest_add_func("/device-plug/spapr_memory_unplug_request",
> > +                       test_spapr_memory_unplug_request);
> > +    }
> > +
> >      return g_test_run();
> >  }
>=20
> I think I'd maybe use a smaller DIMM (256 MiB? 512 MiB), just in case
> the test runs on an overloaded CI system with memory constraints ... but
> anyway:

256MiB is the smallest we can do - that's the LMB size.  I'd suggest
512MiB so we're testing the logic that gathers the multiple LMBs for
the DIMM, since that's kind of hairy (it's basically the bridge
between the PAPR and qemu hotplug models which are quite different for
memory).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxqJTYACgkQbDjKyiDZ
s5KrYhAAryeMGrVp6IQGAwiHhK+CG4M3xoxj+djufRavPWA3aE9ArOY6wevlsARV
Ol2yW9MWqdt15/NBYRHjAZFs+gqhSOk5TVhXxvnO/z8Cc1jK+c+QUAGeFhQPpGEA
OKSA9vszbJz70cQzUtHp7jbIzJI0Yw/XLXhjelMZE8vy+Y/WG55RYyNTn+4aCUCW
W89qS7sHpLn6phkKTQNGUUBgxCY++8TBbHkNVvOwdetMsWSsaukLxHevSSmz7z1B
GMlBcwnK6LIN9O396qQtzfrHOWaE7LqXvcK3kbXMF/05mUmyR1B7fPlXMEBc3sj9
h58DjRwUO/iTLPu8zWjDayR6c7G5OZk9s5+K0EqisBdkzvaNs8IFZjBtmTu0YxvT
X+SHF+N4c9SJwPToLddYpDGtzvFZFa9qNCsUnPBo8j/YHgjF+5cONwinAirbwRS5
+/tLZ9EI6W2YgBSUbrk+V0mSfuXWmVRm4IZgqgABrkmsD3enpZbC9vDW55gdfu37
PErnaxDccGLYg7vOhn/ujPquZWl2BhpovD8pdvsDvH4+Ylr92UwYHN8Oq0F8Ly8q
xOAFbbYNjUxLlWKY0sVDJgXkwnMp2iFB/KtoF6fkJkDHmAPsCbwIhiAeaC8Mt2ne
XLjDO7OYmWNSWFnZI7GXSiJtVCVmm8uiM9XK8AMty3zCCK1Rcrw=
=bvKQ
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
