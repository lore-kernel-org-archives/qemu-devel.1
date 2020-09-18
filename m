Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F50AC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144E8206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NcaoD7QQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144E8206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJOm4-0006j3-4r
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 18:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJOgO-0002Kg-Ro
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 18:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJOgN-0008HI-1y
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 18:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600467402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rSy8cMPNK12wJT4tPK6F8Zx8qEUYZUJh/r/7/nvOOJo=;
 b=NcaoD7QQGvQsjhNfHCyx6dg4IunBqG81ZH5rc3RO8fx0vP5O035o4x6hel9rfe/vQkYk8j
 cgDM0zt0zjk5MHgsTbBPDpdM0gJeXXv8/XWzJBvdWwdL9wCUp5slykiGoTXaMhdlA+l9ls
 H1kgsHNYn52aNtp/0NcGh90j7v+mMEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-Yv270QXdOKOozDEfRIM7PQ-1; Fri, 18 Sep 2020 18:16:40 -0400
X-MC-Unique: Yv270QXdOKOozDEfRIM7PQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1787088EF1E
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 22:16:39 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1C9A60BEC;
 Fri, 18 Sep 2020 22:16:38 +0000 (UTC)
Date: Fri, 18 Sep 2020 18:16:37 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 06/22] i386: move hyperv_limits initialization to
 x86_cpu_realizefn()
Message-ID: <20200918221637.GE57321@habkost.net>
References: <20200904145431.196885-1-vkuznets@redhat.com>
 <20200904145431.196885-7-vkuznets@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200904145431.196885-7-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
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

On Fri, Sep 04, 2020 at 04:54:15PM +0200, Vitaly Kuznetsov wrote:
> As a preparation to expanding Hyper-V CPU features early, move
> hyperv_limits initialization to x86_cpu_realizefn().
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  target/i386/cpu.c |  5 +++++
>  target/i386/cpu.h |  1 +
>  target/i386/kvm.c | 13 ++++++++++++-
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index e605399eb8c0..ef3c672cf415 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6648,6 +6648,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>      cpu->hyperv_version_id[0] = 0x00001bbc;
>      cpu->hyperv_version_id[1] = 0x00060001;
>  
> +    /* Hypervisor implementation limits */
> +    cpu->hyperv_limits[0] = 64;
> +    cpu->hyperv_limits[1] = 0;
> +    cpu->hyperv_limits[2] = 0;
> +
>      if (cpu->ucode_rev == 0) {
>          /* The default is the same as KVM's.  */
>          if (IS_AMD_CPU(env)) {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 2630ffd2d4b2..095d0bf75493 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1662,6 +1662,7 @@ struct X86CPU {
>      uint32_t hyperv_vendor_id[3];
>      uint32_t hyperv_interface_id[4];
>      uint32_t hyperv_version_id[4];
> +    uint32_t hyperv_limits[3];
>  
>      bool check_cpuid;
>      bool enforce_cpuid;
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 169bae2779a4..720c30e9df17 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1253,6 +1253,15 @@ static int hyperv_handle_properties(CPUState *cs,
>              env->features[FEAT_HYPERV_EBX] = c->ebx;
>              env->features[FEAT_HYPERV_EDX] = c->eax;
>          }
> +
> +        c = cpuid_find_entry(cpuid, HV_CPUID_IMPLEMENT_LIMITS, 0);
> +        if (c) {
> +            cpu->hv_max_vps = c->eax;
> +            cpu->hyperv_limits[0] = c->ebx;
> +            cpu->hyperv_limits[1] = c->ecx;
> +            cpu->hyperv_limits[2] = c->edx;
> +        }
> +

Sam question I had for vendor id and version id: should it go to
a separate patch as it changes behavior of hv-passthrough?

>          c = cpuid_find_entry(cpuid, HV_CPUID_ENLIGHTMENT_INFO, 0);
>          if (c) {
>              env->features[FEAT_HV_RECOMM_EAX] = c->eax;
> @@ -1355,7 +1364,9 @@ static int hyperv_handle_properties(CPUState *cs,
>      c = &cpuid_ent[cpuid_i++];
>      c->function = HV_CPUID_IMPLEMENT_LIMITS;
>      c->eax = cpu->hv_max_vps;
> -    c->ebx = 0x40;
> +    c->ebx = cpu->hyperv_limits[0];
> +    c->ecx = cpu->hyperv_limits[1];
> +    c->edx = cpu->hyperv_limits[2];
>  
>      if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
>          __u32 function;
> -- 
> 2.25.4
> 

-- 
Eduardo


