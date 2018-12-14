Received: from eggs.gnu.org ([2001:4830:134:3::10]:44263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXk4C-0007ds-3Z
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:47:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXk4A-0005vF-Q3
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:47:32 -0500
Date: Fri, 14 Dec 2018 17:01:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181214060126.GH29278@umbus.fritz.box>
References: <20181214042122.101921-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4LFBTxd4L5NLO6ly"
Content-Disposition: inline
In-Reply-To: <20181214042122.101921-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v2] spapr-iommu: Always advertise the
 maximum possible DMA window size
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


--4LFBTxd4L5NLO6ly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2018 at 03:21:22PM +1100, Alexey Kardashevskiy wrote:
> When deciding about the huge DMA window, the typical Linux pseries guest
> uses the maximum allowed RAM size as the upper limit. We did the same
> on QEMU side to match that logic. Now we are going to support a GPU RAM
> pass through which is not available at the guest boot time as it requires
> the guest driver interaction. As the result, the guest requests a smaller
> window than it should. Therefore the guest needs to be patched to
> understand this new memory and so does QEMU.
>=20
> Instead of reimplementing here whatever solution we choose for the guest,
> this advertises the biggest possible window size limited by 32 bit
> (as defined by LoPAPR). Since the window size has to be power-of-two
> (the create rtas call receives a window shift, not a size),
> this uses 0x8000.0000 as the maximum number of TCEs possible (rather than
> 32bit maximum of 0xffff.ffff).
>=20
> This is safe as:
> 1. The guest visible emulated table is allocated in KVM (actual pages
> are allocated in page fault handler) and QEMU (actual pages are allocated
> when updated);
> 2. The hardware table (and corresponding userspace address table)
> supports sparse allocation and also checks for locked_vm limit so
> it is unable to cause the host any damage.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to ppc-for-4.0.

> ---
> Changes:
> v2:
> * replaced 0xFFFFFFFF with 0x80000000 as a top limit
> ---
>  hw/ppc/spapr_rtas_ddw.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_rtas_ddw.c b/hw/ppc/spapr_rtas_ddw.c
> index 329feb1..cb8a410 100644
> --- a/hw/ppc/spapr_rtas_ddw.c
> +++ b/hw/ppc/spapr_rtas_ddw.c
> @@ -96,9 +96,8 @@ static void rtas_ibm_query_pe_dma_window(PowerPCCPU *cp=
u,
>                                           uint32_t nret, target_ulong ret=
s)
>  {
>      sPAPRPHBState *sphb;
> -    uint64_t buid, max_window_size;
> +    uint64_t buid;
>      uint32_t avail, addr, pgmask =3D 0;
> -    MachineState *machine =3D MACHINE(spapr);
> =20
>      if ((nargs !=3D 3) || (nret !=3D 5)) {
>          goto param_error_exit;
> @@ -114,27 +113,15 @@ static void rtas_ibm_query_pe_dma_window(PowerPCCPU=
 *cpu,
>      /* Translate page mask to LoPAPR format */
>      pgmask =3D spapr_page_mask_to_query_mask(sphb->page_size_mask);
> =20
> -    /*
> -     * This is "Largest contiguous block of TCEs allocated specifically
> -     * for (that is, are reserved for) this PE".
> -     * Return the maximum number as maximum supported RAM size was in 4K=
 pages.
> -     */
> -    if (machine->ram_size =3D=3D machine->maxram_size) {
> -        max_window_size =3D machine->ram_size;
> -    } else {
> -        max_window_size =3D machine->device_memory->base +
> -                          memory_region_size(&machine->device_memory->mr=
);
> -    }
> -
>      avail =3D SPAPR_PCI_DMA_MAX_WINDOWS - spapr_phb_get_active_win_num(s=
phb);
> =20
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>      rtas_st(rets, 1, avail);
> -    rtas_st(rets, 2, max_window_size >> SPAPR_TCE_PAGE_SHIFT);
> +    rtas_st(rets, 2, 0x80000000); /* The largest window we can possibly =
have */
>      rtas_st(rets, 3, pgmask);
>      rtas_st(rets, 4, 0); /* DMA migration mask, not supported */
> =20
> -    trace_spapr_iommu_ddw_query(buid, addr, avail, max_window_size, pgma=
sk);
> +    trace_spapr_iommu_ddw_query(buid, addr, avail, 0x80000000, pgmask);
>      return;
> =20
>  param_error_exit:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4LFBTxd4L5NLO6ly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwTRzIACgkQbDjKyiDZ
s5IelQ//VlmzaFH+PniYwaQUSb618OLXAgNvTNnUH6UAI3w6WeISz0skOvU5FEv9
89jljN7FlhzHKXbq8RxaAFBiotDM2UvfZ7y3vQzUJ98I/fI+mVjdoeKFxslzecJd
qm7wycKufA0V7ezN2wR7JqVacRAR+WbK3I/6gnEuMwqOlp1IcA2vvd98y/QtynYS
d2Px93XLU6dIb3xPiu7M/H+XCN5IF04aTg/17m0f8GloVPbuPN4bntDZhAbonEBl
TlanORDRl3+86jU7JqZ5yufcr+9f1LXEnaSoJDqt1FOd46VuLsGGXmkVjs8WjsHO
VidSiCK5wpNtluLFKu/4JFTHWOA3Wto3JTjxj/a2Dny6M8wTnBEFpR9TEUYvoOY6
LonEuPw6gf9VPWHsSMmn8yKGtSHsLhslJxFo+SImPsP35otaiBhF2hufejI65Twe
n+TX6U+f9xUD2HK6AZ133T+0uLO2KrnyWWgzFhAmUvM/cXcblqA+fW8wwNaILuqD
ONS9Kc59QKT5VVKULyQk+7fm/y036zh7xRHFhAA5BJ24VCRY9N5zY+OMbhgDi49h
rhn1wjqqZl3374hGckB8vPrCKW2f1zFE3zg4ICRzIe8AsbVdQI9yvhpCV1F7546N
KH2E/H01O0ZyxKSYVVtvzyq6ZgMJ/PuLfNUyqbAVtwRvT4p3+ac=
=4Ngl
-----END PGP SIGNATURE-----

--4LFBTxd4L5NLO6ly--
