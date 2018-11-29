Received: from eggs.gnu.org ([2001:4830:134:3::10]:42443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSEBJ-0004cS-K1
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSEBG-0008NF-6O
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:44:05 -0500
Date: Thu, 29 Nov 2018 15:22:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181129042211.GJ14697@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-35-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bWEb1MG/o7IKOlQF"
Content-Disposition: inline
In-Reply-To: <20181116105729.23240-35-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 34/36] spapr: add KVM support to the
 'dual' machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--bWEb1MG/o7IKOlQF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 11:57:27AM +0100, C=E9dric Le Goater wrote:
> The interrupt mode is chosen by the CAS negotiation process and
> activated after a reset to take into account the required changes in
> the machine. This brings new constraints on how the associated KVM IRQ
> device is initialized.
>=20
> Currently, each model takes care of the initialization of the KVM
> device in their realize method but this is not possible anymore as the
> initialization needs to done globaly when the interrupt mode is known,
> i.e. when machine is reseted. It also means that we need a way to
> delete a KVM device when another mode is chosen.
>=20
> Also, to support migration, the QEMU objects holding the state to
> transfer should always be available but not necessarily activated.
>=20
> The overall approach of this proposal is to initialize both interrupt
> mode at the QEMU level and keep the IRQ number space in sync to allow
> switching from one mode to another. For the KVM side of things, the
> whole initialization of the KVM device, sources and presenters, is
> grouped in a single routine. The XICS and XIVE sPAPR IRQ reset
> handlers are modified accordingly to handle the init and delete
> sequences of the KVM device. The post_load handlers also are, to take
> into account a possible change of interrupt mode after transfer.
>=20
> As KVM is now initialized at reset, we loose the possiblity to
> fallback to the QEMU emulated mode in case of failure and failures
> become fatal to the machine.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive_kvm.c | 48 +++++++++++-----------
>  hw/intc/xics_kvm.c       | 18 ++++++---
>  hw/ppc/spapr_irq.c       | 86 +++++++++++++++++++++++++++++-----------
>  3 files changed, 98 insertions(+), 54 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 0672d8bcbc6b..9c7d36f51e3d 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -148,7 +148,6 @@ static void xive_tctx_kvm_init(XiveTCTX *tctx, Error =
**errp)
> =20
>  static void xive_tctx_kvm_realize(DeviceState *dev, Error **errp)
>  {
> -    XiveTCTX *tctx =3D XIVE_TCTX_KVM(dev);
>      XiveTCTXClass *xtc =3D XIVE_TCTX_BASE_GET_CLASS(dev);
>      Error *local_err =3D NULL;
> =20
> @@ -157,12 +156,6 @@ static void xive_tctx_kvm_realize(DeviceState *dev, =
Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -
> -    xive_tctx_kvm_init(tctx, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
>  }
> =20
>  static void xive_tctx_kvm_class_init(ObjectClass *klass, void *data)
> @@ -222,12 +215,9 @@ static void xive_source_kvm_init(XiveSource *xsrc, E=
rror **errp)
> =20
>  static void xive_source_kvm_reset(DeviceState *dev)
>  {
> -    XiveSource *xsrc =3D XIVE_SOURCE_KVM(dev);
>      XiveSourceClass *xsc =3D XIVE_SOURCE_BASE_GET_CLASS(dev);
> =20
>      xsc->parent_reset(dev);
> -
> -    xive_source_kvm_init(xsrc, &error_fatal);
>  }
> =20
>  /*
> @@ -346,12 +336,6 @@ static void xive_source_kvm_realize(DeviceState *dev=
, Error **errp)
> =20
>      xsrc->qirqs =3D qemu_allocate_irqs(xive_source_kvm_set_irq, xsrc,
>                                       xsrc->nr_irqs);
> -
> -    xive_source_kvm_mmap(xsrc, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
>  }
> =20
>  static void xive_source_kvm_unrealize(DeviceState *dev, Error **errp)
> @@ -823,6 +807,7 @@ void spapr_xive_kvm_init(sPAPRXive *xive, Error **err=
p)
>  {
>      Error *local_err =3D NULL;
>      size_t tima_len;
> +    CPUState *cs;
> =20
>      if (!kvm_enabled() || !kvmppc_has_cap_xive()) {
>          error_setg(errp,
> @@ -850,7 +835,18 @@ void spapr_xive_kvm_init(sPAPRXive *xive, Error **er=
rp)
>          return;
>      }
> =20
> -    /* Let the XiveSource KVM model handle the mapping for the moment */
> +    xive_source_kvm_mmap(&xive->source, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    /* Create the KVM interrupt sources */
> +    xive_source_kvm_init(&xive->source, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> =20
>      /* TIMA KVM mapping
>       *
> @@ -869,6 +865,17 @@ void spapr_xive_kvm_init(sPAPRXive *xive, Error **er=
rp)
>                                        "xive.tima", tima_len, xive->tm_mm=
ap);
>      sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
> =20
> +    /* Connect the presenters to the VCPU */
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +
> +        xive_tctx_kvm_init(XIVE_TCTX_BASE(cpu->intc), &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
> +
>      kvm_kernel_irqchip =3D true;
>      kvm_msi_via_irqfd_allowed =3D true;
>      kvm_gsi_direct_mapping =3D true;
> @@ -920,16 +927,9 @@ void spapr_xive_kvm_fini(sPAPRXive *xive, Error **er=
rp)
> =20
>  static void spapr_xive_kvm_realize(DeviceState *dev, Error **errp)
>  {
> -    sPAPRXive *xive =3D SPAPR_XIVE_KVM(dev);
>      sPAPRXiveClass *sxc =3D SPAPR_XIVE_BASE_GET_CLASS(dev);
>      Error *local_err =3D NULL;
> =20
> -    spapr_xive_kvm_init(xive, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
>      /* Initialize the source and the local routing tables */
>      sxc->parent_realize(dev, &local_err);
>      if (local_err) {
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index a7e3ec32a761..c89fa943847c 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -190,12 +190,6 @@ static void icp_kvm_realize(DeviceState *dev, Error =
**errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -
> -    icp_kvm_init(ICP(dev), &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
>  }
> =20
>  static void icp_kvm_class_init(ObjectClass *klass, void *data)
> @@ -427,6 +421,8 @@ static void rtas_dummy(PowerPCCPU *cpu, sPAPRMachineS=
tate *spapr,
>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp)
>  {
>      int rc;
> +    CPUState *cs;
> +    Error *local_err =3D NULL;
> =20
>      if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_IRQ_XI=
CS)) {
>          error_setg(errp,
> @@ -475,6 +471,16 @@ int xics_kvm_init(sPAPRMachineState *spapr, Error **=
errp)
>      kvm_msi_via_irqfd_allowed =3D true;
>      kvm_gsi_direct_mapping =3D true;
> =20
> +    /* Connect the presenters to the VCPU */
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +
> +        icp_kvm_init(ICP(cpu->intc), &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            goto fail;
> +        }
> +    }
>      return 0;
> =20
>  fail:
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 79ead51c630d..f1720a8dda33 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -98,20 +98,14 @@ static void spapr_irq_init_xics(sPAPRMachineState *sp=
apr, int nr_irqs,
>      MachineState *machine =3D MACHINE(spapr);
>      Error *local_err =3D NULL;
> =20
> -    if (kvm_enabled()) {
> -        if (machine_kernel_irqchip_allowed(machine) &&
> -            !xics_kvm_init(spapr, &local_err)) {
> -            spapr->icp_type =3D TYPE_KVM_ICP;
> -            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs,
> -                                          &local_err);
> -        }
> -        if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
> -            error_prepend(&local_err,
> -                          "kernel_irqchip requested but unavailable: ");
> -            goto error;
> +    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> +        spapr->icp_type =3D TYPE_KVM_ICP;
> +        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs,
> +                                      &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
>          }
> -        error_free(local_err);
> -        local_err =3D NULL;
>      }
> =20
>      if (!spapr->ics) {
> @@ -119,10 +113,11 @@ static void spapr_irq_init_xics(sPAPRMachineState *=
spapr, int nr_irqs,
>          spapr->icp_type =3D TYPE_ICP;
>          spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,
>                                        &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
>      }
> -
> -error:
> -    error_propagate(errp, local_err);
>  }
> =20
>  #define ICS_IRQ_FREE(ics, srcno)   \
> @@ -218,11 +213,28 @@ static int spapr_irq_post_load_xics(sPAPRMachineSta=
te *spapr, int version_id)
> =20
>  static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **errp)
>  {
> +    MachineState *machine =3D MACHINE(spapr);
>      CPUState *cs;
> +    Error *local_err =3D NULL;
> =20
>      CPU_FOREACH(cs) {
>          spapr_cpu_core_set_intc(POWERPC_CPU(cs), spapr->icp_type);
>      }
> +
> +    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {

Aren't both devices '_fini'-ed by the machine level reset handler, why
does it need a _fini here as well as an init?

> +        xics_kvm_fini(spapr, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            error_prepend(errp, "KVM XICS fini failed: ");
> +            return;
> +        }
> +        xics_kvm_init(spapr, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            error_prepend(errp, "KVM XICS init failed: ");
> +            return;
> +        }
> +    }
>  }
> =20
>  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
> @@ -288,10 +300,8 @@ static void spapr_irq_init_xive(sPAPRMachineState *s=
papr, int nr_irqs,
>          spapr->xive_tctx_type =3D TYPE_XIVE_TCTX_KVM;
>          spapr->xive =3D spapr_xive_create(spapr, TYPE_SPAPR_XIVE_KVM, nr=
_irqs,
>                                          nr_servers, &local_err);
> -
> -        if (local_err && machine_kernel_irqchip_required(machine)) {
> +        if (local_err) {
>              error_propagate(errp, local_err);
> -            error_prepend(errp, "kernel_irqchip requested but init faile=
d : ");
>              return;
>          }
> =20
> @@ -375,12 +385,29 @@ static int spapr_irq_post_load_xive(sPAPRMachineSta=
te *spapr, int version_id)
> =20
>  static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **errp)
>  {
> +    MachineState *machine =3D MACHINE(spapr);
>      CPUState *cs;
> +    Error *local_err =3D NULL;
> =20
>      CPU_FOREACH(cs) {
>          spapr_cpu_core_set_intc(POWERPC_CPU(cs), spapr->xive_tctx_type);
>      }
> =20
> +    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> +        spapr_xive_kvm_fini(spapr->xive, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            error_prepend(errp, "KVM XIVE fini failed: ");
> +            return;
> +        }
> +        spapr_xive_kvm_init(spapr->xive, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            error_prepend(errp, "KVM XIVE init failed: ");
> +            return;
> +        }
> +    }
> +
>      spapr_xive_mmio_map(spapr->xive);
>  }
> =20
> @@ -432,11 +459,6 @@ static void spapr_irq_init_dual(sPAPRMachineState *s=
papr, int nr_irqs,
>  {
>      Error *local_err =3D NULL;
> =20
> -    if (kvm_enabled()) {
> -        error_setg(errp, "No KVM support for the 'dual' machine");
> -        return;
> -    }
> -
>      spapr_irq_xics.init(spapr, spapr_irq_xics.nr_irqs, nr_servers, &loca=
l_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -510,10 +532,15 @@ static Object *spapr_irq_cpu_intc_create_dual(sPAPR=
MachineState *spapr,
> =20
>  static int spapr_irq_post_load_dual(sPAPRMachineState *spapr, int versio=
n_id)
>  {
> +    MachineState *machine =3D MACHINE(spapr);
> +
>      /*
>       * Force a reset of the XIVE backend after migration.
>       */
>      if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> +            xics_kvm_fini(spapr, &error_fatal);
> +        }
>          spapr_irq_xive.reset(spapr, &error_fatal);
>      }
> =20
> @@ -522,6 +549,17 @@ static int spapr_irq_post_load_dual(sPAPRMachineStat=
e *spapr, int version_id)
> =20
>  static void spapr_irq_reset_dual(sPAPRMachineState *spapr, Error **errp)
>  {
> +    MachineState *machine =3D MACHINE(spapr);
> +
> +    /*
> +     * Destroy all the KVM IRQ devices. This also clears the VCPU
> +     * presenters
> +     */
> +    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> +        xics_kvm_fini(spapr, &error_fatal);
> +        spapr_xive_kvm_fini(spapr->xive, &error_fatal);
> +    }
> +
>      /*
>       * Only XICS is reseted at startup as it is the default interrupt
>       * mode.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bWEb1MG/o7IKOlQF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv/aXIACgkQbDjKyiDZ
s5LNUA//SIVqxfq2BsN2jMNmXyYEbeDyfCyP1f7BTqF7eTDQ5gr/9LkMtBUdjTSY
TBG6nU7FScaQWATzfXkQo/Y+lpzIrnzMgrS9WD7xOMM8Qt8XrFgDlFToPsWYrpLb
mULk/Ia24GaWmCqOgxNdBEs5PFeFLNY0shPJWgLxVWAxU5m7pPxeYQWuvGAqyfJM
013ZgV+tFmerZtCzjcdpYEZT2ctbjyIn9m+imTx/WlwE9HTjThIGzlmNCh7oLvDE
WCt6u2hr2T09Eh/FOmWcectNr1ajqecHYwmONr+eoTy2rOEzJd6tFz5ry8uWdRcO
CJoq8EFbkgK+vgOQr+7AW2nZR+vI6a5JXuDS05CrdXnqJ3dsfsxsiJ+J2RIKcnax
fpbdk032JmmRZDwiMhN2w3wAJayIDsmXVFhexvKA0RYTmg+iqZ9/kWlMy9ZMOaMo
SSYn/YT/5cUxaP166Yo/tyi9DwaU+ORrYeGHQm9Zg9aCPEDRV1wc2xeEoA/QOgLx
lgEJO8YSx8nsGUy0sp/1cKjoFQ8xf2h5nOxsuooPcVAaPGq9YC466zNhjmt1WD9V
wUz0p+AGapjRKjDFhrPDbNgSe2ah7UqaQuqSQwAnvWBDWILOgoDJJBWe9/xYrqJl
Uor+UCFboq35A+PifDy4xQ8Tvwi/H9DonyL2Kf6HC0MCnWg5IaU=
=DWH+
-----END PGP SIGNATURE-----

--bWEb1MG/o7IKOlQF--
