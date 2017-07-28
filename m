Received: from eggs.gnu.org ([2001:4830:134:3::10]:36292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dawr7-0003Ea-Gh
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dawr6-0007ps-Cy
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:26:29 -0400
Date: Fri, 28 Jul 2017 13:40:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170728034042.GD3098@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<07a10650-f216-99ea-fb48-286887279bf1@linux.vnet.ibm.com>
	<20170727183926.246b5beb@bahia.lan>
	<20bc63c9-0649-5b82-5042-61e7313cf833@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Content-Disposition: inline
In-Reply-To: <20bc63c9-0649-5b82-5042-61e7313cf833@ozlabs.ru>
Subject: Re: [Qemu-devel] [Qemu-ppc] [for-2.11 PATCH 00/26] spapr: add
 support for PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>


--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 01:27:05PM +1000, Alexey Kardashevskiy wrote:
> On 28/07/17 02:39, Greg Kurz wrote:
> > On Wed, 26 Jul 2017 17:31:17 -0300
> > Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> wrote:
> >=20
> >> I've tested the patch set using Greg's Github branch. It worked fine i=
n=20
> >> my tests
> >> using a Fedora 26 and an Ubuntu 17.04 guests. I have two observations
> >> though:
> >>
> >> 1 - This is not related to this patch set per se because it is=20
> >> reproducible on master, but
> >> I think it is interfering with this new feature.  There is a=20
> >> warning/error message in
> >> the kernel right after SLOF that goes:
> >>
> >> (...)
> >>   -> smp_release_cpus() =20
> >> spinning_secondaries =3D 0
> >>   <- smp_release_cpus()
> >> Linux ppc64le
> >> #1 SMP Mon Jul 1[    0.030450] pci 0000:00:02.0: of_irq_parse_pci:=20
> >> failed with rc=3D-22
> >> [    0.030552] pci 0000:00:0f.0: of_irq_parse_pci: failed with rc=3D-22
> >> [  OK  ] Started Security Auditing Service.
> >> (...)
> >>
> >=20
> > This is a regression in QEMU master introduced by this commit:
> >=20
> > commit b87680427e8a3ff682f66514e99a8344e7437247
> > Author: C=E9dric Le Goater <clg@kaod.org>
> > Date:   Wed Jul 5 19:13:15 2017 +0200
> >=20
> >     spapr: populate device tree depending on XIVE_EXPLOIT option
> >    =20
> >     When XIVE is supported, the device tree should be populated
> >     accordingly and the XIVE memory regions mapped to activate MMIOs.
> >    =20
> >     Depending on the design we choose, we could also allocate different
> >     ICS and ICP objects, or switch between objects. This needs to be
> >     discussed.
> >    =20
> >     Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >     Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > It is very similar to the issue that motivated the new KVMPPC_H_UPDATE_=
PHANDLE
> > hcall (see patch 24 and 26 in this series):
> >=20
> > - QEMU creates an "interrupt-controller" node with a phandle property
> >   with the value 0x1111
> > - QEMU passes the FDT to SLOF
> > - SLOF converts all references to the phandle to an SLOF internal value
> >=20
> > =3D> from now on (ie, until the next machine reset), the guest only kno=
ws
> >    the OF phandle.
> >=20
> > - during CAS, if we go XICS, we send back an updated FDT with the
> >   phandle of the "interrupt-controller" node reverted to 0x1111
> >=20
> > =3D> the guest complains because all cold-plugged devices nodes refer
> >    to the OF phandle, not 0x1111
> >=20
> > A solution is to use the value set by KVMPPC_H_UPDATE_PHANDLE during CAS
> > instead of 0x1111. I could verify it makes the guest warning disappear.
> >=20
> > I'll send a dedicated patchset to fix this in 2.10.
>=20
>=20
> The SLOF I pushed for 2.10 does not have it though. And the rest of XIVE =
is
> not targeted for 2.10 anyway. So imho the solution is reverting "spapr:
> populate device tree depending on XIVE_EXPLOIT option" for 2.10.

I agree, I've applied the revert to ppc-for-2.10 now.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll6sjcACgkQbDjKyiDZ
s5KRMxAAy/QfbtJSrn4bGo7EJyxNjeMU8Etv+kEdbA8gt52U7v0Dyg8fPme0tCuR
BuzOQN3v2KEcs6XVqUnBR2GjoB2PLgFXowWOjtjXaLnPtlUAiakNnNuX7qks/h2L
kFINTMzgzjNPh2dpjaCDVqOW7aPMAepZoTPS5rIsxeElL67ETuFJiORide6Xw74N
xqZOfN1hmXrmICZ9UIhJYYEzswbv1HFBQWsfzD1aeJmHM9jRA2a6onMhdyq4Tx4Q
OYkBLi9iHJ7yKOHHcXYnUMk3bGUfK6H64GB2oKiJbJQjx8MGb9dlOjHumqL+Fjjj
3RFtHm75rFsfG0/ut7aBWX+NwdHFSlp//hX04TJfOxfgLIA4zIkQEZuhoa/eIxtO
m43bnOKDiVJXQ80Kw0QORWViaI3cUtMjladViO7tEchRQdhM/8Exhv/UDj6tXiy/
KDW7oRn4M1giKYbzIJAPeHMCN9YMaWMQqNtraiBFMnV1rC9QJ6b7udWooayEFThZ
2MK86D3jEdoNgWx4MrZRCtUFfNTqbk/lpStp+U2e9k2ga8PPcKLjSHFKFEqp/zW7
jaiO/r4/ZD8GUZGPP2dpAgBPfyGGUkxxNn8tEG/YyjJcWlJHWoU9IPJDWgv/0QY0
jCdvPxkrC3/RSO9qBw12ue4hzHb/McIfVS5h9TGC8Acmk6240Rs=
=Rfei
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--
