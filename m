Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9150AC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 19:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7A0216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 19:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dPSY2ous"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7A0216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0WAC-0000Iv-5v
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 15:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0W9C-0007F5-Am
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 15:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0W9A-0008G5-BG
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 15:19:54 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38947)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0W9A-0008FQ-1S
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 15:19:52 -0400
Received: by mail-pl1-x644.google.com with SMTP id z3so1859918pln.6
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 12:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=r1u+Qwt6sInud07Vy+huob+IE9yb0gIDkaboKP6LBLY=;
 b=dPSY2ousJpL/Yjeyhg99yIIU9fl2mZdQGScVKV+b371KJXUlXEfH1Dm3pX5IS+9Ops
 KqVaaNM/vjDlB5GCbJBngCQpKup/vwmLH4XkVbK6gUCc/WOFf/X2JF4r3Q2nISKce2y4
 HPpoW5kJ9Ik+052O6NVekgLCEjGTrAZt7UkuYPIBobTlecmr4YsoSjblFwPReDugDwrI
 6/mU54Oda6NCYn1qlbJoKZvq+mGWKfEMBwc830XPKYAhWolY7RNS6cJa1g0DXmdN/emV
 VErGMWPreDP0syXroHVCv6IETtC+q60pywCM0s2t1oprsgK8ZkfwdZpd3ATBUgBWoPZ0
 8fJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r1u+Qwt6sInud07Vy+huob+IE9yb0gIDkaboKP6LBLY=;
 b=Z6gkdX+UCf5O40UjuNz9kdnGSADKPU3zmX0pFkfCEoA0I8x6CEd8ob1HSl6xXPcap4
 E405EF2zeEmGnYuU5n6Ky14VheJy2bvTS4y8d21s8ccWuUMHO+5QmhO1AJtFiZNX1Kqm
 DP0B5Mkz1rdjx0WQZrTX6Sefoi7TI4Dplm6pU5/dsDmfDsJxwD+JuXPxOR0KJZh2Lg7N
 3obydLoSU3/GXLFZJYLsLcrSCEEnPi4akmUneuQ23Kdhl4mQuFyCS9DzPyB/rLHIWaSR
 0h2l/Z0uMBdBvU+qQA445wxS+MiqxE2RkqGFhQHpTJ3Fki/ENSM9bLb7HmLXWtVWqwbu
 m4NA==
X-Gm-Message-State: APjAAAU330nYO+gsGQsjEDwMyy+dljllPH/yocEGaijv7BgJ+UVJUPiT
 Pd5o8fvHwEN/MITBaNOK4FKwtg==
X-Google-Smtp-Source: APXvYqx6ZAj3gMxK3+7vMdBfGtz7ZNwD6hKa0vw9yR1fdtfKN8wprdd3xmFHWXCCFN44+YiJHykfMA==
X-Received: by 2002:a17:902:8f85:: with SMTP id
 z5mr19224340plo.328.1566415190816; 
 Wed, 21 Aug 2019 12:19:50 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g2sm45451702pfq.88.2019.08.21.12.19.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Aug 2019 12:19:49 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190821092252.26541-1-david@redhat.com>
 <20190821092252.26541-3-david@redhat.com>
 <dc42887a-f991-1fe0-36a7-a7804bc4a939@linaro.org>
 <60d60d82-0407-9549-09b8-ff35218a4e71@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8973f904-c171-bcdd-3f6e-5e18cb37035c@linaro.org>
Date: Wed, 21 Aug 2019 12:19:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <60d60d82-0407-9549-09b8-ff35218a4e71@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v1 2/4] s390x/tcg: Introduce
 probe_read_access()
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/19 10:37 AM, David Hildenbrand wrote:
> Hah, guess what, I implemented a similar variant of "fetch all
> of the host addresses" *but* it is not that easy as you might
> think (sorry for the bad news).

I think it is, because I didn't think it *that* easy.  :-)

> There are certain cases where we can't get access to the raw host
> page. Namely, cpu watchpoints, LAP, NODIRTY. In summary: this won't
> as you describe. (my first approach did exactly this)

NODIRTY and LAP are automatically handled via probe_write
faulting instead of returning the address.  I think there
may be a bug in probe_write at present not checking

Watchpoints could be handled the same way, if we were to
export check_watchpoint from exec.c.  Indeed, I see no way
to handle watchpoints correctly if we don't.  I think that's
an outstanding bug with probe_write.

Any other objections?  I certainly think that restricting the
size of such operations to one page is a large simplification
over the S390Access array thing that you create in this patch.


r~

> 
> The following patch requires another re-factoring
> (tcg_s390_cpu_mmu_translate), but you should get the idea.
> 
> 
> 
> From 0cacd2aea3dbc25e93492cca04f6c866b86d7f8a Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Tue, 20 Aug 2019 09:37:11 +0200
> Subject: [PATCH v1] s390x/tcg: Fault-safe MVC (MOVE) implementation
> 
> MVC can cross page boundaries. In case we fault on the second page, we
> already partially copied data. If we have overlaps, we would
> trigger a fault after having partially moved data, eventually having
> our original data already overwritten. When continuing after the fault,
> we would try to move already modified data, not the original data -
> very bad.
> 
> glibc started to use MVC for forward memmove() and is able to trigger
> exectly this corruption (via rpmbuild and rpm). Fedora 31 (rawhide)
> currently fails to install as we trigger rpm database corruptions due to
> this bug.
> 
> We need a way to translate a virtual address range to individual pages that
> we can access later on without triggering faults. Probing all virtual
> addresses once before the read/write is not sufficient - the guest could
> have modified the page tables (e.g., write-protect, map out) in between,
> so on we could fault on any new tlb_fill() - we have to skip any new MMU
> translations.
> 
> Unfortunately, there are TLB entries for which cannot get a host address
> for (esp., watchpoints, LAP, NOTDIRTY) - in these cases we cannot avoid
> a new MMU translation using the ordinary ld/st helpers. Let's fallback
> to guest physical addresses in these cases, that we access via
> cpu_physical_memory_(read|write),
> 
> This change reduced the boottime for s390x guests (to prompt) from ~1:29
> min to ~1:19 min in my tests. For example, LAP protected pages are now only
> translated once when writing to them using MVC and we don't always fallback
> to byte-based copies.
> 
> We will want to use the same mechanism for other accesses as well (e.g.,
> mvcl), prepare for that right away.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 213 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 200 insertions(+), 13 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 91ba2e03d9..1ca293e00d 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -24,8 +24,10 @@
>  #include "exec/helper-proto.h"
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
> +#include "exec/cpu-common.h"
>  #include "qemu/int128.h"
>  #include "qemu/atomic128.h"
> +#include "tcg_s390x.h"
>  
>  #if !defined(CONFIG_USER_ONLY)
>  #include "hw/s390x/storage-keys.h"
> @@ -104,6 +106,181 @@ static inline void cpu_stsize_data_ra(CPUS390XState *env, uint64_t addr,
>      }
>  }
>  
> +/*
> + * An access covers one page, except for the start/end of the translated
> + * virtual address range.
> + */
> +typedef struct S390Access {
> +    union {
> +        char *haddr;
> +        hwaddr paddr;
> +    };
> +    uint16_t size;
> +    bool isHaddr;
> +} S390Access;
> +
> +/*
> + * Prepare access to a virtual address range, guaranteeing we won't trigger
> + * faults during the actual access. Sometimes we can't get access to the
> + * host address (e.g., LAP, cpu watchpoints/PER, clean pages, ...). Then, we
> + * translate to guest physical addresses instead. We'll have to perform
> + * slower, indirect, access to these physical addresses then.
> + */
> +static void access_prepare_idx(CPUS390XState *env, S390Access access[],
> +                               int nb_access, vaddr vaddr, target_ulong size,
> +                               MMUAccessType access_type, int mmu_idx,
> +                               uintptr_t ra)
> +{
> +    int i = 0;
> +    int cur_size;
> +
> +    /*
> +     * After we obtained the host address of a TLB entry that entry might
> +     * be invalidated again - e.g., via tlb_set_dirty(), via another
> +     * tlb_fill(). We assume here that it is fine to temporarily store the
> +     * host address to access it later - we didn't agree to any tlb flush and
> +     * there seems to be no mechanism protecting the return value of
> +     * tlb_vaddr_to_host().
> +     */
> +    while (size) {
> +        g_assert(i < nb_access);
> +        cur_size = adj_len_to_page(size, vaddr);
> +
> +        access[i].isHaddr = true;
> +        access[i].haddr = tlb_vaddr_to_host(env, vaddr, access_type, mmu_idx);
> +        if (!access[i].haddr) {
> +            access[i].isHaddr = false;
> +            tcg_s390_cpu_mmu_translate(env, vaddr, cur_size, access_type,
> +                                       mmu_idx, false, &access[i].paddr,
> +                                       NULL, ra);
> +        }
> +        access[i].size = cur_size;
> +
> +        vaddr += cur_size;
> +        size -= cur_size;
> +        i++;
> +    }
> +
> +    /* let's zero-out the remaining entries, so we have a size of 0 */
> +    if (i < nb_access) {
> +        memset(&access[i], 0 , sizeof(S390Access) * (nb_access - i));
> +    }
> +}
> +
> +static void access_prepare(CPUS390XState *env, S390Access access[],
> +                           int nb_access, target_ulong vaddr, target_ulong size,
> +                           MMUAccessType access_type, uintptr_t ra)
> +{
> +    int mmu_idx = cpu_mmu_index(env, false);
> +
> +    access_prepare_idx(env, access, nb_access, vaddr, size, access_type,
> +                       mmu_idx, ra);
> +}
> +
> +static void access_set(CPUS390XState *env, S390Access write[], int nb_write,
> +                       uint8_t byte, target_ulong size)
> +{
> +    target_ulong cur_size;
> +    void *buf = NULL;
> +    int w = 0;
> +
> +    while (size) {
> +        g_assert(w < nb_write);
> +        if (!write[w].size) {
> +            w++;
> +            continue;
> +        }
> +
> +        cur_size = MIN(size, write[w].size);
> +        if (write[w].isHaddr) {
> +            memset(write[w].haddr, byte, cur_size);
> +            write[w].haddr += cur_size;
> +        } else {
> +#ifndef CONFIG_USER_ONLY
> +            if (!buf) {
> +                buf = g_malloc(TARGET_PAGE_SIZE);
> +                memset(buf, byte, cur_size);
> +            }
> +            cpu_physical_memory_write(write[w].paddr, buf, cur_size);
> +            write[w].paddr += cur_size;
> +#else
> +            g_assert_not_reached();
> +#endif
> +        }
> +        write[w].size -= cur_size;
> +        size -= cur_size;
> +    }
> +    g_free(buf);
> +}
> +
> +/*
> + * Copy memory in chunks up to chunk_size. If the ranges don't overlap or
> + * if it's a forward move, this function behaves like memmove().
> + *
> + * To achieve a backwards byte-by-byte copy (e.g., MVC), the chunk_size
> + * must not be bigger than the address difference (in the worst case, 1 byte).
> + */
> +static void access_copy(CPUS390XState *env, S390Access write[], int nb_write,
> +                        S390Access read[], int nb_read, target_ulong size,
> +                        target_ulong chunk_size)
> +{
> +    target_ulong cur_size;
> +    void *buf = NULL;
> +    int r = 0;
> +    int w = 0;
> +
> +    g_assert(chunk_size > 0);
> +    chunk_size = MIN(chunk_size, TARGET_PAGE_SIZE);
> +
> +    while (size) {
> +        g_assert(w < nb_write);
> +        g_assert(r < nb_read);
> +        if (!write[w].size) {
> +            w++;
> +            continue;
> +        }
> +        if (!read[r].size) {
> +            r++;
> +            continue;
> +        }
> +        cur_size = MIN(MIN(MIN(size, write[w].size), read[r].size), chunk_size);
> +
> +        if (write[w].isHaddr && read[r].isHaddr) {
> +            memmove(write[w].haddr, read[r].haddr,
> +                    cur_size);
> +            write[w].haddr += cur_size;
> +            read[r].haddr += cur_size;
> +#ifndef CONFIG_USER_ONLY
> +        } else if (!write[w].isHaddr && read[r].isHaddr) {
> +            cpu_physical_memory_write(write[w].paddr,
> +                                      read[r].haddr, cur_size);
> +            write[w].paddr += cur_size;
> +            read[r].haddr += cur_size;
> +        } else if (write[w].isHaddr && !read[r].isHaddr) {
> +            cpu_physical_memory_read(read[r].paddr,
> +                                     write[w].haddr, cur_size);
> +            write[w].haddr += cur_size;
> +            read[r].paddr += cur_size;
> +        } else {
> +            if (!buf) {
> +                buf = g_malloc(chunk_size);
> +            }
> +            cpu_physical_memory_read(read[r].paddr, buf, cur_size);
> +            cpu_physical_memory_write(write[w].paddr, buf, cur_size);
> +            write[w].paddr += cur_size;
> +            read[r].paddr += cur_size;
> +#else
> +        } else {
> +            g_assert_not_reached();
> +#endif
> +        }
> +        write[w].size -= cur_size;
> +        read[r].size -= cur_size;
> +        size -= cur_size;
> +    }
> +    g_free(buf);
> +}
> +
>  static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byte,
>                          uint32_t l, uintptr_t ra)
>  {
> @@ -302,24 +479,34 @@ uint32_t HELPER(oc)(CPUS390XState *env, uint32_t l, uint64_t dest,
>  static uint32_t do_helper_mvc(CPUS390XState *env, uint32_t l, uint64_t dest,
>                                uint64_t src, uintptr_t ra)
>  {
> -    uint32_t i;
> +    /* 256 bytes cannot cross more than two pages */
> +    S390Access read[2];
> +    S390Access write[2];
>  
>      HELPER_LOG("%s l %d dest %" PRIx64 " src %" PRIx64 "\n",
>                 __func__, l, dest, src);
> +    l++;
>  
> -    /* mvc and memmove do not behave the same when areas overlap! */
> -    /* mvc with source pointing to the byte after the destination is the
> -       same as memset with the first source byte */
> +    g_assert(l <= 256);
> +    access_prepare(env, write, ARRAY_SIZE(write), dest, l, MMU_DATA_STORE, ra);
> +
> +    /*
> +     * The result of MVC is as if moving single bytes from left to right
> +     * (in contrast to memmove()). It can be used like memset().
> +     */
>      if (dest == src + 1) {
> -        fast_memset(env, dest, cpu_ldub_data_ra(env, src, ra), l + 1, ra);
> -    } else if (dest < src || src + l < dest) {
> -        fast_memmove(env, dest, src, l + 1, ra);
> -    } else {
> -        /* slow version with byte accesses which always work */
> -        for (i = 0; i <= l; i++) {
> -            uint8_t x = cpu_ldub_data_ra(env, src + i, ra);
> -            cpu_stb_data_ra(env, dest + i, x, ra);
> -        }
> +        access_set(env, write, ARRAY_SIZE(write),
> +                   cpu_ldub_data_ra(env, src, ra), l);
> +        return env->cc_op;
> +    }
> +
> +    access_prepare(env, read, ARRAY_SIZE(read), src, l, MMU_DATA_LOAD, ra);
> +    if (dest < src || src + l <= dest) {
> +        access_copy(env, write, ARRAY_SIZE(write), read, ARRAY_SIZE(read), l,
> +                    TARGET_PAGE_SIZE);
> +    } else if (src < dest) {
> +        access_copy(env, write, ARRAY_SIZE(write), read, ARRAY_SIZE(read), l,
> +                    dest - src);
>      }
>  
>      return env->cc_op;
> 


