Received: from eggs.gnu.org ([2001:4830:134:3::10]:48601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cHKXO-0002I6-NX
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 20:08:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cHKXL-0002ij-Fh
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 20:08:46 -0500
Date: Thu, 15 Dec 2016 12:03:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161215010359.GM32647@umbus>
References: <20161212040603.27295-1-david@gibson.dropbear.id.au>
	<20161212040603.27295-4-david@gibson.dropbear.id.au>
	<1481693756.1555.30.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BHMq0+oGliEfCAkH"
Content-Disposition: inline
In-Reply-To: <1481693756.1555.30.camel@gmail.com>
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


--BHMq0+oGliEfCAkH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2016 at 04:35:56PM +1100, Suraj Jitindar Singh wrote:
> On Mon, 2016-12-12 at 15:06 +1100, David Gibson wrote:
> > This patch implements hypercalls allowing a PAPR guest to resize its
> > own
> > hash page table.=A0=A0This will eventually allow for more flexible memo=
ry
> > hotplug.
> >=20
> > The implementation is partially asynchronous, handled in a special
> > thread
> > running the hpt_prepare_thread() function.=A0=A0The state of a pending
> > resize
> > is stored in SPAPR_MACHINE->pending_hpt.
> >=20
> > The H_RESIZE_HPT_PREPARE hypercall will kick off creation of a new
> > HPT, or,
> > if one is already in progress, monitor it for completion.=A0=A0If there
> > is an
> > existing HPT resize in progress that doesn't match the size specified
> > in
> > the call, it will cancel it, replacing it with a new one matching the
> > given size.
> >=20
> > The H_RESIZE_HPT_COMMIT completes transition to a resized HPT, and
> > can only
> > be called successfully once H_RESIZE_HPT_PREPARE has successfully
> > completed initialization of a new HPT.=A0=A0The guest must ensure that
> > there
> > are no concurrent accesses to the existing HPT while this is called
> > (this
> > effectively means stop_machine() for Linux guests).
> >=20
> > For now H_RESIZE_HPT_COMMIT goes through the whole old HPT, rehashing
> > each
> > HPTE into the new HPT.=A0=A0This can have quite high latency, but it
> > seems to
> > be of the order of typical migration downtime latencies for HPTs of
> > size
> > up to ~2GiB (which would be used in a 256GiB guest).
> >=20
> > In future we probably want to move more of the rehashing to the
> > "prepare"
> > phase, by having H_ENTER and other hcalls update both current and
> > pending HPTs.=A0=A0That's a project for another day, but should be
> > possible
> > without any changes to the guest interface.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> > =A0hw/ppc/spapr.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A04 +-
> > =A0hw/ppc/spapr_hcall.c=A0=A0=A0=A0| 345
> > +++++++++++++++++++++++++++++++++++++++++++++++-
> > =A0include/hw/ppc/spapr.h=A0=A0|=A0=A0=A06 +
> > =A0target-ppc/mmu-hash64.h |=A0=A0=A04 +
> > =A04 files changed, 353 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 846ce51..d057031 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -93,8 +93,6 @@
> > =A0
> > =A0#define PHANDLE_XICP=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x00001111
> > =A0
> > -#define HTAB_SIZE(spapr)=A0=A0=A0=A0=A0=A0=A0=A0(1ULL << ((spapr)->hta=
b_shift))
> > -
> > =A0static XICSState *try_create_xics(const char *type, int nr_servers,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0int nr_irqs, Error **errp)
> > =A0{
> > @@ -1055,7 +1053,7 @@ static void close_htab_fd(sPAPRMachineState
> > *spapr)
> > =A0=A0=A0=A0=A0spapr->htab_fd =3D -1;
> > =A0}
> > =A0
> > -static int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
> > +int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
> > =A0{
> > =A0=A0=A0=A0=A0int shift;
> > =A0
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 72a9c4d..1e89061 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -2,6 +2,7 @@
> > =A0#include "qapi/error.h"
> > =A0#include "sysemu/sysemu.h"
> > =A0#include "qemu/log.h"
> > +#include "qemu/error-report.h"
> > =A0#include "cpu.h"
> > =A0#include "exec/exec-all.h"
> > =A0#include "helper_regs.h"
> > @@ -355,20 +356,319 @@ static target_ulong h_read(PowerPCCPU *cpu,
> > sPAPRMachineState *spapr,
> > =A0=A0=A0=A0=A0return H_SUCCESS;
> > =A0}
> > =A0
> > +struct sPAPRPendingHPT {
> > +=A0=A0=A0=A0/* These fields are read-only after initialization */
> > +=A0=A0=A0=A0int shift;
> > +=A0=A0=A0=A0QemuThread thread;
> > +
> > +=A0=A0=A0=A0/* These fields are protected by the BQL */
> > +=A0=A0=A0=A0bool complete;
> > +
> > +=A0=A0=A0=A0/* These fields are private to the preparation thread if
> > +=A0=A0=A0=A0=A0* !complete, otherwise protected by the BQL */
> > +=A0=A0=A0=A0int ret;
> > +=A0=A0=A0=A0void *hpt;
> > +};
> > +
> > +static void free_pending_hpt(sPAPRPendingHPT *pending)
> > +{
> > +=A0=A0=A0=A0if (pending->hpt) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0qemu_vfree(pending->hpt);
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0g_free(pending);
> > +}
> > +
> > +static void *hpt_prepare_thread(void *opaque)
> > +{
> > +=A0=A0=A0=A0sPAPRPendingHPT *pending =3D opaque;
> > +=A0=A0=A0=A0size_t size =3D 1ULL << pending->shift;
> > +
> > +=A0=A0=A0=A0pending->hpt =3D qemu_memalign(size, size);
> > +=A0=A0=A0=A0if (pending->hpt) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0memset(pending->hpt, 0, size);
> > +=A0=A0=A0=A0=A0=A0=A0=A0pending->ret =3D H_SUCCESS;
> > +=A0=A0=A0=A0} else {
> > +=A0=A0=A0=A0=A0=A0=A0=A0pending->ret =3D H_NO_MEM;
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0qemu_mutex_lock_iothread();
> > +
> > +=A0=A0=A0=A0if (SPAPR_MACHINE(qdev_get_machine())->pending_hpt =3D=3D =
pending) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0/* Ready to go */
> > +=A0=A0=A0=A0=A0=A0=A0=A0pending->complete =3D true;
> > +=A0=A0=A0=A0} else {
> > +=A0=A0=A0=A0=A0=A0=A0=A0/* We've been cancelled, clean ourselves up */
> > +=A0=A0=A0=A0=A0=A0=A0=A0free_pending_hpt(pending);
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0qemu_mutex_unlock_iothread();
> > +=A0=A0=A0=A0return NULL;
> > +}
> > +
> > +/* Must be called with BQL held */
> > +static void cancel_hpt_prepare(sPAPRMachineState *spapr)
> > +{
> > +=A0=A0=A0=A0sPAPRPendingHPT *pending =3D spapr->pending_hpt;
> > +
> > +=A0=A0=A0=A0/* Let the thread know it's cancelled */
> > +=A0=A0=A0=A0spapr->pending_hpt =3D NULL;
> > +
> > +=A0=A0=A0=A0if (!pending) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0/* Nothing to do */
> > +=A0=A0=A0=A0=A0=A0=A0=A0return;
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0if (!pending->complete) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0/* thread will clean itself up */
> > +=A0=A0=A0=A0=A0=A0=A0=A0return;
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0free_pending_hpt(pending);
> > +}
> > +
> > +static int build_dimm_list(Object *obj, void *opaque)
> > +{
> > +=A0=A0=A0=A0GSList **list =3D opaque;
> > +
> > +=A0=A0=A0=A0if (object_dynamic_cast(obj, TYPE_PC_DIMM)) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0DeviceState *dev =3D DEVICE(obj);
> > +=A0=A0=A0=A0=A0=A0=A0=A0if (dev->realized) { /* only realized DIMMs ma=
tter */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*list =3D g_slist_prepend(*list, d=
ev);
> > +=A0=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0object_child_foreach(obj, build_dimm_list, opaque);
> > +=A0=A0=A0=A0return 0;
> > +}
> > +
> > +static ram_addr_t get_current_ram_size(void)
> > +{
> > +=A0=A0=A0=A0GSList *list =3D NULL, *item;
> > +=A0=A0=A0=A0ram_addr_t size =3D ram_size;
> > +
> > +=A0=A0=A0=A0build_dimm_list(qdev_get_machine(), &list);
> > +=A0=A0=A0=A0for (item =3D list; item; item =3D g_slist_next(item)) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0Object *obj =3D OBJECT(item->data);
> > +=A0=A0=A0=A0=A0=A0=A0=A0if (!strcmp(object_get_typename(obj), TYPE_PC_=
DIMM)) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0size +=3D object_property_get_int(=
obj, PC_DIMM_SIZE_PROP,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0&error_abort=
);
> > +=A0=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0}
> > +=A0=A0=A0=A0g_slist_free(list);
> > +
> > +=A0=A0=A0=A0return size;
> > +}
> > +
> > =A0static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0sPAPRMachineState =
*spapr,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0target_ulong opcod=
e,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0target_ulong *args)
> > =A0{
> > =A0=A0=A0=A0=A0target_ulong flags =3D args[0];
> > -=A0=A0=A0=A0target_ulong shift =3D args[1];
> > +=A0=A0=A0=A0int shift =3D args[1];
> > +=A0=A0=A0=A0sPAPRPendingHPT *pending =3D spapr->pending_hpt;
> > =A0
> > =A0=A0=A0=A0=A0if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DISABLED) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0return H_AUTHORITY;
> > =A0=A0=A0=A0=A0}
> > =A0
> > =A0=A0=A0=A0=A0trace_spapr_h_resize_hpt_prepare(flags, shift);
> > -=A0=A0=A0=A0return H_HARDWARE;
> > +
> > +=A0=A0=A0=A0if (flags !=3D 0) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0return H_PARAMETER;
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0if (shift && ((shift < 18) || (shift > 46))) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0return H_PARAMETER;
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0if (pending) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0/* something already in progress */
> > +=A0=A0=A0=A0=A0=A0=A0=A0if (pending->shift =3D=3D shift) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* and it's suitable */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (pending->complete) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return pending->ret;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return H_LONG_BUSY_ORD=
ER_100_MSEC;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0/* not suitable, cancel and replace */
> > +=A0=A0=A0=A0=A0=A0=A0=A0cancel_hpt_prepare(spapr);
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0if (!shift) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0/* nothing to do */
> > +=A0=A0=A0=A0=A0=A0=A0=A0return H_SUCCESS;
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0/* start new prepare */
> > +
> > +=A0=A0=A0=A0/* We only allow the guest to allocate an HPT one order ab=
ove
> > what
> > +=A0=A0=A0=A0=A0* we'd normally give them (to stop a small guest claimi=
ng a
> > huge
> > +=A0=A0=A0=A0=A0* chunk of resources in the HPT */
> > +=A0=A0=A0=A0if (shift > (spapr_hpt_shift_for_ramsize(get_current_ram_s=
ize())
> > + 1))
> Given we already allocate one lower than recommended in the ISA by
> default, should we set this to 2 to allow an allocation of 1 greater
> than the recommended minimum?

No, I think capping it at the ISA recommended size should be ok.  It's
physically contiguous memory in the host, which means it's a pretty
scarce resource.  If this is really a problem in practice we can
revisit it.

> > +=A0=A0=A0=A0=A0=A0=A0=A0return H_RESOURCE;
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0pending =3D g_new0(sPAPRPendingHPT, 1);
> > +=A0=A0=A0=A0pending->shift =3D shift;
> > +=A0=A0=A0=A0pending->ret =3D H_HARDWARE;
> > +
> > +=A0=A0=A0=A0qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0h=
pt_prepare_thread, pending,
> > QEMU_THREAD_DETACHED);
> > +
> > +=A0=A0=A0=A0spapr->pending_hpt =3D pending;
> > +
> > +=A0=A0=A0=A0/* In theory we could estimate the time more accurately ba=
sed on
> > +=A0=A0=A0=A0=A0* the new size, but there's not much point */
> > +=A0=A0=A0=A0return H_LONG_BUSY_ORDER_100_MSEC;
> > +}
> > +
> > +static uint64_t new_hpte_load0(void *htab, uint64_t pteg, int slot)
> > +{
> > +=A0=A0=A0=A0uint8_t *addr =3D htab;
> > +
> > +=A0=A0=A0=A0addr +=3D pteg * HASH_PTEG_SIZE_64;
> > +=A0=A0=A0=A0addr +=3D slot * HASH_PTE_SIZE_64;
> > +=A0=A0=A0=A0return=A0=A0ldq_p(addr);
> > +}
> > +
> > +static void new_hpte_store(void *htab, uint64_t pteg, int slot,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0uint64_t pte0, uint64_t pte1)
> > +{
> > +=A0=A0=A0=A0uint8_t *addr =3D htab;
> > +
> > +=A0=A0=A0=A0addr +=3D pteg * HASH_PTEG_SIZE_64;
> > +=A0=A0=A0=A0addr +=3D slot * HASH_PTE_SIZE_64;
> > +
> > +=A0=A0=A0=A0stq_p(addr, pte0);
> > +=A0=A0=A0=A0stq_p(addr + HASH_PTE_SIZE_64/2, pte1);
> > +}
> > +
> > +static int rehash_hpte(PowerPCCPU *cpu, uint64_t token,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0v=
oid *old, uint64_t oldsize,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0v=
oid *new, uint64_t newsize,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0u=
int64_t pteg, int slot)
> > +{
> > +=A0=A0=A0=A0uint64_t old_hash_mask =3D (oldsize >> 7) - 1;
> > +=A0=A0=A0=A0uint64_t new_hash_mask =3D (newsize >> 7) - 1;
> > +=A0=A0=A0=A0target_ulong pte0 =3D ppc_hash64_load_hpte0(cpu, token, sl=
ot);
> > +=A0=A0=A0=A0target_ulong pte1;
> > +=A0=A0=A0=A0uint64_t avpn;
> > +=A0=A0=A0=A0unsigned shift;
> > +=A0=A0=A0=A0uint64_t hash, new_pteg, replace_pte0;
> > +
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
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (pte0 & HPTE64_V_BOLTED) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Bolted collision, n=
othing we can do */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return H_PTEG_FULL;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Discard this hpte */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return H_SUCCESS;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0=A0}
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

--BHMq0+oGliEfCAkH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUev/AAoJEGw4ysog2bOSvlkP/2J77n7SE43jaUR5lwpzZmss
S7U74yV03ZwwkJ+B5sonn0y2exIusRXd0Lm4a+3md+eE5mk8QgXKxwCsxEFkJJ38
AxgGOqvj1x5Lb+GSdmpAXCqSPp73Ix3E7t9G7odC5eaL9JcMO/5XBIgAhhyyXWEz
SzPbVnJFltEYw01xBhruIAGz1V8zZhyzSChcBGMPzIYCFY02THEqcWr4VnLWyUEX
UxGI8z9k92qNOn7uMw0rv+wPd6SS98kiKt+svihvAJlhnJKmSREnFoSAmXgFiAJP
gqXhww+evIDIBhYrIS7G+NXundIs6T0hOqCNCDcNKK6lTwEFvMqq0UzaOoM7yTH6
NFRw4rjDdBw1P+NAXhuTGkTv3VopdxRTm8s8HAXujdeYDq2fBoV8qnehXSYwhOOn
9pS2XZdfmmVryAwnQzMoYlS/tPmazl7irCCidrcZ8TvHCjkSe/ryws3Yr1rlNEAW
AhbwZhxo3wqK6al1zG6q0L+XUqtYFa5aLwpp7mMGHAfOeaQRUfFu/nB3sG+YC+OW
vuOOOdt7xC8At+cglFKakR7UeH2S+IdeMed3uCwEAQ2Z8gh+/zIdqkMDJWs6FSry
tU68hkRN1upeW0rLcwCQfjTJNhY840aq6S+NIpkQof/WGhLt2+cjltUf6g2733wg
3t2Oyy1K0y2oem5WPc3P
=KDTI
-----END PGP SIGNATURE-----

--BHMq0+oGliEfCAkH--
