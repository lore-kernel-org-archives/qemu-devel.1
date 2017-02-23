Received: from eggs.gnu.org ([2001:4830:134:3::10]:35071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgls8-0007pu-Az
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 00:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgls5-0001AP-GV
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 00:23:20 -0500
Date: Thu, 23 Feb 2017 16:23:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223052307.GB12616@umbus.fritz.box>
References: <20170223020936.29220-1-david@gibson.dropbear.id.au>
	<20170223020936.29220-5-david@gibson.dropbear.id.au>
	<b091dc2d-7608-5bfc-fb2a-47024837715c@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <b091dc2d-7608-5bfc-fb2a-47024837715c@ozlabs.ru>
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-ppc@nongnu.org, sjitindarsingh@gmail.com, qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, paulus@samba.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 04:02:54PM +1100, Alexey Kardashevskiy wrote:
> On 23/02/17 13:09, David Gibson wrote:
> > Accesses to the hashed page table (HPT) are complicated by the fact that
> > the HPT could be in one of three places:
> >    1) Within guest memory - when we're emulating a full guest CPU at the
> >       hardware level (e.g. powernv, mac99, g3beige)
> >    2) Within qemu, but outside guest memory - when we're emulating user=
 and
> >       supervisor instructions within TCG, but instead of emulating
> >       the CPU's hypervisor mode, we just emulate a hypervisor's behavio=
ur
> >       (pseries in TCG)
> >    3) Within KVM - a pseries machine using KVM acceleration.  Mostly
> >       accesses to the HPT are handled by KVM, but there are a few cases
> >       where qemu needs to access it via a special fd for the purpose.
> >=20
> > In order to batch accesses to the fd in case (3), we use a somewhat awk=
ward
> > ppc_hash64_start_access() / ppc_hash64_stop_access() pair, which for ca=
se
> > (3) reads / releases a whole PTEG from the kernel.  For cases (1) & (2)
> > it just returns an address value.  The actual HPTE load helpers then ne=
ed
> > to interpret the returned token differently in the 3 cases.
> >=20
> > This patch keeps the same basic structure, but simplfiies the details.
> > First start_access() / stop_access() are renamed to get_pteg() and
> > put_pteg() to make their operation more obvious.
>=20
>=20
> They are renamed to map_hptes/unmap_hptes actually.

Oops.  Adjusted.

>=20
>=20
> > Second, read_pteg() now
> > always returns a qemu pointer, which can always be used in the same way
> > by the load_hpte() helpers.  In case (1) it comes from address_space_ma=
p()
> > in case (2) directly from qemu's HPT buffer and in case (3) from a
> > temporary buffer read from the KVM fd.
> >=20
> > While we're at it, make things a bit more consistent in terms of types =
and
> > variable names: avoid variables named 'index' (it shadows index(3) which
> > can lead to confusing results), use 'hwaddr ptex' for HPTE indices and
> > uint64_t for each of the HPTE words, use ptex throughout the call stack
> > instead of pte_offset in some places (we still need that at the bottom
> > layer, but nowhere else).
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_hcall.c    | 36 +++++++++---------
> >  target/ppc/cpu.h        |  3 +-
> >  target/ppc/kvm.c        | 25 ++++++-------
> >  target/ppc/kvm_ppc.h    | 43 ++++++++++------------
> >  target/ppc/mmu-hash64.c | 98 ++++++++++++++++++++++++++---------------=
--------
> >  target/ppc/mmu-hash64.h | 46 ++++++++---------------
> >  6 files changed, 119 insertions(+), 132 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 3298a14..fd961b5 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -84,7 +84,7 @@ static target_ulong h_enter(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
> >      unsigned apshift;
> >      target_ulong raddr;
> >      target_ulong slot;
> > -    uint64_t token;
> > +    const ppc_hash_pte64_t *hptes;
> > =20
> >      apshift =3D ppc_hash64_hpte_page_shift_noslb(cpu, pteh, ptel);
> >      if (!apshift) {
> > @@ -123,23 +123,23 @@ static target_ulong h_enter(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
> >      ptex =3D ptex & ~7ULL;
> > =20
> >      if (likely((flags & H_EXACT) =3D=3D 0)) {
> > -        token =3D ppc_hash64_start_access(cpu, ptex);
> > +        hptes =3D ppc_hash64_map_hptes(cpu, ptex, HPTES_PER_GROUP);
> >          for (slot =3D 0; slot < 8; slot++) {
> > -            if (!(ppc_hash64_load_hpte0(cpu, token, slot) & HPTE64_V_V=
ALID)) {
> > +            if (!(ppc_hash64_hpte0(cpu, hptes, slot) & HPTE64_V_VALID)=
) {
> >                  break;
> >              }
> >          }
> > -        ppc_hash64_stop_access(cpu, token);
> > +        ppc_hash64_unmap_hptes(cpu, hptes, ptex, HPTES_PER_GROUP);
> >          if (slot =3D=3D 8) {
> >              return H_PTEG_FULL;
> >          }
> >      } else {
> > -        token =3D ppc_hash64_start_access(cpu, ptex);
> > -        if (ppc_hash64_load_hpte0(cpu, token, 0) & HPTE64_V_VALID) {
> > -            ppc_hash64_stop_access(cpu, token);
> > +        hptes =3D ppc_hash64_map_hptes(cpu, ptex + slot, 1);
> > +        if (ppc_hash64_hpte0(cpu, hptes, 0) & HPTE64_V_VALID) {
> > +            ppc_hash64_unmap_hptes(cpu, hptes, ptex + slot, 1);
> >              return H_PTEG_FULL;
> >          }
> > -        ppc_hash64_stop_access(cpu, token);
> > +        ppc_hash64_unmap_hptes(cpu, hptes, ptex, 1);
> >      }
> > =20
> >      ppc_hash64_store_hpte(cpu, ptex + slot, pteh | HPTE64_V_HPTE_DIRTY=
, ptel);
> > @@ -160,17 +160,17 @@ static RemoveResult remove_hpte(PowerPCCPU *cpu, =
target_ulong ptex,
> >                                  target_ulong flags,
> >                                  target_ulong *vp, target_ulong *rp)
> >  {
> > -    uint64_t token;
> > +    const ppc_hash_pte64_t *hptes;
> >      target_ulong v, r;
> > =20
> >      if (!valid_ptex(cpu, ptex)) {
> >          return REMOVE_PARM;
> >      }
> > =20
> > -    token =3D ppc_hash64_start_access(cpu, ptex);
> > -    v =3D ppc_hash64_load_hpte0(cpu, token, 0);
> > -    r =3D ppc_hash64_load_hpte1(cpu, token, 0);
> > -    ppc_hash64_stop_access(cpu, token);
> > +    hptes =3D ppc_hash64_map_hptes(cpu, ptex, 1);
> > +    v =3D ppc_hash64_hpte0(cpu, hptes, 0);
> > +    r =3D ppc_hash64_hpte1(cpu, hptes, 0);
> > +    ppc_hash64_unmap_hptes(cpu, hptes, ptex, 1);
> > =20
> >      if ((v & HPTE64_V_VALID) =3D=3D 0 ||
> >          ((flags & H_AVPN) && (v & ~0x7fULL) !=3D avpn) ||
> > @@ -291,17 +291,17 @@ static target_ulong h_protect(PowerPCCPU *cpu, sP=
APRMachineState *spapr,
> >      target_ulong flags =3D args[0];
> >      target_ulong ptex =3D args[1];
> >      target_ulong avpn =3D args[2];
> > -    uint64_t token;
> > +    const ppc_hash_pte64_t *hptes;
> >      target_ulong v, r;
> > =20
> >      if (!valid_ptex(cpu, ptex)) {
> >          return H_PARAMETER;
> >      }
> > =20
> > -    token =3D ppc_hash64_start_access(cpu, ptex);
> > -    v =3D ppc_hash64_load_hpte0(cpu, token, 0);
> > -    r =3D ppc_hash64_load_hpte1(cpu, token, 0);
> > -    ppc_hash64_stop_access(cpu, token);
> > +    hptes =3D ppc_hash64_map_hptes(cpu, ptex, 1);
> > +    v =3D ppc_hash64_hpte0(cpu, hptes, 0);
> > +    r =3D ppc_hash64_hpte1(cpu, hptes, 0);
> > +    ppc_hash64_unmap_hptes(cpu, hptes, ptex, 1);
> > =20
> >      if ((v & HPTE64_V_VALID) =3D=3D 0 ||
> >          ((flags & H_AVPN) && (v & ~0x7fULL) !=3D avpn)) {
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index f99bcae..c89973e 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -223,11 +223,12 @@ enum {
> >  typedef struct opc_handler_t opc_handler_t;
> > =20
> >  /*********************************************************************=
********/
> > -/* Types used to describe some PowerPC registers */
> > +/* Types used to describe some PowerPC registers etc. */
> >  typedef struct DisasContext DisasContext;
> >  typedef struct ppc_spr_t ppc_spr_t;
> >  typedef union ppc_avr_t ppc_avr_t;
> >  typedef union ppc_tlb_t ppc_tlb_t;
> > +typedef struct ppc_hash_pte64 ppc_hash_pte64_t;
> > =20
> >  /* SPR access micro-ops generations callbacks */
> >  struct ppc_spr_t {
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 52bbea5..9d3e57e 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2601,17 +2601,17 @@ struct kvm_get_htab_buf {
> >      /*
> >       * We require one extra byte for read
> >       */
> > -    target_ulong hpte[(HPTES_PER_GROUP * 2) + 1];
> > +    ppc_hash_pte64_t hpte[HPTES_PER_GROUP];
>=20
>=20
> The "one extra byte" (which was ulong) is not needed any more why?

Ah.. good question.  A better one is why was it needed in the first
place, to which I don't have a good answer :/.

>=20
>=20
> >  };
> > =20
> > -uint64_t kvmppc_hash64_read_pteg(PowerPCCPU *cpu, target_ulong pte_ind=
ex)
> > +const ppc_hash_pte64_t *kvmppc_map_hptes(hwaddr ptex, int n)
>=20
>=20
> This "int n" is ignored here by a reason?

Uh.. only by reason that I forgot to get around to handling that
properly.  Actually.. I rather suspect there are several things broken
with this function in any case (and equally it's predecessor) - I
think it will return bogus things if there are any invalid HPTEs in
the region read.

I think we're getting away with it because this interface is never
actually used: if we have KVM then we don't ever enter the MMU code
paths that could call this.  I should probably just change the KVM
mode hooks to abort()s.
>=20
>=20
> >  {
> >      int htab_fd;
> >      struct kvm_get_htab_fd ghf;
> > -    struct kvm_get_htab_buf  *hpte_buf;
> > +    struct kvm_get_htab_buf *hpte_buf;
> > =20
> >      ghf.flags =3D 0;
> > -    ghf.start_index =3D pte_index;
> > +    ghf.start_index =3D ptex;
> >      htab_fd =3D kvm_vm_ioctl(kvm_state, KVM_PPC_GET_HTAB_FD, &ghf);
> >      if (htab_fd < 0) {
> >          goto error_out;
> > @@ -2626,7 +2626,7 @@ uint64_t kvmppc_hash64_read_pteg(PowerPCCPU *cpu,=
 target_ulong pte_index)
> >      }
> > =20
> >      close(htab_fd);
> > -    return (uint64_t)(uintptr_t) hpte_buf->hpte;
> > +    return hpte_buf->hpte;
> > =20
> >  out_close:
> >      g_free(hpte_buf);
> > @@ -2635,18 +2635,15 @@ error_out:
> >      return 0;
> >  }
> > =20
> > -void kvmppc_hash64_free_pteg(uint64_t token)
> > +void kvmppc_unmap_hptes(const ppc_hash_pte64_t *hptes, hwaddr ptex, in=
t n)
> >  {
> >      struct kvm_get_htab_buf *htab_buf;
> > =20
> > -    htab_buf =3D container_of((void *)(uintptr_t) token, struct kvm_ge=
t_htab_buf,
> > -                            hpte);
> > +    htab_buf =3D container_of((void *)hptes, struct kvm_get_htab_buf, =
hpte);
> >      g_free(htab_buf);
> > -    return;
> >  }
> > =20
> > -void kvmppc_hash64_write_pte(CPUPPCState *env, target_ulong pte_index,
> > -                             target_ulong pte0, target_ulong pte1)
> > +void kvmppc_hash64_write_pte(hwaddr ptex, uint64_t pte0, uint64_t pte1)
> >  {
> >      int htab_fd;
> >      struct kvm_get_htab_fd ghf;
> > @@ -2661,9 +2658,9 @@ void kvmppc_hash64_write_pte(CPUPPCState *env, ta=
rget_ulong pte_index,
> > =20
> >      hpte_buf.header.n_valid =3D 1;
> >      hpte_buf.header.n_invalid =3D 0;
> > -    hpte_buf.header.index =3D pte_index;
> > -    hpte_buf.hpte[0] =3D pte0;
> > -    hpte_buf.hpte[1] =3D pte1;
> > +    hpte_buf.header.index =3D ptex;
> > +    hpte_buf.hpte[0].pte0 =3D pte0;
> > +    hpte_buf.hpte[0].pte1 =3D pte1;
> >      /*
> >       * Write the hpte entry.
> >       * CAUTION: write() has the warn_unused_result attribute. Hence we
> > diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> > index 8da2ee4..3f8fccd 100644
> > --- a/target/ppc/kvm_ppc.h
> > +++ b/target/ppc/kvm_ppc.h
> > @@ -41,6 +41,10 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uint32=
_t window_size, int *pfd,
> >  int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_size=
);
> >  int kvmppc_reset_htab(int shift_hint);
> >  uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shif=
t);
> > +const ppc_hash_pte64_t *kvmppc_map_hptes(hwaddr ptex, int n);
> > +void kvmppc_unmap_hptes(const ppc_hash_pte64_t *hptes, hwaddr ptex, in=
t n);
> > +
> > +void kvmppc_hash64_write_pte(hwaddr ptex, uint64_t pte0, uint64_t pte1=
);
> >  #endif /* !CONFIG_USER_ONLY */
> >  bool kvmppc_has_cap_epr(void);
> >  int kvmppc_define_rtas_kernel_token(uint32_t token, const char *functi=
on);
> > @@ -49,11 +53,6 @@ int kvmppc_get_htab_fd(bool write);
> >  int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_=
ns);
> >  int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
> >                             uint16_t n_valid, uint16_t n_invalid);
> > -uint64_t kvmppc_hash64_read_pteg(PowerPCCPU *cpu, target_ulong pte_ind=
ex);
> > -void kvmppc_hash64_free_pteg(uint64_t token);
> > -
> > -void kvmppc_hash64_write_pte(CPUPPCState *env, target_ulong pte_index,
> > -                             target_ulong pte0, target_ulong pte1);
> >  bool kvmppc_has_cap_fixup_hcalls(void);
> >  bool kvmppc_has_cap_htm(void);
> >  int kvmppc_enable_hwrng(void);
> > @@ -199,6 +198,22 @@ static inline bool kvmppc_is_mem_backend_page_size=
_ok(char *obj_path)
> >      return true;
> >  }
> > =20
> > +static inline const ppc_hash_pte64_t *kvmppc_map_hptes(hwaddr ptex, in=
t n)
> > +{
> > +    abort();
> > +}
> > +
> > +static inline void kvmppc_unmap_hptes(const ppc_hash_pte64_t *hptes,
> > +                                      hwaddr ptex, int n)
> > +{
> > +    abort();
> > +}
> > +
> > +static inline void kvmppc_hash64_write_pte(hwaddr ptex,
> > +                                           uint64_t pte0, uint64_t pte=
1)
> > +{
> > +    abort();
> > +}
> >  #endif /* !CONFIG_USER_ONLY */
> > =20
> >  static inline bool kvmppc_has_cap_epr(void)
> > @@ -234,24 +249,6 @@ static inline int kvmppc_load_htab_chunk(QEMUFile =
*f, int fd, uint32_t index,
> >      abort();
> >  }
> > =20
> > -static inline uint64_t kvmppc_hash64_read_pteg(PowerPCCPU *cpu,
> > -                                               target_ulong pte_index)
> > -{
> > -    abort();
> > -}
> > -
> > -static inline void kvmppc_hash64_free_pteg(uint64_t token)
> > -{
> > -    abort();
> > -}
> > -
> > -static inline void kvmppc_hash64_write_pte(CPUPPCState *env,
> > -                                           target_ulong pte_index,
> > -                                           target_ulong pte0, target_u=
long pte1)
> > -{
> > -    abort();
> > -}
> > -
> >  static inline bool kvmppc_has_cap_fixup_hcalls(void)
> >  {
> >      abort();
> > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > index 76669ed..c59db47 100644
> > --- a/target/ppc/mmu-hash64.c
> > +++ b/target/ppc/mmu-hash64.c
> > @@ -27,6 +27,7 @@
> >  #include "kvm_ppc.h"
> >  #include "mmu-hash64.h"
> >  #include "exec/log.h"
> > +#include "hw/hw.h"
> > =20
> >  //#define DEBUG_SLB
> > =20
> > @@ -431,33 +432,42 @@ static int ppc_hash64_amr_prot(PowerPCCPU *cpu, p=
pc_hash_pte64_t pte)
> >      return prot;
> >  }
> > =20
> > -uint64_t ppc_hash64_start_access(PowerPCCPU *cpu, target_ulong pte_ind=
ex)
> > +const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,
> > +                                             hwaddr ptex, int n)
> >  {
> > -    uint64_t token =3D 0;
> > -    hwaddr pte_offset;
> > +    const ppc_hash_pte64_t *hptes =3D NULL;
> > +    hwaddr pte_offset =3D ptex * HASH_PTE_SIZE_64;
> > =20
> > -    pte_offset =3D pte_index * HASH_PTE_SIZE_64;
> >      if (cpu->env.external_htab =3D=3D MMU_HASH64_KVM_MANAGED_HPT) {
> >          /*
> >           * HTAB is controlled by KVM. Fetch the PTEG into a new buffer.
> >           */
> > -        token =3D kvmppc_hash64_read_pteg(cpu, pte_index);
> > +        hptes =3D kvmppc_map_hptes(ptex, n);
> >      } else if (cpu->env.external_htab) {
> >          /*
> >           * HTAB is controlled by QEMU. Just point to the internally
> >           * accessible PTEG.
> >           */
> > -        token =3D (uint64_t)(uintptr_t) cpu->env.external_htab + pte_o=
ffset;
> > +        hptes =3D (ppc_hash_pte64_t *)(cpu->env.external_htab + pte_of=
fset);
> >      } else if (cpu->env.htab_base) {
> > -        token =3D cpu->env.htab_base + pte_offset;
> > +        hwaddr plen =3D n * HASH_PTE_SIZE_64;
> > +        hptes =3D address_space_map(CPU(cpu)->as, cpu->env.htab_base +=
 pte_offset,
> > +                                 &plen, false);
> > +        if (plen < (n * HASH_PTE_SIZE_64)) {
> > +            hw_error("%s: Unable to map all requested HPTEs\n", __FUNC=
TION__);
> > +        }
> >      }
> > -    return token;
> > +    return hptes;
> >  }
> > =20
> > -void ppc_hash64_stop_access(PowerPCCPU *cpu, uint64_t token)
> > +void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const ppc_hash_pte64_t *h=
ptes,
> > +                            hwaddr ptex, int n)
> >  {
> >      if (cpu->env.external_htab =3D=3D MMU_HASH64_KVM_MANAGED_HPT) {
> > -        kvmppc_hash64_free_pteg(token);
> > +        kvmppc_unmap_hptes(hptes, ptex, n);
> > +    } else if (!cpu->env.external_htab) {
> > +        address_space_unmap(CPU(cpu)->as, (void *)hptes, n * HASH_PTE_=
SIZE_64,
> > +                            false, n * HASH_PTE_SIZE_64);
> >      }
> >  }
> > =20
> > @@ -505,18 +515,18 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *=
cpu, hwaddr hash,
> >  {
> >      CPUPPCState *env =3D &cpu->env;
> >      int i;
> > -    uint64_t token;
> > +    const ppc_hash_pte64_t *pteg;
> >      target_ulong pte0, pte1;
> > -    target_ulong pte_index;
> > +    target_ulong ptex;
> > =20
> > -    pte_index =3D (hash & env->htab_mask) * HPTES_PER_GROUP;
> > -    token =3D ppc_hash64_start_access(cpu, pte_index);
> > -    if (!token) {
> > +    ptex =3D (hash & env->htab_mask) * HPTES_PER_GROUP;
> > +    pteg =3D ppc_hash64_map_hptes(cpu, ptex, HPTES_PER_GROUP);
> > +    if (!pteg) {
> >          return -1;
> >      }
> >      for (i =3D 0; i < HPTES_PER_GROUP; i++) {
> > -        pte0 =3D ppc_hash64_load_hpte0(cpu, token, i);
> > -        pte1 =3D ppc_hash64_load_hpte1(cpu, token, i);
> > +        pte0 =3D ppc_hash64_hpte0(cpu, pteg, i);
> > +        pte1 =3D ppc_hash64_hpte1(cpu, pteg, i);
> > =20
> >          /* This compares V, B, H (secondary) and the AVPN */
> >          if (HPTE64_V_COMPARE(pte0, ptem)) {
> > @@ -536,11 +546,11 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *=
cpu, hwaddr hash,
> >               */
> >              pte->pte0 =3D pte0;
> >              pte->pte1 =3D pte1;
> > -            ppc_hash64_stop_access(cpu, token);
> > -            return (pte_index + i) * HASH_PTE_SIZE_64;
> > +            ppc_hash64_unmap_hptes(cpu, pteg, ptex, HPTES_PER_GROUP);
> > +            return ptex + i;
> >          }
> >      }
> > -    ppc_hash64_stop_access(cpu, token);
> > +    ppc_hash64_unmap_hptes(cpu, pteg, ptex, HPTES_PER_GROUP);
> >      /*
> >       * We didn't find a valid entry.
> >       */
> > @@ -552,8 +562,7 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU *cp=
u,
> >                                       ppc_hash_pte64_t *pte, unsigned *=
pshift)
> >  {
> >      CPUPPCState *env =3D &cpu->env;
> > -    hwaddr pte_offset;
> > -    hwaddr hash;
> > +    hwaddr hash, ptex;
> >      uint64_t vsid, epnmask, epn, ptem;
> >      const struct ppc_one_seg_page_size *sps =3D slb->sps;
> > =20
> > @@ -596,9 +605,9 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU *cp=
u,
> >              " vsid=3D" TARGET_FMT_lx " ptem=3D" TARGET_FMT_lx
> >              " hash=3D" TARGET_FMT_plx "\n",
> >              env->htab_base, env->htab_mask, vsid, ptem,  hash);
> > -    pte_offset =3D ppc_hash64_pteg_search(cpu, hash, sps, ptem, pte, p=
shift);
> > +    ptex =3D ppc_hash64_pteg_search(cpu, hash, sps, ptem, pte, pshift);
> > =20
> > -    if (pte_offset =3D=3D -1) {
> > +    if (ptex =3D=3D -1) {
> >          /* Secondary PTEG lookup */
> >          ptem |=3D HPTE64_V_SECONDARY;
> >          qemu_log_mask(CPU_LOG_MMU,
> > @@ -607,10 +616,10 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU *=
cpu,
> >                  " hash=3D" TARGET_FMT_plx "\n", env->htab_base,
> >                  env->htab_mask, vsid, ptem, ~hash);
> > =20
> > -        pte_offset =3D ppc_hash64_pteg_search(cpu, ~hash, sps, ptem, p=
te, pshift);
> > +        ptex =3D ppc_hash64_pteg_search(cpu, ~hash, sps, ptem, pte, ps=
hift);
> >      }
> > =20
> > -    return pte_offset;
> > +    return ptex;
> >  }
> > =20
> >  unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU *cpu,
> > @@ -708,7 +717,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr eaddr,
> >      CPUPPCState *env =3D &cpu->env;
> >      ppc_slb_t *slb;
> >      unsigned apshift;
> > -    hwaddr pte_offset;
> > +    hwaddr ptex;
> >      ppc_hash_pte64_t pte;
> >      int pp_prot, amr_prot, prot;
> >      uint64_t new_pte1, dsisr;
> > @@ -792,8 +801,8 @@ skip_slb_search:
> >      }
> > =20
> >      /* 4. Locate the PTE in the hash table */
> > -    pte_offset =3D ppc_hash64_htab_lookup(cpu, slb, eaddr, &pte, &apsh=
ift);
> > -    if (pte_offset =3D=3D -1) {
> > +    ptex =3D ppc_hash64_htab_lookup(cpu, slb, eaddr, &pte, &apshift);
> > +    if (ptex =3D=3D -1) {
> >          dsisr =3D 0x40000000;
> >          if (rwx =3D=3D 2) {
> >              ppc_hash64_set_isi(cs, env, dsisr);
> > @@ -806,7 +815,7 @@ skip_slb_search:
> >          return 1;
> >      }
> >      qemu_log_mask(CPU_LOG_MMU,
> > -                "found PTE at offset %08" HWADDR_PRIx "\n", pte_offset=
);
> > +                  "found PTE at index %08" HWADDR_PRIx "\n", ptex);
> > =20
> >      /* 5. Check access permissions */
> > =20
> > @@ -849,8 +858,7 @@ skip_slb_search:
> >      }
> > =20
> >      if (new_pte1 !=3D pte.pte1) {
> > -        ppc_hash64_store_hpte(cpu, pte_offset / HASH_PTE_SIZE_64,
> > -                              pte.pte0, new_pte1);
> > +        ppc_hash64_store_hpte(cpu, ptex, pte.pte0, new_pte1);
> >      }
> > =20
> >      /* 7. Determine the real address from the PTE */
> > @@ -867,7 +875,7 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *c=
pu, target_ulong addr)
> >  {
> >      CPUPPCState *env =3D &cpu->env;
> >      ppc_slb_t *slb;
> > -    hwaddr pte_offset, raddr;
> > +    hwaddr ptex, raddr;
> >      ppc_hash_pte64_t pte;
> >      unsigned apshift;
> > =20
> > @@ -900,8 +908,8 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *c=
pu, target_ulong addr)
> >          }
> >      }
> > =20
> > -    pte_offset =3D ppc_hash64_htab_lookup(cpu, slb, addr, &pte, &apshi=
ft);
> > -    if (pte_offset =3D=3D -1) {
> > +    ptex =3D ppc_hash64_htab_lookup(cpu, slb, addr, &pte, &apshift);
> > +    if (ptex =3D=3D -1) {
> >          return -1;
> >      }
> > =20
> > @@ -909,30 +917,28 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU =
*cpu, target_ulong addr)
> >          & TARGET_PAGE_MASK;
> >  }
> > =20
> > -void ppc_hash64_store_hpte(PowerPCCPU *cpu,
> > -                           target_ulong pte_index,
> > -                           target_ulong pte0, target_ulong pte1)
> > +void ppc_hash64_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
> > +                           uint64_t pte0, uint64_t pte1)
> >  {
> >      CPUPPCState *env =3D &cpu->env;
> > +    hwaddr offset =3D ptex * HASH_PTE_SIZE_64;
> > =20
> >      if (env->external_htab =3D=3D MMU_HASH64_KVM_MANAGED_HPT) {
> > -        kvmppc_hash64_write_pte(env, pte_index, pte0, pte1);
> > +        kvmppc_hash64_write_pte(ptex, pte0, pte1);
> >          return;
> >      }
> > =20
> > -    pte_index *=3D HASH_PTE_SIZE_64;
> >      if (env->external_htab) {
> > -        stq_p(env->external_htab + pte_index, pte0);
> > -        stq_p(env->external_htab + pte_index + HASH_PTE_SIZE_64 / 2, p=
te1);
> > +        stq_p(env->external_htab + offset, pte0);
> > +        stq_p(env->external_htab + offset + HASH_PTE_SIZE_64 / 2, pte1=
);
> >      } else {
> > -        stq_phys(CPU(cpu)->as, env->htab_base + pte_index, pte0);
> > +        stq_phys(CPU(cpu)->as, env->htab_base + offset, pte0);
> >          stq_phys(CPU(cpu)->as,
> > -                 env->htab_base + pte_index + HASH_PTE_SIZE_64 / 2, pt=
e1);
> > +                 env->htab_base + offset + HASH_PTE_SIZE_64 / 2, pte1);
> >      }
> >  }
> > =20
> > -void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu,
> > -                               target_ulong pte_index,
> > +void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, target_ulong ptex,
> >                                 target_ulong pte0, target_ulong pte1)
> >  {
> >      /*
> > diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> > index 7a0b7fc..8637fe4 100644
> > --- a/target/ppc/mmu-hash64.h
> > +++ b/target/ppc/mmu-hash64.h
> > @@ -10,8 +10,8 @@ int ppc_store_slb(PowerPCCPU *cpu, target_ulong slot,
> >  hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong ad=
dr);
> >  int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr address, int rw,
> >                                  int mmu_idx);
> > -void ppc_hash64_store_hpte(PowerPCCPU *cpu, target_ulong index,
> > -                           target_ulong pte0, target_ulong pte1);
> > +void ppc_hash64_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
> > +                           uint64_t pte0, uint64_t pte1);
> >  void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu,
> >                                 target_ulong pte_index,
> >                                 target_ulong pte0, target_ulong pte1);
> > @@ -96,41 +96,27 @@ void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ul=
ong value,
> >  void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, void *hpt, int shift,
> >                                   Error **errp);
> > =20
> > -uint64_t ppc_hash64_start_access(PowerPCCPU *cpu, target_ulong pte_ind=
ex);
> > -void ppc_hash64_stop_access(PowerPCCPU *cpu, uint64_t token);
> > +struct ppc_hash_pte64 {
> > +    uint64_t pte0, pte1;
> > +};
> > +
> > +const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,\
>=20
>=20
> You do not need the trailing '\'.
>=20
>=20
> > +                                             hwaddr ptex, int n);
> > +void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const ppc_hash_pte64_t *h=
ptes,
> > +                            hwaddr ptex, int n);
> > =20
> > -static inline target_ulong ppc_hash64_load_hpte0(PowerPCCPU *cpu,
> > -                                                 uint64_t token, int i=
ndex)
> > +static inline uint64_t ppc_hash64_hpte0(PowerPCCPU *cpu,
> > +                                        const ppc_hash_pte64_t *hptes,=
 int i)
> >  {
> > -    CPUPPCState *env =3D &cpu->env;
> > -    uint64_t addr;
> > -
> > -    addr =3D token + (index * HASH_PTE_SIZE_64);
> > -    if (env->external_htab) {
> > -        return  ldq_p((const void *)(uintptr_t)addr);
> > -    } else {
> > -        return ldq_phys(CPU(cpu)->as, addr);
> > -    }
> > +    return ldq_p(&(hptes[i].pte0));
> >  }
> > =20
> > -static inline target_ulong ppc_hash64_load_hpte1(PowerPCCPU *cpu,
> > -                                                 uint64_t token, int i=
ndex)
> > +static inline uint64_t ppc_hash64_hpte1(PowerPCCPU *cpu,
> > +                                        const ppc_hash_pte64_t *hptes,=
 int i)
> >  {
> > -    CPUPPCState *env =3D &cpu->env;
> > -    uint64_t addr;
> > -
> > -    addr =3D token + (index * HASH_PTE_SIZE_64) + HASH_PTE_SIZE_64/2;
> > -    if (env->external_htab) {
> > -        return  ldq_p((const void *)(uintptr_t)addr);
> > -    } else {
> > -        return ldq_phys(CPU(cpu)->as, addr);
> > -    }
> > +    return ldq_p(&(hptes[i].pte1));
> >  }
> > =20
> > -typedef struct {
> > -    uint64_t pte0, pte1;
> > -} ppc_hash_pte64_t;
> > -
> >  #endif /* CONFIG_USER_ONLY */
> > =20
> >  #endif /* MMU_HASH64_H */
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrnG5AAoJEGw4ysog2bOSyH8P/3bgYpFwHNnyrca3TqV+aJi/
C1HH/E+GvFWFRkfsANyE07FdyjfirMjzdwUv46R66KDAwqxMVhDPmGg88baTWNDC
0PPPSEYf4AHvyJ7ZJaTapqEnyrMyaaetKITvQHxoqk7kwF462joMh6jPba2h7Ys8
pKQXr4H91i6xomn5JVUzsJReyVSnzJpF6ib0jowtm0t/5ZHX/odVbR1rJ4ewsLZv
QldukJ5uTms8IFjUVIIFKc+GKnKeIq26JMwJaG1j7ugllyWXxHpaM2cGDAaBmRST
WYsJGkrDNjzB50+yxpnvxvKQbS/bRFWhkn9HGz8WWNYiet413i0q5vkA/7mv9Noq
S4DCSC62E3lrCgItdLzhD1sWiIIylW2bSIc0WNmghAMdFWmU8YTXqUrtCu9eOCIc
P76+P3za+DBcnbNIAnqpi4lTez57DwLpKvLDpYSPmuuzpQH0Xqq5FlXmR4x8u/R2
ec5EiRmc/cgCzVKOFtBH0E/9dQ4jaq2ukdLsQv6P91PidPPyw58wuUCoZQNA0wCx
+4vAPNVAwJEmyfVik5MTNlv+3UzYxLZapE0Wcra6g3TXGD2cEHPfOxeoMVuPwY9I
mMKAQbkpzdHqtpn1QB5KZ0TX9SgrEnpveAJxW5QcU3tEnrF6gyotSNXZGhQzp/Te
lUNKzFG7XdGGO2PCT2No
=yaWu
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
