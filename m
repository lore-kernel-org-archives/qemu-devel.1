Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC9DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 11:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3A220739
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 11:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKaAQJZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3A220739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsm0Z-0005sS-4V
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 07:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jslzP-0005IU-6B
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 07:42:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49857
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jslzN-0000O3-9K
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 07:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594122136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PNRjZkM1jw/UBiVaHM0k+sGvjhVHLJOLQ39yN4Iy2LE=;
 b=fKaAQJZuAcbMJZ+5SY0hjW03faCWOEQsevwiUXcOnK1uyBmChFG/SqS3NW8NH3tHKn/J4S
 lwzGwSqL2alMAXPaDjqFHXaCy3ZzHeFdBZ/67PmZBSKMPM+BpP26J806jM8R6d2wUZ4qF0
 S294f2/eghanFZ8KTSTnHtmY0HIZFxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-v43ue8FAOsq-K8mB6nmVGQ-1; Tue, 07 Jul 2020 07:42:14 -0400
X-MC-Unique: v43ue8FAOsq-K8mB6nmVGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9576FEC1AF;
 Tue,  7 Jul 2020 11:42:13 +0000 (UTC)
Received: from starship (unknown [10.35.206.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 879285D9F3;
 Tue,  7 Jul 2020 11:42:12 +0000 (UTC)
Message-ID: <55c743389f61f010b901dfe211f2a832112d53b5.camel@redhat.com>
Subject: Re: [PULL 31/53] KVM: x86: believe what KVM says about WAITPKG
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Date: Tue, 07 Jul 2020 14:42:11 +0300
In-Reply-To: <20200706164155.24696-32-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
 <20200706164155.24696-32-pbonzini@redhat.com>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-07-06 at 12:41 -0400, Paolo Bonzini wrote:
> Currently, QEMU is overriding KVM_GET_SUPPORTED_CPUID's answer for
> the WAITPKG bit depending on the "-overcommit cpu-pm" setting.  This is a
> bad idea because it does not even check if the host supports it, but it
> can be done in x86_cpu_realizefn just like we do for the MONITOR bit.
> 
> This patch moves it there, while making it conditional on host
> support for the related UMWAIT MSR.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c      |  3 +++
>  target/i386/kvm.c      | 11 +++++------
>  target/i386/kvm_i386.h |  1 +
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c44cc510e1..dc9ba06f1f 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6536,6 +6536,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>              host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
>                         &cpu->mwait.ecx, &cpu->mwait.edx);
>              env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
> +            if (kvm_enabled() && kvm_has_waitpkg()) {
> +                env->features[FEAT_7_0_ECX] |= CPUID_7_0_ECX_WAITPKG;
> +            }
>          }
>          if (kvm_enabled() && cpu->ucode_rev == 0) {
>              cpu->ucode_rev = kvm_arch_get_supported_msr_feature(kvm_state,
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 2b6b7443d2..b8455c89ed 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -411,12 +411,6 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>          if (host_tsx_blacklisted()) {
>              ret &= ~(CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_HLE);
>          }
> -    } else if (function == 7 && index == 0 && reg == R_ECX) {
> -        if (enable_cpu_pm) {
> -            ret |= CPUID_7_0_ECX_WAITPKG;
> -        } else {
> -            ret &= ~CPUID_7_0_ECX_WAITPKG;
> -        }
>      } else if (function == 7 && index == 0 && reg == R_EDX) {
>          /*
>           * Linux v4.17-v4.20 incorrectly return ARCH_CAPABILITIES on SVM hosts.
> @@ -4730,3 +4724,8 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>  {
>      abort();
>  }
> +
> +bool kvm_has_waitpkg(void)
> +{
> +    return has_msr_umwait;
Note that this depends on the fix in the kernel
to report this msr only when UMWAIT is supported.
I personally don't mind that.

If we want to support older kernels that don't,
then we have to run 'cpuid' ourselves and check the result.

Otherwise looks good to me.

Best regards,
	Maxim Levitsky

> +}
> diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
> index 00bde7acaf..064b8798a2 100644
> --- a/target/i386/kvm_i386.h
> +++ b/target/i386/kvm_i386.h
> @@ -44,6 +44,7 @@ void kvm_put_apicbase(X86CPU *cpu, uint64_t value);
>  
>  bool kvm_enable_x2apic(void);
>  bool kvm_has_x2apic_api(void);
> +bool kvm_has_waitpkg(void);
>  
>  bool kvm_hv_vpindex_settable(void);
>  



