Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578E3C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 19:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218B9207DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 19:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6Cmwwba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218B9207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxbfT-0006gd-AN
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 15:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jxbeZ-0005t4-SQ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 15:40:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30092
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jxbeX-0005zL-6p
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 15:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595274043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ac3QmFK62rwOQIXaLdKy6Vsk4yZRSt4hUTB8aWJqnY=;
 b=e6CmwwbaGBZbIVuueHxts4i2lu42+HQ+ZReyKLbiB3xdvCUpyU1AeNuip4lueb6r+6t/H5
 YMW4lTK1jCx7axToLdhk+W3EnKw0LT7SRNkTlPwIe9w3gmQhEFWBPqz4+76CZdSZ1xaqYA
 +ZKzHd17otKwW4Pr03pyYqYlCmKGXaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-hFulHOAlMgao_xhnhADswQ-1; Mon, 20 Jul 2020 15:40:41 -0400
X-MC-Unique: hFulHOAlMgao_xhnhADswQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9050D107ACCA;
 Mon, 20 Jul 2020 19:40:40 +0000 (UTC)
Received: from localhost (unknown [10.10.67.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C92D2DE99;
 Mon, 20 Jul 2020 19:40:40 +0000 (UTC)
Date: Mon, 20 Jul 2020 15:40:39 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] i386/kvm: correct the meaning of '0xffffffff' value for
 hv-spinlocks
Message-ID: <20200720194039.GX1274972@habkost.net>
References: <20200515114847.74523-1-vkuznets@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200515114847.74523-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 15, 2020 at 01:48:47PM +0200, Vitaly Kuznetsov wrote:
> Hyper-V TLFS prior to version 6.0 had a mistake in it: special value
> '0xffffffff' for CPUID 0x40000004.EBX was called 'never to retry', this
> looked weird (like why it's not '0' which supposedly have the same effect?)
> but nobody raised the question. In TLFS version 6.0 the mistake was
> corrected to 'never notify' which sounds logical. Fix QEMU accordingly.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

I've just found this buried in my inbox, sorry for missing it!

Queued for 5.2.

> ---
>  docs/hyperv.txt   | 2 +-
>  target/i386/cpu.c | 2 +-
>  target/i386/cpu.h | 4 ++--
>  target/i386/kvm.c | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/hyperv.txt b/docs/hyperv.txt
> index 6518b716a958..5df00da54fc4 100644
> --- a/docs/hyperv.txt
> +++ b/docs/hyperv.txt
> @@ -49,7 +49,7 @@ more efficiently. In particular, this enlightenment allows paravirtualized
>  ======================
>  Enables paravirtualized spinlocks. The parameter indicates how many times
>  spinlock acquisition should be attempted before indicating the situation to the
> -hypervisor. A special value 0xffffffff indicates "never to retry".
> +hypervisor. A special value 0xffffffff indicates "never notify".
>  
>  3.4. hv-vpindex
>  ================
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 7a4a8e3847f0..5bb9a8017523 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7133,7 +7133,7 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
>  
>      DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
> -                       HYPERV_SPINLOCK_NEVER_RETRY),
> +                       HYPERV_SPINLOCK_NEVER_NOTIFY),
>      DEFINE_PROP_BIT64("hv-relaxed", X86CPU, hyperv_features,
>                        HYPERV_FEAT_RELAXED, 0),
>      DEFINE_PROP_BIT64("hv-vapic", X86CPU, hyperv_features,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 408392dbf6f4..80253d1c373b 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -980,8 +980,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
>  #define HYPERV_FEAT_IPI                 13
>  #define HYPERV_FEAT_STIMER_DIRECT       14
>  
> -#ifndef HYPERV_SPINLOCK_NEVER_RETRY
> -#define HYPERV_SPINLOCK_NEVER_RETRY             0xFFFFFFFF
> +#ifndef HYPERV_SPINLOCK_NEVER_NOTIFY
> +#define HYPERV_SPINLOCK_NEVER_NOTIFY             0xFFFFFFFF
>  #endif
>  
>  #define EXCP00_DIVZ	0
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 34f838728dd6..28e9c73cc2a5 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -731,7 +731,7 @@ static bool hyperv_enabled(X86CPU *cpu)
>  {
>      CPUState *cs = CPU(cpu);
>      return kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV) > 0 &&
> -        ((cpu->hyperv_spinlock_attempts != HYPERV_SPINLOCK_NEVER_RETRY) ||
> +        ((cpu->hyperv_spinlock_attempts != HYPERV_SPINLOCK_NEVER_NOTIFY) ||
>           cpu->hyperv_features || cpu->hyperv_passthrough);
>  }
>  
> @@ -1201,7 +1201,7 @@ static int hyperv_handle_properties(CPUState *cs,
>              env->features[FEAT_HV_RECOMM_EAX] = c->eax;
>  
>              /* hv-spinlocks may have been overriden */
> -            if (cpu->hyperv_spinlock_attempts != HYPERV_SPINLOCK_NEVER_RETRY) {
> +            if (cpu->hyperv_spinlock_attempts != HYPERV_SPINLOCK_NEVER_NOTIFY) {
>                  c->ebx = cpu->hyperv_spinlock_attempts;
>              }
>          }
> -- 
> 2.25.4
> 

-- 
Eduardo


