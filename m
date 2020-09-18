Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ACFC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6FA206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DziSw0OY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6FA206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJOoB-0000MZ-Gf
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 18:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJOmm-0007XH-SS
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 18:23:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27217
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJOmj-0000fT-Il
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 18:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600467796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ddlgZFuDnMSl2sr7V1fu31uEjOqeOSgS6QBx4mYSRkA=;
 b=DziSw0OYELb18thMt3wjmrhEz6igsFkRDfzZeK81TMIJBnZcjSsSvxWqfgvqTa65PKNpTS
 qq1sqNnpEcFvx4cXBHqG+oa3eZnjFCSR8Ko5R8l7ARE0Rlx7r//iK98T33ps0o5flBBdkI
 w9f3fMxcEmiuDs1J2pMUB0ezlKGiA68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-VnD8aWkmPpqUYlDpOdnQZw-1; Fri, 18 Sep 2020 18:23:14 -0400
X-MC-Unique: VnD8aWkmPpqUYlDpOdnQZw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5B3A1882FBB
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 22:23:13 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F0B778803;
 Fri, 18 Sep 2020 22:23:13 +0000 (UTC)
Date: Fri, 18 Sep 2020 18:23:13 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/22] i386: move hyperv_interface_id initialization
 to x86_cpu_realizefn()
Message-ID: <20200918222313.GH57321@habkost.net>
References: <20200904145431.196885-1-vkuznets@redhat.com>
 <20200904145431.196885-5-vkuznets@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200904145431.196885-5-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 16:24:56
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

On Fri, Sep 04, 2020 at 04:54:13PM +0200, Vitaly Kuznetsov wrote:
> As a preparation to expanding Hyper-V CPU features early, move
> hyperv_interface_id initialization to x86_cpu_realizefn().
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  target/i386/cpu.c |  6 ++++++
>  target/i386/cpu.h |  1 +
>  target/i386/kvm.c | 18 ++++++++++++------
>  3 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 07e9da9e567e..16888125a30a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6638,6 +6638,12 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>          memcpy(cpu->hyperv_vendor_id, cpu->hyperv_vendor, len);
>      }
>  
> +    /* 'Hv#1' interface identification*/
> +    cpu->hyperv_interface_id[0] = 0x31237648;
> +    cpu->hyperv_interface_id[1] = 0;
> +    cpu->hyperv_interface_id[2] = 0;
> +    cpu->hyperv_interface_id[3] = 0;
> +
>      if (cpu->ucode_rev == 0) {
>          /* The default is the same as KVM's.  */
>          if (IS_AMD_CPU(env)) {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 903994818093..91edc54a268c 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1660,6 +1660,7 @@ struct X86CPU {
>      bool hyperv_passthrough;
>      OnOffAuto hyperv_no_nonarch_cs;
>      uint32_t hyperv_vendor_id[3];
> +    uint32_t hyperv_interface_id[4];
>  
>      bool check_cpuid;
>      bool enforce_cpuid;
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 47779c5e1efd..a36c65100cd0 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1188,7 +1188,6 @@ static int hyperv_handle_properties(CPUState *cs,
>      CPUX86State *env = &cpu->env;
>      struct kvm_cpuid2 *cpuid;
>      struct kvm_cpuid_entry2 *c;
> -    uint32_t signature[3];
>      uint32_t cpuid_i = 0;
>      int r;
>  
> @@ -1232,6 +1231,14 @@ static int hyperv_handle_properties(CPUState *cs,
>              cpu->hyperv_vendor_id[2] = c->edx;
>          }
>  
> +        c = cpuid_find_entry(cpuid, HV_CPUID_INTERFACE, 0);
> +        if (c) {
> +            cpu->hyperv_interface_id[0] = c->eax;
> +            cpu->hyperv_interface_id[1] = c->ebx;
> +            cpu->hyperv_interface_id[2] = c->ecx;
> +            cpu->hyperv_interface_id[3] = c->edx;
> +        }
> +

Same question I sent for vendor id, version id, hyperv_limits:
should this go to a separate patch, as it changes behavior of
hv-passthrough?

>          c = cpuid_find_entry(cpuid, HV_CPUID_FEATURES, 0);
>          if (c) {
>              env->features[FEAT_HYPERV_EAX] = c->eax;
> @@ -1314,11 +1321,10 @@ static int hyperv_handle_properties(CPUState *cs,
>  
>      c = &cpuid_ent[cpuid_i++];
>      c->function = HV_CPUID_INTERFACE;
> -    memcpy(signature, "Hv#1\0\0\0\0\0\0\0\0", 12);
> -    c->eax = signature[0];
> -    c->ebx = 0;
> -    c->ecx = 0;
> -    c->edx = 0;
> +    c->eax = cpu->hyperv_interface_id[0];
> +    c->ebx = cpu->hyperv_interface_id[1];
> +    c->ecx = cpu->hyperv_interface_id[2];
> +    c->edx = cpu->hyperv_interface_id[3];
>  
>      c = &cpuid_ent[cpuid_i++];
>      c->function = HV_CPUID_VERSION;
> -- 
> 2.25.4
> 

-- 
Eduardo


