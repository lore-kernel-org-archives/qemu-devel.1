Received: from eggs.gnu.org ([2001:4830:134:3::10]:49099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9tF4-0006wn-5p
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9tEw-0004mJ-Nw
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:44:09 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:33192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9tEv-0004jF-Vq
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:44:02 -0400
Received: by mail-wr1-x431.google.com with SMTP id e4-v6so2150051wrs.0
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 07:44:01 -0700 (PDT)
References: <20181008232756.30704-1-cota@braap.org>
	<20181008232756.30704-2-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181008232756.30704-2-cota@braap.org>
Date: Tue, 09 Oct 2018 15:43:57 +0100
Message-ID: <87in2bmb82.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 1/5] tcg: Add tlb_index and tlb_entry
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> From: Richard Henderson <richard.henderson@linaro.org>
>
> Isolate the computation of an index from an address into a
> helper before we change that function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> [ cota: convert tlb_vaddr_to_host; use atomic_read on addr_write ]
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/softmmu_template.h     | 72 ++++++++++++++++----------------
>  include/exec/cpu_ldst.h          | 19 +++++++--
>  include/exec/cpu_ldst_template.h | 25 +++++------
>  accel/tcg/cputlb.c               | 61 ++++++++++++---------------
>  4 files changed, 92 insertions(+), 85 deletions(-)
>
> diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
> index 1e50263871..aa34c692ee 100644
> --- a/accel/tcg/softmmu_template.h
> +++ b/accel/tcg/softmmu_template.h
> @@ -111,9 +111,10 @@ static inline DATA_TYPE glue(io_read, SUFFIX)(CPUArc=
hState *env,
>  WORD_TYPE helper_le_ld_name(CPUArchState *env, target_ulong addr,
>                              TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    unsigned mmu_idx =3D get_mmuidx(oi);
> -    int index =3D (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> -    target_ulong tlb_addr =3D env->tlb_table[mmu_idx][index].ADDR_READ;
> +    uintptr_t mmu_idx =3D get_mmuidx(oi);
> +    uintptr_t index =3D tlb_index(env, mmu_idx, addr);
> +    CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
> +    target_ulong tlb_addr =3D entry->ADDR_READ;
>      unsigned a_bits =3D get_alignment_bits(get_memop(oi));
>      uintptr_t haddr;
>      DATA_TYPE res;
> @@ -129,7 +130,7 @@ WORD_TYPE helper_le_ld_name(CPUArchState *env, target=
_ulong addr,
>              tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
>                       mmu_idx, retaddr);
>          }
> -        tlb_addr =3D env->tlb_table[mmu_idx][index].ADDR_READ;
> +        tlb_addr =3D entry->ADDR_READ;
>      }

Hmm I can see this clashing with the de-macro clean-up

>
>      /* Handle an IO access.  */
> @@ -166,7 +167,7 @@ WORD_TYPE helper_le_ld_name(CPUArchState *env, target=
_ulong addr,
>          return res;
>      }
>
> -    haddr =3D addr + env->tlb_table[mmu_idx][index].addend;
> +    haddr =3D addr + entry->addend;
>  #if DATA_SIZE =3D=3D 1
>      res =3D glue(glue(ld, LSUFFIX), _p)((uint8_t *)haddr);
>  #else
> @@ -179,9 +180,10 @@ WORD_TYPE helper_le_ld_name(CPUArchState *env, targe=
t_ulong addr,
>  WORD_TYPE helper_be_ld_name(CPUArchState *env, target_ulong addr,
>                              TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    unsigned mmu_idx =3D get_mmuidx(oi);
> -    int index =3D (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> -    target_ulong tlb_addr =3D env->tlb_table[mmu_idx][index].ADDR_READ;
> +    uintptr_t mmu_idx =3D get_mmuidx(oi);
> +    uintptr_t index =3D tlb_index(env, mmu_idx, addr);
> +    CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
> +    target_ulong tlb_addr =3D entry->ADDR_READ;
>      unsigned a_bits =3D get_alignment_bits(get_memop(oi));
>      uintptr_t haddr;
>      DATA_TYPE res;
> @@ -197,7 +199,7 @@ WORD_TYPE helper_be_ld_name(CPUArchState *env, target=
_ulong addr,
>              tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
>                       mmu_idx, retaddr);
>          }
> -        tlb_addr =3D env->tlb_table[mmu_idx][index].ADDR_READ;
> +        tlb_addr =3D entry->ADDR_READ;
>      }
>
>      /* Handle an IO access.  */
> @@ -234,7 +236,7 @@ WORD_TYPE helper_be_ld_name(CPUArchState *env, target=
_ulong addr,
>          return res;
>      }
>
> -    haddr =3D addr + env->tlb_table[mmu_idx][index].addend;
> +    haddr =3D addr + entry->addend;
>      res =3D glue(glue(ld, LSUFFIX), _be_p)((uint8_t *)haddr);
>      return res;
>  }
> @@ -275,10 +277,10 @@ static inline void glue(io_write, SUFFIX)(CPUArchSt=
ate *env,
>  void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE v=
al,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    unsigned mmu_idx =3D get_mmuidx(oi);
> -    int index =3D (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> -    target_ulong tlb_addr =3D
> -        atomic_read(&env->tlb_table[mmu_idx][index].addr_write);
> +    uintptr_t mmu_idx =3D get_mmuidx(oi);
> +    uintptr_t index =3D tlb_index(env, mmu_idx, addr);
> +    CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
> +    target_ulong tlb_addr =3D atomic_read(&entry->addr_write);
>      unsigned a_bits =3D get_alignment_bits(get_memop(oi));
>      uintptr_t haddr;
>
> @@ -293,8 +295,7 @@ void helper_le_st_name(CPUArchState *env, target_ulon=
g addr, DATA_TYPE val,
>              tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
>                       mmu_idx, retaddr);
>          }
> -        tlb_addr =3D atomic_read(&env->tlb_table[mmu_idx][index].addr_wr=
ite) &
> -            ~TLB_INVALID_MASK;
> +        tlb_addr =3D atomic_read(&entry->addr_write) & ~TLB_INVALID_MASK;
>      }
>
>      /* Handle an IO access.  */
> @@ -315,16 +316,16 @@ void helper_le_st_name(CPUArchState *env, target_ul=
ong addr, DATA_TYPE val,
>      if (DATA_SIZE > 1
>          && unlikely((addr & ~TARGET_PAGE_MASK) + DATA_SIZE - 1
>                       >=3D TARGET_PAGE_SIZE)) {
> -        int i, index2;
> -        target_ulong page2, tlb_addr2;
> +        int i;
> +        target_ulong page2;
> +        CPUTLBEntry *entry2;
>      do_unaligned_access:
>          /* Ensure the second page is in the TLB.  Note that the first pa=
ge
>             is already guaranteed to be filled, and that the second page
>             cannot evict the first.  */
>          page2 =3D (addr + DATA_SIZE) & TARGET_PAGE_MASK;
> -        index2 =3D (page2 >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> -        tlb_addr2 =3D atomic_read(&env->tlb_table[mmu_idx][index2].addr_=
write);
> -        if (!tlb_hit_page(tlb_addr2, page2)
> +        entry2 =3D tlb_entry(env, mmu_idx, page2);
> +        if (!tlb_hit_page(atomic_read(&entry2->addr_write), page2)
>              && !VICTIM_TLB_HIT(addr_write, page2)) {
>              tlb_fill(ENV_GET_CPU(env), page2, DATA_SIZE, MMU_DATA_STORE,
>                       mmu_idx, retaddr);
> @@ -342,7 +343,7 @@ void helper_le_st_name(CPUArchState *env, target_ulon=
g addr, DATA_TYPE val,
>          return;
>      }
>
> -    haddr =3D addr + env->tlb_table[mmu_idx][index].addend;
> +    haddr =3D addr + entry->addend;
>  #if DATA_SIZE =3D=3D 1
>      glue(glue(st, SUFFIX), _p)((uint8_t *)haddr, val);
>  #else
> @@ -354,10 +355,10 @@ void helper_le_st_name(CPUArchState *env, target_ul=
ong addr, DATA_TYPE val,
>  void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE v=
al,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    unsigned mmu_idx =3D get_mmuidx(oi);
> -    int index =3D (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> -    target_ulong tlb_addr =3D
> -        atomic_read(&env->tlb_table[mmu_idx][index].addr_write);
> +    uintptr_t mmu_idx =3D get_mmuidx(oi);
> +    uintptr_t index =3D tlb_index(env, mmu_idx, addr);
> +    CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
> +    target_ulong tlb_addr =3D atomic_read(&entry->addr_write);
>      unsigned a_bits =3D get_alignment_bits(get_memop(oi));
>      uintptr_t haddr;
>
> @@ -372,8 +373,7 @@ void helper_be_st_name(CPUArchState *env, target_ulon=
g addr, DATA_TYPE val,
>              tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
>                       mmu_idx, retaddr);
>          }
> -        tlb_addr =3D atomic_read(&env->tlb_table[mmu_idx][index].addr_wr=
ite) &
> -            ~TLB_INVALID_MASK;
> +        tlb_addr =3D atomic_read(&entry->addr_write) & ~TLB_INVALID_MASK;
>      }
>
>      /* Handle an IO access.  */
> @@ -385,8 +385,8 @@ void helper_be_st_name(CPUArchState *env, target_ulon=
g addr, DATA_TYPE val,
>          /* ??? Note that the io helpers always read data in the target
>             byte ordering.  We should push the LE/BE request down into io=
.  */
>          val =3D TGT_BE(val);
> -        glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr, retaddr,
> -                               tlb_addr & TLB_RECHECK);
> +        glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr,
> +                               retaddr, tlb_addr & TLB_RECHECK);

This is a nop formatting change.

>          return;
>      }
>
> @@ -394,16 +394,16 @@ void helper_be_st_name(CPUArchState *env, target_ul=
ong addr, DATA_TYPE val,
>      if (DATA_SIZE > 1
>          && unlikely((addr & ~TARGET_PAGE_MASK) + DATA_SIZE - 1
>                       >=3D TARGET_PAGE_SIZE)) {
> -        int i, index2;
> -        target_ulong page2, tlb_addr2;
> +        int i;
> +        target_ulong page2;
> +        CPUTLBEntry *entry2;
>      do_unaligned_access:
>          /* Ensure the second page is in the TLB.  Note that the first pa=
ge
>             is already guaranteed to be filled, and that the second page
>             cannot evict the first.  */
>          page2 =3D (addr + DATA_SIZE) & TARGET_PAGE_MASK;
> -        index2 =3D (page2 >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> -        tlb_addr2 =3D atomic_read(&env->tlb_table[mmu_idx][index2].addr_=
write);
> -        if (!tlb_hit_page(tlb_addr2, page2)
> +        entry2 =3D tlb_entry(env, mmu_idx, page2);
> +        if (!tlb_hit_page(atomic_read(&entry2->addr_write), page2)
>              && !VICTIM_TLB_HIT(addr_write, page2)) {
>              tlb_fill(ENV_GET_CPU(env), page2, DATA_SIZE, MMU_DATA_STORE,
>                       mmu_idx, retaddr);
> @@ -421,7 +421,7 @@ void helper_be_st_name(CPUArchState *env, target_ulon=
g addr, DATA_TYPE val,
>          return;
>      }
>
> -    haddr =3D addr + env->tlb_table[mmu_idx][index].addend;
> +    haddr =3D addr + entry->addend;
>      glue(glue(st, SUFFIX), _be_p)((uint8_t *)haddr, val);
>  }
>  #endif /* DATA_SIZE > 1 */
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 9581587ce1..e3d8d738aa 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -126,6 +126,20 @@ extern __thread uintptr_t helper_retaddr;
>  /* The memory helpers for tcg-generated code need tcg_target_long etc.  =
*/
>  #include "tcg.h"
>
> +/* Find the TLB index corresponding to the mmu_idx + address pair.  */
> +static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
> +                                  target_ulong addr)
> +{
> +    return (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> +}
> +
> +/* Find the TLB entry corresponding to the mmu_idx + address pair.  */
> +static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_id=
x,
> +                                     target_ulong addr)
> +{
> +    return &env->tlb_table[mmu_idx][tlb_index(env, mmu_idx, addr)];
> +}
> +
>  #ifdef MMU_MODE0_SUFFIX
>  #define CPU_MMU_INDEX 0
>  #define MEMSUFFIX MMU_MODE0_SUFFIX
> @@ -416,8 +430,7 @@ static inline void *tlb_vaddr_to_host(CPUArchState *e=
nv, abi_ptr addr,
>  #if defined(CONFIG_USER_ONLY)
>      return g2h(addr);
>  #else
> -    int index =3D (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> -    CPUTLBEntry *tlbentry =3D &env->tlb_table[mmu_idx][index];
> +    CPUTLBEntry *tlbentry =3D tlb_entry(env, mmu_idx, addr);
>      abi_ptr tlb_addr;
>      uintptr_t haddr;
>
> @@ -445,7 +458,7 @@ static inline void *tlb_vaddr_to_host(CPUArchState *e=
nv, abi_ptr addr,
>          return NULL;
>      }
>
> -    haddr =3D addr + env->tlb_table[mmu_idx][index].addend;
> +    haddr =3D addr + tlbentry->addend;
>      return (void *)haddr;
>  #endif /* defined(CONFIG_USER_ONLY) */
>  }
> diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_tem=
plate.h
> index ba7a11123c..924713eeed 100644
> --- a/include/exec/cpu_ldst_template.h
> +++ b/include/exec/cpu_ldst_template.h
> @@ -81,7 +81,7 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUAr=
chState *env,
>                                                    target_ulong ptr,
>                                                    uintptr_t retaddr)
>  {
> -    int page_index;
> +    CPUTLBEntry *entry;
>      RES_TYPE res;
>      target_ulong addr;
>      int mmu_idx;
> @@ -94,15 +94,15 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPU=
ArchState *env,
>  #endif
>
>      addr =3D ptr;
> -    page_index =3D (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
>      mmu_idx =3D CPU_MMU_INDEX;
> -    if (unlikely(env->tlb_table[mmu_idx][page_index].ADDR_READ !=3D
> +    entry =3D tlb_entry(env, mmu_idx, addr);
> +    if (unlikely(entry->ADDR_READ !=3D
>                   (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
>          oi =3D make_memop_idx(SHIFT, mmu_idx);
>          res =3D glue(glue(helper_ret_ld, URETSUFFIX), MMUSUFFIX)(env, ad=
dr,
>                                                              oi, retaddr);
>      } else {
> -        uintptr_t hostaddr =3D addr + env->tlb_table[mmu_idx][page_index=
].addend;
> +        uintptr_t hostaddr =3D addr + entry->addend;
>          res =3D glue(glue(ld, USUFFIX), _p)((uint8_t *)hostaddr);
>      }
>      return res;
> @@ -120,7 +120,8 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPU=
ArchState *env,
>                                                    target_ulong ptr,
>                                                    uintptr_t retaddr)
>  {
> -    int res, page_index;
> +    CPUTLBEntry *entry;
> +    int res;
>      target_ulong addr;
>      int mmu_idx;
>      TCGMemOpIdx oi;
> @@ -132,15 +133,15 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(C=
PUArchState *env,
>  #endif
>
>      addr =3D ptr;
> -    page_index =3D (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
>      mmu_idx =3D CPU_MMU_INDEX;
> -    if (unlikely(env->tlb_table[mmu_idx][page_index].ADDR_READ !=3D
> +    entry =3D tlb_entry(env, mmu_idx, addr);
> +    if (unlikely(entry->ADDR_READ !=3D
>                   (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
>          oi =3D make_memop_idx(SHIFT, mmu_idx);
>          res =3D (DATA_STYPE)glue(glue(helper_ret_ld, SRETSUFFIX),
>                                 MMUSUFFIX)(env, addr, oi, retaddr);
>      } else {
> -        uintptr_t hostaddr =3D addr + env->tlb_table[mmu_idx][page_index=
].addend;
> +        uintptr_t hostaddr =3D addr + entry->addend;
>          res =3D glue(glue(lds, SUFFIX), _p)((uint8_t *)hostaddr);
>      }
>      return res;
> @@ -162,7 +163,7 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUA=
rchState *env,
>                                                   target_ulong ptr,
>                                                   RES_TYPE v, uintptr_t r=
etaddr)
>  {
> -    int page_index;
> +    CPUTLBEntry *entry;
>      target_ulong addr;
>      int mmu_idx;
>      TCGMemOpIdx oi;
> @@ -174,15 +175,15 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CP=
UArchState *env,
>  #endif
>
>      addr =3D ptr;
> -    page_index =3D (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
>      mmu_idx =3D CPU_MMU_INDEX;
> -    if (unlikely(atomic_read(&env->tlb_table[mmu_idx][page_index].addr_w=
rite) !=3D
> +    entry =3D tlb_entry(env, mmu_idx, addr);
> +    if (unlikely(atomic_read(&entry->addr_write) !=3D
>                   (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
>          oi =3D make_memop_idx(SHIFT, mmu_idx);
>          glue(glue(helper_ret_st, SUFFIX), MMUSUFFIX)(env, addr, v, oi,
>                                                       retaddr);
>      } else {
> -        uintptr_t hostaddr =3D addr + env->tlb_table[mmu_idx][page_index=
].addend;
> +        uintptr_t hostaddr =3D addr + entry->addend;
>          glue(glue(st, SUFFIX), _p)((uint8_t *)hostaddr, v);
>      }
>  }
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 200444142a..a5972773de 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -286,7 +286,6 @@ static void tlb_flush_page_async_work(CPUState *cpu, =
run_on_cpu_data data)
>  {
>      CPUArchState *env =3D cpu->env_ptr;
>      target_ulong addr =3D (target_ulong) data.target_ptr;
> -    int i;
>      int mmu_idx;
>
>      assert_cpu_is_self(cpu);
> @@ -304,10 +303,9 @@ static void tlb_flush_page_async_work(CPUState *cpu,=
 run_on_cpu_data data)
>      }
>
>      addr &=3D TARGET_PAGE_MASK;
> -    i =3D (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
>      qemu_spin_lock(&env->tlb_lock);
>      for (mmu_idx =3D 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
> -        tlb_flush_entry_locked(&env->tlb_table[mmu_idx][i], addr);
> +        tlb_flush_entry_locked(tlb_entry(env, mmu_idx, addr), addr);
>          tlb_flush_vtlb_page_locked(env, mmu_idx, addr);
>      }
>      qemu_spin_unlock(&env->tlb_lock);
> @@ -339,18 +337,17 @@ static void tlb_flush_page_by_mmuidx_async_work(CPU=
State *cpu,
>      target_ulong addr_and_mmuidx =3D (target_ulong) data.target_ptr;
>      target_ulong addr =3D addr_and_mmuidx & TARGET_PAGE_MASK;
>      unsigned long mmu_idx_bitmap =3D addr_and_mmuidx & ALL_MMUIDX_BITS;
> -    int page =3D (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
>      int mmu_idx;
>
>      assert_cpu_is_self(cpu);
>
> -    tlb_debug("page:%d addr:"TARGET_FMT_lx" mmu_idx:0x%lx\n",
> -              page, addr, mmu_idx_bitmap);
> +    tlb_debug("flush page addr:"TARGET_FMT_lx" mmu_idx:0x%lx\n",
> +              addr, mmu_idx_bitmap);
>
>      qemu_spin_lock(&env->tlb_lock);
>      for (mmu_idx =3D 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
>          if (test_bit(mmu_idx, &mmu_idx_bitmap)) {
> -            tlb_flush_entry_locked(&env->tlb_table[mmu_idx][page], addr);
> +            tlb_flush_entry_locked(tlb_entry(env, mmu_idx, addr), addr);
>              tlb_flush_vtlb_page_locked(env, mmu_idx, addr);
>          }
>      }
> @@ -554,16 +551,14 @@ static inline void tlb_set_dirty1_locked(CPUTLBEntr=
y *tlb_entry,
>  void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
>  {
>      CPUArchState *env =3D cpu->env_ptr;
> -    int i;
>      int mmu_idx;
>
>      assert_cpu_is_self(cpu);
>
>      vaddr &=3D TARGET_PAGE_MASK;
> -    i =3D (vaddr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
>      qemu_spin_lock(&env->tlb_lock);
>      for (mmu_idx =3D 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
> -        tlb_set_dirty1_locked(&env->tlb_table[mmu_idx][i], vaddr);
> +        tlb_set_dirty1_locked(tlb_entry(env, mmu_idx, vaddr), vaddr);
>      }
>
>      for (mmu_idx =3D 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
> @@ -663,8 +658,8 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ul=
ong vaddr,
>      iotlb =3D memory_region_section_get_iotlb(cpu, section, vaddr_page,
>                                              paddr_page, xlat, prot, &add=
ress);
>
> -    index =3D (vaddr_page >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> -    te =3D &env->tlb_table[mmu_idx][index];
> +    index =3D tlb_index(env, mmu_idx, vaddr_page);
> +    te =3D tlb_entry(env, mmu_idx, vaddr_page);
>
>      /*
>       * Hold the TLB lock for the rest of the function. We could acquire/=
release
> @@ -786,16 +781,16 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTL=
BEntry *iotlbentry,
>           * repeat the MMU check here. This tlb_fill() call might
>           * longjump out if this access should cause a guest exception.
>           */
> -        int index;
> +        CPUTLBEntry *entry;
>          target_ulong tlb_addr;
>
>          tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
>
> -        index =3D (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> -        tlb_addr =3D env->tlb_table[mmu_idx][index].addr_read;
> +        entry =3D tlb_entry(env, mmu_idx, addr);
> +        tlb_addr =3D entry->addr_read;
>          if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
>              /* RAM access */
> -            uintptr_t haddr =3D addr + env->tlb_table[mmu_idx][index].ad=
dend;
> +            uintptr_t haddr =3D addr + entry->addend;
>
>              return ldn_p((void *)haddr, size);
>          }
> @@ -853,16 +848,16 @@ static void io_writex(CPUArchState *env, CPUIOTLBEn=
try *iotlbentry,
>           * repeat the MMU check here. This tlb_fill() call might
>           * longjump out if this access should cause a guest exception.
>           */
> -        int index;
> +        CPUTLBEntry *entry;
>          target_ulong tlb_addr;
>
>          tlb_fill(cpu, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
>
> -        index =3D (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> -        tlb_addr =3D atomic_read(&env->tlb_table[mmu_idx][index].addr_wr=
ite);
> +        entry =3D tlb_entry(env, mmu_idx, addr);
> +        tlb_addr =3D atomic_read(&entry->addr_write);
>          if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
>              /* RAM access */
> -            uintptr_t haddr =3D addr + env->tlb_table[mmu_idx][index].ad=
dend;
> +            uintptr_t haddr =3D addr + entry->addend;
>
>              stn_p((void *)haddr, size, val);
>              return;
> @@ -943,20 +938,19 @@ static bool victim_tlb_hit(CPUArchState *env, size_=
t mmu_idx, size_t index,
>   */
>  tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
>  {
> -    int mmu_idx, index;
> +    uintptr_t mmu_idx =3D cpu_mmu_index(env, true);
> +    uintptr_t index =3D tlb_index(env, mmu_idx, addr);
> +    CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
>      void *p;
>
> -    index =3D (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> -    mmu_idx =3D cpu_mmu_index(env, true);
> -    if (unlikely(!tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr=
))) {
> +    if (unlikely(!tlb_hit(entry->addr_code, addr))) {
>          if (!VICTIM_TLB_HIT(addr_code, addr)) {
>              tlb_fill(ENV_GET_CPU(env), addr, 0, MMU_INST_FETCH, mmu_idx,=
 0);
>          }
> -        assert(tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr));
> +        assert(tlb_hit(entry->addr_code, addr));
>      }
>
> -    if (unlikely(env->tlb_table[mmu_idx][index].addr_code &
> -                 (TLB_RECHECK | TLB_MMIO))) {
> +    if (unlikely(entry->addr_code & (TLB_RECHECK | TLB_MMIO))) {
>          /*
>           * Return -1 if we can't translate and execute from an entire
>           * page of RAM here, which will cause us to execute by loading
> @@ -968,7 +962,7 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, =
target_ulong addr)
>          return -1;
>      }
>
> -    p =3D (void *)((uintptr_t)addr + env->tlb_table[mmu_idx][index].adde=
nd);
> +    p =3D (void *)((uintptr_t)addr + entry->addend);
>      return qemu_ram_addr_from_host_nofail(p);
>  }
>
> @@ -981,11 +975,10 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env=
, target_ulong addr)
>  void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu=
_idx,
>                   uintptr_t retaddr)
>  {
> -    int index =3D (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> -    target_ulong tlb_addr =3D
> -        atomic_read(&env->tlb_table[mmu_idx][index].addr_write);
> +    uintptr_t index =3D tlb_index(env, mmu_idx, addr);
> +    CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
>
> -    if (!tlb_hit(tlb_addr, addr)) {
> +    if (!tlb_hit(atomic_read(&entry->addr_write), addr)) {
>          /* TLB entry is for a different page */
>          if (!VICTIM_TLB_HIT(addr_write, addr)) {
>              tlb_fill(ENV_GET_CPU(env), addr, size, MMU_DATA_STORE,
> @@ -1001,8 +994,8 @@ static void *atomic_mmu_lookup(CPUArchState *env, ta=
rget_ulong addr,
>                                 NotDirtyInfo *ndi)
>  {
>      size_t mmu_idx =3D get_mmuidx(oi);
> -    size_t index =3D (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> -    CPUTLBEntry *tlbe =3D &env->tlb_table[mmu_idx][index];
> +    uintptr_t index =3D tlb_index(env, mmu_idx, addr);
> +    CPUTLBEntry *tlbe =3D tlb_entry(env, mmu_idx, addr);
>      target_ulong tlb_addr =3D atomic_read(&tlbe->addr_write);
>      TCGMemOp mop =3D get_memop(oi);
>      int a_bits =3D get_alignment_bits(mop);

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
