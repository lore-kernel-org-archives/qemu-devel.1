Received: from eggs.gnu.org ([2001:4830:134:3::10]:33193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd6Js-0004QR-TD
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 21:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd6Jp-0007vI-S0
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 21:24:48 -0500
Date: Mon, 13 Feb 2017 13:17:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170213021710.GP25381@umbus>
References: <1486704360-27361-1-git-send-email-sjitindarsingh@gmail.com>
	<1486704360-27361-6-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AwNVUpjOmSj7UnwZ"
Content-Disposition: inline
In-Reply-To: <1486704360-27361-6-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V2 05/10] target/ppc: Add
 patb_entry to sPAPRMachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com


--AwNVUpjOmSj7UnwZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 04:25:55PM +1100, Suraj Jitindar Singh wrote:
> ISA v3.00 adds the idea of a partition table which is used to store the
> address translation details for all partitions on the system. The partiti=
on
> table consists of double word entries indexed by partition id where the s=
econd
> double word contains the location of the process table in guest memory. T=
he
> process table is registered by the guest via a h-call.
>=20
> We need somewhere to store the address of the process table so we add an =
entry
> to the sPAPRMachineState struct called patb_entry to represent the second
> doubleword of a single partition table entry corresponding to the current
> guest. We need to store this value so we know if the guest is using radix=
 or
> hash translation and the location of the corresponding process table in g=
uest
> memory. Since we only have a single guest per qemu instance, we only need=
 one
> entry.
>=20
> Since the partition table is technically a hypervisor resource we require=
 that
> access to it is abstracted by the virtual hypervisor through the calls
> [set/get]_patbe(). Currently the value of the entry is never set (and thus
> defaults to 0 indicating hash), but it will be required to both implement
> POWER9 kvm support and tcg radix support.
>=20
> We also add this field to be migrated as part of the sPAPRMachineState as=
 we
> will need it on the receiving side as the guest will never tell us this
> information again and we need it to perform translation.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  hw/ppc/spapr.c         | 19 +++++++++++++++++++
>  include/hw/ppc/spapr.h |  1 +
>  target/ppc/cpu.h       |  2 ++
>  3 files changed, 22 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e465d7a..057adae 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1018,6 +1018,20 @@ static void emulate_spapr_hypercall(PPCVirtualHype=
rvisor *vhyp,
>      }
>  }
> =20
> +static void spapr_set_patbe(PPCVirtualHypervisor *vhyp, uint64_t val)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +
> +    spapr->patb_entry =3D val;
> +}
> +
> +static uint64_t spapr_get_patbe(PPCVirtualHypervisor *vhyp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());

So, it'll amount to the same thing of course, but using
SPAPR_MACHINE(vhyp) here is a little more logically correct.

> +
> +    return spapr->patb_entry;
> +}
> +
>  #define HPTE(_table, _i)   (void *)(((uint64_t *)(_table)) + ((_i) * 2))
>  #define HPTE_VALID(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_V=
ALID)
>  #define HPTE_DIRTY(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_H=
PTE_DIRTY)
> @@ -1141,6 +1155,8 @@ static void ppc_spapr_reset(void)
>      /* Check for unknown sysbus devices */
>      foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
> =20
> +    spapr->patb_entry =3D 0;

I'm assuming that the patb_entry has some control bits making this
distinguishable from a process table at GPA 0?

>      /* Allocate and/or reset the hash page table */
>      spapr_reallocate_hpt(spapr,
>                           spapr_hpt_shift_for_ramsize(machine->maxram_siz=
e),
> @@ -1340,6 +1356,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          VMSTATE_UINT64_TEST(rtc_offset, sPAPRMachineState, version_befor=
e_3),
> =20
>          VMSTATE_PPC_TIMEBASE_V(tb, sPAPRMachineState, 2),
> +        VMSTATE_UINT64(patb_entry, sPAPRMachineState),

Ah.. yeah, you can't just add things to the VMStateDescription,
because that'll break parsing of existing migration streams.  You
could bump the version, but that breaks backwards migration.

So, the usual approach here is to add a new optional subsection - see
vmstate_spapr_ov5_cas for an example.  In this case you could have the
=2Eneeded function return true only if pathb_entry !=3D 0 - so it won't be
transmitted for either POWER7/8 or for POWER9 in legacy mode, which
seems to make sense.

>          VMSTATE_END_OF_LIST()
>      },
>      .subsections =3D (const VMStateDescription*[]) {
> @@ -2733,6 +2750,8 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      nc->nmi_monitor_handler =3D spapr_nmi;
>      smc->phb_placement =3D spapr_phb_placement;
>      vhc->hypercall =3D emulate_spapr_hypercall;
> +    vhc->set_patbe =3D spapr_set_patbe;
> +    vhc->get_patbe =3D spapr_get_patbe;
>  }
> =20
>  static const TypeInfo spapr_machine_info =3D {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a2d8964..c6a929a 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -63,6 +63,7 @@ struct sPAPRMachineState {
> =20
>      void *htab;
>      uint32_t htab_shift;
> +    uint64_t patb_entry; /* Process tbl registed in H_REGISTER_PROCESS_T=
ABLE */
>      hwaddr rma_size;
>      int vrma_adjust;
>      ssize_t rtas_size;
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 425e79d..a148729 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1218,6 +1218,8 @@ struct PPCVirtualHypervisor {
>  struct PPCVirtualHypervisorClass {
>      InterfaceClass parent;
>      void (*hypercall)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
> +    void (*set_patbe)(PPCVirtualHypervisor *vhyp, uint64_t val);

So.. I don't actually see any situation that would require set_patbe.
We need get_patbe for the CPU code to get the process table addr from
the machine.  But the hypercall to set it is already in the machine,
so we don't need to go the other way.

> +    uint64_t (*get_patbe)(PPCVirtualHypervisor *vhyp);
>  };
> =20
>  #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AwNVUpjOmSj7UnwZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoRcjAAoJEGw4ysog2bOSL5cP/ieMae3AvWM/cKphB3Ef7AUI
o1ktZFigFqQMpBiLH7agj6Scs94dkyDIwEIPnbFGRemgU5iryneRGHr4ISyzJ20F
4Rmbqj6Dq4szm5n3TrZulhoFqMTxvSnCShtOAv+Wwoo9M64MbEY9H9kdt5fDaxM9
Hzbdnk6eb3uWbfH5u4LBEuMEoNXyrjmNYIHBJZefy+iJNFwFklLAxOgUrNV2Vm0R
BaC+4OZoboqBgRFWj3j2qNrF2gAN7pJo1riE4AlJjlYiwRTCSWrfdVC4MDhzOpXK
b6B3dBnIvxaGqw3nTg2eHDNCZkgUZKxOTjwDmUzokfrQu22B50USsYj62P70dozy
3r5zunmY70Vpq4ObDhtOEvLTIZgdBPPSvG5qr9BMoy1mqddjQrmiqRaxbWAr8HJe
SwmHxhukm0rT3WFijC5gFYy1V1Idr4JIpQWl2jt/veGn4okilPmPhCqX/5WevbjY
RVNlHp9+DfJEU3+ZPkO/kzUXYAsTCWHSwusG4qC/uLVmGaaVpSuA+nUmez+6hYKG
+aJvS5BJpBvhBLXWSu/QfPHOGKZd0gom49BB5Adqh6AqNLNDcFDB/Ta2oJlW8oCP
i5gkKUDLgrVPeWkbmL1wouu5nXMTrb7V6a0tQByO/5vHIVAVKndNfIxwkNHmnD1L
CTC0wimkofLRaYV0Cszy
=pTpD
-----END PGP SIGNATURE-----

--AwNVUpjOmSj7UnwZ--
