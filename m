Received: from eggs.gnu.org ([2001:4830:134:3::10]:44305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fRCgg-0008A3-KE
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fRCgc-0008Np-LT
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:23:58 -0400
Date: Fri, 8 Jun 2018 18:20:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180608082058.GQ3344@umbus.fritz.box>
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-3-david@redhat.com>
	<20180608093406.30c878ec@bahia.lan>
	<4f518685-fcdb-7c3a-35d3-5a26374e0604@redhat.com>
	<20180608094657.4043502f@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y9o+fgG4MNl0mnzl"
Content-Disposition: inline
In-Reply-To: <20180608094657.4043502f@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v1 2/8] spapr: no need to verify the node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>


--Y9o+fgG4MNl0mnzl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 09:46:57AM +0200, Greg Kurz wrote:
> On Fri, 8 Jun 2018 09:42:48 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
> > On 08.06.2018 09:34, Greg Kurz wrote:
> > > On Thu,  7 Jun 2018 18:52:12 +0200
> > > David Hildenbrand <david@redhat.com> wrote:
> > >  =20
> > >> The node property can always be queried and the value has already be=
en
> > >> verified in pc_dimm_realize().
> > >>
> > >> Signed-off-by: David Hildenbrand <david@redhat.com>
> > >> ---
> > >>  hw/ppc/spapr.c | 9 +--------
> > >>  1 file changed, 1 insertion(+), 8 deletions(-)
> > >>
> > >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > >> index 2375cbee12..d038f3243e 100644
> > >> --- a/hw/ppc/spapr.c
> > >> +++ b/hw/ppc/spapr.c
> > >> @@ -3578,14 +3578,7 @@ static void spapr_machine_device_plug(Hotplug=
Handler *hotplug_dev,
> > >>              error_setg(errp, "Memory hotplug not supported for this=
 machine");
> > >>              return;
> > >>          }
> > >> -        node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE=
_PROP, errp);
> > >> -        if (*errp) { =20
> > >=20
> > > Good riddance :)
> > >  =20
> > >> -            return;
> > >> -        }
> > >> -        if (node < 0 || node >=3D MAX_NODES) {
> > >> -            error_setg(errp, "Invaild node %d", node);
> > >> -            return;
> > >> -        }
> > >> +        node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE=
_PROP, NULL); =20
> > >=20
> > > Maybe pass &error_abort ? =20
> >=20
> > I'm using the same access scheme as in hw/acpi/memory_hotplug.c
> >=20
> > ("error ignored" vs. "error leads to an abort") - but this will actually
> > never fail. But I can use error_abort here, does not matter.
> >=20
>=20
> Heh, /me paranoid but this is David's call and he acked that already
> so I guess it's okay.

Actually, I missed this - error_abort is preferable.  That's general
the right choice for things that shouldn't ever fail.  This way if
they *do* fail we get a clear error immediately.

> Reviewed-by: Greg Kurz <groug@kaod.org>


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Y9o+fgG4MNl0mnzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsaPGcACgkQbDjKyiDZ
s5K42hAAk6oIV4PFzVaIH3UsR4yU1gPxsb5yG/4B9pirDlB0ZMXMm1xUngn/0N/P
jLf6JhQILpBkT66hh4vRWukrbZYATV9VabySsUuFWi2Orw6V/PJeIK86xiWsXAmv
tuNP80GVDvbaufcPYqgJREQk54pY+o2APSMCFwqR0ZU4+7pq74R1I1SduvQepRek
2+yFp5Fi/uerzq0U6xX5+LifqcmJZWYDC1fy5+32AYFlAGtKVXqQmeUddbbiQnvM
te3Riz6urmXlVVwHuBfLAkDB9lv+HnVIVdLtqwktmeDrih7ni2Flv30iYE3icqlV
yTGQjC1TDp30WcU8P3r5M20ZYAPV1wgEn5B5M9m/tqEFYiMBSspPVtq8lJFqjMn3
Nr5ubAwmoDSsD2Ae9esXXmjWEEw3EJCkgXnf8qRdp5nKzRidp75J7BxRtjYk1Jat
ToqOKOTTSzr3ygarLkvCKcyOIlOyweM8Q8HJb0KDjH1iJ9kbV+GYe39xT3FOCGv+
Dn2fVQdl0zPdqLpAiRUh5WG0kBxoBocOXPrPDEcHl0kCtzOCS3mrvEpPmQIVwkol
c0RXwHeLxE2GQo2kErQe/mFE8WEKNMWEK3h68725ct9XQJqgtpoIRkPsc8Q0Sfdg
CsQVgrWP49P8MErs5PM3Pupo5IuHE1o3dk6pkgxAWaf9MnE1FsA=
=UZzR
-----END PGP SIGNATURE-----

--Y9o+fgG4MNl0mnzl--
