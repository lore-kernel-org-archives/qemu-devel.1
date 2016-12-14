Received: from eggs.gnu.org ([2001:4830:134:3::10]:34752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cHHRC-0006uG-D7
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 16:50:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cHHR8-0001zn-6I
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 16:50:10 -0500
Date: Wed, 14 Dec 2016 17:20:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161214062008.GI32647@umbus>
References: <20161212040603.27295-1-david@gibson.dropbear.id.au>
	<20161212040603.27295-4-david@gibson.dropbear.id.au>
	<1481693457.1555.25.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="boAH8PqvUi1v1f55"
Content-Disposition: inline
In-Reply-To: <1481693457.1555.25.camel@gmail.com>
Subject: Re: [Qemu-devel] [PATCHv3 3/5] pseries: Implement HPT resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: paulus@samba.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, thuth@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--boAH8PqvUi1v1f55
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2016 at 04:30:57PM +1100, Suraj Jitindar Singh wrote:
> On Mon, 2016-12-12 at 15:06 +1100, David Gibson wrote:
[snip]
> > +=A0=A0=A0=A0if (!(pte0 & HPTE64_V_VALID) || !(pte0 & HPTE64_V_BOLTED))=
 {
> > +=A0=A0=A0=A0=A0=A0=A0=A0return H_SUCCESS;
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0pte1 =3D ppc_hash64_load_hpte1(cpu, token, slot);
> > +
> > +=A0=A0=A0=A0shift =3D ppc_hash64_hpte_page_shift_noslb(cpu, pte0, pte1=
);
> > +=A0=A0=A0=A0assert(shift); /* H_ENTER should never have allowed a bad
> > encoding */
> > +=A0=A0=A0=A0avpn =3D HPTE64_V_AVPN_VAL(pte0) & ~(((1ULL << shift) - 1)=
 >> 23);
> > +
> > +=A0=A0=A0=A0if (pte0 & HPTE64_V_SECONDARY) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0pteg =3D ~pteg;
> > +=A0=A0=A0=A0}
> > +
> The hash calculation below is pretty hard to follow... That being said
> I don't really see a nicer way of structuring it. I guess you just have
> to wade through the ISA if you actually want to understand what's
> happening here (which I assume most people won't bother with).

Yeah, the hash calculation is always hard to follow.  Here it's
particularly bad because we're essentially doing two: one backwards
and one forwards.  Unless someone has a great suggestion, I don't
really see a way to make this obvious.

> > +=A0=A0=A0=A0if ((pte0 & HPTE64_V_SSIZE) =3D=3D HPTE64_V_SSIZE_256M) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0uint64_t offset, vsid;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0/* We only have 28 - 23 bits of offset in avpn=
 */
> > +=A0=A0=A0=A0=A0=A0=A0=A0offset =3D (avpn & 0x1f) << 23;
> > +=A0=A0=A0=A0=A0=A0=A0=A0vsid =3D avpn >> 5;
> > +=A0=A0=A0=A0=A0=A0=A0=A0/* We can find more bits from the pteg value */
> > +=A0=A0=A0=A0=A0=A0=A0=A0if (shift < 23) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0offset |=3D ((vsid ^ pteg) & old_h=
ash_mask) << shift;
> > +=A0=A0=A0=A0=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0hash =3D vsid ^ (offset >> shift);
> > +=A0=A0=A0=A0} else if ((pte0 & HPTE64_V_SSIZE) =3D=3D HPTE64_V_SSIZE_1=
T) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0uint64_t offset, vsid;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0/* We only have 40 - 23 bits of seg_off in avp=
n */
> > +=A0=A0=A0=A0=A0=A0=A0=A0offset =3D (avpn & 0x1ffff) << 23;
> > +=A0=A0=A0=A0=A0=A0=A0=A0vsid =3D avpn >> 17;
> > +=A0=A0=A0=A0=A0=A0=A0=A0if (shift < 23) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0offset |=3D ((vsid ^ (vsid << 25) =
^ pteg) & old_hash_mask)
> > << shift;
> > +=A0=A0=A0=A0=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0hash =3D vsid ^ (vsid << 25) ^ (offset >> shif=
t);
> > +=A0=A0=A0=A0} else {
> > +=A0=A0=A0=A0=A0=A0=A0=A0error_report("rehash_pte: Bad segment size in =
HPTE");
> > +=A0=A0=A0=A0=A0=A0=A0=A0return H_HARDWARE;
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0new_pteg =3D hash & new_hash_mask;
> > +=A0=A0=A0=A0if (pte0 & HPTE64_V_SECONDARY) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0assert(~pteg =3D=3D (hash & old_hash_mask));
> > +=A0=A0=A0=A0=A0=A0=A0=A0new_pteg =3D ~new_pteg;
> > +=A0=A0=A0=A0} else {
> > +=A0=A0=A0=A0=A0=A0=A0=A0assert(pteg =3D=3D (hash & old_hash_mask));
> > +=A0=A0=A0=A0}
> > +=A0=A0=A0=A0assert((oldsize !=3D newsize) || (pteg =3D=3D new_pteg));
> > +=A0=A0=A0=A0replace_pte0 =3D new_hpte_load0(new, new_pteg, slot);
> > +=A0=A0=A0=A0if (replace_pte0 & HPTE64_V_VALID) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0assert(newsize < oldsize);
> > +=A0=A0=A0=A0=A0=A0=A0=A0if (replace_pte0 & HPTE64_V_BOLTED) {
> Aren't both of these checks for BOLTED redundant? We know that we are
> only rehashing ptes which are both valid and bolted, otherwise we would
> have returned at *** above. Thus the new hpt will only contain invalid
> entries or valid && bolted entries, we don't need to check if
> replace_pte is bolted if we know it's valid. Similarly we know the one
> we are replacing it with is bolted, otherwise we wouldn't have bothered
> rehashing it. Thus it's pretty much sufficient to check replace_pte0
> &&=A0HPTE64_V_VALID =3D=3D 1 which implies a bolted collision irrespectiv=
e.

Ah, so, technically, yes it's redundant.  I'd prefer to leave it as
is, in case we ever implement a version which also rehashes non-bolted
entries.  As it is we could do that simply by changing the test at the
top, without needing a synchronized change here.

> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (pte0 & HPTE64_V_BOLTED) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Bolted collision, n=
othing we can do */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return H_PTEG_FULL;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Discard this hpte */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return H_SUCCESS;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0=A0}
> Is there any reason the rehashed pte has to go into the same slot it
> came out of? Isn't it valid to search all of the slots of the new pteg
> for an empty (invalid) one and put it in the first empty space? Just
> because the current slot already contains a bolted entry doesn't mean
> we can't put it in another slot, right?

Not in practice.  The guest is allowed to keep track of which slot it
loaded an HPTE into and use that for later updates or invalidates -
Linux guests do this in practice.  Because of that the PAPR ACR
explicitly says the resize must preserve hash slots.

I theory we could implement a variant which didn't do this, but I
doubt we'll ever want to because it will be much, much harder to work
with on the guest side.

> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0new_hpte_store(new, new_pteg, slot, pte0, pte1);
> > +=A0=A0=A0=A0return H_SUCCESS;
> > +}
> > +
> > +static int rehash_hpt(PowerPCCPU *cpu,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0void=
 *old, uint64_t oldsize,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0void=
 *new, uint64_t newsize)
> > +{
> > +=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > +=A0=A0=A0=A0uint64_t n_ptegs =3D oldsize >> 7;
> > +=A0=A0=A0=A0uint64_t pteg;
> > +=A0=A0=A0=A0int slot;
> > +=A0=A0=A0=A0int rc;
> > +
> > +=A0=A0=A0=A0assert(env->external_htab =3D=3D old);
> > +
> > +=A0=A0=A0=A0for (pteg =3D 0; pteg < n_ptegs; pteg++) {
> Can we rename token to pteg_[base_]addr or something? Token is very...
> generic

So the value returned here is supposed to be opaque, and only passed
back to the accessor helpers.  It returns different things depending
on if we have an external HPT, or an internal HPT (virtual bare metal
machine).  Hence the generic name.

> > +=A0=A0=A0=A0=A0=A0=A0=A0uint64_t token =3D ppc_hash64_start_access(cpu=
, pteg *
> > HPTES_PER_GROUP);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0if (!token) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return H_HARDWARE;
> > +=A0=A0=A0=A0=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0for (slot =3D 0; slot < HPTES_PER_GROUP; slot+=
+) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0rc =3D rehash_hpte(cpu, token, old=
, oldsize, new, newsize,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0pteg, slot);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (rc !=3D H_SUCCESS) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_stop_access=
(cpu, token);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return rc;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_stop_access(cpu, token);
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0return H_SUCCESS;
> > +}
> > +
> > +static void pivot_hpt(CPUState *cs, run_on_cpu_data arg)
> > +{
> > +=A0=A0=A0=A0sPAPRMachineState *spapr =3D SPAPR_MACHINE(arg.host_ptr);
> > +=A0=A0=A0=A0PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > +
> > +=A0=A0=A0=A0cpu_synchronize_state(cs);
> > +=A0=A0=A0=A0ppc_hash64_set_external_hpt(cpu, spapr->htab, spapr->htab_=
shift,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0&error_fatal);
> > =A0}
> > =A0
> > =A0static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
> > @@ -378,13 +678,52 @@ static target_ulong
> > h_resize_hpt_commit(PowerPCCPU *cpu,
> > =A0{
> > =A0=A0=A0=A0=A0target_ulong flags =3D args[0];
> > =A0=A0=A0=A0=A0target_ulong shift =3D args[1];
> > +=A0=A0=A0=A0sPAPRPendingHPT *pending =3D spapr->pending_hpt;
> > +=A0=A0=A0=A0int rc;
> > +=A0=A0=A0=A0size_t newsize;
> > =A0
> > =A0=A0=A0=A0=A0if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DISABLED) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0return H_AUTHORITY;
> > =A0=A0=A0=A0=A0}
> > =A0
> > =A0=A0=A0=A0=A0trace_spapr_h_resize_hpt_commit(flags, shift);
> > -=A0=A0=A0=A0return H_HARDWARE;
> > +
> > +=A0=A0=A0=A0if (flags !=3D 0) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0return H_PARAMETER;
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0if (!pending || (pending->shift !=3D shift)) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0/* no matching prepare */
> > +=A0=A0=A0=A0=A0=A0=A0=A0return H_CLOSED;
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0if (!pending->complete) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0/* prepare has not completed */
> > +=A0=A0=A0=A0=A0=A0=A0=A0return H_BUSY;
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0newsize =3D 1ULL << pending->shift;
> > +=A0=A0=A0=A0rc =3D rehash_hpt(cpu, spapr->htab, HTAB_SIZE(spapr),
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pending->h=
pt, newsize);
> > +=A0=A0=A0=A0if (rc =3D=3D H_SUCCESS) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0CPUState *cs;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0qemu_vfree(spapr->htab);
> > +=A0=A0=A0=A0=A0=A0=A0=A0spapr->htab =3D pending->hpt;
> > +=A0=A0=A0=A0=A0=A0=A0=A0spapr->htab_shift =3D pending->shift;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0CPU_FOREACH(cs) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0run_on_cpu(cs, pivot_hpt, RUN_ON_C=
PU_HOST_PTR(spapr));
> > +=A0=A0=A0=A0=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0pending->hpt =3D NULL; /* so it's not free()d =
*/
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0/* Clean up */
> > +=A0=A0=A0=A0spapr->pending_hpt =3D NULL;
> > +=A0=A0=A0=A0free_pending_hpt(pending);
> > +
> > +=A0=A0=A0=A0return rc;
> > =A0}
> > =A0
> > =A0static target_ulong h_set_sprg0(PowerPCCPU *cpu, sPAPRMachineState
> > *spapr,
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index d2c758b..954bada 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -14,6 +14,7 @@ struct sPAPRNVRAM;
> > =A0typedef struct sPAPRConfigureConnectorState
> > sPAPRConfigureConnectorState;
> > =A0typedef struct sPAPREventLogEntry sPAPREventLogEntry;
> > =A0typedef struct sPAPREventSource sPAPREventSource;
> > +typedef struct sPAPRPendingHPT sPAPRPendingHPT;
> > =A0
> > =A0#define HPTE64_V_HPTE_DIRTY=A0=A0=A0=A0=A00x0000000000000040ULL
> > =A0#define SPAPR_ENTRY_POINT=A0=A0=A0=A0=A0=A0=A00x100
> > @@ -72,6 +73,8 @@ struct sPAPRMachineState {
> > =A0=A0=A0=A0=A0sPAPRResizeHPT resize_hpt;
> > =A0=A0=A0=A0=A0void *htab;
> > =A0=A0=A0=A0=A0uint32_t htab_shift;
> > +=A0=A0=A0=A0sPAPRPendingHPT *pending_hpt; /* in-progress resize */
> > +
> > =A0=A0=A0=A0=A0hwaddr rma_size;
> > =A0=A0=A0=A0=A0int vrma_adjust;
> > =A0=A0=A0=A0=A0ssize_t rtas_size;
> > @@ -627,6 +630,7 @@ void
> > spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType
> > drc_type,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
uint32_t count,
> > uint32_t index);
> > =A0void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0sPAPRMachineState *spapr);
> > +int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
> > =A0
> > =A0/* rtas-configure-connector state */
> > =A0struct sPAPRConfigureConnectorState {
> > @@ -674,4 +678,6 @@ int spapr_rng_populate_dt(void *fdt);
> > =A0
> > =A0void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data
> > arg);
> > =A0
> > +#define HTAB_SIZE(spapr)=A0=A0=A0=A0=A0=A0=A0=A0(1ULL << ((spapr)->hta=
b_shift))
> > +
> > =A0#endif /* HW_SPAPR_H */
> > diff --git a/target-ppc/mmu-hash64.h b/target-ppc/mmu-hash64.h
> > index ab5d347..4a1b781 100644
> > --- a/target-ppc/mmu-hash64.h
> > +++ b/target-ppc/mmu-hash64.h
> > @@ -60,11 +60,15 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
> > =A0#define HASH_PTE_SIZE_64=A0=A0=A0=A0=A0=A0=A0=A016
> > =A0#define HASH_PTEG_SIZE_64=A0=A0=A0=A0=A0=A0=A0(HASH_PTE_SIZE_64 * HP=
TES_PER_GROUP)
> > =A0
> > +#define HPTE64_V_SSIZE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0SLB_VSID_B
> > +#define HPTE64_V_SSIZE_256M=A0=A0=A0=A0=A0SLB_VSID_B_256M
> > +#define HPTE64_V_SSIZE_1T=A0=A0=A0=A0=A0=A0=A0SLB_VSID_B_1T
> > =A0#define HPTE64_V_SSIZE_SHIFT=A0=A0=A0=A062
> > =A0#define HPTE64_V_AVPN_SHIFT=A0=A0=A0=A0=A07
> > =A0#define HPTE64_V_AVPN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x3fffffffffff=
ff80ULL
> > =A0#define HPTE64_V_AVPN_VAL(x)=A0=A0=A0=A0(((x) & HPTE64_V_AVPN) >>
> > HPTE64_V_AVPN_SHIFT)
> > =A0#define HPTE64_V_COMPARE(x, y)=A0=A0(!(((x) ^ (y)) &
> > 0xffffffffffffff83ULL))
> > +#define HPTE64_V_BOLTED=A0=A0=A0=A0=A0=A0=A0=A0=A00x0000000000000010ULL
> > =A0#define HPTE64_V_LARGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x00000000000000=
04ULL
> > =A0#define HPTE64_V_SECONDARY=A0=A0=A0=A0=A0=A00x0000000000000002ULL
> > =A0#define HPTE64_V_VALID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x00000000000000=
01ULL
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--boAH8PqvUi1v1f55
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUOSYAAoJEGw4ysog2bOSQKEP/RbJqyeIxzyXtVMt0Old4nLs
UUBWrCvuCwyONdhWUqEwhpLobR7P4/zqIK2GVESTZPzkhtVyg2ZpiCEt/Ps87GGL
5S0dCg5wLdNUNPJHi87HQup6p8LONKcBEnqMPJcESGzlve7vcv0OjGkM6y5hhI5o
zuuL6DF5iZNUVWgAlnbat2s2j0cKz3cIDcn53/qThuaHhixdH1J4t/vxCXKLM2L5
dI8z/YLHDiT9mtnTtAwfYpj1+KwZirEnODKyXsBaUxLug+Auzh1NDcBf8iV7uP2T
Nm8lrc3l+RYUZabJ1sZiqrKcdd6IX3cetW9zPHWJmdbP+AyAXM6564L+ZmR60LmX
MvB9HwKB2PIo+sBgebdoD2onGO9oH2wPAfIzyqoLoEAg3F2j+ayEIq+Iq4+rY7gM
PMg3+gKSLO/FrOPan0FgMej9TiJdGpnHUq3qdaUSMYuGjD+n3zPFu77WB7G+kY91
C3P+AXpu+UFo983CAW3K5MalqUZouWfhpWzr72BDXZbjc2OC8L3LOEBJAT3fJhZE
Sfb0QjChB1Ibn2AZ8dX3ee+O5DmRZRXw5rceBd6pFaTWcuNJn2EZZ7oVtuHFPyvC
3ZqK0r7TCtOQTRydj6S+6TWbxROc1sKzAfKDcxEDwf9H+HGWZpwozpIqixG72fp+
46LqKZj4EWV9smutkmVf
=SHfR
-----END PGP SIGNATURE-----

--boAH8PqvUi1v1f55--
