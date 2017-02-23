Received: from eggs.gnu.org ([2001:4830:134:3::10]:50931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgkXe-0006ZD-Nk
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgkXd-0001T8-BE
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:58:06 -0500
Date: Thu, 23 Feb 2017 14:50:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223035046.GK12577@umbus.fritz.box>
References: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
	<1487563478-22265-6-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x/TyKPcLwmKZr+b7"
Content-Disposition: inline
In-Reply-To: <1487563478-22265-6-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V3 05/10] target/ppc: Add
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


--x/TyKPcLwmKZr+b7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:04:33PM +1100, Suraj Jitindar Singh wrote:
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

You've removed set_patb() as requested, but haven't updated the commit
message here.

> defaults to 0 indicating hash), but it will be required to both implement
> POWER9 kvm support and tcg radix support.
>=20
> We also add this field to be migrated as part of the sPAPRMachineState as=
 we
> will need it on the receiving side as the guest will never tell us this
> information again and we need it to perform translation.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

This looks fine, but will need some reworking to rebase on my
hpt-cleanup patch series.  That might even obsolete the new vhc call.

>=20
> ---
>=20
> V2->V3:
> - Only add patbe to migration stream if non-zero
> ---
>  hw/ppc/spapr.c         | 29 +++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  1 +
>  target/ppc/cpu.h       |  1 +
>  3 files changed, 31 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e465d7a..2fbf193 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1018,6 +1018,13 @@ static void emulate_spapr_hypercall(PPCVirtualHype=
rvisor *vhyp,
>      }
>  }
> =20
> +static uint64_t spapr_get_patbe(PPCVirtualHypervisor *vhyp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(vhyp);
> +
> +    return spapr->patb_entry;
> +}
> +
>  #define HPTE(_table, _i)   (void *)(((uint64_t *)(_table)) + ((_i) * 2))
>  #define HPTE_VALID(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_V=
ALID)
>  #define HPTE_DIRTY(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_H=
PTE_DIRTY)
> @@ -1141,6 +1148,8 @@ static void ppc_spapr_reset(void)
>      /* Check for unknown sysbus devices */
>      foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
> =20
> +    spapr->patb_entry =3D 0;
> +
>      /* Allocate and/or reset the hash page table */
>      spapr_reallocate_hpt(spapr,
>                           spapr_hpt_shift_for_ramsize(machine->maxram_siz=
e),
> @@ -1327,6 +1336,24 @@ static const VMStateDescription vmstate_spapr_ov5_=
cas =3D {
>      },
>  };
> =20
> +static bool spapr_patb_entry_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +
> +    return !!spapr->patb_entry;
> +}
> +
> +static const VMStateDescription vmstate_spapr_patb_entry =3D {
> +    .name =3D "spapr_patb_entry",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_patb_entry_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(patb_entry, sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_spapr =3D {
>      .name =3D "spapr",
>      .version_id =3D 3,
> @@ -1344,6 +1371,7 @@ static const VMStateDescription vmstate_spapr =3D {
>      },
>      .subsections =3D (const VMStateDescription*[]) {
>          &vmstate_spapr_ov5_cas,
> +        &vmstate_spapr_patb_entry,
>          NULL
>      }
>  };
> @@ -2733,6 +2761,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      nc->nmi_monitor_handler =3D spapr_nmi;
>      smc->phb_placement =3D spapr_phb_placement;
>      vhc->hypercall =3D emulate_spapr_hypercall;
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
> index 425e79d..684d632 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1218,6 +1218,7 @@ struct PPCVirtualHypervisor {
>  struct PPCVirtualHypervisorClass {
>      InterfaceClass parent;
>      void (*hypercall)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
> +    uint64_t (*get_patbe)(PPCVirtualHypervisor *vhyp);
>  };
> =20
>  #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--x/TyKPcLwmKZr+b7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrlwWAAoJEGw4ysog2bOSAOIP/3V8rj6NQ294b5CK7YXPZpvz
jbKDtQ81M8ET80akUfi6ElA3WE7C06jXrCNFG1pKKeIyU7EEdBZtfgB/3clNdCvO
ZV4wai7dhRVX85wegI3p050sduuIUd5r6BwyBzzMbxhGy0VO/g33ZfeO8zfEB8Wg
7sdrcALAVBp7pU9F66iwNwX+R7ddyb873cmmJNWbLHBDxT80udIQiOEtIfgsk11P
DrxLGZdUxe7Ay6hAsIlhYxvC9G9SlQHEE1aoFBb+bww39FH/umCUTAKK/VV6cAt3
6BhbpYH+n1APlVCC21we/agUBkX12vhgFkSQ0rplPJhdCqpZdCOb8UVcVKuirp2R
9mwTEDjw5W5IWa1ImHU687gG2fUoEzitC3dLf6ChL7jLMqXoFBViinr/fZzYspjb
XSFqrIh3d4DRWD1XZbBiHicpmLcJ7FhXf5W1opD2vLRTooJqLn6rdAQaDMXRKpPB
hz9ox9mZgsOrTDHuKxZO8aWS5pzFI6Kz7kIv3EdNSXW/0k9aIYmWCXQr1vKsXKKa
+eXgfOGYFu5GGh2PGR9vsAVyVfztrXul8FrRunSPGiGLwSnfx02badYe4ERkzyc6
jlEhcirabf2fyI18p7O/OBD5gdPi3VMTscYDKfnvJgcum31HpRDX62VOrIiD7MKU
avPpLPVjxNXzjubG0St5
=WQpK
-----END PGP SIGNATURE-----

--x/TyKPcLwmKZr+b7--
