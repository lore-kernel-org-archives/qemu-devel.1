Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222CCC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4F4206FB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdclZziA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4F4206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfho-0005FK-Dt
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kKffb-0002s3-Q9
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kKffZ-00074P-24
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600771028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3H8ADfv5DBFnuBi74rc4l4UGL408Bs2YW9HKb1phSqg=;
 b=MdclZziAg9OJyClAquoVYW9DlV1+9PqHSuSZUWgavM3mYphTqnGIvqQvEByrmFyy6mApjv
 prdmUzvvn8aoo5j2779yU2YVMuHgpKEuGzesYSR/4kqSxY/cjOfrWBFueBzeAIRweeSHzP
 k2gMVjfLvXo/b9JSHelYTPairdGOeuM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-6Ab2EKp8MkqQkw4oTd7XpQ-1; Tue, 22 Sep 2020 06:37:04 -0400
X-MC-Unique: 6Ab2EKp8MkqQkw4oTd7XpQ-1
Received: by mail-ed1-f72.google.com with SMTP id d13so5554072edz.18
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 03:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=3H8ADfv5DBFnuBi74rc4l4UGL408Bs2YW9HKb1phSqg=;
 b=OjEuTtktVXJJPSQgTUA3QpQRnUFD237z6sj4cgMhYmB5ZAGaiE7bOlnY2IBQB8ZUSQ
 qSY8o1P8QjWkciHLiZ0O4F5sNgfWU73sWh5nBciiT/T0J3xwqsiPFiLPUaEJxQC/9Z1I
 7QeB23gEyXgerDck05w/L1bdgQ4UWIVWIoib6MxtPxFFgqNRvdAffFma8SJZ/a0pPVqu
 q8mXx63ZpqYKMtCmaiDx0PsrVdthTP4z4lO8vsL2NRKxwqAK2E9jPdM85Yqom0D34gtP
 OmcSssOr3hNaaolLVh3SRr7snzbVK2QBoj8tWKke656kXVGs/E6MvscKdwIHbvgOanFR
 xjUA==
X-Gm-Message-State: AOAM5303NckWyg4+74pNRG3dnQJY3CVzDjzDE9a2Rw9HxGdcefMC+/i0
 QmZJRZnuZVAyehyMCvCF7/2K9jfXhwqgdhxoT5nqnpDcyrFHrCmYuLWc1JlZwp6Nj/uOFu9jgic
 sYYp2mGPQyb7gq5E=
X-Received: by 2002:a05:6402:22fc:: with SMTP id
 dn28mr3065156edb.365.1600771023003; 
 Tue, 22 Sep 2020 03:37:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxM9K+9ivFPI+sHBkYf1JpBQzUfsgmKo61e+50+m+UJ7VMACYUfXuRB+Sxz35J9FZfW96UkoA==
X-Received: by 2002:a05:6402:22fc:: with SMTP id
 dn28mr3065135edb.365.1600771022731; 
 Tue, 22 Sep 2020 03:37:02 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id n26sm10877609ejz.89.2020.09.22.03.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 03:37:02 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH RFC 22/22] i386: expand Hyper-V features early
In-Reply-To: <20200918224721.GL57321@habkost.net>
References: <20200904145431.196885-1-vkuznets@redhat.com>
 <20200904145431.196885-23-vkuznets@redhat.com>
 <20200918224721.GL57321@habkost.net>
Date: Tue, 22 Sep 2020 12:37:01 +0200
Message-ID: <878sd2f67m.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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

> On Fri, Sep 04, 2020 at 04:54:31PM +0200, Vitaly Kuznetsov wrote:
>> To make Hyper-V features appear in e.g. QMP query-cpu-model-expansion we
>> need to expand and set the corresponding CPUID leaves early. Modify
>> x86_cpu_get_supported_feature_word() to call newly intoduced Hyper-V
>> specific kvm_hv_get_supported_cpuid() instead of
>> kvm_arch_get_supported_cpuid(). We can't use kvm_arch_get_supported_cpuid()
>> as Hyper-V specific CPUID leaves intersect with KVM's.
>> 
>> Note, early expansion will only happen when KVM supports system wide
>> KVM_GET_SUPPORTED_HV_CPUID ioctl (KVM_CAP_SYS_HYPERV_CPUID).
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
> [...]
>> +uint32_t kvm_hv_get_supported_cpuid(X86CPU *cpu, enum FeatureWord w)
>> +{
>> +    CPUState *cs = CPU(cpu);
>> +    CPUX86State *env = &cpu->env;
>> +    Error *local_err = NULL;
>> +
>> +    hyperv_expand_features(cs, &local_err);
>
> This makes a function that sounds like it doesn't have any side
> effect ("get supported cpuid") have an unintended side effect
> (hyperv_expand_features() will change all CPUID data inside the
> cpu object).
>
> What about making it more similar to
> kvm_arch_get_supported_cpuid(), and be just a wrapper to
> get_supported_hv_cpuid()?
>
> I would also make sure get_supported_hv_cpuid() doesn't get
> CPUState as argument, just to be sure it will never touch the CPU
> object state.

Sure, I can try. The difference with get_supported_cpuid() is that
get_supported_hv_cpuid() currently doesn't have cache and we don't
probably want to call KVM_GET_SUPPORTED_HV_CPUID ioctl for every CPUID
leaf. I don't see why it can't be introduced though.

>
>> +
>> +    if (local_err) {
>> +            error_report_err(local_err);
>> +    }
>> +
>> +    return env->features[w];
>> +}
>> +
>>  static Error *hv_passthrough_mig_blocker;
>>  static Error *hv_no_nonarch_cs_mig_blocker;
>>  
>> diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
>> index 064b8798a26c..2e7da4f39668 100644
>> --- a/target/i386/kvm_i386.h
>> +++ b/target/i386/kvm_i386.h
>> @@ -48,4 +48,11 @@ bool kvm_has_waitpkg(void);
>>  
>>  bool kvm_hv_vpindex_settable(void);
>>  
>> +static inline bool hyperv_feature_word(enum FeatureWord w)
>> +{
>> +    return w >= FEAT_HYPERV_EAX && w <= FEAT_HV_NESTED_EDX;
>> +}
>> +
>> +uint32_t kvm_hv_get_supported_cpuid(X86CPU *cpu, enum FeatureWord w);
>> +
>>  #endif
>> -- 
>> 2.25.4
>> 

-- 
Vitaly


