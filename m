Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A45C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 16:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2041D20859
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 16:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2041D20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48293 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVIgC-00051i-DV
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 12:40:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hVIfI-0004at-Ag
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hVIfF-0007Tc-WF
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:40:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1hVIfF-0007R3-Oq
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:39:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id e19so325134wme.1
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 09:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
	:message-id:mime-version;
	bh=eAHIzIuJGIJSiKQ7HrZdPM5HOr3DLeQrcixUyumboFk=;
	b=XaCcxpQOdwdUdgG0c2ifdTRg5EPQvoPt+xE49ILkCmiKV6QFjQZZPB1g0K5CUzHca4
	njlvXP7KfdMjIsUQgQuIwlNLwbMKlHzVNuzAQ2CXBFKFKA8hIGnvj1s1P8hi/9ZSabob
	USrrlPcieh1FFs137lHaPgwY6muJ4xpAhvT9Fdy/thxDp+1dsIQ4Pnx9DHES1b4CeaNC
	RiHjEeQHs3dD3rjVyh5wwwnsUNbpVuenhODxmI1KHE5icVstyQCKW0PU3QNOEX862bIH
	Q8yo9RbU+kXmyZqZEW7nJNeVsdCXvMiwEF/0RyW7NEDk75LZeiTHcxnbqYkF41g5OWEk
	75iQ==
X-Gm-Message-State: APjAAAWdYVGOPoAIDM6XKb1OwHrzlxPebfEdVJf1jVgtRR7vFyss8A7w
	WDGIn1v6M5BtI7LuLSdptWqSxw==
X-Google-Smtp-Source: APXvYqw7FrNSX5C8Z6aZV/w3BaMt0Qm6eBSoDZ/80Dm+Yf/DsxJ9OK6GUJzTwyZKj5xhjiIQ+1ZN7Q==
X-Received: by 2002:a1c:35c9:: with SMTP id
	c192mr10700393wma.147.1558975194734; 
	Mon, 27 May 2019 09:39:54 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
	[213.175.37.10])
	by smtp.gmail.com with ESMTPSA id n7sm607891wrw.64.2019.05.27.09.39.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 27 May 2019 09:39:54 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>
In-Reply-To: <20190527155231.GB2362@rkaganb.sw.ru>
References: <20190517141924.19024-1-vkuznets@redhat.com>
	<20190517141924.19024-3-vkuznets@redhat.com>
	<20190527155231.GB2362@rkaganb.sw.ru>
Date: Mon, 27 May 2019 18:39:53 +0200
Message-ID: <87h89fn95y.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 2/9] i386/kvm: add support for
 KVM_GET_SUPPORTED_HV_CPUID
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Fri, May 17, 2019 at 04:19:17PM +0200, Vitaly Kuznetsov wrote:
>> KVM now supports reporting supported Hyper-V features through CPUID
>> (KVM_GET_SUPPORTED_HV_CPUID ioctl). Going forward, this is going to be
>> the only way to announce new functionality and this has already happened
>> with Direct Mode stimers.
>> 
>> While we could just support KVM_GET_SUPPORTED_HV_CPUID for new features,
>> it seems to be beneficial to use it for all Hyper-V enlightenments when
>> possible. This way we can implement 'hv-all' pass-through mode giving the
>> guest all supported Hyper-V features even when QEMU knows nothing about
>> them.
>> 
>> Implementation-wise we create a new kvm_hyperv_properties structure
>> defining Hyper-V features, get_supported_hv_cpuid()/
>> get_supported_hv_cpuid_legacy() returning the supported CPUID set and
>> a bit over-engineered hv_cpuid_check_and_set() which we will also be
>> used to set cpu->hyperv_* properties for 'hv-all' mode.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  target/i386/kvm.c | 474 ++++++++++++++++++++++++++++++++++------------
>>  1 file changed, 356 insertions(+), 118 deletions(-)
>> 
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index 3daac1e4f4..6ead422efa 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -684,156 +684,394 @@ static bool tsc_is_stable_and_known(CPUX86State *env)
>>          || env->user_tsc_khz;
>>  }
>>  
>> -static int hyperv_handle_properties(CPUState *cs)
>> +static struct {
>> +    const char *desc;
>> +    struct {
>> +        uint32_t fw;
>> +        uint32_t bits;
>> +    } flags[2];
>> +} kvm_hyperv_properties[] = {
>> +    [HYPERV_FEAT_RELAXED] = {
>> +        .desc = "relaxed timing (hv-relaxed)",
>
> I'd still like to avoid repeating the feature names.

I didn't find a convenient way to extract this from
x86_cpu_properties[]. This can be done but to me it looked like
over-engineering as the only reason we have this here is to have a
somewhat nicer message when something is unsupported.

>
>> +        .flags = {
>> +            {.fw = FEAT_HYPERV_EAX,
>> +             .bits = HV_HYPERCALL_AVAILABLE},
>> +            {.fw = FEAT_HV_RECOMM_EAX,
>> +             .bits = HV_RELAXED_TIMING_RECOMMENDED}
>> +        }
>> +    },
>> +    [HYPERV_FEAT_VAPIC] = {
>> +        .desc = "virtual APIC (hv-vapic)",
>> +        .flags = {
>> +            {.fw = FEAT_HYPERV_EAX,
>> +             .bits = HV_HYPERCALL_AVAILABLE | HV_APIC_ACCESS_AVAILABLE},
>> +            {.fw = FEAT_HV_RECOMM_EAX,
>> +             .bits = HV_APIC_ACCESS_RECOMMENDED}
>> +        }
>> +    },
>> +    [HYPERV_FEAT_TIME] = {
>> +        .desc = "clocksources (hv-time)",
>> +        .flags = {
>> +            {.fw = FEAT_HYPERV_EAX,
>> +             .bits = HV_HYPERCALL_AVAILABLE | HV_TIME_REF_COUNT_AVAILABLE |
>> +             HV_REFERENCE_TSC_AVAILABLE}
>> +        }
>> +    },
>> +    [HYPERV_FEAT_CRASH] = {
>> +        .desc = "crash MSRs (hv-crash)",
>> +        .flags = {
>> +            {.fw = FEAT_HYPERV_EDX,
>> +             .bits = HV_GUEST_CRASH_MSR_AVAILABLE}
>> +        }
>> +    },
>> +    [HYPERV_FEAT_RESET] = {
>> +        .desc = "reset MSR (hv-reset)",
>> +        .flags = {
>> +            {.fw = FEAT_HYPERV_EAX,
>> +             .bits = HV_RESET_AVAILABLE}
>> +        }
>> +    },
>> +    [HYPERV_FEAT_VPINDEX] = {
>> +        .desc = "VP_INDEX MSR (hv-vpindex)",
>> +        .flags = {
>> +            {.fw = FEAT_HYPERV_EAX,
>> +             .bits = HV_VP_INDEX_AVAILABLE}
>> +        }
>> +    },
>> +    [HYPERV_FEAT_RUNTIME] = {
>> +        .desc = "VP_RUNTIME MSR (hv-runtime)",
>> +        .flags = {
>> +            {.fw = FEAT_HYPERV_EAX,
>> +             .bits = HV_VP_RUNTIME_AVAILABLE}
>> +        }
>> +    },
>> +    [HYPERV_FEAT_SYNIC] = {
>> +        .desc = "synthetic interrupt controller (hv-synic)",
>> +        .flags = {
>> +            {.fw = FEAT_HYPERV_EAX,
>> +             .bits = HV_SYNIC_AVAILABLE}
>> +        }
>> +    },
>> +    [HYPERV_FEAT_STIMER] = {
>> +        .desc = "synthetic timers (hv-stimer)",
>> +        .flags = {
>> +            {.fw = FEAT_HYPERV_EAX,
>> +             .bits = HV_SYNTIMERS_AVAILABLE}
>> +        }
>> +    },
>> +    [HYPERV_FEAT_FREQUENCIES] = {
>> +        .desc = "frequency MSRs (hv-frequencies)",
>> +        .flags = {
>> +            {.fw = FEAT_HYPERV_EAX,
>> +             .bits = HV_ACCESS_FREQUENCY_MSRS},
>> +            {.fw = FEAT_HYPERV_EDX,
>> +             .bits = HV_FREQUENCY_MSRS_AVAILABLE}
>> +        }
>> +    },
>> +    [HYPERV_FEAT_REENLIGHTENMENT] = {
>> +        .desc = "reenlightenment MSRs (hv-reenlightenment)",
>> +        .flags = {
>> +            {.fw = FEAT_HYPERV_EAX,
>> +             .bits = HV_ACCESS_REENLIGHTENMENTS_CONTROL}
>> +        }
>> +    },
>> +    [HYPERV_FEAT_TLBFLUSH] = {
>> +        .desc = "paravirtualized TLB flush (hv-tlbflush)",
>> +        .flags = {
>> +            {.fw = FEAT_HV_RECOMM_EAX,
>> +             .bits = HV_REMOTE_TLB_FLUSH_RECOMMENDED |
>> +             HV_EX_PROCESSOR_MASKS_RECOMMENDED}
>> +        }
>> +    },
>> +    [HYPERV_FEAT_EVMCS] = {
>> +        .desc = "enlightened VMCS (hv-evmcs)",
>> +        .flags = {
>> +            {.fw = FEAT_HV_RECOMM_EAX,
>> +             .bits = HV_ENLIGHTENED_VMCS_RECOMMENDED}
>> +        }
>> +    },
>> +    [HYPERV_FEAT_IPI] = {
>> +        .desc = "paravirtualized IPI (hv-ipi)",
>> +        .flags = {
>> +            {.fw = FEAT_HV_RECOMM_EAX,
>> +             .bits = HV_CLUSTER_IPI_RECOMMENDED |
>> +             HV_EX_PROCESSOR_MASKS_RECOMMENDED}
>> +        }
>> +    },
>> +};
>> +
>> +static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max)
>> +{
>> +    struct kvm_cpuid2 *cpuid;
>> +    int r, size;
>> +
>> +    size = sizeof(*cpuid) + max * sizeof(*cpuid->entries);
>> +    cpuid = g_malloc0(size);
>> +    cpuid->nent = max;
>> +
>> +    r = kvm_vcpu_ioctl(cs, KVM_GET_SUPPORTED_HV_CPUID, cpuid);
>> +    if (r == 0 && cpuid->nent >= max) {
>> +        r = -E2BIG;
>> +    }
>> +    if (r < 0) {
>> +        if (r == -E2BIG) {
>> +            g_free(cpuid);
>> +            return NULL;
>> +        } else {
>> +            fprintf(stderr, "KVM_GET_SUPPORTED_HV_CPUID failed: %s\n",
>> +                    strerror(-r));
>> +            exit(1);
>> +        }
>> +    }
>> +    return cpuid;
>> +}
>> +
>> +/*
>> + * Run KVM_GET_SUPPORTED_HV_CPUID ioctl(), allocating a buffer large enough
>> + * for all entries.
>> + */
>> +static struct kvm_cpuid2 *get_supported_hv_cpuid(CPUState *cs)
>> +{
>> +    struct kvm_cpuid2 *cpuid;
>> +    int max = 7; /* 0x40000000..0x40000005, 0x4000000A */
>> +
>> +    /*
>> +     * When the buffer is too small, KVM_GET_SUPPORTED_HV_CPUID fails with
>> +     * -E2BIG, however, it doesn't report back the right size. Keep increasing
>> +     * it and re-trying until we succeed.
>> +     */
>
> I'm still missing the idea of reiterating more than once: the ioctl
> returns the actual size of the array.

Hm, I think I checked that and it doesn't seem to be the case.

The code in kvm_vcpu_ioctl_get_hv_cpuid():

	if (cpuid->nent < nent)
		return -E2BIG;

	if (cpuid->nent > nent)
		cpuid->nent = nent;

(I think I even ran a test after your comment on v1 and it it
confirmed nent is not set on E2BIG). Am I missing something obvious?

>
>> +    while ((cpuid = try_get_hv_cpuid(cs, max)) == NULL) {
>> +        max++;
>> +    }
>> +    return cpuid;
>> +}
>> +
>> +/*
>> + * When KVM_GET_SUPPORTED_HV_CPUID is not supported we fill CPUID feature
>> + * leaves from KVM_CAP_HYPERV* and present MSRs data.
>> + */
>> +static struct kvm_cpuid2 *get_supported_hv_cpuid_legacy(CPUState *cs)
>>  {
>>      X86CPU *cpu = X86_CPU(cs);
>> -    CPUX86State *env = &cpu->env;
>> +    struct kvm_cpuid2 *cpuid;
>> +    struct kvm_cpuid_entry2 *entry_feat, *entry_recomm;
>> +
>> +    /* HV_CPUID_FEATURES, HV_CPUID_ENLIGHTMENT_INFO */
>> +    cpuid = g_malloc0(sizeof(*cpuid) + 2 * sizeof(*cpuid->entries));
>> +    cpuid->nent = 2;
>> +
>> +    /* HV_CPUID_VENDOR_AND_MAX_FUNCTIONS */
>> +    entry_feat = &cpuid->entries[0];
>> +    entry_feat->function = HV_CPUID_FEATURES;
>>  
>> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_RELAXED)) {
>> -        env->features[FEAT_HYPERV_EAX] |= HV_HYPERCALL_AVAILABLE;
>> +    entry_recomm = &cpuid->entries[1];
>> +    entry_recomm->function = HV_CPUID_ENLIGHTMENT_INFO;
>> +    entry_recomm->ebx = cpu->hyperv_spinlock_attempts;
>> +
>> +    if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV) > 0) {
>> +        entry_feat->eax |= HV_HYPERCALL_AVAILABLE;
>> +        entry_feat->eax |= HV_APIC_ACCESS_AVAILABLE;
>> +        entry_feat->edx |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
>> +        entry_recomm->eax |= HV_RELAXED_TIMING_RECOMMENDED;
>> +        entry_recomm->eax |= HV_APIC_ACCESS_RECOMMENDED;
>>      }
>> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VAPIC)) {
>> -        env->features[FEAT_HYPERV_EAX] |= HV_HYPERCALL_AVAILABLE;
>> -        env->features[FEAT_HYPERV_EAX] |= HV_APIC_ACCESS_AVAILABLE;
>> +
>> +    if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_TIME) > 0) {
>> +        entry_feat->eax |= HV_TIME_REF_COUNT_AVAILABLE;
>> +        entry_feat->eax |= HV_REFERENCE_TSC_AVAILABLE;
>>      }
>> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_TIME)) {
>> -        if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_TIME) <= 0) {
>> -            fprintf(stderr, "Hyper-V clocksources "
>> -                    "(requested by 'hv-time' cpu flag) "
>> -                    "are not supported by kernel\n");
>> -            return -ENOSYS;
>> -        }
>> -        env->features[FEAT_HYPERV_EAX] |= HV_HYPERCALL_AVAILABLE;
>> -        env->features[FEAT_HYPERV_EAX] |= HV_TIME_REF_COUNT_AVAILABLE;
>> -        env->features[FEAT_HYPERV_EAX] |= HV_REFERENCE_TSC_AVAILABLE;
>> +
>> +    if (has_msr_hv_frequencies) {
>> +        entry_feat->eax |= HV_ACCESS_FREQUENCY_MSRS;
>> +        entry_feat->edx |= HV_FREQUENCY_MSRS_AVAILABLE;
>>      }
>> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_FREQUENCIES)) {
>> -        if (!has_msr_hv_frequencies) {
>> -            fprintf(stderr, "Hyper-V frequency MSRs "
>> -                    "(requested by 'hv-frequencies' cpu flag) "
>> -                    "are not supported by kernel\n");
>> -            return -ENOSYS;
>> -        }
>> -        env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
>> -        env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
>> +
>> +    if (has_msr_hv_crash) {
>> +        entry_feat->edx |= HV_GUEST_CRASH_MSR_AVAILABLE;
>>      }
>> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_CRASH)) {
>> -        if (!has_msr_hv_crash) {
>> -            fprintf(stderr, "Hyper-V crash MSRs "
>> -                    "(requested by 'hv-crash' cpu flag) "
>> -                    "are not supported by kernel\n");
>> -            return -ENOSYS;
>> -        }
>> -        env->features[FEAT_HYPERV_EDX] |= HV_GUEST_CRASH_MSR_AVAILABLE;
>> +
>> +    if (has_msr_hv_reenlightenment) {
>> +        entry_feat->eax |= HV_ACCESS_REENLIGHTENMENTS_CONTROL;
>>      }
>> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_REENLIGHTENMENT)) {
>> -        if (!has_msr_hv_reenlightenment) {
>> -            fprintf(stderr,
>> -                    "Hyper-V Reenlightenment MSRs "
>> -                    "(requested by 'hv-reenlightenment' cpu flag) "
>> -                    "are not supported by kernel\n");
>> -            return -ENOSYS;
>> -        }
>> -        env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_REENLIGHTENMENTS_CONTROL;
>> +
>> +    if (has_msr_hv_reset) {
>> +        entry_feat->eax |= HV_RESET_AVAILABLE;
>>      }
>> -    env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
>> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_RESET)) {
>> -        if (!has_msr_hv_reset) {
>> -            fprintf(stderr, "Hyper-V reset MSR "
>> -                    "(requested by 'hv-reset' cpu flag) "
>> -                    "is not supported by kernel\n");
>> -            return -ENOSYS;
>> -        }
>> -        env->features[FEAT_HYPERV_EAX] |= HV_RESET_AVAILABLE;
>> +
>> +    if (has_msr_hv_vpindex) {
>> +        entry_feat->eax |= HV_VP_INDEX_AVAILABLE;
>>      }
>> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX)) {
>> -        if (!has_msr_hv_vpindex) {
>> -            fprintf(stderr, "Hyper-V VP_INDEX MSR "
>> -                    "(requested by 'hv-vpindex' cpu flag) "
>> -                    "is not supported by kernel\n");
>> -            return -ENOSYS;
>> -        }
>> -        env->features[FEAT_HYPERV_EAX] |= HV_VP_INDEX_AVAILABLE;
>> +
>> +    if (has_msr_hv_runtime) {
>> +        entry_feat->eax |= HV_VP_RUNTIME_AVAILABLE;
>>      }
>> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_RUNTIME)) {
>> -        if (!has_msr_hv_runtime) {
>> -            fprintf(stderr, "Hyper-V VP_RUNTIME MSR "
>> -                    "(requested by 'hv-runtime' cpu flag) "
>> -                    "is not supported by kernel\n");
>> -            return -ENOSYS;
>> +
>> +    if (has_msr_hv_synic) {
>> +        unsigned int cap = cpu->hyperv_synic_kvm_only ?
>> +            KVM_CAP_HYPERV_SYNIC : KVM_CAP_HYPERV_SYNIC2;
>> +
>> +        if (kvm_check_extension(cs->kvm_state, cap) > 0) {
>> +            entry_feat->eax |= HV_SYNIC_AVAILABLE;
>>          }
>> -        env->features[FEAT_HYPERV_EAX] |= HV_VP_RUNTIME_AVAILABLE;
>>      }
>> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
>> -        unsigned int cap = KVM_CAP_HYPERV_SYNIC;
>> -        if (!cpu->hyperv_synic_kvm_only) {
>> -            if (!hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX)) {
>> -                fprintf(stderr, "Hyper-V SynIC "
>> -                        "(requested by 'hv-synic' cpu flag) "
>> -                        "requires Hyper-V VP_INDEX ('hv-vpindex')\n");
>> -            return -ENOSYS;
>> -            }
>> -            cap = KVM_CAP_HYPERV_SYNIC2;
>> -        }
>>  
>> -        if (!has_msr_hv_synic || !kvm_check_extension(cs->kvm_state, cap)) {
>> -            fprintf(stderr, "Hyper-V SynIC (requested by 'hv-synic' cpu flag) "
>> -                    "is not supported by kernel\n");
>> -            return -ENOSYS;
>> -        }
>> +    if (has_msr_hv_stimer) {
>> +        entry_feat->eax |= HV_SYNTIMERS_AVAILABLE;
>> +    }
>>  
>> -        env->features[FEAT_HYPERV_EAX] |= HV_SYNIC_AVAILABLE;
>> +    if (kvm_check_extension(cs->kvm_state,
>> +                            KVM_CAP_HYPERV_TLBFLUSH) > 0) {
>> +        entry_recomm->eax |= HV_REMOTE_TLB_FLUSH_RECOMMENDED;
>> +        entry_recomm->eax |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
>>      }
>> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_STIMER)) {
>> -        if (!has_msr_hv_stimer) {
>> -            fprintf(stderr, "Hyper-V timers aren't supported by kernel\n");
>> -            return -ENOSYS;
>> -        }
>> -        env->features[FEAT_HYPERV_EAX] |= HV_SYNTIMERS_AVAILABLE;
>> +
>> +    if (kvm_check_extension(cs->kvm_state,
>> +                            KVM_CAP_HYPERV_ENLIGHTENED_VMCS) > 0) {
>> +        entry_recomm->eax |= HV_ENLIGHTENED_VMCS_RECOMMENDED;
>>      }
>> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_RELAXED)) {
>> -        env->features[FEAT_HV_RECOMM_EAX] |= HV_RELAXED_TIMING_RECOMMENDED;
>> +
>> +    if (kvm_check_extension(cs->kvm_state,
>> +                            KVM_CAP_HYPERV_SEND_IPI) > 0) {
>> +        entry_recomm->eax |= HV_CLUSTER_IPI_RECOMMENDED;
>> +        entry_recomm->eax |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
>>      }
>> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VAPIC)) {
>> -        env->features[FEAT_HV_RECOMM_EAX] |= HV_APIC_ACCESS_RECOMMENDED;
>> -    }
>> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_TLBFLUSH)) {
>> -        if (kvm_check_extension(cs->kvm_state,
>> -                                KVM_CAP_HYPERV_TLBFLUSH) <= 0) {
>> -            fprintf(stderr, "Hyper-V TLB flush support "
>> -                    "(requested by 'hv-tlbflush' cpu flag) "
>> -                    " is not supported by kernel\n");
>> -            return -ENOSYS;
>> -        }
>> -        env->features[FEAT_HV_RECOMM_EAX] |= HV_REMOTE_TLB_FLUSH_RECOMMENDED;
>> -        env->features[FEAT_HV_RECOMM_EAX] |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
>> +
>> +    return cpuid;
>> +}
>> +
>> +static int hv_cpuid_get_fw(struct kvm_cpuid2 *cpuid, int fw, uint32_t *r)
>> +{
>> +    struct kvm_cpuid_entry2 *entry;
>> +    uint32_t func;
>> +    int reg;
>> +
>> +    switch (fw) {
>> +    case FEAT_HYPERV_EAX:
>> +        reg = R_EAX;
>> +        func = HV_CPUID_FEATURES;
>> +        break;
>> +    case FEAT_HYPERV_EDX:
>> +        reg = R_EDX;
>> +        func = HV_CPUID_FEATURES;
>> +        break;
>> +    case FEAT_HV_RECOMM_EAX:
>> +        reg = R_EAX;
>> +        func = HV_CPUID_ENLIGHTMENT_INFO;
>> +        break;
>> +    default:
>> +        return -EINVAL;
>>      }
>> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_IPI)) {
>> -        if (kvm_check_extension(cs->kvm_state,
>> -                                KVM_CAP_HYPERV_SEND_IPI) <= 0) {
>> -            fprintf(stderr, "Hyper-V IPI send support "
>> -                    "(requested by 'hv-ipi' cpu flag) "
>> -                    " is not supported by kernel\n");
>> -            return -ENOSYS;
>> +
>> +    entry = cpuid_find_entry(cpuid, func, 0);
>> +    if (!entry) {
>> +        return -ENOENT;
>> +    }
>> +
>> +    switch (reg) {
>> +    case R_EAX:
>> +        *r = entry->eax;
>> +        break;
>> +    case R_EDX:
>> +        *r = entry->edx;
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
>> +                                  int feature)
>> +{
>> +    X86CPU *cpu = X86_CPU(cs);
>> +    CPUX86State *env = &cpu->env;
>> +    uint32_t r, fw, bits;;
>> +    int i;
>> +
>> +    if (!hyperv_feat_enabled(cpu, feature)) {
>> +        return 0;
>> +    }
>> +
>> +    for (i = 0; i < ARRAY_SIZE(kvm_hyperv_properties[feature].flags); i++) {
>> +        fw = kvm_hyperv_properties[feature].flags[i].fw;
>> +        bits = kvm_hyperv_properties[feature].flags[i].bits;
>> +
>> +        if (!fw) {
>> +            continue;
>>          }
>> -        env->features[FEAT_HV_RECOMM_EAX] |= HV_CLUSTER_IPI_RECOMMENDED;
>> -        env->features[FEAT_HV_RECOMM_EAX] |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
>> +
>> +        if (hv_cpuid_get_fw(cpuid, fw, &r) || (r & bits) != bits) {
>> +            fprintf(stderr,
>> +                    "Hyper-V %s is not supported by kernel\n",
>> +                    kvm_hyperv_properties[feature].desc);
>> +            return 1;
>> +        }
>> +
>> +        env->features[fw] |= bits;
>>      }
>> +
>> +    return 0;
>> +}
>> +
>> +static int hyperv_handle_properties(CPUState *cs)
>> +{
>> +    X86CPU *cpu = X86_CPU(cs);
>> +    CPUX86State *env = &cpu->env;
>> +    struct kvm_cpuid2 *cpuid;
>> +    int r = 0;
>> +
>>      if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
>>          uint16_t evmcs_version;
>>  
>>          if (kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_ENLIGHTENED_VMCS, 0,
>>                                  (uintptr_t)&evmcs_version)) {
>> -            fprintf(stderr, "Hyper-V Enlightened VMCS "
>> -                    "(requested by 'hv-evmcs' cpu flag) "
>> -                    "is not supported by kernel\n");
>> +            fprintf(stderr, "Hyper-V %s is not supported by kernel\n",
>> +                    kvm_hyperv_properties[HYPERV_FEAT_EVMCS].desc);
>>              return -ENOSYS;
>>          }
>>          env->features[FEAT_HV_RECOMM_EAX] |= HV_ENLIGHTENED_VMCS_RECOMMENDED;
>>          env->features[FEAT_HV_NESTED_EAX] = evmcs_version;
>>      }
>>  
>> -    return 0;
>> +    if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_CPUID) > 0) {
>> +        cpuid = get_supported_hv_cpuid(cs);
>> +    } else {
>> +        cpuid = get_supported_hv_cpuid_legacy(cs);
>> +    }
>> +
>> +    /* Features */
>> +    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RELAXED);
>> +    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_VAPIC);
>> +    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_TIME);
>> +    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_CRASH);
>> +    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RESET);
>> +    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_VPINDEX);
>> +    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RUNTIME);
>> +    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_SYNIC);
>> +    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_STIMER);
>> +    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_FREQUENCIES);
>> +    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_REENLIGHTENMENT);
>> +    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_TLBFLUSH);
>> +    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_EVMCS);
>> +    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_IPI);
>
> Can't this be expressed by a regualr for() loop?

Yes, it can. In future we can add a special flag to skip something here
if we need to (but there's no need for it now).

>
> Thanks,
> Roman.
>
>> +
>> +    /* Dependencies */
>> +    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC) &&
>> +        !cpu->hyperv_synic_kvm_only &&
>> +        !hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX)) {
>> +        fprintf(stderr, "Hyper-V %s requires %s\n",
>> +                kvm_hyperv_properties[HYPERV_FEAT_SYNIC].desc,
>> +                kvm_hyperv_properties[HYPERV_FEAT_VPINDEX].desc);
>> +        r |= 1;
>> +    }
>> +
>> +    /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
>> +    env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
>> +
>> +    g_free(cpuid);
>> +
>> +    return r ? -ENOSYS : 0;
>>  }
>>  
>>  static int hyperv_init_vcpu(X86CPU *cpu)
>> -- 
>> 2.20.1
>> 

-- 
Vitaly

