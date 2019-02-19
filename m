Received: from eggs.gnu.org ([209.51.188.92]:32805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvwdL-0003rK-9U
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 23:03:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvwdF-0002PM-MN
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 23:03:49 -0500
Date: Tue, 19 Feb 2019 14:49:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190219034917.GS9345@umbus.fritz.box>
References: <20190215170029.15641-1-clg@kaod.org>
	<20190215170029.15641-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3sseE1tnmEs+TkKq"
Content-Disposition: inline
In-Reply-To: <20190215170029.15641-6-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 05/12] target/ppc: Cleanup 64-bit MMU
 includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--3sseE1tnmEs+TkKq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 06:00:22PM +0100, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> To enable inlining more things, move #include of mmu-hash64.h and
> mmu-radix64.h to mmu-book3s-v3.h
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

I don't really get what this is in aid of, and it doesn't seem quite
right.

It's fair enough in mmu-book3s-v3.c.   But mmu-hash64.c handles 64-bit
hash MMUs earlier than V3 as well, so it doesn't really make sense for
it to get to mmu-hash64.c via an indirect include.

> ---
>  target/ppc/mmu-book3s-v3.h | 3 +++
>  hw/ppc/spapr_hcall.c       | 1 -
>  target/ppc/mmu-book3s-v3.c | 2 --
>  target/ppc/mmu-hash64.c    | 1 -
>  target/ppc/mmu-radix64.c   | 1 -
>  5 files changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> index 12ec0054c207..4e59742d7eac 100644
> --- a/target/ppc/mmu-book3s-v3.h
> +++ b/target/ppc/mmu-book3s-v3.h
> @@ -22,6 +22,9 @@
> =20
>  #ifndef CONFIG_USER_ONLY
> =20
> +#include "mmu-hash64.h"
> +#include "mmu-radix64.h"
> +
>  /*
>   * Partition table definitions
>   */
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index b47241ace62a..2f64c69a6abf 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -9,7 +9,6 @@
>  #include "helper_regs.h"
>  #include "hw/ppc/spapr.h"
>  #include "hw/ppc/spapr_cpu_core.h"
> -#include "mmu-hash64.h"
>  #include "cpu-models.h"
>  #include "trace.h"
>  #include "kvm_ppc.h"
> diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
> index a174e7efc57c..ccbae3213cc1 100644
> --- a/target/ppc/mmu-book3s-v3.c
> +++ b/target/ppc/mmu-book3s-v3.c
> @@ -19,9 +19,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include "mmu-hash64.h"
>  #include "mmu-book3s-v3.h"
> -#include "mmu-radix64.h"
> =20
>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>                                int mmu_idx)
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 1175b991d994..f6c822ef917b 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -24,7 +24,6 @@
>  #include "qemu/error-report.h"
>  #include "sysemu/hw_accel.h"
>  #include "kvm_ppc.h"
> -#include "mmu-hash64.h"
>  #include "exec/log.h"
>  #include "hw/hw.h"
>  #include "mmu-book3s-v3.h"
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index ab76cbc83530..5881efeb8598 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -25,7 +25,6 @@
>  #include "sysemu/kvm.h"
>  #include "kvm_ppc.h"
>  #include "exec/log.h"
> -#include "mmu-radix64.h"
>  #include "mmu-book3s-v3.h"
> =20
>  static bool ppc_radix64_get_fully_qualified_addr(CPUPPCState *env, vaddr=
 eaddr,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3sseE1tnmEs+TkKq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxrfL0ACgkQbDjKyiDZ
s5KBeQ/8CW9pcagUXoRw0h9B6xq0qcn9Me637dYstUA3ppoTKnahnpz0/21ifF3W
5VkU6qHnq5+5WzycLZUVZL3rtWizWltX/ajolgOosWJNzV5e5MHcOaHOjhvlV/QF
O+9Mdtg7Td2OSXSeh2g7+a3S8RIRplaMPutHcNaHLlFpxZvlDAhf7FhwS2Xz8jTd
vF5aHUUQxyPCkKBZ6fUeBJQwfv1l0a8iv1p9M/JbN1uC/WwHdjlbSxS7xbkS9AFg
bFXqb77fFFb35a4VB6fYkcfJG13PGtOtsxm3fT/gOaHSCCbEzUUMUxqR2YcUN0J1
0dMjYiFj90ApcSti0Ftuztx5xTcyjYGshULRQ9UWp9+np/FOwQTxD28WpiS3pNs9
ZUU+PXvBCuvblLYunIqNkZ0lJr4OgG69AHvW9M2KkFVYReLEqAFPqxIzh66DhLB0
XOZGAuB0/5Q6+gWlXSTisMXKXfNXa25tDmDGGMS9npDKVah2oTq3s3+4z5Fa2cye
qjb3Hymia/6fnOYT90Qjtf/MO+E6FkKvhgXuz13fordmEyZALgaR0VRS3G1eCMy0
rkgcEYJyvnREImrLvBZhoJjwKxIhkjKv9+DHGIazQF8oECTlMq4YFVcaMAUhWslH
lPH5iSXY2Ux2m+ohanazVfP7DJlLNrwxLG0kKt1imbmWRvTY7JI=
=HpDu
-----END PGP SIGNATURE-----

--3sseE1tnmEs+TkKq--
