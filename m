Received: from eggs.gnu.org ([2001:4830:134:3::10]:51885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6UcW-00070j-DZ
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 01:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6UcU-0005Pm-Nv
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 01:18:04 -0400
Date: Thu, 12 Apr 2018 15:08:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180412050821.GL9425@umbus.fritz.box>
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TnYVF1hk1c8rpHiF"
Content-Disposition: inline
In-Reply-To: <1513815126.2743.34.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [PATCH v2 02/19] spapr: introduce a skeleton for
 the XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--TnYVF1hk1c8rpHiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2017 at 11:12:06AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2017-12-20 at 16:09 +1100, David Gibson wrote:
> >=20
> > As you've suggested in yourself, I think we might need to more
> > explicitly model the different components of the XIVE system.  As part
> > of that, I think you need to be clearer in this base skeleton about
> > exactly what component your XIVE object represents.
> >=20
> > If the answer is "the overall thing" I suspect that's not what you
> > want - I had one of those for XICs which proved to be a mistake
> > (eventually replaced by the XICSFabric interface).
> >=20
> > Changing the model later isn't impossible, but doing so without
> > breaking migration can be a real pain, so I think it's worth a
> > reasonable effort to try and get it right initially.
>=20
> Note: we do need to speed things up a bit, as having exploitation mode
> in KVM will significantly help with IPI performance among other things.
>=20
> I'm about ready to do the KVM bits. The one thing we need to discuss
> and figure a good design for is how we map all those interrupt control
> pages into qemu.
>=20
> Each interrupt (either PCIe pass-through or the "generic XIVE IPIs"
> which are used for guest IPIs and for vio/virtio/emulated interrupts)
> comes with a "control page" (ESB page) which needs to be mapped into
> the guest, and the generic IPIs also come with a trigger page which
> needs to be mapped into the guest for guest IPIs or OpenCAPI
> interrupts, or just qemu for emulated devices.
>=20
> Now that can be thousands of these critters. I certainly don't want to
> create thousands of VMAs in qemu and even less thousands of memory
> regions in KVM.
>=20
> So we need some kind of mechanism by wich a single large VMA gets
> mmap'ed into qemu (or maybe a couple of these, but not too many) and
> the interrupt pages can be assigned to slots in there and demand
> faulted.

Ok, I see your point.  We'll definitely need to be able to map things
in as a block, rather than one by one.

> For the generic interrupts, this can probably be covered by KVM, adding
> some arch ioctls for allocating IPIs and mmap'ing that region etc...
>=20
> For pass-through, it's trickier, we don't want to mmap each irqfd
> individually for the above reason, so we want to "link" them to KVM. We
> don't want to allow qemu to take control of any arbitrary interrupt in
> the system though, so it has to related to the ownership of the irqfd
> coming from vfio.
>=20
> OpenCAPI I suspect will be its own can of worms...
>=20
> Also, have we decided how the process of switching between XICS and
> XIVE will work vs. CAS ? And how that will interact with KVM ? I was
> thinking the kernel would implement a different KVM device type, ie
> the "emulated XICS" would remain KVM_DEV_TYPE_XICS and XIVE would be
> KVM_DEV_TYPE_XIVE.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TnYVF1hk1c8rpHiF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrO6cUACgkQbDjKyiDZ
s5Jy7hAAlPj+A1RKLfJh3zZlw4Q4wAndWRM8CscPpPr3Ks6oK7TgZvAaZ9z+4eA0
927RtPzj7DDI6nVAq0nYbAPLtL7v7Mi0ymExVbkEyRahEGhlV/Wq4bNNJ8MT4Fj2
Kj1ozj5LP2zbTVXYe4SGvfse/LhCFrFF/Rbny6kgTpe6UapV9melE7yEsHY42UPO
AeDlvawwY9O6rgpRNrNrPuRjSEE2RlL9DmmupmTeY6S29c0RFpdjEQDVOofP0mEC
w731/botMwJb5okz0vGnJriXF5f9gQP4XGZwJD+Cf7HPdxCYvs8tK+17HIMKK74Z
EFePy2xMvBmKtMZOskWnzKm9qVF1kOTbitF9Yy4/QpxLejLdf0crscgdIpd+CK9E
t4udVaPyi2BaVl1VM1+zLaEpUMccKNZQJ0rcVR9cxGvI0oxQQe2CwTL9vPJeBa8i
0/1vuR+7Nn9Kk7+l7ipDTzf2ONMMd+/qJ8gfJrL2bMruB1LzYbAiSl3ttcyIgm0b
GatrCbDgxYWYn0T6E3DmyiPoZRo8hjLQ1+14a4GogXXJt8uw/OPlm6+N8/YcFqSX
/x6zkXaXKjuZ8m3r4Cym6JlHoFESZNV/gEV1Une8qacniYwYIikyjSBGrVfE6Yzf
WJ4m4ZBVSEavzdTgHe4JV1fGmIrWT1GQpKmJyp998nTNuzRLEvE=
=+TWg
-----END PGP SIGNATURE-----

--TnYVF1hk1c8rpHiF--
