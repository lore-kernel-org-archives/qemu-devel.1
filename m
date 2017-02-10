Received: from eggs.gnu.org ([2001:4830:134:3::10]:36353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc0ra-00065O-8I
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc0rZ-00024i-5e
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:06 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:43953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cc0rY-00022w-Nl
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:05 -0500
Date: Fri, 10 Feb 2017 12:15:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210011500.GT27610@umbus.fritz.box>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-6-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qUsYCxAE223BCwdt"
Content-Disposition: inline
In-Reply-To: <1486456099-7345-6-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 05/17] intel_iommu: simplify irq region
 translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com


--qUsYCxAE223BCwdt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 04:28:07PM +0800, Peter Xu wrote:
> Now we have a standalone memory region for MSI, all the irq region
> requests should be redirected there. Cleaning up the block with an
> assertion instead.
>=20
> Reviewed-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i386/intel_iommu.c | 28 ++++++----------------------
>  1 file changed, 6 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 50251c3..86d19bb 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -818,28 +818,12 @@ static void vtd_do_iommu_translate(VTDAddressSpace =
*vtd_as, PCIBus *bus,
>      bool writes =3D true;
>      VTDIOTLBEntry *iotlb_entry;
> =20
> -    /* Check if the request is in interrupt address range */
> -    if (vtd_is_interrupt_addr(addr)) {
> -        if (is_write) {
> -            /* FIXME: since we don't know the length of the access here,=
 we
> -             * treat Non-DWORD length write requests without PASID as
> -             * interrupt requests, too. Withoud interrupt remapping supp=
ort,
> -             * we just use 1:1 mapping.
> -             */
> -            VTD_DPRINTF(MMU, "write request to interrupt address "
> -                        "gpa 0x%"PRIx64, addr);
> -            entry->iova =3D addr & VTD_PAGE_MASK_4K;
> -            entry->translated_addr =3D addr & VTD_PAGE_MASK_4K;
> -            entry->addr_mask =3D ~VTD_PAGE_MASK_4K;
> -            entry->perm =3D IOMMU_WO;
> -            return;
> -        } else {
> -            VTD_DPRINTF(GENERAL, "error: read request from interrupt add=
ress "
> -                        "gpa 0x%"PRIx64, addr);
> -            vtd_report_dmar_fault(s, source_id, addr, VTD_FR_READ, is_wr=
ite);
> -            return;
> -        }
> -    }
> +    /*
> +     * We have standalone memory region for interrupt addresses, we
> +     * should never receive translation requests in this region.
> +     */
> +    assert(!vtd_is_interrupt_addr(addr));
> +
>      /* Try to fetch slpte form IOTLB */
>      iotlb_entry =3D vtd_lookup_iotlb(s, source_id, addr);
>      if (iotlb_entry) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qUsYCxAE223BCwdt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnRQUAAoJEGw4ysog2bOS+U8QAKQ0NgsunudNfAzAybQ03UhQ
KcurRJ/2NfBIYCxeT2GcFJXAJbNpEdz6tWS/K4cI+Du+Uo/xNAykrb2HspUAdD5z
JdSM8qsIwU780iIGUOfzdkEiKaKNNNQM27cuzuYK+kP82EX1pfuslXcWD2SsR7VZ
cLjp6bIIxpY9SSA9YFdQ8OvDOzrTwqJuL5u0pyp20LNne1W1uu0Wdpws7VBgmvKO
483usXHK5DadQFdwpF5SALxAakD3A//XCoSYXY7Wsh00llXtLGbYnhFIfNu+Cvk2
RrrsRvvULyxep6nIW2a9VS3C0Whna9QklWKyw8R27fNWx5JwZBJF3IaA9HzjLQR2
gwLFX8cZS/L2vXxDhamNQP1JJM/+n6SNmrna3bV5K7VTKiG6R22L30acHj+Lko39
ji60XdEhsoFnkQjtzEg8RKaorgFBqB9EupgpkYgROgMG1LSn9O+Y898+ucDEmGwk
3c+N+oZN1wvg7rx9AfLjgfJgT6p/6aDoUUvhMPTCWzrN64xmaXdH5n69AZGAAIdJ
T1SVbgriBQGtEXd1hQw/rwcnAyIiQITAaL5aRnXy3Dqbr4XtHDIV/LRCZTP8pEZF
6m+iCdlIppeIkoprOd35HD0iJE6hEy5omQEAdrkaxagC9Dimr+ClR3BzPyohMWn6
hVmjeogPK4rDbAUO9HZG
=s728
-----END PGP SIGNATURE-----

--qUsYCxAE223BCwdt--
