Received: from eggs.gnu.org ([2001:4830:134:3::10]:37180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cgm5g-0006Bi-AK
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 00:37:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cgm5c-0004tR-VW
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 00:37:20 -0500
Message-ID: <1487828220.23895.17.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 23 Feb 2017 16:37:00 +1100
In-Reply-To: <20170223020936.29220-5-david@gibson.dropbear.id.au>
References: <20170223020936.29220-1-david@gibson.dropbear.id.au>
	<20170223020936.29220-5-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, aik@ozlabs.ru
Cc: qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, paulus@samba.org

On Thu, 2017-02-23 at 13:09 +1100, David Gibson wrote:
> Accesses to the hashed page table (HPT) are complicated by the fact
> that
> the HPT could be in one of three places:
>    1) Within guest memory - when we're emulating a full guest CPU at
> the
>       hardware level (e.g. powernv, mac99, g3beige)
>    2) Within qemu, but outside guest memory - when we're emulating
> user and
>       supervisor instructions within TCG, but instead of emulating
>       the CPU's hypervisor mode, we just emulate a hypervisor's
> behaviour
>       (pseries in TCG)
>    3) Within KVM - a pseries machine using KVM acceleration.  Mostly
>       accesses to the HPT are handled by KVM, but there are a few
> cases
>       where qemu needs to access it via a special fd for the purpose.

Should you clarify that this is the case for KVM-HV with KVM-PR the
same as (2)?

> 
> In order to batch accesses to the fd in case (3), we use a somewhat
> awkward
> ppc_hash64_start_access() / ppc_hash64_stop_access() pair, which for
> case
> (3) reads / releases a whole PTEG from the kernel.  For cases (1) &
> (2)
> it just returns an address value.  The actual HPTE load helpers then
> need
> to interpret the returned token differently in the 3 cases.
> 
> This patch keeps the same basic structure, but simplfiies the
> details.
> First start_access() / stop_access() are renamed to get_pteg() and
> put_pteg() to make their operation more obvious.  Second, read_pteg()

Here you say they've been renamed to get/put/read_pteg, but in the code
they're called map/unmap_hptes and it looks like map_hptes does both
the get and the read?

> now
> always returns a qemu pointer, which can always be used in the same
> way
> by the load_hpte() helpers.  In case (1) it comes from
> address_space_map()
> in case (2) directly from qemu's HPT buffer and in case (3) from a
> temporary buffer read from the KVM fd.
> 
> While we're at it, make things a bit more consistent in terms of
> types and
> variable names: avoid variables named 'index' (it shadows index(3)
> which
> can lead to confusing results), use 'hwaddr ptex' for HPTE indices
> and
> uint64_t for each of the HPTE words, use ptex throughout the call
> stack
> instead of pte_offset in some places (we still need that at the
> bottom
> layer, but nowhere else).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Other than the commit message:

Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

> ---
>  hw/ppc/spapr_hcall.c    | 36 +++++++++---------
>  target/ppc/cpu.h        |  3 +-
>  target/ppc/kvm.c        | 25 ++++++-------
>  target/ppc/kvm_ppc.h    | 43 ++++++++++------------
>  target/ppc/mmu-hash64.c | 98 ++++++++++++++++++++++++++-------------
> ----------
>  target/ppc/mmu-hash64.h | 46 ++++++++---------------
>  6 files changed, 119 insertions(+), 132 deletions(-)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 3298a14..fd961b5 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -84,7 +84,7 @@ static target_ulong h_enter(PowerPCCPU *cpu,
> sPAPRMachineState *spapr,
>      unsigned apshift;
>      target_ulong raddr;
>      target_ulong slot;
> -    uint64_t token;
> +    const ppc_hash_pte64_t *hptes;
>  
>      apshift = ppc_hash64_hpte_page_shift_noslb(cpu, pteh, ptel);
>      if (!apshift) {
> @@ -123,23 +123,23 @@ static target_ulong h_enter(PowerPCCPU *cpu,
> sPAPRMachineState *spapr,
>      ptex = ptex & ~7ULL;
>  
>      if (likely((flags & H_EXACT) == 0)) {
> -        token = ppc_hash64_start_access(cpu, ptex);
> +        hptes = ppc_hash64_map_hptes(cpu, ptex, HPTES_PER_GROUP);
>          for (slot = 0; slot < 8; slot++) {
> -            if (!(ppc_hash64_load_hpte0(cpu, token, slot) &
> HPTE64_V_VALID)) {
> +            if (!(ppc_hash64_hpte0(cpu, hptes, slot) &
> HPTE64_V_VALID)) {
>                  break;
>              }
>          }
> -        ppc_hash64_stop_access(cpu, token);
> +        ppc_hash64_unmap_hptes(cpu, hptes, ptex, HPTES_PER_GROUP);
>          if (slot == 8) {
>              return H_PTEG_FULL;
>          }
>      } else {
> -        token = ppc_hash64_start_access(cpu, ptex);
> -        if (ppc_hash64_load_hpte0(cpu, token, 0) & HPTE64_V_VALID) {
> -            ppc_hash64_stop_access(cpu, token);
> +        hptes = ppc_hash64_map_hptes(cpu, ptex + slot, 1);
> +        if (ppc_hash64_hpte0(cpu, hptes, 0) & HPTE64_V_VALID) {
> +            ppc_hash64_unmap_hptes(cpu, hptes, ptex + slot, 1);
>              return H_PTEG_FULL;
>          }
> -        ppc_hash64_stop_access(cpu, token);
> +        ppc_hash64_unmap_hptes(cpu, hptes, ptex, 1);
>      }
>  
>      ppc_hash64_store_hpte(cpu, ptex + slot, pteh |
> HPTE64_V_HPTE_DIRTY, ptel);
> @@ -160,17 +160,17 @@ static RemoveResult remove_hpte(PowerPCCPU
> *cpu, target_ulong ptex,
>                                  target_ulong flags,
>                                  target_ulong *vp, target_ulong *rp)
>  {
> -    uint64_t token;
> +    const ppc_hash_pte64_t *hptes;
>      target_ulong v, r;
>  
>      if (!valid_ptex(cpu, ptex)) {
>          return REMOVE_PARM;
>      }
>  
> -    token = ppc_hash64_start_access(cpu, ptex);
> -    v = ppc_hash64_load_hpte0(cpu, token, 0);
> -    r = ppc_hash64_load_hpte1(cpu, token, 0);
> -    ppc_hash64_stop_access(cpu, token);
> +    hptes = ppc_hash64_map_hptes(cpu, ptex, 1);
> +    v = ppc_hash64_hpte0(cpu, hptes, 0);
> +    r = ppc_hash64_hpte1(cpu, hptes, 0);
> +    ppc_hash64_unmap_hptes(cpu, hptes, ptex, 1);
>  
>      if ((v & HPTE64_V_VALID) == 0 ||
>          ((flags & H_AVPN) && (v & ~0x7fULL) != avpn) ||
> @@ -291,17 +291,17 @@ static target_ulong h_protect(PowerPCCPU *cpu,
> sPAPRMachineState *spapr,
>      target_ulong flags = args[0];
>      target_ulong ptex = args[1];
>      target_ulong avpn = args[2];
> -    uint64_t token;
> +    const ppc_hash_pte64_t *hptes;
>      target_ulong v, r;
>  
>      if (!valid_ptex(cpu, ptex)) {
>          return H_PARAMETER;
>      }
>  
> -    token = ppc_hash64_start_access(cpu, ptex);
> -    v = ppc_hash64_load_hpte0(cpu, token, 0);
> -    r = ppc_hash64_load_hpte1(cpu, token, 0);
> -    ppc_hash64_stop_access(cpu, token);
> +    hptes = ppc_hash64_map_hptes(cpu, ptex, 1);
> +    v = ppc_hash64_hpte0(cpu, hptes, 0);
> +    r = ppc_hash64_hpte1(cpu, hptes, 0);
> +    ppc_hash64_unmap_hptes(cpu, hptes, ptex, 1);
>  
>      if ((v & HPTE64_V_VALID) == 0 ||
>          ((flags & H_AVPN) && (v & ~0x7fULL) != avpn)) {
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index f99bcae..c89973e 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -223,11 +223,12 @@ enum {
>  typedef struct opc_handler_t opc_handler_t;
>  
>  /*******************************************************************
> **********/
> -/* Types used to describe some PowerPC registers */
> +/* Types used to describe some PowerPC registers etc. */
>  typedef struct DisasContext DisasContext;
>  typedef struct ppc_spr_t ppc_spr_t;
>  typedef union ppc_avr_t ppc_avr_t;
>  typedef union ppc_tlb_t ppc_tlb_t;
> +typedef struct ppc_hash_pte64 ppc_hash_pte64_t;
>  
>  /* SPR access micro-ops generations callbacks */
>  struct ppc_spr_t {
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 52bbea5..9d3e57e 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2601,17 +2601,17 @@ struct kvm_get_htab_buf {
>      /*
>       * We require one extra byte for read
>       */
> -    target_ulong hpte[(HPTES_PER_GROUP * 2) + 1];
> +    ppc_hash_pte64_t hpte[HPTES_PER_GROUP];
>  };
>  
> -uint64_t kvmppc_hash64_read_pteg(PowerPCCPU *cpu, target_ulong
> pte_index)
> +const ppc_hash_pte64_t *kvmppc_map_hptes(hwaddr ptex, int n)
>  {
>      int htab_fd;
>      struct kvm_get_htab_fd ghf;
> -    struct kvm_get_htab_buf  *hpte_buf;
> +    struct kvm_get_htab_buf *hpte_buf;
>  
>      ghf.flags = 0;
> -    ghf.start_index = pte_index;
> +    ghf.start_index = ptex;
>      htab_fd = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_HTAB_FD, &ghf);
>      if (htab_fd < 0) {
>          goto error_out;
> @@ -2626,7 +2626,7 @@ uint64_t kvmppc_hash64_read_pteg(PowerPCCPU
> *cpu, target_ulong pte_index)
>      }
>  
>      close(htab_fd);
> -    return (uint64_t)(uintptr_t) hpte_buf->hpte;
> +    return hpte_buf->hpte;
>  
>  out_close:
>      g_free(hpte_buf);
> @@ -2635,18 +2635,15 @@ error_out:
>      return 0;
>  }
>  
> -void kvmppc_hash64_free_pteg(uint64_t token)
> +void kvmppc_unmap_hptes(const ppc_hash_pte64_t *hptes, hwaddr ptex,
> int n)
>  {
>      struct kvm_get_htab_buf *htab_buf;
>  
> -    htab_buf = container_of((void *)(uintptr_t) token, struct
> kvm_get_htab_buf,
> -                            hpte);
> +    htab_buf = container_of((void *)hptes, struct kvm_get_htab_buf,
> hpte);
>      g_free(htab_buf);
> -    return;
>  }
>  
> -void kvmppc_hash64_write_pte(CPUPPCState *env, target_ulong
> pte_index,
> -                             target_ulong pte0, target_ulong pte1)
> +void kvmppc_hash64_write_pte(hwaddr ptex, uint64_t pte0, uint64_t
> pte1)
>  {
>      int htab_fd;
>      struct kvm_get_htab_fd ghf;
> @@ -2661,9 +2658,9 @@ void kvmppc_hash64_write_pte(CPUPPCState *env,
> target_ulong pte_index,
>  
>      hpte_buf.header.n_valid = 1;
>      hpte_buf.header.n_invalid = 0;
> -    hpte_buf.header.index = pte_index;
> -    hpte_buf.hpte[0] = pte0;
> -    hpte_buf.hpte[1] = pte1;
> +    hpte_buf.header.index = ptex;
> +    hpte_buf.hpte[0].pte0 = pte0;
> +    hpte_buf.hpte[0].pte1 = pte1;
>      /*
>       * Write the hpte entry.
>       * CAUTION: write() has the warn_unused_result attribute. Hence
> we
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 8da2ee4..3f8fccd 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -41,6 +41,10 @@ void *kvmppc_create_spapr_tce(uint32_t liobn,
> uint32_t window_size, int *pfd,
>  int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t
> window_size);
>  int kvmppc_reset_htab(int shift_hint);
>  uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int
> hash_shift);
> +const ppc_hash_pte64_t *kvmppc_map_hptes(hwaddr ptex, int n);
> +void kvmppc_unmap_hptes(const ppc_hash_pte64_t *hptes, hwaddr ptex,
> int n);
> +
> +void kvmppc_hash64_write_pte(hwaddr ptex, uint64_t pte0, uint64_t
> pte1);
>  #endif /* !CONFIG_USER_ONLY */
>  bool kvmppc_has_cap_epr(void);
>  int kvmppc_define_rtas_kernel_token(uint32_t token, const char
> *function);
> @@ -49,11 +53,6 @@ int kvmppc_get_htab_fd(bool write);
>  int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t
> max_ns);
>  int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
>                             uint16_t n_valid, uint16_t n_invalid);
> -uint64_t kvmppc_hash64_read_pteg(PowerPCCPU *cpu, target_ulong
> pte_index);
> -void kvmppc_hash64_free_pteg(uint64_t token);
> -
> -void kvmppc_hash64_write_pte(CPUPPCState *env, target_ulong
> pte_index,
> -                             target_ulong pte0, target_ulong pte1);
>  bool kvmppc_has_cap_fixup_hcalls(void);
>  bool kvmppc_has_cap_htm(void);
>  int kvmppc_enable_hwrng(void);
> @@ -199,6 +198,22 @@ static inline bool
> kvmppc_is_mem_backend_page_size_ok(char *obj_path)
>      return true;
>  }
>  
> +static inline const ppc_hash_pte64_t *kvmppc_map_hptes(hwaddr ptex,
> int n)
> +{
> +    abort();
> +}
> +
> +static inline void kvmppc_unmap_hptes(const ppc_hash_pte64_t *hptes,
> +                                      hwaddr ptex, int n)
> +{
> +    abort();
> +}
> +
> +static inline void kvmppc_hash64_write_pte(hwaddr ptex,
> +                                           uint64_t pte0, uint64_t
> pte1)
> +{
> +    abort();
> +}
>  #endif /* !CONFIG_USER_ONLY */
>  
>  static inline bool kvmppc_has_cap_epr(void)
> @@ -234,24 +249,6 @@ static inline int
> kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
>      abort();
>  }
>  
> -static inline uint64_t kvmppc_hash64_read_pteg(PowerPCCPU *cpu,
> -                                               target_ulong
> pte_index)
> -{
> -    abort();
> -}
> -
> -static inline void kvmppc_hash64_free_pteg(uint64_t token)
> -{
> -    abort();
> -}
> -
> -static inline void kvmppc_hash64_write_pte(CPUPPCState *env,
> -                                           target_ulong pte_index,
> -                                           target_ulong pte0,
> target_ulong pte1)
> -{
> -    abort();
> -}
> -
>  static inline bool kvmppc_has_cap_fixup_hcalls(void)
>  {
>      abort();
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 76669ed..c59db47 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -27,6 +27,7 @@
>  #include "kvm_ppc.h"
>  #include "mmu-hash64.h"
>  #include "exec/log.h"
> +#include "hw/hw.h"
>  
>  //#define DEBUG_SLB
>  
> @@ -431,33 +432,42 @@ static int ppc_hash64_amr_prot(PowerPCCPU *cpu,
> ppc_hash_pte64_t pte)
>      return prot;
>  }
>  
> -uint64_t ppc_hash64_start_access(PowerPCCPU *cpu, target_ulong
> pte_index)
> +const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,
> +                                             hwaddr ptex, int n)
>  {
> -    uint64_t token = 0;
> -    hwaddr pte_offset;
> +    const ppc_hash_pte64_t *hptes = NULL;
> +    hwaddr pte_offset = ptex * HASH_PTE_SIZE_64;
>  
> -    pte_offset = pte_index * HASH_PTE_SIZE_64;
>      if (cpu->env.external_htab == MMU_HASH64_KVM_MANAGED_HPT) {
>          /*
>           * HTAB is controlled by KVM. Fetch the PTEG into a new
> buffer.
>           */
> -        token = kvmppc_hash64_read_pteg(cpu, pte_index);
> +        hptes = kvmppc_map_hptes(ptex, n);
>      } else if (cpu->env.external_htab) {
>          /*
>           * HTAB is controlled by QEMU. Just point to the internally
>           * accessible PTEG.
>           */
> -        token = (uint64_t)(uintptr_t) cpu->env.external_htab +
> pte_offset;
> +        hptes = (ppc_hash_pte64_t *)(cpu->env.external_htab +
> pte_offset);
>      } else if (cpu->env.htab_base) {
> -        token = cpu->env.htab_base + pte_offset;
> +        hwaddr plen = n * HASH_PTE_SIZE_64;
> +        hptes = address_space_map(CPU(cpu)->as, cpu->env.htab_base +
> pte_offset,
> +                                 &plen, false);
> +        if (plen < (n * HASH_PTE_SIZE_64)) {
> +            hw_error("%s: Unable to map all requested HPTEs\n",
> __FUNCTION__);
> +        }
>      }
> -    return token;
> +    return hptes;
>  }
>  
> -void ppc_hash64_stop_access(PowerPCCPU *cpu, uint64_t token)
> +void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const ppc_hash_pte64_t
> *hptes,
> +                            hwaddr ptex, int n)
>  {
>      if (cpu->env.external_htab == MMU_HASH64_KVM_MANAGED_HPT) {
> -        kvmppc_hash64_free_pteg(token);
> +        kvmppc_unmap_hptes(hptes, ptex, n);
> +    } else if (!cpu->env.external_htab) {
> +        address_space_unmap(CPU(cpu)->as, (void *)hptes, n *
> HASH_PTE_SIZE_64,
> +                            false, n * HASH_PTE_SIZE_64);
>      }
>  }
>  
> @@ -505,18 +515,18 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU
> *cpu, hwaddr hash,
>  {
>      CPUPPCState *env = &cpu->env;
>      int i;
> -    uint64_t token;
> +    const ppc_hash_pte64_t *pteg;
>      target_ulong pte0, pte1;
> -    target_ulong pte_index;
> +    target_ulong ptex;
>  
> -    pte_index = (hash & env->htab_mask) * HPTES_PER_GROUP;
> -    token = ppc_hash64_start_access(cpu, pte_index);
> -    if (!token) {
> +    ptex = (hash & env->htab_mask) * HPTES_PER_GROUP;
> +    pteg = ppc_hash64_map_hptes(cpu, ptex, HPTES_PER_GROUP);
> +    if (!pteg) {
>          return -1;
>      }
>      for (i = 0; i < HPTES_PER_GROUP; i++) {
> -        pte0 = ppc_hash64_load_hpte0(cpu, token, i);
> -        pte1 = ppc_hash64_load_hpte1(cpu, token, i);
> +        pte0 = ppc_hash64_hpte0(cpu, pteg, i);
> +        pte1 = ppc_hash64_hpte1(cpu, pteg, i);
>  
>          /* This compares V, B, H (secondary) and the AVPN */
>          if (HPTE64_V_COMPARE(pte0, ptem)) {
> @@ -536,11 +546,11 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU
> *cpu, hwaddr hash,
>               */
>              pte->pte0 = pte0;
>              pte->pte1 = pte1;
> -            ppc_hash64_stop_access(cpu, token);
> -            return (pte_index + i) * HASH_PTE_SIZE_64;
> +            ppc_hash64_unmap_hptes(cpu, pteg, ptex,
> HPTES_PER_GROUP);
> +            return ptex + i;
>          }
>      }
> -    ppc_hash64_stop_access(cpu, token);
> +    ppc_hash64_unmap_hptes(cpu, pteg, ptex, HPTES_PER_GROUP);
>      /*
>       * We didn't find a valid entry.
>       */
> @@ -552,8 +562,7 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU
> *cpu,
>                                       ppc_hash_pte64_t *pte, unsigned
> *pshift)
>  {
>      CPUPPCState *env = &cpu->env;
> -    hwaddr pte_offset;
> -    hwaddr hash;
> +    hwaddr hash, ptex;
>      uint64_t vsid, epnmask, epn, ptem;
>      const struct ppc_one_seg_page_size *sps = slb->sps;
>  
> @@ -596,9 +605,9 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU
> *cpu,
>              " vsid=" TARGET_FMT_lx " ptem=" TARGET_FMT_lx
>              " hash=" TARGET_FMT_plx "\n",
>              env->htab_base, env->htab_mask, vsid, ptem,  hash);
> -    pte_offset = ppc_hash64_pteg_search(cpu, hash, sps, ptem, pte,
> pshift);
> +    ptex = ppc_hash64_pteg_search(cpu, hash, sps, ptem, pte,
> pshift);
>  
> -    if (pte_offset == -1) {
> +    if (ptex == -1) {
>          /* Secondary PTEG lookup */
>          ptem |= HPTE64_V_SECONDARY;
>          qemu_log_mask(CPU_LOG_MMU,
> @@ -607,10 +616,10 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU
> *cpu,
>                  " hash=" TARGET_FMT_plx "\n", env->htab_base,
>                  env->htab_mask, vsid, ptem, ~hash);
>  
> -        pte_offset = ppc_hash64_pteg_search(cpu, ~hash, sps, ptem,
> pte, pshift);
> +        ptex = ppc_hash64_pteg_search(cpu, ~hash, sps, ptem, pte,
> pshift);
>      }
>  
> -    return pte_offset;
> +    return ptex;
>  }
>  
>  unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU *cpu,
> @@ -708,7 +717,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu,
> vaddr eaddr,
>      CPUPPCState *env = &cpu->env;
>      ppc_slb_t *slb;
>      unsigned apshift;
> -    hwaddr pte_offset;
> +    hwaddr ptex;
>      ppc_hash_pte64_t pte;
>      int pp_prot, amr_prot, prot;
>      uint64_t new_pte1, dsisr;
> @@ -792,8 +801,8 @@ skip_slb_search:
>      }
>  
>      /* 4. Locate the PTE in the hash table */
> -    pte_offset = ppc_hash64_htab_lookup(cpu, slb, eaddr, &pte,
> &apshift);
> -    if (pte_offset == -1) {
> +    ptex = ppc_hash64_htab_lookup(cpu, slb, eaddr, &pte, &apshift);
> +    if (ptex == -1) {
>          dsisr = 0x40000000;
>          if (rwx == 2) {
>              ppc_hash64_set_isi(cs, env, dsisr);
> @@ -806,7 +815,7 @@ skip_slb_search:
>          return 1;
>      }
>      qemu_log_mask(CPU_LOG_MMU,
> -                "found PTE at offset %08" HWADDR_PRIx "\n",
> pte_offset);
> +                  "found PTE at index %08" HWADDR_PRIx "\n", ptex);
>  
>      /* 5. Check access permissions */
>  
> @@ -849,8 +858,7 @@ skip_slb_search:
>      }
>  
>      if (new_pte1 != pte.pte1) {
> -        ppc_hash64_store_hpte(cpu, pte_offset / HASH_PTE_SIZE_64,
> -                              pte.pte0, new_pte1);
> +        ppc_hash64_store_hpte(cpu, ptex, pte.pte0, new_pte1);
>      }
>  
>      /* 7. Determine the real address from the PTE */
> @@ -867,7 +875,7 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU
> *cpu, target_ulong addr)
>  {
>      CPUPPCState *env = &cpu->env;
>      ppc_slb_t *slb;
> -    hwaddr pte_offset, raddr;
> +    hwaddr ptex, raddr;
>      ppc_hash_pte64_t pte;
>      unsigned apshift;
>  
> @@ -900,8 +908,8 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU
> *cpu, target_ulong addr)
>          }
>      }
>  
> -    pte_offset = ppc_hash64_htab_lookup(cpu, slb, addr, &pte,
> &apshift);
> -    if (pte_offset == -1) {
> +    ptex = ppc_hash64_htab_lookup(cpu, slb, addr, &pte, &apshift);
> +    if (ptex == -1) {
>          return -1;
>      }
>  
> @@ -909,30 +917,28 @@ hwaddr
> ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong addr)
>          & TARGET_PAGE_MASK;
>  }
>  
> -void ppc_hash64_store_hpte(PowerPCCPU *cpu,
> -                           target_ulong pte_index,
> -                           target_ulong pte0, target_ulong pte1)
> +void ppc_hash64_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
> +                           uint64_t pte0, uint64_t pte1)
>  {
>      CPUPPCState *env = &cpu->env;
> +    hwaddr offset = ptex * HASH_PTE_SIZE_64;
>  
>      if (env->external_htab == MMU_HASH64_KVM_MANAGED_HPT) {
> -        kvmppc_hash64_write_pte(env, pte_index, pte0, pte1);
> +        kvmppc_hash64_write_pte(ptex, pte0, pte1);
>          return;
>      }
>  
> -    pte_index *= HASH_PTE_SIZE_64;
>      if (env->external_htab) {
> -        stq_p(env->external_htab + pte_index, pte0);
> -        stq_p(env->external_htab + pte_index + HASH_PTE_SIZE_64 / 2,
> pte1);
> +        stq_p(env->external_htab + offset, pte0);
> +        stq_p(env->external_htab + offset + HASH_PTE_SIZE_64 / 2,
> pte1);
>      } else {
> -        stq_phys(CPU(cpu)->as, env->htab_base + pte_index, pte0);
> +        stq_phys(CPU(cpu)->as, env->htab_base + offset, pte0);
>          stq_phys(CPU(cpu)->as,
> -                 env->htab_base + pte_index + HASH_PTE_SIZE_64 / 2,
> pte1);
> +                 env->htab_base + offset + HASH_PTE_SIZE_64 / 2,
> pte1);
>      }
>  }
>  
> -void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu,
> -                               target_ulong pte_index,
> +void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, target_ulong ptex,
>                                 target_ulong pte0, target_ulong pte1)
>  {
>      /*
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index 7a0b7fc..8637fe4 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -10,8 +10,8 @@ int ppc_store_slb(PowerPCCPU *cpu, target_ulong
> slot,
>  hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong
> addr);
>  int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr address, int
> rw,
>                                  int mmu_idx);
> -void ppc_hash64_store_hpte(PowerPCCPU *cpu, target_ulong index,
> -                           target_ulong pte0, target_ulong pte1);
> +void ppc_hash64_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
> +                           uint64_t pte0, uint64_t pte1);
>  void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu,
>                                 target_ulong pte_index,
>                                 target_ulong pte0, target_ulong
> pte1);
> @@ -96,41 +96,27 @@ void ppc_hash64_set_sdr1(PowerPCCPU *cpu,
> target_ulong value,
>  void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, void *hpt, int
> shift,
>                                   Error **errp);
>  
> -uint64_t ppc_hash64_start_access(PowerPCCPU *cpu, target_ulong
> pte_index);
> -void ppc_hash64_stop_access(PowerPCCPU *cpu, uint64_t token);
> +struct ppc_hash_pte64 {
> +    uint64_t pte0, pte1;
> +};
> +
> +const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,\
> +                                             hwaddr ptex, int n);
> +void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const ppc_hash_pte64_t
> *hptes,
> +                            hwaddr ptex, int n);
>  
> -static inline target_ulong ppc_hash64_load_hpte0(PowerPCCPU *cpu,
> -                                                 uint64_t token, int
> index)
> +static inline uint64_t ppc_hash64_hpte0(PowerPCCPU *cpu,
> +                                        const ppc_hash_pte64_t
> *hptes, int i)
>  {
> -    CPUPPCState *env = &cpu->env;
> -    uint64_t addr;
> -
> -    addr = token + (index * HASH_PTE_SIZE_64);
> -    if (env->external_htab) {
> -        return  ldq_p((const void *)(uintptr_t)addr);
> -    } else {
> -        return ldq_phys(CPU(cpu)->as, addr);
> -    }
> +    return ldq_p(&(hptes[i].pte0));
>  }
>  
> -static inline target_ulong ppc_hash64_load_hpte1(PowerPCCPU *cpu,
> -                                                 uint64_t token, int
> index)
> +static inline uint64_t ppc_hash64_hpte1(PowerPCCPU *cpu,
> +                                        const ppc_hash_pte64_t
> *hptes, int i)
>  {
> -    CPUPPCState *env = &cpu->env;
> -    uint64_t addr;
> -
> -    addr = token + (index * HASH_PTE_SIZE_64) + HASH_PTE_SIZE_64/2;
> -    if (env->external_htab) {
> -        return  ldq_p((const void *)(uintptr_t)addr);
> -    } else {
> -        return ldq_phys(CPU(cpu)->as, addr);
> -    }
> +    return ldq_p(&(hptes[i].pte1));
>  }
>  
> -typedef struct {
> -    uint64_t pte0, pte1;
> -} ppc_hash_pte64_t;
> -
>  #endif /* CONFIG_USER_ONLY */
>  
>  #endif /* MMU_HASH64_H */
