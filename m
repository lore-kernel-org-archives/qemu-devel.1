Received: from eggs.gnu.org ([209.51.188.92]:60983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu5Ic-0001mJ-2L
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 19:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu5IV-0006aJ-NW
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 19:54:42 -0500
Date: Thu, 14 Feb 2019 11:15:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190214001557.GW1884@umbus.fritz.box>
References: <20190213172926.21740-1-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pAMbS1LL1U6QDnK3"
Content-Disposition: inline
In-Reply-To: <20190213172926.21740-1-farosas@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: fix out of bounds write in
 spapr_populate_drmem_v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--pAMbS1LL1U6QDnK3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 03:29:26PM -0200, Fabiano Rosas wrote:
> buf_len is uint8_t which is not large enough to hold the result of:
>=20
>   nr_entries * sizeof(struct sPAPRDrconfCellV2) + sizeof(uint32_t);
>=20
> for a nr_entries greater than 10.
>=20
> This causes the allocated buffer 'int_buf' to be smaller than expected
> and we eventually overwrite some of glibc's control structures (see
> "chunk" in https://sourceware.org/glibc/wiki/MallocInternals)
>=20
> The following error is seen while trying to free int_buf:
>=20
>   "free(): invalid next size (fast)"
>=20
> Fixes: a324d6f166 "spapr: Support ibm,dynamic-memory-v2 property"
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>

Ouch.  That was always bogus, we just got away with it before.

Applied to ppc-for-4.0.

> ---
>  hw/ppc/spapr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 332cba89d4..7c4bf8ed8c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -687,14 +687,14 @@ static int spapr_populate_drmem_v2(sPAPRMachineStat=
e *spapr, void *fdt,
>                                     int offset, MemoryDeviceInfoList *dim=
ms)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> -    uint8_t *int_buf, *cur_index, buf_len;
> +    uint8_t *int_buf, *cur_index;
>      int ret;
>      uint64_t lmb_size =3D SPAPR_MEMORY_BLOCK_SIZE;
>      uint64_t addr, cur_addr, size;
>      uint32_t nr_boot_lmbs =3D (machine->device_memory->base / lmb_size);
>      uint64_t mem_end =3D machine->device_memory->base +
>                         memory_region_size(&machine->device_memory->mr);
> -    uint32_t node, nr_entries =3D 0;
> +    uint32_t node, buf_len, nr_entries =3D 0;
>      sPAPRDRConnector *drc;
>      DrconfCellQueue *elem, *next;
>      MemoryDeviceInfoList *info;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pAMbS1LL1U6QDnK3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxkszoACgkQbDjKyiDZ
s5LBog//U+MZHFjR5bsxtujgPK1A6woKVQppOaUTJG6/XEY1K8zLn4YC/9q3+bIn
dNkD9KvvMBgtUfWExD5kIHgWB/oaR5Pk2EoHN1m+dlUqOU4voU6Q9bVN5UvCC5z0
hvTH8NxwsjIuIoqEGL82Dsb/Z0fGFiPB7JeTLu1sh4PuMNMHgIC8cDcMdvy1eZ09
7/qBQ90FdVCXK/JXEv1vrEFcVBjFgi5wjGHcn/8F8Jguc7seEHcu9EkmK2IPTa2w
mUwT4fJx3+rHLm3jYrgW6NV9p0W3nX8/8jY8o115Kur7tqryy4xEEOS0dlj4fPbG
tNA3PNOqcIu8lGzBssT8VJc4niuTsxr8qPt0Axhl/DXXk0I43bq49jo4COocUYIu
Sw2nE3BtWG3nS+y6PkI3ymznQnS5zHgekO3ihme1HqbFd1EIFOOcEJayO6sPZd0K
vWENCjsKZfDHa2XNz9QB8SVfN6tmLQoBmj2PQW0aGOJVf23iKgl9oGExZkdSrCMm
HCiQrq32HmokovizLPmzMAWIO//NHgpGAefAs+o70eIUyVL+YUBngpkKOVTYRLk+
1FMHH3nYXOBdizCVMbnbgAJD8qnGgjbUnh0Nnn/z73gc4pPIDhT5DHbgie6bna1f
w8F0tIqQ+b9ZeYnutuaZJ7/xr9unnJ2ZBH9CFsNq8K4d+qnP1Zs=
=/A84
-----END PGP SIGNATURE-----

--pAMbS1LL1U6QDnK3--
