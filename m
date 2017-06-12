Received: from eggs.gnu.org ([2001:4830:134:3::10]:48914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKQEO-0002zp-P5
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKQEK-0004ta-G7
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:22:12 -0400
Date: Mon, 12 Jun 2017 22:21:48 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170612142148.GI18542@umbus>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<149692940719.12119.1126399233332975562.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l0l+eSofNeLXHSnY"
Content-Disposition: inline
In-Reply-To: <149692940719.12119.1126399233332975562.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v4 6/6] spapr: fix migration of ICPState
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


--l0l+eSofNeLXHSnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 03:43:27PM +0200, Greg Kurz wrote:
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
> v4: - dropped paranoid g_assert()s
> ---
>  hw/ppc/spapr.c         |   86 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  include/hw/ppc/spapr.h |    2 +
>  2 files changed, 86 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b2951d7618d6..1379986c0c7b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -125,9 +125,50 @@ error:
>      return NULL;
>  }
> =20
> +static bool pre_2_10_vmstate_dummy_icp_needed(void *opaque)
> +{
> +    return false;

Comment here with why always false makes sense here would be useful
for the future.

> +}
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

AFAICT you now set, but never check the flags in the ignore_icp array,
so you should be able to get rid of it.

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
> +    vmstate_unregister(NULL, &pre_2_10_vmstate_dummy_icp, flag);
> +    *flag =3D false;
> +}
> +
> +static inline int xics_nr_servers(void)
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
> @@ -149,6 +190,15 @@ static void xics_system_init(MachineState *machine, =
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

A comment around here explaining that the dummy entries get
deregistered when real ICPs are registered would also be helpful.

> +        }
> +    }
>  }
> =20
>  static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
> @@ -977,7 +1027,6 @@ static void *spapr_build_fdt(sPAPRMachineState *spap=
r,
>      void *fdt;
>      sPAPRPHBState *phb;
>      char *buf;
> -    int smt =3D kvmppc_smt_threads();
> =20
>      fdt =3D g_malloc0(FDT_MAX_SIZE);
>      _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
> @@ -1017,7 +1066,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
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
> @@ -2803,9 +2852,24 @@ static void spapr_core_unplug(HotplugHandler *hotp=
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
> @@ -2913,6 +2977,21 @@ static void spapr_core_plug(HotplugHandler *hotplu=
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
> @@ -3362,9 +3441,12 @@ static void spapr_machine_2_9_instance_options(Mac=
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

--l0l+eSofNeLXHSnY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZPqN8AAoJEGw4ysog2bOSH/YQAL0tzBw+z0rHKlKnwt9ivijY
rrUjZE7qfOsz4zEaPqzZK142L1ABNvbm3FJhqpqDx+6bdUj+VG/y+6DdJjoa3esj
SyeX+OEaFQKHyOaveHYM03pndbWUFoH8FslDtwE7CIYzgfG3w2rc1RZYf+CBOd+V
LOo/rA/KS+n/nh7N5dmlz7Q3VYFSMK9TsQNwmIv5CeU8/eSppZY6FVN46oUtuiVM
r+IUlhpEiDL0hgTUaecyP8bNx9g4xAEfQ8hyv4ud8YUzdlZu0e5hFZGfjQEqotIn
9wqF/BEazZTt5SXCxj54Ez8Phgiczc74gIqoDPEW629LjK399kyvHLK90ZcyIRvr
TyHgNJ4keXqG3nm8PuKCCnsh1XfFFs7eeC+Rx54UfDeRkXHPC5V2uI1V9DuWRm89
3QBO6OkKI/jPSahHodgPuTyxeRW+1XNBXaNxMG6Ple9IwvqlphLMKQatdSk8kAiH
Do5QONQ0AJBPrGvJQkS+lelDvtr17Uzq3DPmJvqoFmvL2dVwPiaxrZ9xtyJhqkCh
TjbzaMbJlBoGsbYdC4CpysyalcbUPFSPxo0pJTS28+e9v4BUfOP6DQZGtcWCl2WH
DscUcD0ZRNRL4RHGG4YzyAkyDJQp0molBlNDAYjWNorwGP7pH575m7TnKSlCIfPm
ScyX1K8WKFCYfPsReqSL
=5rrY
-----END PGP SIGNATURE-----

--l0l+eSofNeLXHSnY--
