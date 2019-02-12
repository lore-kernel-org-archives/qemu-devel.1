Received: from eggs.gnu.org ([209.51.188.92]:42900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtNG6-0007XF-Ja
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtNG3-0000L3-O4
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:53:14 -0500
Date: Tue, 12 Feb 2019 12:11:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190212011153.GH1884@umbus.fritz.box>
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-14-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IbVRjBtIbJdbeK1C"
Content-Disposition: inline
In-Reply-To: <20190107183946.7230-14-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 13/13] spapr: add KVM support to the 'dual'
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--IbVRjBtIbJdbeK1C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:39:46PM +0100, C=E9dric Le Goater wrote:
> The interrupt mode is chosen by the CAS negotiation process and
> activated after a reset to take into account the required changes in
> the machine. This brings new constraints on how the associated KVM IRQ
> device is initialized.
>=20
> Currently, each model takes care of the initialization of the KVM
> device in their realize method but this is not possible anymore as the
> initialization needs to be done globaly when the interrupt mode is
> known, i.e. when machine is reseted. It also means that we need a way
> to delete a KVM device when another mode is chosen.
>=20
> Also, to support migration, the QEMU objects holding the state to
> transfer should always be available but not necessarily activated.
>=20
> The overall approach of this proposal is to initialize both interrupt
> mode at the QEMU level and keep the IRQ number space in sync to allow
> switching from one mode to another. For the KVM side of things, the
> whole initialization of the KVM device, sources and presenters, is
> grouped in a single routine. The XICS and XIVE sPAPR IRQ reset
> handlers are modified accordingly to handle the init and the delete
> sequences of the KVM device.
>=20
> As KVM is now initialized at reset, we loose the possiblity to
> fallback to the QEMU emulated mode in case of failure and failures
> become fatal to the machine.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive.c     |  8 +---
>  hw/intc/spapr_xive_kvm.c | 27 ++++++++++++++
>  hw/intc/xics_kvm.c       | 25 +++++++++++++
>  hw/intc/xive.c           |  4 --
>  hw/ppc/spapr_irq.c       | 79 ++++++++++++++++++++++++++++------------
>  5 files changed, 109 insertions(+), 34 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 21f3c1ef0901..0661aca35900 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -330,13 +330,7 @@ static void spapr_xive_realize(DeviceState *dev, Err=
or **errp)
>      xive->eat =3D g_new0(XiveEAS, xive->nr_irqs);
>      xive->endt =3D g_new0(XiveEND, xive->nr_ends);
> =20
> -    if (kvmppc_xive_enabled()) {
> -        kvmppc_xive_connect(xive, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> -    } else {
> +    if (!kvmppc_xive_enabled()) {
>          /* TIMA initialization */
>          memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops=
, xive,
>                                "xive.tima", 4ull << TM_SHIFT);
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index d35814c1992e..3ebc947f2be7 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -737,6 +737,15 @@ void kvmppc_xive_connect(sPAPRXive *xive, Error **er=
rp)
>      Error *local_err =3D NULL;
>      size_t esb_len;
>      size_t tima_len;
> +    CPUState *cs;
> +
> +    /*
> +     * The KVM XIVE device already in use. This is the case when
> +     * rebooting XIVE -> XIVE

Can this case actually occur?  Further down you appear to
unconditionally destroy both KVM devices at reset time.

> +     */
> +    if (xive->fd !=3D -1) {
> +        return;
> +    }
> =20
>      if (!kvm_enabled() || !kvmppc_has_cap_xive()) {
>          error_setg(errp, "IRQ_XIVE capability must be present for KVM");
> @@ -800,6 +809,24 @@ void kvmppc_xive_connect(sPAPRXive *xive, Error **er=
rp)
>      xive->change =3D qemu_add_vm_change_state_handler(
>          kvmppc_xive_change_state_handler, xive);
> =20
> +    /* Connect the presenters to the initial VCPUs of the machine */
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +
> +        kvmppc_xive_cpu_connect(cpu->tctx, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
> +
> +    /* Update the KVM sources */
> +    kvmppc_xive_source_reset(xsrc, &local_err);
> +    if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +    }
> +
>      kvm_kernel_irqchip =3D true;
>      kvm_msi_via_irqfd_allowed =3D true;
>      kvm_gsi_direct_mapping =3D true;
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 1d21ff217b82..bfc35d71df7f 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -448,6 +448,16 @@ static void rtas_dummy(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp)
>  {
>      int rc;
> +    CPUState *cs;
> +    Error *local_err =3D NULL;
> +
> +    /*
> +     * The KVM XICS device already in use. This is the case when
> +     * rebooting XICS -> XICS
> +     */
> +    if (kernel_xics_fd !=3D -1) {
> +        return 0;
> +    }
> =20
>      if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_IRQ_XI=
CS)) {
>          error_setg(errp,
> @@ -496,6 +506,21 @@ int xics_kvm_init(sPAPRMachineState *spapr, Error **=
errp)
>      kvm_msi_via_irqfd_allowed =3D true;
>      kvm_gsi_direct_mapping =3D true;
> =20
> +    /* Connect the presenters to the initial VCPUs of the machine */
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +
> +        icp_kvm_connect(cpu->icp, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            goto fail;
> +        }
> +        icp_set_kvm_state(cpu->icp, 1);
> +    }
> +
> +    /* Update the KVM sources */
> +    ics_set_kvm_state(ICS_KVM(spapr->ics), 1);
> +
>      return 0;
> =20
>  fail:
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index c5c2fbc3f8bc..c166eab5b210 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -932,10 +932,6 @@ static void xive_source_reset(void *dev)
> =20
>      /* PQs are initialized to 0b01 (Q=3D1) which corresponds to "ints of=
f" */
>      memset(xsrc->status, XIVE_ESB_OFF, xsrc->nr_irqs);
> -
> -    if (kvmppc_xive_enabled()) {
> -        kvmppc_xive_source_reset(xsrc, &error_fatal);
> -    }
>  }
> =20
>  static void xive_source_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index ba27d9d8e972..5592eec3787b 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -98,20 +98,14 @@ static void spapr_irq_init_xics(sPAPRMachineState *sp=
apr, Error **errp)
>      int nr_irqs =3D spapr->irq->nr_irqs;
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

I don't see anything that replaces the irqchip_required logic, which
doesn't seem right.

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
spapr, Error **errp)
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
> @@ -233,7 +228,17 @@ static void spapr_irq_set_irq_xics(void *opaque, int=
 srcno, int val)
> =20
>  static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **errp)
>  {
> -    /* TODO: create the KVM XICS device */
> +    MachineState *machine =3D MACHINE(spapr);
> +    Error *local_err =3D NULL;
> +
> +    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> +        xics_kvm_init(spapr, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            error_prepend(errp, "KVM XICS connect failed: ");
> +            return;
> +        }
> +    }
>  }
> =20
>  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
> @@ -393,6 +398,7 @@ static int spapr_irq_post_load_xive(sPAPRMachineState=
 *spapr, int version_id)
>  static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **errp)
>  {
>      CPUState *cs;
> +    Error *local_err =3D NULL;
> =20
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> @@ -401,6 +407,15 @@ static void spapr_irq_reset_xive(sPAPRMachineState *=
spapr, Error **errp)
>          spapr_xive_set_tctx_os_cam(cpu->tctx);
>      }
> =20
> +    if (kvmppc_xive_enabled()) {
> +        kvmppc_xive_connect(spapr->xive, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            error_prepend(errp, "KVM XIVE connect failed: ");
> +            return;
> +        }
> +    }
> +
>      /* Activate the XIVE MMIOs */
>      spapr_xive_mmio_set_enabled(spapr->xive, true);
>  }
> @@ -462,14 +477,8 @@ static sPAPRIrq *spapr_irq_current(sPAPRMachineState=
 *spapr)
> =20
>  static void spapr_irq_init_dual(sPAPRMachineState *spapr, Error **errp)
>  {
> -    MachineState *machine =3D MACHINE(spapr);
>      Error *local_err =3D NULL;
> =20
> -    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> -        error_setg(errp, "No KVM support for the 'dual' machine");
> -        return;
> -    }
> -
>      spapr_irq_xics.init(spapr, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -568,11 +577,16 @@ static void spapr_irq_cpu_intc_create_dual(sPAPRMac=
hineState *spapr,
> =20
>  static int spapr_irq_post_load_dual(sPAPRMachineState *spapr, int versio=
n_id)
>  {
> +    MachineState *machine =3D MACHINE(spapr);
> +
>      /*
>       * Force a reset of the XIVE backend after migration. The machine
>       * defaults to XICS at startup.
>       */
>      if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> +            xics_kvm_disconnect(spapr, &error_fatal);
> +        }
>          spapr_irq_xive.reset(spapr, &error_fatal);
>      }
> =20
> @@ -581,12 +595,31 @@ static int spapr_irq_post_load_dual(sPAPRMachineSta=
te *spapr, int version_id)
> =20
>  static void spapr_irq_reset_dual(sPAPRMachineState *spapr, Error **errp)
>  {
> +    MachineState *machine =3D MACHINE(spapr);
> +    Error *local_err =3D NULL;
> +
>      /*
>       * Deactivate the XIVE MMIOs. The XIVE backend will reenable them
>       * if selected.
>       */
>      spapr_xive_mmio_set_enabled(spapr->xive, false);
> =20
> +    /* Destroy all KVM devices */
> +    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> +        xics_kvm_disconnect(spapr, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            error_prepend(errp, "KVM XICS disconnect failed: ");
> +            return;
> +        }
> +        kvmppc_xive_disconnect(spapr->xive, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            error_prepend(errp, "KVM XIVE disconnect failed: ");
> +            return;
> +        }
> +    }
> +
>      spapr_irq_current(spapr)->reset(spapr, errp);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IbVRjBtIbJdbeK1C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxiHVkACgkQbDjKyiDZ
s5J3FxAAtP5EZ1DCSvHuCGRp6jdT79wykU8/q1vZyxX8GltHlIYy3eogF3ku1Fbv
ERGAe2HI7tE3jQNIUKOSBGxrImg0amSI/0iBlknOmWVOSSsk6mXfoqwCiNnnw3TA
QTTnFblN9miOOwxIyhC6FdoO1PSImXuwiDuxGCRi6XCiDcPNef5vuoGSJn+g+c0E
XBx5N4C+WY8YJKcfKONRh8xYt9isFVgaI81iG3JTOJ8eVD1VC3k7AWQOa7GaRUK/
OpJOuT+KQAM1Gomwy/yQUofZFmpvnkEEY/ffqs/aer6j85HsjdHHNeteEb48hKce
Q/tJl9QaEi79Rx9uTjhFXWr1wfsEM9mtxVP7a7p6kACBKAQAYZbreFghPIJ/tdqH
7eLWswpXW9FasVB2lXTGHXg+QXv3h8hpSZ8Sdo74hUy9Sapiz0uqpropK6uZh8lp
A6aM769lIh6uyYScegzkNGe5LadXI09cs3ZwBxy8Nr3Y2vrZ9ZPeSD5iXu6pz7cK
U68AS98CINcA4wsDPJJ7JPjgCxrCH2lQw7QRH5nE8P4w7fTiyE1RJfTepxKR6kc0
CuAG7yUHxvNgf0HjUNLpur+p5NyB61tMFZNxNn601umdNm9cuIRZPHaFjyeoCL+n
Xis6GGOCH/hpyv//pGznUMYoTRyrr+BWHJImqHEffjIN5XFDmso=
=PjSP
-----END PGP SIGNATURE-----

--IbVRjBtIbJdbeK1C--
