Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC36C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 06:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C014D20855
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 06:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NboO60ii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C014D20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGydC-00031N-Sw
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 02:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGyc5-00022d-Iq
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 02:02:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGyc3-0001bA-KH
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 02:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599890534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ckaIWowoKC+98xITlRQTBbCznnntGHp+G5ep7+l0I0=;
 b=NboO60iimUrTaxf3QTLWg0tKdhKz0ZDb2T0TTi0Byt1P5yCw+D+0gVl2o3/0ovqD8uYejW
 zyg2/XSpk+8BN2sLxji2E0h5vrGGrDjpBmWEk4ybTboGQkrhxp2dzZiTN2lORUEFhj62wE
 z3eAc7vU2gseNFh7uMmqEESITm9MIK8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-sU-XGmebNlSpj3kAZWz6eg-1; Sat, 12 Sep 2020 02:02:12 -0400
X-MC-Unique: sU-XGmebNlSpj3kAZWz6eg-1
Received: by mail-wm1-f70.google.com with SMTP id b14so2284829wmj.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 23:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7ckaIWowoKC+98xITlRQTBbCznnntGHp+G5ep7+l0I0=;
 b=alhyce4l966ET+R916sF45ZIakR7oBKaqy6U7qdzLqu/WspI3OMi4MAeZC8UqTmoYI
 s8v0eEFCM12fChoivo6+udDsmEbxxYqm60fRDHBDSeiIO6zTdpVc87VuELKEm3RnC+ql
 lOSKN1TsFHRd7IK33HXqVOdklpmCpdxqFgxK5DerwRoAk5Rl4cbfan2a/2POyyZ3BoZ1
 JkklFmFiiVhgyNlG+dLPBkE0jWaN4EKPotpgjVjiJz2XFTe73QqAAjbpf0jYwDV4wHJu
 zGoRTXQ8UlYjkzf9Df+KUrK9V6T2Z5dCcMHJfQAQY8sJhya1Wi9Q6mYEw8rS3AuSXc5j
 wg8g==
X-Gm-Message-State: AOAM531mQwz6DttsCXB186Ca+NmM4SWabYukz9O3BO0jwS4DM8yIrCqx
 U+HDVGY6tJbtDFlC32XCab6HE6zSgAzgcANEsw7SiQ4hO1nvRrSF5Dj2G544D84rn+OsdV/qijV
 v11eykwf0ynJWBAA=
X-Received: by 2002:a1c:f715:: with SMTP id v21mr1421262wmh.117.1599890531468; 
 Fri, 11 Sep 2020 23:02:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzheB2XDm8cUWIdp894v09E56EQtq2H+rlWdQaEItM9urZDzSwnmAT02QE4wWgZLrbQYiRsgw==
X-Received: by 2002:a1c:f715:: with SMTP id v21mr1421239wmh.117.1599890531152; 
 Fri, 11 Sep 2020 23:02:11 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id m3sm8423995wrs.83.2020.09.11.23.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 23:02:10 -0700 (PDT)
Subject: Re: [PATCH] target/i386: support KVM_FEATURE_ASYNC_PF_INT
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
References: <20200908141206.357450-1-vkuznets@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f0c66049-57c0-4955-bac8-f7f090f7e12e@redhat.com>
Date: Sat, 12 Sep 2020 08:02:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908141206.357450-1-vkuznets@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 02:01:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/09/20 16:12, Vitaly Kuznetsov wrote:
> Linux-5.8 introduced interrupt based mechanism for 'page ready' events
> delivery and disabled the old, #PF based one (see commit 2635b5c4a0e4
> "KVM: x86: interrupt based APF 'page ready' event delivery"). Linux
> guest switches to using in in 5.9 (see commit b1d405751cd5 "KVM: x86:
> Switch KVM guest to using interrupts for page ready APF delivery").
> The feature has a new KVM_FEATURE_ASYNC_PF_INT bit assigned and
> the interrupt vector is set in MSR_KVM_ASYNC_PF_INT MSR. Support this
> in QEMU.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> - Note, Linux-5.9-rc4 is currently broken (see
> https://lore.kernel.org/kvm/20200908135350.355053-3-vkuznets@redhat.com/T/#u)
> but I hope it will get fixed before 5.9 is released.
> ---
>  target/i386/cpu.c     |  4 +++-
>  target/i386/cpu.h     |  1 +
>  target/i386/kvm.c     | 10 ++++++++++
>  target/i386/machine.c | 19 +++++++++++++++++++
>  4 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 49d89585288d..76037843511f 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -903,7 +903,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
>              "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
>              NULL, "kvm-pv-tlb-flush", NULL, "kvm-pv-ipi",
> -            "kvm-poll-control", "kvm-pv-sched-yield", NULL, NULL,
> +            "kvm-poll-control", "kvm-pv-sched-yield", "kvm-asyncpf-int", NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              "kvmclock-stable-bit", NULL, NULL, NULL,
> @@ -4209,6 +4209,7 @@ static PropValue kvm_default_props[] = {
>      { "kvmclock", "on" },
>      { "kvm-nopiodelay", "on" },
>      { "kvm-asyncpf", "on" },
> +    { "kvm-asyncpf-int", "on" },
>      { "kvm-steal-time", "on" },
>      { "kvm-pv-eoi", "on" },
>      { "kvmclock-stable-bit", "on" },
> @@ -7092,6 +7093,7 @@ static void x86_cpu_initfn(Object *obj)
>      object_property_add_alias(obj, "kvm_nopiodelay", obj, "kvm-nopiodelay");
>      object_property_add_alias(obj, "kvm_mmu", obj, "kvm-mmu");
>      object_property_add_alias(obj, "kvm_asyncpf", obj, "kvm-asyncpf");
> +    object_property_add_alias(obj, "kvm_asyncpf_int", obj, "kvm-asyncpf-int");
>      object_property_add_alias(obj, "kvm_steal_time", obj, "kvm-steal-time");
>      object_property_add_alias(obj, "kvm_pv_eoi", obj, "kvm-pv-eoi");
>      object_property_add_alias(obj, "kvm_pv_unhalt", obj, "kvm-pv-unhalt");
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index d3097be6a50a..18e99e9b392a 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1492,6 +1492,7 @@ typedef struct CPUX86State {
>      uint64_t wall_clock_msr;
>      uint64_t steal_time_msr;
>      uint64_t async_pf_en_msr;
> +    uint64_t async_pf_int_msr;
>      uint64_t pv_eoi_en_msr;
>      uint64_t poll_control_msr;
>  
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 205b68bc0ce8..b26370662075 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -287,6 +287,7 @@ static const struct kvm_para_features {
>      { KVM_CAP_NOP_IO_DELAY, KVM_FEATURE_NOP_IO_DELAY },
>      { KVM_CAP_PV_MMU, KVM_FEATURE_MMU_OP },
>      { KVM_CAP_ASYNC_PF, KVM_FEATURE_ASYNC_PF },
> +    { KVM_CAP_ASYNC_PF_INT, KVM_FEATURE_ASYNC_PF_INT },
>  };
>  
>  static int get_para_features(KVMState *s)
> @@ -2820,6 +2821,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>          if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
>              kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, env->async_pf_en_msr);
>          }
> +        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF_INT)) {
> +            kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, env->async_pf_int_msr);
> +        }
>          if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
>              kvm_msr_entry_add(cpu, MSR_KVM_PV_EOI_EN, env->pv_eoi_en_msr);
>          }
> @@ -3205,6 +3209,9 @@ static int kvm_get_msrs(X86CPU *cpu)
>      if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
>          kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, 0);
>      }
> +    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF_INT)) {
> +        kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, 0);
> +    }
>      if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
>          kvm_msr_entry_add(cpu, MSR_KVM_PV_EOI_EN, 0);
>      }
> @@ -3445,6 +3452,9 @@ static int kvm_get_msrs(X86CPU *cpu)
>          case MSR_KVM_ASYNC_PF_EN:
>              env->async_pf_en_msr = msrs[i].data;
>              break;
> +        case MSR_KVM_ASYNC_PF_INT:
> +            env->async_pf_int_msr = msrs[i].data;
> +            break;
>          case MSR_KVM_PV_EOI_EN:
>              env->pv_eoi_en_msr = msrs[i].data;
>              break;
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index b1acf7d0ef46..233e46bb70b5 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -394,6 +394,13 @@ static bool async_pf_msr_needed(void *opaque)
>      return cpu->env.async_pf_en_msr != 0;
>  }
>  
> +static bool async_pf_int_msr_needed(void *opaque)
> +{
> +    X86CPU *cpu = opaque;
> +
> +    return cpu->env.async_pf_int_msr != 0;
> +}
> +
>  static bool pv_eoi_msr_needed(void *opaque)
>  {
>      X86CPU *cpu = opaque;
> @@ -467,6 +474,17 @@ static const VMStateDescription vmstate_async_pf_msr = {
>      }
>  };
>  
> +static const VMStateDescription vmstate_async_pf_int_msr = {
> +    .name = "cpu/async_pf_int_msr",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = async_pf_int_msr_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(env.async_pf_int_msr, X86CPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_pv_eoi_msr = {
>      .name = "cpu/async_pv_eoi_msr",
>      .version_id = 1,
> @@ -1438,6 +1456,7 @@ VMStateDescription vmstate_x86_cpu = {
>      .subsections = (const VMStateDescription*[]) {
>          &vmstate_exception_info,
>          &vmstate_async_pf_msr,
> +        &vmstate_async_pf_int_msr,
>          &vmstate_pv_eoi_msr,
>          &vmstate_steal_time_msr,
>          &vmstate_poll_control_msr,
> 

Queued, thanks.

Paolo


