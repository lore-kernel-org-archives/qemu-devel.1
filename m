Received: from eggs.gnu.org ([2001:4830:134:3::10]:56932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIol0-000512-Ft
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIokx-0004tY-7r
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:09:14 -0400
Date: Thu, 8 Jun 2017 14:08:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608040857.GV13397@umbus.fritz.box>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685584629.12025.14875914798241845062.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cnUHsqv9fxRVMt2T"
Content-Disposition: inline
In-Reply-To: <149685584629.12025.14875914798241845062.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] spapr: fix migration of ICPState
 objects from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>


--cnUHsqv9fxRVMt2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 07:17:26PM +0200, Greg Kurz wrote:
> Commit 5bc8d26de20c ("spapr: allocate the ICPState object from under
> sPAPRCPUCore") moved ICPState objects from the machine to CPU cores.
> This is an improvement since we no longer allocate ICPState objects
> that will never be used. But it has the side-effect of breaking
> migration of older machine types from older QEMU versions.
>=20
> This patch allows spapr to register dummy "icp/server" entries to vmstate.
> These entries use a dedicated VMStateDescription that can swallow and
> discard state of an incoming migration stream, and that don't send anythi=
ng
> on outgoing migration.
>=20
> As for real ICPState objects, the instance_id is the cpu_index of the
> corresponding vCPU, which happens to be equal to the generated instance_id
> of older machine types.
>=20
> The machine can unregister/register these entries when CPUs are dynamical=
ly
> plugged/unplugged.
>=20
> This is only available for pseries-2.9 and older machines, thanks to a
> compat property.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v3: - new logic entirely implemented in hw/ppc/spapr.c
> ---
>  hw/ppc/spapr.c         |   88 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  include/hw/ppc/spapr.h |    2 +
>  2 files changed, 88 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9b7ae28939a8..c15b604978f0 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -124,9 +124,52 @@ error:
>      return NULL;
>  }
> =20
> +static bool pre_2_10_vmstate_dummy_icp_needed(void *opaque)
> +{
> +    return false;
> +}

Uh.. the needed function always returns false, how can that work?

> +
> +static const VMStateDescription pre_2_10_vmstate_dummy_icp =3D {
> +    .name =3D "icp/server",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D pre_2_10_vmstate_dummy_icp_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UNUSED(4), /* uint32_t xirr */
> +        VMSTATE_UNUSED(1), /* uint8_t pending_priority */
> +        VMSTATE_UNUSED(1), /* uint8_t mfrr */
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static void pre_2_10_vmstate_register_dummy_icp(sPAPRMachineState *spapr=
, int i)
> +{
> +    bool *flag =3D &spapr->pre_2_10_ignore_icp[i];
> +
> +    g_assert(!*flag);

Apart from this assert(), you never seem to test the values in the
pre_2_10_ignore_icp() array, so it seems a bit pointless.

> +    vmstate_register(NULL, i, &pre_2_10_vmstate_dummy_icp, flag);
> +    *flag =3D true;
> +}
> +
> +static void pre_2_10_vmstate_unregister_dummy_icp(sPAPRMachineState *spa=
pr,
> +                                                  int i)
> +{
> +    bool *flag =3D &spapr->pre_2_10_ignore_icp[i];
> +
> +    g_assert(*flag);
> +    vmstate_unregister(NULL, &pre_2_10_vmstate_dummy_icp, flag);
> +    *flag =3D false;
> +}
> +
> +static inline int xics_nr_servers(void)

Maybe a different name to emphasise that this is only used for the
backwards compat logic.

> +{
> +    return DIV_ROUND_UP(max_cpus * kvmppc_smt_threads(), smp_threads);
> +}
> +
>  static void xics_system_init(MachineState *machine, int nr_irqs, Error *=
*errp)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
> =20
>      if (kvm_enabled()) {
>          if (machine_kernel_irqchip_allowed(machine) &&
> @@ -148,6 +191,15 @@ static void xics_system_init(MachineState *machine, =
int nr_irqs, Error **errp)
>              return;
>          }
>      }
> +
> +    if (smc->pre_2_10_has_unused_icps) {
> +        int i;
> +
> +        spapr->pre_2_10_ignore_icp =3D g_malloc(xics_nr_servers());
> +        for (i =3D 0; i < xics_nr_servers(); i++) {
> +            pre_2_10_vmstate_register_dummy_icp(spapr, i);

This registers a dummy ICP for every slot, some of which will have
real cpus / icps.  That doesn't seem right.

> +        }
> +    }
>  }
> =20
>  static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
> @@ -976,7 +1028,6 @@ static void *spapr_build_fdt(sPAPRMachineState *spap=
r,
>      void *fdt;
>      sPAPRPHBState *phb;
>      char *buf;
> -    int smt =3D kvmppc_smt_threads();
> =20
>      fdt =3D g_malloc0(FDT_MAX_SIZE);
>      _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
> @@ -1016,7 +1067,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
>      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
> =20
>      /* /interrupt controller */
> -    spapr_dt_xics(DIV_ROUND_UP(max_cpus * smt, smp_threads), fdt, PHANDL=
E_XICP);
> +    spapr_dt_xics(xics_nr_servers(), fdt, PHANDLE_XICP);
> =20
>      ret =3D spapr_populate_memory(spapr, fdt);
>      if (ret < 0) {
> @@ -2800,9 +2851,24 @@ static void spapr_core_unplug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>                                Error **errp)
>  {
>      MachineState *ms =3D MACHINE(qdev_get_machine());
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(ms);
>      CPUCore *cc =3D CPU_CORE(dev);
>      CPUArchId *core_slot =3D spapr_find_cpu_slot(ms, cc->core_id, NULL);
> =20
> +    if (spapr->pre_2_10_ignore_icp) {
> +        sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
> +        sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
> +        const char *typename =3D object_class_get_name(scc->cpu_class);
> +        size_t size =3D object_type_get_instance_size(typename);
> +        int i;
> +
> +        for (i =3D 0; i < cc->nr_threads; i++) {
> +            CPUState *cs =3D CPU(sc->threads + i * size);
> +
> +            pre_2_10_vmstate_register_dummy_icp(spapr, cs->cpu_index);
> +        }
> +    }
> +
>      assert(core_slot);
>      core_slot->cpu =3D NULL;
>      object_unparent(OBJECT(dev));
> @@ -2912,6 +2978,21 @@ static void spapr_core_plug(HotplugHandler *hotplu=
g_dev, DeviceState *dev,
>          }
>      }
>      core_slot->cpu =3D OBJECT(dev);
> +
> +    if (spapr->pre_2_10_ignore_icp) {
> +        sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
> +        const char *typename =3D object_class_get_name(scc->cpu_class);
> +        size_t size =3D object_type_get_instance_size(typename);
> +        int i;
> +
> +        for (i =3D 0; i < cc->nr_threads; i++) {
> +            sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(dev);
> +            void *obj =3D sc->threads + i * size;
> +
> +            cs =3D CPU(obj);
> +            pre_2_10_vmstate_unregister_dummy_icp(spapr, cs->cpu_index);
> +        }
> +    }
>  }
> =20
>  static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState=
 *dev,
> @@ -3361,9 +3442,12 @@ static void spapr_machine_2_9_instance_options(Mac=
hineState *machine)
> =20
>  static void spapr_machine_2_9_class_options(MachineClass *mc)
>  {
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> +
>      spapr_machine_2_10_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
>      mc->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
> +    smc->pre_2_10_has_unused_icps =3D true;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index f973b0284596..64382623199d 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -53,6 +53,7 @@ struct sPAPRMachineClass {
>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMB=
s */
>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
>      const char *tcg_default_cpu; /* which (TCG) CPU to simulate by defau=
lt */
> +    bool pre_2_10_has_unused_icps;
>      void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio,=20
>                            hwaddr *mmio32, hwaddr *mmio64,
> @@ -90,6 +91,7 @@ struct sPAPRMachineState {
>      sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vecto=
rs */
>      bool cas_reboot;
>      bool cas_legacy_guest_workaround;
> +    bool *pre_2_10_ignore_icp;
> =20
>      Notifier epow_notifier;
>      QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cnUHsqv9fxRVMt2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOM3ZAAoJEGw4ysog2bOSBjEP/0tjmUFZfTFGuQLrIjxBEaOP
bHsZK1pyZPGeW0XWptm24jiWeRUF8/CZMefsbX1Kn9lWvd/qWCEhj37lb2wPQgnp
s9Fls0fmHg6XIrB/q0MZL9RI+GRrA0kPyuk56jV5ywDgqhHu+gh2plsKHcIS2E7t
VgipvLH3+R6OQU2cpCAYppE7LoF1hyRC9OCQplicPnn8jNrd2y9Q5E0y9JqtNYwd
vDNLwceh1mehxnaGrFlYQiUcJaWFRprI5+Sy91CmGPk9Dxq43NATOfvR5eB3/xcK
RYBNKlFX0MEjhzsM0b5rwddBaGA9yk3GX84EDtVEJKmydggf7HKPiIzjJq0MINaC
uX+je/svvHij7k9chvC08jJH65OmxMvx6LIMU0fZe5sA7NjtVa06eKUdeR6InuhT
1xgLWguXuXG4FItGJnw+X0WNFBmeSbuEzDpg1iGsgNvdRImE3s4ZvDk/xto6ekOS
cXkAa4TB9uRS55O6mo8GSvHaFq2he9oOngrnZ0ybNSSgKJGWB8rHJHHwwcD/oh+o
k/fMDI9Sbdq/bSmwEYCUJxUe7cAvUx+7XJd6gipr6EcJEghjs1GsPh5UF2vLLEtB
BPBw9fbZaBxG1UcrltDSuK2vlKXE7pNtQkiQhzp7QIy8l414fo9LC4IkNeW1glsR
JT8wjFT53yZ4gm8jO9DG
=8Dl6
-----END PGP SIGNATURE-----

--cnUHsqv9fxRVMt2T--
