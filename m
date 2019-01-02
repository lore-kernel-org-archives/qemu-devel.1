Received: from eggs.gnu.org ([208.118.235.92]:47582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geXXl-0004km-7k
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 22:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geXXh-00063D-CH
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 22:50:09 -0500
Date: Wed, 2 Jan 2019 14:25:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190102032533.GJ27457@umbus.fritz.box>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
	<154535248827.862554.14664931152289972599.stgit@bahia.lan>
	<20181221173924.GA19800@kermit-br-ibm-com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yr/DzoowOgTDcSCF"
Content-Disposition: inline
In-Reply-To: <20181221173924.GA19800@kermit-br-ibm-com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 01/15] ppc/spapr: Receive and
 store device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--yr/DzoowOgTDcSCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2018 at 03:39:24PM -0200, Murilo Opsfelder Araujo wrote:
> On Fri, Dec 21, 2018 at 01:34:48AM +0100, Greg Kurz wrote:
> > From: Alexey Kardashevskiy <aik@ozlabs.ru>
> >
> > SLOF receives a device tree and updates it with various properties
> > before switching to the guest kernel and QEMU is not aware of any chang=
es
> > made by SLOF. Since there is no real RTAS (QEMU implements it), it makes
> > sense to pass the SLOF final device tree to QEMU to let it implement
> > RTAS related tasks better, such as PCI host bus adapter hotplug.
> >
> > Specifially, now QEMU can find out the actual XICS phandle (for PHB
> > hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
> > assisted NMI - FWNMI).
> >
> > This stores the initial DT blob in the sPAPR machine and replaces it
> > in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.
> >
> > This adds an @update_dt_enabled machine property to allow backward
> > migration.
> >
> > SLOF already has a hypercall since
> > https://github.com/aik/SLOF/commit/e6fc84652c9c0073f9183
> >
> > This makes use of the new fdt_check_full() helper. In order to allow
> > the configure script to pick the correct DTC version, this adjusts
> > the DTC presense test.
> >
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  configure              |    2 +-
> >  hw/ppc/spapr.c         |   43 ++++++++++++++++++++++++++++++++++++++++=
++-
> >  hw/ppc/spapr_hcall.c   |   42 ++++++++++++++++++++++++++++++++++++++++=
++
> >  hw/ppc/trace-events    |    3 +++
> >  include/hw/ppc/spapr.h |    7 ++++++-
> >  5 files changed, 94 insertions(+), 3 deletions(-)
> >
> > diff --git a/configure b/configure
> > index 224d3071ac61..baeeabc29f56 100755
> > --- a/configure
> > +++ b/configure
> > @@ -3916,7 +3916,7 @@ if test "$fdt" !=3D "no" ; then
> >    cat > $TMPC << EOF
> >  #include <libfdt.h>
> >  #include <libfdt_env.h>
> > -int main(void) { fdt_first_subnode(0, 0); return 0; }
> > +int main(void) { fdt_check_full(NULL, 0); return 0; }
> >  EOF
> >    if compile_prog "" "$fdt_libs" ; then
> >      # system DTC is good - use it
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 17ad84396b31..8ea680fcde1e 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1668,7 +1668,10 @@ static void spapr_machine_reset(void)
> >      /* Load the fdt */
> >      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
> >      cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
> > -    g_free(fdt);
> > +    g_free(spapr->fdt_blob);
> > +    spapr->fdt_size =3D fdt_totalsize(fdt);
> > +    spapr->fdt_initial_size =3D spapr->fdt_size;
> > +    spapr->fdt_blob =3D fdt;
> >
> >      /* Set up the entry state */
> >      spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_ad=
dr);
> > @@ -1919,6 +1922,39 @@ static const VMStateDescription vmstate_spapr_ir=
q_map =3D {
> >      },
> >  };
> >
> > +static bool spapr_dtb_needed(void *opaque)
> > +{
> > +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(opaque);
> > +
> > +    return smc->update_dt_enabled;
> > +}
> > +
> > +static int spapr_dtb_pre_load(void *opaque)
> > +{
> > +    sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
>=20
> Should we use SPAPR_MACHINE here?

I don't think so.  SPAPR_MACHINE is safer if we know what we have is
definitely a QOM object of some sort.  Here we have a void *, so
assuming it's an sPAPRMachineState * is no more dangerous than
assuming it is an Object *.

>=20
> > +
> > +    g_free(spapr->fdt_blob);
> > +    spapr->fdt_blob =3D NULL;
> > +    spapr->fdt_size =3D 0;
> > +
> > +    return 0;
> > +}
> > +
> > +static const VMStateDescription vmstate_spapr_dtb =3D {
> > +    .name =3D "spapr_dtb",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .needed =3D spapr_dtb_needed,
> > +    .pre_load =3D spapr_dtb_pre_load,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT32(fdt_initial_size, sPAPRMachineState),
> > +        VMSTATE_UINT32(fdt_size, sPAPRMachineState),
> > +        VMSTATE_VBUFFER_ALLOC_UINT32(fdt_blob, sPAPRMachineState, 0, N=
ULL,
> > +                                     fdt_size),
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
> > +
> >  static const VMStateDescription vmstate_spapr =3D {
> >      .name =3D "spapr",
> >      .version_id =3D 3,
> > @@ -1948,6 +1984,7 @@ static const VMStateDescription vmstate_spapr =3D=
 {
> >          &vmstate_spapr_cap_ibs,
> >          &vmstate_spapr_irq_map,
> >          &vmstate_spapr_cap_nested_kvm_hv,
> > +        &vmstate_spapr_dtb,
> >          NULL
> >      }
> >  };
> > @@ -3929,6 +3966,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
> >      hc->unplug =3D spapr_machine_device_unplug;
> >
> >      smc->dr_lmb_enabled =3D true;
> > +    smc->update_dt_enabled =3D true;
> >      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
> >      mc->has_hotpluggable_cpus =3D true;
> >      smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
> > @@ -4024,9 +4062,12 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
> >
> >  static void spapr_machine_3_1_class_options(MachineClass *mc)
> >  {
> > +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > +
> >      spapr_machine_4_0_class_options(mc);
> >      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
> >      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
> > +    smc->update_dt_enabled =3D false;
> >  }
> >
> >  DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index ae913d070f50..78fecc8fe906 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1717,6 +1717,46 @@ static target_ulong h_get_cpu_characteristics(Po=
werPCCPU *cpu,
> >
> >      args[0] =3D characteristics;
> >      args[1] =3D behaviour;
> > +    return H_SUCCESS;
> > +}
> > +
> > +static target_ulong h_update_dt(PowerPCCPU *cpu, sPAPRMachineState *sp=
apr,
> > +                                target_ulong opcode, target_ulong *arg=
s)
> > +{
> > +    target_ulong dt =3D ppc64_phys_to_real(args[0]);
> > +    struct fdt_header hdr =3D { 0 };
> > +    unsigned cb;
> > +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> > +    void *fdt;
> > +
> > +    cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
> > +    cb =3D fdt32_to_cpu(hdr.totalsize);
> > +
> > +    if (!smc->update_dt_enabled) {
> > +        return H_SUCCESS;
> > +    }
>=20
> Does it make sense to move this check upper in the function so it can ret=
urn
> earler if update_dt_enabled is false?
>=20
> > +
> > +    /* Check that the fdt did not grow out of proportion */
> > +    if (cb > spapr->fdt_initial_size * 2) {
> > +        trace_spapr_update_dt_failed_size(spapr->fdt_initial_size, cb,
> > +                                          fdt32_to_cpu(hdr.magic));
> > +        return H_PARAMETER;
> > +    }
> > +
> > +    fdt =3D g_malloc0(cb);
> > +    cpu_physical_memory_read(dt, fdt, cb);
> > +
> > +    /* Check the fdt consistency */
> > +    if (fdt_check_full(fdt, cb)) {
> > +        trace_spapr_update_dt_failed_check(spapr->fdt_initial_size, cb,
> > +                                           fdt32_to_cpu(hdr.magic));
> > +        return H_PARAMETER;
> > +    }
> > +
> > +    g_free(spapr->fdt_blob);
> > +    spapr->fdt_size =3D cb;
> > +    spapr->fdt_blob =3D fdt;
> > +    trace_spapr_update_dt(cb);
> >
> >      return H_SUCCESS;
> >  }
> > @@ -1822,6 +1862,8 @@ static void hypercall_register_types(void)
> >
> >      /* ibm,client-architecture-support support */
> >      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_suppo=
rt);
> > +
> > +    spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
> >  }
> >
> >  type_init(hypercall_register_types)
> > diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> > index dc5e65aee96d..0af155ed323d 100644
> > --- a/hw/ppc/trace-events
> > +++ b/hw/ppc/trace-events
> > @@ -22,6 +22,9 @@ spapr_cas_pvr_try(uint32_t pvr) "0x%x"
> >  spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr)=
 "current=3D0x%x, explicit_match=3D%u, new=3D0x%x"
> >  spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=3D0x=
%"PRIx64", shift=3D%"PRIu64
> >  spapr_h_resize_hpt_commit(uint64_t flags, uint64_t shift) "flags=3D0x%=
"PRIx64", shift=3D%"PRIu64
> > +spapr_update_dt(unsigned cb) "New blob %u bytes"
> > +spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned m=
agic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
> > +spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned =
magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
> >
> >  # hw/ppc/spapr_iommu.c
> >  spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t =
ret) "liobn=3D0x%"PRIx64" ioba=3D0x%"PRIx64" tce=3D0x%"PRIx64" ret=3D%"PRId=
64
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 2c77a8ba8810..36033b89d31a 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -103,6 +103,7 @@ struct sPAPRMachineClass {
> >
> >      /*< public >*/
> >      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of L=
MBs */
> > +    bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
> >      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
> >      bool pre_2_10_has_unused_icps;
> >      bool legacy_irq_allocation;
> > @@ -139,6 +140,9 @@ struct sPAPRMachineState {
> >      int vrma_adjust;
> >      ssize_t rtas_size;
> >      void *rtas_blob;
> > +    uint32_t fdt_size;
> > +    uint32_t fdt_initial_size;
> > +    void *fdt_blob;
> >      long kernel_size;
> >      bool kernel_le;
> >      uint32_t initrd_base;
> > @@ -480,7 +484,8 @@ struct sPAPRMachineState {
> >  #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
> >  /* Client Architecture support */
> >  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
> > -#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
> > +#define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
> > +#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
> >
> >  typedef struct sPAPRDeviceTreeUpdateHeader {
> >      uint32_t version_id;
> >
> >
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yr/DzoowOgTDcSCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwsLy0ACgkQbDjKyiDZ
s5J/xhAApBuM9SzdEFs2DPGLUZSDRsZAPcDjC9wb6/kkXBiZwhcRxXKFd9UwnPiW
/kD9ItvI3J++mUHagmpzF/9ASH1MjinRhM4WWeVkLc74mqb3mgqnQVw90LC4mM4l
9ZXsQX68GQJ+JnZn08Lry8cTaobpQ7KYQM86+p0KDKc3Mac5fAJJVBO2JcWBYPAX
1lsggIFVWPAxlFQrQ5IT/9a3gLPsXBxpO2Wc23rkF9mg2S7N87CE6rNHmhYz4dLc
gdxe14NdyJtv1KfwgWJbe8YLG5nAa33wzyqu/qrzX0A4zJuQhEJcurA/00n5QPAg
PUrTSB1+Y10/UjXDxvRu41XKP7HJjEi4UhuRnGxM69oZUN4Sdn5byaeX2XgQYdZ4
20m0XDfv3HN+5hrE0S/Vc9E3i5a27Dh3W3fBVnE2dZ6PPAoCVf69+Wi4BEKDxc4B
UaK4+mVQx8qQyH9zP5vVSZbR1W2nahj1BWZwQW2ABA9GXWAvW5kjxv6B58n3a/ZZ
+1vkmpUvlh71RHCMMyCm4yLVrRe/VjDfUS0wWu9p8dxXUtCFIoBEc0UP0SrsGDQe
HG3KM0T8nAjkdv5x8lF/GWmwQKDxcLlpgj2frRBpdOZe/QZL74pJh/pdiyRL6uzK
auH+lau3NCZQbZkyPaqCiM8FSIxwb7OkXyxa3EpKKm0U99ck7Wo=
=sL9T
-----END PGP SIGNATURE-----

--yr/DzoowOgTDcSCF--
