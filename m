Received: from eggs.gnu.org ([2001:4830:134:3::10]:42325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciYjQ-0003oA-AF
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 22:45:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciYjO-0001zX-Rn
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 22:45:44 -0500
Date: Tue, 28 Feb 2017 14:19:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170228031912.GP17615@umbus.fritz.box>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
	<034945c1bbc8d4a97e5f568d4d463af2c9a24080.1487829585.git.sam.bobroff@au1.ibm.com>
	<20170228002810.GD17615@umbus.fritz.box>
	<1488248717.2323.11.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k3Hs6P4rqk1MjcAG"
Content-Disposition: inline
In-Reply-To: <1488248717.2323.11.camel@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 08/12] spapr: Only setup HTP if
 necessary.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: Sam Bobroff <sam.bobroff@au1.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--k3Hs6P4rqk1MjcAG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2017 at 01:25:17PM +1100, Suraj Jitindar Singh wrote:
> On Tue, 2017-02-28 at 11:28 +1100, David Gibson wrote:
> > s/HTP/HPT/ in subject line.
> >=20
> >=20
> > On Thu, Feb 23, 2017 at 05:00:01PM +1100, Sam Bobroff wrote:
> > >=20
> > > If QEMU is using KVM, and KVM is capable of running in radix mode,
> > > guests can be run in real-mode without allocating a HPT (because
> > > KVM
> > > will use a minimal RPT). So in this case, we avoid creating the HPT
> > > at reset time and later (during CAS) create it if it is necessary.
> > >=20
> > > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> > So, IIRC, we discussed previously that the logical way to do things
> > was to, by default, delay HPT allocation until CAS time, and just do
> > it at reset time for the case that needs it: hash host with KVM.
> >=20
> > Did you hit a problem with that approach, or is there still work to
> > be
> > done here?
>=20
> So what we're doing is assuming radix. Allocate hpt if hash host,
> otherwise delay til CAS time and allocate only if guest chose hash.
>=20
> >=20
> > >=20
> > > ---
> > > v2:
> > >=20
> > > * This patch has been mostly rewritten to move the late HPT
> > > allocation to CAS.
> > > This allows a guest to start in radix mode (when it's in real mode)
> > > and then
> > > change to hash, even if it is a legacy guest and will not call
> > > h_register_process_table().
> > > * Added an exported function to spapr.c to perform HPT allocation
> > > and adjust
> > > the vrma if necessary. This makes it possible to allocate the HPT
> > > from
> > > h_client_architecture_support() in spapr_hcall.c.
> > >=20
> > > =A0hw/ppc/spapr.c=A0=A0=A0=A0=A0=A0=A0=A0=A0| 24 +++++++++++++++-----=
----
> > > =A0hw/ppc/spapr_hcall.c=A0=A0=A0| 10 ++++++++++
> > > =A0include/hw/ppc/spapr.h |=A0=A01 +
> > > =A03 files changed, 26 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index ca3812555f..dfee0f685f 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1123,6 +1123,17 @@ static void
> > > spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
> > > =A0=A0=A0=A0=A0}
> > > =A0}
> > > =A0
> > > +void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
> > > +{
> > > +=A0=A0=A0=A0spapr_reallocate_hpt(spapr,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0spapr=
_hpt_shift_for_ramsize(MACHINE(qdev_get_
> > > machine())->maxram_size),
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0&erro=
r_fatal);
> > > +=A0=A0=A0=A0if (spapr->vrma_adjust) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0spapr->rma_size =3D kvmppc_rma_size(spapr_no=
de0_size(),
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0spapr->htab_shi=
ft);
> > > +=A0=A0=A0=A0}
> > > +}
> > > +
> > > =A0static void find_unknown_sysbus_device(SysBusDevice *sbdev, void
> > > *opaque)
> > > =A0{
> > > =A0=A0=A0=A0=A0bool matched =3D false;
> > > @@ -1151,15 +1162,10 @@ static void ppc_spapr_reset(void)
> > > =A0=A0=A0=A0=A0/* Check for unknown sysbus devices */
> > > =A0=A0=A0=A0=A0foreach_dynamic_sysbus_device(find_unknown_sysbus_devi=
ce,
> > > NULL);
> > > =A0
> > > -=A0=A0=A0=A0/* Allocate and/or reset the hash page table */
> > > -=A0=A0=A0=A0spapr_reallocate_hpt(spapr,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0spapr_hpt_shift_for_ramsize(machine-
> > > >maxram_size),
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0&error_fatal);
> > > -
> > > -=A0=A0=A0=A0/* Update the RMA size if necessary */
> > > -=A0=A0=A0=A0if (spapr->vrma_adjust) {
> > > -=A0=A0=A0=A0=A0=A0=A0=A0spapr->rma_size =3D kvmppc_rma_size(spapr_no=
de0_size(),
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0spapr->htab_shi=
ft);
> > > +=A0=A0=A0=A0/* If using KVM with radix mode available, VCPUs can be
> > > started
> > > +=A0=A0=A0=A0=A0* without a HPT because KVM will start them in radix =
mode. */
> > > +=A0=A0=A0=A0if (!(kvm_enabled() && kvmppc_has_cap_mmu_radix())) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0spapr_setup_hpt_and_vrma(spapr);
> > > =A0=A0=A0=A0=A0}
> > > =A0
> > > =A0=A0=A0=A0=A0qemu_devices_reset();
> > > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > > index 42d20e0b92..cea34073aa 100644
> > > --- a/hw/ppc/spapr_hcall.c
> > > +++ b/hw/ppc/spapr_hcall.c
> > > @@ -1002,6 +1002,16 @@ static target_ulong
> > > h_client_architecture_support(PowerPCCPU *cpu,
> > > =A0=A0=A0=A0=A0ov5_updates =3D spapr_ovec_new();
> > > =A0=A0=A0=A0=A0spapr->cas_reboot =3D spapr_ovec_diff(ov5_updates,
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ov5_cas_old, spapr-
> > > >ov5_cas);
> > > +=A0=A0=A0=A0if (kvm_enabled()) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0if (kvmppc_has_cap_mmu_radix()) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* If the HPT hasn't yet been se=
t up (see
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0* ppc_spapr_reset()), and it'=
s needed, do it now: */
> > I think it's a bit fragile to have here it explicitly mirror the
> > logic
> > which determines whether the HPT is allocated early.=A0=A0I'd prefer to
> > explicitly test here whether we have allocated an HPT - adding a
> > flag,
> > if we have to.
>=20
> We can use the MSB of patb_entry as that flag.

Uh.. only for POWER9..

> patb_entry & GUEST_RADIX =3D=3D GUEST_RADIX -> radix, so assume a hpt
> hasn't been allocated.
>=20
> When we do allocate a hpt we know we're not radix, so set
> patb_entry &=3D ~GUEST_RADIX;
>=20
> Where GUEST_RADIX is the msb in patb_entry which indicates that a guest
> is radix.
>=20
> Essentially patb_entry & GUEST_RADIX cleared mean hash with hpt
> allocated, patb_entry & GUEST_RADIX set means radix so assume an hpt
> hasn't been allocated. On the hpt allocation path we clear GUEST_RADIX
> in patb_entry and when we set GUEST_RADIX we free the hpt.
>=20
> >=20
> > >=20
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!spapr_ovec_test(ov5_updates=
, OV5_MMU_RADIX)) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* legacy hash or ne=
w hash: */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0spapr_setup_hpt_and_=
vrma(spapr);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > +=A0=A0=A0=A0=A0=A0=A0=A0}
> > > +=A0=A0=A0=A0}
> > > =A0
> > > =A0=A0=A0=A0=A0if (!spapr->cas_reboot) {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0spapr->cas_reboot =3D
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index f9b17d860a..a30cbc485c 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -590,6 +590,7 @@ void spapr_dt_events(sPAPRMachineState *sm,
> > > void *fdt);
> > > =A0int spapr_h_cas_compose_response(sPAPRMachineState *sm,
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0target_ulong addr, target_ulong
> > > size,
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0sPAPROptionVector *ov5_updates);
> > > +void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr);
> > > =A0sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t
> > > liobn);
> > > =A0void spapr_tce_table_enable(sPAPRTCETable *tcet,
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0uint32_t page_shift, uint64_t
> > > bus_offset,
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k3Hs6P4rqk1MjcAG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYtOwrAAoJEGw4ysog2bOSnE8P+gLGTZMDSK+h7hLP9R19Eevz
FANzQzmkLrnz5sOe1HsF38zUv1zkdhRTlb05S74nEZy8mOm4Ii62nXbixhIQtLlw
GefSSRlsihSvWFbKDC5SnupHrSlTMLTKleZ4Pd4XM1lj/zqUXRnNbZKQHwjPhyEx
cQGx4jOPDl+PxL7W2EWOpWf1azcftH44nk/bZ7djB6px3OAQ1yCE9RdOdbkQyL+6
t5KU3GKIXcl3YQ4N71MMpGo7emK9iPBzVfMJArw6+aMZsphNzP2hUr9ZUusxxTKq
W0r7dm6kD4cFa4/pimx5LTvbs8aU8OR86J3qycJx0o9AnyPGLlK9lAZSmL36dZ8l
BTYZ0nyX3T4rV6Z1tn5+dT8/4OBBrp9/SujpKbyxwnkJnHei7SmF6yDwfyDK6DUH
rxiWlQxPqaJSvZ3+p3a076Ld4jwTyb8sbB2ZyxLwSxhcYVnn+AVFa+wwQb2GVH+Y
uqFyyx6m7hkvKy3J3AFcXP49MD8MEnWBDo7MmFrmfui1kDxXYb7O24hn/MHVH3GQ
oSpWn2h5l/yuaE88jVQ2AEPigpCsMRKMw5AXKPpHRVO7Bi3Q8dNfs0utS9xMDL8Y
2s0qDjq+fJZV6jlJh7N1ni9GyAPGT6RxcSdD08frAhj8STnjXYPC2bH0QH+y6CEk
9Yyf9vlaVPoX/xu1ISPJ
=eNDe
-----END PGP SIGNATURE-----

--k3Hs6P4rqk1MjcAG--
