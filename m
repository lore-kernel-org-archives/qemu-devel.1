Received: from eggs.gnu.org ([209.51.188.92]:56737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu7oz-0008C9-Bm
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:36:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu7ox-0001nY-AD
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:36:21 -0500
Date: Thu, 14 Feb 2019 14:35:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190214033555.GA1884@umbus.fritz.box>
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-14-clg@kaod.org>
	<20190212011153.GH1884@umbus.fritz.box>
	<d6dc35c6-4987-3fcc-de81-f2aff865cad1@kaod.org>
	<20190213013219.GU1884@umbus.fritz.box>
	<f0b93ebb-e8b5-4448-9b57-8da2feee493c@kaod.org>
	<20190213110749.0194dcd0@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JqdxN8yMrvvaufxH"
Content-Disposition: inline
In-Reply-To: <20190213110749.0194dcd0@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 13/13] spapr: add KVM support to
 the 'dual' machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--JqdxN8yMrvvaufxH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 11:07:49AM +0100, Greg Kurz wrote:
> On Wed, 13 Feb 2019 09:22:46 +0100
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > On 2/13/19 2:32 AM, David Gibson wrote:
> > > On Tue, Feb 12, 2019 at 08:18:19AM +0100, C=E9dric Le Goater wrote: =
=20
> > >> On 2/12/19 2:11 AM, David Gibson wrote: =20
> > >>> On Mon, Jan 07, 2019 at 07:39:46PM +0100, C=E9dric Le Goater wrote:=
 =20
> > >>>> The interrupt mode is chosen by the CAS negotiation process and
> > >>>> activated after a reset to take into account the required changes =
in
> > >>>> the machine. This brings new constraints on how the associated KVM=
 IRQ
> > >>>> device is initialized.
> > >>>>
> > >>>> Currently, each model takes care of the initialization of the KVM
> > >>>> device in their realize method but this is not possible anymore as=
 the
> > >>>> initialization needs to be done globaly when the interrupt mode is
> > >>>> known, i.e. when machine is reseted. It also means that we need a =
way
> > >>>> to delete a KVM device when another mode is chosen.
> > >>>>
> > >>>> Also, to support migration, the QEMU objects holding the state to
> > >>>> transfer should always be available but not necessarily activated.
> > >>>>
> > >>>> The overall approach of this proposal is to initialize both interr=
upt
> > >>>> mode at the QEMU level and keep the IRQ number space in sync to al=
low
> > >>>> switching from one mode to another. For the KVM side of things, the
> > >>>> whole initialization of the KVM device, sources and presenters, is
> > >>>> grouped in a single routine. The XICS and XIVE sPAPR IRQ reset
> > >>>> handlers are modified accordingly to handle the init and the delete
> > >>>> sequences of the KVM device.
> > >>>>
> > >>>> As KVM is now initialized at reset, we loose the possiblity to
> > >>>> fallback to the QEMU emulated mode in case of failure and failures
> > >>>> become fatal to the machine.
> > >>>>
> > >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > >>>> ---
> > >>>>  hw/intc/spapr_xive.c     |  8 +---
> > >>>>  hw/intc/spapr_xive_kvm.c | 27 ++++++++++++++
> > >>>>  hw/intc/xics_kvm.c       | 25 +++++++++++++
> > >>>>  hw/intc/xive.c           |  4 --
> > >>>>  hw/ppc/spapr_irq.c       | 79 ++++++++++++++++++++++++++++-------=
-----
> > >>>>  5 files changed, 109 insertions(+), 34 deletions(-)
> > >>>>
> > >>>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > >>>> index 21f3c1ef0901..0661aca35900 100644
> > >>>> --- a/hw/intc/spapr_xive.c
> > >>>> +++ b/hw/intc/spapr_xive.c
> > >>>> @@ -330,13 +330,7 @@ static void spapr_xive_realize(DeviceState *d=
ev, Error **errp)
> > >>>>      xive->eat =3D g_new0(XiveEAS, xive->nr_irqs);
> > >>>>      xive->endt =3D g_new0(XiveEND, xive->nr_ends);
> > >>>> =20
> > >>>> -    if (kvmppc_xive_enabled()) {
> > >>>> -        kvmppc_xive_connect(xive, &local_err);
> > >>>> -        if (local_err) {
> > >>>> -            error_propagate(errp, local_err);
> > >>>> -            return;
> > >>>> -        }
> > >>>> -    } else {
> > >>>> +    if (!kvmppc_xive_enabled()) {
> > >>>>          /* TIMA initialization */
> > >>>>          memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive=
_tm_ops, xive,
> > >>>>                                "xive.tima", 4ull << TM_SHIFT);
> > >>>> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> > >>>> index d35814c1992e..3ebc947f2be7 100644
> > >>>> --- a/hw/intc/spapr_xive_kvm.c
> > >>>> +++ b/hw/intc/spapr_xive_kvm.c
> > >>>> @@ -737,6 +737,15 @@ void kvmppc_xive_connect(sPAPRXive *xive, Err=
or **errp)
> > >>>>      Error *local_err =3D NULL;
> > >>>>      size_t esb_len;
> > >>>>      size_t tima_len;
> > >>>> +    CPUState *cs;
> > >>>> +
> > >>>> +    /*
> > >>>> +     * The KVM XIVE device already in use. This is the case when
> > >>>> +     * rebooting XIVE -> XIVE =20
> > >>>
> > >>> Can this case actually occur?  Further down you appear to
> > >>> unconditionally destroy both KVM devices at reset time. =20
> > >>
> > >> I guess you are right. I will check.
> > >> =20
> > >>>> +     */
> > >>>> +    if (xive->fd !=3D -1) {
> > >>>> +        return;
> > >>>> +    }
> > >>>> =20
> > >>>>      if (!kvm_enabled() || !kvmppc_has_cap_xive()) {
> > >>>>          error_setg(errp, "IRQ_XIVE capability must be present for=
 KVM");
> > >>>> @@ -800,6 +809,24 @@ void kvmppc_xive_connect(sPAPRXive *xive, Err=
or **errp)
> > >>>>      xive->change =3D qemu_add_vm_change_state_handler(
> > >>>>          kvmppc_xive_change_state_handler, xive);
> > >>>> =20
> > >>>> +    /* Connect the presenters to the initial VCPUs of the machine=
 */
> > >>>> +    CPU_FOREACH(cs) {
> > >>>> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > >>>> +
> > >>>> +        kvmppc_xive_cpu_connect(cpu->tctx, &local_err);
> > >>>> +        if (local_err) {
> > >>>> +            error_propagate(errp, local_err);
> > >>>> +            return;
> > >>>> +        }
> > >>>> +    }
> > >>>> +
> > >>>> +    /* Update the KVM sources */
> > >>>> +    kvmppc_xive_source_reset(xsrc, &local_err);
> > >>>> +    if (local_err) {
> > >>>> +            error_propagate(errp, local_err);
> > >>>> +            return;
> > >>>> +    }
> > >>>> +
> > >>>>      kvm_kernel_irqchip =3D true;
> > >>>>      kvm_msi_via_irqfd_allowed =3D true;
> > >>>>      kvm_gsi_direct_mapping =3D true;
> > >>>> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> > >>>> index 1d21ff217b82..bfc35d71df7f 100644
> > >>>> --- a/hw/intc/xics_kvm.c
> > >>>> +++ b/hw/intc/xics_kvm.c
> > >>>> @@ -448,6 +448,16 @@ static void rtas_dummy(PowerPCCPU *cpu, sPAPR=
MachineState *spapr,
> > >>>>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp)
> > >>>>  {
> > >>>>      int rc;
> > >>>> +    CPUState *cs;
> > >>>> +    Error *local_err =3D NULL;
> > >>>> +
> > >>>> +    /*
> > >>>> +     * The KVM XICS device already in use. This is the case when
> > >>>> +     * rebooting XICS -> XICS
> > >>>> +     */
> > >>>> +    if (kernel_xics_fd !=3D -1) {
> > >>>> +        return 0;
> > >>>> +    }
> > >>>> =20
> > >>>>      if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP=
_IRQ_XICS)) {
> > >>>>          error_setg(errp,
> > >>>> @@ -496,6 +506,21 @@ int xics_kvm_init(sPAPRMachineState *spapr, E=
rror **errp)
> > >>>>      kvm_msi_via_irqfd_allowed =3D true;
> > >>>>      kvm_gsi_direct_mapping =3D true;
> > >>>> =20
> > >>>> +    /* Connect the presenters to the initial VCPUs of the machine=
 */
> > >>>> +    CPU_FOREACH(cs) {
> > >>>> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > >>>> +
> > >>>> +        icp_kvm_connect(cpu->icp, &local_err);
> > >>>> +        if (local_err) {
> > >>>> +            error_propagate(errp, local_err);
> > >>>> +            goto fail;
> > >>>> +        }
> > >>>> +        icp_set_kvm_state(cpu->icp, 1);
> > >>>> +    }
> > >>>> +
> > >>>> +    /* Update the KVM sources */
> > >>>> +    ics_set_kvm_state(ICS_KVM(spapr->ics), 1);
> > >>>> +
> > >>>>      return 0;
> > >>>> =20
> > >>>>  fail:
> > >>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > >>>> index c5c2fbc3f8bc..c166eab5b210 100644
> > >>>> --- a/hw/intc/xive.c
> > >>>> +++ b/hw/intc/xive.c
> > >>>> @@ -932,10 +932,6 @@ static void xive_source_reset(void *dev)
> > >>>> =20
> > >>>>      /* PQs are initialized to 0b01 (Q=3D1) which corresponds to "=
ints off" */
> > >>>>      memset(xsrc->status, XIVE_ESB_OFF, xsrc->nr_irqs);
> > >>>> -
> > >>>> -    if (kvmppc_xive_enabled()) {
> > >>>> -        kvmppc_xive_source_reset(xsrc, &error_fatal);
> > >>>> -    }
> > >>>>  }
> > >>>> =20
> > >>>>  static void xive_source_realize(DeviceState *dev, Error **errp)
> > >>>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > >>>> index ba27d9d8e972..5592eec3787b 100644
> > >>>> --- a/hw/ppc/spapr_irq.c
> > >>>> +++ b/hw/ppc/spapr_irq.c
> > >>>> @@ -98,20 +98,14 @@ static void spapr_irq_init_xics(sPAPRMachineSt=
ate *spapr, Error **errp)
> > >>>>      int nr_irqs =3D spapr->irq->nr_irqs;
> > >>>>      Error *local_err =3D NULL;
> > >>>> =20
> > >>>> -    if (kvm_enabled()) {
> > >>>> -        if (machine_kernel_irqchip_allowed(machine) &&
> > >>>> -            !xics_kvm_init(spapr, &local_err)) {
> > >>>> -            spapr->icp_type =3D TYPE_KVM_ICP;
> > >>>> -            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, =
nr_irqs,
> > >>>> -                                          &local_err);
> > >>>> -        }
> > >>>> -        if (machine_kernel_irqchip_required(machine) && !spapr->i=
cs) {
> > >>>> -            error_prepend(&local_err,
> > >>>> -                          "kernel_irqchip requested but unavailab=
le: ");
> > >>>> -            goto error; =20
> > >>>
> > >>> I don't see anything that replaces the irqchip_required logic, which
> > >>> doesn't seem right. =20
> > >>
> > >> Yes. We do loose the ability to fall back to the emulated device in =
case
> > >> of failure. It is not impossible to do but it will require more chan=
ges
> > >> to check what are the KVM capabilities before starting the machine. =
=20
> > >=20
> > > Uh... it seems more like it's the other way around.  We'll always fall
> > > back to emulated, even if we've explicitly said on the command line
> > > that we don't want that. =20
> >=20
> > Ah yes. The init function might be also broken.=20
> >=20
> > XICS mode is a bit more difficult to handle than XIVE because we have=
=20
> > different object type for the KVM device and the QEMU emulated device,=
=20
>=20
> This is indeed a bit unfortunate, but I think there's still room for
> improvement. Let's look at the base classes:
>=20
> struct ICPStateClass {
>     DeviceClass parent_class;
>=20
>     DeviceRealize parent_realize;
>     DeviceReset parent_reset;
>=20
>     void (*pre_save)(ICPState *icp);
>     int (*post_load)(ICPState *icp, int version_id);
>     void (*synchronize_state)(ICPState *icp);
> };
>=20
> struct ICSStateClass {
>     DeviceClass parent_class;
>=20
>     DeviceRealize parent_realize;
>     DeviceReset parent_reset;
>=20
>     void (*pre_save)(ICSState *s);
>     int (*post_load)(ICSState *s, int version_id);
>     void (*reject)(ICSState *s, uint32_t irq);
>     void (*resend)(ICSState *s);
>     void (*eoi)(ICSState *s, uint32_t irq);
>     void (*synchronize_state)(ICSState *s);
> };
>=20
> The pre_save and post_load callbacks are only used with
> the KVM device. They could be explicitely called from
> the corresponding VMStateDescription callbacks with a
> kvm_enabled() && kvm_irqchip_in_kernel() check.
>=20
> Same goes for the synchronize_state callbacks, which are only
> needed for 'info pic'.
>=20
> The reject, resend and eoi callbacks are only called by code that
> belongs to the QEMU emulated device. Either the RTAS/hypercalls
> or from the machine code with explicit checks like:
>=20
> static void spapr_irq_set_irq_xics(void *opaque, int srcno, int val)
> {
>     sPAPRMachineState *spapr =3D opaque;
>     MachineState *machine =3D MACHINE(opaque);
>=20
>     if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
>         ics_kvm_set_irq(spapr->ics, srcno, val);
>     } else {
>         ics_simple_set_irq(spapr->ics, srcno, val);
>     }
> }
>=20
> or
>=20
> static int spapr_irq_post_load_xics(sPAPRMachineState *spapr, int version=
_id)
> {
>     if (!object_dynamic_cast(OBJECT(spapr->ics), TYPE_ICS_KVM)) {
>         CPUState *cs;
>         CPU_FOREACH(cs) {
>             PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>             icp_resend(spapr_cpu_state(cpu)->icp);
>         }
>     }
>     return 0;
> }
>=20
> Unless I'm missing something, the reject, resend and eoi callbacks could
> simply be removed. This would allow to unify KVM and QEMU emulation in
> the same ICP and ICS object types.
>=20
> If this makes sense to you, I can have a look (already started actually ;=
-)

Please do.  The use of different object types was something that
seemed like a good idea at the time, but in hindsight, wasn't.  In
general different device types should represent guest-visibly
different objects, not just implementation differences.

> > and with the 'dual' mode, we activate the device at CAS reset time.
> >=20
> > Failures being handled at reset time, should we keep the same logic and=
 =20
> > abort the machine at reset if the kernel irqchip is required ?=20
> >=20
>=20
> If the user passed ic-mode=3Ddual,kernel-irqchip=3Don, we should at least=
 make
> sure KVM supports both XICS and XIVE devices during machine init. Then
> during reset if something goes wrong with KVM, it seems ok to abort.
>=20
> If the user didn't pass kernel-irqchip, ie, kernel_irqchip_allowed is true
> and kernel_irqchip_required is false, the current behavior for XICS is
> to try KVM first and fallback to QEMU emulation. I guess it could be the
> same for XIVE.

Yes, I think that's the behaviour we want, on all counts.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JqdxN8yMrvvaufxH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxk4hsACgkQbDjKyiDZ
s5ILyw//Suxws8fe2Zf4cxPwz2/fHS8aoFCGvi8wfEN2t48FqJYIgrm6wYmp56Wl
cm0wcLH5yGNkOWJmZ1dw25z8lzhwiPxb1v4zqBl4XFAltJl7NnfKjIVy1VNsSMua
7ZhyEtnGCmfhkOcYn0h0q+Nd/MPdegGgLQ6yEoFmY9IVecYKIJaRlszKv+ycmDLm
slBQmjq1Sq631BmEVLnfbdilylt1t7iRcG7tnRcy8eWpEnsQxX8r2ijZivMDSbAl
48T8b9s9Fpyr5jTl5XDBu1fCjyWzv5mKKFL5BfJYkFAo9k5Iq2bH0Ei12aW4rILn
zwjfLEBXjmR22ArTQ4IxrhSzbYuWlRunghv/zE0avwiPLZmEP2Xs6VSOIPo/mFZc
Nm8bjFreK3jKa2V1gtJUDd8hhMTtCCfASQOJLiIEyZb4TBLe4eFj2FcEZSd3LBl+
355oCUTuQyq038FljYYAf3NrjxL0Q2n5SdwQWdyGRHJB8ZI8M11M+pSiaaU85zuw
KReMwG6GANOczKZcQKKGvS3WdyCv2o3n2cEIJYoYGbksn5l++78flDMWtz8GyD6V
XR6kjaBP4a0EKyd3YfwQLqmkeFRlggWsKV655SHiHWVkrH3epu4Z53h40BOS7svZ
P3V55F9EUtWXQbP9gq3PtWZtmj0mXT9Sdx3pBsk7BP2AxzVyn3U=
=i51L
-----END PGP SIGNATURE-----

--JqdxN8yMrvvaufxH--
