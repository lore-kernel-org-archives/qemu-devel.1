Received: from eggs.gnu.org ([2001:4830:134:3::10]:50036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsGdM-0000Ha-RU
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 18:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsGdJ-0008EU-1Z
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 18:59:52 -0400
Date: Wed, 13 Sep 2017 23:17:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170913131748.GF3972@umbus.fritz.box>
References: <150512970330.16081.7553039475680302776.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E7i4zwmWs5DOuDSH"
Content-Disposition: inline
In-Reply-To: <150512970330.16081.7553039475680302776.stgit@bahia>
Subject: Re: [Qemu-devel] [RFC PATCH] spapr_pci: make index property
 mandatory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>


--E7i4zwmWs5DOuDSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 01:35:03PM +0200, Greg Kurz wrote:
> Creating several PHBs without index property confuses the DRC code
> and causes issues:
> - only the first index-less PHB is functional, the other ones will
>   silently ignore hotplugging of PCI devices
> - QEMU will even terminate if these PHBs have cold-plugged devices
>=20
> qemu-system-ppc64: -device virtio-net,bus=3Dpci2.0: an attached device
>  is still awaiting release
>=20
> This happens because DR connectors for child PCI devices are created
> with a DRC index that is derived from the PHB's index property. If the
> PHBs are created without index, then the same value of -1 is used to
> compute the DRC indexes for both PHBs, hence causing the collision.
>=20
> Also, the index property is used to compute the placement of the PHB's
> memory regions. It is limited to 31 or 255, depending on the machine
> type version. This fits well with the requirements of DRC indexes, which
> need the PHB index to be a 16-bit value.
>=20
> This patch hence makes the index property mandatory. As a consequence,
> the PHB's memory regions and BUID are now always configured according
> to the index, and it is no longer possible to set them from the command
> line. This is a reasonable trade-off, as it is very unlikely that people
> create PHBs without index (at least libvirt doesn't do it FWIW).
>=20
> We have to introduce a PHB instance init function to initialize the
> 64-bit window address to -1 because pseries-2.7 and older machines
> don't set it.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>=20
> Hi,
>=20
> This is a proposal to address the issue uncovered during the review of the
> PHB hotplug patches:
>=20
> https://lists.nongnu.org/archive/html/qemu-ppc/2017-07/msg00557.html
>=20
> I'd like to address this properly before resuming work on PHB hotplug
> itself. Please comment.

Yes, I think this looks good.  Commit message should explicitly
mention that this does break backwards compat - but we don't think the
non-index PHB feature was used in practice and the simplification is
worth it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E7i4zwmWs5DOuDSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm5L/oACgkQbDjKyiDZ
s5Iatg//X6sLnIMZx/FeJXzccQsozHDpyxc0rRwtmdfGP/E2P0PyB831KPrXUldy
QMSGtqGXuIqU0hwnM9n+oCybZh6ZQ3QX8xwfwMJpylRtyfb/OkUyVbpfnMIM8hCy
0T53WPdT+xHHVFyAmzs3guZlcOm7bJ8l7SrbuHZBGLi5L6oANmoXwidllPd/xzNi
X5WoSke5/+gyXICchKIrwjFhuLlWQn3OVbJ2u3G9WesxAzvDzS7f4rx5oGcDvD8K
Ho4hY/mdaNUKf+9Al6nj9d+e1x6MbTJaoBZ1v+QvQywWrvi9NR7jkx/oTaNItyHJ
nTJoqh1eP+Si2Enmd0sFwPKtSKoMD6NQeSE0KXwUBOBGIFXS5x9d2/2SCiDpZZNj
fOmhH3A10GWwEcbQeK3E69iFYbWBn1XU1dmil9eHxdh7Izm7aEUchm0kmG4SKKX7
JUAaZ7L0Vfot6M9r/r6SQHOeSC7vx/MOaqQrUPoWBNU9U6xcuYlb8X10CUobxu8i
GqKk/UXgB8puLS1OQTwnFmjp0OV516v/GkT8IG8w6Cn/6rB8AmZs5B4vG7eTSUWY
0fXWpQDD3EopcbE3Uj3N49TtlbC6srgsQhPrhwcV9iFBmmcKEwgQzhXX1dlVL1gr
cDFhMwYF9r64tehge233cICpVQse2Una4HxcFx6ABKnQYYgexoE=
=fp2l
-----END PGP SIGNATURE-----

--E7i4zwmWs5DOuDSH--
