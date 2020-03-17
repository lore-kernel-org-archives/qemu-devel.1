Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7E6C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:15:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD17820674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5U1cQFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD17820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGk7-0000Dx-T7
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEGY9-00018m-AQ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEGY7-0003qZ-Q4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:02:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22167)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEGY7-0003iI-Je
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584468162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j2JvZ4mNO0mNgyt/45woZ9rfXmSd3dHVZzJ+Ul0wVn4=;
 b=Z5U1cQFh4VinL8rrWA7fpGXm5nuIf8p60HQenraB1p4+MRG5TDdw5I7uk5ZStyYL1ypo9/
 II5+tZExS2DROuGFgtAfTyEW3KJ+wLxZaMpzZ2o1F5pxWqTDXISztAVPFScCv/ajVf+kF1
 zMzgXPzEFFDymKTdvAYT1gT09qz5C2Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-eelFbVHpOfq9vIuOA_RIyw-1; Tue, 17 Mar 2020 14:02:41 -0400
X-MC-Unique: eelFbVHpOfq9vIuOA_RIyw-1
Received: by mail-wr1-f71.google.com with SMTP id h17so1381598wru.16
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 11:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j2JvZ4mNO0mNgyt/45woZ9rfXmSd3dHVZzJ+Ul0wVn4=;
 b=sfFmSKr5LoVBELphW+A87RCZ2KOwMCj72GNZIPEyNKhBWGlwCzXFJ+ECiN4kqFwzJ7
 o/KE5sLeTxugMpCCSQFFSccil1mU6eB/8MwURnupyPtObzHrKAtFIBRbpzb+xm6W7WXv
 kbEXG+7wSsZv+N1sX6SgUJdn19U+Cc+2ZznHUuNezOXWGI+Zn2YQ7NbTqVCXI1ZbJYA8
 uc5azEi4J5JEfPTvmtOGnIyERl/GVhQtJvm1gbocER0S5aWqm9Rf3RqElWsMcov1Fcof
 cuPfybNyovDDRQ4oix5toAU9q4iwFisbRr1CuMMc1JoKmDyhU+JdveEJ/HNvgsZBONwL
 Y7iw==
X-Gm-Message-State: ANhLgQ06EQe2fEaa7wWJ6BXH2ngGhM7K2Kfp67aNtFPK8bX3TcM1taMs
 q9vRczRyPfOSsdVYRbxzEl8DjPq9bkE6L21dVqlmwHf7zRM9VBVV18EngOzcYTwr7DbWsL/Swge
 /yBoO23mNhRuCqBQ=
X-Received: by 2002:a05:600c:2f01:: with SMTP id
 r1mr213311wmn.31.1584468158016; 
 Tue, 17 Mar 2020 11:02:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvTSLWGVo+qyK1mzEiXAPC9fg8Q6hP/DNsMpm3wBzp1AFIrl2lOMe52++xWuHx27PSU9DuCEA==
X-Received: by 2002:a05:600c:2f01:: with SMTP id
 r1mr213291wmn.31.1584468157761; 
 Tue, 17 Mar 2020 11:02:37 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.227])
 by smtp.gmail.com with ESMTPSA id 9sm211878wmo.38.2020.03.17.11.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 11:02:37 -0700 (PDT)
Subject: Re: [PATCH] i386/kvm: Add CPU property to expose VMware CPUID
 signature
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20200310004017.100484-1-liran.alon@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6cd902ba-c90b-b600-c460-a9b8fba2ebc7@redhat.com>
Date: Tue, 17 Mar 2020 19:02:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310004017.100484-1-liran.alon@oracle.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: mtosatti@redhat.com, ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/03/20 01:40, Liran Alon wrote:
> Some guests are only familiar with VMware PV interface. Therefore, in
> order for these guests to run properly on KVM, we need to be able to
> expose VMware main CPUID leaf. i.e. leaf 0x40000000.
> 
> E.g. Without exposing this VMware CPUID leaf, some guests will fail to boot.
> For example, because of guest attempt to calibrate TSC.
> 
> Signed-off-by: Liran Alon <liran.alon@oracle.com>

Looks good, thanks.  It was submitted quite close to soft freeze so I
couldn't get to it quickly.  But I've queued it now, either for 5.0 or 5.1.

Paolo

> ---
>  target/i386/cpu.c |  1 +
>  target/i386/cpu.h |  1 +
>  target/i386/kvm.c | 35 +++++++++++++++++++++++++++++------
>  3 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 92fafa265914..694766d45a9b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7127,6 +7127,7 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
>      DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migration,
>                       false),
> +    DEFINE_PROP_BOOL("vmware-cpuid", X86CPU, expose_vmware, false),
>      DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
>      DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
>      DEFINE_PROP_BOOL("x-migrate-smi-count", X86CPU, migrate_smi_count,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 9c7cd7cde107..bca626963e25 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1647,6 +1647,7 @@ struct X86CPU {
>       */
>      bool force_features;
>      bool expose_kvm;
> +    bool expose_vmware;
>      bool expose_tcg;
>      bool migratable;
>      bool migrate_smi_count;
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 00917196dffb..2656258b96b3 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1187,6 +1187,15 @@ static int hyperv_handle_properties(CPUState *cs,
>      if (!hyperv_enabled(cpu))
>          return 0;
>  
> +    /*
> +     * VMware & Hyper-V conflicts in CPUID leafs.
> +     * Therefore, they cannot exists together.
> +     */
> +    if (cpu->expose_vmware) {
> +        error_report("vmware-cpuid not compatible with hyperv options");
> +        return -ENOTSUP;
> +    }
> +
>      if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ||
>          cpu->hyperv_passthrough) {
>          uint16_t evmcs_version;
> @@ -1508,6 +1517,18 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          has_msr_hv_hypercall = true;
>      }
>  
> +    if (cpu->expose_vmware) {
> +        c = &cpuid_data.entries[cpuid_i++];
> +        c->function = KVM_CPUID_SIGNATURE;
> +        memcpy(signature, "VMwareVMware", 12);
> +        c->eax = KVM_CPUID_SIGNATURE;
> +        c->ebx = signature[0];
> +        c->ecx = signature[1];
> +        c->edx = signature[2];
> +
> +        kvm_base = KVM_CPUID_SIGNATURE_NEXT;
> +    }
> +
>      if (cpu->expose_kvm) {
>          memcpy(signature, "KVMKVMKVM\0\0\0", 12);
>          c = &cpuid_data.entries[cpuid_i++];
> @@ -1791,11 +1812,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          }
>      }
>  
> -    if (cpu->vmware_cpuid_freq
> -        /* Guests depend on 0x40000000 to detect this feature, so only expose
> -         * it if KVM exposes leaf 0x40000000. (Conflicts with Hyper-V) */
> -        && cpu->expose_kvm
> -        && kvm_base == KVM_CPUID_SIGNATURE
> +    if (cpu->vmware_cpuid_freq &&
> +        (cpu->expose_vmware ||
> +         /*
> +          * Guests depend on 0x40000000 to detect this feature, so only expose
> +          * it if KVM exposes leaf 0x40000000. (Conflicts with Hyper-V)
> +          */
> +          (cpu->expose_kvm && kvm_base == KVM_CPUID_SIGNATURE))
>          /* TSC clock must be stable and known for this feature. */
>          && tsc_is_stable_and_known(env)) {
>  
> @@ -1805,7 +1828,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          c->ebx = env->apic_bus_freq / 1000; /* Hz to KHz */
>          c->ecx = c->edx = 0;
>  
> -        c = cpuid_find_entry(&cpuid_data.cpuid, kvm_base, 0);
> +        c = cpuid_find_entry(&cpuid_data.cpuid, KVM_CPUID_SIGNATURE, 0);
>          c->eax = MAX(c->eax, KVM_CPUID_SIGNATURE | 0x10);
>      }
>  
> 


