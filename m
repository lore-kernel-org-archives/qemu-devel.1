Received: from eggs.gnu.org ([2001:4830:134:3::10]:44880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYmLl-0006a5-8Y
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 23:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYmLk-0003G2-2r
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 23:16:53 -0500
Date: Wed, 1 Feb 2017 15:04:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170201040404.GM30639@umbus.fritz.box>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-8-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kkcDP0v44wDpNmbp"
Content-Disposition: inline
In-Reply-To: <1484288903-18807-8-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 07/17] target/ppc/POWER9: Add partition
 table pointer to sPAPRMachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org


--kkcDP0v44wDpNmbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 05:28:13PM +1100, Suraj Jitindar Singh wrote:
> POWER9 uses a partition table to store information relating to how
> address translation is performed on a per partition basis.
>=20
> Add a data area for this to the sPAPRMachineState struct and (re)allocate
> it on machine reset.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Hm.  I'm having trouble understanding this one.

IIUC, for the "pseries" machine type this partition table entry is
essentially a dummy one, since there's actually only one partition.
For KVM the machine would be represented by one of many partition
table entries on the real host - so the entry here isn't really
relevant.  For TCG, I'm not sure what would be looking at it.  We
haven't implemented the partition->host level translation in TCG
anyway, and in any case pseries (rather than powernv) should be
bypassing that - in which case I'd expect it to bypass looking at the
dummy partition table entry as well.

> ---
>  hw/ppc/spapr.c         | 38 ++++++++++++++++++++++++++++++++------
>  include/hw/ppc/spapr.h |  1 +
>  target/ppc/mmu.h       | 13 +++++++++++++
>  3 files changed, 46 insertions(+), 6 deletions(-)
>  create mode 100644 target/ppc/mmu.h
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 208ef7b..45bd2de 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -41,6 +41,7 @@
>  #include "migration/migration.h"
>  #include "mmu-hash64.h"
>  #include "qom/cpu.h"
> +#include "mmu.h"
> =20
>  #include "hw/boards.h"
>  #include "hw/ppc/ppc.h"
> @@ -1115,6 +1116,26 @@ static void spapr_reallocate_hpt(sPAPRMachineState=
 *spapr, int shift,
>      }
>  }
> =20
> +static void spapr_reallocate_patb(sPAPRMachineState *spapr, Error **errp)
> +{
> +    g_free(spapr->patb);
> +    spapr->patb =3D NULL;
> +
> +    if (!kvm_enabled()) {
> +        /* We need to allocate a partition table entry */
> +        size_t size =3D sizeof(struct patb_entry);
> +
> +        spapr->patb =3D qemu_memalign(size, size);
> +        if (!spapr->patb) {
> +            error_setg_errno(errp, errno, "Could not allocate memory for=
 "
> +                                          "partition table entry");
> +            return;
> +        }
> +
> +        memset(spapr->patb, 0, size);
> +    }
> +}
> +
>  static void find_unknown_sysbus_device(SysBusDevice *sbdev, void *opaque)
>  {
>      bool matched =3D false;
> @@ -1134,7 +1155,7 @@ static void ppc_spapr_reset(void)
>  {
>      MachineState *machine =3D MACHINE(qdev_get_machine());
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> -    PowerPCCPU *first_ppc_cpu;
> +    PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
>      uint32_t rtas_limit;
>      hwaddr rtas_addr, fdt_addr;
>      void *fdt;
> @@ -1143,10 +1164,16 @@ static void ppc_spapr_reset(void)
>      /* Check for unknown sysbus devices */
>      foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
> =20
> -    /* Allocate and/or reset the hash page table */
> -    spapr_reallocate_hpt(spapr,
> -                         spapr_hpt_shift_for_ramsize(machine->maxram_siz=
e),
> -                         &error_fatal);
> +    switch (first_ppc_cpu->env.mmu_model) {
> +    case POWERPC_MMU_3_00:
> +        /* Allocate the partition table */
> +        spapr_reallocate_patb(spapr, &error_fatal);
> +    default:
> +        /* Allocate and/or reset the hash page table */
> +        spapr_reallocate_hpt(spapr,
> +                             spapr_hpt_shift_for_ramsize(machine->maxram=
_size),
> +                             &error_fatal);
> +    }
> =20
>      /* Update the RMA size if necessary */
>      if (spapr->vrma_adjust) {
> @@ -1193,7 +1220,6 @@ static void ppc_spapr_reset(void)
>      g_free(fdt);
> =20
>      /* Set up the entry state */
> -    first_ppc_cpu =3D POWERPC_CPU(first_cpu);
>      first_ppc_cpu->env.gpr[3] =3D fdt_addr;
>      first_ppc_cpu->env.gpr[5] =3D 0;
>      first_cpu->halted =3D 0;
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index bd5bcf7..b654773 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -63,6 +63,7 @@ struct sPAPRMachineState {
> =20
>      void *htab;
>      uint32_t htab_shift;
> +    void *patb;
>      hwaddr rma_size;
>      int vrma_adjust;
>      ssize_t rtas_size;
> diff --git a/target/ppc/mmu.h b/target/ppc/mmu.h
> new file mode 100644
> index 0000000..67b9707
> --- /dev/null
> +++ b/target/ppc/mmu.h
> @@ -0,0 +1,13 @@
> +#ifndef MMU_H
> +#define MMU_H
> +
> +#ifndef CONFIG_USER_ONLY
> +
> +/* Partition Table Entry */
> +struct patb_entry {
> +    uint64_t patbe0, patbe1;
> +};
> +
> +#endif /* CONFIG_USER_ONLY */
> +
> +#endif /* MMU_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kkcDP0v44wDpNmbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkV4yAAoJEGw4ysog2bOSZvgP/j57naWMZ3rZ5EQK1AXNuUQQ
SnZiRIV9GKe0SUnOSvodc0/tkrU3ipOrjWnn9IcuvnjB0r216HdxwqV7e1xI0mJY
TXdM+m+GphwvQwjOmZkh1Pw2PxRVhx/cOU7y5Nfb4mtfY0gxyMTMWR5Wmda8jPzS
g2bEkNMYSq/FIr9kgNug/bnpyZGOfQ+YRWhUBDPhU4fCLu4S4l2TkiV5vcVQjPwg
iL6N1uEMpeZeTu30iEPOeCd5guC5JcLQ8gPPEXTmJRQn6JHwqncuIPvX7cK5Akr+
LYPoJpKzgCcVIc4FP9kbA/prdFE+M9XzPpwONiEcpHsOiA+s9Pvx2ADV47DbbjoN
XwThjZ/9s2t4s9tsT4DOZwIOHS9eKLIFLQtVOrgqLb16rjODcSIb1R1cUz+S0tQ1
7GLDgR00JfRdC2uAq/EU+ZolgpvCLL5Ty32fhnPUFLzh1IkzgiucexWV03k3zcCx
SVh1TlbQCwsikO0Ro/GQ1QKJjKdJXSweuQiEpBB/cokLoTl+pmw55DERJ80iQ3Ke
Xf6XiQwsGpVxI5l/4aA3v8+NSvlb7O1RbmRGJxi7FGBhfUGwfWAT8UPG+OWBUjqs
j4TRO70gaE7JtOMVplA5lPS4wQrXsIOLxKplS6WmaMILkNwSl1PJG5uNQ6/jerGe
qZETc2noLcm6N0YUm3DY
=fJBR
-----END PGP SIGNATURE-----

--kkcDP0v44wDpNmbp--
