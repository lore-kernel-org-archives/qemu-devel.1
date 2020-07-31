Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E031C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 19:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C372087C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 19:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3LWkr3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C372087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1b2G-0001gi-5m
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 15:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k1b1V-0001DJ-Oc
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 15:48:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34882
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k1b1S-00070q-R6
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 15:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596224932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0KmuHGeTPKwkDX4esuxCZ0HvUlHxCfBe+nLh2txgkkA=;
 b=h3LWkr3fIzPdOWI+Djlu4LIgTz0rSAuA+8B4Vr6iHs+nBQl8qIFxlk8thHUrVVU7TTy/x0
 tVh8ACRTaToKUirw6R5Twres45B6tHWbot2N2R+GQYBsWzcp/piaosXqhX7jDZnfh7SoFB
 HyH3m4qiUa1ktI0LzSY8wWo8f09GIMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-CtiW05VkPbmf6P3XC_T9hg-1; Fri, 31 Jul 2020 15:48:48 -0400
X-MC-Unique: CtiW05VkPbmf6P3XC_T9hg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C76771083E84;
 Fri, 31 Jul 2020 19:48:47 +0000 (UTC)
Received: from localhost (ovpn-120-33.rdu2.redhat.com [10.10.120.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0292310013D9;
 Fri, 31 Jul 2020 19:48:41 +0000 (UTC)
Date: Fri, 31 Jul 2020 15:48:40 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [RFC PATCH] target/i386: kvm: Enable KVM_FEATURE_PCI_GO_MMCONFIG
 CPUID bit
Message-ID: <20200731194840.GI225270@habkost.net>
References: <20200731184938.606754-1-jusual@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200731184938.606754-1-jusual@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 12:28:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 31, 2020 at 08:49:38PM +0200, Julia Suvorova wrote:
> This feature allows MMCONFIG to be used even to access the base PCI
> config space [1]. This means increased performance: one access to
> MMCONFIG instead of two conventional accesses to I/O ports.
> 
> Q35 makes no distinction in base or extended PCI config access to
> MMCONFIG, MMCONFIG is always on, and in case it is is not initialized,
> probing of PCI devices will fall back to normal process and use type1
> access.
> 
> Enable the feature unconditionally.
> 
> [1]: https://lore.kernel.org/kvm/20200730193510.578309-1-jusual@redhat.com/
> 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
> The feature is in the review phase.
> 
>  include/standard-headers/asm-x86/kvm_para.h | 1 +
>  target/i386/cpu.c                           | 3 ++-
>  target/i386/kvm.c                           | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/standard-headers/asm-x86/kvm_para.h b/include/standard-headers/asm-x86/kvm_para.h
> index 07877d3295..52eeba9067 100644
> --- a/include/standard-headers/asm-x86/kvm_para.h
> +++ b/include/standard-headers/asm-x86/kvm_para.h
> @@ -32,6 +32,7 @@
>  #define KVM_FEATURE_POLL_CONTROL	12
>  #define KVM_FEATURE_PV_SCHED_YIELD	13
>  #define KVM_FEATURE_ASYNC_PF_INT	14
> +#define KVM_FEATURE_PCI_GO_MMCONFIG	15
>  
>  #define KVM_HINTS_REALTIME      0
>  
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 588f32e136..5509523bb3 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -810,7 +810,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
>              "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
>              NULL, "kvm-pv-tlb-flush", NULL, "kvm-pv-ipi",
> -            "kvm-poll-control", "kvm-pv-sched-yield", NULL, NULL,
> +            "kvm-poll-control", "kvm-pv-sched-yield", NULL, "kvm-pci-go-mmconfig",
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              "kvmclock-stable-bit", NULL, NULL, NULL,
> @@ -4141,6 +4141,7 @@ static PropValue kvm_default_props[] = {
>      { "acpi", "off" },
>      { "monitor", "off" },
>      { "svm", "off" },
> +    { "kvm-pci-go-mmconfig", "on" },

You'll need a TYPE_X86_CPU.kvm-pci-go-mmconfig=off entry in
pc_compat_5_1 to keep guest ABI compatibility on older machine
types.

pc_compat_5_1 is introduced by
https://lore.kernel.org/qemu-devel/20200728094645.272149-1-cohuck@redhat.com/
("hw: add compat machines for 5.2").

>      { NULL, NULL },
>  };
>  
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 6f18d940a5..0069e945e6 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -440,6 +440,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>          if (!kvm_irqchip_in_kernel()) {
>              ret &= ~(1U << KVM_FEATURE_PV_UNHALT);
>          }
> +        ret |= 1U << KVM_FEATURE_PCI_GO_MMCONFIG;

On most cases, enabling a feature unconditionally on
kvm_arch_get_supported_cpuid() would be a mistake, but this flag
seems to be an exception to the rule.

A comment here explaining why it is really safe to enable it
unconditionally would be welcome.

>      } else if (function == KVM_CPUID_FEATURES && reg == R_EDX) {
>          ret |= 1U << KVM_HINTS_REALTIME;
>          found = 1;
> -- 
> 2.25.4
> 

-- 
Eduardo


