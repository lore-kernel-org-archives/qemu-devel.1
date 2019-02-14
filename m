Received: from eggs.gnu.org ([209.51.188.92]:56712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu7p1-0008C3-Qu
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:36:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu7jn-0003ct-EW
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:31:01 -0500
Date: Thu, 14 Feb 2019 14:29:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190214032916.GY1884@umbus.fritz.box>
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-14-clg@kaod.org>
	<20190212011153.GH1884@umbus.fritz.box>
	<d6dc35c6-4987-3fcc-de81-f2aff865cad1@kaod.org>
	<20190213013219.GU1884@umbus.fritz.box>
	<f0b93ebb-e8b5-4448-9b57-8da2feee493c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V3VOne4eOnSspFMY"
Content-Disposition: inline
In-Reply-To: <f0b93ebb-e8b5-4448-9b57-8da2feee493c@kaod.org>
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


--V3VOne4eOnSspFMY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 09:22:46AM +0100, C=E9dric Le Goater wrote:
> On 2/13/19 2:32 AM, David Gibson wrote:
> > On Tue, Feb 12, 2019 at 08:18:19AM +0100, C=E9dric Le Goater wrote:
> >> On 2/12/19 2:11 AM, David Gibson wrote:
> >>> On Mon, Jan 07, 2019 at 07:39:46PM +0100, C=E9dric Le Goater wrote:
> >>>> The interrupt mode is chosen by the CAS negotiation process and
> >>>> activated after a reset to take into account the required changes in
> >>>> the machine. This brings new constraints on how the associated KVM I=
RQ
> >>>> device is initialized.
> >>>>
> >>>> Currently, each model takes care of the initialization of the KVM
> >>>> device in their realize method but this is not possible anymore as t=
he
> >>>> initialization needs to be done globaly when the interrupt mode is
> >>>> known, i.e. when machine is reseted. It also means that we need a way
> >>>> to delete a KVM device when another mode is chosen.
> >>>>
> >>>> Also, to support migration, the QEMU objects holding the state to
> >>>> transfer should always be available but not necessarily activated.
> >>>>
> >>>> The overall approach of this proposal is to initialize both interrupt
> >>>> mode at the QEMU level and keep the IRQ number space in sync to allow
> >>>> switching from one mode to another. For the KVM side of things, the
> >>>> whole initialization of the KVM device, sources and presenters, is
> >>>> grouped in a single routine. The XICS and XIVE sPAPR IRQ reset
> >>>> handlers are modified accordingly to handle the init and the delete
> >>>> sequences of the KVM device.
> >>>>
> >>>> As KVM is now initialized at reset, we loose the possiblity to
> >>>> fallback to the QEMU emulated mode in case of failure and failures
> >>>> become fatal to the machine.
> >>>>
> >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>> ---
> >>>>  hw/intc/spapr_xive.c     |  8 +---
> >>>>  hw/intc/spapr_xive_kvm.c | 27 ++++++++++++++
> >>>>  hw/intc/xics_kvm.c       | 25 +++++++++++++
> >>>>  hw/intc/xive.c           |  4 --
> >>>>  hw/ppc/spapr_irq.c       | 79 ++++++++++++++++++++++++++++---------=
---
> >>>>  5 files changed, 109 insertions(+), 34 deletions(-)
> >>>>
> >>>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> >>>> index 21f3c1ef0901..0661aca35900 100644
> >>>> --- a/hw/intc/spapr_xive.c
> >>>> +++ b/hw/intc/spapr_xive.c
> >>>> @@ -330,13 +330,7 @@ static void spapr_xive_realize(DeviceState *dev=
, Error **errp)
> >>>>      xive->eat =3D g_new0(XiveEAS, xive->nr_irqs);
> >>>>      xive->endt =3D g_new0(XiveEND, xive->nr_ends);
> >>>> =20
> >>>> -    if (kvmppc_xive_enabled()) {
> >>>> -        kvmppc_xive_connect(xive, &local_err);
> >>>> -        if (local_err) {
> >>>> -            error_propagate(errp, local_err);
> >>>> -            return;
> >>>> -        }
> >>>> -    } else {
> >>>> +    if (!kvmppc_xive_enabled()) {
> >>>>          /* TIMA initialization */
> >>>>          memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_t=
m_ops, xive,
> >>>>                                "xive.tima", 4ull << TM_SHIFT);
> >>>> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> >>>> index d35814c1992e..3ebc947f2be7 100644
> >>>> --- a/hw/intc/spapr_xive_kvm.c
> >>>> +++ b/hw/intc/spapr_xive_kvm.c
> >>>> @@ -737,6 +737,15 @@ void kvmppc_xive_connect(sPAPRXive *xive, Error=
 **errp)
> >>>>      Error *local_err =3D NULL;
> >>>>      size_t esb_len;
> >>>>      size_t tima_len;
> >>>> +    CPUState *cs;
> >>>> +
> >>>> +    /*
> >>>> +     * The KVM XIVE device already in use. This is the case when
> >>>> +     * rebooting XIVE -> XIVE
> >>>
> >>> Can this case actually occur?  Further down you appear to
> >>> unconditionally destroy both KVM devices at reset time.
> >>
> >> I guess you are right. I will check.
> >>
> >>>> +     */
> >>>> +    if (xive->fd !=3D -1) {
> >>>> +        return;
> >>>> +    }
> >>>> =20
> >>>>      if (!kvm_enabled() || !kvmppc_has_cap_xive()) {
> >>>>          error_setg(errp, "IRQ_XIVE capability must be present for K=
VM");
> >>>> @@ -800,6 +809,24 @@ void kvmppc_xive_connect(sPAPRXive *xive, Error=
 **errp)
> >>>>      xive->change =3D qemu_add_vm_change_state_handler(
> >>>>          kvmppc_xive_change_state_handler, xive);
> >>>> =20
> >>>> +    /* Connect the presenters to the initial VCPUs of the machine */
> >>>> +    CPU_FOREACH(cs) {
> >>>> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >>>> +
> >>>> +        kvmppc_xive_cpu_connect(cpu->tctx, &local_err);
> >>>> +        if (local_err) {
> >>>> +            error_propagate(errp, local_err);
> >>>> +            return;
> >>>> +        }
> >>>> +    }
> >>>> +
> >>>> +    /* Update the KVM sources */
> >>>> +    kvmppc_xive_source_reset(xsrc, &local_err);
> >>>> +    if (local_err) {
> >>>> +            error_propagate(errp, local_err);
> >>>> +            return;
> >>>> +    }
> >>>> +
> >>>>      kvm_kernel_irqchip =3D true;
> >>>>      kvm_msi_via_irqfd_allowed =3D true;
> >>>>      kvm_gsi_direct_mapping =3D true;
> >>>> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> >>>> index 1d21ff217b82..bfc35d71df7f 100644
> >>>> --- a/hw/intc/xics_kvm.c
> >>>> +++ b/hw/intc/xics_kvm.c
> >>>> @@ -448,6 +448,16 @@ static void rtas_dummy(PowerPCCPU *cpu, sPAPRMa=
chineState *spapr,
> >>>>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp)
> >>>>  {
> >>>>      int rc;
> >>>> +    CPUState *cs;
> >>>> +    Error *local_err =3D NULL;
> >>>> +
> >>>> +    /*
> >>>> +     * The KVM XICS device already in use. This is the case when
> >>>> +     * rebooting XICS -> XICS
> >>>> +     */
> >>>> +    if (kernel_xics_fd !=3D -1) {
> >>>> +        return 0;
> >>>> +    }
> >>>> =20
> >>>>      if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_I=
RQ_XICS)) {
> >>>>          error_setg(errp,
> >>>> @@ -496,6 +506,21 @@ int xics_kvm_init(sPAPRMachineState *spapr, Err=
or **errp)
> >>>>      kvm_msi_via_irqfd_allowed =3D true;
> >>>>      kvm_gsi_direct_mapping =3D true;
> >>>> =20
> >>>> +    /* Connect the presenters to the initial VCPUs of the machine */
> >>>> +    CPU_FOREACH(cs) {
> >>>> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >>>> +
> >>>> +        icp_kvm_connect(cpu->icp, &local_err);
> >>>> +        if (local_err) {
> >>>> +            error_propagate(errp, local_err);
> >>>> +            goto fail;
> >>>> +        }
> >>>> +        icp_set_kvm_state(cpu->icp, 1);
> >>>> +    }
> >>>> +
> >>>> +    /* Update the KVM sources */
> >>>> +    ics_set_kvm_state(ICS_KVM(spapr->ics), 1);
> >>>> +
> >>>>      return 0;
> >>>> =20
> >>>>  fail:
> >>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> >>>> index c5c2fbc3f8bc..c166eab5b210 100644
> >>>> --- a/hw/intc/xive.c
> >>>> +++ b/hw/intc/xive.c
> >>>> @@ -932,10 +932,6 @@ static void xive_source_reset(void *dev)
> >>>> =20
> >>>>      /* PQs are initialized to 0b01 (Q=3D1) which corresponds to "in=
ts off" */
> >>>>      memset(xsrc->status, XIVE_ESB_OFF, xsrc->nr_irqs);
> >>>> -
> >>>> -    if (kvmppc_xive_enabled()) {
> >>>> -        kvmppc_xive_source_reset(xsrc, &error_fatal);
> >>>> -    }
> >>>>  }
> >>>> =20
> >>>>  static void xive_source_realize(DeviceState *dev, Error **errp)
> >>>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> >>>> index ba27d9d8e972..5592eec3787b 100644
> >>>> --- a/hw/ppc/spapr_irq.c
> >>>> +++ b/hw/ppc/spapr_irq.c
> >>>> @@ -98,20 +98,14 @@ static void spapr_irq_init_xics(sPAPRMachineStat=
e *spapr, Error **errp)
> >>>>      int nr_irqs =3D spapr->irq->nr_irqs;
> >>>>      Error *local_err =3D NULL;
> >>>> =20
> >>>> -    if (kvm_enabled()) {
> >>>> -        if (machine_kernel_irqchip_allowed(machine) &&
> >>>> -            !xics_kvm_init(spapr, &local_err)) {
> >>>> -            spapr->icp_type =3D TYPE_KVM_ICP;
> >>>> -            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr=
_irqs,
> >>>> -                                          &local_err);
> >>>> -        }
> >>>> -        if (machine_kernel_irqchip_required(machine) && !spapr->ics=
) {
> >>>> -            error_prepend(&local_err,
> >>>> -                          "kernel_irqchip requested but unavailable=
: ");
> >>>> -            goto error;
> >>>
> >>> I don't see anything that replaces the irqchip_required logic, which
> >>> doesn't seem right.
> >>
> >> Yes. We do loose the ability to fall back to the emulated device in ca=
se
> >> of failure. It is not impossible to do but it will require more changes
> >> to check what are the KVM capabilities before starting the machine.
> >=20
> > Uh... it seems more like it's the other way around.  We'll always fall
> > back to emulated, even if we've explicitly said on the command line
> > that we don't want that.
>=20
> Ah yes. The init function might be also broken.=20
>=20
> XICS mode is a bit more difficult to handle than XIVE because we have=20
> different object type for the KVM device and the QEMU emulated device,=20
> and with the 'dual' mode, we activate the device at CAS reset time.

Yeah.. we should probably fix that.

> Failures being handled at reset time, should we keep the same logic and =
=20
> abort the machine at reset if the kernel irqchip is required ?=20
>=20
> But we won't be able to fall back on the QEMU emulated device if KVM=20
> XICS fails and if the kernel irqchip is only allowed. It should work for=
=20
> XIVE though.

That's fine.  If we've said that kernel irqchip is required, we
shouldn't fall back to emulation.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V3VOne4eOnSspFMY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxk4IgACgkQbDjKyiDZ
s5Ii1Q//RmgYo2yG4gi4usMkyaJYAnm97d3M4F4Axuo1D6aTE9aOKKkUKYPJZ4PN
+ZDRExXAVk4Rr2Go3C2blW/5R99r7EjtjMW4hIMHFO4Y6IMa4oc5ENH/hQtsttr3
SroXiJDa39FefgkitZEBytnuG4uwfyT7zxwT7JIAjrDEw7/BW6+Db1HN2m7RyG3O
5zACAF2eH/1dR0P0YS+cJYClLVVsFZVsqrMxT0l2CwrQ0MZ1hEIl6vP4CeAuml2K
T4UzdWrg2nL7ZCjMsiMFYPUidokjH8RsHOP8nknebeve64Pp76J8CnaGicR/XY5Y
NeZcNiSq3KSbpOK1Lk9XVMs9cc0aIyI8EKP1Z4b52vZ+6ny4l039BQSgcfdaOuQK
nGNKImUNQMDc4d4mJfNdPPKsX0e8Tsqms8c5RHlWr7Ml52SmMDklV8khmyVNdE7g
LYbtModBX2Oq62eWHUwDMRzkkQ5s15EOELXFOqnby2NSfj3YMYKI1YfmfbykpB6o
JgFQ/IM8Vgq9GE8VGrQIZ8m2Jf//QqJsmYyKrwxABKmQU1HOlT4IwwMt+FSbzDFJ
7cDu+bDvBj2fV6m16PFmxyYRZ7V4LR5HqE3M1c1qedcAZCNkOb1mABuATYOszGfZ
6m+eeHnNsL+A/ponRyUXwUM3RMD4ARQl0XDHh48c5XuayXEAM1o=
=93UV
-----END PGP SIGNATURE-----

--V3VOne4eOnSspFMY--
