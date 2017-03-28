Received: from eggs.gnu.org ([2001:4830:134:3::10]:39122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csf7j-0002Ah-2T
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 20:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csf7h-00074a-RM
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 20:36:35 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:46651)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1csf7g-0006zI-Sn
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 20:36:33 -0400
Date: Tue, 28 Mar 2017 11:06:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170328000628.GA13461@umbus.fritz.box>
References: <20170327044030.31306-1-aik@ozlabs.ru>
	<d474bbee-94aa-d8d2-7369-71058fb8a099@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <d474bbee-94aa-d8d2-7369-71058fb8a099@redhat.com>
Subject: Re: [Qemu-devel] [PATCH qemu] pci: Add missing drop of bus master
 AS reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2017 at 05:28:17PM +0200, Paolo Bonzini wrote:
>=20
>=20
> On 27/03/2017 06:40, Alexey Kardashevskiy wrote:
> > The recent introduction of a bus master container added
> > memory_region_add_subregion() into the PCI device registering path but
> > missed memory_region_del_subregion() in the unregistering path leaving
> > a reference to the root memory region of the new container.
> >=20
> > This adds missing memory_region_del_subregion().
> >=20
> > Fixes: 3716d5902d743 ("pci: introduce a bus master container")
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >  hw/pci/pci.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index e6b08e1988..bd8043c460 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -869,6 +869,8 @@ static void do_pci_unregister_device(PCIDevice *pci=
_dev)
> >      pci_dev->bus->devices[pci_dev->devfn] =3D NULL;
> >      pci_config_free(pci_dev);
> > =20
> > +    memory_region_del_subregion(&pci_dev->bus_master_container_region,
> > +                                &pci_dev->bus_master_enable_region);
> >      address_space_destroy(&pci_dev->bus_master_as);
> >  }
> > =20
> >=20
>=20
> My own review fail.  The enable subregion would be deleted when a memory
> region is finalized, but the enable subregions is keeping the owner
> alive.  And until the owner is alive, the container region is not
> deleted either.  So there is a reference count cycle, which we need to
> break.
>=20
> It's probably good to revisit commit 2e2b8eb ("memory: allow destroying
> a non-empty MemoryRegion", 2015-10-01).  For 2.9,
>=20
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Merged to ppc-for-2.9.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2akCAAoJEGw4ysog2bOSB64QAKL10yYcULN+YjCvYvMJZXho
vwpyWLDiD+fAcj0Gp5U6o/2OAtbd7+uSQpHmkAsHpXEFrAEqS+rv2sbbsLYRvVEn
dOdFpC80qcF9NXenDhBFLxHNT8nAvNnSMYrVFNb23ooMEa1Cqc5myROeaLuPrbOv
aSEyktdFUj8hw1XqhtTfA5iZ+swUKufUSs7KUcaJX7hUBJb4ttBI7vTBP3SLNaVB
WJV0qpYSXPx8VF18JrWWzoCgpC80zQilrA4VJjWAdG+C1jK8zj3584WdEQ5uqhNf
iknHoWmIfeKRYgflMHQZIC05cr79YZbuECg03hUbltQxb6qjtJF2XLQ2GjviH/28
yA48CmTcR6Pu9isOXSqi3H4R5t7f5ylFAT4u+fMckJiAlWlUBUzd1vm1PCWCtvTk
7cncRSQxBMvlY+9XUDrXWgevoWqiO36AHc+EDIGbIg6kiE9I9i4j9lPPfrP5etKT
MxvD7+qAZ8QQRulJtwbJN8yTreU1ERw2msCm3XZTXaY4JH6BOyLIJeNmITNB+wOw
20YRS9QM6A2zA6+Wm4isrYsTFqk64UVt+H8H/D/mPG16nIOuSvUGwvjKfVau7xqQ
89Warqa+krgYAFW0L5gt2+zaAPDOgbXmXjzctZgxY/o7g6IPOmkVdTDloZtOdTf5
bSULN8EusBTNdAb9mp3d
=tHJ3
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
