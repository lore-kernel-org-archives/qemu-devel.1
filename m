Received: from eggs.gnu.org ([2001:4830:134:3::10]:57749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8dJ9-0004U8-7j
	for qemu-devel@nongnu.org; Wed, 10 May 2017 21:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8dJ7-0004jl-K0
	for qemu-devel@nongnu.org; Wed, 10 May 2017 21:54:23 -0400
Date: Thu, 11 May 2017 11:02:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170511010220.GE14408@umbus.fritz.box>
References: <1494234377-1773-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1494234377-1773-3-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Content-Disposition: inline
In-Reply-To: <1494234377-1773-3-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] spapr: Fix migration of Radix
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 02:36:17PM +0530, Bharata B Rao wrote:
> Currently HTAB savevm handlers get registered by default and migration
> of radix guest will fail.
>=20
> - Ensure that HTAB savevm handlers are not registered for radix case.
> - Ensure that we issue KVM_PPC_CONFIGURE_V3_MMU for radix case post
>   migration.
>=20
> TODO: Right now I have delayed the HTAB savevm handler registration
> to CAS call where we know if the guest is radix or hash. Another approach
> is to let the HTAB handlers to be registered by default (as it is being
> done currently, but unregister them from CAS when we discover radix
> capability).

Option 2 there sounds messy.  I also suspect it could break if you try
to migrate an (eventually) radix guest before it's done CAS.

Strictly speaking only registering at CAS time will break old hash
guests that don't do CAS at all.  However such guests are really,
really ancient, and I suspect we don't work with them already.

You do, however, need to deregister (and allow the choice to be made
again) on guest reset.  On KVM we can only (for now) support either
hash or radix guests.  Under TCG, however, we could run a radix guest
then reboot to a hash guest or vice versa.


>=20
> Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c         | 18 +++++++++++++++---
>  hw/ppc/spapr_hcall.c   |  5 +++++
>  include/hw/ppc/spapr.h |  3 +++
>  3 files changed, 23 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e2dc77c..e14f55c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1436,6 +1436,14 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
>          err =3D spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
>      }
> =20
> +    if (spapr->patb_entry && (spapr->patb_flags & SPAPR_PROC_TABLE_RADIX=
) &&

patb_entry already tells you whether the guest is radix or not
(PATBE1_GR), you shouldn't need extra flags.

> +        kvmppc_has_cap_mmu_radix() && kvm_enabled()) {

You should also fail the migration if you have an incoming radix
guest, but the your new KVM host can't do radix.  Or the reverse, for
that matter.

> +        err =3D kvmppc_configure_v3_mmu(POWERPC_CPU(first_cpu),
> +                                      spapr->patb_flags &
> +                                      SPAPR_PROC_TABLE_RADIX,
> +                                      spapr->patb_flags & SPAPR_PROC_TAB=
LE_GTSE,
> +                                      spapr->patb_entry);
> +    }
>      return err;
>  }
> =20
> @@ -1520,6 +1528,7 @@ static const VMStateDescription vmstate_spapr_patb_=
entry =3D {
>      .needed =3D spapr_patb_entry_needed,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINT64(patb_entry, sPAPRMachineState),
> +        VMSTATE_UINT64(patb_flags, sPAPRMachineState),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -1869,6 +1878,12 @@ static SaveVMHandlers savevm_htab_handlers =3D {
>      .load_state =3D htab_load,
>  };
> =20
> +void spapr_htab_savevm_register(sPAPRMachineState *spapr)
> +{
> +    register_savevm_live(NULL, "spapr/htab", -1, 1,
> +                         &savevm_htab_handlers, spapr);
> +}
> +
>  static void spapr_boot_set(void *opaque, const char *boot_device,
>                             Error **errp)
>  {
> @@ -2331,9 +2346,6 @@ static void ppc_spapr_init(MachineState *machine)
>       * interface, this is a legacy from the sPAPREnvironment structure
>       * which predated MachineState but had a similar function */
>      vmstate_register(NULL, 0, &vmstate_spapr, spapr);
> -    register_savevm_live(NULL, "spapr/htab", -1, 1,
> -                         &savevm_htab_handlers, spapr);
> -
>      /* used by RTAS */
>      QTAILQ_INIT(&spapr->ccs_list);
>      qemu_register_reset(spapr_ccs_reset_hook, spapr);
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 3600b0e..fa03ca0 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -988,6 +988,7 @@ static target_ulong h_register_process_table(PowerPCC=
PU *cpu,
>      spapr_check_setup_free_hpt(spapr, spapr->patb_entry, cproc);
> =20
>      spapr->patb_entry =3D cproc; /* Save new process table */
> +    spapr->patb_flags =3D flags; /* Save the flags */
> =20
>      /* Update the UPRT and GTSE bits in the LPCR for all cpus */
>      CPU_FOREACH(cs) {
> @@ -1169,6 +1170,10 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>          }
>      }
> =20
> +    /* Register savevm handlers for HTAB case */
> +    if (!guest_radix || !kvmppc_has_cap_mmu_radix()) {
> +        spapr_htab_savevm_register(spapr);
> +    }
>      return H_SUCCESS;
>  }
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a692e63..0d0e9e4 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -75,6 +75,7 @@ struct sPAPRMachineState {
>      void *htab;
>      uint32_t htab_shift;
>      uint64_t patb_entry; /* Process tbl registed in H_REGISTER_PROCESS_T=
ABLE */
> +    uint64_t patb_flags;
>      hwaddr rma_size;
>      int vrma_adjust;
>      ssize_t rtas_size;
> @@ -691,4 +692,6 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_o=
n_cpu_data arg);
>  #define SPAPR_PROC_TABLE_HPT_PT      0x02
>  #define SPAPR_PROC_TABLE_GTSE        0x01
> =20
> +void spapr_htab_savevm_register(sPAPRMachineState *spapr);
> +
>  #endif /* HW_SPAPR_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZE7gZAAoJEGw4ysog2bOSfBsP/AuaKR00VG2nQoUyFsQrqF2r
Y/mdzbRLoPJ08u/aQFNKDDe5oaAirWEeRNTV1SKlDsiZg+ph66XQ0BinAv3G3xes
P7aGH0FiAuq5oc2D6Ug05PJbymIQnvqEM2oL3V0r0+//ikG/m2T4I3CB2SXvTmxy
Y2cj6+z+nwO24WGzZbYxIt2HFKNlWL5FfH8CHjriJLLyLp5mNDXK+vA9ELsd8VG6
h0L2hteAcvgE2R9laAsv1UagW19VsBAGk/ebLRUOtvAjkkBY7aCorSmW5s1Seg11
3JHEapGa0PZjJDyUomxQEnc6yjXQRrPl1JoolO17PkiaC74j3fxCdRxLLnef6qRn
Y4i1BIB5an75x4b3mqQ3SzjMdgfCohVxKKH7a6hpc4l0oA5oU+GzOmQAw7p6rlSH
P7T3jPtTPMjFaCSS2UM5iEuurI9MklZT2AoNBAvGci6VSkaqORL5cK0vHrVcwIOn
31LRz4z14hGVkULcWsoudlIh5sKwKwKvKluk4M/ce69x7ZGBLH7xoN2Zo2rPEvPy
k0ct8BXExXsc/uwscbhjhbWj8mizTIX4fWx+C1YJsgjdKXvgUPxvA9lKnahsKFOK
AetgxSJ2ESaqFLWEMhVfYVNd/Jd9Z5u6nFrVzKdJZOvXyRnJvrvxirG42tibu6h0
J6xgGS1jWQlzudhMBcFe
=NqV+
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--
