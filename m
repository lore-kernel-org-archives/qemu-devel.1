Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC94C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049F9206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ETArlzEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049F9206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT1Kr-0004Ns-4p
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 06:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT1K0-0003dN-T6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT1Jz-00018V-Na
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:49:08 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jT1Jz-00018C-3l
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:49:07 -0400
Received: by mail-ot1-x342.google.com with SMTP id z25so25288712otq.13
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 03:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R/rTAYokcjj8HRqIgXJH4e924adjbvQCLJByB1dR0zQ=;
 b=ETArlzEXWKZ6jIbGaQfUMeuMpTzUmcBJknVCJr4iuKnO/WWvjOssJdGQjDop/Jbx2Z
 oLCySvZgdE/30g4jHmEl+KWPaF3cOPUvV3mSNk4y5Nl+xfohNuvZ/PepFepnFrpuAQfP
 SLcJI312InuVJg5ktBnqfQ8UJbh9asCRAVErZROmMbQ0pZN5awA28M+1/0hE0nmMh8L3
 /LfKkjwUXCs7tY7RPXiq8aUhaYSBgfsq3McmjR3kRcz4kYuWQsS/buT0NpporosRY9H6
 zVby8MP43x+Lf/mZMpNlpm/HbVMAS/qKZsoTlGHgeEtS3H+xPnchSF+VZV034exc/Nap
 k92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R/rTAYokcjj8HRqIgXJH4e924adjbvQCLJByB1dR0zQ=;
 b=OBHtfjTp/3ioIKiVrFrvdNNft85s/cOxHFyMQRKZL8KfJbKEgynZgBQ1QxahaSIEtM
 l5ycJ0+VsEby5pzgQOJYnY+gm8z7VLGOplcVhbjTglKnUKSxGNbC1MVTcoXBdXkIHjgD
 w4OpYk/uuyvJlyPqT6vMdnK/8sLUhS81qbIzPzRlJjlYuFu3nF6R3bCd2fLlWArRkw/I
 47bzsv5PYKSTFcsQ8HfH+VFbUIes7xifWwbiNkKKRi2XSXC5qrscfVmN5dV81+qDhD4K
 U8pKDXoni4qpL/EN4IK4CX4aMgLfCkq79RNFRS+1pVjIcQEi7Mbx5WIFUhbObIpKu2K4
 qryQ==
X-Gm-Message-State: AGi0PuZr+ygIn6gBqHlJQnFcug3VFAQ4CtnI56RFbL2xRVw4YrWz48EM
 +gL2iA7pdCslSwnaOGXiPekvUMmy7WWLUuU0HqR8Fg==
X-Google-Smtp-Source: APiQypJ7GOapSpRK3ltj297VCZflG9saduHbB1WPk+JutQIo+CJ+NkUJhWfoCNbyQd5Doqx1+KYddvbNsQXAo0B+RFU=
X-Received: by 2002:aca:c751:: with SMTP id x78mr15409246oif.163.1587984545349; 
 Mon, 27 Apr 2020 03:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200422043309.18430-1-richard.henderson@linaro.org>
 <20200422043309.18430-5-richard.henderson@linaro.org>
In-Reply-To: <20200422043309.18430-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2020 11:48:53 +0100
Message-ID: <CAFEAcA_ugvJWmN8fNbvZYJvOtyv6uPAumQ8UPtK-k9nqN=uerQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/18] accel/tcg: Add probe_access_flags
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Apr 2020 at 05:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This new interface will allow targets to probe for a page
> and then handle watchpoints themselves.  This will be most
> useful for vector predicated memory operations, where one
> page lookup can be used for many operations, and one test
> can avoid many watchpoint checks.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Fix return of host pointer in softmmu probe_access_flags.
> ---
>  include/exec/cpu-all.h  |  13 ++-
>  include/exec/exec-all.h |  22 +++++
>  accel/tcg/cputlb.c      | 177 ++++++++++++++++++++--------------------
>  accel/tcg/user-exec.c   |  36 +++++---
>  4 files changed, 149 insertions(+), 99 deletions(-)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 49384bb66a..43ddcf024c 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -328,7 +328,18 @@ CPUArchState *cpu_copy(CPUArchState *env);
>       | CPU_INTERRUPT_TGT_EXT_3   \
>       | CPU_INTERRUPT_TGT_EXT_4)
>
> -#if !defined(CONFIG_USER_ONLY)
> +#ifdef CONFIG_USER_ONLY
> +
> +/*
> + * Allow some level of source compatibility with softmmu.  We do not
> + * support any of the more exotic features, so only invalid pages may
> + * be signaled by probe_access_flags().
> + */
> +#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
> +#define TLB_MMIO            0
> +#define TLB_WATCHPOINT      0
> +
> +#else
>
>  /*
>   * Flags stored in the low bits of the TLB virtual address.
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index d656a1f05c..8792bea07a 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -362,6 +362,28 @@ static inline void *probe_read(CPUArchState *env, target_ulong addr, int size,
>      return probe_access(env, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
>  }
>
> +/**
> + * probe_access_flags:
> + * @env: CPUArchState
> + * @addr: guest virtual address to look up
> + * @access_type: read, write or execute permission
> + * @mmu_idx: MMU index to use for lookup
> + * @nonfault: suppress the fault
> + * @phost: return value for host address
> + * @retaddr: return address for unwinding
> + *
> + * Similar to probe_access, loosely returning the TLB_FLAGS_MASK for
> + * the page, and storing the host address for RAM in @phost.
> + *
> + * If @nonfault is set, do not raise an exception but return TLB_INVALID_MASK.
> + * Do not handle watchpoints, but include TLB_WATCHPOINT in the returned flags.
> + * Do handle clean pages, so exclude TLB_NOTDIRY from the returned flags.

"TLB_NOTDIRTY"

> + * For simplicity, all "mmio-like" flags are folded to TLB_MMIO.
> + */
> +int probe_access_flags(CPUArchState *env, target_ulong addr,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool nonfault, void **phost, uintptr_t retaddr);
> +
>  #define CODE_GEN_ALIGN           16 /* must be >= of the size of a icache line */
>
>  /* Estimated block size for TB allocation.  */
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index e3b5750c3b..bbe265ce28 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1231,86 +1231,16 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
>      }
>  }
>
> -/*
> - * Probe for whether the specified guest access is permitted. If it is not
> - * permitted then an exception will be taken in the same way as if this
> - * were a real access (and we will not return).
> - * If the size is 0 or the page requires I/O access, returns NULL; otherwise,
> - * returns the address of the host page similar to tlb_vaddr_to_host().
> - */
> -void *probe_access(CPUArchState *env, target_ulong addr, int size,
> -                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> +static int probe_access_internal(CPUArchState *env, target_ulong addr,
> +                                 int fault_size, MMUAccessType access_type,
> +                                 int mmu_idx, bool nonfault,
> +                                 void **phost, uintptr_t retaddr)
>  {
>      uintptr_t index = tlb_index(env, mmu_idx, addr);
>      CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
> -    target_ulong tlb_addr;
> -    size_t elt_ofs;
> -    int wp_access;
> -
> -    g_assert(-(addr | TARGET_PAGE_MASK) >= size);
> -
> -    switch (access_type) {
> -    case MMU_DATA_LOAD:
> -        elt_ofs = offsetof(CPUTLBEntry, addr_read);
> -        wp_access = BP_MEM_READ;
> -        break;
> -    case MMU_DATA_STORE:
> -        elt_ofs = offsetof(CPUTLBEntry, addr_write);
> -        wp_access = BP_MEM_WRITE;
> -        break;
> -    case MMU_INST_FETCH:
> -        elt_ofs = offsetof(CPUTLBEntry, addr_code);
> -        wp_access = BP_MEM_READ;
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -    tlb_addr = tlb_read_ofs(entry, elt_ofs);
> -
> -    if (unlikely(!tlb_hit(tlb_addr, addr))) {
> -        if (!victim_tlb_hit(env, mmu_idx, index, elt_ofs,
> -                            addr & TARGET_PAGE_MASK)) {
> -            tlb_fill(env_cpu(env), addr, size, access_type, mmu_idx, retaddr);
> -            /* TLB resize via tlb_fill may have moved the entry. */
> -            index = tlb_index(env, mmu_idx, addr);
> -            entry = tlb_entry(env, mmu_idx, addr);
> -        }
> -        tlb_addr = tlb_read_ofs(entry, elt_ofs);
> -    }
> -
> -    if (!size) {
> -        return NULL;
> -    }
> -
> -    if (unlikely(tlb_addr & TLB_FLAGS_MASK)) {
> -        CPUIOTLBEntry *iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
> -
> -        /* Reject I/O access, or other required slow-path.  */
> -        if (tlb_addr & (TLB_MMIO | TLB_BSWAP | TLB_DISCARD_WRITE)) {
> -            return NULL;
> -        }
> -
> -        /* Handle watchpoints.  */
> -        if (tlb_addr & TLB_WATCHPOINT) {
> -            cpu_check_watchpoint(env_cpu(env), addr, size,
> -                                 iotlbentry->attrs, wp_access, retaddr);
> -        }
> -
> -        /* Handle clean RAM pages.  */
> -        if (tlb_addr & TLB_NOTDIRTY) {
> -            notdirty_write(env_cpu(env), addr, size, iotlbentry, retaddr);
> -        }
> -    }
> -
> -    return (void *)((uintptr_t)addr + entry->addend);
> -}
> -
> -void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
> -                        MMUAccessType access_type, int mmu_idx)
> -{
> -    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
> -    target_ulong tlb_addr, page;
> +    target_ulong tlb_addr, page_addr;
>      size_t elt_ofs;
> +    int flags;
>
>      switch (access_type) {
>      case MMU_DATA_LOAD:
> @@ -1325,20 +1255,19 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
>      default:
>          g_assert_not_reached();
>      }
> -
> -    page = addr & TARGET_PAGE_MASK;
>      tlb_addr = tlb_read_ofs(entry, elt_ofs);
>
> -    if (!tlb_hit_page(tlb_addr, page)) {
> -        uintptr_t index = tlb_index(env, mmu_idx, addr);
> -
> -        if (!victim_tlb_hit(env, mmu_idx, index, elt_ofs, page)) {
> +    page_addr = addr & TARGET_PAGE_MASK;
> +    if (!tlb_hit_page(tlb_addr, page_addr)) {
> +        if (!victim_tlb_hit(env, mmu_idx, index, elt_ofs, page_addr)) {
>              CPUState *cs = env_cpu(env);
>              CPUClass *cc = CPU_GET_CLASS(cs);
>
> -            if (!cc->tlb_fill(cs, addr, 0, access_type, mmu_idx, true, 0)) {
> +            if (!cc->tlb_fill(cs, addr, fault_size, access_type,
> +                              mmu_idx, nonfault, retaddr)) {
>                  /* Non-faulting page table read failed.  */
> -                return NULL;
> +                *phost = NULL;
> +                return TLB_INVALID_MASK;
>              }
>
>              /* TLB resize via tlb_fill may have moved the entry.  */
> @@ -1346,15 +1275,89 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
>          }
>          tlb_addr = tlb_read_ofs(entry, elt_ofs);
>      }
> +    flags = tlb_addr & TLB_FLAGS_MASK;
>
> -    if (tlb_addr & ~TARGET_PAGE_MASK) {
> -        /* IO access */
> +    /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
> +    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY))) {
> +        *phost = NULL;
> +        return TLB_MMIO;
> +    }
> +
> +    /* Everything else is RAM. */
> +    *phost = (void *)((uintptr_t)addr + entry->addend);
> +    return flags;
> +}
> +
> +int probe_access_flags(CPUArchState *env, target_ulong addr,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool nonfault, void **phost, uintptr_t retaddr)
> +{
> +    int flags;
> +
> +    flags = probe_access_internal(env, addr, 0, access_type, mmu_idx,
> +                                  nonfault, phost, retaddr);
> +
> +    /* Handle clean RAM pages.  */
> +    if (unlikely(flags & TLB_NOTDIRTY)) {
> +        uintptr_t index = tlb_index(env, mmu_idx, addr);
> +        CPUIOTLBEntry *iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
> +
> +        notdirty_write(env_cpu(env), addr, 1, iotlbentry, retaddr);
> +        flags &= ~TLB_NOTDIRTY;
> +    }

probe_access() handles watchpoints. Why doesn't probe_access_flags()
have to do that?

> +
> +    return flags;
> +}
> +
> +void *probe_access(CPUArchState *env, target_ulong addr, int size,
> +                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> +{
> +    void *host;
> +    int flags;
> +
> +    g_assert(-(addr | TARGET_PAGE_MASK) >= size);
> +
> +    flags = probe_access_internal(env, addr, size, access_type, mmu_idx,
> +                                  false, &host, retaddr);
> +
> +    /* Per the interface, size == 0 merely faults the access. */
> +    if (size == 0) {
>          return NULL;
>      }
>
> -    return (void *)((uintptr_t)addr + entry->addend);
> +    if (unlikely(flags & (TLB_NOTDIRTY | TLB_WATCHPOINT))) {
> +        uintptr_t index = tlb_index(env, mmu_idx, addr);
> +        CPUIOTLBEntry *iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
> +
> +        /* Handle clean RAM pages.  */
> +        if (flags & TLB_NOTDIRTY) {
> +            notdirty_write(env_cpu(env), addr, 1, iotlbentry, retaddr);
> +        }
> +
> +        /* Handle watchpoints.  */
> +        if (flags & TLB_WATCHPOINT) {
> +            int wp_access = (access_type == MMU_DATA_STORE
> +                             ? BP_MEM_WRITE : BP_MEM_READ);
> +            cpu_check_watchpoint(env_cpu(env), addr, size,
> +                                 iotlbentry->attrs, wp_access, retaddr);
> +        }

The old code checked for watchpoints first, and then handled notdirty-writes,
which seems like the more correct order. Why has the new
version switched them around?

(Incidentally notdirty_write() is rather misleadingly named,
since it doesn't actually do a write, it just marks a notdirty
page as dirty.)

> +    }
> +
> +    return host;

The probe_access_internal() doc comment doesn't say that it
guarantees to set host to NULL for the TLB_MMIO/TLB_INVALID_MASK
cases, but we implicitly rely on it here.


>  }
>
> +void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
> +                        MMUAccessType access_type, int mmu_idx)
> +{
> +    void *host;
> +    int flags;
> +
> +    flags = probe_access_internal(env, addr, 0, access_type,
> +                                  mmu_idx, true, &host, 0);
> +
> +    /* No combination of flags are expected by the caller. */
> +    return flags ? NULL : host;
> +}
>
>  #ifdef CONFIG_PLUGIN
>  /*
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 4be78eb9b3..91c2dc46dd 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -190,13 +190,12 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
>      g_assert_not_reached();
>  }
>
> -void *probe_access(CPUArchState *env, target_ulong addr, int size,
> -                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> +int probe_access_flags(CPUArchState *env, target_ulong addr,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool nonfault, void **phost, uintptr_t ra)
>  {
>      int flags;
>
> -    g_assert(-(addr | TARGET_PAGE_MASK) >= size);
> -
>      switch (access_type) {
>      case MMU_DATA_STORE:
>          flags = PAGE_WRITE;
> @@ -211,15 +210,30 @@ void *probe_access(CPUArchState *env, target_ulong addr, int size,
>          g_assert_not_reached();
>      }
>
> -    if (!guest_addr_valid(addr) || page_check_range(addr, size, flags) < 0) {
> -        CPUState *cpu = env_cpu(env);
> -        CPUClass *cc = CPU_GET_CLASS(cpu);
> -        cc->tlb_fill(cpu, addr, size, access_type, MMU_USER_IDX, false,
> -                     retaddr);
> -        g_assert_not_reached();
> +    if (!guest_addr_valid(addr) || page_check_range(addr, 1, flags) < 0) {
> +        if (nonfault) {
> +            *phost = NULL;
> +            return TLB_INVALID_MASK;
> +        } else {
> +            CPUState *cpu = env_cpu(env);
> +            CPUClass *cc = CPU_GET_CLASS(cpu);
> +            cc->tlb_fill(cpu, addr, 0, access_type, MMU_USER_IDX, false, ra);
> +            g_assert_not_reached();
> +        }
>      }
>
> -    return size ? g2h(addr) : NULL;
> +    *phost = g2h(addr);
> +    return 0;
> +}
> +
> +void *probe_access(CPUArchState *env, target_ulong addr, int size,
> +                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> +{
> +    void *host;
> +
> +    g_assert(-(addr | TARGET_PAGE_MASK) >= size);
> +    probe_access_flags(env, addr, access_type, mmu_idx, false, &host, retaddr);
> +    return host;

The old code returned NULL for a zero size; the new version does not.
The old code passed size into cc->tlb_fill; the new version does not.
The old code passed size into page_check_range(); the new version does not.

thanks
-- PMM

