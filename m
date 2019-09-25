Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E575C4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0AD21D79
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YRT//vYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0AD21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDA0H-0001Fn-Hv
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 12:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iD9wd-0006pe-6L
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iD9wb-00023b-AH
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:15:11 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iD9wb-0001zu-1F
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:15:09 -0400
Received: by mail-wm1-x341.google.com with SMTP id v17so5626179wml.4
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZacImurD740+KeapyH4obBJjjx+p2T0/JPi/VCvGzmI=;
 b=YRT//vYYp8EWZytMdt53vIfVj5JKjeShVqw0M7lxjtjpVNJ6ggLbmPinjebzmsNnTC
 an8ewFN96a6O8jjoOgmSURJs74MB7jHJp0wV3IHisNZRXwr6vOGEj5jfUhaA/55LP8LT
 e8K21HpGPJmaxVjbcG+/yHAzeaJW7qJ/9Gc8o1R9sH2jGsZ6F5m0HpW/harX+tf7fTgz
 M3bGd0qSYIINOQV9kfMoLMYop8Ur/gfpKsVMmc3KL0ORgWRcLaXLSTcKBQGzLZMAd1u5
 72BUxOpSGEaOL7fhaQFNmzZ/j6GylcYxvRktBKd++JyDYyUA6A0B6+e26Xvcw+zNkoyJ
 gfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZacImurD740+KeapyH4obBJjjx+p2T0/JPi/VCvGzmI=;
 b=MAKujvhI8k96ywkjJZvCntj0ff+X5IZzofcJwGah4fLeKq+T4NYIuoaiQc9UhqDMC4
 QPd53L7E6lJ1314UF4o63+ffiy6zKSfZQhQJaT1zu8zoH1SToxO34NmJCR9aiEGf0f3X
 WDSQ5HBuG5lz5AhmSY9QorHzy7TgdwuEgAYAKnqg3p7yVdBum/4vRvXninUBQfD2qjXe
 sxSVDZjv4pVQCtMF1/A9SbncmBxbuci6Ew8CuKKOkOFUb7N5yORIJDaNZghf89E931mL
 lDN6m24YQMejrQ8ey4RHk423V77xQu3fV2a5LOjSCgfA448Ji/hFMnqW/UVojgLJAxLD
 C9+w==
X-Gm-Message-State: APjAAAW+GTXFdHN7BI0zRZk+ybUXaJjk+FIkFDRaMa8ZxIAT2YH8/ftk
 prr5l0IclXHr/n1RwHNS8CTL0g==
X-Google-Smtp-Source: APXvYqw0lcR+RBTvv8BVnkJrTtTmXj/TMyI4r5qSyFiiSuZ57b9HnjIL+B/0Os1W5C/ybzCGNfYAzQ==
X-Received: by 2002:a7b:caa9:: with SMTP id r9mr9059617wml.14.1569428104582;
 Wed, 25 Sep 2019 09:15:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f66sm6194544wmg.2.2019.09.25.09.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 09:15:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 585801FF87;
 Wed, 25 Sep 2019 17:15:03 +0100 (BST)
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-12-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 11/16] cputlb: Merge and move
 memory_notdirty_write_{prepare,complete}
In-reply-to: <20190923230004.9231-12-richard.henderson@linaro.org>
Date: Wed, 25 Sep 2019 17:15:03 +0100
Message-ID: <87pnjo9wu0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Since 9458a9a1df1a, all readers of the dirty bitmaps wait
> for the rcu lock, which means that they wait until the end
> of any executing TranslationBlock.
>
> As a consequence, there is no need for the actual access
> to happen in between the _prepare and _complete.  Therefore,
> we can improve things by merging the two functions into
> notdirty_write and dropping the NotDirtyInfo structure.
>
> In addition, the only users of notdirty_write are in cputlb.c,
> so move the merged function there.  Pass in the CPUIOTLBEntry
> from which the ram_addr_t may be computed.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/memory-internal.h | 65 -----------------------------
>  accel/tcg/cputlb.c             | 76 +++++++++++++++++++---------------
>  exec.c                         | 44 --------------------
>  3 files changed, 42 insertions(+), 143 deletions(-)
>
> diff --git a/include/exec/memory-internal.h b/include/exec/memory-interna=
l.h
> index ef4fb92371..9fcc2af25c 100644
> --- a/include/exec/memory-internal.h
> +++ b/include/exec/memory-internal.h
> @@ -49,70 +49,5 @@ void address_space_dispatch_free(AddressSpaceDispatch =
*d);
>
>  void mtree_print_dispatch(struct AddressSpaceDispatch *d,
>                            MemoryRegion *root);
> -
> -struct page_collection;
> -
> -/* Opaque struct for passing info from memory_notdirty_write_prepare()
> - * to memory_notdirty_write_complete(). Callers should treat all fields
> - * as private, with the exception of @active.
> - *
> - * @active is a field which is not touched by either the prepare or
> - * complete functions, but which the caller can use if it wishes to
> - * track whether it has called prepare for this struct and so needs
> - * to later call the complete function.
> - */
> -typedef struct {
> -    CPUState *cpu;
> -    struct page_collection *pages;
> -    ram_addr_t ram_addr;
> -    vaddr mem_vaddr;
> -    unsigned size;
> -    bool active;
> -} NotDirtyInfo;
> -
> -/**
> - * memory_notdirty_write_prepare: call before writing to non-dirty memory
> - * @ndi: pointer to opaque NotDirtyInfo struct
> - * @cpu: CPU doing the write
> - * @mem_vaddr: virtual address of write
> - * @ram_addr: the ram address of the write
> - * @size: size of write in bytes
> - *
> - * Any code which writes to the host memory corresponding to
> - * guest RAM which has been marked as NOTDIRTY must wrap those
> - * writes in calls to memory_notdirty_write_prepare() and
> - * memory_notdirty_write_complete():
> - *
> - *  NotDirtyInfo ndi;
> - *  memory_notdirty_write_prepare(&ndi, ....);
> - *  ... perform write here ...
> - *  memory_notdirty_write_complete(&ndi);
> - *
> - * These calls will ensure that we flush any TCG translated code for
> - * the memory being written, update the dirty bits and (if possible)
> - * remove the slowpath callback for writing to the memory.
> - *
> - * This must only be called if we are using TCG; it will assert otherwis=
e.
> - *
> - * We may take locks in the prepare call, so callers must ensure that
> - * they don't exit (via longjump or otherwise) without calling complete.
> - *
> - * This call must only be made inside an RCU critical section.
> - * (Note that while we're executing a TCG TB we're always in an
> - * RCU critical section, which is likely to be the case for callers
> - * of these functions.)
> - */
> -void memory_notdirty_write_prepare(NotDirtyInfo *ndi,
> -                                   CPUState *cpu,
> -                                   vaddr mem_vaddr,
> -                                   ram_addr_t ram_addr,
> -                                   unsigned size);
> -/**
> - * memory_notdirty_write_complete: finish write to non-dirty memory
> - * @ndi: pointer to the opaque NotDirtyInfo struct which was initialized
> - * by memory_not_dirty_write_prepare().
> - */
> -void memory_notdirty_write_complete(NotDirtyInfo *ndi);
> -
>  #endif
>  #endif
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 05530a8b0c..09b0df87c6 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -33,6 +33,7 @@
>  #include "exec/helper-proto.h"
>  #include "qemu/atomic.h"
>  #include "qemu/atomic128.h"
> +#include "translate-all.h"
>
>  /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target =
*/
>  /* #define DEBUG_TLB */
> @@ -1084,6 +1085,37 @@ tb_page_addr_t get_page_addr_code(CPUArchState *en=
v, target_ulong addr)
>      return qemu_ram_addr_from_host_nofail(p);
>  }
>
> +static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
> +                           CPUIOTLBEntry *iotlbentry, uintptr_t retaddr)
> +{
> +    ram_addr_t ram_addr =3D mem_vaddr + iotlbentry->addr;
> +
> +    trace_memory_notdirty_write_access(mem_vaddr, ram_addr, size);
> +
> +    if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)=
) {
> +        struct page_collection *pages
> +            =3D page_collection_lock(ram_addr, ram_addr + size);
> +
> +        /* We require mem_io_pc in tb_invalidate_phys_page_range.  */
> +        cpu->mem_io_pc =3D retaddr;
> +
> +        tb_invalidate_phys_page_fast(pages, ram_addr, size);
> +        page_collection_unlock(pages);
> +    }
> +
> +    /*
> +     * Set both VGA and migration bits for simplicity and to remove
> +     * the notdirty callback faster.
> +     */
> +    cpu_physical_memory_set_dirty_range(ram_addr, size, DIRTY_CLIENTS_NO=
CODE);
> +
> +    /* We remove the notdirty callback only if the code has been flushed=
. */
> +    if (!cpu_physical_memory_is_clean(ram_addr)) {
> +        trace_memory_notdirty_set_dirty(mem_vaddr);
> +        tlb_set_dirty(cpu, mem_vaddr);
> +    }
> +}
> +
>  /*
>   * Probe for whether the specified guest access is permitted. If it is n=
ot
>   * permitted then an exception will be taken in the same way as if this
> @@ -1203,8 +1235,7 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr =
addr,
>  /* Probe for a read-modify-write atomic operation.  Do not allow unalign=
ed
>   * operations, or io operations to proceed.  Return the host address.  */
>  static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
> -                               TCGMemOpIdx oi, uintptr_t retaddr,
> -                               NotDirtyInfo *ndi)
> +                               TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      size_t mmu_idx =3D get_mmuidx(oi);
>      uintptr_t index =3D tlb_index(env, mmu_idx, addr);
> @@ -1264,12 +1295,9 @@ static void *atomic_mmu_lookup(CPUArchState *env, =
target_ulong addr,
>
>      hostaddr =3D (void *)((uintptr_t)addr + tlbe->addend);
>
> -    ndi->active =3D false;
>      if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
> -        ndi->active =3D true;
> -        memory_notdirty_write_prepare(ndi, env_cpu(env), addr,
> -                                      qemu_ram_addr_from_host_nofail(hos=
taddr),
> -                                      1 << s_bits);
> +        notdirty_write(env_cpu(env), addr, 1 << s_bits,
> +                       &env_tlb(env)->d[mmu_idx].iotlb[index], retaddr);
>      }
>
>      return hostaddr;
> @@ -1636,28 +1664,13 @@ store_helper(CPUArchState *env, target_ulong addr=
, uint64_t val,
>              return;
>          }
>
> -        haddr =3D (void *)((uintptr_t)addr + entry->addend);
> -
>          /* Handle clean RAM pages.  */
>          if (tlb_addr & TLB_NOTDIRTY) {
> -            NotDirtyInfo ndi;
> -
> -            /* We require mem_io_pc in tb_invalidate_phys_page_range.  */
> -            env_cpu(env)->mem_io_pc =3D retaddr;
> -
> -            memory_notdirty_write_prepare(&ndi, env_cpu(env), addr,
> -                                          addr + iotlbentry->addr, size);
> -
> -            if (unlikely(need_swap)) {
> -                store_memop(haddr, val, op ^ MO_BSWAP);
> -            } else {
> -                store_memop(haddr, val, op);
> -            }
> -
> -            memory_notdirty_write_complete(&ndi);
> -            return;
> +            notdirty_write(env_cpu(env), addr, size, iotlbentry, retaddr=
);
>          }
>
> +        haddr =3D (void *)((uintptr_t)addr + entry->addend);
> +
>          if (unlikely(need_swap)) {
>              store_memop(haddr, val, op ^ MO_BSWAP);
>          } else {
> @@ -1783,14 +1796,9 @@ void helper_be_stq_mmu(CPUArchState *env, target_u=
long addr, uint64_t val,
>  #define EXTRA_ARGS     , TCGMemOpIdx oi, uintptr_t retaddr
>  #define ATOMIC_NAME(X) \
>      HELPER(glue(glue(glue(atomic_ ## X, SUFFIX), END), _mmu))
> -#define ATOMIC_MMU_DECLS NotDirtyInfo ndi
> -#define ATOMIC_MMU_LOOKUP atomic_mmu_lookup(env, addr, oi, retaddr, &ndi)
> -#define ATOMIC_MMU_CLEANUP                              \
> -    do {                                                \
> -        if (unlikely(ndi.active)) {                     \
> -            memory_notdirty_write_complete(&ndi);       \
> -        }                                               \
> -    } while (0)
> +#define ATOMIC_MMU_DECLS
> +#define ATOMIC_MMU_LOOKUP atomic_mmu_lookup(env, addr, oi, retaddr)
> +#define ATOMIC_MMU_CLEANUP
>
>  #define DATA_SIZE 1
>  #include "atomic_template.h"
> @@ -1818,7 +1826,7 @@ void helper_be_stq_mmu(CPUArchState *env, target_ul=
ong addr, uint64_t val,
>  #undef ATOMIC_MMU_LOOKUP
>  #define EXTRA_ARGS         , TCGMemOpIdx oi
>  #define ATOMIC_NAME(X)     HELPER(glue(glue(atomic_ ## X, SUFFIX), END))
> -#define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, oi, GETPC(), &nd=
i)
> +#define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, oi, GETPC())
>
>  #define DATA_SIZE 1
>  #include "atomic_template.h"
> diff --git a/exec.c b/exec.c
> index 961d7d6497..7d835b1a2b 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2718,50 +2718,6 @@ ram_addr_t qemu_ram_addr_from_host(void *ptr)
>      return block->offset + offset;
>  }
>
> -/* Called within RCU critical section. */
> -void memory_notdirty_write_prepare(NotDirtyInfo *ndi,
> -                          CPUState *cpu,
> -                          vaddr mem_vaddr,
> -                          ram_addr_t ram_addr,
> -                          unsigned size)
> -{
> -    ndi->cpu =3D cpu;
> -    ndi->ram_addr =3D ram_addr;
> -    ndi->mem_vaddr =3D mem_vaddr;
> -    ndi->size =3D size;
> -    ndi->pages =3D NULL;
> -
> -    trace_memory_notdirty_write_access(mem_vaddr, ram_addr, size);
> -
> -    assert(tcg_enabled());
> -    if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)=
) {
> -        ndi->pages =3D page_collection_lock(ram_addr, ram_addr + size);
> -        tb_invalidate_phys_page_fast(ndi->pages, ram_addr, size);
> -    }
> -}
> -
> -/* Called within RCU critical section. */
> -void memory_notdirty_write_complete(NotDirtyInfo *ndi)
> -{
> -    if (ndi->pages) {
> -        assert(tcg_enabled());
> -        page_collection_unlock(ndi->pages);
> -        ndi->pages =3D NULL;
> -    }
> -
> -    /* Set both VGA and migration bits for simplicity and to remove
> -     * the notdirty callback faster.
> -     */
> -    cpu_physical_memory_set_dirty_range(ndi->ram_addr, ndi->size,
> -                                        DIRTY_CLIENTS_NOCODE);
> -    /* we remove the notdirty callback only if the code has been
> -       flushed */
> -    if (!cpu_physical_memory_is_clean(ndi->ram_addr)) {
> -        trace_memory_notdirty_set_dirty(ndi->mem_vaddr);
> -        tlb_set_dirty(ndi->cpu, ndi->mem_vaddr);
> -    }
> -}
> -
>  /* Generate a debug exception if a watchpoint has been hit.  */
>  void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
>                            MemTxAttrs attrs, int flags, uintptr_t ra)


--
Alex Benn=C3=A9e

