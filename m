Received: from eggs.gnu.org ([209.51.188.92]:52012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu9Ar-00019y-8G
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 00:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu9Ap-0008Uo-Cu
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 00:03:01 -0500
Date: Thu, 14 Feb 2019 16:02:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190214050240.GC1884@umbus.fritz.box>
References: <20190117025115.81178-1-aik@ozlabs.ru>
	<fbe0ca8e-4d52-d59c-4f8d-9a1f473a81df@gmail.com>
	<b82674e7-cc41-6bba-2f9e-9882bfd7afbd@ozlabs.ru>
	<20190207081830.4dcbb822@x1.home>
	<295fa9ca-29c1-33e6-5168-8991bc0ef7b1@ozlabs.ru>
	<20190207202620.23e9c063@x1.home>
	<20190208052849.GB6434@umbus.fritz.box>
	<45e89e77-02ad-aebf-ab2f-e5e7f7e12ecb@ozlabs.ru>
	<20190210230711.29e88264@x1.home>
	<3dc97339-58c4-b0ce-ff2f-38bb099ccb57@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3+4H5zObBQkbFbMG"
Content-Disposition: inline
In-Reply-To: <3dc97339-58c4-b0ce-ff2f-38bb099ccb57@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu 0/3] spapr_pci,
 vfio: NVIDIA V100 + P9 passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>


--3+4H5zObBQkbFbMG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 06:46:32PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 11/02/2019 17:07, Alex Williamson wrote:
> > On Mon, 11 Feb 2019 14:49:49 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >=20
> >> On 08/02/2019 16:28, David Gibson wrote:
> >>> On Thu, Feb 07, 2019 at 08:26:20PM -0700, Alex Williamson wrote: =20
> >>>> On Fri, 8 Feb 2019 13:29:37 +1100
> >>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>> =20
> >>>>> On 08/02/2019 02:18, Alex Williamson wrote: =20
> >>>>>> On Thu, 7 Feb 2019 15:43:18 +1100
> >>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>>>>    =20
> >>>>>>> On 07/02/2019 04:22, Daniel Henrique Barboza wrote:   =20
> >>>>>>>> Based on this series, I've sent a Libvirt patch to allow a QEMU =
process
> >>>>>>>> to inherit IPC_LOCK when using VFIO passthrough with the Tesla V=
100
> >>>>>>>> GPU:
> >>>>>>>>
> >>>>>>>> https://www.redhat.com/archives/libvir-list/2019-February/msg002=
19.html
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> In that thread, Alex raised concerns about allowing QEMU to free=
ly lock
> >>>>>>>> all the memory it wants. Is this an issue to be considered in th=
e review
> >>>>>>>> of this series here?
> >>>>>>>>
> >>>>>>>> Reading the patches, specially patch 3/3, it seems to me that QE=
MU is
> >>>>>>>> going to lock the KVM memory to populate the NUMA node with memo=
ry
> >>>>>>>> of the GPU itself, so at first there is no risk of not taking ov=
er the
> >>>>>>>> host RAM.
> >>>>>>>> Am I missing something?     =20
> >>>>>>>
> >>>>>>>
> >>>>>>> The GPU memory belongs to the device and not visible to the host =
as
> >>>>>>> memory blocks and not covered by page structs, for the host it is=
 more
> >>>>>>> like MMIO which is passed through to the guest without that locked
> >>>>>>> accounting, I'd expect libvirt to keep working as usual except th=
at:
> >>>>>>>
> >>>>>>> when libvirt calculates the amount of memory needed for TCE tables
> >>>>>>> (which is guestRAM/64k*8), now it needs to use the end of the las=
t GPU
> >>>>>>> RAM window as a guest RAM size. For example, in QEMU HMP "info mt=
ree -f":
> >>>>>>>
> >>>>>>> FlatView #2
> >>>>>>>  AS "memory", root: system
> >>>>>>>  AS "cpu-memory-0", root: system
> >>>>>>>  Root memory region: system
> >>>>>>>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
> >>>>>>>   0000010000000000-0000011fffffffff (prio 0, ram): nvlink2-mr
> >>>>>>>
> >>>>>>> So previously the DMA window would cover 0x7fffffff+1, now it has=
 to
> >>>>>>> cover 0x11fffffffff+1.   =20
> >>>>>>
> >>>>>> This looks like a chicken and egg problem, you're saying libvirt n=
eeds
> >>>>>> to query mtree to understand the extent of the GPU layout, but we =
need
> >>>>>> to specify the locked memory limits in order for QEMU to start?  Is
> >>>>>> libvirt supposed to start the VM with unlimited locked memory and =
fix
> >>>>>> it at some indeterminate point in the future?  Run a dummy VM with
> >>>>>> unlimited locked memory in order to determine the limits for the r=
eal
> >>>>>> VM?  Neither of these sound practical.  Thanks,   =20
> >>>>>
> >>>>>
> >>>>> QEMU maps GPU RAM at known locations (which only depends on the vPH=
B's
> >>>>> index or can be set explicitely) and libvirt knows how many GPUs are
> >>>>> passed so it is quite easy to calculate the required amount of memo=
ry.
> >>>>>
> >>>>> Here is the window start calculation:
> >>>>> https://github.com/aik/qemu/commit/7073cad3ae7708d657e01672bcf53092=
808b54fb#diff-662409c2a5a150fe231d07ea8384b920R3812
> >>>>>
> >>>>> We do not exactly know the GPU RAM window size until QEMU reads it =
=66rom
> >>>>> VFIO/nvlink2 but we know that all existing hardware has a window of
> >>>>> 128GB (the adapters I have access to only have 16/32GB on board). =
=20
> >>>>
> >>>> So you're asking that libvirt add 128GB per GPU with magic nvlink
> >>>> properties, which may be 8x what's actually necessary and libvirt
> >>>> determines which GPUs to apply this to how?  Does libvirt need to so=
rt
> >>>> through device tree properties for this?  Thanks, =20
> >>>
> >>> Hm.  If the GPU memory is really separate from main RAM, which it
> >>> sounds like, I don't think it makes sense to account it against the
> >>> same locked memory limit as regular RAM. =20
> >>
> >>
> >> This is accounting for TCE table to cover GPU RAM, not for GPU RAM its=
elf.
> >>
> >> So I am asking libvirt to add 128GB/64k*8=3D16MB to the locked_vm. It
> >> already does so for the guest RAM.
> >=20
> > Why do host internal data structures count against the user's locked
> > memory limit?  We don't include IOMMU page tables or type1 accounting
> > structures on other archs.  Thanks,
>=20
> Because pseries guests create DMA windows dynamically and the userspace
> can pass multiple devices to a guest, placing each on its own vPHB each
> of which most likely will create an additional 64bit DMA window which is
> backed with an IOMMU table =3D> the userspace triggers these allocations.
> We account guest RAM once as it is shared among vPHBs but not the IOMMU
> tables.

Uh.. I think that's missing the point.

The real reason is that on x86, IOMMU page tables (IIUC) live within
guest memory, so they're essentially already accounted for.

Under PAPR, the IOMMU tables live outside the guest accessed via
hypercalls.  So, they consume hypervisor memory that the guest can
cause to be allocated.  We need to account that somewhere, so the
guest can't cause the hypervisor to allocate arbitrary amounts of
space.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3+4H5zObBQkbFbMG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxk9nAACgkQbDjKyiDZ
s5J/OhAA2aJvAcHeboFle6QGiZLUduM5o/BF5ueDVFjNFmuGFpHBMirMQEOOOaf+
dWSjqlHMgHZVDhGMyxPphVrIyIxiY1tlpKfes94kaa7xYsrxeiuy4vfhZeOvFdpb
A5Kwy8rUXoJKn02eBnXu23rJZKja2N3I2Bz3HlS/sFYpvaL5GXjkkM8k4D9poEOe
eEt6C9slYwmP5Qa9IvqH0ib8zFtUJ+qSB4vpj6mSpNpf3oTcbD9WAqnM9m/kMQUc
OA8PJTxGmsRkaLfAy2BmvevC9y9gDAQ2wFCC3NdCjwgVbFEYMZN9PrBn1h29jwW8
jBStFt+5qey0DOz8/FJLfqv1hxHgg2cdQ2uDNJhyxO0+fdcXDDpy5N6KcojaFmci
aVM/w99av2hUAjYQmgX7cW1SFmB/UCo8Uj1bXHdcll2ybfAu6kj1rrNUHED+ZAAz
g5IYTgSmm7IeTNiKX3Cgnk0gLVvnUZPKlIi9RxGdvLRIVSHVvn42uQ6N7RJxhYU8
FOU364RjZGmjYdStfisOLKRpNeMy5xcet6Kd7qE0xAv9K2u5qUSBwbam2YuyWJmK
Y7UjRHW5neMqY2+jsGiMZgQeVLsAgJ7RYcNTiFR8q1Bp+4NDmkI94hrawGePPoyq
2gTyVlz1/Nh+JjBYjHHLmPgk9yeOhvY42JiVEVBkhEUvV6ga8k4=
=Dpuk
-----END PGP SIGNATURE-----

--3+4H5zObBQkbFbMG--
