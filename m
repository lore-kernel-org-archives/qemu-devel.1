Received: from eggs.gnu.org ([2001:4830:134:3::10]:34266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1diA6S-0007PQ-2N
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 22:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1diA6Q-0003ge-VM
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 22:00:08 -0400
Date: Thu, 17 Aug 2017 11:59:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170817015951.GE5509@umbus.fritz.box>
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
	<150287476880.9760.9354459130009292681.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o0ZfoUVt4BxPQnbU"
Content-Disposition: inline
In-Reply-To: <150287476880.9760.9354459130009292681.stgit@aravinda>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] ppc: spapr: Enable FWNMI capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2017 at 02:42:48PM +0530, Aravinda Prasad wrote:
> Enable the KVM capability KVM_CAP_PPC_FWNMI so that
> the KVM causes guest exit with NMI as exit reason
> when it encounters a machine check exception on the
> address belonging to a guest. Without this capability
> enabled, KVM redirects machine check exceptions to
> guest's 0x200 vector.
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr_rtas.c |   17 +++++++++++++++++
>  target/ppc/kvm.c    |    2 ++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 2f3c47b..c2a361a 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -47,6 +47,8 @@
>  #include "trace.h"
>  #include "hw/ppc/fdt.h"
> =20
> +extern int cap_fwnmi;

Ew.  as the style checker will tell you, bare externs in .c files are
frowned upon.  And the cap_* variables xertainly shouldn't be exported
=66rom kvm.c.

>  static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
>                                     uint32_t token, uint32_t nargs,
>                                     target_ulong args,
> @@ -354,7 +356,22 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>                                    target_ulong args,
>                                    uint32_t nret, target_ulong rets)
>  {
> +    int ret;
> +    CPUState *cs =3D CPU(cpu);
> +
> +    if (!cap_fwnmi) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    }
> +
>      spapr->guest_machine_check_addr =3D rtas_ld(args, 1);
> +
> +    ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
> +    if (ret < 0) {
> +        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> +        return;
> +    }
> +

Congratulations, you broke build on an x86 host.  Things that directly
call KVM need to go in kvm.c with suitable stubs for non-kvm builds.

>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> =20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 73f64ed..ca1ffa6 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -90,6 +90,7 @@ static int cap_htm;             /* Hardware transaction=
al memory support */
>  static int cap_mmu_radix;
>  static int cap_mmu_hash_v3;
>  static int cap_resize_hpt;
> +int cap_fwnmi;
> =20
>  static uint32_t debug_inst_opcode;
> =20
> @@ -147,6 +148,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_mmu_radix =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
>      cap_mmu_hash_v3 =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V=
3);
>      cap_resize_hpt =3D kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HP=
T);
> +    cap_fwnmi =3D kvm_check_extension(s, KVM_CAP_PPC_FWNMI);
> =20
>      if (!cap_interrupt_level) {
>          fprintf(stderr, "KVM: Couldn't find level irq capability. Expect=
 the "
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--o0ZfoUVt4BxPQnbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmU+JYACgkQbDjKyiDZ
s5IkhBAAwRABSYaMZ3WzC3dV3O+fZuWOd4WuzTEctxXQxsGs4Lf501cVf0BbUvAl
x0ChuSOK6qi/0hEqj8YcZU1dcqJJZzCLP6uMvE2VwF8+YVz3xASZCN0wEPwbSBTb
GondI8LKTl1cBx3J+P3K0ajhQgHrxQ+K2gaMkq4MaunzURVKnjOnCAkGDuvl/rlP
FtZRA3VJD9e7PsTMEClTOMWn4SwOAERKJLMC0w6BzByBJIHK5UE1eywzmKxfDNPK
Zo/1PwiugwSYBoHU1P/hww9/ghID8P0nRlpvslwgnMwyHTN0Kmtka0VA+5FEmPKd
JEyblIv/ZlxKKPLJzOZquvps3dV0EWkF37ZtIPMalGAVB6QNqLVxE9ylJmrLOyaG
s3fJJ+uhAXS7JaY6e+auDWZomNBwQLrayDK8C0zyynJGnD+d0H3Q2HB9rdrPoCb9
alIEi/gtevXpP14LmYWeabPLQeVgPFIA6O1PFOs0zSlo3seHbocD0xUlDgXcj2ky
HT01J8TuM/f1EOxKMcHKPe73QCdL+Rj2WNpeBYRp29AA0UAnXbehTH2/r7w9lz2X
VwrzHFsjQ0qAbltbORibaeFkxLhsQeQ722ts4ZPghFGij0zPox5cSiOvZklwuH3b
tmILMcsuYpiyg65n+Y5aItR98+3KnB1Sg95t5WN2W+UcU1ICl6Q=
=sOQp
-----END PGP SIGNATURE-----

--o0ZfoUVt4BxPQnbU--
