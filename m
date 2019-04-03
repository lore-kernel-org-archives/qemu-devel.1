Received: from eggs.gnu.org ([209.51.188.92]:51828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hBe0k-0008Hs-Jt
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hBe0j-00049r-Ik
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:24:54 -0400
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-18-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fbf79534-7e95-6999-ecd3-f142086c349a@redhat.com>
Date: Wed, 3 Apr 2019 13:17:18 +0200
MIME-Version: 1.0
In-Reply-To: <20190403034358.21999-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/26] target/s390x: Convert to
 CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>

>  #endif /* CONFIG_USER_ONLY */
> +
> +bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool probe, uintptr_t retaddr)
> +{
> +    S390CPU *cpu = S390_CPU(cs);
> +
> +#ifndef CONFIG_USER_ONLY
> +    CPUS390XState *env = &cpu->env;
> +    target_ulong vaddr, raddr;
> +    uint64_t asc;
> +    int prot, fail;
> +
> +    qemu_log_mask(CPU_LOG_MMU, "%s: addr 0x%" VADDR_PRIx " rw %d mmu_idx %d\n",
> +                  __func__, address, access_type, mmu_idx);
> +
> +    vaddr = address;
> +
> +    if (mmu_idx < MMU_REAL_IDX) {
> +        asc = cpu_mmu_idx_to_asc(mmu_idx);
> +        /* 31-Bit mode */
> +        if (!(env->psw.mask & PSW_MASK_64)) {
> +            vaddr &= 0x7fffffff;
> +        }
> +        fail = mmu_translate(env, vaddr, access_type, asc, &raddr, &prot, true);
> +    } else if (mmu_idx == MMU_REAL_IDX) {
> +        /* 31-Bit mode */
> +        if (!(env->psw.mask & PSW_MASK_64)) {
> +            vaddr &= 0x7fffffff;
> +        }
> +        fail = mmu_translate_real(env, vaddr, access_type, &raddr, &prot);
> +    } else {
> +        g_assert_not_reached();
> +    }
> +
> +    /* check out of RAM access */
> +    if (!fail &&
> +        !address_space_access_valid(&address_space_memory, raddr,
> +                                    TARGET_PAGE_SIZE, access_type,
> +                                    MEMTXATTRS_UNSPECIFIED)) {
> +        qemu_log_mask(CPU_LOG_MMU,
> +                      "%s: raddr %" PRIx64 " > ram_size %" PRIx64 "\n",
> +                      __func__, (uint64_t)raddr, (uint64_t)ram_size);
> +        trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);
> +        fail = 1;
> +    }
> +
> +    if (!fail) {
> +        qemu_log_mask(CPU_LOG_MMU,
> +                      "%s: set tlb %" PRIx64 " -> %" PRIx64 " (%x)\n",
> +                      __func__, (uint64_t)vaddr, (uint64_t)raddr, prot);
> +        tlb_set_page(cs, address & TARGET_PAGE_MASK, raddr, prot,
> +                     mmu_idx, TARGET_PAGE_SIZE);
> +        return true;
> +    }
> +    if (probe) {
> +        return false;
> +    }
> +#else
> +    trigger_pgm_exception(&cpu->env, PGM_ADDRESSING, ILEN_AUTO);
> +    /*
> +     * On real machines this value is dropped into LowMem.  Since this
> +     * is userland, simply put this someplace that cpu_loop can find it.
> +     */
> +    cpu->env.__excp_addr = address;
> +#endif
> +
> +    cpu_restore_state(cs, retaddr, true);
> +
> +    /*
> +     * Note that handle_mmu_fault sets ilen to either 2 (for code)

This comment no longer matches.

> +     * or AUTO (for data).  We can resolve AUTO now, as if it was
> +     * set to UNWIND -- that will have been done via assignment
> +     * in cpu_restore_state.  Otherwise re-examine access_type.
> +     */
> +    if (access_type == MMU_INST_FETCH) {
> +        CPUS390XState *env = cs->env_ptr;
> +        env->int_pgm_ilen = 2;
> +    }
> +
> +    cpu_loop_exit(cs);
> +}
> +

Apart from that, looks good to me.

-- 

Thanks,

David / dhildenb
