Received: from eggs.gnu.org ([2001:4830:134:3::10]:33168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gOcDO-0000KI-Ch
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 00:35:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gOcDK-0003VM-Ib
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 00:35:18 -0500
Date: Mon, 19 Nov 2018 16:31:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181119053131.GJ23503@umbus>
References: <20181113083104.2692-1-aik@ozlabs.ru>
	<20181113083104.2692-6-aik@ozlabs.ru>
	<20181119024239.GF23503@umbus>
	<cb9e4cf1-7902-93ca-616f-c8d41cc3ff2b@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cN519qCC4CN1mUcX"
Content-Disposition: inline
In-Reply-To: <cb9e4cf1-7902-93ca-616f-c8d41cc3ff2b@ozlabs.ru>
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


--cN519qCC4CN1mUcX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2018 at 04:08:33PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 19/11/2018 13:42, David Gibson wrote:
> > On Tue, Nov 13, 2018 at 07:31:02PM +1100, Alexey Kardashevskiy wrote:
> >> When deciding about the huge DMA window, the typical Linux pseries gue=
st
> >> uses the maximum allowed RAM size as the upper limit. We did the same
> >> on QEMU side to match that logic. Now we are going to support GPU RAM
> >> pass through which is not available at the guest boot time as it requi=
res
> >> the guest driver interaction. As the result, the guest requests a smal=
ler
> >> window than it should. Therefore the guest needs to be patched to
> >> understand this new memory and so does QEMU.
> >>
> >> Instead of reimplementing here whatever solution we will choose for
> >> the guest, this advertises the biggest possible window size limited by
> >> 32 bit (as defined by LoPAPR).
> >>
> >> This seems to be safe as:
> >> 1. The guest visible emulated table is allocated in KVM (actual pages
> >> are allocated in page fault handler) and QEMU (actual pages are alloca=
ted
> >> when changed);
> >> 2. The hardware table (and corresponding userspace addresses cache)
> >> supports sparse allocation and also checks for locked_vm limit so
> >> it is unable to cause the host any damage.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >=20
> > This seems like a good idea to me, even without the NPU stuff.  It
> > always bothered me slightly that we based what's effectively the IOVA
> > limit on the guest RAM size which doesn't have any direct connection
> > to it.
> >=20
> > As long as it doesn't hit the locked memory limits, I don't see any
> > reason we should prevent a guest from doing something weird like
> > mapping a small bit of RAM over and over in IOVA space, or mapping its
> > RAM sparsely in IOVA space.
> >=20
> >> ---
> >>  hw/ppc/spapr_rtas_ddw.c | 19 +++----------------
> >>  1 file changed, 3 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/hw/ppc/spapr_rtas_ddw.c b/hw/ppc/spapr_rtas_ddw.c
> >> index 329feb1..df60351 100644
> >> --- a/hw/ppc/spapr_rtas_ddw.c
> >> +++ b/hw/ppc/spapr_rtas_ddw.c
> >> @@ -96,9 +96,8 @@ static void rtas_ibm_query_pe_dma_window(PowerPCCPU =
*cpu,
> >>                                           uint32_t nret, target_ulong =
rets)
> >>  {
> >>      sPAPRPHBState *sphb;
> >> -    uint64_t buid, max_window_size;
> >> +    uint64_t buid;
> >>      uint32_t avail, addr, pgmask =3D 0;
> >> -    MachineState *machine =3D MACHINE(spapr);
> >> =20
> >>      if ((nargs !=3D 3) || (nret !=3D 5)) {
> >>          goto param_error_exit;
> >> @@ -114,27 +113,15 @@ static void rtas_ibm_query_pe_dma_window(PowerPC=
CPU *cpu,
> >>      /* Translate page mask to LoPAPR format */
> >>      pgmask =3D spapr_page_mask_to_query_mask(sphb->page_size_mask);
> >> =20
> >> -    /*
> >> -     * This is "Largest contiguous block of TCEs allocated specifical=
ly
> >> -     * for (that is, are reserved for) this PE".
> >> -     * Return the maximum number as maximum supported RAM size was in=
 4K pages.
> >> -     */
> >> -    if (machine->ram_size =3D=3D machine->maxram_size) {
> >> -        max_window_size =3D machine->ram_size;
> >> -    } else {
> >> -        max_window_size =3D machine->device_memory->base +
> >> -                          memory_region_size(&machine->device_memory-=
>mr);
> >> -    }
> >> -
> >>      avail =3D SPAPR_PCI_DMA_MAX_WINDOWS - spapr_phb_get_active_win_nu=
m(sphb);
> >> =20
> >>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> >>      rtas_st(rets, 1, avail);
> >> -    rtas_st(rets, 2, max_window_size >> SPAPR_TCE_PAGE_SHIFT);
> >> +    rtas_st(rets, 2, 0xFFFFFFFF); /* Largest contiguous block of TCEs=
 */
> >=20
> > One detail though.. where does this limit actually come from?  Is it
> > actually a limit imposed by the hardware somewhere, or just because
> > the RTAS call doesn't ahve room for anything more?
>=20
> I used this limit just because of the parameter size.
>=20
> >=20
> > Previously limits would usually have been a power of 2; is it likely
> > to matter that now it won't be?
>=20
> LoPAPR says it is "Largest contiguous block of TCEs" and no mention of
> power of two but ibm,create-pe-dma-window takes a window shift so it is
> assumed that windows can still be only power of two. Not sure. The
> powernv code will fail if the requested window is not power of two.
>=20
> Replacing 0xffffffff with 0x80000000 won't make a difference though here
> but probably will make the error clearer...

Yeah, given that the windows have to be a power of 2 in size, I think
it makes sense for this to be a power of 2, even if it doesn't
strictly have to be.  So I think 0x80000000 would be a better option.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cN519qCC4CN1mUcX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvySrMACgkQbDjKyiDZ
s5Icpw/9EufIZG0HXtuip8KQCiUukQM1MoSel01zu1XfWZpRW8Zd+DmdUetlqDIS
5++eaftXEj+19QJ0W6bJ18+wIV9TBxdh1NO8PDAIijmeITfztEVisEo9E274PWKu
O6dQk2aJYums+t9Fct4i0tBvJcDDKRJbUG2HMC4zh2+pJ+NRikNn/oxPDWnXvbts
49HlF14TfNwc3pd433QB6y81eK7lByueEZRhvJ3Wuo3p7UQjLBzJ3gSt8rhcb5ms
STtoKmxRnEILqvTJl2eeLH12ym1n+ul0exn5u+bSsDEEYbanhCmtG/FvhSn5dbb9
53GZ0jnOmS5GpAgbQ/rxksOIwJY8l7rECBsltAn2O21ttxa9sINVuD3yS/5LRnHw
zO0DefJxgTlVxEER+/kn6ghGVwpom94NX9ZK+k7qNwHnXMf+07/pUal9xvjl2adO
wMrW3TwmEqGmM8pc+ix0bM1pC6NrsBEVDoQEDoQRWDhUPhQo3rgu8HBff2JGn1l2
3xo8GaFtWpdsTFF1wiTbQyKBA9L2n9c/vKdh03IbXqTvDK+rxzHJb6lzkMhyRZRR
NHSM0oAfCJsIVsJyLxBzxAhmT0qrMfQXztBWTnmPgpbLMZge865qd3/CcfyGRHT/
ymK5Sa3nwDgWQ9vc62K7MgcfDnPiyxThWw/kJJ90y3bvUvoOQu0=
=wkHr
-----END PGP SIGNATURE-----

--cN519qCC4CN1mUcX--
