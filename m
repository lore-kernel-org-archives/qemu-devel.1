Received: from eggs.gnu.org ([2001:4830:134:3::10]:46755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepp-0007cU-JY
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepn-0006yX-Q6
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:49 -0500
Date: Thu, 9 Feb 2017 13:51:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209025132.GX17644@umbus.fritz.box>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o/BvujNCPFVhiGON"
Content-Disposition: inline
In-Reply-To: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/9] ISA 3.00 KVM guest support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--o/BvujNCPFVhiGON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 01:56:43PM +1100, Sam Bobroff wrote:
>=20
> Because KVM will soon provide the necessary infrastructure for KVM guests=
 to
> run on POWER9 CPUs, we can now start exploiting this new functionality fr=
om
> QEMU. See:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-January/153433.html
>=20
> This work is not yet complete but it is functional and is presented for e=
arly
> review. It overlaps in some places with current work supporting the same =
guests
> under full emulation.
>=20
> This set aims to support only the following scenarios:
> * A POWER9 host running in radix mode, running a guest in radix mode.
> * A POWER9 host running in hash mode, running a guest in hash mode.
> * A POWER9 host running in hash mode, running a guest in legacy(+) mode.
> (+) Where legacy means that the guest does not support ISA 3.00.
>=20
> Hash or radix mode for the host is controlled via the "disable_radix" ker=
nel
> command line parameter: the host will use radix unless disable_radix is g=
iven.
> For the guest it should be automatically selected to match the host.
>=20
> Bad legacy guests: There are some recent kernels (e.g. 4.9) that will, wh=
en run
> as a KVM guest and if the ibm,pa-features entry in the device tree has the
> Radix MMU bit set, attempt to initialize the MMU as if they were a host (=
which
> will cause them to crash). To avoid exposing this problem, the Radix MMU =
bit
> is removed from ibm,pa-features when a legacy guest is detected.
>=20
> Prerequsites:
> * This set is based on current QEMU master, but relies on some work alrea=
dy posted here:
> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg02527.html
> Specifically patches 1..4 which set up the new CPU and MMU models.

Ok, I've merged 1/9 and reviewed the rest.

> Notes:
>     * Migration/snapshots are not yet investigated.

So, it's reasonable to avoid migration for now.  I'm even ok merging
something without migration support *IF* it isn't a silent failure:
i.e. it must have at least a stub that will fail the migration early
if it's in a mode that's not supported.

>     * If the host cannot support the guest (e.g. radix host and a legacy =
guest)
>       then the guest will crash but QEMU should probably terminate with a
>       descriptive message.

Uh, yes, that would certainly be better.
>=20
>=20
> Sam Bobroff (9):
>   spapr: fix off-by-one error in spapr_ovec_populate_dt()
>   Update headers using update-linux-headers.sh
>   spapr: Add ibm,processor-radix-AP-encodings to the device tree
>   target-ppc: support KVM_CAP_PPC_MMU_RADIX, KVM_CAP_PPC_MMU_HASH_V3
>   spapr: Only setup HTP if necessary.
>   spapr: Add h_register_process_table() hypercall
>   spapr: Set ISA 3.00 radix and hash bits in OV5
>   spapr: Advertise ISA 3.0 MMU features in pa_features
>   spapr: Small cleanup of PPC MMU enums
>=20
>  hw/ppc/spapr.c                                     | 152 +++++---
>  hw/ppc/spapr_hcall.c                               |  52 ++-
>  hw/ppc/spapr_ovec.c                                |   2 +-
>  include/hw/ppc/spapr.h                             |   4 +-
>  include/hw/ppc/spapr_ovec.h                        |   6 +
>  include/standard-headers/linux/input-event-codes.h |   2 +-
>  include/standard-headers/linux/pci_regs.h          |   8 +
>  include/standard-headers/linux/virtio_ids.h        |   1 +
>  linux-headers/asm-arm/kvm.h                        |   2 +
>  linux-headers/asm-arm/unistd.h                     | 419 +--------------=
------
>  linux-headers/asm-powerpc/kvm.h                    |  25 ++
>  linux-headers/asm-powerpc/unistd.h                 |   1 +
>  linux-headers/asm-x86/kvm_para.h                   |   4 +-
>  linux-headers/linux/kvm.h                          |  11 +-
>  linux-headers/linux/vfio.h                         |  10 +
>  target/ppc/cpu-qom.h                               |  12 +-
>  target/ppc/cpu.h                                   |   5 +
>  target/ppc/kvm.c                                   |  66 +++-
>  target/ppc/kvm_ppc.h                               |  13 +
>  target/ppc/mmu-hash64.c                            |  10 +-
>  target/ppc/mmu_helper.c                            |  67 ++--
>  target/ppc/translate.c                             |  12 +-
>  22 files changed, 346 insertions(+), 538 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--o/BvujNCPFVhiGON
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYm9k0AAoJEGw4ysog2bOS2AwQAKzMsFgKrOf6OrQrvcgC0PA+
aGQ/6atKKc3eit6hT1OhHXX951PvKR43vZElWv952n6y7a3yd9tdBJ2DUxP7jdBe
COD0k3aPuIMfZzywikU2Vlnf97cRJbKZGy880THwhjNGBHMv1+BfZ+aMYescdaLU
GSIdhvP3g6QbqgqbWzRWBuz+Sk6ExYTw7PEHsq++GUWcBYYZqn+O8Yb7Ow4W1TFt
hNwkttT0xCAvU9jsRwnm6Tdf4okwyD2MiNBoCI3gpoIarrKvLFKY3OgV+5SbC0Rx
lTEXfTrASYkRSS6iHujw/1X8XkuGHu031an24w1qoqfMLBvsBIdQrnT+1rU4X3Em
tspedoMZK551QHX6aA49zgjL5pIHSz3Fo56qd/mxGCf9kh6GpgT7X90DJgvkKYVJ
Z385xQDa7gQSRTezQ3pfawbE+bLdJzN1CJRhPW0/qosYEFWJ8l+fWBePbwc2rRYv
qK6jQgBMz5XNxG0EoN/qVGNpD3FFT+Rv1Z0YuVYIiO7pf+yMruSNee9u6gXzcTrS
SWwKzg5oq3LRs5aTKSbKe82lIS9cKGGGTwt0It1REA1yqa0BZadCeBfT2HnRzbam
+3Z6NsYTYmrJI0J4vdukrFQQk5RatvD3WQdjXJDi3fDqskYlL2pj777nRMjFahkl
ENDp8lK2d4+uEDIB7v3a
=DxQK
-----END PGP SIGNATURE-----

--o/BvujNCPFVhiGON--
