Received: from eggs.gnu.org ([209.51.188.92]:42371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grzT3-0003Be-Gz
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 01:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grzT1-0004zf-LG
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 01:16:53 -0500
Date: Fri, 8 Feb 2019 16:28:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190208052849.GB6434@umbus.fritz.box>
References: <20190117025115.81178-1-aik@ozlabs.ru>
	<fbe0ca8e-4d52-d59c-4f8d-9a1f473a81df@gmail.com>
	<b82674e7-cc41-6bba-2f9e-9882bfd7afbd@ozlabs.ru>
	<20190207081830.4dcbb822@x1.home>
	<295fa9ca-29c1-33e6-5168-8991bc0ef7b1@ozlabs.ru>
	<20190207202620.23e9c063@x1.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <20190207202620.23e9c063@x1.home>
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 08:26:20PM -0700, Alex Williamson wrote:
> On Fri, 8 Feb 2019 13:29:37 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > On 08/02/2019 02:18, Alex Williamson wrote:
> > > On Thu, 7 Feb 2019 15:43:18 +1100
> > > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > >  =20
> > >> On 07/02/2019 04:22, Daniel Henrique Barboza wrote: =20
> > >>> Based on this series, I've sent a Libvirt patch to allow a QEMU pro=
cess
> > >>> to inherit IPC_LOCK when using VFIO passthrough with the Tesla V100
> > >>> GPU:
> > >>>
> > >>> https://www.redhat.com/archives/libvir-list/2019-February/msg00219.=
html
> > >>>
> > >>>
> > >>> In that thread, Alex raised concerns about allowing QEMU to freely =
lock
> > >>> all the memory it wants. Is this an issue to be considered in the r=
eview
> > >>> of this series here?
> > >>>
> > >>> Reading the patches, specially patch 3/3, it seems to me that QEMU =
is
> > >>> going to lock the KVM memory to populate the NUMA node with memory
> > >>> of the GPU itself, so at first there is no risk of not taking over =
the
> > >>> host RAM.
> > >>> Am I missing something?   =20
> > >>
> > >>
> > >> The GPU memory belongs to the device and not visible to the host as
> > >> memory blocks and not covered by page structs, for the host it is mo=
re
> > >> like MMIO which is passed through to the guest without that locked
> > >> accounting, I'd expect libvirt to keep working as usual except that:
> > >>
> > >> when libvirt calculates the amount of memory needed for TCE tables
> > >> (which is guestRAM/64k*8), now it needs to use the end of the last G=
PU
> > >> RAM window as a guest RAM size. For example, in QEMU HMP "info mtree=
 -f":
> > >>
> > >> FlatView #2
> > >>  AS "memory", root: system
> > >>  AS "cpu-memory-0", root: system
> > >>  Root memory region: system
> > >>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
> > >>   0000010000000000-0000011fffffffff (prio 0, ram): nvlink2-mr
> > >>
> > >> So previously the DMA window would cover 0x7fffffff+1, now it has to
> > >> cover 0x11fffffffff+1. =20
> > >=20
> > > This looks like a chicken and egg problem, you're saying libvirt needs
> > > to query mtree to understand the extent of the GPU layout, but we need
> > > to specify the locked memory limits in order for QEMU to start?  Is
> > > libvirt supposed to start the VM with unlimited locked memory and fix
> > > it at some indeterminate point in the future?  Run a dummy VM with
> > > unlimited locked memory in order to determine the limits for the real
> > > VM?  Neither of these sound practical.  Thanks, =20
> >=20
> >=20
> > QEMU maps GPU RAM at known locations (which only depends on the vPHB's
> > index or can be set explicitely) and libvirt knows how many GPUs are
> > passed so it is quite easy to calculate the required amount of memory.
> >=20
> > Here is the window start calculation:
> > https://github.com/aik/qemu/commit/7073cad3ae7708d657e01672bcf53092808b=
54fb#diff-662409c2a5a150fe231d07ea8384b920R3812
> >=20
> > We do not exactly know the GPU RAM window size until QEMU reads it from
> > VFIO/nvlink2 but we know that all existing hardware has a window of
> > 128GB (the adapters I have access to only have 16/32GB on board).
>=20
> So you're asking that libvirt add 128GB per GPU with magic nvlink
> properties, which may be 8x what's actually necessary and libvirt
> determines which GPUs to apply this to how?  Does libvirt need to sort
> through device tree properties for this?  Thanks,

Hm.  If the GPU memory is really separate from main RAM, which it
sounds like, I don't think it makes sense to account it against the
same locked memory limit as regular RAM.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxdE5EACgkQbDjKyiDZ
s5Llig//RA9jgl1MGVHFsK7w/Q6DhdOIL6BJYtpoYo/INkQD2CVwOLgp4B5uAUlm
1iJKBEb/hMmnzqBMkGVxBy0So/u7xrzYveBahgbC/z8iGo661vptJGrRGf2Q11bE
Nphidx2n/wofR1D8nwO/SU9ZJT6ubGI/Gm4BR3Ob48NROv3qFj+OpiNJ8mTbex95
n4xxkTpS4DAUu4iRORz5W9qAMFM2e6L/L3GuBZlb/ImpMzwC2+blSe7N2jkg6AJk
tKedxcap27c5y6Ha6oeMVT9mehF8NU3izJ9SIj00uRlfKkjoR75tL8j4lRjdgy2Q
V2AL3iNnw9WHhJEunh1pDMHh4G3EtM7odSk7quDBUi0hI5s3eegRakdiBXqyDDes
DJiTU4oAt7kKNPgIu8qRq48TP3fsEgXfS/rWJxWg006frjoBSLQhg4iOqCiJiCCA
gRzz7fcUespp1sTD7yVMzJJg808UYU0L22tUq+tZYE4DjeOCisFik7ZbU5D8fedv
Jwlq6tFj/I4vPEGB/Q+jLci0wibnSACyHPkZKfzCnFukI2jKKGjIFwKx/kzIEo6d
WIX77qyJ00XBznGImO0za5bkn1hXM5qmhs5uTIaI8bY7bezdNJ0KJKuGwcmePJCs
mkDxmhroFrSMNCGY6Afs7sQPeQpiuHyxU5sVkZ6rhMcF5Cj7OR8=
=383v
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
