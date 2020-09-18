Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A779C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19EC72100A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDSRe9f0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19EC72100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJOgu-0002Xw-6L
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 18:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJOeo-0001Fs-9Q
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 18:15:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57428
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJOeh-0007x9-Ln
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 18:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600467298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PiCA1djH/89K0wWjBgjSq0CPMKgQU3DIRMaYZ3QWvXQ=;
 b=UDSRe9f0faBuTEkebSFS95YQV4GrPMghrqquTljnXYnJnogD9p1HK82idJLcx4x92MOD0D
 8sLscFhxQVxcMWom5guIlKBBXUzvRtBr5zot26oLDisEWVrCZOunWfy7RczDp1/M0Znuhp
 ebw5jHKEmNnHPquv4xyqAiKxVEVFsio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-4fSZZKukMpeIDufWhCu1Gw-1; Fri, 18 Sep 2020 18:14:56 -0400
X-MC-Unique: 4fSZZKukMpeIDufWhCu1Gw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 405D864147
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 22:14:55 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D54DB5D9D5;
 Fri, 18 Sep 2020 22:14:54 +0000 (UTC)
Date: Fri, 18 Sep 2020 18:14:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 03/22] i386: move hyperv_vendor_id initialization to
 x86_cpu_realizefn()
Message-ID: <20200918221454.GC57321@habkost.net>
References: <20200904145431.196885-1-vkuznets@redhat.com>
 <20200904145431.196885-4-vkuznets@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200904145431.196885-4-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

On Fri, Sep 04, 2020 at 04:54:12PM +0200, Vitaly Kuznetsov wrote:
> As a preparation to expanding Hyper-V CPU features early, move
> hyperv_vendor_id initialization to x86_cpu_realizefn().
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  target/i386/cpu.c | 15 ++++++++++++++-
>  target/i386/cpu.h |  3 ++-
>  target/i386/kvm.c | 25 ++++++++++---------------
>  3 files changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 14489def2177..07e9da9e567e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6625,6 +6625,19 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>          }
>      }
>  
> +    if (!cpu->hyperv_vendor) {
> +        memcpy(cpu->hyperv_vendor_id, "Microsoft Hv", 12);
> +    } else {
> +        size_t len = strlen(cpu->hyperv_vendor);
> +
> +        if (len > 12) {
> +            warn_report("hv-vendor-id truncated to 12 characters");
> +            len = 12;
> +        }
> +        memset(cpu->hyperv_vendor_id, 0, 12);
> +        memcpy(cpu->hyperv_vendor_id, cpu->hyperv_vendor, len);
> +    }
> +

The change makes sense, but considering that we'll have a lot of
new code added to x86_cpu_realizefn(), I would prefer to create a
separate x86_cpu_hyperv_realize() function to make
x86_cpu_realizefn() a bit more readable.


>      if (cpu->ucode_rev == 0) {
>          /* The default is the same as KVM's.  */
>          if (IS_AMD_CPU(env)) {
> @@ -7313,7 +7326,7 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_UINT32("min-xlevel2", X86CPU, env.cpuid_min_xlevel2, 0),
>      DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
>      DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
> -    DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor_id),
> +    DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
>      DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
>      DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
>      DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index d3097be6a50a..903994818093 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1654,11 +1654,12 @@ struct X86CPU {
>      uint64_t ucode_rev;
>  
>      uint32_t hyperv_spinlock_attempts;
> -    char *hyperv_vendor_id;
> +    char *hyperv_vendor;
>      bool hyperv_synic_kvm_only;
>      uint64_t hyperv_features;
>      bool hyperv_passthrough;
>      OnOffAuto hyperv_no_nonarch_cs;
> +    uint32_t hyperv_vendor_id[3];
>  
>      bool check_cpuid;
>      bool enforce_cpuid;
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 205b68bc0ce8..47779c5e1efd 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1225,6 +1225,13 @@ static int hyperv_handle_properties(CPUState *cs,
>          memcpy(cpuid_ent, &cpuid->entries[0],
>                 cpuid->nent * sizeof(cpuid->entries[0]));
>  
> +        c = cpuid_find_entry(cpuid, HV_CPUID_VENDOR_AND_MAX_FUNCTIONS, 0);
> +        if (c) {
> +            cpu->hyperv_vendor_id[0] = c->ebx;
> +            cpu->hyperv_vendor_id[1] = c->ecx;
> +            cpu->hyperv_vendor_id[2] = c->edx;
> +        }
> +

I can't find the equivalent of this code in the current tree?  Is
hyperv vendor ID broken when using hv-passthrough today?

Maybe this could be done as a separate patch, as it changes
behavior of hv-passthrough?

>          c = cpuid_find_entry(cpuid, HV_CPUID_FEATURES, 0);
>          if (c) {
>              env->features[FEAT_HYPERV_EAX] = c->eax;
> @@ -1299,23 +1306,11 @@ static int hyperv_handle_properties(CPUState *cs,
>  
>      c = &cpuid_ent[cpuid_i++];
>      c->function = HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
> -    if (!cpu->hyperv_vendor_id) {
> -        memcpy(signature, "Microsoft Hv", 12);
> -    } else {
> -        size_t len = strlen(cpu->hyperv_vendor_id);
> -
> -        if (len > 12) {
> -            error_report("hv-vendor-id truncated to 12 characters");
> -            len = 12;
> -        }
> -        memset(signature, 0, 12);
> -        memcpy(signature, cpu->hyperv_vendor_id, len);
> -    }
>      c->eax = hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ?
>          HV_CPUID_NESTED_FEATURES : HV_CPUID_IMPLEMENT_LIMITS;
> -    c->ebx = signature[0];
> -    c->ecx = signature[1];
> -    c->edx = signature[2];
> +    c->ebx = cpu->hyperv_vendor_id[0];
> +    c->ecx = cpu->hyperv_vendor_id[1];
> +    c->edx = cpu->hyperv_vendor_id[2];
>  
>      c = &cpuid_ent[cpuid_i++];
>      c->function = HV_CPUID_INTERFACE;
> -- 
> 2.25.4
> 

-- 
Eduardo


