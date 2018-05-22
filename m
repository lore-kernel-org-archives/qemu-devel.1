Received: from eggs.gnu.org ([2001:4830:134:3::10]:49655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL3UI-0000lc-Qs
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL3UD-0007HF-QV
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:21:46 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:40342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fL3UD-0007H4-JB
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:21:41 -0400
Received: by mail-wm0-x244.google.com with SMTP id j5-v6so31497550wme.5
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 02:21:41 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-3-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180521140402.23318-3-peter.maydell@linaro.org>
Date: Tue, 22 May 2018 10:21:39 +0100
Message-ID: <87muwsujto.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/27] Make tb_invalidate_phys_addr() take
 a MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> As part of plumbing MemTxAttrs down to the IOMMU translate method,
> add MemTxAttrs as an argument to tb_invalidate_phys_addr().
> Its callers either have an attrs value to hand, or don't care
> and can use MEMTXATTRS_UNSPECIFIED.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/exec-all.h   | 5 +++--
>  accel/tcg/translate-all.c | 2 +-
>  exec.c                    | 2 +-
>  target/xtensa/op_helper.c | 3 ++-
>  4 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index bd68328ed9..4d09eaba72 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -255,7 +255,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ul=
ong vaddr,
>  void tlb_set_page(CPUState *cpu, target_ulong vaddr,
>                    hwaddr paddr, int prot,
>                    int mmu_idx, target_ulong size);
> -void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr);
> +void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs a=
ttrs);
>  void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu=
_idx,
>                   uintptr_t retaddr);
>  #else
> @@ -303,7 +303,8 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synce=
d(CPUState *cpu,
>                                                         uint16_t idxmap)
>  {
>  }
> -static inline void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr)
> +static inline void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr,
> +                                           MemTxAttrs attrs)
>  {
>  }
>  #endif
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index f409d42d54..f04a922ef7 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1672,7 +1672,7 @@ static TranslationBlock *tb_find_pc(uintptr_t tc_pt=
r)
>  }
>
>  #if !defined(CONFIG_USER_ONLY)
> -void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr)
> +void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs a=
ttrs)
>  {
>      ram_addr_t ram_addr;
>      MemoryRegion *mr;
> diff --git a/exec.c b/exec.c
> index ffa1099547..c3a197e67b 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -898,7 +898,7 @@ static void breakpoint_invalidate(CPUState *cpu, targ=
et_ulong pc)
>      if (phys !=3D -1) {
>          /* Locks grabbed by tb_invalidate_phys_addr */
>          tb_invalidate_phys_addr(cpu->cpu_ases[asidx].as,
> -                                phys | (pc & ~TARGET_PAGE_MASK));
> +                                phys | (pc & ~TARGET_PAGE_MASK), attrs);
>      }
>  }
>  #endif
> diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
> index e3bcbe10d6..8a8c763c63 100644
> --- a/target/xtensa/op_helper.c
> +++ b/target/xtensa/op_helper.c
> @@ -105,7 +105,8 @@ static void tb_invalidate_virtual_addr(CPUXtensaState=
 *env, uint32_t vaddr)
>      int ret =3D xtensa_get_physical_addr(env, false, vaddr, 2, 0,
>              &paddr, &page_size, &access);
>      if (ret =3D=3D 0) {
> -        tb_invalidate_phys_addr(&address_space_memory, paddr);
> +        tb_invalidate_phys_addr(&address_space_memory, paddr,
> +                                MEMTXATTRS_UNSPECIFIED);
>      }
>  }


--
Alex Benn=C3=A9e
