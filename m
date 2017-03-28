Received: from eggs.gnu.org ([2001:4830:134:3::10]:39454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cshJn-0007X1-BQ
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cshJm-0005yT-2S
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:57:11 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:56027)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cshJk-0005w6-Uz
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:57:09 -0400
Date: Tue, 28 Mar 2017 13:47:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170328024701.GA21068@umbus.fritz.box>
References: <20170327044030.31306-1-aik@ozlabs.ru>
	<d474bbee-94aa-d8d2-7369-71058fb8a099@redhat.com>
	<20170328000628.GA13461@umbus.fritz.box>
	<20170328053258-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20170328053258-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 05:33:48AM +0300, Michael S. Tsirkin wrote:
> On Tue, Mar 28, 2017 at 11:06:28AM +1100, David Gibson wrote:
> > On Mon, Mar 27, 2017 at 05:28:17PM +0200, Paolo Bonzini wrote:
> > >=20
> > >=20
> > > On 27/03/2017 06:40, Alexey Kardashevskiy wrote:
> > > > The recent introduction of a bus master container added
> > > > memory_region_add_subregion() into the PCI device registering path =
but
> > > > missed memory_region_del_subregion() in the unregistering path leav=
ing
> > > > a reference to the root memory region of the new container.
> > > >=20
> > > > This adds missing memory_region_del_subregion().
> > > >=20
> > > > Fixes: 3716d5902d743 ("pci: introduce a bus master container")
> > > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > > ---
> > > >  hw/pci/pci.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > index e6b08e1988..bd8043c460 100644
> > > > --- a/hw/pci/pci.c
> > > > +++ b/hw/pci/pci.c
> > > > @@ -869,6 +869,8 @@ static void do_pci_unregister_device(PCIDevice =
*pci_dev)
> > > >      pci_dev->bus->devices[pci_dev->devfn] =3D NULL;
> > > >      pci_config_free(pci_dev);
> > > > =20
> > > > +    memory_region_del_subregion(&pci_dev->bus_master_container_reg=
ion,
> > > > +                                &pci_dev->bus_master_enable_region=
);
> > > >      address_space_destroy(&pci_dev->bus_master_as);
> > > >  }
> > > > =20
> > > >=20
> > >=20
> > > My own review fail.  The enable subregion would be deleted when a mem=
ory
> > > region is finalized, but the enable subregions is keeping the owner
> > > alive.  And until the owner is alive, the container region is not
> > > deleted either.  So there is a reference count cycle, which we need to
> > > break.
> > >=20
> > > It's probably good to revisit commit 2e2b8eb ("memory: allow destroyi=
ng
> > > a non-empty MemoryRegion", 2015-10-01).  For 2.9,
> > >=20
> > > Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> >=20
> > Merged to ppc-for-2.9.
>=20
> I have it on pci branch, seems more appropriate.

Good point.  I've dropped it from my tree.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2c6jAAoJEGw4ysog2bOSooYP+gNdyl/T9xqZ9Gtkv+iROe/A
0hBPSsc+tkAMOieDVFARFMYl7esOPyQZ0TKBxMmee6G1L9LLsPIte3hmEB7YGuCt
wBmutosrKCyEaHe5lAyD2mw1vMrNb5rnmorJ97Y4kpvxM8vRKp+S1JMXRV048EfE
fMnTvxxtydt7GrjtFU7Yix0sy/isUrpO/9JhEOOGFxHX9I6p1l3h2o5vyb+l4JYP
NlOWQ3JXbKBPGun96bQTuDfa706EsDFARj02BS8VAlz5gmipldjW9QZB00pgwKHG
lfmAfW+axBmTQB7D4N3VBzo0e44bCcHdtkiqLNypvjtq262OBxlI/AASsZ1nnEF6
Bcg71Ff2/CZCZXy2emy+2rpGXOeLk3QlPgW9NaH7lGQuPfVTWraFAAFkt5CRHGe3
F6/LMmMzisM3Pax3ZMJseQzO/4IbmoxGyfwq0qGrCYwB/c3Nr3o672rxTOhn62mr
17Kcg7nAt4jwrIGTKALV9DMA7x46qSVbUs6QUtv1KZDBz9bxkhhy/kMmBBnN1yZ6
cn24Y4tRqJXQJH8xk7weJ34KMmBFgk3XYk9RM71jkwyoK0uspPxtuv9/6qULydNA
7YdFtWsxq9SYabuaKtk1bxxG04GO9HCKeMNGkapoMim7MgLdOK+09agkxluFhksc
CITJL6L4muBgWMfTwgzG
=GjZf
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
