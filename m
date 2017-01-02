Received: from eggs.gnu.org ([2001:4830:134:3::10]:35624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOCEe-0004sI-2e
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 18:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOCEc-0006JY-Go
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 18:41:48 -0500
Date: Tue, 3 Jan 2017 10:41:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170102234128.GI12761@umbus.fritz.box>
References: <20161222052212.49006-1-aik@ozlabs.ru>
	<20161222052212.49006-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="poJSiGMzRSvrLGLs"
Content-Disposition: inline
In-Reply-To: <20161222052212.49006-3-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu 2/2] spapr_pci: Advertise 16M IOMMU
 pages when available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--poJSiGMzRSvrLGLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 22, 2016 at 04:22:12PM +1100, Alexey Kardashevskiy wrote:
> On sPAPR, IOMMU page size varies and if QEMU is running with RAM
> backed with hugepages, we can advertise this to the guest so does
> this patch.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  hw/ppc/spapr_pci.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index fd6fc1d953..09244056fc 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1505,6 +1505,9 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>      }
> =20
>      /* DMA setup */
> +    /* This allows huge pages for IOMMU when guest is backed with huge p=
ages */
> +    sphb->page_size_mask |=3D qemu_getrampagesize();

This doesn't look right - you're unconditionally enabling the host ram
page size, regardless of anything else.  Instead the backing page size
should be used to filter out those sizes which are possible from the
list of those supported by the guest hardware.  This patch will give
particularly odd results if you ran it on x86 with hugepages for
example: it would advertise a 2M IOMMU page size, which could never
exist on native POWER.

Except... come to think of it, why is the backing RAM page size
relevant at all?  Or rather.. I think VFIO should be able to cope with
any guest IOMMU page size which is larger than the host ram page size
(although if it's much larger it could get expensive in the host
tables).  This case would already be routine for ppc64 on x86, where
the guest IOMMU page size is 64kiB, but the host page size is 4 kiB.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--poJSiGMzRSvrLGLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYauUoAAoJEGw4ysog2bOSM/0QAL78Eo/jpn6mZXMbEVjm+j9e
NMuwFQlPFRtO18LSqJFUVVf8b4nu7B0juDJq7VPYaCk6Bttqimm4MzYhwRCMmcOl
MVUSDZg4uPoUOIVDPRoUBEVrP3yNYZAEuOK8jNHsBLSBtUKAyQhAaMciQazPpVr5
g6lEF9tC/QpU/tbOfFx+pXFhWZh5OF5GgNDs0C06Y1YJJvs6lRQmgQHUCPbk7qFo
NjZfp0yn3UQVv813Ppjqco8pJ1LVYgx3qKAnMcD0lWSD9JelWI8GEdVaOX4M0arF
KQdtqbwRgvRNTk/DFwwwC5DtJAn60qDXaIhQ+R7FeoJpPqFqx+w6MP6Qxkd2JKmo
x4DTx7FS+vj34KSAxDALc/tgBeBNQztJ/PAtR6mT1HZrgqAagUzhycQoJcsSMaY6
o4GY6Dh/lLRUv2bMgpNAWYH5/UjqVIuwF8wWak+0cRV+SpoCGNQMdEoDaoss/XXs
/tLZLTaILKkmh/3K9JE2fJvQJZijJXmaF7oQVYZUCRfTLhrfHEwMXgaFXXXwBN0t
8VQ58Rze7n7Cvgf9WNSZOfcogmCxjFzKXH/wy3l8EMix3FI/7SYFBewVOUymoVzU
Uxpl6vrMDVP0vsn8efRMv6aI38lQ/CITBNkHYeq48HSX8jxaLFEpEhocWUfLDBTn
qPxxmSFZVEW6rvWQBEWW
=4wI5
-----END PGP SIGNATURE-----

--poJSiGMzRSvrLGLs--
