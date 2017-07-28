Received: from eggs.gnu.org ([2001:4830:134:3::10]:36351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dawrD-0003F8-0s
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dawr6-0007q0-DW
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:26:32 -0400
Date: Fri, 28 Jul 2017 14:09:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170728040913.GJ3098@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100580191.27487.17612552307249886496.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9Q2l3mYpK16UQ/iv"
Content-Disposition: inline
In-Reply-To: <150100580191.27487.17612552307249886496.stgit@bahia>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 25/26] spapr_pci: drop abusive
 sanity check when migrating the LSI table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--9Q2l3mYpK16UQ/iv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 08:03:21PM +0200, Greg Kurz wrote:
> The guest can allocate blocks of IRQs when calling the ibm,change-msi
> RTAS call. This has an impact on the IRQ numbers returned by subsequent
> calls to spapr_ics_alloc_block().
>=20
> It doesn't cause any problem right now because PHB are cold plugged and
> the LSI table have the same numbers at the destination and the source.
>=20
> But this won't be the case anymore when we support PHB hotplug. In this
> case the IRQ numbers in the LSI table are state that we should migrate.
>=20
> This patch hence changes the destination to always accept the LSI table
> from the migration stream, like it is already done for MSIs. No effort
> is made to preserve the current behavior of failing migration when LSI
> numbers are different with older machine types, for simplicity.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Urgh.  So, yes, there's a real problem here.  But fundamentally it's
because we're dynamically allocating the LSIs from a pool, rather than
having a fixed mapping (mea culpa, I did this in a bunch of places
before I knew better and it's come to bite us several times since).

Migrating the value like this will fix the problem, but I'm going to
have to think if it's the best way.  If we really do need an allocator
or something like it, then we'll have to migrate something - although
the fact that the LSIs will depend on the order you hotplug things is
kinda nasty still.

Making the LSIs fixed will address several other oddities in this
area, but will obviously been a wider ranging rework of the irq
assignment in the machine (and some machine version compatibility
cruft, of course).

> ---
>  hw/ppc/spapr_pci.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 58406a1b7e93..157867af8178 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1887,8 +1887,7 @@ static const VMStateDescription vmstate_spapr_pci_l=
si =3D {
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .fields =3D (VMStateField[]) {
> -        VMSTATE_UINT32_EQUAL(irq, struct spapr_pci_lsi, NULL),
> -
> +        VMSTATE_UINT32(irq, struct spapr_pci_lsi),
>          VMSTATE_END_OF_LIST()
>      },
>  };
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9Q2l3mYpK16UQ/iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll6uOkACgkQbDjKyiDZ
s5ISUw/+Pe2izh/onoZ1D227NBZpYMzv4tqaR6hYi+ZMMtta+SkYnuED2ZzPYpJ2
EaXzC5MHQcx0QS0JG8vqq6I0A31hHfqX/9Dmw2iGUav6Jb7IAU2zCABF/IfismRR
eE29hw27Ii6DdQSr0rq8oQFDE/13fBBhyGjkYyyu9Mz1zEfMTaF24khDz0ODc2Mh
CGi6/BJGUxr1tLhPkSGlVNrPeRjlSSFbqfmG/dw8+3XcPvWg/G1nKPbI2X8TjAWM
I+WiaL9eGrJoQbZvKzfMFV4RWNd5iZApVaOAjC+STxAj50z0p+6nBTrJZaBjq7kU
keJhCtrYr/l9GyXLJrpEF3hdmmRWqu17N5Mlr5+BdzhTzEPCHbeYcYEgt4sGIVPA
xet4IbC4RNQ71OOhuQNuSc/eGSeTPvQGfcpw23iZ2kRs5P3hDaLoyH8uTfS5PSWm
pZoLDz+Osi4gZyyJoTufMBuWxh+wIf4m2stuwGC9bLXEcmbzHjiQ0Q+gGo410rHa
ZbFSaNnJa5PDhmA8cdteVMslTFvImA9CSMrwkFOdSEomZT6JjAuFEBUAhEuup9M8
4ekGezRm4qN3oNDOPLZooGAi7ByZIToW5usM0/S7Byvzb3Q6zLA2w6VDO8BPC8Bh
s5EiOhtPe8N2vnjtZYuXqCFjP/PMrEa4KcWsHT+dihDp0mJsqVw=
=eebH
-----END PGP SIGNATURE-----

--9Q2l3mYpK16UQ/iv--
