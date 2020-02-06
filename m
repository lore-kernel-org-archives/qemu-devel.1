Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3DCC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 23:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4899920838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 23:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYGFCmYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4899920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izqWD-0002Ox-HL
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 18:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1izqVS-0001Nw-Rd
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 18:24:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1izqVQ-0000YB-4n
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 18:24:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34029
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1izqVP-0000W4-Uq
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 18:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581031458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1lWg6VGhnWcqSb5srSPqG2P0Jdyb+pQc1B1LDg45H/0=;
 b=FYGFCmYJN0FnSNd7xgAdfbDwiNo5YPtah+xbQTz9Ua9Ts3B8lpRV0lo+iWH1Vg5aw9GY7v
 iMMpncC4eMj6/re3MljNV6ne6n7xEqC5hHK+gi9bH5CK20twhLsU6YQs4gJ6+gbZxLuUP7
 NhxSPWkMXkANOvmON3t3Zq5LLCpKEe0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-zt33elHYPJia3-F1_IiAmA-1; Thu, 06 Feb 2020 18:24:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25CDE107B113
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 23:24:16 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D516D790F7;
 Thu,  6 Feb 2020 23:24:13 +0000 (UTC)
Date: Thu, 6 Feb 2020 16:24:12 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 20/59] target/i386: kvm: initialize microcode revision
 from KVM
Message-ID: <20200206162412.11d5b9c6@w520.home>
In-Reply-To: <1579787449-27599-21-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
 <1579787449-27599-21-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: zt33elHYPJia3-F1_IiAmA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 14:50:10 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> KVM can return the host microcode revision as a feature MSR.
> Use it as the default value for -cpu host.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <1579544504-3616-4-git-send-email-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c | 4 ++++
>  target/i386/kvm.c | 5 +++++
>  2 files changed, 9 insertions(+)

Hey Paolo,

My Windows 10 VM boot loops with this :-\  It seems to be related to
the CPU model.  Now fails (host-passthrough):

-cpu host,hv-time,hv-relaxed,hv-vapic,hv-spinlocks=0x1fff,hv-vendor-id=KeenlyKVM,kvm=off

Works (host-model):

-cpu IvyBridge-IBRS,ss=on,vmx=on,pcid=on,hypervisor=on,arat=on,tsc-adjust=on,umip=on,md-clear=on,stibp=on,arch-capabilities=on,ssbd=on,xsaveopt=on,skip-l1dfl-vmentry=on,hv-time,hv-relaxed,hv-vapic,hv-spinlocks=0x1fff,hv-vendor-id=KeenlyKVM,kvm=off

Thanks,
Alex

> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 790254e..ffe5de0 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6416,6 +6416,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>                         &cpu->mwait.ecx, &cpu->mwait.edx);
>              env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
>          }
> +        if (kvm_enabled() && cpu->ucode_rev == 0) {
> +            cpu->ucode_rev = kvm_arch_get_supported_msr_feature(kvm_state,
> +                                                                MSR_IA32_UCODE_REV);
> +        }
>      }
>  
>      if (cpu->ucode_rev == 0) {
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index f6dd6b7..1b67090 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -2696,6 +2696,11 @@ static void kvm_init_msrs(X86CPU *cpu)
>                            env->features[FEAT_CORE_CAPABILITY]);
>      }
>  
> +    if (kvm_arch_get_supported_msr_feature(kvm_state,
> +                                           MSR_IA32_UCODE_REV)) {
> +        kvm_msr_entry_add(cpu, MSR_IA32_UCODE_REV, cpu->ucode_rev);
> +    }
> +
>      /*
>       * Older kernels do not include VMX MSRs in KVM_GET_MSR_INDEX_LIST, but
>       * all kernels with MSR features should have them.


