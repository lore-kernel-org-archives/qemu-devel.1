Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DE9C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 20:33:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB7B325281
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 20:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="bnW117qb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7B325281
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jn6f4-00072T-TT
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 16:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jn6eO-0005xv-8Y
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 16:33:12 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:38176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jn6eM-0001MP-HT
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 16:33:11 -0400
Received: by mail-qt1-x844.google.com with SMTP id z2so9160776qts.5
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=0zqCvujoZbph+2s/UDGvvCI8Fw7lKs568q/Kjwnbdhc=;
 b=bnW117qbsYaSNM1tAj6KCSnIOPdts2WX/ca2YuEOiTC19d9CP44rXzk080OqaHMWXt
 hnOE20UYT5cWyDv3UQ91Z6P6UQTNSjBZT92YJyGgIUUX9afo77tVEOCSozfVmH8skvHm
 WgRbYwp+Ujw4NbggCVHFXU5fyaTZuxgvw312KSG6gBTgNesyemPqmisf6YNXz9rhihAy
 tsMToSTK/E4QaS6mI45L06HUnE0/C7uK8XzozY7NYedQOLzw6uY8tnz4IbJZ3j9tS4uH
 nebfdM4K8RFYNjbaR+fcF7T3It1BoR978++jW8T6SDB6ar3UgEXrD2SYQ15nEMI8Dt0N
 v8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=0zqCvujoZbph+2s/UDGvvCI8Fw7lKs568q/Kjwnbdhc=;
 b=hHglOqwcxf3jdZDb5KHcLOsfgHPKEOgDNcIoLn0mqcv7H/RZh3aNGZEF6SZT9OT6fk
 lsjObf7izOWungaGlzEpTlartWX7sSQwD7bICnzCe1U700+AFOiqJEm9Kmy9saI2Hvzu
 l1Hn02VGmLB9rsaCnWmfEEU8YvYYZms6SUZkwGC+noUmE1/WWv1AH6QJ6QdXRdYJ4Y2a
 hEPrqEoiLoJbCp+L2vdr28ERdFKdj73qKMi7rLIqccrXxZByNk/Zu+fHCY0MaOBUlr3Z
 qV+2QzigG51XJ0gJXfrFq1Qdw+KQtdBqzEblo/HPZPpyF0pmjRzzPCHchjEpUPv1/isH
 gC9g==
X-Gm-Message-State: AOAM533zRPTXFmOgCNl3spLA900RcIjpQlerWFElJvrYivhOwdaJ1PEo
 7YQdRxCPXwvfvIt+Z9Hqavw27w==
X-Google-Smtp-Source: ABdhPJwfuQcxiLM0K6qRP4MIo73l5QtBkHwAV9idh0NGEUPaxAOJk4H8NuYQXGHlRWJIYNNiKsVjZg==
X-Received: by 2002:aed:2142:: with SMTP id 60mr13668150qtc.176.1592771588905; 
 Sun, 21 Jun 2020 13:33:08 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id x13sm1069527qts.57.2020.06.21.13.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2020 13:33:08 -0700 (PDT)
Date: Sun, 21 Jun 2020 16:33:07 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 3/6] cputlb: ensure we save the IOTLB data in case of
 reset
Message-ID: <20200621203307.GA168836@sff>
References: <20200610155509.12850-1-alex.bennee@linaro.org>
 <20200610155509.12850-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200610155509.12850-4-alex.bennee@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::844;
 envelope-from=cota@braap.org; helo=mail-qt1-x844.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: robert.foley@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, Paolo Bonzini <pbonzini@redhat.com>,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 10, 2020 at 16:55:06 +0100, Alex Bennée wrote:
> Any write to a device might cause a re-arrangement of memory
> triggering a TLB flush and potential re-size of the TLB invalidating
> previous entries. This would cause users of qemu_plugin_get_hwaddr()
> to see the warning:
> 
>   invalid use of qemu_plugin_get_hwaddr
> 
> because of the failed tlb_lookup which should always succeed. To
> prevent this we save the IOTLB data in case it is later needed by a
> plugin doing a lookup.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - save the entry instead of re-running the tlb_fill.
> 
> squash! cputlb: ensure we save the IOTLB entry in case of reset
> ---
>  accel/tcg/cputlb.c | 63 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index eb2cf9de5e6..9bf9e479c7c 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1058,6 +1058,47 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>      return val;
>  }
>  
> +#ifdef CONFIG_PLUGIN
> +
> +typedef struct SavedIOTLB {
> +    struct rcu_head rcu;
> +    struct SavedIOTLB **save_loc;
> +    MemoryRegionSection *section;
> +    hwaddr mr_offset;
> +} SavedIOTLB;
> +
> +static void clean_saved_entry(SavedIOTLB *s)
> +{
> +    atomic_rcu_set(s->save_loc, NULL);

This will race with the CPU thread that sets saved_for_plugin in
save_iotlb_data().

> +    g_free(s);
> +}
> +
> +static __thread SavedIOTLB *saved_for_plugin;

Apologies if this has been discussed, but why is this using TLS
variables and not state embedded in CPUState?
I see that qemu_plugin_get_hwaddr does not take a cpu_index, but
maybe it should? We could then just embed the RCU pointer in CPUState.

> +
> +/*
> + * Save a potentially trashed IOTLB entry for later lookup by plugin.
> + *
> + * We also need to track the thread storage address because the RCU
> + * cleanup that runs when we leave the critical region (the current
> + * execution) is actually in a different thread.
> + */
> +static void save_iotlb_data(MemoryRegionSection *section, hwaddr mr_offset)
> +{
> +    SavedIOTLB *s = g_new(SavedIOTLB, 1);
> +    s->save_loc = &saved_for_plugin;
> +    s->section = section;
> +    s->mr_offset = mr_offset;
> +    atomic_rcu_set(&saved_for_plugin, s);
> +    call_rcu(s, clean_saved_entry, rcu);

Here we could just publish the new pointer and g_free_rcu the old
one, if any.

> +}
> +
> +#else
> +static void save_iotlb_data(MemoryRegionSection *section, hwaddr mr_offset)
> +{
> +    /* do nothing */
> +}
> +#endif
> +
>  static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>                        int mmu_idx, uint64_t val, target_ulong addr,
>                        uintptr_t retaddr, MemOp op)
> @@ -1077,6 +1118,12 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>      }
>      cpu->mem_io_pc = retaddr;
>  
> +    /*
> +     * The memory_region_dispatch may trigger a flush/resize
> +     * so for plugins we save the iotlb_data just in case.
> +     */
> +    save_iotlb_data(section, mr_offset);
> +
>      if (mr->global_locking && !qemu_mutex_iothread_locked()) {
>          qemu_mutex_lock_iothread();
>          locked = true;
> @@ -1091,6 +1138,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>                                 MMU_DATA_STORE, mmu_idx, iotlbentry->attrs, r,
>                                 retaddr);
>      }
> +

Stray whitespace change.

>      if (locked) {
>          qemu_mutex_unlock_iothread();
>      }
> @@ -1366,8 +1414,11 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
>   * in the softmmu lookup code (or helper). We don't handle re-fills or
>   * checking the victim table. This is purely informational.
>   *
> - * This should never fail as the memory access being instrumented
> - * should have just filled the TLB.
> + * This almost never fails as the memory access being instrumented
> + * should have just filled the TLB. The one corner case is io_writex
> + * which can cause TLB flushes and potential resizing of the TLBs
> + * loosing the information we need. In those cases we need to recover
> + * data from a thread local copy of the io_tlb entry.
>   */
>  
>  bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
> @@ -1391,6 +1442,14 @@ bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
>              data->v.ram.hostaddr = addr + tlbe->addend;
>          }
>          return true;
> +    } else {
> +        SavedIOTLB *saved = atomic_rcu_read(&saved_for_plugin);
> +        if (saved) {
> +            data->is_io = true;
> +            data->v.io.section = saved->section;
> +            data->v.io.offset = saved->mr_offset;
> +            return true;
> +        }

Shouldn't we check that the contents of the saved IOTLB match the
parameters of the lookup? Otherwise passing a random address is likely
to land here.

Thanks,
		Emilio

