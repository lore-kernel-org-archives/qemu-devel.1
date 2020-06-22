Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92447C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4741A206C1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VhnuFSR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4741A206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnIQa-0001qZ-C0
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnILy-0003gN-1G
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:03:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnILv-0005ah-RF
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:02:57 -0400
Received: by mail-wr1-x444.google.com with SMTP id l10so15817963wrr.10
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 02:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FXC0KhxmQ0OXCKNmT03qAIjs5XeHUZMjjJ4+72xaM8Y=;
 b=VhnuFSR2sZpGdxh8+EUlB+DZo5LBPacLuc8VwrUZRgPZHDk5TJQEwPDxBdGAC/jLGY
 3zuw72vj48xJGZgEdobXBuDc4JQ4sxSt/Qp0E4g/cnLTdOvSBe883TYWtVz9DYaKjjLE
 C6CQ9oCox1q0HwEpkN/r3E/bgWYgL6/QIp2/EqkOZB0Tk0uLONH3ArE46vFEG5p4UcxM
 s5gJu1/XaZbovSDIuwT5hGLwK1b1GMMHpPIt24v2OAPffU1p9YTbjNvguNEL3lxrRM5O
 hoUHNfQHzEmofGdv8GjTNFSCGiyqvoFn9ao1DTmyZAjGuiRLM6xVK8nI1Z/WR8O/7gQY
 cibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FXC0KhxmQ0OXCKNmT03qAIjs5XeHUZMjjJ4+72xaM8Y=;
 b=tVoWarR4tE3rxU4kP2TEbD48GwWtx4dInfwSokRS/NiNAVr48KZdpZxN4HK0gdGxPI
 evpnmbm3JUoSgEwm0AV2LEUSvwRaQ+sYmyRAAmoZCFQma0ls461pVl97KNLjZJnlwqBU
 d6SK7BVs0J/H/E2Py9IRRqEQ+KkO0yLNKDeyEpO22MP7xkJ2RLDHIdGkDy6ceGDsrG9k
 3WUFJR5f2uT59kmBjdRNhhkAm361bCuCOVAGDuwAtmwvbdKTp/4+WQarAYKoBKCEkgQT
 kbK4BdGYrcXBy2lbmcegOpD3kVYWr9RIPXflzdHYrY95tbiS+q6x7Z2Vfr2I+6Ajoq6m
 MkpQ==
X-Gm-Message-State: AOAM533j8rqd33uP4mgoBQjZPtyT+zRLmkg11jZu+CKwkxtkoo7V7E1w
 e6EHY6j0Db5wzrWDssmVyBkyTg==
X-Google-Smtp-Source: ABdhPJxsh+kuyF+9BcnEfFMytVUcSZNqvI5ZQNoY7aPuANVAqj3lBFD2jIu679qtCn36wrXwSGehcA==
X-Received: by 2002:a5d:420e:: with SMTP id n14mr19030321wrq.164.1592816572478; 
 Mon, 22 Jun 2020 02:02:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h29sm18123377wrc.78.2020.06.22.02.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 02:02:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B83D41FF7E;
 Mon, 22 Jun 2020 10:02:50 +0100 (BST)
References: <20200610155509.12850-1-alex.bennee@linaro.org>
 <20200610155509.12850-4-alex.bennee@linaro.org>
 <20200621203307.GA168836@sff>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Emilio G. Cota" <cota@braap.org>
Subject: Re: [PATCH  v2 3/6] cputlb: ensure we save the IOTLB data in case
 of reset
In-reply-to: <20200621203307.GA168836@sff>
Date: Mon, 22 Jun 2020 10:02:50 +0100
Message-ID: <87imfja2x1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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


Emilio G. Cota <cota@braap.org> writes:

> On Wed, Jun 10, 2020 at 16:55:06 +0100, Alex Benn=C3=A9e wrote:
>> Any write to a device might cause a re-arrangement of memory
>> triggering a TLB flush and potential re-size of the TLB invalidating
>> previous entries. This would cause users of qemu_plugin_get_hwaddr()
>> to see the warning:
>>=20
>>   invalid use of qemu_plugin_get_hwaddr
>>=20
>> because of the failed tlb_lookup which should always succeed. To
>> prevent this we save the IOTLB data in case it is later needed by a
>> plugin doing a lookup.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> ---
>> v2
>>   - save the entry instead of re-running the tlb_fill.
>>=20
>> squash! cputlb: ensure we save the IOTLB entry in case of reset
>> ---
>>  accel/tcg/cputlb.c | 63 ++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 61 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> index eb2cf9de5e6..9bf9e479c7c 100644
>> --- a/accel/tcg/cputlb.c
>> +++ b/accel/tcg/cputlb.c
>> @@ -1058,6 +1058,47 @@ static uint64_t io_readx(CPUArchState *env, CPUIO=
TLBEntry *iotlbentry,
>>      return val;
>>  }
>>=20=20
>> +#ifdef CONFIG_PLUGIN
>> +
>> +typedef struct SavedIOTLB {
>> +    struct rcu_head rcu;
>> +    struct SavedIOTLB **save_loc;
>> +    MemoryRegionSection *section;
>> +    hwaddr mr_offset;
>> +} SavedIOTLB;
>> +
>> +static void clean_saved_entry(SavedIOTLB *s)
>> +{
>> +    atomic_rcu_set(s->save_loc, NULL);
>
> This will race with the CPU thread that sets saved_for_plugin in
> save_iotlb_data().

Surely that only happens outside the critical section?

>
>> +    g_free(s);
>> +}
>> +
>> +static __thread SavedIOTLB *saved_for_plugin;
>
> Apologies if this has been discussed, but why is this using TLS
> variables and not state embedded in CPUState?

Good point - I guess I;m being lazy.

> I see that qemu_plugin_get_hwaddr does not take a cpu_index, but
> maybe it should? We could then just embed the RCU pointer in CPUState.
>
>> +
>> +/*
>> + * Save a potentially trashed IOTLB entry for later lookup by plugin.
>> + *
>> + * We also need to track the thread storage address because the RCU
>> + * cleanup that runs when we leave the critical region (the current
>> + * execution) is actually in a different thread.
>> + */
>> +static void save_iotlb_data(MemoryRegionSection *section, hwaddr mr_off=
set)
>> +{
>> +    SavedIOTLB *s =3D g_new(SavedIOTLB, 1);
>> +    s->save_loc =3D &saved_for_plugin;
>> +    s->section =3D section;
>> +    s->mr_offset =3D mr_offset;
>> +    atomic_rcu_set(&saved_for_plugin, s);
>> +    call_rcu(s, clean_saved_entry, rcu);
>
> Here we could just publish the new pointer and g_free_rcu the old
> one, if any.

That would be simpler. I'll re-spin.

>
>> +}
>> +
>> +#else
>> +static void save_iotlb_data(MemoryRegionSection *section, hwaddr mr_off=
set)
>> +{
>> +    /* do nothing */
>> +}
>> +#endif
>> +
>>  static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>>                        int mmu_idx, uint64_t val, target_ulong addr,
>>                        uintptr_t retaddr, MemOp op)
>> @@ -1077,6 +1118,12 @@ static void io_writex(CPUArchState *env, CPUIOTLB=
Entry *iotlbentry,
>>      }
>>      cpu->mem_io_pc =3D retaddr;
>>=20=20
>> +    /*
>> +     * The memory_region_dispatch may trigger a flush/resize
>> +     * so for plugins we save the iotlb_data just in case.
>> +     */
>> +    save_iotlb_data(section, mr_offset);
>> +
>>      if (mr->global_locking && !qemu_mutex_iothread_locked()) {
>>          qemu_mutex_lock_iothread();
>>          locked =3D true;
>> @@ -1091,6 +1138,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBE=
ntry *iotlbentry,
>>                                 MMU_DATA_STORE, mmu_idx, iotlbentry->att=
rs, r,
>>                                 retaddr);
>>      }
>> +
>
> Stray whitespace change.
>
>>      if (locked) {
>>          qemu_mutex_unlock_iothread();
>>      }
>> @@ -1366,8 +1414,11 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_pt=
r addr,
>>   * in the softmmu lookup code (or helper). We don't handle re-fills or
>>   * checking the victim table. This is purely informational.
>>   *
>> - * This should never fail as the memory access being instrumented
>> - * should have just filled the TLB.
>> + * This almost never fails as the memory access being instrumented
>> + * should have just filled the TLB. The one corner case is io_writex
>> + * which can cause TLB flushes and potential resizing of the TLBs
>> + * loosing the information we need. In those cases we need to recover
>> + * data from a thread local copy of the io_tlb entry.
>>   */
>>=20=20
>>  bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
>> @@ -1391,6 +1442,14 @@ bool tlb_plugin_lookup(CPUState *cpu, target_ulon=
g addr, int mmu_idx,
>>              data->v.ram.hostaddr =3D addr + tlbe->addend;
>>          }
>>          return true;
>> +    } else {
>> +        SavedIOTLB *saved =3D atomic_rcu_read(&saved_for_plugin);
>> +        if (saved) {
>> +            data->is_io =3D true;
>> +            data->v.io.section =3D saved->section;
>> +            data->v.io.offset =3D saved->mr_offset;
>> +            return true;
>> +        }
>
> Shouldn't we check that the contents of the saved IOTLB match the
> parameters of the lookup? Otherwise passing a random address is likely
> to land here.

Good point - I'm being too trusting here ;-)

Thanks for the review.

--=20
Alex Benn=C3=A9e

