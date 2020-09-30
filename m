Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3308C47420
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462F2206FC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7FnnS4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462F2206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdk3-0001Qy-T8
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNdXP-0005tP-TN
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNdXM-0004hJ-T8
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:59 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601477816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BWygO3zus+E5Ew+h58cK+tuk4USd2/S/xwndQI8QGJs=;
 b=U7FnnS4bgi5qSwO4+g3x/XCOtKMD9yD2Uxfzk69ECMtPk88qAWDjPR7Osr/DKV4ceCp7/c
 7i59adl05IUQhOjDJSWtN6uIv/V/I6QbYTUzdBCte4p8w3Jejk4AbYJBtkiPgvadZEVzuX
 o7qWs5ssB7KUoarXI3ReHiZCNvwohO4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-syjb9zZRNgyrxAMZ1S6f9g-1; Wed, 30 Sep 2020 10:56:54 -0400
X-MC-Unique: syjb9zZRNgyrxAMZ1S6f9g-1
Received: by mail-wm1-f72.google.com with SMTP id c204so568364wmd.5
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 07:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=BWygO3zus+E5Ew+h58cK+tuk4USd2/S/xwndQI8QGJs=;
 b=iauWFY4469C1dfRfaGxZaNnkgKK2x1BhYixQ7niozo2By3c4Q9fiGZHDEZw9JiBPQm
 AtvSbiHtaPl90zUoQG0+4WzB97JNrJklPTB4mAFsbgzXAO1fqKLHQbrYa0DCrUeeOT5a
 8zONUjwwgAhmXrkfAcM/eAZ11Bx1DN/Rm7oj2NA9X0Gda7gnD6vCr/qy/na0RW/OJuuk
 q3LnSZmhVQpFWCJFHjgdmmD8jUubP0EgS6xbSAxsY/ipYt38lrDena0hgfMALhHT29jN
 kSQh349r1RjpsHWYhwX7X1LvvhoxUGU+Vnbe7OL9u9u6OQVxT7oTKIFTS4eZlE8Mdl//
 62BA==
X-Gm-Message-State: AOAM530NaUjF5tQlEXgNOsYJ+gyae6FhNCH4+mX8fkvTEOb1ntq1vwyJ
 O/MY90WIzZ2bM3N8cF7yUNwLmmzOq4vCrZFXtZE0Fx33kAhXW8+RWL38f7oZrc6OrH3vLS4UysY
 urHV4kelYxuDbpO8=
X-Received: by 2002:a1c:28a:: with SMTP id 132mr3489659wmc.9.1601477812543;
 Wed, 30 Sep 2020 07:56:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUtZh7nbAsV0pVbs/vIHBVk0csIdxY+Bs8KZujVBlIEAgSFwbGPA6cPTB1Cisd3BXET2/4xw==
X-Received: by 2002:a1c:28a:: with SMTP id 132mr3489623wmc.9.1601477812009;
 Wed, 30 Sep 2020 07:56:52 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id h1sm3419265wrx.33.2020.09.30.07.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 07:56:51 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH RFC v2 12/19] i386: drop FEAT_HYPERV feature leaves
In-Reply-To: <20200930143615.GQ3717385@habkost.net>
References: <20200930134027.1348021-1-vkuznets@redhat.com>
 <20200930134027.1348021-13-vkuznets@redhat.com>
 <20200930143615.GQ3717385@habkost.net>
Date: Wed, 30 Sep 2020 16:56:50 +0200
Message-ID: <87sgaz9utp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, Sep 30, 2020 at 03:40:20PM +0200, Vitaly Kuznetsov wrote:
>> Hyper-V feature leaves are weird. We have some of them in
>> feature_word_info[] array but we don't use feature_word_info
>> magic to enable them. Neither do we use feature_dependencies[]
>> mechanism to validate the configuration as it doesn't allign
>> well with Hyper-V's many-to-many dependency chains. Some of
>> the feature leaves hold not only feature bits, but also values.
>> E.g. FEAT_HV_NESTED_EAX contains both features and the supported
>> Enlightened VMCS range.
>> 
>> Hyper-V features are already represented in 'struct X86CPU' with
>> uint64_t hyperv_features so duplicating them in env->features adds
>> little (or zero) benefits. THe other half of Hyper-V emulation features
>> is also stored with values in hyperv_vendor_id[], hyperv_limits[],...
>> so env->features[] is already incomplete.
>> 
>> Remove Hyper-V feature leaves from env->features[] completely.
>> kvm_hyperv_properties[] is converted to using raw CPUID func/reg
>> pairs for features, this allows us to get rid of hv_cpuid_get_fw()
>> conversion.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> So, my first reaction to this was "we don't want to revert this,
> having hyperv features in env->features is useful", but seeing
> that there's only one line where env->features[] is actually used
> in target/i386/cpu.c, I agree with this change.  We still have
> the option to recreate those FeatureWord entries in the future,
> if necessary.
>
> I'm still reviewing the patch and it looks good so far, but I
> have one question: have you considered doing this at the
> beginning of the series?  There are
>   env->features[...] = hv_cpuid_get_host(cs, ...)
> lines you have added in the previous patches, just to remove them
> in this patch.
>

In case the general idea (removing Hyper-V feature leaves from
env->features[]) is acceptable I can try to minimize code churn in
v1. Maybe separating hv_build_cpuid_leaf() into its own patch will make
the removal cleaner, I'll definitely give it a try.

>> ---
>>  target/i386/cpu.c |  90 +----------------------
>>  target/i386/cpu.h |   6 +-
>>  target/i386/kvm.c | 181 ++++++++++++++++++++++------------------------
>>  3 files changed, 90 insertions(+), 187 deletions(-)
>> 
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 8ec0af0a6d48..a178db255641 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -828,94 +828,6 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>>           */
>>          .no_autoenable_flags = ~0U,
>>      },
>> -    /*
>> -     * .feat_names are commented out for Hyper-V enlightenments because we
>> -     * don't want to have two different ways for enabling them on QEMU command
>> -     * line. Some features (e.g. "hyperv_time", "hyperv_vapic", ...) require
>> -     * enabling several feature bits simultaneously, exposing these bits
>> -     * individually may just confuse guests.
>> -     */
>> -    [FEAT_HYPERV_EAX] = {
>> -        .type = CPUID_FEATURE_WORD,
>> -        .feat_names = {
>> -            NULL /* hv_msr_vp_runtime_access */, NULL /* hv_msr_time_refcount_access */,
>> -            NULL /* hv_msr_synic_access */, NULL /* hv_msr_stimer_access */,
>> -            NULL /* hv_msr_apic_access */, NULL /* hv_msr_hypercall_access */,
>> -            NULL /* hv_vpindex_access */, NULL /* hv_msr_reset_access */,
>> -            NULL /* hv_msr_stats_access */, NULL /* hv_reftsc_access */,
>> -            NULL /* hv_msr_idle_access */, NULL /* hv_msr_frequency_access */,
>> -            NULL /* hv_msr_debug_access */, NULL /* hv_msr_reenlightenment_access */,
>> -            NULL, NULL,
>> -            NULL, NULL, NULL, NULL,
>> -            NULL, NULL, NULL, NULL,
>> -            NULL, NULL, NULL, NULL,
>> -            NULL, NULL, NULL, NULL,
>> -        },
>> -        .cpuid = { .eax = 0x40000003, .reg = R_EAX, },
>> -    },
>> -    [FEAT_HYPERV_EBX] = {
>> -        .type = CPUID_FEATURE_WORD,
>> -        .feat_names = {
>> -            NULL /* hv_create_partitions */, NULL /* hv_access_partition_id */,
>> -            NULL /* hv_access_memory_pool */, NULL /* hv_adjust_message_buffers */,
>> -            NULL /* hv_post_messages */, NULL /* hv_signal_events */,
>> -            NULL /* hv_create_port */, NULL /* hv_connect_port */,
>> -            NULL /* hv_access_stats */, NULL, NULL, NULL /* hv_debugging */,
>> -            NULL /* hv_cpu_power_management */, NULL /* hv_configure_profiler */,
>> -            NULL, NULL,
>> -            NULL, NULL, NULL, NULL,
>> -            NULL, NULL, NULL, NULL,
>> -            NULL, NULL, NULL, NULL,
>> -            NULL, NULL, NULL, NULL,
>> -        },
>> -        .cpuid = { .eax = 0x40000003, .reg = R_EBX, },
>> -    },
>> -    [FEAT_HYPERV_EDX] = {
>> -        .type = CPUID_FEATURE_WORD,
>> -        .feat_names = {
>> -            NULL /* hv_mwait */, NULL /* hv_guest_debugging */,
>> -            NULL /* hv_perf_monitor */, NULL /* hv_cpu_dynamic_part */,
>> -            NULL /* hv_hypercall_params_xmm */, NULL /* hv_guest_idle_state */,
>> -            NULL, NULL,
>> -            NULL, NULL, NULL /* hv_guest_crash_msr */, NULL,
>> -            NULL, NULL, NULL, NULL,
>> -            NULL, NULL, NULL, NULL,
>> -            NULL, NULL, NULL, NULL,
>> -            NULL, NULL, NULL, NULL,
>> -            NULL, NULL, NULL, NULL,
>> -        },
>> -        .cpuid = { .eax = 0x40000003, .reg = R_EDX, },
>> -    },
>> -    [FEAT_HV_RECOMM_EAX] = {
>> -        .type = CPUID_FEATURE_WORD,
>> -        .feat_names = {
>> -            NULL /* hv_recommend_pv_as_switch */,
>> -            NULL /* hv_recommend_pv_tlbflush_local */,
>> -            NULL /* hv_recommend_pv_tlbflush_remote */,
>> -            NULL /* hv_recommend_msr_apic_access */,
>> -            NULL /* hv_recommend_msr_reset */,
>> -            NULL /* hv_recommend_relaxed_timing */,
>> -            NULL /* hv_recommend_dma_remapping */,
>> -            NULL /* hv_recommend_int_remapping */,
>> -            NULL /* hv_recommend_x2apic_msrs */,
>> -            NULL /* hv_recommend_autoeoi_deprecation */,
>> -            NULL /* hv_recommend_pv_ipi */,
>> -            NULL /* hv_recommend_ex_hypercalls */,
>> -            NULL /* hv_hypervisor_is_nested */,
>> -            NULL /* hv_recommend_int_mbec */,
>> -            NULL /* hv_recommend_evmcs */,
>> -            NULL,
>> -            NULL, NULL, NULL, NULL,
>> -            NULL, NULL, NULL, NULL,
>> -            NULL, NULL, NULL, NULL,
>> -            NULL, NULL, NULL, NULL,
>> -        },
>> -        .cpuid = { .eax = 0x40000004, .reg = R_EAX, },
>> -    },
>> -    [FEAT_HV_NESTED_EAX] = {
>> -        .type = CPUID_FEATURE_WORD,
>> -        .cpuid = { .eax = 0x4000000A, .reg = R_EAX, },
>> -    },
>>      [FEAT_SVM] = {
>>          .type = CPUID_FEATURE_WORD,
>>          .feat_names = {
>> @@ -6906,7 +6818,7 @@ static GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
>>      CPUX86State *env = &cpu->env;
>>      GuestPanicInformation *panic_info = NULL;
>>  
>> -    if (env->features[FEAT_HYPERV_EDX] & HV_GUEST_CRASH_MSR_AVAILABLE) {
>> +    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_CRASH)) {
>>          panic_info = g_malloc0(sizeof(GuestPanicInformation));
>>  
>>          panic_info->type = GUEST_PANIC_INFORMATION_TYPE_HYPER_V;
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index 187e4a09e65d..b07325745bcb 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -519,11 +519,6 @@ typedef enum FeatureWord {
>>      FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
>>      FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
>>      FEAT_KVM_HINTS,     /* CPUID[4000_0001].EDX */
>> -    FEAT_HYPERV_EAX,    /* CPUID[4000_0003].EAX */
>> -    FEAT_HYPERV_EBX,    /* CPUID[4000_0003].EBX */
>> -    FEAT_HYPERV_EDX,    /* CPUID[4000_0003].EDX */
>> -    FEAT_HV_RECOMM_EAX, /* CPUID[4000_0004].EAX */
>> -    FEAT_HV_NESTED_EAX, /* CPUID[4000_000A].EAX */
>>      FEAT_SVM,           /* CPUID[8000_000A].EDX */
>>      FEAT_XSAVE,         /* CPUID[EAX=0xd,ECX=1].EAX */
>>      FEAT_6_EAX,         /* CPUID[6].EAX */
>> @@ -1663,6 +1658,7 @@ struct X86CPU {
>>      uint32_t hyperv_interface_id[4];
>>      uint32_t hyperv_version_id[4];
>>      uint32_t hyperv_limits[3];
>> +    uint32_t hyperv_nested[4];
>>  
>>      bool check_cpuid;
>>      bool enforce_cpuid;
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index 0e6eef6a52c2..86a5cfa1e12b 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -815,7 +815,8 @@ static bool tsc_is_stable_and_known(CPUX86State *env)
>>  static struct {
>>      const char *desc;
>>      struct {
>> -        uint32_t fw;
>> +        uint32_t func;
>> +        int reg;
>>          uint32_t bits;
>>      } flags[2];
>>      uint64_t dependencies;
>> @@ -823,25 +824,25 @@ static struct {
>>      [HYPERV_FEAT_RELAXED] = {
>>          .desc = "relaxed timing (hv-relaxed)",
>>          .flags = {
>> -            {.fw = FEAT_HYPERV_EAX,
>> +            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
>>               .bits = HV_HYPERCALL_AVAILABLE},
>> -            {.fw = FEAT_HV_RECOMM_EAX,
>> +            {.func = HV_CPUID_ENLIGHTMENT_INFO, .reg = R_EAX,
>>               .bits = HV_RELAXED_TIMING_RECOMMENDED}
>>          }
>>      },
>>      [HYPERV_FEAT_VAPIC] = {
>>          .desc = "virtual APIC (hv-vapic)",
>>          .flags = {
>> -            {.fw = FEAT_HYPERV_EAX,
>> +            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
>>               .bits = HV_HYPERCALL_AVAILABLE | HV_APIC_ACCESS_AVAILABLE},
>> -            {.fw = FEAT_HV_RECOMM_EAX,
>> +            {.func = HV_CPUID_ENLIGHTMENT_INFO, .reg = R_EAX,
>>               .bits = HV_APIC_ACCESS_RECOMMENDED}
>>          }
>>      },
>>      [HYPERV_FEAT_TIME] = {
>>          .desc = "clocksources (hv-time)",
>>          .flags = {
>> -            {.fw = FEAT_HYPERV_EAX,
>> +            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
>>               .bits = HV_HYPERCALL_AVAILABLE | HV_TIME_REF_COUNT_AVAILABLE |
>>               HV_REFERENCE_TSC_AVAILABLE}
>>          }
>> @@ -849,42 +850,42 @@ static struct {
>>      [HYPERV_FEAT_CRASH] = {
>>          .desc = "crash MSRs (hv-crash)",
>>          .flags = {
>> -            {.fw = FEAT_HYPERV_EDX,
>> +            {.func = HV_CPUID_FEATURES, .reg = R_EDX,
>>               .bits = HV_GUEST_CRASH_MSR_AVAILABLE}
>>          }
>>      },
>>      [HYPERV_FEAT_RESET] = {
>>          .desc = "reset MSR (hv-reset)",
>>          .flags = {
>> -            {.fw = FEAT_HYPERV_EAX,
>> +            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
>>               .bits = HV_RESET_AVAILABLE}
>>          }
>>      },
>>      [HYPERV_FEAT_VPINDEX] = {
>>          .desc = "VP_INDEX MSR (hv-vpindex)",
>>          .flags = {
>> -            {.fw = FEAT_HYPERV_EAX,
>> +            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
>>               .bits = HV_VP_INDEX_AVAILABLE}
>>          }
>>      },
>>      [HYPERV_FEAT_RUNTIME] = {
>>          .desc = "VP_RUNTIME MSR (hv-runtime)",
>>          .flags = {
>> -            {.fw = FEAT_HYPERV_EAX,
>> +            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
>>               .bits = HV_VP_RUNTIME_AVAILABLE}
>>          }
>>      },
>>      [HYPERV_FEAT_SYNIC] = {
>>          .desc = "synthetic interrupt controller (hv-synic)",
>>          .flags = {
>> -            {.fw = FEAT_HYPERV_EAX,
>> +            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
>>               .bits = HV_SYNIC_AVAILABLE}
>>          }
>>      },
>>      [HYPERV_FEAT_STIMER] = {
>>          .desc = "synthetic timers (hv-stimer)",
>>          .flags = {
>> -            {.fw = FEAT_HYPERV_EAX,
>> +            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
>>               .bits = HV_SYNTIMERS_AVAILABLE}
>>          },
>>          .dependencies = BIT(HYPERV_FEAT_SYNIC) | BIT(HYPERV_FEAT_TIME)
>> @@ -892,23 +893,23 @@ static struct {
>>      [HYPERV_FEAT_FREQUENCIES] = {
>>          .desc = "frequency MSRs (hv-frequencies)",
>>          .flags = {
>> -            {.fw = FEAT_HYPERV_EAX,
>> +            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
>>               .bits = HV_ACCESS_FREQUENCY_MSRS},
>> -            {.fw = FEAT_HYPERV_EDX,
>> +            {.func = HV_CPUID_FEATURES, .reg = R_EDX,
>>               .bits = HV_FREQUENCY_MSRS_AVAILABLE}
>>          }
>>      },
>>      [HYPERV_FEAT_REENLIGHTENMENT] = {
>>          .desc = "reenlightenment MSRs (hv-reenlightenment)",
>>          .flags = {
>> -            {.fw = FEAT_HYPERV_EAX,
>> +            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
>>               .bits = HV_ACCESS_REENLIGHTENMENTS_CONTROL}
>>          }
>>      },
>>      [HYPERV_FEAT_TLBFLUSH] = {
>>          .desc = "paravirtualized TLB flush (hv-tlbflush)",
>>          .flags = {
>> -            {.fw = FEAT_HV_RECOMM_EAX,
>> +            {.func = HV_CPUID_ENLIGHTMENT_INFO, .reg = R_EAX,
>>               .bits = HV_REMOTE_TLB_FLUSH_RECOMMENDED |
>>               HV_EX_PROCESSOR_MASKS_RECOMMENDED}
>>          },
>> @@ -917,7 +918,7 @@ static struct {
>>      [HYPERV_FEAT_EVMCS] = {
>>          .desc = "enlightened VMCS (hv-evmcs)",
>>          .flags = {
>> -            {.fw = FEAT_HV_RECOMM_EAX,
>> +            {.func = HV_CPUID_ENLIGHTMENT_INFO, .reg = R_EAX,
>>               .bits = HV_ENLIGHTENED_VMCS_RECOMMENDED}
>>          },
>>          .dependencies = BIT(HYPERV_FEAT_VAPIC)
>> @@ -925,7 +926,7 @@ static struct {
>>      [HYPERV_FEAT_IPI] = {
>>          .desc = "paravirtualized IPI (hv-ipi)",
>>          .flags = {
>> -            {.fw = FEAT_HV_RECOMM_EAX,
>> +            {.func = HV_CPUID_ENLIGHTMENT_INFO, .reg = R_EAX,
>>               .bits = HV_CLUSTER_IPI_RECOMMENDED |
>>               HV_EX_PROCESSOR_MASKS_RECOMMENDED}
>>          },
>> @@ -934,7 +935,7 @@ static struct {
>>      [HYPERV_FEAT_STIMER_DIRECT] = {
>>          .desc = "direct mode synthetic timers (hv-stimer-direct)",
>>          .flags = {
>> -            {.fw = FEAT_HYPERV_EDX,
>> +            {.func = HV_CPUID_FEATURES, .reg = R_EDX,
>>               .bits = HV_STIMER_DIRECT_MODE_AVAILABLE}
>>          },
>>          .dependencies = BIT(HYPERV_FEAT_STIMER)
>> @@ -1108,38 +1109,34 @@ static uint32_t hv_cpuid_get_host(CPUState *cs, uint32_t func, int reg)
>>      return cpuid_entry_get_reg(entry, reg);
>>  }
>>  
>> -static uint32_t hv_cpuid_get_fw(CPUState *cs, int fw)
>> +static bool hyperv_feature_supported(CPUState *cs, int feature)
>>  {
>> -    uint32_t func;
>> -    int reg;
>> +    uint32_t func, bits;
>> +    int i, reg;
>>  
>> -    switch (fw) {
>> -    case FEAT_HYPERV_EAX:
>> -        reg = R_EAX;
>> -        func = HV_CPUID_FEATURES;
>> -        break;
>> -    case FEAT_HYPERV_EDX:
>> -        reg = R_EDX;
>> -        func = HV_CPUID_FEATURES;
>> -        break;
>> -    case FEAT_HV_RECOMM_EAX:
>> -        reg = R_EAX;
>> -        func = HV_CPUID_ENLIGHTMENT_INFO;
>> -        break;
>> -    default:
>> -        return 0;
>> +    for (i = 0; i < ARRAY_SIZE(kvm_hyperv_properties[feature].flags); i++) {
>> +
>> +        func = kvm_hyperv_properties[feature].flags[i].func;
>> +        reg = kvm_hyperv_properties[feature].flags[i].reg;
>> +        bits = kvm_hyperv_properties[feature].flags[i].bits;
>> +
>> +        if (!func) {
>> +            continue;
>> +        }
>> +
>> +        if ((hv_cpuid_get_host(cs, func, reg) & bits) != bits) {
>> +            return false;
>> +        }
>>      }
>>  
>> -    return hv_cpuid_get_host(cs, func, reg);
>> +    return true;
>>  }
>>  
>>  static int hv_cpuid_check_and_set(CPUState *cs, int feature)
>>  {
>>      X86CPU *cpu = X86_CPU(cs);
>> -    CPUX86State *env = &cpu->env;
>> -    uint32_t r, fw, bits;
>>      uint64_t deps;
>> -    int i, dep_feat;
>> +    int dep_feat;
>>  
>>      if (!hyperv_feat_enabled(cpu, feature) && !cpu->hyperv_passthrough) {
>>          return 0;
>> @@ -1158,27 +1155,15 @@ static int hv_cpuid_check_and_set(CPUState *cs, int feature)
>>          deps &= ~(1ull << dep_feat);
>>      }
>>  
>> -    for (i = 0; i < ARRAY_SIZE(kvm_hyperv_properties[feature].flags); i++) {
>> -        fw = kvm_hyperv_properties[feature].flags[i].fw;
>> -        bits = kvm_hyperv_properties[feature].flags[i].bits;
>> -
>> -        if (!fw) {
>> -            continue;
>> -        }
>> -
>> -        r = hv_cpuid_get_fw(cs, fw);
>> -        if ((r & bits) != bits) {
>> -            if (hyperv_feat_enabled(cpu, feature)) {
>> -                fprintf(stderr,
>> -                        "Hyper-V %s is not supported by kernel\n",
>> -                        kvm_hyperv_properties[feature].desc);
>> -                return 1;
>> -            } else {
>> -                return 0;
>> -            }
>> +    if (!hyperv_feature_supported(cs, feature)) {
>> +        if (hyperv_feat_enabled(cpu, feature)) {
>> +            fprintf(stderr,
>> +                    "Hyper-V %s is not supported by kernel\n",
>> +                    kvm_hyperv_properties[feature].desc);
>> +            return 1;
>> +        } else {
>> +            return 0;
>>          }
>> -
>> -        env->features[fw] |= bits;
>>      }
>>  
>>      if (cpu->hyperv_passthrough) {
>> @@ -1188,6 +1173,32 @@ static int hv_cpuid_check_and_set(CPUState *cs, int feature)
>>      return 0;
>>  }
>>  
>> +static uint32_t hv_build_cpuid_leaf(CPUState *cs, uint32_t func, int reg)
>> +{
>> +    X86CPU *cpu = X86_CPU(cs);
>> +    uint32_t r = 0;
>> +    int i, j;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(kvm_hyperv_properties); i++) {
>> +        if (!hyperv_feat_enabled(cpu, i)) {
>> +            continue;
>> +        }
>> +
>> +        for (j = 0; j < ARRAY_SIZE(kvm_hyperv_properties[i].flags); j++) {
>> +            if (kvm_hyperv_properties[i].flags[j].func != func) {
>> +                continue;
>> +            }
>> +            if (kvm_hyperv_properties[i].flags[j].reg != reg) {
>> +                continue;
>> +            }
>> +
>> +            r |= kvm_hyperv_properties[i].flags[j].bits;
>> +        }
>> +    }
>> +
>> +    return r;
>> +}
>> +
>>  /*
>>   * Fill in Hyper-V CPUIDs. Returns the number of entries filled in cpuid_ent in
>>   * case of success, errno < 0 in case of failure and 0 when no Hyper-V
>> @@ -1197,7 +1208,6 @@ static int hyperv_handle_properties(CPUState *cs,
>>                                      struct kvm_cpuid_entry2 *cpuid_ent)
>>  {
>>      X86CPU *cpu = X86_CPU(cs);
>> -    CPUX86State *env = &cpu->env;
>>      struct kvm_cpuid_entry2 *c;
>>      uint32_t cpuid_i = 0;
>>      int r;
>> @@ -1219,9 +1229,7 @@ static int hyperv_handle_properties(CPUState *cs,
>>          }
>>  
>>          if (!r) {
>> -            env->features[FEAT_HV_RECOMM_EAX] |=
>> -                HV_ENLIGHTENED_VMCS_RECOMMENDED;
>> -            env->features[FEAT_HV_NESTED_EAX] = evmcs_version;
>> +            cpu->hyperv_nested[0] = evmcs_version;
>>          }
>>      }
>>  
>> @@ -1255,13 +1263,6 @@ static int hyperv_handle_properties(CPUState *cs,
>>          cpu->hyperv_version_id[3] =
>>              hv_cpuid_get_host(cs, HV_CPUID_VERSION, R_EDX);
>>  
>> -        env->features[FEAT_HYPERV_EAX] =
>> -            hv_cpuid_get_host(cs, HV_CPUID_FEATURES, R_EAX);
>> -        env->features[FEAT_HYPERV_EBX] =
>> -            hv_cpuid_get_host(cs, HV_CPUID_FEATURES, R_EBX);
>> -        env->features[FEAT_HYPERV_EDX] =
>> -            hv_cpuid_get_host(cs, HV_CPUID_FEATURES, R_EDX);
>> -
>>          cpu->hv_max_vps = hv_cpuid_get_host(cs, HV_CPUID_IMPLEMENT_LIMITS,
>>                                              R_EAX);
>>          cpu->hyperv_limits[0] =
>> @@ -1271,21 +1272,8 @@ static int hyperv_handle_properties(CPUState *cs,
>>          cpu->hyperv_limits[2] =
>>              hv_cpuid_get_host(cs, HV_CPUID_IMPLEMENT_LIMITS, R_EDX);
>>  
>> -        env->features[FEAT_HV_RECOMM_EAX] =
>> -            hv_cpuid_get_host(cs, HV_CPUID_ENLIGHTMENT_INFO, R_EAX);
>>          cpu->hyperv_spinlock_attempts =
>>              hv_cpuid_get_host(cs, HV_CPUID_ENLIGHTMENT_INFO, R_EBX);
>> -
>> -        env->features[FEAT_HV_NESTED_EAX] =
>> -            hv_cpuid_get_host(cs, HV_CPUID_NESTED_FEATURES, R_EAX);
>> -    }
>> -
>> -    if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_ON) {
>> -        env->features[FEAT_HV_RECOMM_EAX] |= HV_NO_NONARCH_CORESHARING;
>> -    } else if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_AUTO) {
>> -        env->features[FEAT_HV_RECOMM_EAX] |=
>> -            hv_cpuid_get_host(cs, HV_CPUID_ENLIGHTMENT_INFO, R_EAX) &
>> -            HV_NO_NONARCH_CORESHARING;
>>      }
>>  
>>      /* Features */
>> @@ -1315,9 +1303,6 @@ static int hyperv_handle_properties(CPUState *cs,
>>          r |= 1;
>>      }
>>  
>> -    /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
>> -    env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
>> -
>>      if (r) {
>>          return -ENOSYS;
>>      }
>> @@ -1346,15 +1331,25 @@ static int hyperv_handle_properties(CPUState *cs,
>>  
>>      c = &cpuid_ent[cpuid_i++];
>>      c->function = HV_CPUID_FEATURES;
>> -    c->eax = env->features[FEAT_HYPERV_EAX];
>> -    c->ebx = env->features[FEAT_HYPERV_EBX];
>> -    c->edx = env->features[FEAT_HYPERV_EDX];
>> +    c->eax = hv_build_cpuid_leaf(cs, HV_CPUID_FEATURES, R_EAX);
>> +    c->ebx = hv_build_cpuid_leaf(cs, HV_CPUID_FEATURES, R_EBX);
>> +    c->edx = hv_build_cpuid_leaf(cs, HV_CPUID_FEATURES, R_EDX);
>> +
>> +    /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
>> +    c->edx |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
>>  
>>      c = &cpuid_ent[cpuid_i++];
>>      c->function = HV_CPUID_ENLIGHTMENT_INFO;
>> -    c->eax = env->features[FEAT_HV_RECOMM_EAX];
>> +    c->eax = hv_build_cpuid_leaf(cs, HV_CPUID_ENLIGHTMENT_INFO, R_EAX);
>>      c->ebx = cpu->hyperv_spinlock_attempts;
>>  
>> +    if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_ON) {
>> +        c->eax |= HV_NO_NONARCH_CORESHARING;
>> +    } else if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_AUTO) {
>> +        c->eax |= hv_cpuid_get_host(cs, HV_CPUID_ENLIGHTMENT_INFO, R_EAX) &
>> +            HV_NO_NONARCH_CORESHARING;
>> +    }
>> +
>>      c = &cpuid_ent[cpuid_i++];
>>      c->function = HV_CPUID_IMPLEMENT_LIMITS;
>>      c->eax = cpu->hv_max_vps;
>> @@ -1374,7 +1369,7 @@ static int hyperv_handle_properties(CPUState *cs,
>>  
>>          c = &cpuid_ent[cpuid_i++];
>>          c->function = HV_CPUID_NESTED_FEATURES;
>> -        c->eax = env->features[FEAT_HV_NESTED_EAX];
>> +        c->eax = cpu->hyperv_nested[0];
>>      }
>>  
>>      return cpuid_i;
>> -- 
>> 2.25.4
>> 

-- 
Vitaly


