Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BACC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20805206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeWrUrFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20805206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFlC-0005Ks-NZ
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1idEdd-00013E-J3
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1idEdc-0006Ee-Bq
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:31:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50559
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1idEdc-0006Dg-6H
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575642679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0GVLdwTKojga49goErV7EvUaG8cPg8NjTUzdsUGd3MQ=;
 b=GeWrUrFO5ErKJxqMtPJej9K1rSnlCRPuwFUrrGM4XzBI5HHDrkqBC0AD/B5sGA4LtGJf0K
 PkntgADO3iJ6k3QCArODoPCg2uLUtPHX/48NY0zD0yFxW+FyGRK4V8VvtkJYNkH46MLib/
 AXTRilB2YIK8nP8YrtNR0TlV1/PBCqE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-jmcVBZMXM4S74h31T6UxTw-1; Fri, 06 Dec 2019 06:30:52 -0500
Received: by mail-wr1-f69.google.com with SMTP id t3so2980437wrm.23
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 03:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0GVLdwTKojga49goErV7EvUaG8cPg8NjTUzdsUGd3MQ=;
 b=JZ5bLNIoviT1JQTqy04tytRocB2gBFULDx0bfYrRVGLzAIKxanj6XESfd8FO/LVEeV
 ADRLs8pAQXMsW8Jd8Y2Tm8VphFEa/5PixSzquxk8GrXLyz7M8dy8OnSbaM3awvMG3BAh
 E6POtHE+zT1Um0MVbGcPQJrPzaTvSnIVl2NlUTAmRx2xpBf7r1Gu2AhkOJL9YTNM33Hn
 5IllO3DYWfOALnnZSfNmIFHrOBRhZbjbutKT7q+XJc+tzdi/PlmwA6shfZzHRYgcfg//
 AnpD6VQc8JCSim+u672pR4/iQg5xNIscdtA2Oid3uDcvA04aQGBoAc1VOIMeFy5ik6zT
 PODw==
X-Gm-Message-State: APjAAAXkrSWUan1D56anLRPikUJvNSuBjDM3gxuaoezX8PzwU3vrO83F
 R4T6I8RR0SU974N8UIvNLJH5WdDInmTVZsnjiqSa/CFv+Qd+Q0OV4ABuCMsX5FPgzd173NQfIAK
 9t5IvQxf1A220Z+Y=
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr10525962wmj.47.1575631851394; 
 Fri, 06 Dec 2019 03:30:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqynRGIHlMgA8YY5/klhSTkuhxKg/Eci9pUTuMB5YYon8XwwZJQKRj44uOXurmEUTMQwmChIZw==
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr10525941wmj.47.1575631851095; 
 Fri, 06 Dec 2019 03:30:51 -0800 (PST)
Received: from [10.201.49.168] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id z8sm15809068wrq.22.2019.12.06.03.30.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 03:30:50 -0800 (PST)
Subject: Re: [PATCH] target/i386: skip kvm_msr_entry_add when kvm_vmx_basic is
 0
To: Catherine Ho <catherine.hecx@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
References: <3a1c97b2-789f-dd21-59ba-f780cf3bad92@redhat.com>
 <1575627817-24625-1-git-send-email-catherine.hecx@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9c86f277-f13c-b33d-41e5-0ed32aaf75d7@redhat.com>
Date: Fri, 6 Dec 2019 12:30:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1575627817-24625-1-git-send-email-catherine.hecx@gmail.com>
Content-Language: en-US
X-MC-Unique: jmcVBZMXM4S74h31T6UxTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: "Zhong, Yang" <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/12/19 11:23, Catherine Ho wrote:
> Commit 1389309c811b ("KVM: nVMX: expose VMX capabilities for nested
> hypervisors to userspace") expands the msr_based_features with
> MSR_IA32_VMX_BASIC and others. Then together with an old kernel before
> 1389309c811b, the qemu call KVM_GET_MSR_FEATURE_INDEX_LIST and got the
> smaller kvm_feature_msrs. Then in kvm_arch_get_supported_msr_feature(),
> searching VMX_BASIC will be failed and return 0. At last kvm_vmx_basic
> will be assigned to 0.
> 
> Without this patch, it will cause a qemu crash (host kernel 4.15
> ubuntu 18.04+qemu 4.1):
> qemu-system-x86_64: error: failed to set MSR 0x480 to 0x0
> target/i386/kvm.c:2932: kvm_put_msrs: Assertion `ret ==
> cpu->kvm_msr_buf->nmsrs' failed.
> 
> This fixes it by skipping kvm_msr_entry_add when kvm_vmx_basic is 0
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
> ---
>  target/i386/kvm.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index a8c44bf..8cf84a2 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -2632,8 +2632,13 @@ static void kvm_msr_entry_add_vmx(X86CPU *cpu, FeatureWordArray f)
>                                           f[FEAT_VMX_SECONDARY_CTLS]));
>      kvm_msr_entry_add(cpu, MSR_IA32_VMX_EPT_VPID_CAP,
>                        f[FEAT_VMX_EPT_VPID_CAPS] | fixed_vmx_ept_vpid);
> -    kvm_msr_entry_add(cpu, MSR_IA32_VMX_BASIC,
> +
> +    if (kvm_vmx_basic) {
> +	/* Only add the entry when host supports it */
> +        kvm_msr_entry_add(cpu, MSR_IA32_VMX_BASIC,
>                        f[FEAT_VMX_BASIC] | fixed_vmx_basic);
> +    }
> +
>      kvm_msr_entry_add(cpu, MSR_IA32_VMX_MISC,
>                        f[FEAT_VMX_MISC] | fixed_vmx_misc);
>      if (has_msr_vmx_vmfunc) {
> 

Yang Zhong from Intel also sent a similar patch.  Thanks very much to
both of you.

Paolo


