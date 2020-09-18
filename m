Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4CEC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 171BC21734
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhCNTQmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171BC21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJPAn-0002My-6F
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 18:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJPA9-0001wa-55
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 18:47:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28574
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJPA7-0004qM-0K
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 18:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600469245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WMAQwFyr578MA607kPcz8rOilg1xoP5ibVkgRlPyew8=;
 b=LhCNTQmBzI/QYcQdk0pSy8WNg6eMSi1SOaMZHGie6UyzeJWMKIL7NdDfYyKN4CdcFxgDwN
 pMnWF4KzCskgSbvu8Q82GD3Wg1ZjzG4EdYLhII627GuGE4dnM4i0jZNT+flCLgriPEqEOv
 kSCfPyyj9wePn8OgutB5gx6MMIf799M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-NVQjYU5wM7GDt-_Nir_CWQ-1; Fri, 18 Sep 2020 18:47:23 -0400
X-MC-Unique: NVQjYU5wM7GDt-_Nir_CWQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 512B51074670
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 22:47:22 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1AD905C225;
 Fri, 18 Sep 2020 22:47:22 +0000 (UTC)
Date: Fri, 18 Sep 2020 18:47:21 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 22/22] i386: expand Hyper-V features early
Message-ID: <20200918224721.GL57321@habkost.net>
References: <20200904145431.196885-1-vkuznets@redhat.com>
 <20200904145431.196885-23-vkuznets@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200904145431.196885-23-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 18:14:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
[...]
> +uint32_t kvm_hv_get_supported_cpuid(X86CPU *cpu, enum FeatureWord w)
> +{
> +    CPUState *cs = CPU(cpu);
> +    CPUX86State *env = &cpu->env;
> +    Error *local_err = NULL;
> +
> +    hyperv_expand_features(cs, &local_err);

This makes a function that sounds like it doesn't have any side
effect ("get supported cpuid") have an unintended side effect
(hyperv_expand_features() will change all CPUID data inside the
cpu object).

What about making it more similar to
kvm_arch_get_supported_cpuid(), and be just a wrapper to
get_supported_hv_cpuid()?

I would also make sure get_supported_hv_cpuid() doesn't get
CPUState as argument, just to be sure it will never touch the CPU
object state.

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


