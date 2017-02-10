Received: from eggs.gnu.org ([2001:4830:134:3::10]:47061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbzFD-0002Mm-2U
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbzF9-00067e-Iq
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:39:23 -0500
Date: Fri, 10 Feb 2017 11:21:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210002129.GN27610@umbus.fritz.box>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-12-git-send-email-sjitindarsingh@gmail.com>
	<20170201042819.GQ30639@umbus.fritz.box>
	<1486609721.2498.83.camel@gmail.com>
	<1486684035.4230.1.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="prC3/KjdfqNV7evK"
Content-Disposition: inline
In-Reply-To: <1486684035.4230.1.camel@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 11/17] target/ppc/POWER9: Update to new
 pte format for POWER9 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org


--prC3/KjdfqNV7evK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 10:47:15AM +1100, Suraj Jitindar Singh wrote:
> On Thu, 2017-02-09 at 14:08 +1100, Suraj Jitindar Singh wrote:
> > On Wed, 2017-02-01 at 15:28 +1100, David Gibson wrote:
> > >=20
> > > On Fri, Jan 13, 2017 at 05:28:17PM +1100, Suraj Jitindar Singh
> > > wrote:
> > > >=20
> > > >=20
> > > > The page table entry format was updated for the POWER9 processor.
> > > >=20
> > > > It was decided that kernels would used the old format
> > > > irrespective
> > > > with the translation occuring at the hypervisor level. Thus we
> > > > convert
> > > > between the old and new format when accessing the ptes. Since we
> > > > need the
> > > > whole pte to perform this conversion, we remove the old functions
> > > > which
> > > > accessed either the first or second doubleword and introduce a
> > > > new
> > > > functions which access the entire pte, returning the entry
> > > > converted
> > > > back to the old format (if required). Update call sites
> > > > accordingly.
> > > >=20
> > > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > > > ---
> > > > =A0hw/ppc/spapr_hcall.c=A0=A0=A0=A0| 51 ++++++++++++++++++---------=
--------
> > > > =A0target/ppc/mmu-hash64.c | 13 +++++----
> > > > =A0target/ppc/mmu-hash64.h | 71
> > > > ++++++++++++++++++++++++++++++++++++-
> > > > ------------
> > > > =A03 files changed, 86 insertions(+), 49 deletions(-)
> > > >=20
> > > > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > > > index 9a9bedf..9f0c20d 100644
> > > > --- a/hw/ppc/spapr_hcall.c
> > > > +++ b/hw/ppc/spapr_hcall.c
> > > > @@ -125,7 +125,8 @@ static target_ulong h_enter(PowerPCCPU *cpu,
> > > > sPAPRMachineState *spapr,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0pte_index &=3D ~7ULL;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0token =3D ppc_hash64_start_access(cpu, p=
te_index);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0for (; index < 8; index++) {
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!(ppc_hash64_load_hpte0(cp=
u, token, index) &
> > > > HPTE64_V_VALID)) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash_pte64_t pte =3D ppc_h=
ash64_load_hpte(cpu,
> > > > token, index);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!(pte.pte0 & HPTE64_V_VALI=
D)) {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > > @@ -134,8 +135,10 @@ static target_ulong h_enter(PowerPCCPU *cpu,
> > > > sPAPRMachineState *spapr,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return H_PTEG_FULL;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > > =A0=A0=A0=A0=A0} else {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash_pte64_t pte;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0token =3D ppc_hash64_start_access(cpu, p=
te_index);
> > > IIRC the only reason for the clumsy start_access / stop_access
> > > stuff
> > > was because we wanted to do the two loads separately (to avoid
> > > loading
> > > word1 in cases we don't need it).=A0=A0Since you're combining both
> > > loads
> > > into a single helper, I think you can put the start_access /
> > > stop_access into the same helper.
> > >=20
> > > Or have I missed something.
> > >=20
> > Yeah these functions can probably be merged together...
> Actually, it looks like we need the start access and stop access stuff
> for kvm-hv where we load the pte into a buffer on start access and free
> it on stop access. So I think we still need to keep these two functions
> separate.

Well, the question is are there any instances where we do more than
just a load word0 + load word1 within the start/stop pair.  I don't
remember off hand.

> > >=20
> > > >=20
> > > >=20
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0if (ppc_hash64_load_hpte0(cpu, token, 0) &
> > > > HPTE64_V_VALID)
> > > > {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0pte =3D ppc_hash64_load_hpte(cpu, token, 0=
);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0if (pte.pte0 & HPTE64_V_VALID) {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_stop_access(cpu, =
token);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return H_PTEG_FULL;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > > @@ -163,26 +166,25 @@ static RemoveResult remove_hpte(PowerPCCPU
> > > > *cpu, target_ulong ptex,
> > > > =A0{
> > > > =A0=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > > > =A0=A0=A0=A0=A0uint64_t token;
> > > > -=A0=A0=A0=A0target_ulong v, r;
> > > > +=A0=A0=A0=A0ppc_hash_pte64_t pte;
> > > > =A0
> > > > =A0=A0=A0=A0=A0if (!valid_pte_index(env, ptex)) {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0return REMOVE_PARM;
> > > > =A0=A0=A0=A0=A0}
> > > > =A0
> > > > =A0=A0=A0=A0=A0token =3D ppc_hash64_start_access(cpu, ptex);
> > > > -=A0=A0=A0=A0v =3D ppc_hash64_load_hpte0(cpu, token, 0);
> > > > -=A0=A0=A0=A0r =3D ppc_hash64_load_hpte1(cpu, token, 0);
> > > > +=A0=A0=A0=A0pte =3D ppc_hash64_load_hpte(cpu, token, 0);
> > > > =A0=A0=A0=A0=A0ppc_hash64_stop_access(cpu, token);
> > > > =A0
> > > > -=A0=A0=A0=A0if ((v & HPTE64_V_VALID) =3D=3D 0 ||
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0((flags & H_AVPN) && (v & ~0x7fULL) !=3D a=
vpn) ||
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0((flags & H_ANDCOND) && (v & avpn) !=3D 0)=
) {
> > > > +=A0=A0=A0=A0if ((pte.pte0 & HPTE64_V_VALID) =3D=3D 0 ||
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0((flags & H_AVPN) && (pte.pte0 & ~0x7fULL)=
 !=3D avpn) ||
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0((flags & H_ANDCOND) && (pte.pte0 & avpn) =
!=3D 0)) {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0return REMOVE_NOT_FOUND;
> > > > =A0=A0=A0=A0=A0}
> > > > -=A0=A0=A0=A0*vp =3D v;
> > > > -=A0=A0=A0=A0*rp =3D r;
> > > > +=A0=A0=A0=A0*vp =3D pte.pte0;
> > > > +=A0=A0=A0=A0*rp =3D pte.pte1;
> > > > =A0=A0=A0=A0=A0ppc_hash64_store_hpte(cpu, ptex, HPTE64_V_HPTE_DIRTY=
, 0);
> > > > -=A0=A0=A0=A0ppc_hash64_tlb_flush_hpte(cpu, ptex, v, r);
> > > > +=A0=A0=A0=A0ppc_hash64_tlb_flush_hpte(cpu, ptex, pte.pte0, pte.pte=
1);
> > > > =A0=A0=A0=A0=A0return REMOVE_SUCCESS;
> > > > =A0}
> > > > =A0
> > > > @@ -293,35 +295,36 @@ static target_ulong h_protect(PowerPCCPU
> > > > *cpu, sPAPRMachineState *spapr,
> > > > =A0=A0=A0=A0=A0target_ulong flags =3D args[0];
> > > > =A0=A0=A0=A0=A0target_ulong pte_index =3D args[1];
> > > > =A0=A0=A0=A0=A0target_ulong avpn =3D args[2];
> > > > +=A0=A0=A0=A0ppc_hash_pte64_t pte;
> > > > =A0=A0=A0=A0=A0uint64_t token;
> > > > -=A0=A0=A0=A0target_ulong v, r;
> > > > =A0
> > > > =A0=A0=A0=A0=A0if (!valid_pte_index(env, pte_index)) {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0return H_PARAMETER;
> > > > =A0=A0=A0=A0=A0}
> > > > =A0
> > > > =A0=A0=A0=A0=A0token =3D ppc_hash64_start_access(cpu, pte_index);
> > > > -=A0=A0=A0=A0v =3D ppc_hash64_load_hpte0(cpu, token, 0);
> > > > -=A0=A0=A0=A0r =3D ppc_hash64_load_hpte1(cpu, token, 0);
> > > > +=A0=A0=A0=A0pte =3D ppc_hash64_load_hpte(cpu, token, 0);
> > > > =A0=A0=A0=A0=A0ppc_hash64_stop_access(cpu, token);
> > > > =A0
> > > > -=A0=A0=A0=A0if ((v & HPTE64_V_VALID) =3D=3D 0 ||
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0((flags & H_AVPN) && (v & ~0x7fULL) !=3D a=
vpn)) {
> > > > +=A0=A0=A0=A0if ((pte.pte0 & HPTE64_V_VALID) =3D=3D 0 ||
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0((flags & H_AVPN) && (pte.pte0 & ~0x7fULL)=
 !=3D avpn)) {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0return H_NOT_FOUND;
> > > > =A0=A0=A0=A0=A0}
> > > > =A0
> > > > -=A0=A0=A0=A0r &=3D ~(HPTE64_R_PP0 | HPTE64_R_PP | HPTE64_R_N |
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0HPTE64_R_KEY_HI | HPTE64_R_KEY_LO=
);
> > > > -=A0=A0=A0=A0r |=3D (flags << 55) & HPTE64_R_PP0;
> > > > -=A0=A0=A0=A0r |=3D (flags << 48) & HPTE64_R_KEY_HI;
> > > > -=A0=A0=A0=A0r |=3D flags & (HPTE64_R_PP | HPTE64_R_N | HPTE64_R_KE=
Y_LO);
> > > > +=A0=A0=A0=A0pte.pte1 &=3D ~(HPTE64_R_PP0 | HPTE64_R_PP | HPTE64_R_=
N |
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0HPTE64_R_KEY=
_HI | HPTE64_R_KEY_LO);
> > > > +=A0=A0=A0=A0pte.pte1 |=3D (flags << 55) & HPTE64_R_PP0;
> > > > +=A0=A0=A0=A0pte.pte1 |=3D (flags << 48) & HPTE64_R_KEY_HI;
> > > > +=A0=A0=A0=A0pte.pte1 |=3D flags & (HPTE64_R_PP | HPTE64_R_N |
> > > > HPTE64_R_KEY_LO);
> > > > =A0=A0=A0=A0=A0ppc_hash64_store_hpte(cpu, pte_index,
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0(v & ~HPTE64_V_VALID) |
> > > > HPTE64_V_HPTE_DIRTY, 0);
> > > > -=A0=A0=A0=A0ppc_hash64_tlb_flush_hpte(cpu, pte_index, v, r);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0(pte.pte0 & ~HPTE64_V_VALID) |
> > > > HPTE64_V_HPTE_DIRTY,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A00);
> > > > +=A0=A0=A0=A0ppc_hash64_tlb_flush_hpte(cpu, pte_index, pte.pte0,
> > > > pte.pte1);
> > > > =A0=A0=A0=A0=A0/* Flush the tlb */
> > > > =A0=A0=A0=A0=A0check_tlb_flush(env, true);
> > > > =A0=A0=A0=A0=A0/* Don't need a memory barrier, due to qemu's global=
 lock */
> > > > -=A0=A0=A0=A0ppc_hash64_store_hpte(cpu, pte_index, v |
> > > > HPTE64_V_HPTE_DIRTY,
> > > > r);
> > > > +=A0=A0=A0=A0ppc_hash64_store_hpte(cpu, pte_index, pte.pte0 |
> > > > HPTE64_V_HPTE_DIRTY,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0pte.pte1);
> > > > =A0=A0=A0=A0=A0return H_SUCCESS;
> > > > =A0}
> > > > =A0
> > > > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > > > index b476b3f..03607d5 100644
> > > > --- a/target/ppc/mmu-hash64.c
> > > > +++ b/target/ppc/mmu-hash64.c
> > > > @@ -515,7 +515,6 @@ static hwaddr
> > > > ppc_hash64_pteg_search(PowerPCCPU
> > > > *cpu, hwaddr hash,
> > > > =A0=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > > > =A0=A0=A0=A0=A0int i;
> > > > =A0=A0=A0=A0=A0uint64_t token;
> > > > -=A0=A0=A0=A0target_ulong pte0, pte1;
> > > > =A0=A0=A0=A0=A0target_ulong pte_index;
> > > > =A0
> > > > =A0=A0=A0=A0=A0pte_index =3D (hash & env->htab_mask) * HPTES_PER_GR=
OUP;
> > > > @@ -524,12 +523,11 @@ static hwaddr
> > > > ppc_hash64_pteg_search(PowerPCCPU *cpu, hwaddr hash,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0return -1;
> > > > =A0=A0=A0=A0=A0}
> > > > =A0=A0=A0=A0=A0for (i =3D 0; i < HPTES_PER_GROUP; i++) {
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0pte0 =3D ppc_hash64_load_hpte0(cpu, token,=
 i);
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0pte1 =3D ppc_hash64_load_hpte1(cpu, token,=
 i);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash_pte64_t entry =3D ppc_hash64_load=
_hpte(cpu,
> > > > token,
> > > > i);
> > > Hm.=A0=A0So the hypercalls using the access helpers which include
> > > format
> > > conversion makes sense to me - the hypercalls are defined to use
> > > the
> > > old format, even on POWER9 AIUI.
> > >=20
> > > It doesn't really make sense to me here, in what is essentially the
> > > physical implementation of the HPT lookup.=A0=A0Shouldn't that be usi=
ng
> > > the new format natively?
> > >=20
> > > Basically it seems odd that you store things in the new format in
> > > memory, but convert to the old format on *all* accesses, not just
> > > the
> > > hypercall ones which are defined that way.
> > >=20
> > It seemed easier to just do the conversion rather than updating the
> > code in all places. That said since this is modelling the hardware
> > and
> > should probably use the new format instead of just converting it and
> > pretenting nothing changed.
> > >=20
> > > >=20
> > > >=20
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0/* This compares V, B, H (secondary) and=
 the AVPN */
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0if (HPTE64_V_COMPARE(pte0, ptem)) {
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*pshift =3D hpte_page_shift(sp=
s, pte0, pte1);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0if (HPTE64_V_COMPARE(entry.pte0, ptem)) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*pshift =3D hpte_page_shift(sp=
s, entry.pte0,
> > > > entry.pte1);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/*
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0* If there is no match, i=
gnore the PTE, it could
> > > > simply
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0* be for a different segm=
ent size encoding and the
> > > > @@ -543,8 +541,7 @@ static hwaddr
> > > > ppc_hash64_pteg_search(PowerPCCPU
> > > > *cpu, hwaddr hash,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* We don't do anything with=
 pshift yet as qemu TLB
> > > > only deals
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0* with 4K pages anyway
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*/
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pte->pte0 =3D pte0;
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pte->pte1 =3D pte1;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*pte =3D entry;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_stop_access(cpu, =
token);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return (pte_index + i) * HAS=
H_PTE_SIZE_64;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > > @@ -924,6 +921,8 @@ void ppc_hash64_store_hpte(PowerPCCPU *cpu,
> > > > =A0{
> > > > =A0=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > > > =A0
> > > > +=A0=A0=A0=A0ppc_hash64_hpte_old_to_new(env, &pte0, &pte1);
> > > > +
> > > > =A0=A0=A0=A0=A0if (env->external_htab =3D=3D MMU_HASH64_KVM_MANAGED=
_HPT) {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0kvmppc_hash64_write_pte(env, pte_index, =
pte0, pte1);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > > > diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> > > > index ab5d347..73d7ce4 100644
> > > > --- a/target/ppc/mmu-hash64.h
> > > > +++ b/target/ppc/mmu-hash64.h
> > > > @@ -60,6 +60,7 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
> > > > =A0#define HASH_PTE_SIZE_64=A0=A0=A0=A0=A0=A0=A0=A016
> > > > =A0#define HASH_PTEG_SIZE_64=A0=A0=A0=A0=A0=A0=A0(HASH_PTE_SIZE_64 *
> > > > HPTES_PER_GROUP)
> > > > =A0
> > > > +#define HPTE64_V_3_00_COMMON=A0=A0=A0=A00x000fffffffffffffULL
> > > > =A0#define HPTE64_V_SSIZE_SHIFT=A0=A0=A0=A062
> > > > =A0#define HPTE64_V_AVPN_SHIFT=A0=A0=A0=A0=A07
> > > > =A0#define HPTE64_V_AVPN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x3fffffff=
ffffff80ULL
> > > > @@ -69,9 +70,12 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
> > > > =A0#define HPTE64_V_SECONDARY=A0=A0=A0=A0=A0=A00x0000000000000002ULL
> > > > =A0#define HPTE64_V_VALID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x0000000000=
000001ULL
> > > > =A0
> > > > +#define HPTE64_R_3_00_COMMON=A0=A0=A0=A00xf1ffffffffffffffULL
> > > > =A0#define HPTE64_R_PP0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x800000=
0000000000ULL
> > > > =A0#define HPTE64_R_TS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x4000=
000000000000ULL
> > > > =A0#define HPTE64_R_KEY_HI=A0=A0=A0=A0=A0=A0=A0=A0=A00x300000000000=
0000ULL
> > > > +#define HPTE64_R_SSIZE_SHIFT=A0=A0=A0=A058
> > > > +#define HPTE64_R_SSIZE_MASK=A0=A0=A0=A0=A0(3ULL << HPTE64_R_SSIZE_=
SHIFT)
> > > > =A0#define HPTE64_R_RPN_SHIFT=A0=A0=A0=A0=A0=A012
> > > > =A0#define HPTE64_R_RPN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x0fffff=
fffffff000ULL
> > > > =A0#define HPTE64_R_FLAGS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x0000000000=
0003ffULL
> > > > @@ -91,6 +95,10 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
> > > > =A0#define HPTE64_V_1TB_SEG=A0=A0=A0=A0=A0=A0=A0=A00x40000000000000=
00ULL
> > > > =A0#define HPTE64_V_VRMA_MASK=A0=A0=A0=A0=A0=A00x4001ffffff000000ULL
> > > > =A0
> > > > +typedef struct {
> > > > +=A0=A0=A0=A0uint64_t pte0, pte1;
> > > > +} ppc_hash_pte64_t;
> > > > +
> > > > =A0void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ulong value,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0Error **errp);
> > > > =A0void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, void *hpt, int
> > > > shift,
> > > > @@ -99,37 +107,64 @@ void ppc_hash64_set_external_hpt(PowerPCCPU
> > > > *cpu, void *hpt, int shift,
> > > > =A0uint64_t ppc_hash64_start_access(PowerPCCPU *cpu, target_ulong
> > > > pte_index);
> > > > =A0void ppc_hash64_stop_access(PowerPCCPU *cpu, uint64_t token);
> > > > =A0
> > > > -static inline target_ulong ppc_hash64_load_hpte0(PowerPCCPU
> > > > *cpu,
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0uint64_t token,
> > > > int index)
> > > > +static inline void ppc_hash64_hpte_old_to_new(CPUPPCState *env,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0tar=
get_ulong
> > > > *pte0,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0tar=
get_ulong
> > > > *pte1)
> > > > =A0{
> > > > -=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > > > -=A0=A0=A0=A0uint64_t addr;
> > > > +=A0=A0=A0=A0switch (env->mmu_model) {
> > > > +=A0=A0=A0=A0case POWERPC_MMU_3_00:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0/*
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0* v3.00 of the ISA moved the B field to=
 the second
> > > > doubleword and
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0* shortened the abbreviated virtual add=
ress and
> > > > abbreviated real page
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0* number fields
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0*/
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0*pte1 =3D (*pte1 & HPTE64_R_3_00_COMMON) |
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0((*pte0 >> HPTE64_=
V_SSIZE_SHIFT) <<
> > > > HPTE64_R_SSIZE_SHIFT);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0*pte0 =3D *pte0 & HPTE64_V_3_00_COMMON;
> > > > +=A0=A0=A0=A0default:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0;
> > > > +=A0=A0=A0=A0}
> > > > +}
> > > > =A0
> > > > -=A0=A0=A0=A0addr =3D token + (index * HASH_PTE_SIZE_64);
> > > > -=A0=A0=A0=A0if (env->external_htab) {
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0return=A0=A0ldq_p((const void *)(uintptr_t=
)addr);
> > > > -=A0=A0=A0=A0} else {
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0return ldq_phys(CPU(cpu)->as, addr);
> > > > +static inline void ppc_hash64_hpte_new_to_old(CPUPPCState *env,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0tar=
get_ulong
> > > > *pte0,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0tar=
get_ulong
> > > > *pte1)
> > > > +{
> > > > +=A0=A0=A0=A0switch (env->mmu_model) {
> > > > +=A0=A0=A0=A0case POWERPC_MMU_3_00:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0/*
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0* v3.00 of the ISA moved the B field to=
 the second
> > > > doubleword and
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0* shortened the abbreviated virtual add=
ress and
> > > > abbreviated real page
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0* number fields
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0*/
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0*pte0 =3D (*pte0 & HPTE64_V_3_00_COMMON) |=
 ((*pte1 &
> > > > HPTE64_R_SSIZE_MASK)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0<< (HPTE64_V_SSIZE=
_SHIFT -
> > > > HPTE64_R_SSIZE_SHIFT));
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0*pte1 =3D *pte1 & HPTE64_R_3_00_COMMON;
> > > > +=A0=A0=A0=A0default:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0;
> > > > =A0=A0=A0=A0=A0}
> > > > =A0}
> > > > =A0
> > > > -static inline target_ulong ppc_hash64_load_hpte1(PowerPCCPU
> > > > *cpu,
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0uint64_t token,
> > > > int index)
> > > > +static inline ppc_hash_pte64_t ppc_hash64_load_hpte(PowerPCCPU
> > > > *cpu,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0uint64_t
> > > > token,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0int index)
> > > > =A0{
> > > > =A0=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > > > +=A0=A0=A0=A0ppc_hash_pte64_t pte;
> > > > =A0=A0=A0=A0=A0uint64_t addr;
> > > > =A0
> > > > -=A0=A0=A0=A0addr =3D token + (index * HASH_PTE_SIZE_64) +
> > > > HASH_PTE_SIZE_64/2;
> > > > +=A0=A0=A0=A0addr =3D token + (index * HASH_PTE_SIZE_64);
> > > > =A0=A0=A0=A0=A0if (env->external_htab) {
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0return=A0=A0ldq_p((const void *)(uintptr_t=
)addr);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0pte.pte0 =3D ldq_p((const void *)(uintptr_=
t)addr);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0pte.pte1 =3D ldq_p((const void *)(uintptr_=
t)addr +
> > > > HASH_PTE_SIZE_64/2);
> > > > =A0=A0=A0=A0=A0} else {
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0return ldq_phys(CPU(cpu)->as, addr);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0pte.pte0 =3D ldq_phys(CPU(cpu)->as, addr);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0pte.pte1 =3D ldq_phys(CPU(cpu)->as, addr +
> > > > HASH_PTE_SIZE_64/2);
> > > > =A0=A0=A0=A0=A0}
> > > > -}
> > > > =A0
> > > > -typedef struct {
> > > > -=A0=A0=A0=A0uint64_t pte0, pte1;
> > > > -} ppc_hash_pte64_t;
> > > > +=A0=A0=A0=A0ppc_hash64_hpte_new_to_old(env, &pte.pte0, &pte.pte1);
> > > > +=A0=A0=A0=A0return pte;
> > > > +}
> > > > =A0
> > > > =A0#endif /* CONFIG_USER_ONLY */
> > > > =A0
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--prC3/KjdfqNV7evK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnQeJAAoJEGw4ysog2bOSW2QP/3b3OUEPx73u5bpLCG/0DTFH
69/JREIYv2SCZ/X3wOCp3hKwUijWOwFQ0mmlbSySuRGZ6+R11Yd+MzgwN87fQGok
MJM7N9vxs2yCUue2JQABB4K0xUtVTZV4d4Ql2Dv/EOQKFRpFqtYw/gfDW1WhzqyS
/abqu9wtsHlrmeeTudq6uaRdgX0FTjh9iGtrsJfPmC6SsdCMvhXmCezwrXu3wBUs
q8ivrVFgeGTzHSck22kF4Ak55iK+kG8NFiMhKnG6ErRUWyiKKPXTb5MEfNKqR/eI
7Ek2Ir2vW8KmUbhjZJr0yZF3baQ2lUWN3117Z5OenK7jFs7DfyVyU3PFkc4jgd/9
iDn1n6BclA0GcUOPXUDkbtt593WcP6ImTk0h+Of/jkLwNGdogjfbN3FpT9KtJtO6
tcOea5Ystxa89imkzYSEEnI4nhmIVvuRkb3TbYVlmxQhgkasvfmj3z2BFAIoWn7Y
bdOii8q3PzpcgNEiDFT4VNomCW+z+3FOeRtozf3AlDKxDQ+nroh937HyVARDHG9Q
8DgZ0HYNgAsLrG8BXwyFmgxT2rN10uIFxCkvMYKgRk74xW5POuA31WtW+RFKQ2iY
B+MBhOJLYavAgUhC5NCi8V355dpaQ9nTwfrjFBPz+I8HWMEtR73DnQjOOIZdAK49
VhHOQcou3Z/QoAuicipA
=zvAY
-----END PGP SIGNATURE-----

--prC3/KjdfqNV7evK--
