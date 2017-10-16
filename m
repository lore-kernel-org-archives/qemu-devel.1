Received: from eggs.gnu.org ([2001:4830:134:3::10]:53846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e41pQ-0002zB-MI
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e41pO-00063b-UF
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:36:56 -0400
Date: Mon, 16 Oct 2017 20:36:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171016093641.GH2776@umbus.fritz.box>
References: <20171016052004.31397-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YhFoJY/gx7awiIuK"
Content-Disposition: inline
In-Reply-To: <20171016052004.31397-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v3] RFC: ppc/spapr: Receive and store
 device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Balbir Singh <bsingharora@gmail.com>, Greg Kurz <groug@kaod.org>, slof@lists.ozlabs.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>


--YhFoJY/gx7awiIuK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2017 at 04:20:04PM +1100, Alexey Kardashevskiy wrote:
> SLOF receives a device tree and updates it with various properties
> before switching to the guest kernel and QEMU is not aware of any changes
> made by SLOF. Since there is no real RTAS and QEMU implements it,
> it makes sense to pass the SLOF device tree to QEMU so the latter could
> implement RTAS related tasks better.
>=20
> Specifially, now QEMU can find out the actual XICS phandle (for PHB
> hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
> assisted NMI - FWNMI).
>=20
> This stores the initial DT blob in the sPAPR machine and replaces it
> in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.
>=20
> This implements a basic FDT header validity check of the new blob;
> the new blob size should not increase more than twice since the reset.
>=20
> This adds a machine property - update_dt_enabled - to allow backward
> migration.
>=20
> This requires SLOF update: "fdt: Pass the resulting device tree to QEMU".
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v3:
> * store reset-time FDT blob size and compare the update size against it;
> this disallows more than 2x increase between resets
> * added some FDT header sanity checks
> * implemented migration
>=20
> ---
> I could store just a size of the QEMU's blob, or a tree, not sure
> which one makes more sense here.
>=20
> This allows up to 2 times blob increase. Not 1.5 just to avoid
> float/double, just looks a bit ugly imho.
> ---
>  include/hw/ppc/spapr.h |  7 ++++++-
>  hw/ppc/spapr.c         | 31 ++++++++++++++++++++++++++++++-
>  hw/ppc/spapr_hcall.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
>  hw/ppc/trace-events    |  2 ++
>  4 files changed, 80 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index c1b365f564..a9ccc14823 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -60,6 +60,7 @@ struct sPAPRMachineClass {
>      /*< public >*/
>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMB=
s */
>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
> +    bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
>      const char *tcg_default_cpu; /* which (TCG) CPU to simulate by defau=
lt */
>      bool pre_2_10_has_unused_icps;
>      void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
> @@ -92,6 +93,9 @@ struct sPAPRMachineState {
>      int vrma_adjust;
>      ssize_t rtas_size;
>      void *rtas_blob;
> +    uint32_t fdt_size;
> +    uint32_t fdt_initial_size;
> +    void *fdt_blob;
>      long kernel_size;
>      bool kernel_le;
>      uint32_t initrd_base;
> @@ -400,7 +404,8 @@ struct sPAPRMachineState {
>  #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
>  /* Client Architecture support */
>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
> -#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
> +#define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
> +#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
> =20
>  typedef struct sPAPRDeviceTreeUpdateHeader {
>      uint32_t version_id;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ff87f155d5..cb7bcc851e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1467,7 +1467,10 @@ static void ppc_spapr_reset(void)
>      /* Load the fdt */
>      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>      cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
> -    g_free(fdt);
> +    g_free(spapr->fdt_blob);
> +    spapr->fdt_size =3D fdt_totalsize(fdt);
> +    spapr->fdt_initial_size =3D spapr->fdt_size;
> +    spapr->fdt_blob =3D fdt;
> =20
>      /* Set up the entry state */
>      first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> @@ -1675,6 +1678,27 @@ static const VMStateDescription vmstate_spapr_patb=
_entry =3D {
>      },
>  };
> =20
> +static bool spapr_dtb_needed(void *opaque)
> +{
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(opaque);
> +
> +    return smc->update_dt_enabled;
> +}
> +
> +static const VMStateDescription vmstate_spapr_dtb =3D {
> +    .name =3D "spapr_dtb",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_dtb_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(fdt_initial_size, sPAPRMachineState),

I'm not sure you need to migrate initial size.  The destination can
work this out itself.. unless we skip the reset when we have an
incoming migration, I'm not sure.

> +        VMSTATE_UINT32(fdt_size, sPAPRMachineState),
> +        VMSTATE_VBUFFER_ALLOC_UINT32(fdt_blob, sPAPRMachineState, 0, NUL=
L,
> +                                     fdt_size),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_spapr =3D {
>      .name =3D "spapr",
>      .version_id =3D 3,
> @@ -1694,6 +1718,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_ov5_cas,
>          &vmstate_spapr_patb_entry,
>          &vmstate_spapr_pending_events,
> +        &vmstate_spapr_dtb,
>          NULL
>      }
>  };
> @@ -3605,6 +3630,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      hc->unplug_request =3D spapr_machine_device_unplug_request;
> =20
>      smc->dr_lmb_enabled =3D true;
> +    smc->update_dt_enabled =3D true;
>      smc->tcg_default_cpu =3D "POWER8";
>      mc->has_hotpluggable_cpus =3D true;
>      smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
> @@ -3703,7 +3729,10 @@ static void spapr_machine_2_10_instance_options(Ma=
chineState *machine)
> =20
>  static void spapr_machine_2_10_class_options(MachineClass *mc)
>  {
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> +
>      spapr_machine_2_11_class_options(mc);
> +    smc->update_dt_enabled =3D false;
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_10);
>  }
> =20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 8d72bb7c1c..be3de41080 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1656,6 +1656,46 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_update_dt(PowerPCCPU *cpu, sPAPRMachineState *spap=
r,
> +                                target_ulong opcode, target_ulong *args)
> +{
> +    target_ulong dt =3D ppc64_phys_to_real(args[0]);
> +    struct fdt_header hdr =3D { 0 };
> +    unsigned cb;
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +
> +    cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
> +    cb =3D fdt32_to_cpu(hdr.totalsize);
> +
> +    if (fdt_check_header(&hdr) ||
> +        fdt32_to_cpu(hdr.boot_cpuid_phys) ||

A nonzero boot cpuid is potentially valid, we shouldn't fail that.

> +        fdt32_to_cpu(hdr.off_dt_struct) >=3D cb ||
> +        fdt32_to_cpu(hdr.off_dt_strings) >=3D cb ||
> +        fdt32_to_cpu(hdr.off_mem_rsvmap) >=3D cb ||

Just checking the offset isn't very useful.  You need to check two
things for each of the blocks:
	off + size >=3D off	; this checks there's no overflow
	off + size <=3D totalsize	; checks the block fits in the blob

With the additional complication that you don't actually have a size
for the rsvmap - so you have to step through it to verify that.  For a
v16 blob you don't have one for the structure blob either, but you
could simply reject v16 blobs.

> +        fdt32_to_cpu(hdr.totalsize) !=3D fdt32_to_cpu(hdr.size_dt_string=
s) +
> +                fdt32_to_cpu(hdr.size_dt_struct) +
> +                sizeof(struct fdt_reserve_entry) +
> +                sizeof(hdr)

This check is invalid.  It's allowed to have gaps between the blocks
in the FDT, which could increase the size.  In some cases it's even
required, to meet the alignment requirements for each block.

||

Yeah.. this is all a bit complicated, I'm really thinking about a
fdt_fsck() function for libfdt.

> +        cb / spapr->fdt_initial_size > 2) {
> +        trace_spapr_update_dt_failed(spapr->fdt_initial_size, cb,
> +            fdt32_to_cpu(hdr.magic));
> +        return H_PARAMETER;
> +    }
> +
> +    if (!smc->update_dt_enabled) {
> +        return H_SUCCESS;
> +    }
> +
> +    g_free(spapr->fdt_blob);
> +    spapr->fdt_size =3D cb;
> +    spapr->fdt_blob =3D g_malloc0(cb);
> +    cpu_physical_memory_read(dt, spapr->fdt_blob, cb);
> +
> +    trace_spapr_update_dt(cb);
> +
> +    return H_SUCCESS;
> +}
> +
>  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
>  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_H=
CALL_BASE + 1];
> =20
> @@ -1753,6 +1793,8 @@ static void hypercall_register_types(void)
> =20
>      /* ibm,client-architecture-support support */
>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support=
);
> +
> +    spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
>  }
> =20
>  type_init(hypercall_register_types)
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 4a6a6490fa..60ee4e3a4b 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -18,6 +18,8 @@ spapr_cas_pvr_try(uint32_t pvr) "0x%x"
>  spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "=
current=3D0x%x, explicit_match=3D%u, new=3D0x%x"
>  spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=3D0x%"=
PRIx64", shift=3D%"PRIu64
>  spapr_h_resize_hpt_commit(uint64_t flags, uint64_t shift) "flags=3D0x%"P=
RIx64", shift=3D%"PRIu64
> +spapr_update_dt(unsigned cb) "New blob %u bytes"
> +spapr_update_dt_failed(unsigned cbold, unsigned cbnew, unsigned magic) "=
Old blob %u bytes, new blob %u bytes, magic 0x%x"
> =20
>  # hw/ppc/spapr_iommu.c
>  spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t re=
t) "liobn=3D0x%"PRIx64" ioba=3D0x%"PRIx64" tce=3D0x%"PRIx64" ret=3D%"PRId64

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YhFoJY/gx7awiIuK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnkfaQACgkQbDjKyiDZ
s5Ij6Q//RxUVqmjHOc9cp3IEgTVhKlwd+hZlwfmj/+fPEMxcFVqN45cSZ1HxkX/s
48WYeORfIaficrfaarT4+MXIyR1K756TnOi+uHQZVqNvi2N2gyo3wyH93qYmcCzJ
gBPTd/G5U3JX7yOU9TASDDN/BQOqYDxhUhBFiqUy7sleB4tLbtHN+eKV65qZQ1Ph
ONOwovfuq5u71iDfI84A5qqfTm/WDBs+pBZquMJyYIY6MZoRzzQt6G5KBnOjvMi9
MZYaXt5NsbLk172PbmY3rje6ScPw99i0FkIgZWxuWV2vNGoaTBabFvEx4gD4ZodC
ED0NEERcYWJSsZDH0C9bK9bt9nrs2wqKiF7v28n/g2MV/TA5Af2vgHwQVkR9uFz1
R4LQcySBCfW5WSR0K5+p5qO65irnDMGApPwlr6i0Bp4JsGd7Q+vd9lvDj0M6WFUd
7TbKU3IXJMtz3QoX9xbP0/0buTGA8ghzyPub8o5D+GRDUTLlbQ7yis+hbNa1Cqdz
x4RZGfvKJlUh3stuPYYBJrZ5Lgrl7xv7/NWSGwGKw7NboPVA6RPopSMeGoJ6YqmT
O1pfTOBhA3w1ftAjjWedrQ2T4y6h27cvCLYcCthekrFSF78aUTbR7nP0ELaIgCfO
X4NlrMy7IMAtRBcJdknxpyXdfgE9QqYy12TbqzuWAAt22W2wOlc=
=JpDw
-----END PGP SIGNATURE-----

--YhFoJY/gx7awiIuK--
