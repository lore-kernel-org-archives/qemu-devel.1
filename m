Received: from eggs.gnu.org ([2001:4830:134:3::10]:34092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gOZpG-0005vc-DD
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 22:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gOZpF-0002Fn-4t
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 22:02:14 -0500
Date: Mon, 19 Nov 2018 13:42:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181119024239.GF23503@umbus>
References: <20181113083104.2692-1-aik@ozlabs.ru>
	<20181113083104.2692-6-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V4b9U9vrdWczvw78"
Content-Disposition: inline
In-Reply-To: <20181113083104.2692-6-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu RFC 5/7] spapr-iommu: Always advertise
 the maximum possible DMA window size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alistair Popple <alistair@popple.id.au>, Reza Arbab <arbab@linux.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Oliver O'Halloran <oohall@gmail.com>


--V4b9U9vrdWczvw78
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 07:31:02PM +1100, Alexey Kardashevskiy wrote:
> When deciding about the huge DMA window, the typical Linux pseries guest
> uses the maximum allowed RAM size as the upper limit. We did the same
> on QEMU side to match that logic. Now we are going to support GPU RAM
> pass through which is not available at the guest boot time as it requires
> the guest driver interaction. As the result, the guest requests a smaller
> window than it should. Therefore the guest needs to be patched to
> understand this new memory and so does QEMU.
>=20
> Instead of reimplementing here whatever solution we will choose for
> the guest, this advertises the biggest possible window size limited by
> 32 bit (as defined by LoPAPR).
>=20
> This seems to be safe as:
> 1. The guest visible emulated table is allocated in KVM (actual pages
> are allocated in page fault handler) and QEMU (actual pages are allocated
> when changed);
> 2. The hardware table (and corresponding userspace addresses cache)
> supports sparse allocation and also checks for locked_vm limit so
> it is unable to cause the host any damage.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

This seems like a good idea to me, even without the NPU stuff.  It
always bothered me slightly that we based what's effectively the IOVA
limit on the guest RAM size which doesn't have any direct connection
to it.

As long as it doesn't hit the locked memory limits, I don't see any
reason we should prevent a guest from doing something weird like
mapping a small bit of RAM over and over in IOVA space, or mapping its
RAM sparsely in IOVA space.

> ---
>  hw/ppc/spapr_rtas_ddw.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_rtas_ddw.c b/hw/ppc/spapr_rtas_ddw.c
> index 329feb1..df60351 100644
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
> +    rtas_st(rets, 2, 0xFFFFFFFF); /* Largest contiguous block of TCEs */

One detail though.. where does this limit actually come from?  Is it
actually a limit imposed by the hardware somewhere, or just because
the RTAS call doesn't ahve room for anything more?

Previously limits would usually have been a power of 2; is it likely
to matter that now it won't be?

>      rtas_st(rets, 3, pgmask);
>      rtas_st(rets, 4, 0); /* DMA migration mask, not supported */
> =20
> -    trace_spapr_iommu_ddw_query(buid, addr, avail, max_window_size, pgma=
sk);
> +    trace_spapr_iommu_ddw_query(buid, addr, avail, 0xFFFFFFFF, pgmask);
>      return;
> =20
>  param_error_exit:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V4b9U9vrdWczvw78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvyIx8ACgkQbDjKyiDZ
s5Kplw//c4woqM6Si3JuVS8IF1KMA5zO9WWtkEjRFVcQ2d6BLgLKWwL4aKjmPf6J
hNbydn3HYSzMhXD0nvmiOIRLC4lJgufyao5UfZJ0HF6Zntaamy1yOTqk9y6SRqx+
9lqgxVC0i9cPxMXZgBdMXVKPyMnBe0T1OC5QkOZDkI9nKu57X8TvwS51m4z/cROl
nLY3+vVHleCD4+WUHC5qJ2q1UkL8kzMvxUKG+1wLZKi1TO4QhEj78pkYHQj5WP/v
mMvEqvf3UlIhpeDISLbhNHE5ArAoqpwsLsoTe8nCQl6T9XxJw4WzECa2RzImYZoN
71N/w4Og95ub34AgFZZg08kTZNJ/GbcAn+V8hG5zOb89L1T+Dm0/zSAMCc9F09GC
go5XmRYNuoag8HmD9BiQhf+OD6MWSPiv0T88vKEbnATVeN2SxbhNcKioSh5daqiZ
Vuu8Bygvr3QUUynLKAr/CxYEA3sJbFL5DdMQKOXFm2kBu4ZlGWsdNF4yiyWJcJk7
hvW6zY4ybqK70WsXBMvGGuwvxrpdcV6aSMDgsfAaQ/TgA9U0lzrKwreTJJ9BeTUX
A38DparBEDZxFa42qlADGQSpwGhV3fV50S3Aa0Ej6+f0FSdDmwuTWJv3lkutFLH1
NL52n2B8323MgcDqEBbxE2W2nWPMno36KKrtFh4NLAvgA2sB72M=
=0rbW
-----END PGP SIGNATURE-----

--V4b9U9vrdWczvw78--
