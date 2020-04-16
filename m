Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE08C2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 11:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8CC021D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 11:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kpss1jOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8CC021D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP37N-0000Hr-Q6
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 07:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jP36n-0008DH-4z
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 07:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jP36l-0007rE-QY
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 07:55:05 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jP36l-0007qp-HJ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 07:55:03 -0400
Received: by mail-oi1-x243.google.com with SMTP id d7so11275240oif.9
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 04:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JGU07xRE/RHdS1xjEQB2WZABtzGazzNi1EF9edrQcNE=;
 b=kpss1jOo/9CGEc1LytYDt28RH37gGcp+G5JkTSSQR91T64xnKdTEAlJ3tqQuLYCgPR
 qn7DbqpVd+hthwOaPEVw+LLymiVt+cfXhw+W7Pc8yut7ULvh1wwf9ljMtN6oyZbhWSGT
 WkaTxNQ4FSm2t8J872vQe3mYHc6X/4ljxLoaQf5V8FPDfApyHyGeSzQ4jUiJeMVyYJuy
 N99zPcSAx42oyCau/FKqna3LPCbSv1SQKPn0VDNrQJx+cr3PB8w/k/S9YtzDYhvZoKzP
 n7rOlNHlnDSPmvWF/T9ykNOECWF+dfM0JaGdWO3bVbOle3FmBddYBdn9R8Z8g/THfN+H
 lUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JGU07xRE/RHdS1xjEQB2WZABtzGazzNi1EF9edrQcNE=;
 b=iB44V8k3DwEBS0I8s2sT9ExCD9V5sD0sTFEY3ndIl8WGFKHbB0fL69e7I2A7bu+pzm
 jrg1r2AcD0oNlrXLthFpxf6l2VN3WpxZjelHJ1JkJHkjWZHSjpoFGqYxwxjJq1WeTJOm
 PiTpOGu2tAYFGFVNdHpdU3DPQ+s5hXaQeC/qS4gVpuHJwEM9T9DW7XgmG3qRqk4aCGiW
 2/eD5k628MVj8F3muG3929Vv1D0ee4XvauiCS2v0bPJVpwxcJYY1TEmanz1OvqkddlLw
 u/QsLuDfOQoLbIOcgtDZVcAhw6uMZgZB9DxOw6KV6d5bSK8RgAvMulZJ8J1reVqLwocU
 cpvg==
X-Gm-Message-State: AGi0PuZ/Q07apb9lMwRK/Vks9aVMmFvQXyccnDBJpmliH1wsrNo56tJ+
 uXFqtS3oy05gPyTZpJof8NGsVMZ8km2fFdUwQc/qiA==
X-Google-Smtp-Source: APiQypLtel4qGmv/b+mTDDwv8Gm/Ipd3KANOMrFi/S38vnTlrsXB3hIkmxFAjv8ae8p/jdtA5rhqOCL1C07T5F7q2wc=
X-Received: by 2002:aca:3a8a:: with SMTP id h132mr2468243oia.146.1587038102320; 
 Thu, 16 Apr 2020 04:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200311064420.30606-3-richard.henderson@linaro.org>
 <20200312043353.28913-1-richard.henderson@linaro.org>
In-Reply-To: <20200312043353.28913-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 12:54:51 +0100
Message-ID: <CAFEAcA9VQyq0jZGWOJ-kTpM7QfF8Uqg7_tVUDpvjsc=Kv9nSjQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] accel/tcg: Add probe_access_flags
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: qemuarm@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Mar 2020 at 04:34, Richard Henderson
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

All of the code above seems to have disappeared in this
refactoring -- it's not in probe_access_internal()
but it hasn't moved to the new probe_access().


> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 4be78eb9b3..c52dd8a95a 100644
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
> +                       bool nonfault, void **phost, uintptr_t retaddr)
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
> +            cc->tlb_fill(cpu, addr, 0, access_type, MMU_USER_IDX, false, retaddr);
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
>  }

probe_access() used to pass the 'size' argument through to
page_check_range() and cc->tlb_fill(); after this refactoring
it no longer does that.

thanks
-- PMM

