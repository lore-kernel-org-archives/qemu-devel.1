Received: from eggs.gnu.org ([2001:4830:134:3::10]:45007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9W4E-0000Db-Ep
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9W2F-0004v4-SL
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:57:27 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9W2D-0004tb-4B
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:57:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id e4-v6so20990018wrs.0
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 06:57:20 -0700 (PDT)
References: <20181005211450.847-1-cota@braap.org>
	<20181005211450.847-4-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181005211450.847-4-cota@braap.org>
Date: Mon, 08 Oct 2018 14:57:18 +0100
Message-ID: <8736tgo81t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/4] cputlb: serialize tlb updates with
 env->tlb_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> Currently we rely on atomic operations for cross-CPU invalidations.
> There are two cases that these atomics miss: cross-CPU invalidations
> can race with either (1) vCPU threads flushing their TLB, which
> happens via memset, or (2) vCPUs calling tlb_reset_dirty on their TLB,
> which updates .addr_write with a regular store. This results in
> undefined behaviour, since we're mixing regular and atomic ops
> on concurrent accesses.
>
> Fix it by using tlb_lock, a per-vCPU lock. All updaters of tlb_table
> and the corresponding victim cache now hold the lock.
> The readers that do not hold tlb_lock must use atomic reads when
> reading .addr_write, since this field can be updated by other threads;
> the conversion to atomic reads is done in the next patch.

We don't enforce this for the TCG code - but rely on the backend ISA's
to avoid torn reads from updates from cputlb that could invalidate an
entry.

>
> Note that an alternative fix would be to expand the use of atomic ops.
> However, in the case of TLB flushes this would have a huge performance
> impact, since (1) TLB flushes can happen very frequently and (2) we
> currently use a full memory barrier to flush each TLB entry, and a TLB
> has many entries. Instead, acquiring the lock is barely slower than a
> full memory barrier since it is uncontended, and with a single lock
> acquisition we can flush the entire TLB.
>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/exec/cpu-defs.h |   3 +
>  accel/tcg/cputlb.c      | 152 +++++++++++++++++++++-------------------
>  2 files changed, 84 insertions(+), 71 deletions(-)
>
> diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
> index a171ffc1a4..4ff62f32bf 100644
> --- a/include/exec/cpu-defs.h
> +++ b/include/exec/cpu-defs.h
> @@ -24,6 +24,7 @@
>  #endif
>
>  #include "qemu/host-utils.h"
> +#include "qemu/thread.h"
>  #include "qemu/queue.h"
>  #ifdef CONFIG_TCG
>  #include "tcg-target.h"
> @@ -142,6 +143,8 @@ typedef struct CPUIOTLBEntry {
>
>  #define CPU_COMMON_TLB \
>      /* The meaning of the MMU modes is defined in the target code. */   \
> +    /* tlb_lock serializes updates to tlb_table and tlb_v_table */      \
> +    QemuSpin tlb_lock;                                                  \
>      CPUTLBEntry tlb_table[NB_MMU_MODES][CPU_TLB_SIZE];                  \
>      CPUTLBEntry tlb_v_table[NB_MMU_MODES][CPU_VTLB_SIZE];               \
>      CPUIOTLBEntry iotlb[NB_MMU_MODES][CPU_TLB_SIZE];                    \
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index f6b388c961..2b0ff47fdf 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -75,6 +75,9 @@ QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
>
>  void tlb_init(CPUState *cpu)
>  {
> +    CPUArchState *env =3D cpu->env_ptr;
> +
> +    qemu_spin_init(&env->tlb_lock);
>  }
>
>  /* flush_all_helper: run fn across all cpus
> @@ -129,8 +132,17 @@ static void tlb_flush_nocheck(CPUState *cpu)
>      atomic_set(&env->tlb_flush_count, env->tlb_flush_count + 1);
>      tlb_debug("(count: %zu)\n", tlb_flush_count());
>
> +    /*
> +     * tlb_table/tlb_v_table updates from any thread must hold tlb_lock.
> +     * However, updates from the owner thread (as is the case here; see =
the
> +     * above assert_cpu_is_self) do not need atomic_set because all reads
> +     * that do not hold the lock are performed by the same owner thread.
> +     */
> +    qemu_spin_lock(&env->tlb_lock);
>      memset(env->tlb_table, -1, sizeof(env->tlb_table));
>      memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
> +    qemu_spin_unlock(&env->tlb_lock);
> +
>      cpu_tb_jmp_cache_clear(cpu);
>
>      env->vtlb_index =3D 0;
> @@ -182,6 +194,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *=
cpu, run_on_cpu_data data)
>
>      tlb_debug("start: mmu_idx:0x%04lx\n", mmu_idx_bitmask);
>
> +    qemu_spin_lock(&env->tlb_lock);
>      for (mmu_idx =3D 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
>
>          if (test_bit(mmu_idx, &mmu_idx_bitmask)) {
> @@ -191,6 +204,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *=
cpu, run_on_cpu_data data)
>              memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_tabl=
e[0]));
>          }
>      }
> +    qemu_spin_unlock(&env->tlb_lock);
>
>      cpu_tb_jmp_cache_clear(cpu);
>
> @@ -247,19 +261,24 @@ static inline bool tlb_hit_page_anyprot(CPUTLBEntry=
 *tlb_entry,
>             tlb_hit_page(tlb_entry->addr_code, page);
>  }
>
> -static inline void tlb_flush_entry(CPUTLBEntry *tlb_entry, target_ulong =
page)
> +/* Called with tlb_lock held */
> +static inline void tlb_flush_entry_locked(CPUTLBEntry *tlb_entry,
> +                                          target_ulong page)
>  {
>      if (tlb_hit_page_anyprot(tlb_entry, page)) {
>          memset(tlb_entry, -1, sizeof(*tlb_entry));
>      }
>  }
>
> -static inline void tlb_flush_vtlb_page(CPUArchState *env, int mmu_idx,
> -                                       target_ulong page)
> +/* Called with tlb_lock held */
> +static inline void tlb_flush_vtlb_page_locked(CPUArchState *env, int mmu=
_idx,
> +                                              target_ulong page)
>  {
>      int k;
> +
> +    assert_cpu_is_self(ENV_GET_CPU(env));
>      for (k =3D 0; k < CPU_VTLB_SIZE; k++) {
> -        tlb_flush_entry(&env->tlb_v_table[mmu_idx][k], page);
> +        tlb_flush_entry_locked(&env->tlb_v_table[mmu_idx][k], page);
>      }
>  }
>
> @@ -286,10 +305,12 @@ static void tlb_flush_page_async_work(CPUState *cpu=
, run_on_cpu_data data)
>
>      addr &=3D TARGET_PAGE_MASK;
>      i =3D (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> +    qemu_spin_lock(&env->tlb_lock);
>      for (mmu_idx =3D 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
> -        tlb_flush_entry(&env->tlb_table[mmu_idx][i], addr);
> -        tlb_flush_vtlb_page(env, mmu_idx, addr);
> +        tlb_flush_entry_locked(&env->tlb_table[mmu_idx][i], addr);
> +        tlb_flush_vtlb_page_locked(env, mmu_idx, addr);
>      }
> +    qemu_spin_unlock(&env->tlb_lock);
>
>      tb_flush_jmp_cache(cpu, addr);
>  }
> @@ -326,12 +347,14 @@ static void tlb_flush_page_by_mmuidx_async_work(CPU=
State *cpu,
>      tlb_debug("page:%d addr:"TARGET_FMT_lx" mmu_idx:0x%lx\n",
>                page, addr, mmu_idx_bitmap);
>
> +    qemu_spin_lock(&env->tlb_lock);
>      for (mmu_idx =3D 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
>          if (test_bit(mmu_idx, &mmu_idx_bitmap)) {
> -            tlb_flush_entry(&env->tlb_table[mmu_idx][page], addr);
> -            tlb_flush_vtlb_page(env, mmu_idx, addr);
> +            tlb_flush_entry_locked(&env->tlb_table[mmu_idx][page], addr);
> +            tlb_flush_vtlb_page_locked(env, mmu_idx, addr);
>          }
>      }
> +    qemu_spin_unlock(&env->tlb_lock);
>
>      tb_flush_jmp_cache(cpu, addr);
>  }
> @@ -454,72 +477,41 @@ void tlb_unprotect_code(ram_addr_t ram_addr)
>   * most usual is detecting writes to code regions which may invalidate
>   * generated code.
>   *
> - * Because we want other vCPUs to respond to changes straight away we
> - * update the te->addr_write field atomically. If the TLB entry has
> - * been changed by the vCPU in the mean time we skip the update.
> + * Other vCPUs might be reading their TLBs during guest execution, so we=
 update
> + * te->addr_write with atomic_set. We don't need to worry about this for
> + * oversized guests as MTTCG is disabled for them.
>   *
> - * As this function uses atomic accesses we also need to ensure
> - * updates to tlb_entries follow the same access rules. We don't need
> - * to worry about this for oversized guests as MTTCG is disabled for
> - * them.
> + * Called with tlb_lock held.
>   */
> -
> -static void tlb_reset_dirty_range(CPUTLBEntry *tlb_entry, uintptr_t star=
t,
> -                           uintptr_t length)
> +static void tlb_reset_dirty_range_locked(CPUTLBEntry *tlb_entry,
> +                                         uintptr_t start, uintptr_t leng=
th)
>  {
> -#if TCG_OVERSIZED_GUEST
>      uintptr_t addr =3D tlb_entry->addr_write;
>
>      if ((addr & (TLB_INVALID_MASK | TLB_MMIO | TLB_NOTDIRTY)) =3D=3D 0) {
>          addr &=3D TARGET_PAGE_MASK;
>          addr +=3D tlb_entry->addend;
>          if ((addr - start) < length) {
> +#if TCG_OVERSIZED_GUEST
>              tlb_entry->addr_write |=3D TLB_NOTDIRTY;
> -        }
> -    }
>  #else
> -    /* paired with atomic_mb_set in tlb_set_page_with_attrs */
> -    uintptr_t orig_addr =3D atomic_mb_read(&tlb_entry->addr_write);
> -    uintptr_t addr =3D orig_addr;
> -
> -    if ((addr & (TLB_INVALID_MASK | TLB_MMIO | TLB_NOTDIRTY)) =3D=3D 0) {
> -        addr &=3D TARGET_PAGE_MASK;
> -        addr +=3D atomic_read(&tlb_entry->addend);
> -        if ((addr - start) < length) {
> -            uintptr_t notdirty_addr =3D orig_addr | TLB_NOTDIRTY;
> -            atomic_cmpxchg(&tlb_entry->addr_write, orig_addr, notdirty_a=
ddr);
> +            atomic_set(&tlb_entry->addr_write,
> +                       tlb_entry->addr_write | TLB_NOTDIRTY);
> +#endif
>          }
>      }
> -#endif
>  }
>
> -/* For atomic correctness when running MTTCG we need to use the right
> - * primitives when copying entries */
> -static inline void copy_tlb_helper(CPUTLBEntry *d, CPUTLBEntry *s,
> -                                   bool atomic_set)
> +/* Called with tlb_lock held */
> +static inline void copy_tlb_helper_locked(CPUTLBEntry *d, const CPUTLBEn=
try *s)
>  {
> -#if TCG_OVERSIZED_GUEST
>      *d =3D *s;

In general I'm happy with the patch set but what ensures that this
always DRT with respect to the TCG code reads that race with it?

> -#else
> -    if (atomic_set) {
> -        d->addr_read =3D s->addr_read;
> -        d->addr_code =3D s->addr_code;
> -        atomic_set(&d->addend, atomic_read(&s->addend));
> -        /* Pairs with flag setting in tlb_reset_dirty_range */
> -        atomic_mb_set(&d->addr_write, atomic_read(&s->addr_write));
> -    } else {
> -        d->addr_read =3D s->addr_read;
> -        d->addr_write =3D atomic_read(&s->addr_write);
> -        d->addr_code =3D s->addr_code;
> -        d->addend =3D atomic_read(&s->addend);
> -    }
> -#endif
>  }
>
>  /* This is a cross vCPU call (i.e. another vCPU resetting the flags of
> - * the target vCPU). As such care needs to be taken that we don't
> - * dangerously race with another vCPU update. The only thing actually
> - * updated is the target TLB entry ->addr_write flags.
> + * the target vCPU).
> + * We must take tlb_lock to avoid racing with another vCPU update. The o=
nly
> + * thing actually updated is the target TLB entry ->addr_write flags.
>   */
>  void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
>  {
> @@ -528,22 +520,26 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t star=
t1, ram_addr_t length)
>      int mmu_idx;
>
>      env =3D cpu->env_ptr;
> +    qemu_spin_lock(&env->tlb_lock);
>      for (mmu_idx =3D 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
>          unsigned int i;
>
>          for (i =3D 0; i < CPU_TLB_SIZE; i++) {
> -            tlb_reset_dirty_range(&env->tlb_table[mmu_idx][i],
> -                                  start1, length);
> +            tlb_reset_dirty_range_locked(&env->tlb_table[mmu_idx][i], st=
art1,
> +                                         length);
>          }
>
>          for (i =3D 0; i < CPU_VTLB_SIZE; i++) {
> -            tlb_reset_dirty_range(&env->tlb_v_table[mmu_idx][i],
> -                                  start1, length);
> +            tlb_reset_dirty_range_locked(&env->tlb_v_table[mmu_idx][i], =
start1,
> +                                         length);
>          }
>      }
> +    qemu_spin_unlock(&env->tlb_lock);
>  }
>
> -static inline void tlb_set_dirty1(CPUTLBEntry *tlb_entry, target_ulong v=
addr)
> +/* Called with tlb_lock held */
> +static inline void tlb_set_dirty1_locked(CPUTLBEntry *tlb_entry,
> +                                         target_ulong vaddr)
>  {
>      if (tlb_entry->addr_write =3D=3D (vaddr | TLB_NOTDIRTY)) {
>          tlb_entry->addr_write =3D vaddr;
> @@ -562,16 +558,18 @@ void tlb_set_dirty(CPUState *cpu, target_ulong vadd=
r)
>
>      vaddr &=3D TARGET_PAGE_MASK;
>      i =3D (vaddr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> +    qemu_spin_lock(&env->tlb_lock);
>      for (mmu_idx =3D 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
> -        tlb_set_dirty1(&env->tlb_table[mmu_idx][i], vaddr);
> +        tlb_set_dirty1_locked(&env->tlb_table[mmu_idx][i], vaddr);
>      }
>
>      for (mmu_idx =3D 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
>          int k;
>          for (k =3D 0; k < CPU_VTLB_SIZE; k++) {
> -            tlb_set_dirty1(&env->tlb_v_table[mmu_idx][k], vaddr);
> +            tlb_set_dirty1_locked(&env->tlb_v_table[mmu_idx][k], vaddr);
>          }
>      }
> +    qemu_spin_unlock(&env->tlb_lock);
>  }
>
>  /* Our TLB does not support large pages, so remember the area covered by
> @@ -658,9 +656,6 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ul=
ong vaddr,
>          addend =3D (uintptr_t)memory_region_get_ram_ptr(section->mr) + x=
lat;
>      }
>
> -    /* Make sure there's no cached translation for the new page.  */
> -    tlb_flush_vtlb_page(env, mmu_idx, vaddr_page);
> -
>      code_address =3D address;
>      iotlb =3D memory_region_section_get_iotlb(cpu, section, vaddr_page,
>                                              paddr_page, xlat, prot, &add=
ress);
> @@ -668,6 +663,18 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_u=
long vaddr,
>      index =3D (vaddr_page >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
>      te =3D &env->tlb_table[mmu_idx][index];
>
> +    /*
> +     * Hold the TLB lock for the rest of the function. We could acquire/=
release
> +     * the lock several times in the function, but it is faster to amort=
ize the
> +     * acquisition cost by acquiring it just once. Note that this leads =
to
> +     * a longer critical section, but this is not a concern since the TL=
B lock
> +     * is unlikely to be contended.
> +     */
> +    qemu_spin_lock(&env->tlb_lock);
> +
> +    /* Make sure there's no cached translation for the new page.  */
> +    tlb_flush_vtlb_page_locked(env, mmu_idx, vaddr_page);
> +
>      /*
>       * Only evict the old entry to the victim tlb if it's for a
>       * different page; otherwise just overwrite the stale data.
> @@ -677,7 +684,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ul=
ong vaddr,
>          CPUTLBEntry *tv =3D &env->tlb_v_table[mmu_idx][vidx];
>
>          /* Evict the old entry into the victim tlb.  */
> -        copy_tlb_helper(tv, te, true);
> +        copy_tlb_helper_locked(tv, te);
>          env->iotlb_v[mmu_idx][vidx] =3D env->iotlb[mmu_idx][index];
>      }
>
> @@ -729,9 +736,8 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ul=
ong vaddr,
>          }
>      }
>
> -    /* Pairs with flag setting in tlb_reset_dirty_range */
> -    copy_tlb_helper(te, &tn, true);
> -    /* atomic_mb_set(&te->addr_write, write_address); */
> +    copy_tlb_helper_locked(te, &tn);
> +    qemu_spin_unlock(&env->tlb_lock);
>  }
>
>  /* Add a new TLB entry, but without specifying the memory
> @@ -895,6 +901,8 @@ static bool victim_tlb_hit(CPUArchState *env, size_t =
mmu_idx, size_t index,
>                             size_t elt_ofs, target_ulong page)
>  {
>      size_t vidx;
> +
> +    assert_cpu_is_self(ENV_GET_CPU(env));
>      for (vidx =3D 0; vidx < CPU_VTLB_SIZE; ++vidx) {
>          CPUTLBEntry *vtlb =3D &env->tlb_v_table[mmu_idx][vidx];
>          target_ulong cmp =3D *(target_ulong *)((uintptr_t)vtlb + elt_ofs=
);
> @@ -903,9 +911,11 @@ static bool victim_tlb_hit(CPUArchState *env, size_t=
 mmu_idx, size_t index,
>              /* Found entry in victim tlb, swap tlb and iotlb.  */
>              CPUTLBEntry tmptlb, *tlb =3D &env->tlb_table[mmu_idx][index];
>
> -            copy_tlb_helper(&tmptlb, tlb, false);
> -            copy_tlb_helper(tlb, vtlb, true);
> -            copy_tlb_helper(vtlb, &tmptlb, true);
> +            qemu_spin_lock(&env->tlb_lock);
> +            copy_tlb_helper_locked(&tmptlb, tlb);
> +            copy_tlb_helper_locked(tlb, vtlb);
> +            copy_tlb_helper_locked(vtlb, &tmptlb);
> +            qemu_spin_unlock(&env->tlb_lock);
>
>              CPUIOTLBEntry tmpio, *io =3D &env->iotlb[mmu_idx][index];
>              CPUIOTLBEntry *vio =3D &env->iotlb_v[mmu_idx][vidx];


--
Alex Benn=C3=A9e
