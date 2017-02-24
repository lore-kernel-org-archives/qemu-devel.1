Received: from eggs.gnu.org ([2001:4830:134:3::10]:40159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1chBHx-0000p2-Uo
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 03:31:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1chBHu-0000QD-Lq
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 03:31:41 -0500
Date: Fri, 24 Feb 2017 16:25:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170224052504.GB17615@umbus.fritz.box>
References: <20170223020936.29220-1-david@gibson.dropbear.id.au>
	<20170223020936.29220-5-david@gibson.dropbear.id.au>
	<1487828220.23895.17.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rsGyAQ90QqnfMsmV"
Content-Disposition: inline
In-Reply-To: <1487828220.23895.17.camel@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 4/6] target/ppc: Cleanup HPTE accessors for
 64-bit hash MMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, aik@ozlabs.ru, qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, paulus@samba.org


--rsGyAQ90QqnfMsmV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 04:37:00PM +1100, Suraj Jitindar Singh wrote:
> On Thu, 2017-02-23 at 13:09 +1100, David Gibson wrote:
> > Accesses to the hashed page table (HPT) are complicated by the fact
> > that
> > the HPT could be in one of three places:
> > =A0=A0=A01) Within guest memory - when we're emulating a full guest CPU=
 at
> > the
> > =A0=A0=A0=A0=A0=A0hardware level (e.g. powernv, mac99, g3beige)
> > =A0=A0=A02) Within qemu, but outside guest memory - when we're emulating
> > user and
> > =A0=A0=A0=A0=A0=A0supervisor instructions within TCG, but instead of em=
ulating
> > =A0=A0=A0=A0=A0=A0the CPU's hypervisor mode, we just emulate a hypervis=
or's
> > behaviour
> > =A0=A0=A0=A0=A0=A0(pseries in TCG)
> > =A0=A0=A03) Within KVM - a pseries machine using KVM acceleration.=A0=
=A0Mostly
> > =A0=A0=A0=A0=A0=A0accesses to the HPT are handled by KVM, but there are=
 a few
> > cases
> > =A0=A0=A0=A0=A0=A0where qemu needs to access it via a special fd for th=
e purpose.
>=20
> Should you clarify that this is the case for KVM-HV with KVM-PR the
> same as (2)?

Ah, good idea.

>=20
> >=20
> > In order to batch accesses to the fd in case (3), we use a somewhat
> > awkward
> > ppc_hash64_start_access() / ppc_hash64_stop_access() pair, which for
> > case
> > (3) reads / releases a whole PTEG from the kernel.=A0=A0For cases (1) &
> > (2)
> > it just returns an address value.=A0=A0The actual HPTE load helpers then
> > need
> > to interpret the returned token differently in the 3 cases.
> >=20
> > This patch keeps the same basic structure, but simplfiies the
> > details.
> > First start_access() / stop_access() are renamed to get_pteg() and
> > put_pteg() to make their operation more obvious.=A0=A0Second, read_pteg=
()
>=20
> Here you say they've been renamed to get/put/read_pteg, but in the code
> they're called map/unmap_hptes and it looks like map_hptes does both
> the get and the read?

Oops, I'll update.

>=20
> > now
> > always returns a qemu pointer, which can always be used in the same
> > way
> > by the load_hpte() helpers.=A0=A0In case (1) it comes from
> > address_space_map()
> > in case (2) directly from qemu's HPT buffer and in case (3) from a
> > temporary buffer read from the KVM fd.
> >=20
> > While we're at it, make things a bit more consistent in terms of
> > types and
> > variable names: avoid variables named 'index' (it shadows index(3)
> > which
> > can lead to confusing results), use 'hwaddr ptex' for HPTE indices
> > and
> > uint64_t for each of the HPTE words, use ptex throughout the call
> > stack
> > instead of pte_offset in some places (we still need that at the
> > bottom
> > layer, but nowhere else).
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Other than the commit message:
>=20
> Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>=20
> > ---
> > =A0hw/ppc/spapr_hcall.c=A0=A0=A0=A0| 36 +++++++++---------
> > =A0target/ppc/cpu.h=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A03 +-
> > =A0target/ppc/kvm.c=A0=A0=A0=A0=A0=A0=A0=A0| 25 ++++++-------
> > =A0target/ppc/kvm_ppc.h=A0=A0=A0=A0| 43 ++++++++++------------
> > =A0target/ppc/mmu-hash64.c | 98 ++++++++++++++++++++++++++-------------
> > ----------
> > =A0target/ppc/mmu-hash64.h | 46 ++++++++---------------
> > =A06 files changed, 119 insertions(+), 132 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 3298a14..fd961b5 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -84,7 +84,7 @@ static target_ulong h_enter(PowerPCCPU *cpu,
> > sPAPRMachineState *spapr,
> > =A0=A0=A0=A0=A0unsigned apshift;
> > =A0=A0=A0=A0=A0target_ulong raddr;
> > =A0=A0=A0=A0=A0target_ulong slot;
> > -=A0=A0=A0=A0uint64_t token;
> > +=A0=A0=A0=A0const ppc_hash_pte64_t *hptes;
> > =A0
> > =A0=A0=A0=A0=A0apshift =3D ppc_hash64_hpte_page_shift_noslb(cpu, pteh, =
ptel);
> > =A0=A0=A0=A0=A0if (!apshift) {
> > @@ -123,23 +123,23 @@ static target_ulong h_enter(PowerPCCPU *cpu,
> > sPAPRMachineState *spapr,
> > =A0=A0=A0=A0=A0ptex =3D ptex & ~7ULL;
> > =A0
> > =A0=A0=A0=A0=A0if (likely((flags & H_EXACT) =3D=3D 0)) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0token =3D ppc_hash64_start_access(cpu, ptex);
> > +=A0=A0=A0=A0=A0=A0=A0=A0hptes =3D ppc_hash64_map_hptes(cpu, ptex, HPTE=
S_PER_GROUP);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0for (slot =3D 0; slot < 8; slot++) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!(ppc_hash64_load_hpte0(cpu, t=
oken, slot) &
> > HPTE64_V_VALID)) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!(ppc_hash64_hpte0(cpu, hptes,=
 slot) &
> > HPTE64_V_VALID)) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > -=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_stop_access(cpu, token);
> > +=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_unmap_hptes(cpu, hptes, ptex, HPTES=
_PER_GROUP);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0if (slot =3D=3D 8) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return H_PTEG_FULL;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0} else {
> > -=A0=A0=A0=A0=A0=A0=A0=A0token =3D ppc_hash64_start_access(cpu, ptex);
> > -=A0=A0=A0=A0=A0=A0=A0=A0if (ppc_hash64_load_hpte0(cpu, token, 0) & HPT=
E64_V_VALID) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_stop_access(cpu, token);
> > +=A0=A0=A0=A0=A0=A0=A0=A0hptes =3D ppc_hash64_map_hptes(cpu, ptex + slo=
t, 1);
> > +=A0=A0=A0=A0=A0=A0=A0=A0if (ppc_hash64_hpte0(cpu, hptes, 0) & HPTE64_V=
_VALID) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_unmap_hptes(cpu, hptes,=
 ptex + slot, 1);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return H_PTEG_FULL;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > -=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_stop_access(cpu, token);
> > +=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_unmap_hptes(cpu, hptes, ptex, 1);
> > =A0=A0=A0=A0=A0}
> > =A0
> > =A0=A0=A0=A0=A0ppc_hash64_store_hpte(cpu, ptex + slot, pteh |
> > HPTE64_V_HPTE_DIRTY, ptel);
> > @@ -160,17 +160,17 @@ static RemoveResult remove_hpte(PowerPCCPU
> > *cpu, target_ulong ptex,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0target_ulong flags,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0target_ulong *vp, target_ulong *rp)
> > =A0{
> > -=A0=A0=A0=A0uint64_t token;
> > +=A0=A0=A0=A0const ppc_hash_pte64_t *hptes;
> > =A0=A0=A0=A0=A0target_ulong v, r;
> > =A0
> > =A0=A0=A0=A0=A0if (!valid_ptex(cpu, ptex)) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0return REMOVE_PARM;
> > =A0=A0=A0=A0=A0}
> > =A0
> > -=A0=A0=A0=A0token =3D ppc_hash64_start_access(cpu, ptex);
> > -=A0=A0=A0=A0v =3D ppc_hash64_load_hpte0(cpu, token, 0);
> > -=A0=A0=A0=A0r =3D ppc_hash64_load_hpte1(cpu, token, 0);
> > -=A0=A0=A0=A0ppc_hash64_stop_access(cpu, token);
> > +=A0=A0=A0=A0hptes =3D ppc_hash64_map_hptes(cpu, ptex, 1);
> > +=A0=A0=A0=A0v =3D ppc_hash64_hpte0(cpu, hptes, 0);
> > +=A0=A0=A0=A0r =3D ppc_hash64_hpte1(cpu, hptes, 0);
> > +=A0=A0=A0=A0ppc_hash64_unmap_hptes(cpu, hptes, ptex, 1);
> > =A0
> > =A0=A0=A0=A0=A0if ((v & HPTE64_V_VALID) =3D=3D 0 ||
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0((flags & H_AVPN) && (v & ~0x7fULL) !=3D avp=
n) ||
> > @@ -291,17 +291,17 @@ static target_ulong h_protect(PowerPCCPU *cpu,
> > sPAPRMachineState *spapr,
> > =A0=A0=A0=A0=A0target_ulong flags =3D args[0];
> > =A0=A0=A0=A0=A0target_ulong ptex =3D args[1];
> > =A0=A0=A0=A0=A0target_ulong avpn =3D args[2];
> > -=A0=A0=A0=A0uint64_t token;
> > +=A0=A0=A0=A0const ppc_hash_pte64_t *hptes;
> > =A0=A0=A0=A0=A0target_ulong v, r;
> > =A0
> > =A0=A0=A0=A0=A0if (!valid_ptex(cpu, ptex)) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0return H_PARAMETER;
> > =A0=A0=A0=A0=A0}
> > =A0
> > -=A0=A0=A0=A0token =3D ppc_hash64_start_access(cpu, ptex);
> > -=A0=A0=A0=A0v =3D ppc_hash64_load_hpte0(cpu, token, 0);
> > -=A0=A0=A0=A0r =3D ppc_hash64_load_hpte1(cpu, token, 0);
> > -=A0=A0=A0=A0ppc_hash64_stop_access(cpu, token);
> > +=A0=A0=A0=A0hptes =3D ppc_hash64_map_hptes(cpu, ptex, 1);
> > +=A0=A0=A0=A0v =3D ppc_hash64_hpte0(cpu, hptes, 0);
> > +=A0=A0=A0=A0r =3D ppc_hash64_hpte1(cpu, hptes, 0);
> > +=A0=A0=A0=A0ppc_hash64_unmap_hptes(cpu, hptes, ptex, 1);
> > =A0
> > =A0=A0=A0=A0=A0if ((v & HPTE64_V_VALID) =3D=3D 0 ||
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0((flags & H_AVPN) && (v & ~0x7fULL) !=3D avp=
n)) {
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index f99bcae..c89973e 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -223,11 +223,12 @@ enum {
> > =A0typedef struct opc_handler_t opc_handler_t;
> > =A0
> > =A0/*******************************************************************
> > **********/
> > -/* Types used to describe some PowerPC registers */
> > +/* Types used to describe some PowerPC registers etc. */
> > =A0typedef struct DisasContext DisasContext;
> > =A0typedef struct ppc_spr_t ppc_spr_t;
> > =A0typedef union ppc_avr_t ppc_avr_t;
> > =A0typedef union ppc_tlb_t ppc_tlb_t;
> > +typedef struct ppc_hash_pte64 ppc_hash_pte64_t;
> > =A0
> > =A0/* SPR access micro-ops generations callbacks */
> > =A0struct ppc_spr_t {
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 52bbea5..9d3e57e 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2601,17 +2601,17 @@ struct kvm_get_htab_buf {
> > =A0=A0=A0=A0=A0/*
> > =A0=A0=A0=A0=A0=A0* We require one extra byte for read
> > =A0=A0=A0=A0=A0=A0*/
> > -=A0=A0=A0=A0target_ulong hpte[(HPTES_PER_GROUP * 2) + 1];
> > +=A0=A0=A0=A0ppc_hash_pte64_t hpte[HPTES_PER_GROUP];
> > =A0};
> > =A0
> > -uint64_t kvmppc_hash64_read_pteg(PowerPCCPU *cpu, target_ulong
> > pte_index)
> > +const ppc_hash_pte64_t *kvmppc_map_hptes(hwaddr ptex, int n)
> > =A0{
> > =A0=A0=A0=A0=A0int htab_fd;
> > =A0=A0=A0=A0=A0struct kvm_get_htab_fd ghf;
> > -=A0=A0=A0=A0struct kvm_get_htab_buf=A0=A0*hpte_buf;
> > +=A0=A0=A0=A0struct kvm_get_htab_buf *hpte_buf;
> > =A0
> > =A0=A0=A0=A0=A0ghf.flags =3D 0;
> > -=A0=A0=A0=A0ghf.start_index =3D pte_index;
> > +=A0=A0=A0=A0ghf.start_index =3D ptex;
> > =A0=A0=A0=A0=A0htab_fd =3D kvm_vm_ioctl(kvm_state, KVM_PPC_GET_HTAB_FD,=
 &ghf);
> > =A0=A0=A0=A0=A0if (htab_fd < 0) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0goto error_out;
> > @@ -2626,7 +2626,7 @@ uint64_t kvmppc_hash64_read_pteg(PowerPCCPU
> > *cpu, target_ulong pte_index)
> > =A0=A0=A0=A0=A0}
> > =A0
> > =A0=A0=A0=A0=A0close(htab_fd);
> > -=A0=A0=A0=A0return (uint64_t)(uintptr_t) hpte_buf->hpte;
> > +=A0=A0=A0=A0return hpte_buf->hpte;
> > =A0
> > =A0out_close:
> > =A0=A0=A0=A0=A0g_free(hpte_buf);
> > @@ -2635,18 +2635,15 @@ error_out:
> > =A0=A0=A0=A0=A0return 0;
> > =A0}
> > =A0
> > -void kvmppc_hash64_free_pteg(uint64_t token)
> > +void kvmppc_unmap_hptes(const ppc_hash_pte64_t *hptes, hwaddr ptex,
> > int n)
> > =A0{
> > =A0=A0=A0=A0=A0struct kvm_get_htab_buf *htab_buf;
> > =A0
> > -=A0=A0=A0=A0htab_buf =3D container_of((void *)(uintptr_t) token, struct
> > kvm_get_htab_buf,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0hpte);
> > +=A0=A0=A0=A0htab_buf =3D container_of((void *)hptes, struct kvm_get_ht=
ab_buf,
> > hpte);
> > =A0=A0=A0=A0=A0g_free(htab_buf);
> > -=A0=A0=A0=A0return;
> > =A0}
> > =A0
> > -void kvmppc_hash64_write_pte(CPUPPCState *env, target_ulong
> > pte_index,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0target_ulong pte0, target_ulong pte1)
> > +void kvmppc_hash64_write_pte(hwaddr ptex, uint64_t pte0, uint64_t
> > pte1)
> > =A0{
> > =A0=A0=A0=A0=A0int htab_fd;
> > =A0=A0=A0=A0=A0struct kvm_get_htab_fd ghf;
> > @@ -2661,9 +2658,9 @@ void kvmppc_hash64_write_pte(CPUPPCState *env,
> > target_ulong pte_index,
> > =A0
> > =A0=A0=A0=A0=A0hpte_buf.header.n_valid =3D 1;
> > =A0=A0=A0=A0=A0hpte_buf.header.n_invalid =3D 0;
> > -=A0=A0=A0=A0hpte_buf.header.index =3D pte_index;
> > -=A0=A0=A0=A0hpte_buf.hpte[0] =3D pte0;
> > -=A0=A0=A0=A0hpte_buf.hpte[1] =3D pte1;
> > +=A0=A0=A0=A0hpte_buf.header.index =3D ptex;
> > +=A0=A0=A0=A0hpte_buf.hpte[0].pte0 =3D pte0;
> > +=A0=A0=A0=A0hpte_buf.hpte[0].pte1 =3D pte1;
> > =A0=A0=A0=A0=A0/*
> > =A0=A0=A0=A0=A0=A0* Write the hpte entry.
> > =A0=A0=A0=A0=A0=A0* CAUTION: write() has the warn_unused_result attribu=
te. Hence
> > we
> > diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> > index 8da2ee4..3f8fccd 100644
> > --- a/target/ppc/kvm_ppc.h
> > +++ b/target/ppc/kvm_ppc.h
> > @@ -41,6 +41,10 @@ void *kvmppc_create_spapr_tce(uint32_t liobn,
> > uint32_t window_size, int *pfd,
> > =A0int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t
> > window_size);
> > =A0int kvmppc_reset_htab(int shift_hint);
> > =A0uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int
> > hash_shift);
> > +const ppc_hash_pte64_t *kvmppc_map_hptes(hwaddr ptex, int n);
> > +void kvmppc_unmap_hptes(const ppc_hash_pte64_t *hptes, hwaddr ptex,
> > int n);
> > +
> > +void kvmppc_hash64_write_pte(hwaddr ptex, uint64_t pte0, uint64_t
> > pte1);
> > =A0#endif /* !CONFIG_USER_ONLY */
> > =A0bool kvmppc_has_cap_epr(void);
> > =A0int kvmppc_define_rtas_kernel_token(uint32_t token, const char
> > *function);
> > @@ -49,11 +53,6 @@ int kvmppc_get_htab_fd(bool write);
> > =A0int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t
> > max_ns);
> > =A0int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0uint16_t n_valid, uint16_t n_invalid);
> > -uint64_t kvmppc_hash64_read_pteg(PowerPCCPU *cpu, target_ulong
> > pte_index);
> > -void kvmppc_hash64_free_pteg(uint64_t token);
> > -
> > -void kvmppc_hash64_write_pte(CPUPPCState *env, target_ulong
> > pte_index,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0target_ulong pte0, target_ulong pte1);
> > =A0bool kvmppc_has_cap_fixup_hcalls(void);
> > =A0bool kvmppc_has_cap_htm(void);
> > =A0int kvmppc_enable_hwrng(void);
> > @@ -199,6 +198,22 @@ static inline bool
> > kvmppc_is_mem_backend_page_size_ok(char *obj_path)
> > =A0=A0=A0=A0=A0return true;
> > =A0}
> > =A0
> > +static inline const ppc_hash_pte64_t *kvmppc_map_hptes(hwaddr ptex,
> > int n)
> > +{
> > +=A0=A0=A0=A0abort();
> > +}
> > +
> > +static inline void kvmppc_unmap_hptes(const ppc_hash_pte64_t *hptes,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0hwaddr ptex, int n)
> > +{
> > +=A0=A0=A0=A0abort();
> > +}
> > +
> > +static inline void kvmppc_hash64_write_pte(hwaddr ptex,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0uint64_t pte0, =
uint64_t
> > pte1)
> > +{
> > +=A0=A0=A0=A0abort();
> > +}
> > =A0#endif /* !CONFIG_USER_ONLY */
> > =A0
> > =A0static inline bool kvmppc_has_cap_epr(void)
> > @@ -234,24 +249,6 @@ static inline int
> > kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
> > =A0=A0=A0=A0=A0abort();
> > =A0}
> > =A0
> > -static inline uint64_t kvmppc_hash64_read_pteg(PowerPCCPU *cpu,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0tar=
get_ulong
> > pte_index)
> > -{
> > -=A0=A0=A0=A0abort();
> > -}
> > -
> > -static inline void kvmppc_hash64_free_pteg(uint64_t token)
> > -{
> > -=A0=A0=A0=A0abort();
> > -}
> > -
> > -static inline void kvmppc_hash64_write_pte(CPUPPCState *env,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0target_ulong pt=
e_index,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0target_ulong pt=
e0,
> > target_ulong pte1)
> > -{
> > -=A0=A0=A0=A0abort();
> > -}
> > -
> > =A0static inline bool kvmppc_has_cap_fixup_hcalls(void)
> > =A0{
> > =A0=A0=A0=A0=A0abort();
> > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > index 76669ed..c59db47 100644
> > --- a/target/ppc/mmu-hash64.c
> > +++ b/target/ppc/mmu-hash64.c
> > @@ -27,6 +27,7 @@
> > =A0#include "kvm_ppc.h"
> > =A0#include "mmu-hash64.h"
> > =A0#include "exec/log.h"
> > +#include "hw/hw.h"
> > =A0
> > =A0//#define DEBUG_SLB
> > =A0
> > @@ -431,33 +432,42 @@ static int ppc_hash64_amr_prot(PowerPCCPU *cpu,
> > ppc_hash_pte64_t pte)
> > =A0=A0=A0=A0=A0return prot;
> > =A0}
> > =A0
> > -uint64_t ppc_hash64_start_access(PowerPCCPU *cpu, target_ulong
> > pte_index)
> > +const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0hwaddr pt=
ex, int n)
> > =A0{
> > -=A0=A0=A0=A0uint64_t token =3D 0;
> > -=A0=A0=A0=A0hwaddr pte_offset;
> > +=A0=A0=A0=A0const ppc_hash_pte64_t *hptes =3D NULL;
> > +=A0=A0=A0=A0hwaddr pte_offset =3D ptex * HASH_PTE_SIZE_64;
> > =A0
> > -=A0=A0=A0=A0pte_offset =3D pte_index * HASH_PTE_SIZE_64;
> > =A0=A0=A0=A0=A0if (cpu->env.external_htab =3D=3D MMU_HASH64_KVM_MANAGED=
_HPT) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0/*
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0* HTAB is controlled by KVM. Fetch the PT=
EG into a new
> > buffer.
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*/
> > -=A0=A0=A0=A0=A0=A0=A0=A0token =3D kvmppc_hash64_read_pteg(cpu, pte_ind=
ex);
> > +=A0=A0=A0=A0=A0=A0=A0=A0hptes =3D kvmppc_map_hptes(ptex, n);
> > =A0=A0=A0=A0=A0} else if (cpu->env.external_htab) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0/*
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0* HTAB is controlled by QEMU. Just point =
to the internally
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0* accessible PTEG.
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*/
> > -=A0=A0=A0=A0=A0=A0=A0=A0token =3D (uint64_t)(uintptr_t) cpu->env.exter=
nal_htab +
> > pte_offset;
> > +=A0=A0=A0=A0=A0=A0=A0=A0hptes =3D (ppc_hash_pte64_t *)(cpu->env.extern=
al_htab +
> > pte_offset);
> > =A0=A0=A0=A0=A0} else if (cpu->env.htab_base) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0token =3D cpu->env.htab_base + pte_offset;
> > +=A0=A0=A0=A0=A0=A0=A0=A0hwaddr plen =3D n * HASH_PTE_SIZE_64;
> > +=A0=A0=A0=A0=A0=A0=A0=A0hptes =3D address_space_map(CPU(cpu)->as, cpu-=
>env.htab_base +
> > pte_offset,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0&plen, false);
> > +=A0=A0=A0=A0=A0=A0=A0=A0if (plen < (n * HASH_PTE_SIZE_64)) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0hw_error("%s: Unable to map all re=
quested HPTEs\n",
> > __FUNCTION__);
> > +=A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0}
> > -=A0=A0=A0=A0return token;
> > +=A0=A0=A0=A0return hptes;
> > =A0}
> > =A0
> > -void ppc_hash64_stop_access(PowerPCCPU *cpu, uint64_t token)
> > +void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const ppc_hash_pte64_t
> > *hptes,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0hwaddr ptex, int n)
> > =A0{
> > =A0=A0=A0=A0=A0if (cpu->env.external_htab =3D=3D MMU_HASH64_KVM_MANAGED=
_HPT) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0kvmppc_hash64_free_pteg(token);
> > +=A0=A0=A0=A0=A0=A0=A0=A0kvmppc_unmap_hptes(hptes, ptex, n);
> > +=A0=A0=A0=A0} else if (!cpu->env.external_htab) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0address_space_unmap(CPU(cpu)->as, (void *)hpte=
s, n *
> > HASH_PTE_SIZE_64,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0false, n * HASH_PTE_SIZE_64);
> > =A0=A0=A0=A0=A0}
> > =A0}
> > =A0
> > @@ -505,18 +515,18 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU
> > *cpu, hwaddr hash,
> > =A0{
> > =A0=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > =A0=A0=A0=A0=A0int i;
> > -=A0=A0=A0=A0uint64_t token;
> > +=A0=A0=A0=A0const ppc_hash_pte64_t *pteg;
> > =A0=A0=A0=A0=A0target_ulong pte0, pte1;
> > -=A0=A0=A0=A0target_ulong pte_index;
> > +=A0=A0=A0=A0target_ulong ptex;
> > =A0
> > -=A0=A0=A0=A0pte_index =3D (hash & env->htab_mask) * HPTES_PER_GROUP;
> > -=A0=A0=A0=A0token =3D ppc_hash64_start_access(cpu, pte_index);
> > -=A0=A0=A0=A0if (!token) {
> > +=A0=A0=A0=A0ptex =3D (hash & env->htab_mask) * HPTES_PER_GROUP;
> > +=A0=A0=A0=A0pteg =3D ppc_hash64_map_hptes(cpu, ptex, HPTES_PER_GROUP);
> > +=A0=A0=A0=A0if (!pteg) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0return -1;
> > =A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0for (i =3D 0; i < HPTES_PER_GROUP; i++) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0pte0 =3D ppc_hash64_load_hpte0(cpu, token, i);
> > -=A0=A0=A0=A0=A0=A0=A0=A0pte1 =3D ppc_hash64_load_hpte1(cpu, token, i);
> > +=A0=A0=A0=A0=A0=A0=A0=A0pte0 =3D ppc_hash64_hpte0(cpu, pteg, i);
> > +=A0=A0=A0=A0=A0=A0=A0=A0pte1 =3D ppc_hash64_hpte1(cpu, pteg, i);
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0/* This compares V, B, H (secondary) and the=
 AVPN */
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0if (HPTE64_V_COMPARE(pte0, ptem)) {
> > @@ -536,11 +546,11 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU
> > *cpu, hwaddr hash,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*/
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pte->pte0 =3D pte0;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pte->pte1 =3D pte1;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_stop_access(cpu, token);
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return (pte_index + i) * HASH_PTE_=
SIZE_64;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_unmap_hptes(cpu, pteg, =
ptex,
> > HPTES_PER_GROUP);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ptex + i;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0}
> > -=A0=A0=A0=A0ppc_hash64_stop_access(cpu, token);
> > +=A0=A0=A0=A0ppc_hash64_unmap_hptes(cpu, pteg, ptex, HPTES_PER_GROUP);
> > =A0=A0=A0=A0=A0/*
> > =A0=A0=A0=A0=A0=A0* We didn't find a valid entry.
> > =A0=A0=A0=A0=A0=A0*/
> > @@ -552,8 +562,7 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU
> > *cpu,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash_pte64_t *pte, unsigned
> > *pshift)
> > =A0{
> > =A0=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > -=A0=A0=A0=A0hwaddr pte_offset;
> > -=A0=A0=A0=A0hwaddr hash;
> > +=A0=A0=A0=A0hwaddr hash, ptex;
> > =A0=A0=A0=A0=A0uint64_t vsid, epnmask, epn, ptem;
> > =A0=A0=A0=A0=A0const struct ppc_one_seg_page_size *sps =3D slb->sps;
> > =A0
> > @@ -596,9 +605,9 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU
> > *cpu,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" vsid=3D" TARGET_FMT_lx " ptem=
=3D" TARGET_FMT_lx
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" hash=3D" TARGET_FMT_plx "\n",
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->htab_base, env->htab_mask, =
vsid, ptem,=A0=A0hash);
> > -=A0=A0=A0=A0pte_offset =3D ppc_hash64_pteg_search(cpu, hash, sps, ptem=
, pte,
> > pshift);
> > +=A0=A0=A0=A0ptex =3D ppc_hash64_pteg_search(cpu, hash, sps, ptem, pte,
> > pshift);
> > =A0
> > -=A0=A0=A0=A0if (pte_offset =3D=3D -1) {
> > +=A0=A0=A0=A0if (ptex =3D=3D -1) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0/* Secondary PTEG lookup */
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0ptem |=3D HPTE64_V_SECONDARY;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0qemu_log_mask(CPU_LOG_MMU,
> > @@ -607,10 +616,10 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU
> > *cpu,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" hash=3D" TARGET_FM=
T_plx "\n", env->htab_base,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->htab_mask, vsid=
, ptem, ~hash);
> > =A0
> > -=A0=A0=A0=A0=A0=A0=A0=A0pte_offset =3D ppc_hash64_pteg_search(cpu, ~ha=
sh, sps, ptem,
> > pte, pshift);
> > +=A0=A0=A0=A0=A0=A0=A0=A0ptex =3D ppc_hash64_pteg_search(cpu, ~hash, sp=
s, ptem, pte,
> > pshift);
> > =A0=A0=A0=A0=A0}
> > =A0
> > -=A0=A0=A0=A0return pte_offset;
> > +=A0=A0=A0=A0return ptex;
> > =A0}
> > =A0
> > =A0unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU *cpu,
> > @@ -708,7 +717,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu,
> > vaddr eaddr,
> > =A0=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > =A0=A0=A0=A0=A0ppc_slb_t *slb;
> > =A0=A0=A0=A0=A0unsigned apshift;
> > -=A0=A0=A0=A0hwaddr pte_offset;
> > +=A0=A0=A0=A0hwaddr ptex;
> > =A0=A0=A0=A0=A0ppc_hash_pte64_t pte;
> > =A0=A0=A0=A0=A0int pp_prot, amr_prot, prot;
> > =A0=A0=A0=A0=A0uint64_t new_pte1, dsisr;
> > @@ -792,8 +801,8 @@ skip_slb_search:
> > =A0=A0=A0=A0=A0}
> > =A0
> > =A0=A0=A0=A0=A0/* 4. Locate the PTE in the hash table */
> > -=A0=A0=A0=A0pte_offset =3D ppc_hash64_htab_lookup(cpu, slb, eaddr, &pt=
e,
> > &apshift);
> > -=A0=A0=A0=A0if (pte_offset =3D=3D -1) {
> > +=A0=A0=A0=A0ptex =3D ppc_hash64_htab_lookup(cpu, slb, eaddr, &pte, &ap=
shift);
> > +=A0=A0=A0=A0if (ptex =3D=3D -1) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0dsisr =3D 0x40000000;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0if (rwx =3D=3D 2) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_set_isi(cs, env, dsis=
r);
> > @@ -806,7 +815,7 @@ skip_slb_search:
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0return 1;
> > =A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0qemu_log_mask(CPU_LOG_MMU,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"found PTE at offset %=
08" HWADDR_PRIx "\n",
> > pte_offset);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"found PTE at in=
dex %08" HWADDR_PRIx "\n", ptex);
> > =A0
> > =A0=A0=A0=A0=A0/* 5. Check access permissions */
> > =A0
> > @@ -849,8 +858,7 @@ skip_slb_search:
> > =A0=A0=A0=A0=A0}
> > =A0
> > =A0=A0=A0=A0=A0if (new_pte1 !=3D pte.pte1) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_store_hpte(cpu, pte_offset / HASH_P=
TE_SIZE_64,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0pte.pte0, new_pte1);
> > +=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_store_hpte(cpu, ptex, pte.pte0, new=
_pte1);
> > =A0=A0=A0=A0=A0}
> > =A0
> > =A0=A0=A0=A0=A0/* 7. Determine the real address from the PTE */
> > @@ -867,7 +875,7 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU
> > *cpu, target_ulong addr)
> > =A0{
> > =A0=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > =A0=A0=A0=A0=A0ppc_slb_t *slb;
> > -=A0=A0=A0=A0hwaddr pte_offset, raddr;
> > +=A0=A0=A0=A0hwaddr ptex, raddr;
> > =A0=A0=A0=A0=A0ppc_hash_pte64_t pte;
> > =A0=A0=A0=A0=A0unsigned apshift;
> > =A0
> > @@ -900,8 +908,8 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU
> > *cpu, target_ulong addr)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0}
> > =A0
> > -=A0=A0=A0=A0pte_offset =3D ppc_hash64_htab_lookup(cpu, slb, addr, &pte,
> > &apshift);
> > -=A0=A0=A0=A0if (pte_offset =3D=3D -1) {
> > +=A0=A0=A0=A0ptex =3D ppc_hash64_htab_lookup(cpu, slb, addr, &pte, &aps=
hift);
> > +=A0=A0=A0=A0if (ptex =3D=3D -1) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0return -1;
> > =A0=A0=A0=A0=A0}
> > =A0
> > @@ -909,30 +917,28 @@ hwaddr
> > ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong addr)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0& TARGET_PAGE_MASK;
> > =A0}
> > =A0
> > -void ppc_hash64_store_hpte(PowerPCCPU *cpu,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0target_ulong pte_index,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0target_ulong pte0, target_ulong pte1)
> > +void ppc_hash64_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0uint64_t pte0, uint64_t pte1)
> > =A0{
> > =A0=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > +=A0=A0=A0=A0hwaddr offset =3D ptex * HASH_PTE_SIZE_64;
> > =A0
> > =A0=A0=A0=A0=A0if (env->external_htab =3D=3D MMU_HASH64_KVM_MANAGED_HPT=
) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0kvmppc_hash64_write_pte(env, pte_index, pte0, =
pte1);
> > +=A0=A0=A0=A0=A0=A0=A0=A0kvmppc_hash64_write_pte(ptex, pte0, pte1);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > =A0=A0=A0=A0=A0}
> > =A0
> > -=A0=A0=A0=A0pte_index *=3D HASH_PTE_SIZE_64;
> > =A0=A0=A0=A0=A0if (env->external_htab) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0stq_p(env->external_htab + pte_index, pte0);
> > -=A0=A0=A0=A0=A0=A0=A0=A0stq_p(env->external_htab + pte_index + HASH_PT=
E_SIZE_64 / 2,
> > pte1);
> > +=A0=A0=A0=A0=A0=A0=A0=A0stq_p(env->external_htab + offset, pte0);
> > +=A0=A0=A0=A0=A0=A0=A0=A0stq_p(env->external_htab + offset + HASH_PTE_S=
IZE_64 / 2,
> > pte1);
> > =A0=A0=A0=A0=A0} else {
> > -=A0=A0=A0=A0=A0=A0=A0=A0stq_phys(CPU(cpu)->as, env->htab_base + pte_in=
dex, pte0);
> > +=A0=A0=A0=A0=A0=A0=A0=A0stq_phys(CPU(cpu)->as, env->htab_base + offset=
, pte0);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0stq_phys(CPU(cpu)->as,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->htab_base + pt=
e_index + HASH_PTE_SIZE_64 / 2,
> > pte1);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->htab_base + of=
fset + HASH_PTE_SIZE_64 / 2,
> > pte1);
> > =A0=A0=A0=A0=A0}
> > =A0}
> > =A0
> > -void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0target_ulong pte_index,
> > +void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, target_ulong ptex,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0target_ulong pte0, target_ulong pte1)
> > =A0{
> > =A0=A0=A0=A0=A0/*
> > diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> > index 7a0b7fc..8637fe4 100644
> > --- a/target/ppc/mmu-hash64.h
> > +++ b/target/ppc/mmu-hash64.h
> > @@ -10,8 +10,8 @@ int ppc_store_slb(PowerPCCPU *cpu, target_ulong
> > slot,
> > =A0hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong
> > addr);
> > =A0int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr address, int
> > rw,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0int mmu_idx);
> > -void ppc_hash64_store_hpte(PowerPCCPU *cpu, target_ulong index,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0target_ulong pte0, target_ulong pte1);
> > +void ppc_hash64_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0uint64_t pte0, uint64_t pte1);
> > =A0void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0target_ulong pte_index,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0target_ulong pte0, target_ulong
> > pte1);
> > @@ -96,41 +96,27 @@ void ppc_hash64_set_sdr1(PowerPCCPU *cpu,
> > target_ulong value,
> > =A0void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, void *hpt, int
> > shift,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0Error **errp);
> > =A0
> > -uint64_t ppc_hash64_start_access(PowerPCCPU *cpu, target_ulong
> > pte_index);
> > -void ppc_hash64_stop_access(PowerPCCPU *cpu, uint64_t token);
> > +struct ppc_hash_pte64 {
> > +=A0=A0=A0=A0uint64_t pte0, pte1;
> > +};
> > +
> > +const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,\
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0hwaddr pt=
ex, int n);
> > +void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const ppc_hash_pte64_t
> > *hptes,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0hwaddr ptex, int n);
> > =A0
> > -static inline target_ulong ppc_hash64_load_hpte0(PowerPCCPU *cpu,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0uint64_t token, int
> > index)
> > +static inline uint64_t ppc_hash64_hpte0(PowerPCCPU *cpu,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0const ppc_hash_pte64_t
> > *hptes, int i)
> > =A0{
> > -=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > -=A0=A0=A0=A0uint64_t addr;
> > -
> > -=A0=A0=A0=A0addr =3D token + (index * HASH_PTE_SIZE_64);
> > -=A0=A0=A0=A0if (env->external_htab) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0return=A0=A0ldq_p((const void *)(uintptr_t)add=
r);
> > -=A0=A0=A0=A0} else {
> > -=A0=A0=A0=A0=A0=A0=A0=A0return ldq_phys(CPU(cpu)->as, addr);
> > -=A0=A0=A0=A0}
> > +=A0=A0=A0=A0return ldq_p(&(hptes[i].pte0));
> > =A0}
> > =A0
> > -static inline target_ulong ppc_hash64_load_hpte1(PowerPCCPU *cpu,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0uint64_t token, int
> > index)
> > +static inline uint64_t ppc_hash64_hpte1(PowerPCCPU *cpu,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0const ppc_hash_pte64_t
> > *hptes, int i)
> > =A0{
> > -=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > -=A0=A0=A0=A0uint64_t addr;
> > -
> > -=A0=A0=A0=A0addr =3D token + (index * HASH_PTE_SIZE_64) + HASH_PTE_SIZ=
E_64/2;
> > -=A0=A0=A0=A0if (env->external_htab) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0return=A0=A0ldq_p((const void *)(uintptr_t)add=
r);
> > -=A0=A0=A0=A0} else {
> > -=A0=A0=A0=A0=A0=A0=A0=A0return ldq_phys(CPU(cpu)->as, addr);
> > -=A0=A0=A0=A0}
> > +=A0=A0=A0=A0return ldq_p(&(hptes[i].pte1));
> > =A0}
> > =A0
> > -typedef struct {
> > -=A0=A0=A0=A0uint64_t pte0, pte1;
> > -} ppc_hash_pte64_t;
> > -
> > =A0#endif /* CONFIG_USER_ONLY */
> > =A0
> > =A0#endif /* MMU_HASH64_H */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rsGyAQ90QqnfMsmV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYr8OuAAoJEGw4ysog2bOSItQP/313tzSC25qz2aIdQSHi+ZhS
fhw+qSVlerGySWBhiqmG+HdpTIA++cGhP0DRljHOtdi242/e4j2ngh6DHH9ob/VR
oouc6ZPwIiegOJomRimvQ71wOHkjDEVKkT0ND/dzxFHevEad6lGLCgbZJ8BuUqVr
+MnOHrj2Gz1o2ZupklY3amU8hQ8c76fSy1veLtaPfv0f+wUFrjk8TqmD/h9tNbzN
mRpbrmWZ907lsiAYcFoPFrmPuCGhVbiGjPmqbwYo6L77CCGKcZluH5ya5kkAeedD
Urw9fhukbyu573mcpi0lD+Ddm2sNSapoO41rR93Itox+u5P+2oQaPlMDB5oUe4wZ
EE416AshC6X0slnuZchBxbLz7EjJh3i3QhMzjxkwQT5ZHxxeUhMmub+Q8eT+ywLJ
/9MXsCiBbfvaoROepydsHw1hnK0EQt4rC+WmcogkCI9lNlmLC4sv5PYwNWeBmstE
1daK+VnEmsy7fVeKwcYj7/vT+igPIrei50gihgCkV4KuKRgM1ISs58n4HPcpvBA2
jyp/uX8fcIdXQ17HFiTSA3Evm+FORjPzqS3iZZv7dJMBW4osnlBrfdyVEXvUDdJA
M3PeQwdAG4ASlTiFmAIueP6G/3sGyVJNKr8g0R6BKWJOFI8i6+TFI4kHKSMy+HYs
KrYghGYU8G7eG/E/j9Vh
=96d4
-----END PGP SIGNATURE-----

--rsGyAQ90QqnfMsmV--
