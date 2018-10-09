Received: from eggs.gnu.org ([2001:4830:134:3::10]:50385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9tIP-0000aH-K6
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9tIM-0002Qp-9W
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:47:37 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9tII-0002Kf-6J
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:47:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id x12-v6so2131302wru.8
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 07:47:28 -0700 (PDT)
References: <20181008232756.30704-1-cota@braap.org>
	<20181008232756.30704-5-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181008232756.30704-5-cota@braap.org>
Date: Tue, 09 Oct 2018 15:47:26 +0100
Message-ID: <87efczmb29.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 4/5] cputlb: track TLB use rate
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

> This paves the way for implementing a dynamically-sized softmmu.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/cpu-defs.h |  5 +++++
>  accel/tcg/cputlb.c      | 17 ++++++++++++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
> index 87cd015f60..56f1887c7f 100644
> --- a/include/exec/cpu-defs.h
> +++ b/include/exec/cpu-defs.h
> @@ -141,10 +141,15 @@ typedef struct CPUIOTLBEntry {
>      MemTxAttrs attrs;
>  } CPUIOTLBEntry;
>
> +typedef struct CPUTLBDesc {
> +    size_t n_used_entries;
> +} CPUTLBDesc;
> +
>  #define CPU_COMMON_TLB  \
>      /* The meaning of the MMU modes is defined in the target code. */   \
>      /* tlb_lock serializes updates to tlb_mask, tlb_table and tlb_v_tabl=
e */ \
>      QemuSpin tlb_lock;                                                  \
> +    CPUTLBDesc tlb_desc[NB_MMU_MODES];                                  \
>      /* tlb_mask[i] contains (n_entries - 1) << CPU_TLB_ENTRY_BITS */    \
>      uintptr_t tlb_mask[NB_MMU_MODES];                                   \
>      CPUTLBEntry *tlb_table[NB_MMU_MODES];                               \
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 4dc47e603c..11d6060eb0 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -82,6 +82,7 @@ void tlb_init(CPUState *cpu)
>      for (i =3D 0; i < NB_MMU_MODES; i++) {
>          size_t n_entries =3D CPU_TLB_SIZE;
>
> +        env->tlb_desc[i].n_used_entries =3D 0;
>          env->tlb_mask[i] =3D (n_entries - 1) << CPU_TLB_ENTRY_BITS;
>          env->tlb_table[i] =3D g_new(CPUTLBEntry, n_entries);
>          env->iotlb[i] =3D g_new0(CPUIOTLBEntry, n_entries);
> @@ -150,6 +151,7 @@ static void tlb_flush_nocheck(CPUState *cpu)
>      qemu_spin_lock(&env->tlb_lock);
>      for (i =3D 0; i < NB_MMU_MODES; i++) {
>          memset(env->tlb_table[i], -1, sizeof_tlb(env, i));
> +        env->tlb_desc[i].n_used_entries =3D 0;
>      }
>      memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
>      qemu_spin_unlock(&env->tlb_lock);
> @@ -213,6 +215,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *=
cpu, run_on_cpu_data data)
>
>              memset(env->tlb_table[mmu_idx], -1, sizeof_tlb(env, mmu_idx)=
);
>              memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_tabl=
e[0]));
> +            env->tlb_desc[mmu_idx].n_used_entries =3D 0;
>          }
>      }
>      qemu_spin_unlock(&env->tlb_lock);
> @@ -273,12 +276,14 @@ static inline bool tlb_hit_page_anyprot(CPUTLBEntry=
 *tlb_entry,
>  }
>
>  /* Called with tlb_lock held */
> -static inline void tlb_flush_entry_locked(CPUTLBEntry *tlb_entry,
> +static inline bool tlb_flush_entry_locked(CPUTLBEntry *tlb_entry,
>                                            target_ulong page)
>  {
>      if (tlb_hit_page_anyprot(tlb_entry, page)) {
>          memset(tlb_entry, -1, sizeof(*tlb_entry));
> +        return true;
>      }
> +    return false;
>  }
>
>  /* Called with tlb_lock held */
> @@ -316,7 +321,9 @@ static void tlb_flush_page_async_work(CPUState *cpu, =
run_on_cpu_data data)
>      addr &=3D TARGET_PAGE_MASK;
>      qemu_spin_lock(&env->tlb_lock);
>      for (mmu_idx =3D 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
> -        tlb_flush_entry_locked(tlb_entry(env, mmu_idx, addr), addr);
> +        if (tlb_flush_entry_locked(tlb_entry(env, mmu_idx, addr), addr))=
 {
> +            env->tlb_desc[mmu_idx].n_used_entries--;
> +        }
>          tlb_flush_vtlb_page_locked(env, mmu_idx, addr);
>      }
>      qemu_spin_unlock(&env->tlb_lock);
> @@ -358,7 +365,9 @@ static void tlb_flush_page_by_mmuidx_async_work(CPUSt=
ate *cpu,
>      qemu_spin_lock(&env->tlb_lock);
>      for (mmu_idx =3D 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
>          if (test_bit(mmu_idx, &mmu_idx_bitmap)) {
> -            tlb_flush_entry_locked(tlb_entry(env, mmu_idx, addr), addr);
> +            if (tlb_flush_entry_locked(tlb_entry(env, mmu_idx, addr), ad=
dr)) {
> +                env->tlb_desc[mmu_idx].n_used_entries--;
> +            }
>              tlb_flush_vtlb_page_locked(env, mmu_idx, addr);
>          }
>      }
> @@ -696,6 +705,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ul=
ong vaddr,
>          /* Evict the old entry into the victim tlb.  */
>          copy_tlb_helper_locked(tv, te);
>          env->iotlb_v[mmu_idx][vidx] =3D env->iotlb[mmu_idx][index];
> +        env->tlb_desc[mmu_idx].n_used_entries--;
>      }
>
>      /* refill the tlb */
> @@ -747,6 +757,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ul=
ong vaddr,
>      }
>
>      copy_tlb_helper_locked(te, &tn);
> +    env->tlb_desc[mmu_idx].n_used_entries++;
>      qemu_spin_unlock(&env->tlb_lock);
>  }


--
Alex Benn=C3=A9e
