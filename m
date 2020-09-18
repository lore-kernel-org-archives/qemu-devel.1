Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EFFC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903C32100A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2k81rNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903C32100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJOiO-0004PG-Op
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 18:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJOfk-0001sX-G6
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 18:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22292)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJOfi-0008Ds-L5
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 18:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600467361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JPqqUYOilUNBsNsCdknHADm98dIjjuf8KGrasiN8234=;
 b=D2k81rNrms3IuJqi0gVFeiolsN2B48mg/jMgzMA+mf3usPOV3/NW02+N37kjhqVMYe3OMa
 2f38e5ZZSSuYUFxYhI2L2+tdZcd2EJKGlcGFNKuryVq2CAPqe0/kRNaqDo2lUFhhShrmO8
 5qPXm1xE4wkdRA/DXnQZ/T0+zAN3LtI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-wYyiDFh9PkiTMZlH21b3-Q-1; Fri, 18 Sep 2020 18:15:59 -0400
X-MC-Unique: wYyiDFh9PkiTMZlH21b3-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A26988EF1D
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 22:15:58 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03C5A55762;
 Fri, 18 Sep 2020 22:15:57 +0000 (UTC)
Date: Fri, 18 Sep 2020 18:15:57 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 05/22] i386: move hyperv_version_id initialization to
 x86_cpu_realizefn()
Message-ID: <20200918221557.GD57321@habkost.net>
References: <20200904145431.196885-1-vkuznets@redhat.com>
 <20200904145431.196885-6-vkuznets@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200904145431.196885-6-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

On Fri, Sep 04, 2020 at 04:54:14PM +0200, Vitaly Kuznetsov wrote:
> As a preparation to expanding Hyper-V CPU features early, move
> hyperv_version_id initialization to x86_cpu_realizefn().
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  target/i386/cpu.c |  4 ++++
>  target/i386/cpu.h |  1 +
>  target/i386/kvm.c | 14 ++++++++++++--
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 16888125a30a..e605399eb8c0 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6644,6 +6644,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>      cpu->hyperv_interface_id[2] = 0;
>      cpu->hyperv_interface_id[3] = 0;
>  
> +    /* Hypervisor system identity */
> +    cpu->hyperv_version_id[0] = 0x00001bbc;
> +    cpu->hyperv_version_id[1] = 0x00060001;
> +
>      if (cpu->ucode_rev == 0) {
>          /* The default is the same as KVM's.  */
>          if (IS_AMD_CPU(env)) {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 91edc54a268c..2630ffd2d4b2 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1661,6 +1661,7 @@ struct X86CPU {
>      OnOffAuto hyperv_no_nonarch_cs;
>      uint32_t hyperv_vendor_id[3];
>      uint32_t hyperv_interface_id[4];
> +    uint32_t hyperv_version_id[4];
>  
>      bool check_cpuid;
>      bool enforce_cpuid;
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index a36c65100cd0..169bae2779a4 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1239,6 +1239,14 @@ static int hyperv_handle_properties(CPUState *cs,
>              cpu->hyperv_interface_id[3] = c->edx;
>          }
>  
> +        c = cpuid_find_entry(cpuid, HV_CPUID_VERSION, 0);
> +        if (c) {
> +            cpu->hyperv_version_id[0] = c->eax;
> +            cpu->hyperv_version_id[1] = c->ebx;
> +            cpu->hyperv_version_id[2] = c->ecx;
> +            cpu->hyperv_version_id[3] = c->edx;
> +        }
> +

Same questions I had for vendor id: is hyperv_version_id broken
when using hv-passthrough today?  Should this go to a separate
patch?

>          c = cpuid_find_entry(cpuid, HV_CPUID_FEATURES, 0);
>          if (c) {
>              env->features[FEAT_HYPERV_EAX] = c->eax;
> @@ -1328,8 +1336,10 @@ static int hyperv_handle_properties(CPUState *cs,
>  
>      c = &cpuid_ent[cpuid_i++];
>      c->function = HV_CPUID_VERSION;
> -    c->eax = 0x00001bbc;
> -    c->ebx = 0x00060001;
> +    c->eax = cpu->hyperv_version_id[0];
> +    c->ebx = cpu->hyperv_version_id[1];
> +    c->ecx = cpu->hyperv_version_id[2];
> +    c->edx = cpu->hyperv_version_id[3];
>  
>      c = &cpuid_ent[cpuid_i++];
>      c->function = HV_CPUID_FEATURES;
> -- 
> 2.25.4
> 

-- 
Eduardo


