Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE2FC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81CD621734
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQlF0guW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CD621734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJP2D-00081W-Jl
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 18:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJP1R-0007G8-HT
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 18:38:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJP1N-0003OG-G5
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 18:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600468703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j+aq4N0KbQ0f1MO5UfH5IlP8zqq+C4UIxtylu9+vuy0=;
 b=OQlF0guWKxlUOqbYMrJoH/0w/apYn3ObuKEsK69G/ulmJFBSB4MxXIVKQf+hNmM+ldaAms
 p7tQo2oY/LCEQpTt1XRDTLfW/y6DZmxygXLkSklmrOG79iolw6k8s2EG47LeDFcy5pNbix
 xSJWPZihaRxwRALwYHPeMFGSQMG2pGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-PPuGeb6uOVe5qABnjL5vYQ-1; Fri, 18 Sep 2020 18:38:21 -0400
X-MC-Unique: PPuGeb6uOVe5qABnjL5vYQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F11F41084C94
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 22:38:20 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B65DC7B7A0;
 Fri, 18 Sep 2020 22:38:20 +0000 (UTC)
Date: Fri, 18 Sep 2020 18:38:20 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 22/22] i386: expand Hyper-V features early
Message-ID: <20200918223820.GK57321@habkost.net>
References: <20200904145431.196885-1-vkuznets@redhat.com>
 <20200904145431.196885-23-vkuznets@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200904145431.196885-23-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

On Fri, Sep 04, 2020 at 04:54:31PM +0200, Vitaly Kuznetsov wrote:
> To make Hyper-V features appear in e.g. QMP query-cpu-model-expansion we
> need to expand and set the corresponding CPUID leaves early. Modify
> x86_cpu_get_supported_feature_word() to call newly intoduced Hyper-V
> specific kvm_hv_get_supported_cpuid() instead of
> kvm_arch_get_supported_cpuid(). We can't use kvm_arch_get_supported_cpuid()
> as Hyper-V specific CPUID leaves intersect with KVM's.
> 
> Note, early expansion will only happen when KVM supports system wide
> KVM_GET_SUPPORTED_HV_CPUID ioctl (KVM_CAP_SYS_HYPERV_CPUID).

Will this implicitly enable hyperv CPUID passthrough when using
"-cpu host"?  Do we want it to?

> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  target/i386/cpu.c      | 15 +++++++++------
>  target/i386/kvm.c      | 15 +++++++++++++++
>  target/i386/kvm_i386.h |  7 +++++++
>  3 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 479c4bbbf459..d3c4ecb3535c 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5147,7 +5147,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
>      return cpu_list;
>  }
>  
> -static uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
> +static uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w,
>                                                     bool migratable_only)
>  {
>      FeatureWordInfo *wi = &feature_word_info[w];
> @@ -5156,9 +5156,12 @@ static uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
>      if (kvm_enabled()) {
>          switch (wi->type) {
>          case CPUID_FEATURE_WORD:
> -            r = kvm_arch_get_supported_cpuid(kvm_state, wi->cpuid.eax,
> -                                                        wi->cpuid.ecx,
> -                                                        wi->cpuid.reg);
> +            if (hyperv_feature_word(w))
> +                r = kvm_hv_get_supported_cpuid(cpu, w);
> +            else
> +                r = kvm_arch_get_supported_cpuid(kvm_state, wi->cpuid.eax,
> +                                                 wi->cpuid.ecx,
> +                                                 wi->cpuid.reg);
>              break;
>          case MSR_FEATURE_WORD:
>              r = kvm_arch_get_supported_msr_feature(kvm_state,
> @@ -6485,7 +6488,7 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>               * by the user.
>               */
>              env->features[w] |=
> -                x86_cpu_get_supported_feature_word(w, cpu->migratable) &
> +                x86_cpu_get_supported_feature_word(cpu, w, cpu->migratable) &
>                  ~env->user_features[w] &
>                  ~feature_word_info[w].no_autoenable_flags;
>          }
> @@ -6589,7 +6592,7 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
>  
>      for (w = 0; w < FEATURE_WORDS; w++) {
>          uint64_t host_feat =
> -            x86_cpu_get_supported_feature_word(w, false);
> +            x86_cpu_get_supported_feature_word(cpu, w, false);
>          uint64_t requested_features = env->features[w];
>          uint64_t unavailable_features = requested_features & ~host_feat;
>          mark_unavailable_features(cpu, w, unavailable_features, prefix);
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 961241528a5c..764b96fbbb7d 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1449,6 +1449,21 @@ static int hyperv_fill_cpuids(CPUState *cs,
>      return cpuid_i;
>  }
>  
> +uint32_t kvm_hv_get_supported_cpuid(X86CPU *cpu, enum FeatureWord w)
> +{
> +    CPUState *cs = CPU(cpu);
> +    CPUX86State *env = &cpu->env;
> +    Error *local_err = NULL;
> +
> +    hyperv_expand_features(cs, &local_err);
> +
> +    if (local_err) {
> +            error_report_err(local_err);
> +    }
> +
> +    return env->features[w];
> +}
> +
>  static Error *hv_passthrough_mig_blocker;
>  static Error *hv_no_nonarch_cs_mig_blocker;
>  
> diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
> index 064b8798a26c..2e7da4f39668 100644
> --- a/target/i386/kvm_i386.h
> +++ b/target/i386/kvm_i386.h
> @@ -48,4 +48,11 @@ bool kvm_has_waitpkg(void);
>  
>  bool kvm_hv_vpindex_settable(void);
>  
> +static inline bool hyperv_feature_word(enum FeatureWord w)
> +{
> +    return w >= FEAT_HYPERV_EAX && w <= FEAT_HV_NESTED_EDX;
> +}
> +
> +uint32_t kvm_hv_get_supported_cpuid(X86CPU *cpu, enum FeatureWord w);
> +
>  #endif
> -- 
> 2.25.4
> 

-- 
Eduardo


